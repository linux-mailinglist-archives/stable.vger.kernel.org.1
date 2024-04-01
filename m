Return-Path: <stable+bounces-35107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13E894271
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A599928360D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1650267;
	Mon,  1 Apr 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKCn6bpU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5884D5A0;
	Mon,  1 Apr 2024 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990356; cv=none; b=RPhaSyftHdnvBsy4xZKDGg7kD01GyqFAKQNul+FbnEgTPm3GVB5bd8uQE6eVQTAPV7VtaU1vlk1MPstUEDTCs7+UuATZ50lFl6tdkGh+idj+SVoGDQFk7BKW/ze74j6zZdrHn9UM+2/UyOj5k1hKVe5//IogqFGQUcdactD0U1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990356; c=relaxed/simple;
	bh=L3QXZ4ONzMJCMJegrEtPaIi+2gqrWhNVVIePsrxnlbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtVRi+uledJGV8X7aWv+SKtHGe+A7KuzQQqnFQysBX/LURHEgdvVACnDFecuMDVvzwNByF/DaumpNCKdW0lcnA0je0Dr5tycrmxwDPLEIN52jFTPCadr0sdokZjZE4MvCSoozM2HCisjdltjK98hx1HFk6/Mhwqeaqz0DIWlTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKCn6bpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBEDC433F1;
	Mon,  1 Apr 2024 16:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990356;
	bh=L3QXZ4ONzMJCMJegrEtPaIi+2gqrWhNVVIePsrxnlbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKCn6bpU78szovGLh/VeOJGWtssdJMtRIlgcHynXXqzSBtQeyugqVSl6oJtdhyKwP
	 CTR3C7Fshu8gzZ9Ot3dUNbHhL+4ej1dYpOoGDuTaBNdznWDBy5Rs1taiyO3RgT5PL1
	 qwE3lRehfgUs+z8nULInd5H1Zzmi9cbJkztsZYuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Filippov <jcmvbkbc@gmail.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.6 326/396] exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()
Date: Mon,  1 Apr 2024 17:46:15 +0200
Message-ID: <20240401152557.631554734@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 2aea94ac14d1e0a8ae9e34febebe208213ba72f7 upstream.

In NOMMU kernel the value of linux_binprm::p is the offset inside the
temporary program arguments array maintained in separate pages in the
linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
thus must be adjusted when that array is copied to the user stack.
Without that adjustment the value passed by the NOMMU kernel to the ELF
program in the AT_EXECFN entry of the aux array doesn't make any sense
and it may break programs that try to access memory pointed to by that
entry.

Adjust linux_binprm::exec before the successful return from the
transfer_args_to_stack().

Cc: <stable@vger.kernel.org>
Fixes: b6a2fea39318 ("mm: variable length argument support")
Fixes: 5edc2a5123a7 ("binfmt_elf_fdpic: wire up AT_EXECFD, AT_EXECFN, AT_SECURE")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Link: https://lore.kernel.org/r/20240320182607.1472887-1-jcmvbkbc@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/exec.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -894,6 +894,7 @@ int transfer_args_to_stack(struct linux_
 			goto out;
 	}
 
+	bprm->exec += *sp_location - MAX_ARG_PAGES * PAGE_SIZE;
 	*sp_location = sp;
 
 out:




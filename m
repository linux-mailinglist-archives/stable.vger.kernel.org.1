Return-Path: <stable+bounces-8011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19C81A40A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AEA1F2634F
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3F447A76;
	Wed, 20 Dec 2023 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kCs54Kqs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666C4779A;
	Wed, 20 Dec 2023 16:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495CEC433C8;
	Wed, 20 Dec 2023 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088664;
	bh=dUWLm2VzJRP5PcvhVwF9kyhYuekxNRUOgH9upZ30OIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCs54KqsUwQjGmnUVirRGyCtANe/Vl6eBbcDcJjNkm8UU0VqBErrg8GOJaANt8Ncm
	 Hjx5TIVvwn8NQrOWYVQklYpPPIvG9thGUedZM8X0qj7qh7L94BzQ/fpWuH6sWiCkdm
	 +5m4HIsQ5uRoIBTp9NkH/sUHmQZt1RljAhRkH2vs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 014/159] ksmbd: Delete an invalid argument description in smb2_populate_readdir_entry()
Date: Wed, 20 Dec 2023 17:07:59 +0100
Message-ID: <20231220160931.944071088@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit f5c381392948dcae19f854b9586b806654f08a11 ]

A warning is reported because an invalid argument description, it is found
by running scripts/kernel-doc, which is caused by using 'make W=1'.
fs/ksmbd/smb2pdu.c:3406: warning: Excess function parameter 'user_ns'
description in 'smb2_populate_readdir_entry'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 475d6f98804c ("ksmbd: fix translation in smb2_populate_readdir_entry()")
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3466,7 +3466,6 @@ static int dentry_name(struct ksmbd_dir_
  * @conn:	connection instance
  * @info_level:	smb information level
  * @d_info:	structure included variables for query dir
- * @user_ns:	user namespace
  * @ksmbd_kstat:	ksmbd wrapper of dirent stat information
  *
  * if directory has many entries, find first can't read it fully.




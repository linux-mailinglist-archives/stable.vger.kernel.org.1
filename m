Return-Path: <stable+bounces-24132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5FA869342
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB505B2F545
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2C13B2B9;
	Tue, 27 Feb 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijkFR2Ik"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713B78B61;
	Tue, 27 Feb 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041121; cv=none; b=FlWHvEOcLJAxBdIeeKdfnngEcVBIOtJHl+M7pyKmb5fWY17RLv+xOc5hdl3Mhg1ejvZAkbc+UIXcoyyHCOfM8Usw/OHCdJuD7+HxU/ruxPNLxRfLcqaNIVnLLmZByctVcA32mVARCcfliWsd7jwGJNeor50kKLsotPFn0FqlG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041121; c=relaxed/simple;
	bh=Hi5Lmj+fjxCSvD3CicNCz5U97XBS2fCDQ1nObBYboJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9rwcV0mb0xjXknaxCEkvLrFKAKe3+BvqzUWphlGPU2Lc8qzgZSl8UsIAoZZDu1jABlCI6d2t31Kk2RcrPF3o2F3AVUZe3HAYz661Uttfy/llsjhTLVsSv5/jCZUKLYRyULCwKXbvXZExfYyl8CYRUtPTFZm0ZsNhWrCroGh5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijkFR2Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F76C433C7;
	Tue, 27 Feb 2024 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041121;
	bh=Hi5Lmj+fjxCSvD3CicNCz5U97XBS2fCDQ1nObBYboJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijkFR2IksY5aJYlepk4AjFqd7PBAgAvSHnvqoILT8Bxp63Dw7vr3oFFLaKZolbitq
	 YbV/Va17zvOTWUez7itmfQIGyIimAtl8QbRkKJNBG+074fArZxy9hJWkEsxsI9OsqK
	 kpdHNxvzobDeSv7qegZB9KtQ36b6rbD9Rg2OXDJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.7 228/334] smb3: add missing null server pointer check
Date: Tue, 27 Feb 2024 14:21:26 +0100
Message-ID: <20240227131638.156149724@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 45be0882c5f91e1b92e645001dd1a53b3bd58c97 upstream.

Address static checker warning in cifs_ses_get_chan_index():
    warn: variable dereferenced before check 'server'
To be consistent, and reduce risk, we should add another check
for null server pointer.

Fixes: 88675b22d34e ("cifs: do not search for channel if server is terminating")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/sess.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -76,7 +76,7 @@ cifs_ses_get_chan_index(struct cifs_ses
 	unsigned int i;
 
 	/* if the channel is waiting for termination */
-	if (server->terminate)
+	if (server && server->terminate)
 		return CIFS_INVAL_CHAN_INDEX;
 
 	for (i = 0; i < ses->chan_count; i++) {




Return-Path: <stable+bounces-8116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DC81A497
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DAB1F22DE0
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7E47A4F;
	Wed, 20 Dec 2023 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XE2bUEOP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BDB4779E;
	Wed, 20 Dec 2023 16:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8BBC433C9;
	Wed, 20 Dec 2023 16:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088952;
	bh=p/Xrf9QQG34F3zecfyq7+ecEkCKWyCVOERZAIFLDGmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XE2bUEOPccfZcOJT86zKf9Sh8SdmbeVdBFUBZ8wxVUcroBhkpFX5cBN2SMlsO6Rx8
	 GFHfqvqAlU6+PVP/Zmzmydt0oFHFq4gf/DWfxAtyY+wAwmOFrrPWjyc6BwVn5yXw+F
	 nXTG4DHXU1r+mwHcNJBLvAhwNuaHo63bZEZjnNJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 118/159] ksmbd: switch to use kmemdup_nul() helper
Date: Wed, 20 Dec 2023 17:09:43 +0100
Message-ID: <20231220160936.841744606@linuxfoundation.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 084ba46fc41c21ba827fd92e61f78def7a6e52ea ]

Use kmemdup_nul() helper instead of open-coding to
simplify the code.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/asn1.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/ksmbd/asn1.c
+++ b/fs/ksmbd/asn1.c
@@ -214,12 +214,10 @@ static int ksmbd_neg_token_alloc(void *c
 {
 	struct ksmbd_conn *conn = context;
 
-	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
+	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
-	memcpy(conn->mechToken, value, vlen);
-	conn->mechToken[vlen] = '\0';
 	return 0;
 }
 




Return-Path: <stable+bounces-8154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645181A4C4
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ED81C25A9E
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938874A9B8;
	Wed, 20 Dec 2023 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bhAQ+l5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D489482F2;
	Wed, 20 Dec 2023 16:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E5C433C7;
	Wed, 20 Dec 2023 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703089064;
	bh=HhQ+V4hn1H6iGUIZagAoD+BSWKwyHZXbP0j8V1qEaSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhAQ+l5Q72D7g6KEYvUaZ9+J9mc6GHoBpUhnQ47oxbixl7CfSVXA2wXlKhFZg3XC2
	 UM4bHVVEYHyQmiUtDC6+Y/T3PyCNZYv3vnhoupH+6JeDBiXnOMX8FvukSqbA89QWPf
	 9hzhfkiko6p25CNVlu9PMARp0sQwMCz7o4l2Y6c8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 128/159] ksmbd: fix passing freed memory aux_payload_buf
Date: Wed, 20 Dec 2023 17:09:53 +0100
Message-ID: <20231220160937.298707776@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 59d8d24f4610333560cf2e8fe3f44cafe30322eb ]

The patch e2b76ab8b5c9: "ksmbd: add support for read compound" leads
to the following Smatch static checker warning:

  fs/smb/server/smb2pdu.c:6329 smb2_read()
        warn: passing freed memory 'aux_payload_buf'

It doesn't matter that we're passing a freed variable because nbytes is
zero. This patch set "aux_payload_buf = NULL" to make smatch silence.

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6314,7 +6314,7 @@ int smb2_read(struct ksmbd_work *work)
 						      aux_payload_buf,
 						      nbytes);
 		kvfree(aux_payload_buf);
-
+		aux_payload_buf = NULL;
 		nbytes = 0;
 		if (remain_bytes < 0) {
 			err = (int)remain_bytes;




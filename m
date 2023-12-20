Return-Path: <stable+bounces-8129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC281A4AA
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CA41F22245
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D9495C8;
	Wed, 20 Dec 2023 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="txNyu1pZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20048CD8;
	Wed, 20 Dec 2023 16:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA49C433C7;
	Wed, 20 Dec 2023 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088993;
	bh=WW4ERD4nF59xrl1kF0xi8dKv2i7UPCp0ZoV5hRM3aoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txNyu1pZWxq+YW8RI5HGihMBC2apMxQyhqTbD667d/AIYrHNNcNYor4y1YD789w+L
	 dDUL9okbYd5TMXQ9e7QNMjRVfOaET+NFq/zNkLB6yq7tiFCZrmHZt3fD7n7Tfu+6Tb
	 LRzRB/2XRRC4cdzXExwYzJ7Timkz9EhGPVWXsgUY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 124/159] ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
Date: Wed, 20 Dec 2023 17:09:49 +0100
Message-ID: <20231220160937.108774701@linuxfoundation.org>
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

[ Upstream commit 4b081ce0d830b684fdf967abc3696d1261387254 ]

If authblob->SessionKey.Length is bigger than session key
size(CIFS_KEY_SIZE), slub overflow can happen in key exchange codes.
cifs_arc4_crypt copy to session key array from SessionKey from client.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21940
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/auth.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -355,6 +355,9 @@ int ksmbd_decode_ntlmssp_auth_blob(struc
 		if (blob_len < (u64)sess_key_off + sess_key_len)
 			return -EINVAL;
 
+		if (sess_key_len > CIFS_KEY_SIZE)
+			return -EINVAL;
+
 		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
 		if (!ctx_arc4)
 			return -ENOMEM;




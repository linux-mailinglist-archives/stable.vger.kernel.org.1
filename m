Return-Path: <stable+bounces-24096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B68693D3
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17560B2E83D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF013DB87;
	Tue, 27 Feb 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nl/CDWp+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399D13B7AE;
	Tue, 27 Feb 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041022; cv=none; b=WaOCxaXczr4qLoiMyI7Tu19MhmLRIzpEPCRea/nJHvc1DuCv/qNEHP22x4TW9ORZJ0OET5WTusdIbW+l+kIv45DmROiWlyaiunniKedObXBbK37Tls6bCOIH0HKbu6J9p3pjFrfcRdcWAhQYaYVAsFnUMwRn/tjNZbUd0FLdyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041022; c=relaxed/simple;
	bh=vMeVdWaQCjGVbxOOSwp61kdBhIaS2SBvpgd2D+zzXw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVOhVqZrrtbezk/6ALwzTF+8eA786WqOhJ7WhJKa3jLdDg3G3WvnzYdKyjh13/ZMaqjcRNaIftp0UmM26v4mKxf5b8YqvR213Aan7HcpSE1z1X07nqYaVjpLIGCI6P1DC7gvFxfTUgqbRpCHJiecoQEHqUaIAnbxLWh9gxMcm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nl/CDWp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C453C433C7;
	Tue, 27 Feb 2024 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041021;
	bh=vMeVdWaQCjGVbxOOSwp61kdBhIaS2SBvpgd2D+zzXw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nl/CDWp+h6vCm6EI3Yl4/fu9BS2bsUGDvRB5WWRwR0Ch/0bRYCEB6QZow3e+qtfSH
	 QQ7FvzTCoEHNUpw0CkoSHheY8ub+lVRSzpxSusnGAOUrY59iByByhv7jKGlffyGqCD
	 J24VrAaurn1pnAjKaW2vNhY6UZMbTgyfMqdnpP+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	zhenwei pi <pizhenwei@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.7 192/334] crypto: virtio/akcipher - Fix stack overflow on memcpy
Date: Tue, 27 Feb 2024 14:20:50 +0100
Message-ID: <20240227131636.882712377@linuxfoundation.org>
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

From: zhenwei pi <pizhenwei@bytedance.com>

commit c0ec2a712daf133d9996a8a1b7ee2d4996080363 upstream.

sizeof(struct virtio_crypto_akcipher_session_para) is less than
sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
stack variable leads stack overflow. Clang reports this issue by
commands:
make -j CC=clang-14 mrproper >/dev/null 2>&1
make -j O=/tmp/crypto-build CC=clang-14 allmodconfig >/dev/null 2>&1
make -j O=/tmp/crypto-build W=1 CC=clang-14 drivers/crypto/virtio/
  virtio_crypto_akcipher_algs.o

Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net/
Cc: <stable@vger.kernel.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -104,7 +104,8 @@ static void virtio_crypto_dataq_akcipher
 }
 
 static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
-		struct virtio_crypto_ctrl_header *header, void *para,
+		struct virtio_crypto_ctrl_header *header,
+		struct virtio_crypto_akcipher_session_para *para,
 		const uint8_t *key, unsigned int keylen)
 {
 	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
@@ -128,7 +129,7 @@ static int virtio_crypto_alg_akcipher_in
 
 	ctrl = &vc_ctrl_req->ctrl;
 	memcpy(&ctrl->header, header, sizeof(ctrl->header));
-	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	memcpy(&ctrl->u.akcipher_create_session.para, para, sizeof(*para));
 	input = &vc_ctrl_req->input;
 	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 




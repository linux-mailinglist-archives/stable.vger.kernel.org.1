Return-Path: <stable+bounces-23665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA788672DF
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D970B32433
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC041CD35;
	Mon, 26 Feb 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TixC+7qG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02FAEEDA
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943672; cv=none; b=db3iKXBp/CqdOkbJOHXp8MnNnqd0c5gt9N9ViADit6Rb0ydYNwtuqZnCmH2y6fC6RZ1v4CFTC0YzGb2Uzf2nnSVPLax6o8QZ6J/VxGhWQ7yVIUD4yXJZxmPbs5TaUvp1/DJQ4IpOvJptJFCHUF+qn6xBNNeQPQewMtSn0ZsK4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943672; c=relaxed/simple;
	bh=TK0tpIOiG3gbFqifYFwVLlyY0X4BYAmaJmBBlmIIR1k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DrQ9pDWkLM2JOmrDOUNv92GjkedbaCtd2lfcMiE3+1CTXkPQQ2wN0RnvlomIOo7kouQCIIdOdOSpjbcGtwTlEZsYoBsFO3LfGr7RyJIvTB4qVcHT3mk0c7tzIM/V/lNiUF07WlaKJPZjAfC1CFLVEGS0bnc6RctgIbxu2KzPb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TixC+7qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16803C433F1;
	Mon, 26 Feb 2024 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943672;
	bh=TK0tpIOiG3gbFqifYFwVLlyY0X4BYAmaJmBBlmIIR1k=;
	h=Subject:To:Cc:From:Date:From;
	b=TixC+7qGIYhpG5hyNZuLEZAtkwwgTApGrOxI+Rf0yw6hiN7+rIeNKkz/1Y14J49Ul
	 hL0u9h9wfRuIVT/AVxtQRmKLomttS576gKkftPaL1vaFD2Ic4twowju//1CxsgvOOM
	 Cq1t8PAaJrbh22sAzCEVx7wOJ7TBZnelx61NJ7CY=
Subject: FAILED: patch "[PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy" failed to apply to 5.15-stable tree
To: pizhenwei@bytedance.com,herbert@gondor.apana.org.au,jasowang@redhat.com,mst@redhat.com,nathan@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:34:29 +0100
Message-ID: <2024022629-defog-preoccupy-2fb8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c0ec2a712daf133d9996a8a1b7ee2d4996080363
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022629-defog-preoccupy-2fb8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c0ec2a712daf ("crypto: virtio/akcipher - Fix stack overflow on memcpy")
0756ad15b1fe ("virtio-crypto: use private buffer for control request")
6fd763d15586 ("virtio-crypto: change code style")
59ca6c93387d ("virtio-crypto: implement RSA algorithm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0ec2a712daf133d9996a8a1b7ee2d4996080363 Mon Sep 17 00:00:00 2001
From: zhenwei pi <pizhenwei@bytedance.com>
Date: Tue, 30 Jan 2024 19:27:40 +0800
Subject: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy

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

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..de53eddf6796 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -104,7 +104,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 }
 
 static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
-		struct virtio_crypto_ctrl_header *header, void *para,
+		struct virtio_crypto_ctrl_header *header,
+		struct virtio_crypto_akcipher_session_para *para,
 		const uint8_t *key, unsigned int keylen)
 {
 	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
@@ -128,7 +129,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 
 	ctrl = &vc_ctrl_req->ctrl;
 	memcpy(&ctrl->header, header, sizeof(ctrl->header));
-	memcpy(&ctrl->u, para, sizeof(ctrl->u));
+	memcpy(&ctrl->u.akcipher_create_session.para, para, sizeof(*para));
 	input = &vc_ctrl_req->input;
 	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
 



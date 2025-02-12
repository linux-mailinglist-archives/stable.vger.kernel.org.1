Return-Path: <stable+bounces-114989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840AEA31C60
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 03:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010F21888D4E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D891D63C4;
	Wed, 12 Feb 2025 02:54:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAA1CAA7F;
	Wed, 12 Feb 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328874; cv=none; b=gXdZOR+dCZYhdTIZO8hX2arAFkJXhrWi43Z4nYmLx8LOumsALB03ODFArvTSgoKpfS+ztIZIkayP1NjITsfqx2F2v0I/kuJhxuzDegSu/b1RSaTBsKxVmenXX47xLR7xy7rTvkLKC+1R27esQwDNhnANUT9hmFQiiTa4aWGuKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328874; c=relaxed/simple;
	bh=5e4nqBQj9+FTs/Lw1huds1GxtSzJtquW0xbwEbljHYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvonzPXasodvIwzjTS1HOE6OYawTzQiOwLXBmHLv9mO+RI1k1jomDju72dQRYByLcFgIQgJVB7oLzcoclsfUQ+x0ehaRu+WlgBPR5Mh12ZDT8brxdHod0enZrImRkjU3OFIj0xDcyVH1kj9YX6Gx+LKLazHh0dDMFJ0nHr3q5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAnVPtaDaxnZnmTDA--.32612S2;
	Wed, 12 Feb 2025 10:54:20 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] tls: Check return value of get_cipher_desc in fill_sg_out
Date: Wed, 12 Feb 2025 10:53:50 +0800
Message-ID: <20250212025351.380-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnVPtaDaxnZnmTDA--.32612S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4fCr18tF1UXry7Cr47CFg_yoW8Jw1Upr
	yq9FZ7K345WF15t3WUAF1kWa47Can0yay3Wr48ZryjkrsxtrWDJFy8JrWYyF45X39xAFyv
	yryqgw1fZ3WDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRELA2esAO8qlgAAsI

The function get_cipher_desc() may return NULL if the cipher type is
invalid or unsupported. In fill_sg_out(), the return value is used
without any checks, which could lead to a NULL pointer dereference.

This patch adds a DEBUG_NET_WARN_ON_ONCE check to ensure that
cipher_desc is valid and offloadable before proceeding. This prevents
potential crashes and provides a clear warning in debug builds.

Fixes: 8db44ab26beb ("tls: rename tls_cipher_size_desc to tls_cipher_desc")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/tls/tls_device_fallback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index f9e3d3d90dcf..0f93a0833ec2 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -306,6 +306,7 @@ static void fill_sg_out(struct scatterlist sg_out[3], void *buf,
 {
 	const struct tls_cipher_desc *cipher_desc =
 		get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
 	sg_set_buf(&sg_out[0], dummy_buf, sync_size);
 	sg_set_buf(&sg_out[1], nskb->data + tcp_payload_offset, payload_len);
-- 
2.42.0.windows.2



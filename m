Return-Path: <stable+bounces-222127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGr0ALWdo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9E1CC901
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F8C330EF314
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484CE30E83A;
	Sun,  1 Mar 2026 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXHRrCmm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC73302165;
	Sun,  1 Mar 2026 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329968; cv=none; b=LAf3sAy6Vbl9WB4iWaoGYQytsjJtuHcNqmG5OPeZhqLxk6EdA1yjlyG35YZhHOZR1tgrEJmS9UvVzyLDXh6ENUF+qno1f5FjRFKTQB087c6ungrJlQCQg2KRtdOS0fPAU1TbfjpaUYOCVTpDl4RPq2sWJcY2WMdamVYLSvT/3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329968; c=relaxed/simple;
	bh=CExcrflG4IPXSPYOEFqwbJ8inTL/ydm6MkTRoSWNyzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lG86gfqJVLLuRopjNK2ItKDv/PE0lTO0d0AwfStE7335ZU0iZcOX1HNqovAJC8ndXd0Uq0EZUQkkVt4TUjU4GTkuzGA9FPZphS6YNFxyIA8xVHqMsv75POUtxBqLRfZY9b6y00Z5N5/IFwch6C7JCZTy6MiTn9uyseGOXHo6TBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXHRrCmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F252C19421;
	Sun,  1 Mar 2026 01:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329967;
	bh=CExcrflG4IPXSPYOEFqwbJ8inTL/ydm6MkTRoSWNyzI=;
	h=From:To:Cc:Subject:Date:From;
	b=qXHRrCmmXAwJbhk5VtxoTap0s/ox3djXS5ijDe0Tis/jm19gEg0rfwCThP/DFO4JS
	 QefK5ybiu8sYfn7l2Ayo+EjuoMYkcg7jk0x+f++qyg0/l/T/xxM6yYg+2Jr5Mm2BMq
	 GDqd/PiNzd7iV+njGd6PdJt5Xz99Jf0H1WFaT4Yt3VGSgM5EJ1wXZBfRpQikz4RIyw
	 l5WxxtSnvjbEnsKjYV1unGIGCwsSYmLDJQ7qAJad9YZ6JOPTV9R+wiwPZwV7UXLG1P
	 EmawZSWWi6z4EBzFpL8gqYTvVKGY8TegHlf7UHCtPJI/c0lnN6dJ8LsAHfJW4LFm64
	 0bffotWGem3aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	maobibo@loongson.cn
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	linux-crypto@vger.kernel.org
Subject: FAILED: Patch "crypto: virtio: Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:45 -0500
Message-ID: <20260301015246.1719369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222127-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email]
X-Rspamd-Queue-Id: 79A9E1CC901
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a389d431053935366b88a8fbf271f1a564b9a44e Mon Sep 17 00:00:00 2001
From: Bibo Mao <maobibo@loongson.cn>
Date: Tue, 13 Jan 2026 11:05:55 +0800
Subject: [PATCH] crypto: virtio: Remove duplicated virtqueue_kick in
 virtio_crypto_skcipher_crypt_req

With function virtio_crypto_skcipher_crypt_req(), there is already
virtqueue_kick() call with spinlock held in function
__virtio_crypto_skcipher_do_req(). Remove duplicated virtqueue_kick()
function call here.

Fixes: d79b5d0bbf2e ("crypto: virtio - support crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260113030556.3522533-3-maobibo@loongson.cn>
---
 drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 1b3fb21a2a7de..11053d1786d4d 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -541,8 +541,6 @@ int virtio_crypto_skcipher_crypt_req(
 	if (ret < 0)
 		return ret;
 
-	virtqueue_kick(data_vq->vq);
-
 	return 0;
 }
 
-- 
2.51.0






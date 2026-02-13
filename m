Return-Path: <stable+bounces-216238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHkvH4Y2j2n2MgEAu9opvQ
	(envelope-from <stable+bounces-216238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:34:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62AE1371A9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9CE9303AF10
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56E360734;
	Fri, 13 Feb 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz6ytNQZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9B2F362B
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993237; cv=none; b=tS6OuXwVMl5yApsp1lATI/+9VI5OMSwOVw4BJ6sfQMlhrN8EOJ2QHyt2ptHy7I5bcI9xC7psYwJ/fT/bPeC0yfqc13Ghc/k+dP18WEy5VZvKVJPLP+a62BjORyThg7R0iG7/fsc7su5n5UCwA8rJt8mpqJUaZKqEM+YYMla9dCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993237; c=relaxed/simple;
	bh=ZsgBTSeaVZiLeC1yz8U/gSOQ+r5JWiM/F+4cIdNEvs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXFu4FUmhNrntgwWKyE4qSO7YltoNJtLYZ4ftkHKVMcuM1E4NEVehkSDvS6u0XISQBoyq5U4gbst46dqE3RgCAB8c0YI0ndGlMk0Wx4LhJBZ5qQB3VCBuY+WytfcvUvJWyN3dYYZDOq4R+4eafPsl8WjJM/6pLe5QGSjXLsPIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz6ytNQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BEAC116C6;
	Fri, 13 Feb 2026 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770993236;
	bh=ZsgBTSeaVZiLeC1yz8U/gSOQ+r5JWiM/F+4cIdNEvs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nz6ytNQZ2xnJIXrJ7eBQst/wbgFxyxOZQlJgEz3WMwDLGAHr7zhBIkKKYLOZ8/oxt
	 yxOAX9uXiJfmJeniU9YGazjsdDBHlmBAkr5oZ5oYwEWaUiqoiobch5ytxkRbI5RIPy
	 eet0Gqj8n2sDMXZGpbKRPFMMdW9FRydmO50mUwTCRSIdP2sTsWpAfjpO4r33GmAwzW
	 BHfP2Ux11Qt/v2KnTAj3XaJ6qQ56lyxHGSsQPC5DDfT5hh+MBqHOsx1ISSzmUvRaXW
	 O2NCqhQeOaySjzK+nqKhJAcYZyRKoCWeoLlzqhOZrIAUjdmW9Wze1bXRHF1D3RJNxm
	 Cne9Q40/8oJRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req
Date: Fri, 13 Feb 2026 09:33:54 -0500
Message-ID: <20260213143354.3510918-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021345-delivery-dealing-7b00@gregkh>
References: <2026021345-delivery-dealing-7b00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216238-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C62AE1371A9
X-Rspamd-Action: no action

From: Bibo Mao <maobibo@loongson.cn>

[ Upstream commit 14f86a1155cca1176abf55987b2fce7f7fcb2455 ]

With function virtio_crypto_skcipher_crypt_req(), there is already
virtqueue_kick() call with spinlock held in function
__virtio_crypto_skcipher_do_req(). Remove duplicated virtqueue_kick()
function call here.

Fixes: d79b5d0bbf2e ("crypto: virtio - support crypto engine framework")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/virtio/virtio_crypto_algs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_algs.c
index ae645c9d47a7a..bd6b1be464e2a 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -556,8 +556,6 @@ int virtio_crypto_skcipher_crypt_req(
 	if (ret < 0)
 		return ret;
 
-	virtqueue_kick(data_vq->vq);
-
 	return 0;
 }
 
-- 
2.51.0



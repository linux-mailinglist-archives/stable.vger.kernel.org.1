Return-Path: <stable+bounces-216235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O2mIZQxj2nQMAEAu9opvQ
	(envelope-from <stable+bounces-216235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:13:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D441D136FF4
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8617F302DB58
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629F43612C3;
	Fri, 13 Feb 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njcO3njU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538235FF43
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991851; cv=none; b=YogSTZmpf0gccZCHKNgbI4hxd0FQPEvwG1TKNe2CSTLh88pivFmwvQag2YKGHucamE7gT6kuFVIvc0XTzPvhJzjaWtnBW3ls28aqhqBfNhpWynqOj+YlFMjIe3K8GmOWFk/3/mxEkMkjTDjWGxcB0CRNwf2Bgv6OkgeqEm0MH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991851; c=relaxed/simple;
	bh=pXI4XFYoewQxrc97cee4N9G0F4iZ6S7/fExvT5kDYns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVM78idrnQF/RWXS+CR1NhcSsMb/jmMdRfKl6Bss2Fwtr743i7GiL+tA/sBzAoA+K/7DltdlhIYZPw7u42/k1IlvB0OMpdBnq1V5ui+l34dO4mkoU1+WD+8i3tlpFXNkYkOR2zO52JXObEkN/NOe/AYjIZAI73jVJ5zpkVay7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njcO3njU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C38C19423;
	Fri, 13 Feb 2026 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770991850;
	bh=pXI4XFYoewQxrc97cee4N9G0F4iZ6S7/fExvT5kDYns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njcO3njUC6AXF69z2lkPsKgzpKAObTJ8qmu5HidYztJeCP9wntkDmTcCaNkRmkNHM
	 thM4VYhNU/uJjxUGBKuJov3f1rfyxibn5TRSjRIqwVlwKPwwsDda5pbYCl1OX94S+z
	 /tSt4HgKPrMryQLP5qum2rpCRpLU1C+F7+svdAuBvzB49AfAw3O5F0XuYKhK6p4W5i
	 o1zE5Nmh9ZYOwzHHYmT/C52U8oxntUKXsbIu+twFo+75fBtseXxYq9xRHnBHYPlunO
	 Kbf5v/V79FEwzFQhdxao54bhMFdiAwF5+30s6eOXctdNNR/XxrPbrmbb3tS+DAJ0gz
	 R/kbFgmAOaf1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req
Date: Fri, 13 Feb 2026 09:10:48 -0500
Message-ID: <20260213141048.3504475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021345-deceit-circling-d688@gregkh>
References: <2026021345-deceit-circling-d688@gregkh>
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
	TAGGED_FROM(0.00)[bounces-216235-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,apana.org.au:email]
X-Rspamd-Queue-Id: D441D136FF4
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
index 8b577e4aa39fa..3106e40d482e5 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_algs.c
@@ -569,8 +569,6 @@ int virtio_crypto_skcipher_crypt_req(
 	if (ret < 0)
 		return ret;
 
-	virtqueue_kick(data_vq->vq);
-
 	return 0;
 }
 
-- 
2.51.0



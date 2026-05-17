Return-Path: <stable+bounces-249149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id avASGJYiCmpjxAQAu9opvQ
	(envelope-from <stable+bounces-249149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 22:18:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEAB563BB5
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 22:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48CEC3003359
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4E30BB8A;
	Sun, 17 May 2026 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha7sSuiP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4F8248896
	for <stable@vger.kernel.org>; Sun, 17 May 2026 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779049101; cv=none; b=uR5+nsGs4efwOdhQcZxpGgQClaZSIYiTT57F5NNPyGUsXYJ7ixPxX2cUdy7VSb/sKMlQpfQZZs0zqTsvFyskYmTDa5ccafKpBnbqmRQcNp4LNsUQ00XJqwsXQH9P6lnaMcCCsQj9oDWDZLF5ndsT+RdH9pKWcCoJAaPOYpeGrbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779049101; c=relaxed/simple;
	bh=D4eM9q/Mr+hTh8dz6TrmBMJJtqn2b3M7cZXupEYG+Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ3TemUju9zAYT02NRZYaOKYLCRqrQcaiL9+egpPrZjNB3B2t9t/xdL0iVLJkDW++e0GMp4SlOkKlna5ZRnUWdgjDc01hiko3p3lEVauDkvhPA2zEHO5/M/tZG3La3Es2CEejlzwFqY9yzaRN6tSSZfIAmblpFnQc5S/LqPLdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha7sSuiP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eb05b1875so686419f8f.3
        for <stable@vger.kernel.org>; Sun, 17 May 2026 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779049098; x=1779653898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RlEMj/0dstrsBJwk5bXCGDFYaiCKlnQRdIAzhzZX49w=;
        b=Ha7sSuiPF5afUoWs3t6/O0W5BncNhcMCbUe8ZBpXH2P18WGkS55xQWmarkoJrmpob9
         2/tPSah14A8tOtnQlmv5ALwHNzHrAD8FBzHPO+skbhAu0Jz4C4o+7H+vCAi3hm+dR5E/
         ogBwhnwdoip3EVn1Zos71qX5j/5UBozYn65iAweiOTlBhYO7YC/9Fd84pz6KWpATH1Za
         rLTITq7hOO1z1OukHqiKIEQWPdpJ9eZF8bg2H6q6mt3hD4KdG4+va2dSAjAoJ24jpjB4
         zK5L22vs1r8Pq9ndbRYz6Kprky25kB36lT7ELsrUqs/2qF5bhlhz3KowPF0yOQNA9aGQ
         s7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779049098; x=1779653898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlEMj/0dstrsBJwk5bXCGDFYaiCKlnQRdIAzhzZX49w=;
        b=iAseqT8bMlqI4elAyFAPA4H7NOqmgt7SxVBeR8uR7Sm6V6Y97c029qHvtnqshjNjWb
         p/tPCDD159J7N+WhrCkHMMOd+HbW410/p/wZNgg3QYrCNGD4vc4WJbSb++yBWSifJlEt
         4V8oX0TwXAh4e+vYFD8oX1BppQn+8+ShV+OCKhHENm2lVlt8hfc/PLcSQIiaIXhvxFyB
         9EkFolV4wPyzMzlgDep61Pi9GsAq+SR+AOFFvLxlbFpH7GWtkwD8fzqe5fkXYG3lgkmB
         CYK/usonE8CXIX4wJCQkyPUnE0g0ZpAeXbro7HUC5dKvCDFWfVIZLMuMqyKbZKozYlhZ
         5pMw==
X-Forwarded-Encrypted: i=1; AFNElJ/tU5l12OpFFL3LFbQoXROivOEREKk+TvZmHEbxzm/vJpbNg84buboUQTVeRTbWujVcl82QJjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxc2EbiGZYEumQYPrF9csOLXWZPH25JKkQWdLIDomi3CckqGpc
	L2zGVT605CB8HXKS/1qiG0HtQYB6uAekB1zDvvDavpJhd4aXeV69lsnA
X-Gm-Gg: Acq92OGwrLCD+yPqz15su+Vm1Z8I3dwHkAhOAtkNJRHWr2qMtvYyb5Ec6wGpihDkReK
	B0deuk5m1xc9VI0ZDxPrsh2xoBH34kzymEZdnqssFoSohHXrdWYpeVpEBSkUy+GvBH0YdoBZK1H
	k5YPHQ5WbGQuKWob/6OQ/YkgIeYYnuxTNnJ29AFPTP+4lbsNA5ZaJRtmmIBY2DE6uyQvDvXkDP7
	HHGotNr21Xc1i4U8GJa+hqSn2xryT3V7IJWzZRLBdF3TIo4hXt3573MnJjzwliWG8G3L0UwRVI/
	3q9nwo5CTu+DU6a/dpOnTf+2Pz6b75rkT4hgENQJidd1tzgOtsV7Kn6reMbRhDOqlMYyB6Zw8Uu
	Bozud+uGA4A14i4E51aS4GQBK5KlhUytbnhomkLlupp9ro+P6WAZqYaJewBENg3Wc0j+Jc2HUwU
	cNg5xrSzT54t59pTyaTXUITAIKZkJxdKHJ2HjeVrSSErCho3NWukWaarw3CvDSh05ZzZsS+12ID
	uLeJyrwoIY=
X-Received: by 2002:a5d:5d85:0:b0:43d:6e0:9458 with SMTP id ffacd0b85a97d-45e5c60d551mr17752171f8f.39.1779049098119;
        Sun, 17 May 2026 13:18:18 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm30371048f8f.20.2026.05.17.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 13:18:17 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: devmem: reject TX dma-buf with non-page-aligned size or SG length
Date: Sun, 17 May 2026 21:18:14 +0100
Message-ID: <20260517201814.222563-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECEAB563BB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-249149-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The TX dma-buf bind assumes dmabuf->size and every sg_dma_len() are
PAGE_SIZE multiples: tx_vec is sized dmabuf->size / PAGE_SIZE and
indexed by virt_addr / PAGE_SIZE, with only a virt_addr < dmabuf->size
bound check. A non-page-aligned size lets sendmsg() reach the tail
region past the last populated slot and read one past tx_vec[]. A
non-page-aligned, non-final SG entry causes the same OOB indirectly
by desyncing later slots.

Reject both up front. Real exporters (udmabuf, dma-buf heaps, GPU
drivers) already page-align, so this only refuses layouts the TX path
can't back correctly.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/core/devmem.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 468344739db2..e72f48ff9094 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -193,6 +193,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
 	unsigned long virtual;
+	bool todevice;
 	int err;
 
 	if (!dma_dev) {
@@ -240,7 +241,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		goto err_detach;
 	}
 
-	if (direction == DMA_TO_DEVICE) {
+	todevice = direction == DMA_TO_DEVICE;
+
+	if (todevice) {
+		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
+			goto err_unmap;
+		}
 		binding->tx_vec = kvmalloc_objs(struct net_iov *,
 						dmabuf->size / PAGE_SIZE);
 		if (!binding->tx_vec) {
@@ -267,6 +275,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		size_t len = sg_dma_len(sg);
 		struct net_iov *niov;
 
+		if (todevice && !IS_ALIGNED(len, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "TX dma-buf SG length must be PAGE_SIZE aligned");
+			goto err_free_chunks;
+		}
+
 		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
 				     dev_to_node(&dev->dev));
 		if (!owner) {
-- 
2.53.0



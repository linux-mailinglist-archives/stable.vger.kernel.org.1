Return-Path: <stable+bounces-235487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLN2JMvy12n6UwgAu9opvQ
	(envelope-from <stable+bounces-235487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:41:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 974933CEC88
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 831F9300F2A8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E53E3C4A;
	Thu,  9 Apr 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhrvNbrl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774EF36CDE2
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760037; cv=none; b=Ar/A3tvdWk9xRyzZqWfF14k8El9kyJhBk+QjCeL5b6xGRybzRkiO0Ix3UvkNty2UUht5tupjJqUhqIb21ZcQcGp4k36FqSz1JWjZn0YRiLsvyN6OCqpqeaqE94EF7WfAF8dA5tqb4Vkl3AmfbfWmqpRKhPzIPA0Tfb/tnKdYtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760037; c=relaxed/simple;
	bh=LVgn0vBdkVsmYtOJ2Mv8Tab1Z8bSNEKNjFGxlFR9yQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKnDFrVBtTqd0Z/pBdsFh+8D3yczhYP1NiitOds4dO/lcrE2QFzcGMgJkh0ltbqnyfPKdyi+WW7RpWCPDkDipPgeqSnhdi0sYVqovj3SHT8/iUTCQQtB8gCnw+0UNr6jflvazI6KHePoXoSgbPG81DyHqyu4Mzb7BFGPtiNb8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhrvNbrl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so811367f8f.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775760034; x=1776364834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbSeM7rVE+r24N6osWe4SerhDWF0/QD9ts6cYUU6inY=;
        b=WhrvNbrly25+Togsaly3e4BXhhMpkO1Yt3BoLHXbHTjLF1r7DBhemt9VulCZIJesqc
         QiMML/vmORrziXZQ+Wzyks3sa8icaSZdq7DKAQAveM3PcGPnfI4996aLTSKaSdFqU7+E
         xRfiKn9Rr2IWbtJl5OQwA93lgP1DpDPwWyI++znrU7mgUcVFgPIguRkAhLtYL00brI/A
         1IlYNXdCSyNSt0E58Q00PgAjiYtTl1HHub0RpdLJyOFMVklKZxHpybv1jGv5adBDDJAF
         ApOmi0XLioQxMbd8FMdD+9L91fx/7T8xjNtMPFuQrwi2w5kbV2VP/jqbLldFajdwSts9
         2srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760034; x=1776364834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbSeM7rVE+r24N6osWe4SerhDWF0/QD9ts6cYUU6inY=;
        b=DEPUc0bZucQqDuaG3xNvyZ+Ygaa8/9WCouU/SkJafvudpOgUsU4bi57ZIk1dEidlBR
         ykmxBAkuOssESPcKCOPNKbXzIi8khWPgWt0duGjSNJb1W1HTwnOqJcEUP1CeffhBdh+H
         A4ZI+0yJcrBr85bT74xyQNGnTRfEGOb6+1shbMNxETUpIMkFjZ0krCACI7ZQDQdfhe8V
         lLNd1fn/LevaXjNc+hmVuXJBIzyJZezPcovk2WPQkmMT4tmLvpg63y7cuPIGbKa0skU9
         137kbeb68XWaj4hnlGIjNWvj3LbGZiUbm0aDgeAM9nFp9AabdDy6/MNBPspCzz6fX5sl
         6+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFNMMIqgXQm1wNzbTG3HFgWKlA1XkKSdoDhCXeOs3W2lhIaRnSa6KtQklfr8QBhslRrTyQOk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbliCzGpX/9lSzWV0gs1nDm506aUu9yGtut3AUhc/BZR2ALLGp
	t5GzYFUt4yl9p8UUyU+bpb9SayezLIau1yJIqTj2L/CFIVg3yMYZVBI5
X-Gm-Gg: AeBDieu61gRMLWppSy5/g4SLPB6k7VnBu56N1Jiks5bYlCIz4TnHdgL8fzrkcm72Eh+
	i6voVKIY6tvU3L05xsNnKu7VmFBljfkehM1mLYGUjS5xIDbItLEES0EHD9ErYkTK5BXZ94yn843
	Cs//aR7vEVZn48j9+5JZqrjNeGNAu74uUSw8dtZvu0P+IoJ2m412mZ9lPxyMjS1lO29DyEi4Wob
	yk+ywywOsRb55JaF4YOlM6HAXYCN5MKMEdUIyFazEBUsJ6YWRRNOUVTXWMm8fgJ71zLOiugAdPp
	Qwo7m4cgmVdBegHKM3BMDn1cOivozzkRU47qH9jA01xaImUko48gzAe5Y2nEkvSJ2WSnr5SDmwX
	74OfCx8Fa7PdsDwWIm2N6sMn6ngPgOV1hlkwRBBZd/Ohuj8gJDrqK62eF2IQNSGeHa/UvcGfKTW
	FniLVmCTRyTLdiiT2FPZlo2goyKWTluUyWczOjyOzhRgpW0IBcZgwnUeB9XziJwHk1iP8o80ssk
	kTFhTUEz+aZ2hlvrGWwlFM=
X-Received: by 2002:a05:6000:40dc:b0:439:bd70:610f with SMTP id ffacd0b85a97d-43d642bac24mr244448f8f.44.1775760033721;
        Thu, 09 Apr 2026 11:40:33 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d88bsm560563f8f.37.2026.04.09.11.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:40:33 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: vburru@marvell.com,
	sedara@marvell.com,
	srasheed@marvell.com,
	sburla@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net v2 2/2] octeon_ep_vf: add NULL check for napi_build_skb()
Date: Thu,  9 Apr 2026 19:40:09 +0100
Message-ID: <20260409184009.930359-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409184009.930359-1-devnexen@gmail.com>
References: <20260409184009.930359-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-235487-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 974933CEC88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_build_skb() can return NULL on allocation failure. In
__octep_vf_oq_process_rx(), the result is used directly without a NULL
check in both the single-buffer and multi-fragment paths, leading to a
NULL pointer dereference.

Add NULL checks after both napi_build_skb() calls, properly advancing
descriptors and consuming remaining fragments on failure.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 7bd1b9b8d7f5..d98247408242 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -414,10 +414,15 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
-		rx_bytes += buff_info->len;
-
 		if (buff_info->len <= oq->max_single_buffer_size) {
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx = octep_vf_oq_next_idx(oq, read_idx);
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
 			desc_used++;
@@ -427,6 +432,27 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			u16 data_len;
 
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx = octep_vf_oq_next_idx(oq, read_idx);
+				data_len = buff_info->len - oq->max_single_buffer_size;
+				while (data_len) {
+					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+						       PAGE_SIZE, DMA_FROM_DEVICE);
+					buff_info = (struct octep_vf_rx_buffer *)
+						    &oq->buff_info[read_idx];
+					buff_info->page = NULL;
+					if (data_len < oq->buffer_size)
+						data_len = 0;
+					else
+						data_len -= oq->buffer_size;
+					desc_used++;
+					read_idx = octep_vf_oq_next_idx(oq, read_idx);
+				}
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
-- 
2.53.0



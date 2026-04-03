Return-Path: <stable+bounces-233234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFuxH5Ee0Glk3gYAu9opvQ
	(envelope-from <stable+bounces-233234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 22:09:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F4398137
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 22:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9067230479CE
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 20:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE13D5662;
	Fri,  3 Apr 2026 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi+FBY7T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D534B19F
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246858; cv=none; b=CjFLzTv5WUE8fOAhxoYsW2fNbZGMJrJYpAHBwS2nTeUtd6Vh9PHQVhm7BXGkLNWyEu8RIEu6AJE6ZpziaopAUOOH0jLkSw6EFARtynPCkvZgX5GpNDBHPX3JJAKoGyGccNiRHDwQhWfmUlBrUiCTTXquvVUx1DMYm7JVOtK+5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246858; c=relaxed/simple;
	bh=2EWNeglDkNZGr2Gg1mnutn0NEb1fsT8qNPLfPzONX6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioijJk8dNww1D/IG1tu4htrnnI1BwIkHqhqs1zNLNOFjDu6YwI0qeWZdihXiHDEr5E15PMwL3pAWlYGG/edeGL6/3gPF3L0RKxSxr18MO90sv3N15AzNz2IDqx4SdilqURC7KNoRetnSg4tgbRxHwxrZYoRAx1JuDpBWWRokns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi+FBY7T; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso20304475e9.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775246855; x=1775851655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTa3SMNP51BcljfrASeQns+9o2oJfvoBuCifvUwOAm0=;
        b=Qi+FBY7T3N+t9Z6zyYyUvToT2W2yH71BCPwTWhey5+NXD7bS1WOb7pIflMLgBATccf
         oUqBb//GKWACMjVeoXpHeDrGHCODJmsOr1ReJjA4hkQogb1luLXks+SQLgSOPWBRrDDB
         70o99J93FpAQqptCcxju1oyEb/jZUyJyIGF08T8Inn4Fu53VcZZs3k1EormV/97vHJxT
         eQwlFKwdsRaxqST4MRtR+EdLJEyxleFjMJQtQ9yT0t2ewh3i+Fb/HO83Q3OMFMH1tzAs
         1wJxeAItkG1+6dE3SlGLy9qWfADIXu1TTKxPrIPVDDjaHZ3+uJU7GtwEY288H+8uDJHt
         q0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775246855; x=1775851655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTa3SMNP51BcljfrASeQns+9o2oJfvoBuCifvUwOAm0=;
        b=Hi2JkTfsBxPwS/bx4FZz9iE+D01eJP+yLCOBEs03JiX+qjlZ3iUdto4akDk+3W/u9r
         lnOU2quqdv1vrPXr6Hol4acXhMzfU2Vif1TnWmYC+YaSDFxk9jHyCyIou7Z3oywq/q2U
         UAMTsiwq8YyaAo7nvZGeihyrNA2KM/tQNsHohIwy7t9KGeGk58E1NDJDUQhzTpIucwqx
         EmCXyNDEvDCXmUx8g69qwh+ioHnUNuB0BzJ96o2FeVYkcJ2mh0XEhvS6ZABgkME0bygO
         tLWOMYKm6+FZU3/wAan6AMHBuKgWGR3YweQegwNQxRMtAhqbiXCQNDQsbzW6W2z42Dae
         7bWA==
X-Forwarded-Encrypted: i=1; AJvYcCVamicesfP0SkVZZ9IKlMlR4kFQXWFlfrJPNuQ6XUjCLtRUVdqpCIuhJFPCU3pyBFGTrP5pXzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vAElbKkh5AhvNmAtuas4++//ZHAYjoiWjvq+6z70hae1tetw
	zJNJOSiXwC1KyolXm2Gt9J+4BCGv3fYtCEKTyw/+u7Ju6ATlMuVRRkU4
X-Gm-Gg: ATEYQzwVsV5ieApYxlypT3JeEVeLlIsPwchIPaLbv408lnJoBkhnKXl1hpZdwi+oQoc
	k7i6JCbJcUiLOdDCrr9hiXBurwHSumc/Egu4648knfDD6TZpEJZ5sQs0kHtd+Ixpn+KUjzvvthh
	n3m9gtLDrXBlWR4fBpS4uIZS8fKlLe4QBgS05rGbQQ7NN24mC0pesB6U43FbsdtOV0TE+pi+nbu
	VFD7Mf9LJZgmt5ZJnd+Peln617mp4pDhgK/4DVFYT8YReULrKyNX7fTnzdu5JqeorI2Fff8rQSV
	n8x+eAqhfjgy/+EQlfoY4FnRGgpswNmMKHJAcB6kN8l1/oxuH5AklIvE5AO5KWHIdy2nf7JXAuZ
	DlfjGnNM6LjWTPRN6o8JMTEwODWgk1JVzluyhnjGJjstJp20DPuM3NNVXdh25cMZGkpETLFsd3u
	lQUex3Q1hJss1VJKlEP/UO0GE5Hl74wC6+qY4pJN1WIjcQW2RV6uZIMBphI9au8BCJ8qY98gPrr
	Rh3kc3YaC49
X-Received: by 2002:a05:600c:6290:b0:488:869c:ed9e with SMTP id 5b1f17b1804b1-488997c1c18mr70132855e9.23.1775246855414;
        Fri, 03 Apr 2026 13:07:35 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1c148sm43199695e9.5.2026.04.03.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:07:35 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] octeon_ep_vf: add NULL check for napi_build_skb()
Date: Fri,  3 Apr 2026 21:07:32 +0100
Message-ID: <20260403200732.497307-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-233234-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 284F4398137
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
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index b579d5b545c4..97b836c1f5d2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -409,10 +409,18 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
-		rx_bytes += buff_info->len;
 
 		if (buff_info->len <= oq->max_single_buffer_size) {
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				read_idx++;
+				desc_used++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
 			read_idx++;
@@ -424,6 +432,30 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			u16 data_len;
 
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				read_idx++;
+				desc_used++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				data_len = buff_info->len - oq->max_single_buffer_size;
+				while (data_len) {
+					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+							PAGE_SIZE, DMA_FROM_DEVICE);
+					buff_info = (struct octep_vf_rx_buffer *)&oq->buff_info[read_idx];
+					buff_info->page = NULL;
+					if (data_len < oq->buffer_size)
+						data_len = 0;
+					else
+						data_len -= oq->buffer_size;
+					read_idx++;
+					desc_used++;
+					if (read_idx == oq->max_count)
+						read_idx = 0;
+				}
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
-- 
2.53.0



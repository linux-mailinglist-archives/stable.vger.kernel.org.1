Return-Path: <stable+bounces-235486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDqhH6ry12n6UwgAu9opvQ
	(envelope-from <stable+bounces-235486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:40:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C47703CEC61
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C76E630172D8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F7311C3E;
	Thu,  9 Apr 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvdCLdj/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796832E62AC
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760034; cv=none; b=VWXq9Kw24k1s71feux9zyIQC/VOpqO2ZyWcWcoYZ4V4oLBnXjSuwscv33qsvGiVtl9pUCwG1O2+ZtXym9ykb6gMaXoytau8fu191sDiP5/D8YI96eCnhwRGruE8V2PTUxlnznAVAAQiHgZDrFdu7zRkqJDqVLN9oXU/CzsxMEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760034; c=relaxed/simple;
	bh=QS69EOwbeilaE+gg/PyPbGlFPcxKmaTs+d+KkM8Dpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbaWH1J3zOLAj7fOOTaPCHf4BTzHRptP4V7ZTA8Cs9p3mLSU+RhZHcfGUwCEIKYkO6z6ntLuzHjY3xii+ZUE2lj7RBQKAEfvElqleo5YrjnWU4Hiz/nHl+Alb5lHZ6UO4YQc/gqXK1L9x+kTiSj8rYBX3wbZIGbm/JPXgArYNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvdCLdj/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d5ec211abso570989f8f.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775760032; x=1776364832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oP20LkfN1ljFvhP3IKO8BTW+iHHIGJpKL/nZSlyxTA=;
        b=XvdCLdj/P+hdkNLwEc2YeM15ZIknZCcXZbd5As3Nno5y1SolDjb7RhRZcpfTehudL3
         LGFlanQvcoWcclICGcXJIVfVccGuJ3hKAY3EmjYYEz+P8qut7bMKood1hgHUiLQ33YX0
         7oTYIGeUpQrZ8aV8aZPCux2oSw4M25kZvxb+kzrywwd9QilYJZmWsXr1RRc4fiohqVg7
         5aDaG1Hw83RHDoKUQbqHHrmO080eR2TdYUryn4QpEzAWBkTtjs2cTGeDl3+I3H9qGd0U
         foedFIDfMNXepV76n5SobqRiPE9paET60SGMmLn/JkIJ70UkJlIThCNocqnFETZFqv8l
         KRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760032; x=1776364832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oP20LkfN1ljFvhP3IKO8BTW+iHHIGJpKL/nZSlyxTA=;
        b=me0KqoEXR46eXWqM0QMFv0rpt/gVc1wObRY5pfYt4Ip5k8YAwhPyw4jNJ54LeYZqAs
         KGtLIqrx3bR7pBcel/jXXhSq+zCUvsQZTC9c6eNtsajmF0VxwUKm0oNtYyn7zxdSZIej
         2FBM+LXqZ/bKUwQtOW1P7Sm56Yx47uwAKpP1QcQDyDsoXrvKPeMJh9iDyJXg983lBsDC
         O6j+DUr589DudQn5rqNZakeAd10GjIXuFwmsNx1vjH6pT3FyOmukcq8CdGWR9iQcGrXP
         GY73UhjLK35BQwqMxDc1rnLR7vCgJubNZcE/bIOpSz/mbpu3TMUJ2jSwgJqkRN/62MWB
         ONrg==
X-Forwarded-Encrypted: i=1; AJvYcCUfVDA4PUCIdec9XIevw65wydAeGzirlPGiXL0wbZyXLaPpIGL0vHL6jyQJHsgFopIu8cUgR4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcdWfZcIhEpZXrD7aY+abG6jVpRjaN1VEjJ+ddTjV9yNVP2+wN
	2ML7VRo2viaxJALElQsKGUln1IMJES9lHhJi4QksrsbwxPjJIuprGYKrxnH55LBuYsEfng==
X-Gm-Gg: AeBDievNpR6bgyR2geUwfYMB+f6WFMDRA7a1IlUGxvc0DffP6/ysB2TDCh3Zup8z3PK
	sQ222jG0K0wCAj0DO/fhGzUlWGobdH56T2ZaXyVWaWWk5d6JAvA4PI1ssECGjcfSBoYnJzVfji1
	5XedUTPhctkDddW450xuZLUgCqzQHtvXGfPyy8Vw9vzaHGCkxQw2uYi1OmmHep+lqd/SkyR3nhJ
	1rMGZC29Fc7zRMavIREB2B6wQRk43mNUhJDxo1Nb25PHNRO9gPzDY/JLQbyuEJw/6WpVDcpGNSv
	fUmPLonlvMHM1zE2fK1xxFNQzqib8hUg30UDUt1P5pVHC3ueV7OhC0z3RNorRld3eaWmMmLWkj2
	VINT2edEAUcVLPwe67DrzYO9/H5zVGyQmj8ccTu133N/OhPnNGC6s5Bc8iIbyN1j97bA+jVe5K2
	upHw724OUX83qL7OlqU8C1yeBwMj0HK3GMtY23SaXzOwuY+CJHJUPulPcqxunlUSJ2LFQ8KSdYC
	9jX6pmwIkY1
X-Received: by 2002:a05:6000:4007:b0:43c:fbde:3101 with SMTP id ffacd0b85a97d-43d642e7cc5mr237497f8f.41.1775760031718;
        Thu, 09 Apr 2026 11:40:31 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d88bsm560563f8f.37.2026.04.09.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:40:31 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] octeon_ep_vf: introduce octep_vf_oq_next_idx() helper
Date: Thu,  9 Apr 2026 19:40:08 +0100
Message-ID: <20260409184009.930359-2-devnexen@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-235486-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C47703CEC61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce octep_vf_oq_next_idx() to consolidate the repeated
ring index advance and wraparound pattern in __octep_vf_oq_process_rx().

No functional change intended.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index b579d5b545c4..7bd1b9b8d7f5 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -352,6 +352,11 @@ static int octep_vf_oq_check_hw_for_pkts(struct octep_vf_device *oct,
 	return new_pkts;
 }
 
+static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
+{
+	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
+}
+
 /**
  * __octep_vf_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -415,10 +420,8 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
-			read_idx++;
 			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
+			read_idx = octep_vf_oq_next_idx(oq, read_idx);
 		} else {
 			struct skb_shared_info *shinfo;
 			u16 data_len;
@@ -429,10 +432,8 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			 * subsequent fragments contains only data.
 			 */
 			skb_put(skb, oq->max_single_buffer_size);
-			read_idx++;
 			desc_used++;
-			if (read_idx == oq->max_count)
-				read_idx = 0;
+			read_idx = octep_vf_oq_next_idx(oq, read_idx);
 
 			shinfo = skb_shinfo(skb);
 			data_len = buff_info->len - oq->max_single_buffer_size;
@@ -454,10 +455,8 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 						buff_info->len,
 						buff_info->len);
 				buff_info->page = NULL;
-				read_idx++;
 				desc_used++;
-				if (read_idx == oq->max_count)
-					read_idx = 0;
+				read_idx = octep_vf_oq_next_idx(oq, read_idx);
 			}
 		}
 
-- 
2.53.0



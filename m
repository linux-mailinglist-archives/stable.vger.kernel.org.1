Return-Path: <stable+bounces-206278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15382D03D63
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 111BD30348B1
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683E53EEFC1;
	Thu,  8 Jan 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fLDMWLYI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D23407575
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863495; cv=none; b=JFSVn99Ev2BoWTTyycazqoAWp4h1VlChVJe0XANEf2YgBirHy5Aa2RQGOjJTggk1JPLNrlF3TcHukjD7L14kfbvgWqnymzmHe/rhWCkj3Fe9GD1Dhwe+kinzQSti9vJAHkgwNIZ08XteJ2gsbEqRfzISRTcKKej/KNw5iO0jWvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863495; c=relaxed/simple;
	bh=B931oHIimqmsO10uO8Y+IrukZdrFt4h8LI0GgPLSxV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qyflgjl/p47WyISFRGxLwDz/cc7OHqpya5GDoUG6w0XBZIzon7nLPKecHX95BYh9DWGivKLOpjZM5MC6oe9ZSK5yv56K0TiFtiO3weG4cOPLHs0L5jOS6Tsko3RAkVSM2MJFE3fIJiIiKtjdjxzp0jCCBH0jNr0pBw2DH7xiuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fLDMWLYI; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7cac8231d4eso1769978a34.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863484; x=1768468284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afDNHqE+O/jMQ8GoDcichOsLE/NDeo2/4CdPT3q2YIY=;
        b=A2O3jsDsZmebeEWN6e2+oShhjSNyxJad8jmXsFpLirvQ9mSMOKS7UbRsKV8Bd3Dp4g
         qISqbMOI/TwnxdjaZeDNCiLlrLf0ttcOVrpDjLUul2ZW95YKIBAOlsCoVApKJdcTZzB6
         MqHOlEO89IBMGOaxwR8wnMHr1xwzVI71QXrk7r4/JZ1NRdIJfjspr/dBILMi4toU813G
         DaayZbvnYszi5WRDc4oTacX7Ipi0D30JhPFgg294KaOsmw0w5IqWU/iCEPQXmwdWhzAs
         3K7yEDAyKnNfyTRrlZ0hU4q+qA8U46q7nUxfqVH28J6relxSC1yRWrTDIXI5OgeoVL1x
         a4Dg==
X-Gm-Message-State: AOJu0YyYhCd8HNEx2JdP3hF8VYjlUiol+QLMZGhERngfWGJOE579EMOK
	velCW+BiQbJpaWSk4jg4N9+VHSnqS33hurvaq4En6xK5EJw0ldhFnJwI68+z8hDCZilRyoDQpN6
	wQC7eq8NGJdJBdORHnZ7dBZNR155SaPKrRSRMFHGKZXkqiPHQobEpy2HbAcxwx8Lj4blJr0sfbv
	EV1d7jcRNFWu53BNiNeorguTh9nBks7pCaEAJkDXiOgrqdcYPHfnC3vm4cvEmu+r0bd6GjfgUbF
	Km/qzGGvZIQ4v4XQg==
X-Gm-Gg: AY/fxX68SNdYcfHZTxG2gll92gn39sDcr7xiePY5AdbdjZn87spdXXMA6K4A2446eb0
	W5a9iDtNsWZq4cmM/H5Wue0cXp0NuTSHbN+nPo6yDJsEUQm3cJicgewhrBO+FmiwIthTyQverTL
	O1Xh+ZOp9VpDfLuesWrbvq8w/GpuKV1zpxzZnKQ5+sRXawh2hKPRUUWo5P1KKgSrYG0Gol2aold
	eTHxeApPf7Kl6c707uIk9WMlQ7i0MfXpQYoTR74hue6idntpP1xtYa1ibXf5HNK0ZF3qEeO5JXQ
	1OJ8aJVRjYGbDd5QAzUGvLLZYUvImG7VsuCOEYEONnIocIva/rRhEeI94T0FTFnzUunKG1+UChS
	B1iepa1+a3bdRaECm/ADImmNLJujKnPHXUMCwo+nElGgXHDgYNj9La/Jql6afvWnBeOYBKFOdxO
	Cbbv2n2RTQqkTjWLtF5gOfKUlybsx9vKtCXY9Y1x1u69QdYA==
X-Google-Smtp-Source: AGHT+IGYv6id4/YfTiDn4FPn+bSDvVsmmF5y3O0CL5kKyogOPMZq3hx3+20dncvhCrbZkXqO/gpFKQ+hychx
X-Received: by 2002:a05:6830:dc2:b0:7c6:d0b2:8eb6 with SMTP id 46e09a7af769-7ce50926cedmr2705947a34.15.1767863484451;
        Thu, 08 Jan 2026 01:11:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ce47802f1bsm958992a34.2.2026.01.08.01.11.24
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:11:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b0751d8de7so3427167eec.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767863483; x=1768468283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afDNHqE+O/jMQ8GoDcichOsLE/NDeo2/4CdPT3q2YIY=;
        b=fLDMWLYI51tengXQI/QbjJil1AUrnf1AW6lzkOfVgFVmkLumZfcby6vX/tsiemB28i
         jxs7SjcsdOJKT4fE5Ips4dJZ1kAW+kcFa80y2x0wCRP0NEuohaZ5KJHLN/F4dld+h/lf
         RGLGGlOCtVusNk3vbuSBHCeol55DY/pa9N3iE=
X-Received: by 2002:a05:693c:4151:10b0:2a4:8576:abf5 with SMTP id 5a478bee46e88-2b17d2b0af0mr3151553eec.23.1767863482725;
        Thu, 08 Jan 2026 01:11:22 -0800 (PST)
X-Received: by 2002:a05:693c:4151:10b0:2a4:8576:abf5 with SMTP id 5a478bee46e88-2b17d2b0af0mr3151533eec.23.1767863482047;
        Thu, 08 Jan 2026 01:11:22 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706c503csm10623374eec.15.2026.01.08.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:11:21 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mathias.nyman@intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2 v6.6] usb: xhci: move link chain bit quirk checks into one helper function.
Date: Thu,  8 Jan 2026 00:50:20 -0800
Message-Id: <20260108085021.671854-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108085021.671854-1-shivani.agarwal@broadcom.com>
References: <20260108085021.671854-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Niklas Neronin <niklas.neronin@linux.intel.com>

commit 7476a2215c07703db5e95efaa3fc5b9f957b9417 upstream.

Older 0.95 xHCI hosts and some other specific newer hosts require the
chain bit to be set for Link TRBs even if the link TRB is not in the
middle of a transfer descriptor (TD).

move the checks for all those cases  into one xhci_link_chain_quirk()
function to clean up and avoid code duplication.

No functional changes.

[skip renaming chain_links flag, reword commit message -Mathias]

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240626124835.1023046-10-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on 6.6.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/usb/host/xhci-mem.c  | 10 ++--------
 drivers/usb/host/xhci-ring.c |  8 ++------
 drivers/usb/host/xhci.h      |  7 +++++--
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 621f12c11cbc..264f8bbe8f9e 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -136,10 +136,7 @@ static void xhci_link_rings(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	if (!ring || !first || !last)
 		return;
 
-	/* Set chain bit for 0.95 hosts, and for isoc rings on AMD 0.96 host */
-	chain_links = !!(xhci_link_trb_quirk(xhci) ||
-			 (ring->type == TYPE_ISOC &&
-			  (xhci->quirks & XHCI_AMD_0x96_HOST)));
+	chain_links = xhci_link_chain_quirk(xhci, ring->type);
 
 	next = ring->enq_seg->next;
 	xhci_link_segments(ring->enq_seg, first, ring->type, chain_links);
@@ -330,10 +327,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	unsigned int num = 0;
 	bool chain_links;
 
-	/* Set chain bit for 0.95 hosts, and for isoc rings on AMD 0.96 host */
-	chain_links = !!(xhci_link_trb_quirk(xhci) ||
-			 (type == TYPE_ISOC &&
-			  (xhci->quirks & XHCI_AMD_0x96_HOST)));
+	chain_links = xhci_link_chain_quirk(xhci, type);
 
 	prev = xhci_segment_alloc(xhci, cycle_state, max_packet, num, flags);
 	if (!prev)
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 6443e11eaac0..cdb819e323b3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -245,9 +245,7 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
 		 * AMD 0.96 host, carry over the chain bit of the previous TRB
 		 * (which may mean the chain bit is cleared).
 		 */
-		if (!(ring->type == TYPE_ISOC &&
-		      (xhci->quirks & XHCI_AMD_0x96_HOST)) &&
-		    !xhci_link_trb_quirk(xhci)) {
+		if (!xhci_link_chain_quirk(xhci, ring->type)) {
 			next->link.control &= cpu_to_le32(~TRB_CHAIN);
 			next->link.control |= cpu_to_le32(chain);
 		}
@@ -3381,9 +3379,7 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
 		/* If we're not dealing with 0.95 hardware or isoc rings
 		 * on AMD 0.96 host, clear the chain bit.
 		 */
-		if (!xhci_link_trb_quirk(xhci) &&
-		    !(ep_ring->type == TYPE_ISOC &&
-		      (xhci->quirks & XHCI_AMD_0x96_HOST)))
+		if (!xhci_link_chain_quirk(xhci, ep_ring->type))
 			ep_ring->enqueue->link.control &=
 				cpu_to_le32(~TRB_CHAIN);
 		else
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 808f2ee43b94..cbd8ef1c8db6 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1784,9 +1784,12 @@ static inline void xhci_write_64(struct xhci_hcd *xhci,
 	lo_hi_writeq(val, regs);
 }
 
-static inline int xhci_link_trb_quirk(struct xhci_hcd *xhci)
+
+/* Link TRB chain should always be set on 0.95 hosts, and AMD 0.96 ISOC rings */
+static inline bool xhci_link_chain_quirk(struct xhci_hcd *xhci, enum xhci_ring_type type)
 {
-	return xhci->quirks & XHCI_LINK_TRB_QUIRK;
+	return (xhci->quirks & XHCI_LINK_TRB_QUIRK) ||
+	       (type == TYPE_ISOC && (xhci->quirks & XHCI_AMD_0x96_HOST));
 }
 
 /* xHCI debugging */
-- 
2.43.7



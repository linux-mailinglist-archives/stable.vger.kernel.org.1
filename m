Return-Path: <stable+bounces-206275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E2D0388C
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 15:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DDDD301C574
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF13EEFA2;
	Thu,  8 Jan 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ax4a+ip4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3C40756C
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863443; cv=none; b=E4iRVocHhVIyx2V8nAgG45QNHbxg0/HWDt0x3L9k2WSZVG/Zue/omOX7NElkPeD1yYnJROTK9V1m38uk2fRhVQFLAx4pQN3RyuBcc843WkBH6DKfhLwhtY3+iSeOq5tgQ0N7rykhEa/Agvmt8tEr+ek/xgz4fNrtIWyoiLv93eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863443; c=relaxed/simple;
	bh=uq93U9o8JB9zbSTVh+vQQdETnho1x8xCHUG4yBJ991Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1dZMxbx4vqsF9sUGFIKQQH9GYz2HcKweUYhPGNPDHmyc9PKCNhRflTbs/csQQyuVUL5ZXuWfdtXg4ugxw5OT6KP5QAjKu2atXrUJt5YybxzKSRwyH0l6nzYC2X8S5WiH8pMhD+dRiv8k+E0TTleVJMmS5yHQ5ukPBBntvbuPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ax4a+ip4; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-12056277571so2961794c88.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863432; x=1768468232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1wGe4AzuWmLwc2h4fqRv3J8yQzipzJ9zvQmyQ9uhA4=;
        b=T9+OtXHoSq+qn8lPJdD+xOqXKUjrx/ZRlQuMiOu7+6dI+yPLjp3LYKUt2LAbyQk9gl
         QokpBMQnjgK8hy+vSSg7zKkxV+sIvklQ74gWvuvJ1g9tizlcyLxHAwx6W+gaCZ7JJQH3
         kFrGXalto8ZwClC2KJeAWDRn+skAxZFrB2HrhHCXruYCbTM4v9ubgII64fj+iEAqCC11
         5WAe4xJFLw7fpdJ6/Z0dBWl+1NxEXtpVlOT+arAJJbFolvWKipRE6kdRVgY+YQwaB+45
         2xDfSC23+tuGNlb6G3W4nset9q6adMN38un1WPlMLPOPeIN9sZ5Zz6r0kTdIci5gV7qO
         H3zQ==
X-Gm-Message-State: AOJu0Yxp+PT09zzknpcRVFVHQ0aDoLx7A6vNIkwOzjS7owpHoE3SQy3q
	ySfUibDYCvLuxWIP4RgUPCfNt1W63Y64U8tuI0zxCBje28DIR12GNVUNeTuvvHEjhdseMpfbNgo
	YqngsffPJ6v6wOz73d7hcqK9KIDjqd0DN9f0F3fk36NOg5Geo19wKdEMI5VNK6nEBYc4TMSLMMg
	9xZa8V2IAXjlONeyUwpd0o+njQdbPB3QK4J9DrR8RSmSNlTfGKOlhZYIfI8jlhkco/I/D9MGpuc
	GEajPxkNIcr8cWkug==
X-Gm-Gg: AY/fxX6mUSlRxF3uIpmMbvAHOUci2/o/KKqlrjThcZOHyTauhtPdDqdN1XBesmNSHCz
	A2GbqJ/XzI1pO+2bdVNnWxx1y/CJJd0UtBt9LS2Tx8M1MVUOJhBbQaQN8DJ0qnAQqymsjkxm1Tl
	oiCLfE1ORA0LdBJcvlGxkWwxJYNHP09qJK83XzHpKB0Y2q7NT+MRDORcu4zZFv7Tul/OF1W8Wb3
	PNKVDn7XchhDvWHIENz9pYFQRQvHpyJA1m7R+q/dp6iYnPtxuWM/uvAO7QLDci2Mf6XXXH/74b5
	erj2s353ybkLKR0aHWzu5jxE1jT7GkkIRSuuM+rjfBSu6jWp9BqzjcIqzn0bLFfmJoCxNBrdp+i
	WTJcFrZDUK45GVQBr9CDPvrH8Lpbvlu86hiJOr4Gcd1MQv4FriryhXChH4oM5E/kAE5krtJXlXd
	i0sOVWqzxeW2/saLQPc9ZSEaDTP9OwGJieUQQp/Tsf0nujJA==
X-Google-Smtp-Source: AGHT+IHDg6nO7MgEJZn+BpJUEmYrULzZSBXrf6ePU7aNN73JXc/FY+jgvydPsAcNAdkGkYkzF/69PfnQMX09
X-Received: by 2002:a05:7022:609a:b0:11b:923d:7735 with SMTP id a92af1059eb24-121f8af867cmr4576580c88.1.1767863431834;
        Thu, 08 Jan 2026 01:10:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f2489521sm1699737c88.3.2026.01.08.01.10.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:10:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b0751d8de7so3426322eec.1
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767863430; x=1768468230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1wGe4AzuWmLwc2h4fqRv3J8yQzipzJ9zvQmyQ9uhA4=;
        b=ax4a+ip4g4l4yfvuTcnabIcsykVjSS/IuuWmKcOm82Qu28E1W4qW5hGJlWkigY+Yn/
         rDGQ7r8ZzlF5zJi845R4vFZJi5aMwkRNg4r+cJWxPDMBZ5dI+39p9jAgdoZrGrhzcX+t
         TzZAQO1s0fVYDA9qU91IcIlFkhWQ1P80l7Yfc=
X-Received: by 2002:a05:7022:3c10:b0:119:e56b:98c0 with SMTP id a92af1059eb24-121f8b8bd9cmr3172460c88.39.1767863429720;
        Thu, 08 Jan 2026 01:10:29 -0800 (PST)
X-Received: by 2002:a05:7022:3c10:b0:119:e56b:98c0 with SMTP id a92af1059eb24-121f8b8bd9cmr3172435c88.39.1767863428998;
        Thu, 08 Jan 2026 01:10:28 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24985d1sm13267619c88.16.2026.01.08.01.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:10:28 -0800 (PST)
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
Subject: [PATCH 1/2 v5.10-v6.1] usb: xhci: move link chain bit quirk checks into one helper function.
Date: Thu,  8 Jan 2026 00:49:26 -0800
Message-Id: <20260108084927.671785-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108084927.671785-1-shivani.agarwal@broadcom.com>
References: <20260108084927.671785-1-shivani.agarwal@broadcom.com>
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
[Shivani: Modified to apply on v5.10.y-v6.1.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/usb/host/xhci-mem.c  | 10 ++--------
 drivers/usb/host/xhci-ring.c |  8 ++------
 drivers/usb/host/xhci.h      |  7 +++++--
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 57f739f93321..42c12b382e9f 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -133,10 +133,7 @@ static void xhci_link_rings(struct xhci_hcd *xhci, struct xhci_ring *ring,
 	if (!ring || !first || !last)
 		return;
 
-	/* Set chain bit for 0.95 hosts, and for isoc rings on AMD 0.96 host */
-	chain_links = !!(xhci_link_trb_quirk(xhci) ||
-			 (ring->type == TYPE_ISOC &&
-			  (xhci->quirks & XHCI_AMD_0x96_HOST)));
+	chain_links = xhci_link_chain_quirk(xhci, ring->type);
 
 	next = ring->enq_seg->next;
 	xhci_link_segments(ring->enq_seg, first, ring->type, chain_links);
@@ -326,10 +323,7 @@ static int xhci_alloc_segments_for_ring(struct xhci_hcd *xhci,
 	struct xhci_segment *prev;
 	bool chain_links;
 
-	/* Set chain bit for 0.95 hosts, and for isoc rings on AMD 0.96 host */
-	chain_links = !!(xhci_link_trb_quirk(xhci) ||
-			 (type == TYPE_ISOC &&
-			  (xhci->quirks & XHCI_AMD_0x96_HOST)));
+	chain_links = xhci_link_chain_quirk(xhci, type);
 
 	prev = xhci_segment_alloc(xhci, cycle_state, max_packet, flags);
 	if (!prev)
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index cb0bf8b6e017..1f047f38ef46 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -250,9 +250,7 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
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
@@ -3355,9 +3353,7 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
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
index fd095ff9fc8b..07591a498b5e 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1788,9 +1788,12 @@ static inline void xhci_write_64(struct xhci_hcd *xhci,
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



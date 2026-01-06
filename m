Return-Path: <stable+bounces-205088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E64CF8CAC
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 15:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A55D930205F8
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D557313533;
	Tue,  6 Jan 2026 14:31:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDB2DF12F
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709893; cv=none; b=HKYInSnFyy2H+ZC6qopPPt4fDcG+ZhrYQtFqdX/PFaKBHasqAeGcUlIQS8OU16mJypJufHKSe+v8mCaHksPRRrGFvovc1Kccn3yDp8U/8cIRKnvOnEwcrTBNZNSvw8ibktao36aEX7AAlfuZM/1fghVQydFZLujJniLCUOqPUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709893; c=relaxed/simple;
	bh=Q3PukjQiNCmvifXzahUybCj85L1tKr0+GnNmNJ/igD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JnzSel0QLVa2TBeQJ98ZEveV1YrZ9HjHEgQcfeZNB0AZ2YqlP+gI5xYww4p9O2vZ3D/pC83lX7sMG50OpOfuO9sqacpUrmBBJhS0I1VQ+PH33FTLx1u9IAOKyvPItXj6eYALDMl1lMB/NZ9eIwejBscV3XGrUMPME6PYoxw3OtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ece54945d9so428984fac.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 06:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767709890; x=1768314690;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ioKt6sO8sJoF4hfrPk6VnyjuTVjaNElBYz7+4alp3k=;
        b=Kdo8oSCRh7wRqKCZahYrvwXm2AXp+3/noJsWWWJP8ZnyYMAzcvJGxpr9zuuggnj6qX
         InzC9yxb5uAjAUoFW+VmEy0DNwgQO2ohUzf/bS0uR3KEjZPkF7HPUU5ULX5YKFfuye40
         /B1Jkq3auDQPBxIx3h0P9+tvEP1444olLCFdHPpKeoEXla7fDoMzGFGYSmCOeg0s4fld
         PooSM9hN/GhbiHFJ9Sw6fHRWpaHssCZI3qK8anuJOBZicvF2QHlApEqtkpGVs5mDp42g
         ZC7mr0pUoOcu4dFWKL3s1E38Wdx1rSA5WDtZGmJvsvPbVR1C6FBPF59iQCkNbo2dAVT+
         XJIA==
X-Forwarded-Encrypted: i=1; AJvYcCVh+mWCN+e+9unSH0iX2+T7FmMLCQCXHXtEWmoUsNgrUAype3i9Xl1WmsZ0hMKrcEHv/BiGL5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6R+UATy/SgmpPQKLzz7JyWRyxtKfzJ7LyZ7oaCZFaKF6Dt8uA
	IMOrNIlL6osGCF/gKnXhRu7ngWFQv72niW4euDNk5Tefu1fs/J89mmrA
X-Gm-Gg: AY/fxX5N2E5b4dfkiKSVIBnfFD7uEOySgpVzCbf7r2aQPcgpCOB7vNFghmW7vzSNEmv
	8Hk/OXu/v1NnBZDDXkfVsjlw9vEpBcD4UcvWbbvH4yFmtKCG+avATePZxceTO00ia34DPgdUWcu
	N1DtqHGhr9jm/vKs4e0HB2+1Z+WWHzMoGvmBUygLgOkqeQca0ttLIY/N4ub72BzRzOxTzuT+IdR
	Nn8fbbzysTiFNjka+GZ9IA9DcYB4UlNOBMJk7ZTEZIXQcHqItwZ/2HPTGofL+e5eJzH8/BIEzWZ
	oK8oW7g47rvJQOdAaEz2BooVnpBTNahQmtjRrwuQBCv1AlfhERRnQf9CNNOBI9sI0sHQ1rt0XZ5
	D9qIjAuNHspPsmd360g2fYOzBqgSnJy+qNmS8KtBO2U7OfOOQ9ma2te7DeK+XQlMLtfE/ZgudVZ
	G0GCreJL/3alcyRvaa4FGYQ1qX
X-Google-Smtp-Source: AGHT+IE/DKqExDU9apzgGeHXUcrQXUi/cCvy4EHlIay27hQk413+5HO6x58xoObU2/fQRH5pL4zHow==
X-Received: by 2002:a05:6870:9621:b0:3f6:1e56:aad7 with SMTP id 586e51a60fabf-3ffa09e84a6mr1675107fac.15.1767709890505;
        Tue, 06 Jan 2026 06:31:30 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50e1e29sm1382401fac.19.2026.01.06.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 06:31:30 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 06 Jan 2026 06:31:14 -0800
Subject: [PATCH net v3] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-bnxt-v3-1-71f37e11446a@debian.org>
X-B4-Tracking: v=1; b=H4sIALEcXWkC/1WNyw6DIBQFf4XctTSCio9V/6PpQuCidIENUGJj/
 PdG2i7cnszM2SCgtxhgIBt4TDbYxcFAqoKAmkc3IbUaBgK85A3jFaPSrZGqptYVa3UnDUJB4On
 R2DVnbuAwwv07hpd8oIpH4MBmG+Li3/kssQyfu4lRRjvTK41C9J2srxqlHd1l8VNuJv63RMnK5
 mdxymg/KtGjRtNycbL2ff8APcGeoOYAAAA=
X-Change-ID: 20251231-bnxt-c54d317d8bfe
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190; i=leitao@debian.org;
 h=from:subject:message-id; bh=Q3PukjQiNCmvifXzahUybCj85L1tKr0+GnNmNJ/igD0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpXRzBzKyLbJb4MzDu7+wngc+K1h7TIkZbdWJN+
 8AlyZWoYkOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaV0cwQAKCRA1o5Of/Hh3
 bb5OD/9ACFKf7S6zFNdvFbz9vvRG9ESrB8uEKPpbC439RXojN7HFIzJCg/PHNDCIJYk3tVw39nj
 Ltsz8COG7rVBdaJKD9bSYSNkaEo5474UNtepAVhWttUBx/1naC4oZ4KOrqXYcTx79dhPjKbXtZf
 jEL4aSq50HtIR5cNnQFn2ZJR8Qq4GO3EBk0/ConSFxx8sM9MOMOD9pyEQ3ug63l4CZhr3HBp2Fn
 z2YodikBzwkx2lNa0viJTZyzwnskwSMFUfbaitAHqJdFuBaOnBGKDNvTtkrCc0S9rA2JzyeOWiH
 Be7XKIAdrnY9KtKS5jrTJwbRIfXFyqHVNihUIOPbMy7tfHKPayXgwg6Hpih1zi6WKLgIaRrYnqj
 B5NnaUCu0P+sIBY0KEYNjyAoWHyywCUNEMPPQBfODdshzT6AHefZcSrdL1POtPaNXwqTUz1IsRU
 KtLuHQs1/rD5ZUs67TubfQ9wJ5S7Au/Ct+QPinzMsBQeihs1zsviFhixsMSvT9rAKMJm8z96Gch
 LU8gmteyxUx75KVGMj7vaM3tWsRzdqmKJptCxvxTzpgVBJ7TbI3jO4SxC+ULKWIX+blFtqCRQP1
 /ZAUvqINRl9913c+ZHTEK/XGxlCE6z1fLIeYPLleoMLenqB/KC3gL17kICyOCjxxmfjFd4kNpFN
 LrAlNvm2oIFE65A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When bnxt_init_one() fails during initialization (e.g.,
bnxt_init_int_mode returns -ENODEV), the error path calls
bnxt_free_hwrm_resources() which destroys the DMA pool and sets
bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
which invokes ptp_clock_unregister().

Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
disable events"), ptp_clock_unregister() now calls
ptp_disable_all_events(), which in turn invokes the driver's .enable()
callback (bnxt_ptp_enable()) to disable PTP events before completing the
unregistration.

bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
function tries to allocate from bp->hwrm_dma_pool, causing a NULL
pointer dereference:

  bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_init_int_mode err: ffffffed
  KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
  Call Trace:
   __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72)
   bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
   ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
   ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
   bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134)
   bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)

Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")

Fix this by clearing and unregistering ptp (bnxt_ptp_clear()) before
freeing HWRM resources.

Suggested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
Cc: stable@vger.kernel.org
---
Changes in v3:
- Moved bp->ptp_cfg to be closer to the kfree(). (Pavan/Jakub)
- Link to v2: https://patch.msgid.link/20260105-bnxt-v2-1-9ac69edef726@debian.org

Changes in v2:
- Instead of checking for HWRM resources in bnxt_ptp_enable(), call it
  when HWRM resources are availble (Pavan Chebbi)
- Link to v1: https://patch.msgid.link/20251231-bnxt-v1-1-8f9cde6698b4@debian.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d160e54ac121..8419d1eb4035 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16891,12 +16891,12 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 init_err_pci_clean:
 	bnxt_hwrm_func_drv_unrgtr(bp);
-	bnxt_free_hwrm_resources(bp);
-	bnxt_hwmon_uninit(bp);
-	bnxt_ethtool_free(bp);
 	bnxt_ptp_clear(bp);
 	kfree(bp->ptp_cfg);
 	bp->ptp_cfg = NULL;
+	bnxt_free_hwrm_resources(bp);
+	bnxt_hwmon_uninit(bp);
+	bnxt_ethtool_free(bp);
 	kfree(bp->fw_health);
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);

---
base-commit: e146b276a817807b8f4a94b5781bf80c6c00601b
change-id: 20251231-bnxt-c54d317d8bfe

Best regards,
--  
Breno Leitao <leitao@debian.org>



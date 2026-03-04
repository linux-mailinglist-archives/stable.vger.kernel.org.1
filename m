Return-Path: <stable+bounces-223099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOkfFaRnqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:11:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4989204EB8
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 703AC30C3F65
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE03379960;
	Wed,  4 Mar 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHKbPQu/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596FC36C0B2
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643810; cv=none; b=Atzgr3Pn3vC5daKVjJaTcMThLx5QTAEIBWnsaWsaUZXlJFTDHDkv3d92i3TlFtyY1HXaN898AMicV6J2ebWMB6gqOEA3tgArZ8dNh2WDhmXpkg7bczTGXT5IVY9CzxTGtJ+ZRO3gTxrogg6EaS05cdGpI2WkAP03t39hSuj/Asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643810; c=relaxed/simple;
	bh=7kcYr2CQWjFfr9XdeVWn0l0eawRx1baQA5m4INnvGGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GvirRIsPOx9REOEv+qDAJFEkRNM+rdE11MqJQEeATRewHkqMzt5JL6SiBlftn5zNOw3H/eRhI1NEPM2rpeetR+lzdauof0wRySctajgrWfa34iyRe/sSvAfGfOP4YmmBfZ5V2b99JmoJhdHgSDaU2Q34s98ghbQV0VHMkOa3ARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHKbPQu/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so83327605e9.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 09:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643808; x=1773248608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgphRLbhPgD5BSG66OxTSqTGbQeSKmeLgYJYjcP2SFM=;
        b=hHKbPQu/q97wPpQInyzGqaMIkTDcnhWzumx8yefQJHEWJ9eZvkSeQiWKaDlHOXLjfi
         AROMRYamp8b032kC2eVFjz3hV5fD9xV51aOsT3R2aBi+HXHq0cRL92uWRrslGuJQDJrI
         ZTmNAvjOur4mV6vWMVTYpVXx1LSceja6LgUq+ycpV3c5Pamo/wRSDMRIaeCc2fAcdPRb
         Jd+xK7jkpYoY1nKX7mC2yl8qoN+M58WuBk6CUQ3wHSfypYgPwf/IQp10RfJ911+wfB4o
         57+GkG9dHIJFUP9X+5K5hAERqaR91Z/y7Fotvkx4/FUYAqHiBrO8gE9IHiKJ4QxWutcr
         2v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643808; x=1773248608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgphRLbhPgD5BSG66OxTSqTGbQeSKmeLgYJYjcP2SFM=;
        b=k+IRIRNdSV+jIKXe3veGJpKFJkcxBwMKBKzcqyAt2j9ph3YJbDODwxLkHAfWUnohCi
         8n/49XOlQlzA0phMgy3/0OTyuc6mg1cbIfSIuJZFw6dgujqRLQn4J5XVca31DocJQ842
         86UEcZRjcTUrRQF5eOpCq/0fUfdXU1fVGo6CAKh6S+kQjHUv9zBSQG7m3pFwn2Ymlx/6
         fogsswXrpmWJlfEZUOz9YzIFSBqtXEkv84vzCQARRX7AXUL//UWokUJEC7PiLNgOVke4
         AWz3SHAtY0NUReURM2SluJpfEIk3OtHMZgXXfxFRbIUL2ckQnXUy0zoGOlnRtG9UPzs0
         csKw==
X-Forwarded-Encrypted: i=1; AJvYcCXnW3rOcogwxkCQokOGlUNQr0mQrAAGCOvDR02W/oMGogl4/CM4Ii4yGa8ngulsOWsQBgu696s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBDySHmGjus+GOiCxHB+BbGexK+lglJ4GMpyi17s2qluF0NCu
	q4uvmPQfCJBwt2g7AMBVoEP/6a42We3ByEuvZVqUo0hjGVmrqjupWnyl
X-Gm-Gg: ATEYQzyMtt1dmt0D+S49KNCQxTuvjZ7x+92yXMVGi4x/uEGVCokAhPuoCSSLxnQJxbp
	JpNsxPhJtzKIgsxYi+yO3ADPG6hJPfLIptg+Xz65bPyTfkQ3lyUp+Fko3SkvXTS0Y/ZO9jdKOKg
	qunxvkLQ5etQ8aZ8rWFQInqhKp5oNsnGdN+X5Js5wMM1IhPB7Kq/6qsLsVW3J77E7YxbngrqUBo
	csx+xkWi9WgRE5tIJrjvuwwrWqFj3SNC6/yfQZX/TaG4ubhgawvPhNVhT1LZ7Xgq9wQ074vX1Q4
	z8+g6gBEX+RHYdeAh4wUZ2vR7UTucbQ+86cDkm5ibWXe9L/O2XNk3MkcQOhpRmyc4P5wvx8wOYa
	iXbhvY4rEpm6fvqUJnURLIKy+IrD44pwaD0ke+SB0mQLdtDpdAqacw6NgYn8JLSWhT/rhdcvfSz
	dTM0AmZ0KS+lkR+9GAwBt0AEnDrKeLYHqSRFLlEJAwNE5CqPKezMiH3g==
X-Received: by 2002:a05:600c:8b86:b0:483:3380:ca0c with SMTP id 5b1f17b1804b1-485198bf9f7mr55962865e9.35.1772643807452;
        Wed, 04 Mar 2026 09:03:27 -0800 (PST)
Received: from eve (82-69-63-155.dsl.in-addr.zen.co.uk. [82.69.63.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851887fc54sm70150345e9.10.2026.03.04.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:03:26 -0800 (PST)
From: Rich Hanes <georgebastille@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	stable@vger.kernel.org,
	Rich Hanes <georgebastille@gmail.com>
Subject: [PATCH] PCI/PM: Don't call pci_pm_power_up_and_verify_state() for devices already in D0
Date: Wed,  4 Mar 2026 17:03:24 +0000
Message-ID: <20260304170324.67076-1-georgebastille@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4989204EB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223099-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgebastille@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
initializing") calls pci_pm_power_up_and_verify_state() for every PCI
device at the end of pci_pm_init().  This causes a boot-time regression
on PCIe endpoints that the firmware leaves in D0.

The problem is not the _PS0 call itself — pci_power_up() returns early
when the hardware PM_CTRL register already reads D0.  The problem is
that pci_pm_power_up_and_verify_state() unconditionally calls
pci_update_current_state() afterwards, which sets current_state to
PCI_D0 even for devices that were never actually transitioned.

pcie_aspm_init_link_state() later checks current_state when the
pcieport driver binds to the upstream port.  From aspm.c:

  /* Spec says both ports must be in D0 before enabling PCI PM substates */
  if (parent->current_state != PCI_D0 || child->current_state != PCI_D0) {
          state &= ~PCIE_LINK_STATE_L1_SS_PCIPM;

When current_state is PCI_D0 (set prematurely by pci_pm_init()), ASPM
enables L1 PM substates including L1.2.  L1.2 removes the PCIe
reference clock from the link during idle periods, putting the
downstream device into a D3cold-equivalent state.  Without a subsequent
_PS0 call to restore it, the device does not respond to config space
reads when the link returns to L0.  pciehp observes this as:

  pciehp: Slot(0): Card not present   <- L1.2 entry during link retrain
  pciehp: Slot(0): Card present
  pciehp: Slot(0): Link Up
  pciehp: Slot(0): No device found    <- device unresponsive in D3cold

Reproduced on a Lenovo ThinkPad with Intel Wireless-AC 7265 (8086:095a)
behind PCIe root port 8086:9d10.  The workaround pcie_aspm=off confirms
that suppressing L1 PM substate configuration prevents the failure.

The fix is to read PM_CTRL before calling 
pci_pm_power_up_and_verify_state() and skip it when the hardware already 
reports D0.  This preserves the
_REG notification for devices the firmware leaves in a non-D0 state
(the original motivation for the commit) while leaving current_state as
PCI_UNKNOWN for devices already in D0, which correctly defers L1 PM
substate enablement.

Also add an early return to pci_power_up() to avoid calling
platform_pci_set_power_state() (_PS0) redundantly on devices whose
hardware state is already D0 and whose software state is PCI_UNKNOWN.

Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rich Hanes <georgebastille@gmail.com>
---
 drivers/pci/pci.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..e2e11b2884d4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1301,6 +1301,13 @@ int pci_power_up(struct pci_dev *dev)
 	pci_power_t state;
 	u16 pmcsr;
 
+	if (dev->pm_cap && dev->current_state == PCI_UNKNOWN && !pci_dev_is_disconnected(dev)) {
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		if (!PCI_POSSIBLE_ERROR(pmcsr) && (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0) {
+			dev->current_state = PCI_D0;
+			return 0;
+		}
+	}
 	platform_pci_set_power_state(dev, PCI_D0);
 
 	if (!dev->pm_cap) {
@@ -3191,7 +3198,27 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 poweron:
-	pci_pm_power_up_and_verify_state(dev);
+	/*
+	 * Explicitly put the device into D0 to ensure platform power methods
+	 * such as _PS0 are called and _REG is notified.  Only do this when
+	 * the hardware is not already in D0: pcie_aspm_init_link_state()
+	 * enables PCIe L1 PM substates (L1.1/L1.2) only when both the
+	 * downstream device and its parent report current_state == PCI_D0.
+	 * Calling pci_pm_power_up_and_verify_state() for a device already in
+	 * D0 would set current_state prematurely, enabling L1.2 before the
+	 * driver is ready and causing the device to enter a deep sleep state
+	 * it cannot exit without platform intervention (_PS0).
+	 */
+	if (dev->pm_cap) {
+		u16 pmcsr;
+
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		if (PCI_POSSIBLE_ERROR(pmcsr) ||
+		    (pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0)
+			pci_pm_power_up_and_verify_state(dev);
+	} else {
+		pci_pm_power_up_and_verify_state(dev);
+	}
 	pm_runtime_forbid(&dev->dev);
 
 	/*
-- 
2.53.0



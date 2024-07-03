Return-Path: <stable+bounces-57826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C1925E38
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4451F2578B
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F9A176FA0;
	Wed,  3 Jul 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gHmmlauI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EA13B280;
	Wed,  3 Jul 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006049; cv=none; b=S8xpoFnmD1fFkQznG2RcyVRy5MUYfKS7Ue/0gpoB3Qg7yxbt85oJrYKzfQm9gXR57X2f96p0xyx59/D9/rBaQRqUWx4PgM1fKS51mmedjDoLIyfeIFKQRF1skkEj3ivV083p9Lfgg0o5C+QzqL/fjzJUagtma+Na6NQqmqb2bBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006049; c=relaxed/simple;
	bh=lRtZZcHUScolkcWyx2F1mmAKbHdxfyfKQzIcZoQqVgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N89W29uOuzUlNUlqPLoJD3tKzLaVPVakPgYekV4+1c5Rl1T+HSMkp1h43yM9cIn+HgK4c6fbcxMIuI05krGAfWVwAhEiXA2USvQf1O1TiJbLs1PpE9agk1o49uAYdqUtecPjfeyrpbPUQe//QdW3znEAYzr0fr2fa2o+ons1EK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gHmmlauI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95598C2BD10;
	Wed,  3 Jul 2024 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006049;
	bh=lRtZZcHUScolkcWyx2F1mmAKbHdxfyfKQzIcZoQqVgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHmmlauIHnOYLm/FFtJIWLoL2ybMTiPvX2j68CQrR+2fti4m2QKwmaQ9UMqcZzVl3
	 xjMFlmSeMQ9lKuEwuCCv5iSH+oewgfnCTIUYnUK4qFN7p39YJ3SQt8F2Ch2dESWUOG
	 8aV3LakFRMD0F957RvwOnkPeAcClzHyfOzrXkxIk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Naveen Naidu <naveennaidu479@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 252/356] PCI: Add PCI_ERROR_RESPONSE and related definitions
Date: Wed,  3 Jul 2024 12:39:48 +0200
Message-ID: <20240703102922.651928819@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naveen Naidu <naveennaidu479@gmail.com>

[ Upstream commit 57bdeef4716689d9b0e3571034d65cf420f6efcd ]

A config or MMIO read from a PCI device that doesn't exist or doesn't
respond causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Add a PCI_ERROR_RESPONSE definition for that and use it where appropriate
to make these checks consistent and easier to find.

Also add helper definitions PCI_SET_ERROR_RESPONSE() and
PCI_POSSIBLE_ERROR() to make the code more readable.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/55563bf4dfc5d3fdc96695373c659d099bf175b1.1637243717.git.naveennaidu479@gmail.com
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Pali Rohár <pali@kernel.org>
Stable-dep-of: c625dabbf1c4 ("x86/amd_nb: Check for invalid SMN reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 25e2e7756b1d8..32805c3a37bb3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -154,6 +154,15 @@ enum pci_interrupt_pin {
 /* The number of legacy PCI INTx interrupts */
 #define PCI_NUM_INTX	4
 
+/*
+ * Reading from a device that doesn't respond typically returns ~0.  A
+ * successful read from a device may also return ~0, so you need additional
+ * information to reliably identify errors.
+ */
+#define PCI_ERROR_RESPONSE		(~0ULL)
+#define PCI_SET_ERROR_RESPONSE(val)	(*(val) = ((typeof(*(val))) PCI_ERROR_RESPONSE))
+#define PCI_POSSIBLE_ERROR(val)		((val) == ((typeof(val)) PCI_ERROR_RESPONSE))
+
 /*
  * pci_power_t values must match the bits in the Capabilities PME_Support
  * and Control/Status PowerState fields in the Power Management capability.
-- 
2.43.0





Return-Path: <stable+bounces-155392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E3AE41CE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED62E189240A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E855324BC07;
	Mon, 23 Jun 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EPZkt37U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35452417C3;
	Mon, 23 Jun 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684307; cv=none; b=MDQ3vlqzv4LbWcvq4WcxP0gVcWo4BQzkvBiYID/RNt4NvZGHVgGWf9asXU+kWlIN2Y+XoQWADg+bda7TpWPcev4MebMj4CaXJfZbVapQ+aihpgHyAAet/6nU1ARXA3TDHPjl6IEFKfxCJgmyD7bgb0CUaBhT515Ths9ZOlKfJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684307; c=relaxed/simple;
	bh=wh/9BaQQaY+us2ZasgmhdCTFbCvBkS9KO8AYZrVll+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/J8u5iXRanSiR8lQAozBmgjlFgb22PzKK7i8rxNNyBbtyM9/ErCIfGmPMJyVg+sUmAiMYsiNQ2mir7ju+WxKCBaIPk6R4mKY/Egbz7RMo5mv2reryB5UKKJsfsNa1Ra+pwLSmmvc8VATlBMFztOtYN4gN8/fv42fk9I/LLNph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EPZkt37U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F68C4CEEA;
	Mon, 23 Jun 2025 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684307;
	bh=wh/9BaQQaY+us2ZasgmhdCTFbCvBkS9KO8AYZrVll+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPZkt37UAb3qM0V17j/QaaU9CsjL85tKlgxYD9YSKqn6zvZdBiA4HznF8wCygy6s2
	 BrG41jwZE2c8HWckAcKYxoinIeaBZeSS67CfvcZOnrvxoD8E+cgqbmUINsrlGiMAu2
	 2UgKzOl+H6oXFxrXYBs84KmCUMzDy+WaEt3F0kqk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gautam Menghani <gautam@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 6.15 019/592] powerpc/pseries/msi: Avoid reading PCI device registers in reduced power states
Date: Mon, 23 Jun 2025 14:59:37 +0200
Message-ID: <20250623130700.685244358@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gautam Menghani <gautam@linux.ibm.com>

commit 9cc0eafd28c7faef300822992bb08d79cab2a36c upstream.

When a system is being suspended to RAM, the PCI devices are also
suspended and the PPC code ends up calling pseries_msi_compose_msg() and
this triggers the BUG_ON() in __pci_read_msi_msg() because the device at
this point is in reduced power state. In reduced power state, the memory
mapped registers of the PCI device are not accessible.

To replicate the bug:
1. Make sure deep sleep is selected
	# cat /sys/power/mem_sleep
	s2idle [deep]

2. Make sure console is not suspended (so that dmesg logs are visible)
	echo N > /sys/module/printk/parameters/console_suspend

3. Suspend the system
	echo mem > /sys/power/state

To fix this behaviour, read the cached msi message of the device when the
device is not in PCI_D0 power state instead of touching the hardware.

Fixes: a5f3d2c17b07 ("powerpc/pseries/pci: Add MSI domains")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250305090237.294633-1-gautam@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/msi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -525,7 +525,12 @@ static struct msi_domain_info pseries_ms
 
 static void pseries_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	__pci_read_msi_msg(irq_data_get_msi_desc(data), msg);
+	struct pci_dev *dev = msi_desc_to_pci_dev(irq_data_get_msi_desc(data));
+
+	if (dev->current_state == PCI_D0)
+		__pci_read_msi_msg(irq_data_get_msi_desc(data), msg);
+	else
+		get_cached_msi_msg(data->irq, msg);
 }
 
 static struct irq_chip pseries_msi_irq_chip = {




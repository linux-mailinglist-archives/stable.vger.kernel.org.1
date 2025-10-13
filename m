Return-Path: <stable+bounces-184163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B50FBD20AB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6C244EE481
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB122F28EE;
	Mon, 13 Oct 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZ2Mrr0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633052F3627
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343929; cv=none; b=BL3KfWzN0h8KF/QLz8nSKKrLJQT7s4rkH8u1MoNGne97w/HZSa7O5IBBevcfwlC0ZkyqetnlcSSz1gONam/5OZv4k+mmHikBuRKuYS1PFNlan8TnNJoDJAyFebioVH6/In+81g1wUQ1CK9hO/Kr88OceMqRXms2QTLS7B1nMPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343929; c=relaxed/simple;
	bh=oCOMdSV5v2svCNF3k3RU1i9NDielQLSAQRhhhu81yy0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SIys3Z3+tlmwLNZGFni/msMJGoRYI8SKF/HAtL+l8BpgITaXuuf/HlTIBJP7NHLQXxwhppXkp1xwtdfphd32x6VGBn7R+ATCSEJrleOzcVw2I19by74tJjFlzKOriFRH92lCZwBnTSxNzK0qUZto8YOB522dd8Phgb+iqWAorbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZ2Mrr0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D36C4CEFE;
	Mon, 13 Oct 2025 08:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343928;
	bh=oCOMdSV5v2svCNF3k3RU1i9NDielQLSAQRhhhu81yy0=;
	h=Subject:To:Cc:From:Date:From;
	b=WZ2Mrr0l/IHEN9Nyg0hV6PohVJxbvOtPbDR8bMbJkUWpAEfurs5XcSgsOZ85XZ4t3
	 6ygysYWTRPLagj/nxXZ9CyDR/PTBBjbfAFqcDUOP6ZCLq5doaK8kbHdM1nlyiemAaD
	 XtJnbiB/d16FxBszNGS9bh+dkpZcCXz1U/SQuUII=
Subject: FAILED: patch "[PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read" failed to apply to 5.10-stable tree
To: hansg@kernel.org,andy@kernel.org,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:25:16 +0200
Message-ID: <2025101315-glue-daylight-739b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101315-glue-daylight-739b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hansg@kernel.org>
Date: Mon, 4 Aug 2025 15:32:40 +0200
Subject: [PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read
 regmap_config flag

Testing has shown that reading multiple registers at once (for 10-bit
ADC values) does not work. Set the use_single_read regmap_config flag
to make regmap split these for us.

This should fix temperature opregion accesses done by
drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
the upcoming drivers for the ADC and battery MFD cells.

Fixes: 6bac0606fdba ("mfd: Add support for Cherry Trail Dollar Cove TI PMIC")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Link: https://lore.kernel.org/r/20250804133240.312383-1-hansg@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 4c1a68c9f575..6daf33e07ea0 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -82,6 +82,8 @@ static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
+	/* The hardware does not support reading multiple registers at once */
+	.use_single_read = true,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {



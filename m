Return-Path: <stable+bounces-184160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99581BD2093
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592313BF7A0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58F2F28EE;
	Mon, 13 Oct 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sli/IpRc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE322F2902
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343920; cv=none; b=EDQ0rpNiQvo73/6WnR1n7WH+1uX6xAlxQAksfOYpftNf3jcLhSSTTGllVPDKrNPBt/jDsSDUeF615scAYj1JRB+5Cy7G4TdyT8SRA7i0AeXc2cTwrpe7bcY9AeBG5/44S9PlPl6nLNq+6zGKGrVpaG+qiH8cmHsL0B4H5crkCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343920; c=relaxed/simple;
	bh=5NjbpB/1bCxAQ+Dkp0GWtB308s9RN97vKw226cypbt8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AuMWjA2qizM2AYcmIPi3fAe9rtnPFsLG9k5mFiO3GRyMhAl1xqTvk7fizCwL9khCNI+7DrraeWSI4/7IiEnvy4cofxDhoSteCxWsRdRc0mP34BQSA9IIhSIkhR8jrdGuKtly4HLbVsMti8PN6cX2bKseDtBb0EE9KEJUD+wpg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sli/IpRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5A6C4CEE7;
	Mon, 13 Oct 2025 08:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343919;
	bh=5NjbpB/1bCxAQ+Dkp0GWtB308s9RN97vKw226cypbt8=;
	h=Subject:To:Cc:From:Date:From;
	b=sli/IpRcnz2fCMtWGtChX53yTm/sVd6tZzGU1yzmendLgDwVc1hoUPqcldVBoe97p
	 v0JJIi6cHHmJCnm0MRnDDImtmo+dWyBOMHLDcQK4fzUqLcsLxLtrwa0j6goOl4Z2ii
	 csdHkh06PcmcOGgXzmaaO7i5BZY8amhiezjpNk20=
Subject: FAILED: patch "[PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read" failed to apply to 6.1-stable tree
To: hansg@kernel.org,andy@kernel.org,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:25:07 +0200
Message-ID: <2025101307-little-reseal-5a13@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101307-little-reseal-5a13@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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



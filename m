Return-Path: <stable+bounces-184158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858CABD208D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400F73BF2E3
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EB2F2610;
	Mon, 13 Oct 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iCscSOhQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1C2C11E5
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343908; cv=none; b=fzc3Q3WMVVcw82C2iQEKOhS/kIDeOE8FKjO7fTEHex3sjsKSu1WvI+aecxbM1GfhKpxY45qPpnyekJ5vn7zPIxj8FK1A9yAQPEBGxNOat325Vv4fZv+SArvBn6Q5klvmZQ4qKzd3IJqs8Wwku1D8KPCFEyK1lik79xC3ZPGOxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343908; c=relaxed/simple;
	bh=JPLQfnzpEYZy1T/BXYCxWbj0LI8bVuKn43WKe2uAQZ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cqv4rIB29TOTVWRI9z6l02ZwiUDoLRIYlgVWyOCm6grLLXiP2lPWwFjBGyTF/MjMJ93Ud4pXX9hHrdO+FO9vBMSwfFZpNy2iABEXbXUZ4Jf+UQ7tIpV5buUVsuUgUBDmR72Rgpkbd4sWYgRFbYSOHQVnkIZ4fDJKvcNjYS1UyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iCscSOhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B626FC4CEE7;
	Mon, 13 Oct 2025 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343908;
	bh=JPLQfnzpEYZy1T/BXYCxWbj0LI8bVuKn43WKe2uAQZ4=;
	h=Subject:To:Cc:From:Date:From;
	b=iCscSOhQCZOwlSWTW1sxcCq1voNcjBUucjgYU4Rt43eoTvKxTNLUnbmlAlJRxomVx
	 pdTouCIy2gFmn2hsxDw+Imo1h2je0Ejtt8Zso2dnfRHh6UXYaEck+21QhDh89dAro+
	 0AjqKlhMmD22k5tFqhyPfmDif2Q6v/8CztMDEniE=
Subject: FAILED: patch "[PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read" failed to apply to 6.12-stable tree
To: hansg@kernel.org,andy@kernel.org,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:25:05 +0200
Message-ID: <2025101305-cheek-copartner-c523@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101305-cheek-copartner-c523@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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



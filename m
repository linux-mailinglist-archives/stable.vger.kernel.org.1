Return-Path: <stable+bounces-184159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A221BD2090
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5343D3BF26E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A812F2610;
	Mon, 13 Oct 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uvMC+ylE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4A2C11E5
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343917; cv=none; b=NeR0+edXGHOQoXedfgD2KBfDZwQV8YE/cb6/wibFZFhquZfI6aRgpboZmkN2xhuQe8zFT1gMtfyEHSJyac8H2Dkf5yKlyN0Qe1cz+jmw8rvGL7NWMihTW5VZVS1jgwJr1Xts0VoB0RGBcFrx4qqXNjyNeHSz8qz7Gxm6wB2d3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343917; c=relaxed/simple;
	bh=yxRsnMrSId5UMezDHkg3p9y8/+W5L7xBQhFhpxWwwjk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U61lOaqgE6gh3eBhLAZhMEDpRkF89upbhAHloNTb9O9d5hJnTH383okarrmbWYlADDUZ2d9EHYst4AR5Q+H8GzwvFSfAPxBOD61jNpKC6LoCuggWLjMTQb2d7z2kTLib7AH396gJruyp0ZNCPGyNminiQU9MHhrBT2i+2uJyAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uvMC+ylE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AB0C4CEE7;
	Mon, 13 Oct 2025 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343917;
	bh=yxRsnMrSId5UMezDHkg3p9y8/+W5L7xBQhFhpxWwwjk=;
	h=Subject:To:Cc:From:Date:From;
	b=uvMC+ylEdvGRgGQB6TDR4zT5DELl5f2AEzqWbmKI1tU8LEYBn6CgxboEdS+oYiCNw
	 PSv8xwcdEokrH24JQF3qfP28k2FbtwI86k5X8AZbbQDLHtbV/TTi8D49QfCxTE2eFM
	 j+NBI8F4P4iiji8tjIzMnSPJIUxYwGkjoU9FDR3g=
Subject: FAILED: patch "[PATCH] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read" failed to apply to 6.6-stable tree
To: hansg@kernel.org,andy@kernel.org,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:25:06 +0200
Message-ID: <2025101306-cufflink-fidgeting-4c7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101306-cufflink-fidgeting-4c7b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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



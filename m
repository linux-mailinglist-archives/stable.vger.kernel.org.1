Return-Path: <stable+bounces-81234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F05D992815
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9221F23457
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AA818E059;
	Mon,  7 Oct 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SrsTZsBl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354681741E0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293277; cv=none; b=rWo4lynaaY5ooh7dL43Pveu/mt+TP7lqtrW0oJybkO3fEEZe0tX8a0oy+rnelo3ZpagT9Mh26vs89nEG5WDVtQ7Ul129rwPuEYQVqu24h586/cuW4AsKiJmPIkmMpaflnGCxUkc/T0pjBiDAePaDtqXN7i7ZE/AjgpGA/xpNd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293277; c=relaxed/simple;
	bh=uYAkcNJOPDh/fu+kJG+zjY68ftEBwKX6yuUWhgSmJsg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RlO6BSn2/t8pB8zvhisuqk8xDicXz2dMhFdVhfTnYohjoXIEjtc+Pg5YsF5zqinuZgOjf6LdM/ZKYZtbbYQtCLwe4iadYcg/pZfroBU4djgZaChKGyisTlp0AlGrItCFk6dgEwSZ0pCBGclSvRmZijIsJhCQYE8oNuxuRuwgZ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SrsTZsBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E2C4CEC6;
	Mon,  7 Oct 2024 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293277;
	bh=uYAkcNJOPDh/fu+kJG+zjY68ftEBwKX6yuUWhgSmJsg=;
	h=Subject:To:Cc:From:Date:From;
	b=SrsTZsBlOnyErqVGqgc5Pr6aAS+548jtrCiXBctsbS5klHUIxQ8AqkjU9VcDJS5B0
	 U5SKyJ1S6SEGoBWqfdY1+30a2o6f69e42QkvmIPP08IeIb9xcoMD59AV8GzPtyuj/6
	 Fr5+rsBKPkaZ1Xb0PR2fnN1uLJMWIbxRsdEUBQKw=
Subject: FAILED: patch "[PATCH] i2c: synquacer: Deal with optional PCLK correctly" failed to apply to 6.6-stable tree
To: ardb@kernel.org,andi.shyti@kernel.org,christophe.jaillet@wanadoo.fr
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:27:54 +0200
Message-ID: <2024100754-daylight-mountable-26f0@gregkh>
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
git cherry-pick -x f2990f8630531a99cad4dc5c44cb2a11ded42492
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100754-daylight-mountable-26f0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f2990f863053 ("i2c: synquacer: Deal with optional PCLK correctly")
e6722ea6b9ed ("i2c: synquacer: Remove a clk reference from struct synquacer_i2c")
55750148e559 ("i2c: synquacer: Fix an error handling path in synquacer_i2c_probe()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2990f8630531a99cad4dc5c44cb2a11ded42492 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 12:46:31 +0200
Subject: [PATCH] i2c: synquacer: Deal with optional PCLK correctly

ACPI boot does not provide clocks and regulators, but instead, provides
the PCLK rate directly, and enables the clock in firmware. So deal
gracefully with this.

Fixes: 55750148e559 ("i2c: synquacer: Fix an error handling path in synquacer_i2c_probe()")
Cc: stable@vger.kernel.org # v6.10+
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index 4eccbcd0fbfc..bbb9062669e4 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -550,12 +550,13 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "socionext,pclk-rate",
 				 &i2c->pclkrate);
 
-	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(pclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
 				     "failed to get and enable clock\n");
 
-	i2c->pclkrate = clk_get_rate(pclk);
+	if (pclk)
+		i2c->pclkrate = clk_get_rate(pclk);
 
 	if (i2c->pclkrate < SYNQUACER_I2C_MIN_CLK_RATE ||
 	    i2c->pclkrate > SYNQUACER_I2C_MAX_CLK_RATE)



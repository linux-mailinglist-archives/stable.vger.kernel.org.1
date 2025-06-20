Return-Path: <stable+bounces-154974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BBAE158F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3143E4A1246
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598623236F;
	Fri, 20 Jun 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ehqQTY6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7123371E
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407129; cv=none; b=D1cWmk9sI6tPe6pDTGnZjJKlrsa7EPUW5v6K7DmcYAD+eItuz1h1qphDk3h/IR3bSM84YhZclN4dPwKSwwKR+66QSYBZg3V1NtFn/aBr32CPkKRudqOBJVZ8XmV72hmswZ4xIHi9F/21WCdNCsJIwmeG5HWUxXL2j2uM73DGO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407129; c=relaxed/simple;
	bh=7H/z7VhR9BxaYgnigzFmlGxY1UaD4ad8x8J8CIUceks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MPz0WX8AXdare9v8ruDzrY6HsDh3wURhETWwPR9uxA09h66nz00d+ZlbDcQ5dBn7rqbc4SuIZfrauxcM5HtKy8CZTYvo12NxeNGT1SbUIouyh17fVh9ZMsIO1nTJOLbYbdk0oWt1TaCieaSgfJNivKij2qYz4t/mG5Hb97UnhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ehqQTY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B5C4CEE3;
	Fri, 20 Jun 2025 08:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750407129;
	bh=7H/z7VhR9BxaYgnigzFmlGxY1UaD4ad8x8J8CIUceks=;
	h=Subject:To:Cc:From:Date:From;
	b=1ehqQTY6OLJ4a2wFN4GBun/MIlqZ9e0PeBxuvGfn8zklFwEupZV4OAaGAi0x/8++s
	 qEYTcXL2BrHi9RbQtZuz64qANI729/g4hYhOcuguFKV8gR5AIoaqum8Lg5zOKwq9Jr
	 jbqEZscQNHciQTSTBpPzfANA3MZXjTwcN/oZFz7w=
Subject: FAILED: patch "[PATCH] ASoC: codecs: wcd9335: Fix missing free of regulator supplies" failed to apply to 6.15-stable tree
To: krzysztof.kozlowski@linaro.org,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:12:07 +0200
Message-ID: <2025062006-ocean-hypertext-39fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9079db287fc3e38e040b0edeb0a25770bb679c8e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062006-ocean-hypertext-39fb@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9079db287fc3e38e040b0edeb0a25770bb679c8e Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 May 2025 11:47:01 +0200
Subject: [PATCH] ASoC: codecs: wcd9335: Fix missing free of regulator supplies

Driver gets and enables all regulator supplies in probe path
(wcd9335_parse_dt() and wcd9335_power_on_reset()), but does not cleanup
in final error paths and in unbind (missing remove() callback).  This
leads to leaked memory and unbalanced regulator enable count during
probe errors or unbind.

Fix this by converting entire code into devm_regulator_bulk_get_enable()
which also greatly simplifies the code.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-1-0b8a2993b7d3@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 8ee4360aff92..5e19e813748d 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -332,7 +332,6 @@ struct wcd9335_codec {
 
 	int intr1;
 	struct gpio_desc *reset_gpio;
-	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 
 	unsigned int rx_port_value[WCD9335_RX_MAX];
 	unsigned int tx_port_value[WCD9335_TX_MAX];
@@ -355,6 +354,10 @@ struct wcd9335_irq {
 	char *name;
 };
 
+static const char * const wcd9335_supplies[] = {
+	"vdd-buck", "vdd-buck-sido", "vdd-tx", "vdd-rx", "vdd-io",
+};
+
 static const struct wcd9335_slim_ch wcd9335_tx_chs[WCD9335_TX_MAX] = {
 	WCD9335_SLIM_TX_CH(0),
 	WCD9335_SLIM_TX_CH(1),
@@ -4989,30 +4992,16 @@ static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 	if (IS_ERR(wcd->native_clk))
 		return dev_err_probe(dev, PTR_ERR(wcd->native_clk), "slimbus clock not found\n");
 
-	wcd->supplies[0].supply = "vdd-buck";
-	wcd->supplies[1].supply = "vdd-buck-sido";
-	wcd->supplies[2].supply = "vdd-tx";
-	wcd->supplies[3].supply = "vdd-rx";
-	wcd->supplies[4].supply = "vdd-io";
-
-	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(wcd9335_supplies),
+					     wcd9335_supplies);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get supplies\n");
+		return dev_err_probe(dev, ret, "Failed to get and enable supplies\n");
 
 	return 0;
 }
 
 static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
 {
-	struct device *dev = wcd->dev;
-	int ret;
-
-	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * For WCD9335, it takes about 600us for the Vout_A and
 	 * Vout_D to be ready after BUCK_SIDO is powered up.



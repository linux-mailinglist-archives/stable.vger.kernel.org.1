Return-Path: <stable+bounces-55089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623FE9154CC
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9347B1C235CA
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79C19DF8F;
	Mon, 24 Jun 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m26WLLA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C919EEC1
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247776; cv=none; b=rrJSy8kwDX28wZzVHBMsWNdnLMf7JTBbyDU2LgwEp7yffSW00cMAtxCQQjbg7e1UMacnfACAbo2wqjAtcz0BUH+THF5dPFQQksFHEM3aUpoouvO6Sp9CeQVfF0INooJsepW53sqmeIFoVjFFy+D8WlIoklMms5hSrjOyZlXwfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247776; c=relaxed/simple;
	bh=fNekQ5LjsZcdMXMnBJOOTufc8BjALnJMdBQ4ksuCsdQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jo1/8kbzJX3Naz6oTiKewJhxYU3A5AWZH8vWrPSTIE117JNhoKAo7XoDZk+1tW+oWeQeeHtKbuaPx0d2ryY8usI65Et8unbPf0eIeTjFtuN9b6WAsmVAWZKvc3hQKbXl8Iu5LQm4r6W3/7Jb4HMS+0LFxDT048vZJvIb4SQaHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m26WLLA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C044CC2BBFC;
	Mon, 24 Jun 2024 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247776;
	bh=fNekQ5LjsZcdMXMnBJOOTufc8BjALnJMdBQ4ksuCsdQ=;
	h=Subject:To:Cc:From:Date:From;
	b=m26WLLA+VObaEovFdfV051lg2atMAesszuTDO2qqX0Fld04tkekYWnxDdLBq6E+gG
	 crEzFxtgOx2Dw3Mpw74NQlSFvGe5Bow8pz3XBE2yEeTalyrYgE7YNjFy9V4Wi3bflf
	 T5mBvJpIyzvpU8Z7GiC0NXLFK/uEoS9oMZWUDRvA=
Subject: FAILED: patch "[PATCH] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz" failed to apply to 4.19-stable tree
To: ckeepax@opensource.cirrus.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:49:18 +0200
Message-ID: <2024062418-serotonin-immobile-a6f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 60980cf5b8c8cc9182e5e9dbb62cbfd345c54074
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062418-serotonin-immobile-a6f4@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60980cf5b8c8cc9182e5e9dbb62cbfd345c54074 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 7 Jun 2024 11:34:23 +0100
Subject: [PATCH] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz

Some internals of the cs35l56 can only support SPI speeds of up to
11MHz. Whilst some use-cases could support higher rates, keep things
simple by dropping the SPI speed down to this avoid any potential
issues.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240607103423.4159834-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 902a0734cc36..8b618ef0f711 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -54,7 +54,7 @@ static const struct software_node ampr = {
 
 static struct spi_board_info ampl_info = {
 	.modalias		= "cs35l56",
-	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.max_speed_hz		= 11 * HZ_PER_MHZ,
 	.chip_select		= 0,
 	.mode			= SPI_MODE_0,
 	.swnode			= &ampl,
@@ -62,7 +62,7 @@ static struct spi_board_info ampl_info = {
 
 static struct spi_board_info ampr_info = {
 	.modalias		= "cs35l56",
-	.max_speed_hz		= 20 * HZ_PER_MHZ,
+	.max_speed_hz		= 11 * HZ_PER_MHZ,
 	.chip_select		= 1,
 	.mode			= SPI_MODE_0,
 	.swnode			= &ampr,



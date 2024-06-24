Return-Path: <stable+bounces-55088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B99154CB
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6BD1C23500
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6938D19F46B;
	Mon, 24 Jun 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpw+tDK2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935E19F463
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247773; cv=none; b=uNWEwwl87LrP1msIUkjEw3pEQTMINRQNVmUpiKaxR+J+w6IN4yRXN9Y+GUyNueFIlsEQBKH6OXSeJkLTUYWLqLWfz3sAYvpqNbRmj6NbK7/JnJko+r8CnpSiVeN+7ZL2YUvZDX7+fMgrgWr3/W0WgN5VfnclNuSArrDz9CZN0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247773; c=relaxed/simple;
	bh=S4b3NCgqrhEjvrQzX0GacabtA3YPrpnhjD68ne6wKiw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XWWv4JahO2RKFueTTo4Nu4n+0OJKN0d3KLEXWVJihHzhCUpe+fP9SH37D92dF4TAcJ/MoD4NP8upBzjNgGB0Lt0zTxjQ+kKMG1UVvye3SoX2i71SxHcroPo7ufVsgl0lYWuymAxxUy8F9L5TdrpKFf3khK/8XZ9tEW+tkPKo/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpw+tDK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6318FC2BBFC;
	Mon, 24 Jun 2024 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247772;
	bh=S4b3NCgqrhEjvrQzX0GacabtA3YPrpnhjD68ne6wKiw=;
	h=Subject:To:Cc:From:Date:From;
	b=cpw+tDK2JqjwDzxxIW8dBJ1rjcZz8wDkHDGISTfaTroI9zJntgwT3TY3J2Dpk8Flq
	 NM21dPLf04CNa7A+XxgVqKS4wGZVKIxLykpobOO2ZS1bKBTKF6+V2Xi7cRvQovjWsU
	 aUsb9wZhO955XNhxhXIwlHGmEBusFZ99MxX9fBe8=
Subject: FAILED: patch "[PATCH] spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz" failed to apply to 5.4-stable tree
To: ckeepax@opensource.cirrus.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:49:18 +0200
Message-ID: <2024062417-scribing-deluge-54e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 60980cf5b8c8cc9182e5e9dbb62cbfd345c54074
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062417-scribing-deluge-54e8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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



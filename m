Return-Path: <stable+bounces-170463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07EB2A40D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822D07BA509
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5C31B13B;
	Mon, 18 Aug 2025 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AENqao5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380122765EA;
	Mon, 18 Aug 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522716; cv=none; b=N5dK4/h2NoD7myECIxNZEScFTHSGh+xsdgBNstie9URHCYoSsNaLoRbE/q5zaDz3tLe1+/UTxNRKg2ccIxgbxVeA1lMFodKfNaFmI0Cf7hhmI/6wHPc0Yuio8hS5BVb0A0jy134GoNoSfZKHr5vO5IHswDBQRO4rTmc2k0y88+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522716; c=relaxed/simple;
	bh=6q9EDRSroDxF+pTzBG4gFNQkoE4N5Mga27aLT+WgRhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmTNB2BDG8H2Olj8hiC+ZKvMX3OLEkeouaP5e4O1rDh52LkzhYN0UrUmebr3j9dAS3T1Ugzyo2NzZZ3ad9V+/AoWeBv2BEFr0eBcM2BFPs4aQQaIst/ThcgXl39jrKH1Xtn3taoYtflCVIZblDRD3jSm7VgOTFYMn3uu+fnrAMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AENqao5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51467C4CEEB;
	Mon, 18 Aug 2025 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522715;
	bh=6q9EDRSroDxF+pTzBG4gFNQkoE4N5Mga27aLT+WgRhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AENqao5ZwynGuoX9hFj6LDQHbtFJiXgyrohNCjvq1tXlodLdP3O19HLZ0lu+NHQTA
	 4im7YBNJouGqVPe0lh3qxIJvL/KG/8vZCdiHkVZ1wzI7mq/jFxN0JcywjhDvpjdIsE
	 AkVNG/PmHh3Pvk458TWDMnWpbp4bNTj3Cg5huZnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Meagan Lloyd <meaganlloyd@linux.microsoft.com>,
	Tyler Hicks <code@tyhicks.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 367/444] rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe
Date: Mon, 18 Aug 2025 14:46:33 +0200
Message-ID: <20250818124502.661037858@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>

[ Upstream commit 48458654659c9c2e149c211d86637f1592470da5 ]

In using CONFIG_RTC_HCTOSYS, rtc_hctosys() will sync the RTC time to the
kernel time as long as rtc_read_time() succeeds. In some power loss
situations, our supercapacitor-backed DS1342 RTC comes up with either an
unpredictable future time or the default 01/01/00 from the datasheet.
The oscillator stop flag (OSF) is set in these scenarios due to the
power loss and can be used to determine the validity of the RTC data.

Some chip types in the ds1307 driver already have OSF handling to
determine whether .read_time provides valid RTC data or returns -EINVAL.

This change removes the clear of the OSF in .probe as the OSF needs to
be preserved to expand the OSF handling to the ds1341 chip type (note
that DS1341 and DS1342 share a datasheet).

Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Reviewed-by: Tyler Hicks <code@tyhicks.com>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Link: https://lore.kernel.org/r/1749665656-30108-2-git-send-email-meaganlloyd@linux.microsoft.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-ds1307.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index c6d388bb4a19..1960d1bd851c 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1824,10 +1824,8 @@ static int ds1307_probe(struct i2c_client *client)
 		regmap_write(ds1307->regmap, DS1337_REG_CONTROL,
 			     regs[0]);
 
-		/* oscillator fault?  clear flag, and warn */
+		/* oscillator fault? warn */
 		if (regs[1] & DS1337_BIT_OSF) {
-			regmap_write(ds1307->regmap, DS1337_REG_STATUS,
-				     regs[1] & ~DS1337_BIT_OSF);
 			dev_warn(ds1307->dev, "SET TIME!\n");
 		}
 		break;
-- 
2.39.5





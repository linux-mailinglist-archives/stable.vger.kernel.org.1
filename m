Return-Path: <stable+bounces-95624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B2F9DA8ED
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 14:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF0A166691
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695C1FCF73;
	Wed, 27 Nov 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zverev.info header.i=@zverev.info header.b="YiSWOgu0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tXswiC2A"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BA1FCF71
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715097; cv=none; b=mzN5mZAnI+svXxX+lYI/rqQD8Yt6KOctfz4SsHHMM84O6ABs9F8z7dJVe2jexL+0kMJYriLGNKMw1JnEFInfhOlCM9cDF6IC0BYxOKuG1cFvjm6PFqkDOcd0JBMfJ+7fwaBqBfsEnBLiZOVowsNz541hHRqBsU2eGJMvTgp+5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715097; c=relaxed/simple;
	bh=5WdYc0EZKvJ6ZdyaZTUEOmFzFKuguRyVSbPcxbjeqFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0Y77QUbXv2/b6zYNaznvL0HQT52qDifXgCTuok1vKMs3Hgc3Kcchldr1WYWs1aaTd+QBNldatkFoZ9VSFb3L1LKGp+MP3pN0zO2uR8PEG3/RS++oFhb60lz4I8mgp73PuYcKaFXWX/qZEtYZVNUkkiODCyj4pRQymbu83SksZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zverev.info; spf=pass smtp.mailfrom=zverev.info; dkim=pass (2048-bit key) header.d=zverev.info header.i=@zverev.info header.b=YiSWOgu0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tXswiC2A; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zverev.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zverev.info
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 037A62540169;
	Wed, 27 Nov 2024 08:44:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 27 Nov 2024 08:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zverev.info; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1732715092; x=1732801492; bh=eMvQqOu65ubkIPIQ0fHOr
	cHndTZ4USrdwArs02/lQas=; b=YiSWOgu0xBggPpEvzrBhdohoNv0ccc1Bk4tAa
	HmFvJlp51Um0kLlzEU+73q3K5k0uPSF84FPAxkZZj93psJuKlqL2lrqmdtTSK3El
	K30Zjh0fdAZsND2s1n3TKObwcgvx3+V35nzNG4zfPDCH1317lzO/BgGuLKWCpfFb
	/1dtcDY0CxnTYsq9Id2DooC25o2LwsXWqKcPonvwXEdOwd8UjWD3DO1/nxUTLSZh
	ZF73wRnIBOKloEQVnZ8FxUK5IZWEmfOo/L/GiAvLRT/HeZZNj85ZbavBrHqOTqlC
	uo1OoEgRce3/Aq85HXcdbFYo/ftL9vCDym2uxg+B/uXZUJ8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732715092; x=1732801492; bh=eMvQqOu65ubkIPIQ0fHOrcHndTZ4USrdwAr
	s02/lQas=; b=tXswiC2AAH4rVlPrNGvDM3QjmiMEAJwmHemqMoPCEhfM1I6s09q
	YKLx0bgMDFOzqNY52oREC4/NKYlKjmj8/lmYf2geonjp7I4BAKB3cBnXdGY7HNSN
	fb9XstC10wRXwdAvGtebl9NEKmmY5K5fdcfUTiS6VEOH9hZ0/0AtPwlPlJGtWmnV
	fFvyqDuNyPXd7TxcnUSuUTEnrPa/1koFbFYNQUU1nuSXryLixkgdmPkYMS9aWCPE
	uiqW/pcM95vwR5WwYxdJNGfPO57aHLSq4wRm3CXc+6YGdSr6WVJwb6KzTVEAaneL
	OcQ+qFf1T8MaPYYKlQ+eRK8GaMQm3KUeFJg==
X-ME-Sender: <xms:VCJHZyUu5MS6wq1G5lIdaSWBaUBLtoVYevTzAYFZ-IGMlYhO-VAEVg>
    <xme:VCJHZ-n_rr5JtfRqwz3iKuQazY2aRCPrOt4RMeDEBZ6_ntzGJ__Kv6oPFFFRoSjw8
    i1FMm3O3iirFH9RSGI>
X-ME-Received: <xmr:VCJHZ2akmlpe4Mz5cPfBZUhaOIXEQ1uIpU_iRgKn_KfSB4cSe-7e00AqrWMcBC5fCc6hOnYREgWfRMw_9ITU18fnfu0unYBbURAPhCMUKHv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgggfestdekredtredttdenucfhrhhomhepkfhlhigrucgkvhgvrhgvvhcuoehilhih
    rgesiihvvghrvghvrdhinhhfoheqnecuggftrfgrthhtvghrnhepuddtfefgudelhedtle
    dugeegieeujeelhfejleefheettdfgueffieduuedvudejnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehilhihrgesiihvvghrvghvrdhinhhfohdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepihhlhigrseiivhgvrhgvvhdrihhnfhhopdhrtghpthhtohepshht
    rggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VCJHZ5UPd8oFai2BUkjH8_kJXjIy0AOcKeJRQceMrUrK6Kj12rY6gQ>
    <xmx:VCJHZ8lEUfxA9wJWgBAqxswKI0ottGwrw_kj6qzG3ZSsIOJz6WI54w>
    <xmx:VCJHZ-d7mariATMwXx3-6C40vBTheOqUMAKm5v3TU30cAj8qjAPMMg>
    <xmx:VCJHZ-HcPIZ2Q18Ri6NzkOhHuw2GdS6NO3ja7Zr8A3z-afHw-jf9UA>
    <xmx:VCJHZ2jXyJgUC4v9b-mc3LGjWMpFvDOcnwjhvUNN_bqaYQHj1COKz0Dg>
Feedback-ID: i72894769:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 08:44:51 -0500 (EST)
From: Ilya Zverev <ilya@zverev.info>
To: Mark Brown <broonie@kernel.org>
Cc: Ilya Zverev <ilya@zverev.info>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add a quirk for microfone on Lenovo ThinkPad P14s Gen 5 21MES00B00
Date: Wed, 27 Nov 2024 15:44:20 +0200
Message-ID: <20241127134420.14471-1-ilya@zverev.info>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New ThinkPads need new quirk entries. Ilya has tested this one.
Laptop product id is 21MES00B00, though the shorthand 21ME works.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219533
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Zverev <ilya@zverev.info>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index facd82f0f251..e38c5885dadf 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21M5"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.47.0



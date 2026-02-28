Return-Path: <stable+bounces-220517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ki2JptMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:14:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D181C812F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7654324D917
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B33CC1DD;
	Sat, 28 Feb 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgisCwzc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1443CC1D7;
	Sat, 28 Feb 2026 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300401; cv=none; b=DRoQS83rkSktDp+4VYx55k8TqOQIfpzvtN0Q+ONlKZKXBcJP+cjz5NQ8em0MvwP/dqpx8I7xhhzdUqf2xv1Hf5mYeKTOnUp+r+ob6P/S9k55GDrTqZaBkhMCXx7H51tibTFNOc9y3Vu7zA84vq8hKTEjAuN02pg4u134OcKA2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300401; c=relaxed/simple;
	bh=C7Bf/4SETKQRpPhhtzMAKhHgf2oEI1fWMYv2QqDhegk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2scCRdnRsCnmeQJPDDFBi4l1FdD/AeLZAw5pNxDAu/BQy46y52CqQdgeg7ByQ1vuB8QaPdCmTUOWE/vEBwXbXFGCk4CKeKgnxuYcX9v3oMeXGFwNaBw4vOJFUk5Amla6AAVGaMqCq+uj3MY4j0f2tkHWIpq7ELoSzt9uJTqaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgisCwzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D947C19423;
	Sat, 28 Feb 2026 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300400;
	bh=C7Bf/4SETKQRpPhhtzMAKhHgf2oEI1fWMYv2QqDhegk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgisCwzcMkONW7ttGsVx5qjhcte/q8Q5Vc7tI1TYrLGUMgWBPxvZgazdBYyFiGKPN
	 C6wekJzgfgRj0j4f5G9QDJ1t7Nl7USrM2Iba7/g8xnoSMt/DJVm8+NqHOUTCKUCEWc
	 E/PA7vJxps0Jmqh73r3x/MZ97Ig0zDiMvRkuthP/Z14GUfz11Fw3WSrGgTxBMS6xI6
	 x2pvcQI69Xg3HnieckWeWZU5o2JNjoVqVamcI96KAVVIV1dwfZAuQcU+GQ4dwdiEeJ
	 KS8YBVN1DxeAQsiOnLR7U/p5goATmYc8jaNweC9KMVodIKa5Eyh8we5IgOhxtPOknd
	 yhmzHZgq8NYsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 438/844] ASoC: amd: amd_sdw: add machine driver quirk for Lenovo models
Date: Sat, 28 Feb 2026 12:25:51 -0500
Message-ID: <20260228173244.1509663-439-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220517-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: E3D181C812F
X-Rspamd-Action: no action

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit 3acf517e1ae05ef66561b7a2782690387ce46e21 ]

This patch adds a quirk to include the codec amplifier function for Lenovo
models listed in the quirk table.

Note: In these models, the RT722 codec amplifier is excluded, and an
external amplifier is used instead.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20260218104734.3641481-3-Vijendar.Mukunda@amd.com
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index fae94b9edd5a3..4f92de33a71a0 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -95,6 +95,22 @@ static const struct dmi_system_id soc_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
 	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YW"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YX"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
 	{}
 };
 
-- 
2.51.0



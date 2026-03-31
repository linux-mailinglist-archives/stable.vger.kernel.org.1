Return-Path: <stable+bounces-232270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHMlA8X+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832836DD29
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE45A30A185A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AAB423A8E;
	Tue, 31 Mar 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z8D5sBSf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37F423A62;
	Tue, 31 Mar 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976315; cv=none; b=l+CbcjwjQwi6qSftBTRzaszkQeeqR46gmbkfyZ7tlqF9rlgpy8mNnwk14killbE4GWFETYVujGOAqg0HArI7prqB2qKOaCTcngwSOqXYgSWFNsy6K6R8zy6HKYPi7ew48uZ/JJLOaYTb7oZAJuOs7ywwnJL8vOrcRorvGnd577U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976315; c=relaxed/simple;
	bh=GZwTe5Ejmx/IPthteoitU5d1MsjcSKZtkM2Crq1AEQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=So3+whWBQKWa49SivVTRiGm4UP71sKp/FrcMSW9/WRAMVDGDlPEbIFfOcxjnIeMPtBjV0JSjJJgx+G73p5CK4PZ00D8sY6SatixkgZE/2sIylzUC1AcrBxeG08FR2zuufZFeoaKqulHzcW5mJtLHxyty4Tevjtxpcu240mg5RQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z8D5sBSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6264BC19423;
	Tue, 31 Mar 2026 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976315;
	bh=GZwTe5Ejmx/IPthteoitU5d1MsjcSKZtkM2Crq1AEQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8D5sBSf7mJzlxC8ejIVGi/z+PQIcMR0hCnmHD0XkLHJQqd6/sXOZ30+wArNIuPga
	 KCEdaejXAtrjIb/uFdfwz0Xi+/som4X4kobUWvxYU5liJ/e48bOX3yvDGI+yVhPAfT
	 WMgOVbCGnE9PRokIMPG2xhgOTW1vnnyht7+QcZkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sheetal <sheetal@nvidia.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 045/309] ALSA: hda/hdmi: Add Tegra238 HDA codec device ID
Date: Tue, 31 Mar 2026 18:19:08 +0200
Message-ID: <20260331161755.143938872@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232270-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 8832836DD29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sheetal <sheetal@nvidia.com>

[ Upstream commit 5f4338e5633dc034a81000b2516a78cfb51c601d ]

Add Tegra238 HDA codec device in hda_device_id list.

Signed-off-by: Sheetal <sheetal@nvidia.com>
Link: https://patch.msgid.link/20260302084217.3135982-1-sheetal@nvidia.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/hdmi/tegrahdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/hdmi/tegrahdmi.c b/sound/hda/codecs/hdmi/tegrahdmi.c
index 5f6fe31aa2028..ebb6410a48313 100644
--- a/sound/hda/codecs/hdmi/tegrahdmi.c
+++ b/sound/hda/codecs/hdmi/tegrahdmi.c
@@ -299,6 +299,7 @@ static const struct hda_device_id snd_hda_id_tegrahdmi[] = {
 	HDA_CODEC_ID_MODEL(0x10de002f, "Tegra194 HDMI/DP2",	MODEL_TEGRA),
 	HDA_CODEC_ID_MODEL(0x10de0030, "Tegra194 HDMI/DP3",	MODEL_TEGRA),
 	HDA_CODEC_ID_MODEL(0x10de0031, "Tegra234 HDMI/DP",	MODEL_TEGRA234),
+	HDA_CODEC_ID_MODEL(0x10de0032, "Tegra238 HDMI/DP",	MODEL_TEGRA234),
 	HDA_CODEC_ID_MODEL(0x10de0033, "SoC 33 HDMI/DP",	MODEL_TEGRA234),
 	HDA_CODEC_ID_MODEL(0x10de0034, "Tegra264 HDMI/DP",	MODEL_TEGRA234),
 	HDA_CODEC_ID_MODEL(0x10de0035, "SoC 35 HDMI/DP",	MODEL_TEGRA234),
-- 
2.51.0





Return-Path: <stable+bounces-231684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J1FDMf5y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A55D636D08C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 916C231E996B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC2F423A8C;
	Tue, 31 Mar 2026 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0dpL7KEP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C73DFC7D;
	Tue, 31 Mar 2026 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974801; cv=none; b=Fp9Gj0KuOy3404lwyot+W7jpmsp81yeXa3A0e9sxBDw/yxDHEcVcrIyEcFUWbMIWMNtnsCqi3vjDRgE1xQxZ53BioI3XqlIUK71NK2tmnDNd/k9UKYwtJt18/llgWoQ4YM5dHLaNiMo5Ny0nIZKeAF2tvl9DzSIws1Wt+hbTQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974801; c=relaxed/simple;
	bh=Chq0f2wDBboWZqE8da9AZnKqyrM0+0qUav4d2PyJwvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQTi/Lqib3Gd5xWOenAxt1VwRyZ1oH7gmW2wU7AwdGbGvRmAlgSFFoi6x3Se/LMBGHKqSN7dsyXXuk5C1n3+QaxFna2at1Kb2431lj5m5zxA/l1uRNNAOIbum2QeQcUkHK/hJ/wDdJhYQRXifwTxNZaxUiXDSUdaxCoceCvNXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0dpL7KEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A47CC19423;
	Tue, 31 Mar 2026 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974801;
	bh=Chq0f2wDBboWZqE8da9AZnKqyrM0+0qUav4d2PyJwvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0dpL7KEP1hJJGmM78UgK1IEnhXpn7y2BiJ/JgQcjH0Bi886sxguUJRpKDktn1z/Rf
	 aAVkw5ASoAW+5xbZy4H3a1jTgxMvHjIedSi0G6e6/esTkB7X2vamOFwpNHHtF/q/Zu
	 dqYaOt5D8c6bBxGZF/iw77yeovGz5sLxmRyOA1XE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuming Fan <shumingf@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 048/342] ASoC: rt1321: fix DMIC ch2/3 mask issue
Date: Tue, 31 Mar 2026 18:18:01 +0200
Message-ID: <20260331161800.667509754@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231684-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A55D636D08C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 986841dcad257615a6e3f89231bb38e1f3506b77 ]

This patch fixed the DMIC ch2/3 mask missing problem.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://patch.msgid.link/20260225091210.3648905-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt1320-sdw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index e6142645b9038..4d09dd06f2d83 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -1455,7 +1455,7 @@ static int rt1320_sdw_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_port_config port_config;
 	struct sdw_port_config dmic_port_config[2];
 	struct sdw_stream_runtime *sdw_stream;
-	int retval;
+	int retval, num_channels;
 	unsigned int sampling_rate;
 
 	dev_dbg(dai->dev, "%s %s", __func__, dai->name);
@@ -1487,7 +1487,8 @@ static int rt1320_sdw_hw_params(struct snd_pcm_substream *substream,
 				dmic_port_config[1].num = 10;
 				break;
 			case RT1321_DEV_ID:
-				dmic_port_config[0].ch_mask = BIT(0) | BIT(1);
+				num_channels = params_channels(params);
+				dmic_port_config[0].ch_mask = GENMASK(num_channels - 1, 0);
 				dmic_port_config[0].num = 8;
 				break;
 			default:
-- 
2.51.0





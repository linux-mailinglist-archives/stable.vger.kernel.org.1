Return-Path: <stable+bounces-232413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGssCXoAzGkoNQYAu9opvQ
	(envelope-from <stable+bounces-232413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4B36E299
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86F75304C52D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5873002A9;
	Tue, 31 Mar 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EXvFzi2f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C72F5491;
	Tue, 31 Mar 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976683; cv=none; b=RjEpoHSL63bWAhqbOCBmOhJV2d2mpN688VpXrPdJ9snQnJO8m0wr4E+TucxsmnDSaco70TMrHChIzvAbCvB77raJBBiqmWW72ynUoafV5sBZZKsNyzcPTPl0NoG57oBIFfaE2+SbKbFDxyWRe16QY7poclAnIj6VwmZMPCeiG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976683; c=relaxed/simple;
	bh=ffMZCVhu/fl9RRmUsKa+BMNiys2VhxoTDE9ACYWyAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVpnBs3PNad9n8mC7HNh9wmo9F5hbKCIxkBC5TTJiLqUcjYpfvmYkAWTqLhye4PwcjAX8B6i4em+lcj7oeVj0auKGmgX+yY14X8aYuKMQ3eYy/j8GrnqatfFu42NclnPeLMubf2ZAvDlDcjoueitlGlHgFLWtb9bNnkDaDrkmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EXvFzi2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96716C19423;
	Tue, 31 Mar 2026 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976682;
	bh=ffMZCVhu/fl9RRmUsKa+BMNiys2VhxoTDE9ACYWyAws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXvFzi2fLuT/WYfhKSeX78xM5yspyedht2RR0An4nsQWKQvj4GsQHqHGX673I44oB
	 utg5+bwmD9qOgeZoTF2dSy9PB7y+moaWaYcuPewDLQzvnjlhQ20bxBKnB+Hp44t1f9
	 +Y5xE+T2cmoQ/FxeLMfxh2HCU2gyLUbbjnz5DDAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Joel Selvaraj <foss@joelselvaraj.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 187/309] ASoC: codecs: wcd934x: fix typo in dt parsing
Date: Tue, 31 Mar 2026 18:21:30 +0200
Message-ID: <20260331161800.342148919@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232413-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,joelselvaraj.com:email]
X-Rspamd-Queue-Id: E3B4B36E299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

commit cfb385a8dc88d86a805a5682eaa68f59fa5c0ec3 upstream.

Looks like we ended up with a typo during device tree data parsing
as part of 4f16b6351bbff ("ASoC: codecs: wcd: add common helper for wcd
codecs") patch.
 This will result in not parsing the device tree data and results in
zero mic bias values.

Fix this by calling wcd_dt_parse_micbias_info instead of
wcd_dt_parse_mbhc_data.

Fixes: 4f16b6351bbff ("ASoC: codecs: wcd: add common helper for wcd codecs")
Cc: Stable@vger.kernel.org
Reported-by: Joel Selvaraj <foss@joelselvaraj.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260323231748.2217967-1-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index c8db33f78a1b..bc41a1466c70 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2172,7 +2172,7 @@ static int wcd934x_init_dmic(struct snd_soc_component *comp)
 	u32 def_dmic_rate, dmic_clk_drv;
 	int ret;
 
-	ret = wcd_dt_parse_mbhc_data(comp->dev, &wcd->mbhc_cfg);
+	ret = wcd_dt_parse_micbias_info(&wcd->common);
 	if (ret)
 		return ret;
 
-- 
2.53.0





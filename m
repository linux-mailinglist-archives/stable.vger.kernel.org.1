Return-Path: <stable+bounces-245998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNaWDQBqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:57:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392B52654D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 147AA30DA0AC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32183BB111;
	Tue, 12 May 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D/GtdrIw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471E3955C1;
	Tue, 12 May 2026 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608095; cv=none; b=K6oaodP4Q/Svwdidx2TuPaToQ8R2Q+ifrDArull9x/52yhEr6an8O4Yb7wfWhLOgx9SfpQA3QqfmZexTyLKn+9+gpxdnFLrKLa7DbIR0lErd9HcXkxsbS2is4hVk2p5LwgD5uOvAu3igcO+4GWTrdJ/+oAo2xHTybcTT9/UMbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608095; c=relaxed/simple;
	bh=XIj1d5rDWzcMVsa8NAG1/UatcRjwQK6ZFrC0RSxHx7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PseVfPpSIQR/Rg1qI+CLC6pGDDADzm0EZBcNY+taQuTnrkJg3s+5UgRTSqrcg8QPdVNp2Ni2f4REQYaNo/NKatZx2XnAqgLH014jgrPYs34oo6munVE/m7uhTqEwB4vb9po1suOm4/t8f2QtF0vn+i8wjc9mKdau4RgeRqyNqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/GtdrIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D14C2BCB0;
	Tue, 12 May 2026 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608095;
	bh=XIj1d5rDWzcMVsa8NAG1/UatcRjwQK6ZFrC0RSxHx7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/GtdrIwKJYnmvl7UWuimvtvV6CzI7BOJ17KMWUGUMYP8EXHJXeUerA99qnFwjk7I
	 j/uzyoEoQ3J+s2U0OD+FAiW1sG7NqtrJp5qhThueYM7QOQJM7rkY5ImWr8wQYuFcQQ
	 7RwkVlETAfot/qZX2cmieZZ/NZw6CX83cOntws3A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 110/206] ASoC: Intel: bytcr_wm5102: Fix MCLK leak on platform_clock_control error
Date: Tue, 12 May 2026 19:39:22 +0200
Message-ID: <20260512173935.185682951@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9392B52654D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,oss.qualcomm.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245998-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit 13d30682e8dee191ac04e93642f0372a723e8b0c upstream.

If byt_wm5102_prepare_and_enable_pll1() fails in the
SND_SOC_DAPM_EVENT_ON() path, platform_clock_control() returns after
clk_prepare_enable(priv->mclk) without disabling the clock again.

This leaks an MCLK enable reference on failed power-up attempts. Add the
missing clk_disable_unprepare() on the error path, matching the unwind
used by the other Intel platform_clock_control() implementations.

Fixes: 9a87fc1e0619 ("ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260427-bytcr-wm5102-mclk-leak-v1-1-02b96d08e99c@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/boards/bytcr_wm5102.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/intel/boards/bytcr_wm5102.c
+++ b/sound/soc/intel/boards/bytcr_wm5102.c
@@ -171,6 +171,7 @@ static int platform_clock_control(struct
 		ret = byt_wm5102_prepare_and_enable_pll1(codec_dai, 48000);
 		if (ret) {
 			dev_err(card->dev, "Error setting codec sysclk: %d\n", ret);
+			clk_disable_unprepare(priv->mclk);
 			return ret;
 		}
 	} else {




Return-Path: <stable+bounces-215024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA9rGgzxiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3A11086C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C28B4308A846
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3C360741;
	Mon,  9 Feb 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o2Yd8A5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AE29D265;
	Mon,  9 Feb 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647419; cv=none; b=eq3E7YDC30zckW5he7+qQpq0eS4r7NdwAd16mRQF+JIl2z6+essg4dQDU8pJ/wkio8Lrki1CX/ZIEeqCONcidiTEagUFzjdtRsFCSQbE92aNq6iayazu+gMcpuN2IhHcs6TVcoS0egLHRyCCVmRBLRnld+rh4lJ3fYR+D2cDaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647419; c=relaxed/simple;
	bh=fs6uKhuBTtk3W8jIF8FkwSBsax7jCgdYwb9j6q5YMUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwmptjb+lzSAYJ5amvjHjs2kMFWZ4F2bYlQOnn1ka7s/VMTJRQVZc/HoHtVwJNhqVXjT+VYcPjA64Fh7gQwRBQsH651vpXXrhu52hHTnqPA6nY1eTiWKHOZBl8eKWnfRjhyDP2pbOxoS57RjflgZXscokoZnbDKO2wNqWZchiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o2Yd8A5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEB2C116C6;
	Mon,  9 Feb 2026 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647419;
	bh=fs6uKhuBTtk3W8jIF8FkwSBsax7jCgdYwb9j6q5YMUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2Yd8A5zJQ+ifgt1RQfuoSvSJNil401G4bkWN5QeLIhuhZYmq64SppsewAIxyKr20
	 dJz/QKDUugL72AWCPuwwbNSUMiR7MqfKETwbUWF5mg+Z0teXCfv+/6Y7+eqMnTVAhX
	 r/5PaQd05WWWOORBEhl9QXRcMPdWuyOhaDvICCio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kery Qi <qikeyu2017@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 087/175] ASoC: davinci-evm: Fix reference leak in davinci_evm_probe
Date: Mon,  9 Feb 2026 15:22:40 +0100
Message-ID: <20260209142323.564739282@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215024-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: BFC3A11086C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kery Qi <qikeyu2017@gmail.com>

[ Upstream commit 5b577d214fcc109707bcb77b4ae72a31cfd86798 ]

The davinci_evm_probe() function calls of_parse_phandle() to acquire
device nodes for "ti,audio-codec" and "ti,mcasp-controller". These
functions return device nodes with incremented reference counts.

However, in several error paths (e.g., when the second of_parse_phandle(),
snd_soc_of_parse_card_name(), or devm_snd_soc_register_card() fails),
the function returns directly without releasing the acquired nodes,
leading to reference leaks.

This patch adds an error handling path 'err_put' to properly release
the device nodes using of_node_put() and clean up the pointers when
an error occurs.

Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
Link: https://patch.msgid.link/20260107154836.1521-2-qikeyu2017@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/davinci-evm.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index 2a2f5bc95576e..a55a369ce71c2 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -193,27 +193,32 @@ static int davinci_evm_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	dai->cpus->of_node = of_parse_phandle(np, "ti,mcasp-controller", 0);
-	if (!dai->cpus->of_node)
-		return -EINVAL;
+	if (!dai->cpus->of_node) {
+		ret = -EINVAL;
+		goto err_put;
+	}
 
 	dai->platforms->of_node = dai->cpus->of_node;
 
 	evm_soc_card.dev = &pdev->dev;
 	ret = snd_soc_of_parse_card_name(&evm_soc_card, "ti,model");
 	if (ret)
-		return ret;
+		goto err_put;
 
 	mclk = devm_clk_get(&pdev->dev, "mclk");
 	if (PTR_ERR(mclk) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto err_put;
 	} else if (IS_ERR(mclk)) {
 		dev_dbg(&pdev->dev, "mclk not found.\n");
 		mclk = NULL;
 	}
 
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
+	if (!drvdata) {
+		ret = -ENOMEM;
+		goto err_put;
+	}
 
 	drvdata->mclk = mclk;
 
@@ -223,7 +228,8 @@ static int davinci_evm_probe(struct platform_device *pdev)
 		if (!drvdata->mclk) {
 			dev_err(&pdev->dev,
 				"No clock or clock rate defined.\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put;
 		}
 		drvdata->sysclk = clk_get_rate(drvdata->mclk);
 	} else if (drvdata->mclk) {
@@ -239,8 +245,25 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&evm_soc_card, drvdata);
 	ret = devm_snd_soc_register_card(&pdev->dev, &evm_soc_card);
 
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		goto err_put;
+	}
+
+	return ret;
+
+err_put:
+	dai->platforms->of_node = NULL;
+
+	if (dai->cpus->of_node) {
+		of_node_put(dai->cpus->of_node);
+		dai->cpus->of_node = NULL;
+	}
+
+	if (dai->codecs->of_node) {
+		of_node_put(dai->codecs->of_node);
+		dai->codecs->of_node = NULL;
+	}
 
 	return ret;
 }
-- 
2.51.0





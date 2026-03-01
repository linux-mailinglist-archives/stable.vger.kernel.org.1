Return-Path: <stable+bounces-221555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN8MHgqZo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FB1CB48F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E341307DB02
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8332BDC28;
	Sun,  1 Mar 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyEVW/RQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25028FFFB;
	Sun,  1 Mar 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328568; cv=none; b=PkGVSl3ZLjQ4NveCI/Xh0/JLIQgS0rsPE4XY3Lf+4hw9lT/ESBLqmvOPsssnS5cEjCObx/bKKt0YD27jqBml8Lktg6RoviVn6f6Webls55o0DHi60W7lasAoHNAoQKWMN2jvfSLkNZAKhmbe9yf41LveiWwQLLmG5iFNKUNugFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328568; c=relaxed/simple;
	bh=N1NtrNC9X60D/qxEzSnftgSHf7Jz63CmMQt2Ipg08Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Txhd1jxrLEHQerEcmfgtRNeUemX8wLAo4JOEFdqd5PpEYPwFh7x9S9bIh7UXWMM6Czf5eSOqRqPxciTSnSrDaUl3Th/E5/1tS0yz1drMfj5etomwBekV/zjHOIqq1rXHlQQvLGs0PhccpQLEKGBl3ZniJfPfYwY0uRylmxPdVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyEVW/RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564C7C19421;
	Sun,  1 Mar 2026 01:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328568;
	bh=N1NtrNC9X60D/qxEzSnftgSHf7Jz63CmMQt2Ipg08Vc=;
	h=From:To:Cc:Subject:Date:From;
	b=RyEVW/RQxZWVCOQoDOYv1E/pthZHIf3hUBipT2orcPs4pM207zXw1COl6okqz0o5h
	 2Z7cPtTq6Cr1c6uMf0TkUBLqWrdNlvHg9C87XomN+Ai1dnkyoF3DjrxgjXKimSZ29f
	 +1x8O+fMMMniAkiaslTflG4bYdZ5oCVk9rzstuWoGgNyyS/UyKNCPufMZZ+mekXFA1
	 bea29+ROSoLV+bJjvYeoiBl500Z09IKBoYWtaeBIb5Cd+mAuhaqs5UWJJOpu+9y3RB
	 yQPLFFuZKAGrHZflFlp3hoNKvJlfkBMJPHZVVIkKtM+uKivQ3BnB27/869W1klfdKM
	 NeTwc6T3Kn+VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shengjiu.wang@nxp.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>, Junichi@web.codeaurora.org,
	Mihai@web.codeaurora.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: FAILED: Patch "ASoC: dt-bindings: asahi-kasei,ak5558: Fix the supply names" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:29:25 -0500
Message-ID: <20260301012926.1687194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.996];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221555-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D08FB1CB48F
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 80ca113671a005430207d351cb403c1637106212 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Thu, 12 Feb 2026 10:18:29 +0800
Subject: [PATCH] ASoC: dt-bindings: asahi-kasei,ak5558: Fix the supply names

In the original txt format binding document ak4458.txt, the supply names
are 'AVDD-supply', 'DVDD-supply', and they are also used in driver. But in
the commit converting to yaml format, they are changed to 'avdd-supply',
'dvdd-supply'. After search all the dts file, these names 'AVDD-supply',
'DVDD-supply', 'avdd-supply', 'dvdd-supply' are not used in any dts
file. So it is safe to fix the yaml binding document.

Fixes: 829d78e3ea32 ("ASoC: dt-bindings: ak5558: Convert to dtschema")
Cc: stable@vger.kernel.org
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260212021829.3244736-4-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/asahi-kasei,ak5558.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml
index 5c2f131c86c3f..18919d9112a3f 100644
--- a/Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak5558.yaml
@@ -19,10 +19,10 @@ properties:
   reg:
     maxItems: 1
 
-  avdd-supply:
+  AVDD-supply:
     description: A 1.8V supply that powers up the AVDD pin.
 
-  dvdd-supply:
+  DVDD-supply:
     description: A 1.2V supply that powers up the DVDD pin.
 
   reset-gpios:
-- 
2.51.0






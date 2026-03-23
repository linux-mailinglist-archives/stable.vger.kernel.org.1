Return-Path: <stable+bounces-228322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PeIA0JNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:25:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB9E2F46B3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44BE73211369
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081BA3B27D7;
	Mon, 23 Mar 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qkqPCT57"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1AF35F5E2;
	Mon, 23 Mar 2026 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274804; cv=none; b=A/IhmVukAcv+WlJ+HrrDNDkLldvHED6RYnldBmgGdA3XjDCrmZVp+/mzDI0HtW89WkRM67Egdrx1e3Q14mufmh+VGimCxAsqujywOjBLeGGoPYTsvgA0eYjXcod4kuPSkeC71yHjVl7Lh73sqaui6EOb6hnAQXCuje90Lm3JBpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274804; c=relaxed/simple;
	bh=l7M8njGFjBiqxjv8pBE5lZF6WThF9e8VczhzYxc19Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it6KjaxXbEfYjp29uEZUjqF9RB+kyXd8sXI3KEpHb33Ua3ekPo1rHowb4C2pVbxaX9z2cUzEWXntxA0P57Cri88fxTq2Hw3EKO7GpiotIO07gNEyW8RTaGrqeI9ZouHxvk3L9cbbZ9LyNFJwxFCKfTbLZ1/24SvYitmRwUC+tcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qkqPCT57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F43C4CEF7;
	Mon, 23 Mar 2026 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274804;
	bh=l7M8njGFjBiqxjv8pBE5lZF6WThF9e8VczhzYxc19Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkqPCT57q6t5IMUVvtpseyYClgXxL1tV9Ano6rEQVJ6c5eQ6X5AyzkfEOxNmR7u1T
	 zDLwYbtsi/8RL6fWdhHX2mxvukYtkkwx7G95On/Tp0ZdOuMIvY1fGrFOZ/N9SbazKW
	 NdcRJTqSNZo6unK6dUfkzSMu8HvjcGfo7X8l8aLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 113/212] arm64: dts: renesas: rzv2-evk-cn15-sd: Add ramp delay for SD0 regulator
Date: Mon, 23 Mar 2026 14:45:34 +0100
Message-ID: <20260323134507.343911786@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228322-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AEB9E2F46B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 5c03465ecf6a56b7b261df9594f0e10612f53a50 ]

Set an appropriate ramp delay for the SD0 I/O voltage regulator in the
CN15 SD overlay to make UHS-I voltage switching reliable during card
initialization.

This issue was observed on the RZ/V2H EVK, while the same UHS-I cards
worked on the RZ/V2N EVK without problems. Adding the ramp delay makes
the behavior consistent and avoids SD init timeouts.

Before this change SD0 could fail with:

    mmc0: error -110 whilst initialising SD card

With the delay in place UHS-I cards enumerate correctly:

    mmc0: new UHS-I speed SDR104 SDXC card at address aaaa
    mmcblk0: mmc0:aaaa SR64G 59.5 GiB
     mmcblk0: p1

Fixes: 3d6c2bc7629c8 ("arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and RZ/V2N EVKs")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260123225957.1007089-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
index 0af1e0a6c7f48..fc53c1aae3b52 100644
--- a/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
+++ b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
@@ -25,6 +25,7 @@
 		regulator-max-microvolt = <3300000>;
 		gpios-states = <0>;
 		states = <3300000 0>, <1800000 1>;
+		regulator-ramp-delay = <60>;
 	};
 };
 
-- 
2.51.0





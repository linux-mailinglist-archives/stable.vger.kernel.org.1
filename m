Return-Path: <stable+bounces-228092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFX4BjBJwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:07:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7030D2F3DCC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF5EB30D40AC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70AE3AD537;
	Mon, 23 Mar 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="im9zAfjw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892263AD539;
	Mon, 23 Mar 2026 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274100; cv=none; b=KTZwTBWUk98xM5LhHhdUWTlX3SsXa/1Ewfegvp+7grOKrSQDijHDaygUo00/MV+Ltiu1CfRdoBoPeDL/qm8k3HDg1DLXgNFDW1to8aAuhfvhvgwnRych01bLTgPQ6+PAve8N3Gk17cmptVKq20GhlNdy/nRpNBt0mNC6NYgySbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274100; c=relaxed/simple;
	bh=p1IcNIAt+2srlk3PtVVjA4CvpZwa7Q+k/5lDjhl/134=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCwNWbLgBrU/ICA0F5Ukzlfx5G8v4TT0OBPBiaB2NljJlv64/5MNtNlkNr+84bJ1b0YW1OJhTE6PZqP2GB+stbhUuV2RGDoJzrfQ0egDS6nHtqcjXixQf9U6yFO/8IVGOmv50cNhRw7gDStO38Rgyfxdp7XtGXtjGyBztwkFKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=im9zAfjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFE7C4CEF7;
	Mon, 23 Mar 2026 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274100;
	bh=p1IcNIAt+2srlk3PtVVjA4CvpZwa7Q+k/5lDjhl/134=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=im9zAfjw6qGIMDLXiLi3q8x2f7X51oLBykG+Iyp1bySv8Oiw00ecILC+rs9A4HCL2
	 wzeCfHAmAXzYSfcpTIt+OJXsrDzR85tx96gcyoiTy5KlANDF0Qmx/VYxQTCYxWhFk6
	 ikOm+B99RRH0V8qiAuKr3/xunOvKZGzZuD8R3NE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 108/220] arm64: dts: renesas: rzt2h-n2h-evk: Add ramp delay for SD0 card regulator
Date: Mon, 23 Mar 2026 14:44:45 +0100
Message-ID: <20260323134508.013048992@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228092-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,glider.be:email,msgid.link:url,renesas.com:email]
X-Rspamd-Queue-Id: 7030D2F3DCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit bb70589b67039e491dd60cf71272884e926a0f95 ]

Add a ramp delay of 60 uV/us to the vqmmc_sdhi0 voltage regulator to
fix UHS-I SD card detection failures.

Measurements on CN78 pin 4 showed the actual voltage ramp time to be
21.86ms when switching between 3.3V and 1.8V. A 25ms ramp delay has
been configured to provide adequate margin. The calculation is based
on the voltage delta of 1.5V (3.3V - 1.8V):
  1500000 uV / 60 uV/us = 25000 us (25ms)

Prior to this patch, UHS-I cards failed to initialize with:

    mmc0: error -110 whilst initialising SD card

After this patch, UHS-I cards are properly detected on SD0:

    mmc0: new UHS-I speed SDR104 SDXC card at address aaaa
    mmcblk0: mmc0:aaaa SR64G 59.5 GiB

Fixes: d065453e5ee09 ("arm64: dts: renesas: rzt2h-rzn2h-evk: Enable SD card slot")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260123225957.1007089-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 63bd91690b540..890e4ddc1e78b 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -53,6 +53,7 @@ vqmmc_sdhi0: regulator-vqmmc-sdhi0 {
 		regulator-max-microvolt = <3300000>;
 		gpios-states = <0>;
 		states = <3300000 0>, <1800000 1>;
+		regulator-ramp-delay = <60>;
 	};
 #endif
 
-- 
2.51.0





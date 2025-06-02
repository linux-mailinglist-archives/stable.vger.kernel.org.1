Return-Path: <stable+bounces-149067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDBACB027
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AAA188B305
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF1221299;
	Mon,  2 Jun 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxHQICvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743B1C5D72;
	Mon,  2 Jun 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872793; cv=none; b=fjgDKNcbvuL0spq4/rnAPAc+pXQ4vET9dlp3dISCOghDcwRvaWl/99vJZurIh99ycgxXdIAVP2smF8iH8IVsomlV4SVm1DV+xOjOvEvYehF7VlsNDhpvXwEy/OeQ5CQ8Wy7JYfP0+Adverv8/egFNExCNyc+oO5S1mk8pHrCwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872793; c=relaxed/simple;
	bh=EsofmpkbWBpGrsIMHHhVOCzNNHyGpHw9TNG80f9XPjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mswz6JMW1dwP9jfRVUD/HAVjUVko1fIsWW1m9vmMOvsmlRK6lbLexoMoh6w2LYvtx+FIOVveICDqKbJRMcL5AiEir1ROiFDVfGaGz14zT1wDXVjLOJy4P0RkVuoEAV61fjD0824/BFx4yipbcINDxM4vW/VX856uPMzMPjAe+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxHQICvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F266C4CEEE;
	Mon,  2 Jun 2025 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872792;
	bh=EsofmpkbWBpGrsIMHHhVOCzNNHyGpHw9TNG80f9XPjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RxHQICvvQ4Qyvy6FRT+v75bHzsbJz8oTQsztBEVI+LLVYuFJJgfPtmpBOg5TpTwKN
	 ZnZXmgzIBVh5yXs+bwcjQpt534UcmITr3ekJvu/6WB3NJCrJdu2GJ/TPthZZP+GAP9
	 lfnZNQrRehDZeOY95XGAHu59lL8kBjPXSngop308=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 6.14 40/73] arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix length of serdes_ln_ctrl
Date: Mon,  2 Jun 2025 15:47:26 +0200
Message-ID: <20250602134243.272787285@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
References: <20250602134241.673490006@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siddharth Vadapalli <s-vadapalli@ti.com>

commit 3b62bd1fde50d54cc59015e14869e6cc3d6899e0 upstream.

Commit under Fixes corrected the "mux-reg-masks" property but did not
update the "length" field of the "reg" property to account for the
newly added register offsets which extend the region. Fix this.

Fixes: 38e7f9092efb ("arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix serdes_ln_ctrl reg-masks")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20250423151612.48848-1-s-vadapalli@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -77,7 +77,7 @@
 
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
-			reg = <0x00004080 0x30>;
+			reg = <0x00004080 0x50>;
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
 					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */




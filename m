Return-Path: <stable+bounces-251598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CFMDHb2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C96AF59509D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 709CE30CC9CD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029B36405A;
	Wed, 20 May 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eeeBZIuk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E9369D67;
	Wed, 20 May 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298398; cv=none; b=I0jz9FPbMoGmY6rk3zMSWzg9K1smDMwxQM77nq2m+3DkRS4hPRqMUkR7xtu/9kB52SoUCwYKqka4VTx9FsdLQ0MTqMMU31Rdo8Pw42io0ceNkEaInipqnJ+w1NMvDLSp6irdcvVUDYB/ngfEdXli6V44M1qcTfRRb9uo2Qs4X9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298398; c=relaxed/simple;
	bh=7LW+12iJpall26cvqIJQWVf7zcYwDnZ9knM7mfu+EFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iF8b2t67P+csatsdpzgeU3Yl/3q81S/tSTqnGgwXhfcUflOfaEj/WuVTUS+8AGAdX3mQdUfOCgtuKXzhTfHM3kJUHjJg9yFSALOnXABTlFDnzRnA/mjx+WPsOG5KQDVdKos+fbNzRTsKOrFeiShnXlVT/DixrocConqXwYIMciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eeeBZIuk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2DD1F000E9;
	Wed, 20 May 2026 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298397;
	bh=S42fEUhpGnWk5gEXWepNX9tdZK9zzLgPUg8WqdJPvRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeeBZIukZzHOu5ZAtjZbMimEV/cEKmxrBuM0K8zYlb0eRfKQTpxn2EZmXx88+sN2z
	 cfj+w+RF+OIwvM2W6HmfvGW/f03IVsktLEdZ3oGHeEpHT6w46L1QoM+0FEI2o6p1hG
	 YEjT2LImTpwK2vpuyO1P4SCaNCRrXk/CjoHc9A/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 393/957] arm64: dts: rockchip: Add mphy reset to ufshc node
Date: Wed, 20 May 2026 18:14:36 +0200
Message-ID: <20260520162143.050644989@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251598-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,rock-chips.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,sntech.de:email,2a2d0000:email]
X-Rspamd-Queue-Id: C96AF59509D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 792c42da47fa199f90492784e3c57280acd57f22 ]

The mphy reset signal is used to reset the physical adapter. Resetting
other components while leaving the mphy unreset may occasionally prevent
the UFS controller from successfully linking up with the device.

This addresses an intermittent hardware bug where the UFS link fails to
establish under specific timing conditions with certain chips. While
difficult to reproduce initially, this issue was consistently observed in
downstream testing and requires explicit mphy reset control for full
stability.

Fixes: c75e5e010fef ("scsi: arm64: dts: rockchip: Add UFS support for RK3576 SoC")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/1773277913-29580-1-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 70e67d4dccb8a..5d69a81aecc64 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1829,8 +1829,9 @@ ufshc: ufshc@2a2d0000 {
 			pinctrl-0 = <&ufs_refclk &ufs_rstgpio>;
 			pinctrl-names = "default";
 			resets = <&cru SRST_A_UFS_BIU>, <&cru SRST_A_UFS_SYS>,
-				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>;
-			reset-names = "biu", "sys", "ufs", "grf";
+				 <&cru SRST_A_UFS>, <&cru SRST_P_UFS_GRF>,
+				 <&cru SRST_MPHY_INIT>;
+			reset-names = "biu", "sys", "ufs", "grf", "mphy";
 			reset-gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_LOW>;
 			status = "disabled";
 		};
-- 
2.53.0





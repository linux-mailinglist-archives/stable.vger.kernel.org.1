Return-Path: <stable+bounces-221388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKL3IUqWo2lPHgUAu9opvQ
	(envelope-from <stable+bounces-221388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0091CABC3
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C25B311533B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4D274B28;
	Sun,  1 Mar 2026 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4bhP5Go"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4D2BD0B;
	Sun,  1 Mar 2026 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328136; cv=none; b=P7zSGkC959gY6S6LBfALbIlRQQt5qybVNMpMpW1QY9nam0r6WpqAcwjTipizXMbjqlG/ooFdCKNoRcIyrbIl6A4yHpGIf3JSU7RjKaOt/RPHY+XXyZOPiteajNdaLBOU0rIJIVeY4IHcItxw52Og4nBVlgD3mw+TSS5BwgDYuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328136; c=relaxed/simple;
	bh=3k7OQsiVcaP5g+1HoaLmipVxH474h+K0lLE9htxoVXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTOc3hgQlnX9f4ylG0h5emFa9rZZG5n40eX/zwcCounHpzsNXMHbr+leAdCUNwwD2+orSx8HmDgdA3VJbHoa6K/qam7JO2LkGI+5WrmE0WU2VLkH6jkRBYBoRWrRnkDlNsT5dwGIlciLVrJD5lsSrSfXlcwXvGwweFmocXbgvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4bhP5Go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040D6C19421;
	Sun,  1 Mar 2026 01:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328135;
	bh=3k7OQsiVcaP5g+1HoaLmipVxH474h+K0lLE9htxoVXU=;
	h=From:To:Cc:Subject:Date:From;
	b=f4bhP5GoUTw4+CHfMm34iAXeBln9EGymb1Vqpb4dpxzeTDmGPRN/z2l4suQm2qFa2
	 DcpvZHHdQ2ZiP2FBIr1rHNcHSD7Cx9MjI9KnrnBz0XUfThNoCmIFaPVhOnMQqCdf9p
	 gf1SbV2hLd2RHXN7OB3J3WXJWedR1Z8WTdDWwz6bekKIzd9LFp9ArPscR7CMsqPDg5
	 UioKbQkDmpbb04Eei470Rz02OjXoLPo/LMiy2yj/ve6+pov/JvAw5/OGVBmdWrCIA4
	 TNsFXv2oPO3LmOKShAPxSR6qFb94s8xOKugpxXFV3bPe+5gTxaZMWCsz+Q6jQi1BhZ
	 XwBQDbiMU+7kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jerrysteve1101@gmail.com
Cc: Peter Robinson <pbrobinson@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "arm64: dts: rockchip: Do not enable hdmi_sound node on Pinebook Pro" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:22:13 -0500
Message-ID: <20260301012213.1678405-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,manjaro.org,sntech.de,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-221388-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,manjaro.org:email]
X-Rspamd-Queue-Id: CD0091CABC3
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b18247f9dab735c9c2d63823d28edc9011e7a1ad Mon Sep 17 00:00:00 2001
From: Jun Yan <jerrysteve1101@gmail.com>
Date: Fri, 16 Jan 2026 23:12:53 +0800
Subject: [PATCH] arm64: dts: rockchip: Do not enable hdmi_sound node on
 Pinebook Pro

Remove the redundant enabling of the hdmi_sound node in the Pinebook Pro
board dts file, because the HDMI output is unused on this device. [1][2]

This change also eliminates the following kernel log warning, which is
caused by the unenabled dependent node of hdmi_sound that ultimately
results in the node's probe failure:

  platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error

[1] https://files.pine64.org/doc/PinebookPro/pinebookpro_v2.1_mainboard_schematic.pdf
[2] https://files.pine64.org/doc/PinebookPro/pinebookpro_schematic_v21a_20220419.pdf

Cc: stable@vger.kernel.org
Fixes: 5a65505a69884 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Link: https://patch.msgid.link/20260116151253.9223-1-jerrysteve1101@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index eaaca08a76018..a6ac89567bafe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -421,10 +421,6 @@ &gpu {
 	status = "okay";
 };
 
-&hdmi_sound {
-	status = "okay";
-};
-
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-falling-time-ns = <4>;
-- 
2.51.0






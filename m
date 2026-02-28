Return-Path: <stable+bounces-220708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gADSOSJAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDAC1C6DFD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 414B93166A04
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CA3FB88B;
	Sat, 28 Feb 2026 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9WxMNdz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128353FB882;
	Sat, 28 Feb 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300588; cv=none; b=vFZIepjlH0RVDhBR68bdtjYL5kTlM8Jvw48scy8gMCEClphbzu22UxMUNjoX3/Nsbv3jTR7P1NO/JB30zTFL0X20ULz2adKpBmIGLcCbZKUXbmSplRDt3nil0q7l6NiIsA+1akRoFmcbbQjizMklf+0c1ClD9vSTN2whxcO8Xic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300588; c=relaxed/simple;
	bh=2/8CjZ2M6wqfVJPQsRKl2gNxsxkT7FkZ7s/j0wZ1C2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCMCMHf7Chf6dqG/Ib8f1o68UJSu0kaDWcFLRnRn8fiJT3esKqRNgN9dezbEoF7BUOJkfR0ia/XHpsHC4CCey8evolFKaNPbpl5VwZKO7FZrd8I2driKYkJaGJtuhciBnP+G8dlyK1r4ZijzsRupwlMUeqIYYO4RaVxL1hLGjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9WxMNdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01B8C19423;
	Sat, 28 Feb 2026 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300587;
	bh=2/8CjZ2M6wqfVJPQsRKl2gNxsxkT7FkZ7s/j0wZ1C2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9WxMNdzp1qkQIKjmiKIsF0piJE9+LQGsTbkommlsP8leF+SoWs3mKCV1UoiYtmez
	 CmkFePWjCWykcDpFrVQzJUMWUd1nF4nmDHKizo0R35qrNEAa8be4BTeZASwqqek2v6
	 /X3uJz4cQMFQq5XkpJ3N1KMt8R0XvIDpYlTvKD2gY/n9WpVYoKkkyQkp1U/DASdmU2
	 A4YpCm1yn/z2PSLjMcVx8/vzdLpuEgzE69i0HRZsVv9H4allHWjJszG+Q6bzEuW+Vc
	 IFe0fLJq2GFM8ISeZLfiG8uO3sv8aDQXHs3x55XmQstWeY0DLW0hG81OCo0NaPPgwM
	 IOIy00ABigDow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jun Yan <jerrysteve1101@gmail.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 629/844] arm64: dts: rockchip: Do not enable hdmi_sound node on Pinebook Pro
Date: Sat, 28 Feb 2026 12:29:02 -0500
Message-ID: <20260228173244.1509663-630-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,manjaro.org,sntech.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220708-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,manjaro.org:email,pine64.org:url]
X-Rspamd-Queue-Id: 8CDAC1C6DFD
X-Rspamd-Action: no action

From: Jun Yan <jerrysteve1101@gmail.com>

[ Upstream commit b18247f9dab735c9c2d63823d28edc9011e7a1ad ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 810ab6ff4e670..753d513449540 100644
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



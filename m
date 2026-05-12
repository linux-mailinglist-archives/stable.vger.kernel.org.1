Return-Path: <stable+bounces-245431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM4hFWDyAmrpywEAu9opvQ
	(envelope-from <stable+bounces-245431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:26:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6D151DA27
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28D85301372F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8FC379C52;
	Tue, 12 May 2026 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnYhAbS8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99B3B52E4
	for <stable@vger.kernel.org>; Tue, 12 May 2026 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577912; cv=none; b=amS+axlc4XaVUCYJ89foOgra/KO0vD9faKO+5CcmcSkFdvDgdt1/CAOerPJRHYS/CRG4fO2Xz/o42ZiDFK0JD/muZihI5anPPwSOusFD8SIOg337kbciBlvYEqHBI0PmafEnXe3l6HrzS9v+b8SPfBiOKmj+1+XHrFrKHsDci6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577912; c=relaxed/simple;
	bh=Te4JIbpLP2wsOEm0mgCN6GLdQddstzF2t9Hyh9Znah8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nfqniplrb2bJOqSm73ZoHIzPrK7A6rN2Y6YRn0ICGhX6NcxG0TxBozCmI0nJAzY7KkBM3sPZ4v1ZsRGt7z8xonGu5ThaAybtUBs2BNveKop3yDs7zDLncI2AsUAnuqwl1kd0pCUMQh3IZYt2PUgZAxhCsNqW8AKiXVI3kV+vgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnYhAbS8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso36463635e9.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778577909; x=1779182709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4BQTc4T1OOXSNZ2RCg5v8h0CYbT+t3RxhIuDD3tfTiA=;
        b=VnYhAbS8AsJ7oP6+Nook7+wh/J78mrFkUSTPQvLUAtuLGuftdYsMswR09vJdcpqELG
         a3lCpgADNclqKbgxL3DjbrLLjg2J/7sm1kd9Ahk24iUMG2UkgXprj3XBUfQIB8e46Scv
         fu6pRVUkO14jA3lL9kFFT/4B5rHitVhXDbdHnuqC7I/Q1VkfuOJJ1aE8jJ9nhXFaxCf3
         jemnMmBSHXILlRdp9rZtFJbCMJPwAAFdxhBzi0URH1fhGbAD0fmY80Tvu+I4TTt0NzqB
         OaZIpKOCyB8V0QOKrXK8crsYvY1LKTop+yRCwVG6RQZxbQ7DVMOc3xIqWL0quBv1rlGq
         z0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778577909; x=1779182709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BQTc4T1OOXSNZ2RCg5v8h0CYbT+t3RxhIuDD3tfTiA=;
        b=Ncsj8RdtoQZphrW1v8bDElkeau5+eGjQ6KmtKO9n3X5ZdNypFkuSJpkC2e5fjc8mYx
         Yymx+zW/vC6xEgvnVIO6+3UqCay30hg2RN2lU5UCX+ET7QukoaUQch1crRSoRV06wF5x
         pYaFurFt7YyTzp7wvUEMyRf50MYYE8XeD0BRu5kyZ2rGlxp9ysYA75od0a7HzgaeBXUf
         Kwigx2WtOAfxZEoALg/RDFcNc4AjVNGEfjzpeSffae7CWeGzeK0sGkAZ3VPSKazkMi4P
         vNnqpZmGQl+TRkcLvcEXkVeVwc1NiHGxBilwcvINfDasd0iPzz+ZhFv2drEKPRv7NZFX
         gyuQ==
X-Gm-Message-State: AOJu0YyBVx6whV/gs8BvCpCgwebD6Uw+pLz3pzniTd92snLydR3quCiU
	4Hgdl8Oqj33Az53VwvaXsnBItm2IkTt5uXmZBiZ/Fu9wJYFcBOAh+Gxu
X-Gm-Gg: Acq92OGDzQI764tq3SOnltXX6M7mKDysVilrIjvNtaqwKJSAbH/Yr+LnAIAGxQ8g+CO
	JZQCEgR/CjhjXM9w/h4esRQ98G/IR7OZ5BxhS386qWeUuhuUP6drY1zU+Cvn1pJA/iYKsKEiYxG
	7VB2j6kDwd4yu/DY/eckckZXo63FYuHvSfgzgZOZFB/iIPxRHrbWfRLwnxYipipinMA3gZHUAmu
	GcLtLa3udjjwTEdoCQYYfwCXCgRPIG2UtQ++Sua9Rr3yZeohBuGsixT+d/HA1SUop4MUybzywOf
	6syEpAnTW/NCARWvOrVl73SFRgRCpRdxvipTFCRvBlxM5L3+7Sh6Yf/CpiVpKQEhFOVDWakAVhX
	2A25kizXsP8X9oQpYXMJMiDxEGvoJFkl2oKClQzxgXM5RXHTcqr4L85G5YlCH9JE2dO89Xyv3ff
	vTCD3laIX4C0k+10TDkOKVFphwlu0XIzyfFi8QO6QixcGSmqQaUy7asJ7q1h60OX3+OMwkGKoJH
	95rmoNJws3LsJ+TJp90b/aVIGUscoX2z9qRselxHQWI
X-Received: by 2002:a05:600c:4686:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-48e676b6882mr288356675e9.26.1778577908947;
        Tue, 12 May 2026 02:25:08 -0700 (PDT)
Received: from thinkpad-l14-ju.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e904bf792sm59883195e9.0.2026.05.12.02.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:25:08 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: stable@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix emmc reset polarity on px30-cobra
Date: Tue, 12 May 2026 11:22:09 +0200
Message-ID: <20260512092225.34835-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB6D151DA27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-245431-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakobunt@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Technically, the reset signal is active low - it's called RST_n after all.

But it is ignored completely unless RST_n_FUNCTION=1 (byte 162 in extcsd)
is set in the emmc. It is 0 per default.

For emmcs that have RST_n_FUNCTION=1 we failed like this:

	[    3.074480] mmc1: Failed to initialize a non-removable card

With this change they work normally.

Cc: stable@vger.kernel.org
Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
index b7e669d8ba4d..90751b04f95c 100644
--- a/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-cobra.dtsi
@@ -35,7 +35,7 @@ emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
 		pinctrl-names = "default";
-		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 RK_PB3 GPIO_ACTIVE_LOW>;
 	};
 
 	gpio-leds {
-- 
2.47.3



Return-Path: <stable+bounces-230836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G7PEd+vyGlRowUAu9opvQ
	(envelope-from <stable+bounces-230836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:51:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F1E350BA8
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DAFC3043BD0
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 04:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC4028488D;
	Sun, 29 Mar 2026 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiSFP0Nh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F624169D
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759711; cv=none; b=dIv+s/p4QstupFYWyFRlALb6dGf1pPM4uKE+rR5v5R2NLnV9/hOIZXoH4cr4B6C+1pIx852cV/xGVaIFqo60zzMCoWKjTVkC1aYwLvPpsbEzBRidNXzsvqhO/D8WHYbCP+xmKW2ecgn69ZT11Py5FHajzn/d6WSOQftwJ0n8VZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759711; c=relaxed/simple;
	bh=mrDnR0G7mbNJho3HlF5gQvzhoEN14/C2UquKRdZ6H1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JhgvBa6hSoBq+sCbAe4S/vsjf+d/sGMK2TdztXn2OfOBQttytZanUqMBPAq8Z9T1UlDnQTmvcLALxSU2+mKuub45AYKHjlobIgxTR6UmrtPdksr7bzljlIXU4Nn4eV7Bwzct5iOpYJlOpYHZD8xso+EqlZo5xPxgFP6fm2gIK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiSFP0Nh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2195437a12.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 21:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774759709; x=1775364509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X72F+IYkq8vmJ6nRPI8ppD04puTmgdxZkpkri1mXXzg=;
        b=SiSFP0NhBAJmtHnRK2BBtz3Go07NRQ13nWKVqMWzf16AJC/Z0DSvJAbFA0DXqed1LQ
         o0OjDbJFjinHM6gFTxGD5d7FxHXM2q3dsk0Ze21Ba2RoNG1xuyHfyS27f71iBfgAeFDa
         +gNwIbtZ1ONfXllgQRStXkxJvDU86ABwXNK+iENAUl7ybpVAW45yiscaJaJwu3VIK0zp
         cPaZJOYKXzm+omic4bL3rxD/7TxFrNHqtll9zsubjqn70t6BcQYMPJ0gPo0MP0KFafSM
         3C+q4GtoTYJOBAqLA481D3PoaBsOOI1JWarW10RSdvjgzLtdhCicR19mxKW1JpzZKfHW
         v9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774759709; x=1775364509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X72F+IYkq8vmJ6nRPI8ppD04puTmgdxZkpkri1mXXzg=;
        b=cZgJtZdwIVDU4+ReX4BAVLzorKLoCJqaSeGlLJ0SLhEb+2cuHC2/L+fArmO3suUT7G
         gPc7a+WOl/2S/uXPh78EyEXOvqkBRUm/iWH2f0wRk9L4ZBCL8fIs97J0ht2JGDdCB/e+
         J7oJ9aJv/CNEEOKTMCUIaW+0/QCUzZ1Wzn5JqUT0vgT9Vr570awXXZxn87eAmbgkttRB
         /P5yoBuLPxVM3oOIsUdq0V3j9XGp8vpgFcJQUsZuSdGuCG6aMzgjRA0k3+V1X3Cf9TGu
         U61KmRSfutcYrBQQjp/jrteWUAj4spbUeOXJYlSXxFmdsQufL3kYpj+vyl7eXkGkKgmS
         VC/w==
X-Forwarded-Encrypted: i=1; AJvYcCU69DScMn2arRyJ7aGGbG+BYnx9a6N7jEi+PYsQDbfNQziGXxM8CuiDcxtlBM5oGJWbJnqxxlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwFRYpAx/EYgtQfsOxRmAJw+zuI8OQwZoCENw++Zc3zK83JZu
	TqtjLxzkppq2r5uzXdkBnee5jiki0ns1Kf3+Di7xZ3Oijq4p0sry7s+1
X-Gm-Gg: ATEYQzy1W/t6DxPx+iLkjRjuGy88EfmVDtTnbZzmVs08T2FvkkBQq4YZDuMlXJnuK1T
	Q8mRmaCRu2z3uVxuY98pnETRvlDLmNNcf5CFDIeJ7qFrWBB/WQJmIfHGtwP1xkFic7TJj9WWme7
	nDYlMbSEc5AYoF+YidC3Xa0c2Rz9V/WpyVG8TGdHH9YClfjAubt8gSDfmCnlAEJf2ZyrLqqZEm+
	o+v06L5HZatFC/GPRplT7CcTUXoxGdPwlPGyP7QTjKQQZJQ4+4W7GqdsteDh18SKIO5kwWnhoQ8
	ZvPPopUiQvDFHjmpv1bCoOTIM+YydEQ0YuC8dHF7bjDe3kstsbUfn+n+9YnC3Bdy3C1R9V4eFAs
	Z8xEqoLeZZwwRooPgtXBob3sOBBEN7trWu+jpcf+FdWXX6A3Daz6ODYSLO6BL9brItPgiRbPeNd
	ZNLA1Lt7DRPPIGzmvY8fUA/lpS53pb
X-Received: by 2002:a05:6a20:9188:b0:394:6344:e5c4 with SMTP id adf61e73a8af0-39c877ea332mr8300548637.3.1774759709300;
        Sat, 28 Mar 2026 21:48:29 -0700 (PDT)
Received: from [192.168.0.101] ([43.226.29.240])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c769179e31asm2899739a12.17.2026.03.28.21.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 21:48:29 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Sun, 29 Mar 2026 04:47:58 +0000
Subject: [PATCH v2 3/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Enable
 vibrator
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-ginkgo-add-usb-ir-vib-v2-3-870e0745e55e@gmail.com>
References: <20260329-ginkgo-add-usb-ir-vib-v2-0-870e0745e55e@gmail.com>
In-Reply-To: <20260329-ginkgo-add-usb-ir-vib-v2-0-870e0745e55e@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Sean Young <sean@mess.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Martin Botka <martin.botka@somainline.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-clk@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774759680; l=1039;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=mrDnR0G7mbNJho3HlF5gQvzhoEN14/C2UquKRdZ6H1k=;
 b=ph9fTagfBVXtK331HF7XaRKTIzItjVo85alsUFGqPrhIYNQAXctTJbC9AbxZpAXzv901QbdE4
 v03zR55ULznCzUwTjppN1GV1PAgNPMg6p+EkNIgfHXbZXAuTkgnD9xj
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sr.ht,gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-230836-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathbappai@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A4F1E350BA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable the vibrator on the PMI632 which is used on this phone.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
index 7eecd9dc3028..88691f1fa3a1 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include "sm6125.dtsi"
 #include "pm6125.dtsi"
+#include "pmi632.dtsi"
 
 /delete-node/ &adsp_pil_mem;
 /delete-node/ &cont_splash_mem;
@@ -115,6 +116,10 @@ &hsusb_phy1 {
 	status = "okay";
 };
 
+&pmi632_vib {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };

-- 
2.53.0



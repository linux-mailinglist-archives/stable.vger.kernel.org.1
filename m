Return-Path: <stable+bounces-213034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNEIE1NigGlR7gIAu9opvQ
	(envelope-from <stable+bounces-213034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:37:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C8DC9BA5
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC9E93002D14
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24A4285C88;
	Mon,  2 Feb 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDzjVy9M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA4279DAD
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021452; cv=none; b=BAwFP6tEIRGAY+fkaGQzbFpTXdqo4CnSerZdwlAkjnay22nU3zV5qsbxdGwijWcGGm/DaG2nwtdyWWpp+D4tUkzvMikfVcn8g4BS3cl27oSFtbh9wm49gWT3TYlHwHb6PxW2253rr5P019j/5UbBPf3JGl/fOsubh/x+2nPxiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021452; c=relaxed/simple;
	bh=cmqMih4MUx+xdsxqRaw6RKXabUbqmRn2ZVQMLIr1M7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk677ltrB60qEjtfl6Lf+OsUch6foqcaIVQp/9foK8w4OT3F4eK+whhBAzZsRagvwWZW18ZR+k0QN24jrZCyb/9fcDgys9nMqHA1Y+yDEEdfUAEj/YgtfpW3DNKE9PXNR7kk7dBUvD2cVQJ/8bpTqPbOisZdKc4TkZ5VB+1v4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDzjVy9M; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so30579955e9.2
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 00:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770021448; x=1770626248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joUE9EOzP/3mRELBtbdhIrRdcsM6ON8pu5mMACf9Xr0=;
        b=kDzjVy9Mr8R3mBr86h74N4yPEvak9vBqc5E3eBKeJFaiiFRktChipuAbLOi94DyP8Q
         DXuWErN4ZrxasXKuhzMTC/ZhenMc4pda7frwiNY74RsttMJPnewaw/6Jxqmn5ukFoGBj
         FirxjbQFMmDw/T4TjDXayNcLRi7DIISgv7on7L7Tx5fAS2yxyAuPw8aCpkmD+5oOn+QL
         2WZobYX2ClMU8EkexWI/GrMAZyyQemieGpo4UcCFVNk75zD8TgMHZ/Afh2cbupYQqfe/
         1ZOe1K7Ybw/5eVBEGsN3fLiLdaumuZIIdXpIsjI39BiAFED89n+tTF5OLFurfkY0PE1R
         KNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770021448; x=1770626248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=joUE9EOzP/3mRELBtbdhIrRdcsM6ON8pu5mMACf9Xr0=;
        b=RQQnpA57/xdIsU926vCY1ZQ3Y3cut697jLRDS1mwilZyozwxqckglghr0Cz/L1X3eI
         Oh10hy26DGVIHJqlAU0IGqLKWkMsHTmTZ+CZijbNBWCU1X3jSDdBjYO2gqxtv8DXxk5L
         4u8V3wGrB15uyboHI5oSFmcx/I4DLaWZgjMw3j2xTLqfy730uO5egCa9xf6/pRCa6tK9
         JxVWVkFdsEHzYi/Th2MQQC+7I+4BDa6fLYynRtQzBb6CasQSm89NoW7JBJD5e4XfpNQ1
         fQN22kg9AdeakcoM3ofUOOuU5KuuNorm6iZbwnQeeOuoMVmNAuKgCpsztMhopbJUCABt
         A4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVw9Zf3WhwS8zpgpkoNZFtDZrmtRwfHqfcudRdklfce1yq0LI2KboEHRNgEjLvV8TM0mhfugpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPQQkrNtDV4hTJUsKNdm5WY92Shxa+PMrdadl+AfMiWv5xszL
	aXMVY5ADZk0WHssI1TkySQWm++N3x/fMFwi43hh7l94tnixBVeGsbZoo
X-Gm-Gg: AZuq6aKUWyWP5me/LAhiZQU39+dV1fc0lDcf13128LUxMGcqXWekBWO/RW5JeLp99jP
	NNDCQa48o+FtvS6Ytt1SkH80wke6fQcGk5zmvSIdOKXVnc3ND9jo0W/jI6nGcv4jMKWFSqzFw8x
	cCGpXcXwbROOFYCZNXD/wU6KUbTxtElSJ+6ffoL2UQxhfoWnhi5IAccZGjh1YXdrUVBqPiwD19l
	qxdTH6wclcIW6mnETJZrY50ut0Bj0WchlNEwAlRUf11V1165HLZ4w8J/dJJlMBqRhR30ebHRcLI
	reboRef23XPFgolrwW90Qn9PfJJL2H824axlMHXYWiyUqHN/OSVE09jf6fvFZ7bOE3OWMC7soxG
	CDXNUGj3Gdm6GAbmEd/9zxX/w06Z24ZaTK1chcHKWLOPx6YRf2Wzy5ymw0Y/ydLQXcq19hmGYRb
	xB67zzfvgbnkLuNkEL/xSsoWUoIM467fspFR/kwlgEllIAkK9jIkXZNYt5PoFgjaa2bwMf4nrYh
	+dZm2+LZMYdEwcPoM68ZYzKfzjm+0mOmsdHHYKe9zaS13TP/Ek4kfO8eQ5PTsZ1CdO9siW7FP7Z
	ZrFkEwuWgfKy/HEIRgg=
X-Received: by 2002:a05:600c:4e56:b0:480:53ce:45d3 with SMTP id 5b1f17b1804b1-482db47cdc5mr123484685e9.18.1770021448326;
        Mon, 02 Feb 2026 00:37:28 -0800 (PST)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce564f9sm399535415e9.14.2026.02.02.00.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 00:37:27 -0800 (PST)
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: ti: k3-am69-aquila-dev: Fix DP regulator enable GPIO
Date: Mon,  2 Feb 2026 09:36:00 +0100
Message-ID: <20260202083604.325060-2-fra.schnyder@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202083604.325060-1-fra.schnyder@gmail.com>
References: <20260202083604.325060-1-fra.schnyder@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213034-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5C8DC9BA5
X-Rspamd-Action: no action

From: Franz Schnyder <franz.schnyder@toradex.com>

Correct the DP regulator enable GPIO to index 21.
The 3.3V DP regulator was not being enabled by the assigned GPIO, as it
is routed to GPIO index 21 and not 37, which was causing instability
with displays connected over DP or via an active DP-to-HDMI adapter.

Fixes: 39ac6623b1d8 ("arm64: dts: ti: Add Aquila AM69 Support")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
index f48601ae38b7..d3677c2c2547 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
@@ -33,7 +33,7 @@ reg_3v3_dp: regulator-3v3-dp {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_21_dp>;
 		/* Aquila GPIO_21_DP (AQUILA B57) */
-		gpio = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+		gpio = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
-- 
2.43.0



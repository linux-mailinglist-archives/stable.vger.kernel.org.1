Return-Path: <stable+bounces-213035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEpZJiJjgGml7gIAu9opvQ
	(envelope-from <stable+bounces-213035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:41:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AFC9BCE
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2450E303CEAF
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC222C0F89;
	Mon,  2 Feb 2026 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNszzXLV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D13353EF0
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770021453; cv=none; b=jqnS1YZnQBrAnpNmO7Drtf07A38bubK53CWeUQOCMcfo6yzR+nmy3PYste7EOKJVu8hutOcI0l+PfQnaOulfHcIsBBoWyxZ/2aUCFFzzjOhra5xUo1+7fFpLy6yUiKTYSShyTZdf8AId3Re/qoGU0via5mDasds/hXqR35Y83+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770021453; c=relaxed/simple;
	bh=m43fD9DxUHEeNJaw/Ju56CmZEw+prtCN038EDrI0Mlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqjR+5Tvc1V6pDj6uomecEP3OY3tWpjYHZ+JW8EhqufJRtkQDnBgpdIVqdJRIw9D/zoIFc4k7pomY2fOQtWOf85hz+kG9iYrPVhyNDFRBWR7XJXjiN2W1Sscs2W3PM/p84EG73Pgcg7q5D3aTjqe4CmX3iCr+HkvdUGitvLxZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNszzXLV; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4806bf03573so19848375e9.2
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 00:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770021451; x=1770626251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUt9924HsCW+kyUNL12xZ+wX+8YIZNo80+Bbnu4QVf4=;
        b=TNszzXLVgFE65nGdgg7Xg0Okcn+htATkpIEvH8InGH4Yj7CtwnBMfPh2O9gJmgb8ES
         VpAdv6QEqhJgNxInB/YnosjWlZytk0cdLrpvFZXtUfobcB4fBUJIyrVmCJIDGcejrw5R
         bxvw0rvIGcvyRxS39qy4uap6+S9Qv4vPhEvihB04VhQ17d2ejNvqcH0W5v/XBu1oV8i0
         QcLs+isoU4ssocnvV9uaE5otl4XVnn/VvGNjua7SP3w4wnrEC8FAps7COtqUAtbDndfs
         +ywWLsz+LMoKKreCU4TlpCngRMOXEkhuoJGJ2YkAOxN4BUxzgqR6jW3o5DiJmEKs7K2s
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770021451; x=1770626251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUt9924HsCW+kyUNL12xZ+wX+8YIZNo80+Bbnu4QVf4=;
        b=ioWvCtg/BYlS5iwOX5nk74CAYe+AHWZskqbrOfBAzMUOHshqPbFc5fuLwAL10kr/np
         TukNQBUNh9lskQ71S3jsyLKa7qB5Fj6D8KHEt277gNy8VNFZMoiDXeGKgRIf45YvWUe2
         su1y+2FwpI9Hzipt/ng8/Dvb3n0Hsn/iCuF37rtPzh/yvOi/igB27pzpxNQWMLne6h1T
         guWyvPbdP9FC6rgPfvwzSIAa+VUArEfVQUEQE2RyPYwmoXWNnoyUgQUd1hnrD0fubEVW
         A+Bqtx6fyyRQapDi7YPqh/qISCdNFQKJhLveQz7pfpRMlihdM297ZaBQPzoHjp1bp0yw
         0xCw==
X-Forwarded-Encrypted: i=1; AJvYcCXyrcz0M+Mud6FLVhx5aPR212dnDZuqo71Hr8xEbRidenCc0fEIZ7KYzv6kiKuaRdiPEjzOxcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4mbV3mLCUBbfVaSGfUlpzTokGmeMTOdgsIledcH07aeAeqsZ
	INIk7TKWlAx9PTZS34ZelHeYAEffzoygfsCyze3mp9azzICUR5HpMPO7
X-Gm-Gg: AZuq6aIfZj7eQyRKXRjz/hGQ2Icdo/EF/k5b96IzoI8/693kBZ6hFiGVmVKny9AxSkH
	pMBxC3o0KvLhplNEZBrx8HRtyuYSuWFZSaMtq88jvxSyaqpKRsBOx51DJbiMgeAIOM7KZjUkzP4
	t20rLTK427ZJ/byWzpwffoYiEr8hfZaABqWEbR0BYf2f+qTONCv08iNoDQQMG/3wUO91GVSfJRK
	kHgZI3Lf/r4CRc8+XGjipKVluvALetFr1tXQaa4BJwbkG8Zc9QsaougPZwD8q6JeNpJIk/HC7Sj
	QzIVUzom7QPyfDxHkG8db5/A5+DwY3celqfwJflnez3vo/FzomiBldlKY1DZcPJqlLKxfrERL+o
	UylFLPTHiNUkvQ99iIhHlFrGXxtJhM+dVMhMEa04lI+ed8v+TPsWjFwdidKxbAD8PuPnMgCAxrM
	DhstwRMjU8Nf9C3TTTpZXvk6h4At2e6KhPgHIW8cqZ8epYndMmVmyWBvI9oaGeirtFyeVB44dac
	IcgveAXSIDaGmFJrJLCvaVOftm4zdIiW8cCq3oCsZuVkPrva2XSTvHaKJRtgnlJq2TKNVWDJvV4
	yjussubu
X-Received: by 2002:a05:600c:a00d:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-482db465540mr141701315e9.12.1770021450631;
        Mon, 02 Feb 2026 00:37:30 -0800 (PST)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce564f9sm399535415e9.14.2026.02.02.00.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 00:37:29 -0800 (PST)
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
Subject: [PATCH v1 2/2] arm64: dts: ti: k3-am69-aquila-clover: Fix DP regulator enable GPIO
Date: Mon,  2 Feb 2026 09:36:01 +0100
Message-ID: <20260202083604.325060-3-fra.schnyder@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213035-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fraschnyder@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 110AFC9BCE
X-Rspamd-Action: no action

From: Franz Schnyder <franz.schnyder@toradex.com>

Correct the DP regulator enable GPIO to index 21.
The 3.3V DP regulator was not being enabled by the assigned GPIO, as it
is routed to GPIO index 21 and not 37, which was causing instability
with displays connected over DP or via an active DP-to-HDMI adapter.

Fixes: 9f748a6177e1 ("arm64: dts: ti: am69-aquila: Add Clover")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
index ec8ff4587715..dc0d3cf2f985 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
@@ -26,7 +26,7 @@ reg_3v3_dp: regulator-3v3-dp {
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



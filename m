Return-Path: <stable+bounces-269817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NZ5CM+jEQmq8BAoAu9opvQ
	(envelope-from <stable+bounces-269817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 21:18:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440096DE3E1
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 21:18:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mtTfcl6P;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269817-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269817-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BB323018C0D
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C439DBC5;
	Mon, 29 Jun 2026 19:17:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0437D10F
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:17:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760671; cv=none; b=sbQjTdN5El7FJLXEARO6Q4Cv4RAv9PJgrsDSl8bgMkNcHC6E0sPQcfBteJHt5x4HxOAAeDOwear0Dkxg2eruVJr0kzlD47fFBnraxm4jkqgaxTk5PTae4aw/txaSDuSS08IjexChQLAltCvWw0cp2NoPE4OvTwVLT/Q1TMUCrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760671; c=relaxed/simple;
	bh=4KDJhI9HttGkLkq+uMNiUP4rjVMYobG2l//58bY3dbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLA74+hixZZwTA4Z5n+/GRhJ4UsvQnOx3JIsrY9QjEZ+/h0wgkITm29T+xNyO3GhDrsPTV+C735IFekmeyMGajRiUMGpeKZ8+WekWBo65F+aL+xQ3LJgf4hptbhG6OeHdq/ydxO40pMVvtpTjfZihnwwg3a0F9jWathELgneZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtTfcl6P; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b5d61302so4995645e9.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760668; x=1783365468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFiE5okuY8pUtgILiSrSZWQvOisAuKWMlCokuO74NKY=;
        b=mtTfcl6PE1uHYxeOLf55qGrgz6+FfG8xpy7EgKGAIO6Ts5OI0SFI8BQoxGXtRMyOkv
         n8vHTZjRyLsRDC+X0g1oS8jA89R/OjSW0WMvPlCiTCA4SiZBMKsOe6UVXx/wJLxNm1tp
         +d5MeEWV319ZgIlt4fxJQVdF03uT3MJD8q8AWf0OwSmdAeJJz9iVZKlIxD0DI/XfvPfF
         No5zl+4M1Csh5mmh5vXGepsu9vK+LC9TM/hv75PC64oFXSlo+NSDp22qNDMtHqXHzq+u
         CrFMHvSJ86dGtnirBg/NHO2tnd3cUp01Q2GQ5ajHNc/uc0msBIwXP1h2cxv2FGm3ZJph
         bkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760668; x=1783365468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YFiE5okuY8pUtgILiSrSZWQvOisAuKWMlCokuO74NKY=;
        b=UunU81Q92sv5X+kRfJZlMNnxnqm/pDOoE6oZ+bSghSvh7WrNa9vhrAKG3YQAky2Tq8
         bMs1AFPnrJMcDpUQkbBo4skEcSc3+y1oQH/WjmqL2e0TLjn6XUUtmZ4OcXIqfLl8prQ2
         4cJv8vDQBnZu87hCUF0UNkksPFHLVSyhnQIufr3o5YqjXVBamKULM2eapjMJJkNouPRx
         997cnIBxBpIMc0zCva2HR8mgCEi0roTxAqnnyLGvaz2sytNh9oZ4YPs4PoVEW9L/XRkz
         YGENao9SVQba9hu08myQqE8EO1GDxkV0bfXO4qIiXgTO9vP+pOtmT4STn5BqK+A0x9/N
         ultQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/Ne5N3Z3gU4mS7JWBVmFCghUHNwykHZ2l7YmhFr7RvmCctyVTo6nuDiEz7UW+4jXNjzI0qNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQaOLvbasN6pHQnULlMVAiOKq9cU+uhKaAOw90hiN4+UnIFPl
	v1FSEPwr7Lz834PrRthQmE3g7xYZWunhVj5SAVGBZLMh7TtVo1cQ+Q6y
X-Gm-Gg: AfdE7cl7fGVEOzr5+4qk5bKtwW+VdPR0J7FjB21BqQ6WBbxnTSz85tHOGy4vo/ZnIXn
	ip4v9sTpi969vfStvf6Tfm3WXoUaU4/v1lBPA6jlfot/QJSc1PVA52kzPX2d1jNAJj8Q4RDJdpp
	JCv9XfHxg7f9Z+2qd3jyhep2z0E7sWg0C3YXgM/qZU5MN34uO047nz/M7BA4tAnZyjJtBzVUd34
	fEei9z+ntLsiduxA1oncjMhzvFL8fRvbUdhuaPF2lfmoVax3uPeWsN5IhHSjyDl56RuntJB0YnQ
	GHEANeKwrvXTsSXA6czVK0FRRRJ9B3ZlLSqfrnK9oiafpZMfWP2mxP4xoOniy9ADXuzMFB2WVjT
	jmH/cZihHOVwZPhEVVpObSeWrhQjH+AzH+dTrJlIxpdmTmw6xTuZtuafqFZ0pWgTF4jymOr3oUa
	rlFWtrJAMwFn74q/ZE6MZ8cNGS+4X7ggFg1Vv42idTnWtUMqTE5bYdKM7rDtyGfyiX53w5QPm+x
	B2xIibGKVInCHF/CwPs6BtYP9O01Zgd1zJ4XqbGAG00AyIa+xUboAGjZQ6E/i6m7j4nKOm6ZJai
	Ca560J+Tog==
X-Received: by 2002:a05:6000:2c0c:b0:473:1e79:87e6 with SMTP id ffacd0b85a97d-4754a50ac5emr757082f8f.3.1782760668572;
        Mon, 29 Jun 2026 12:17:48 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cdccsm259568f8f.24.2026.06.29.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:17:48 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 29 Jun 2026 21:17:39 +0200
Subject: [PATCH 1/3] hwmon: (max1619) add missing 'select REGMAP' to
 Kconfig
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-add-kconfig-deps-v1-1-8104df929b1a@gmail.com>
References: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
In-Reply-To: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782760667; l=793;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=4KDJhI9HttGkLkq+uMNiUP4rjVMYobG2l//58bY3dbQ=;
 b=4LflAj63BV1nJl1FxlOGiLIMPdzdWeGL6ck6IgzOh4DqZkNcPwufL1uFSFGcJUfft0nUyPYAk
 5S7Bm/UJ0mqCyi49TFKpPNpgNlWhFq/wG3g4JMzBH439LctlQ8F8nFj
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-269817-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@roeck-us.net,m:tzungbi@kernel.org,m:alexandru.tachici@analog.com,m:linux-hwmon@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:joshua.crofts1@gmail.com,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 440096DE3E1

The Kconfig entry for the MAX1619 sensor doesn't contain a
`select REGMAP` parameter, causing build failures if regmap
isn't selected previously during the build process.

Fixes: f8016132ce49 ("hwmon: (max1619) Convert to use regmap")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5c2d3ff5fce8..a908e22bf166 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1248,6 +1248,7 @@ config SENSORS_MAX16065
 config SENSORS_MAX1619
 	tristate "Maxim MAX1619 sensor chip"
 	depends on I2C
+	select REGMAP
 	help
 	  If you say yes here you get support for MAX1619 sensor chip.
 

-- 
2.54.0



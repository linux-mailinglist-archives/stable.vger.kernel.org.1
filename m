Return-Path: <stable+bounces-272372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mbSBA8yyTGpXoQEAu9opvQ
	(envelope-from <stable+bounces-272372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:03:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B0A718D57
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:03:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CR9uKKCp;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272372-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272372-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791CB30F26E7
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 07:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE63B2FFE;
	Tue,  7 Jul 2026 07:49:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7993A873D
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:49:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410571; cv=none; b=qZHckMYMut/qEqF4Q2+iZv82BxmwMDYHfB78CcEidWpwBjcxI7qpK3Qu1o9lNIaA3D9B0UN5eRW2yn32VqP7+mL2YKeo48z09pBUv22xYTcVHZ/Y9QzJ6JQmcBso7OSWG3oRYa0Zyyzqv4HFY1QTZ51b2G5NVm16mCpHFHCCkjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410571; c=relaxed/simple;
	bh=eFufH7LT3CdItIJOBph0MNu+wwyaWOrq8umciX1p/6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcGzBkyl8gMpjOrMHy9iuRr3IdwaAkb3neIgA3GnRGK0BLGNQgZAtmIJKbD7dAHwRDpCG18KY1grAXy9sheDNUT6GoihC5cz7cDacZQaBVYmrufYiS+1YmzReWI10tIPRwjIAlEEeBMYufUz6ud4xODJzkHGIJ2YLrp7khvVd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR9uKKCp; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381891a9525so3598549a91.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410568; x=1784015368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0usj1Azn3b9r2TvYMyi39ADdH0kaKf4fB0NJ5kTbFs=;
        b=CR9uKKCpcnbViGJQFdsn1d+0qx8p8n2+RgvojUQdAQrRp8t71tBgmAlAgeHPbihERu
         b16d/9QNeqXwHl1El8tK87oXwWoB/ytaw9Ipq+XdnedZwMnIUZ55PAIhM/DsqPEVhd1e
         DINaTL5ItdsG/SRovOHAUJYVYE1upcp8nDXg8mwMbKSw/S3VZU8cGGrb1ailHs4OszHe
         s6ZtpkpduhR5vPb+YgGbIRcfQWufiz+gv29Schuu6phEJ1sxcrayBKNRm28C/EFLs8Kk
         A05YKUKuEFc+z27DHWVHALvvTASZd2Mh7OK63ylncZ6hJFMIromhUKSai+jlTakoJsXR
         ++4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410568; x=1784015368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t0usj1Azn3b9r2TvYMyi39ADdH0kaKf4fB0NJ5kTbFs=;
        b=OC06dW52UGQyczKU3L/za49ec48LZ4xLheIN3+glYOXbX/vM2nmXrAzLqKUWONtxdt
         ZrVqqP4zfJ/+9hYLic3AfmucCsH+pvz+p+o6ewFPLEzd0ormgrpR1FBc3vy+q4WLFpEI
         dRPnzxFW+N5PlRfkijto3uEisBUM1Wg9M9l59V2bQASTKeXjuGU0XsVadDaWxJSrRcaK
         MZugOnErfiPGpZsStRK7CLFO9aud6rW0hECP6dmpbL5/T2fBlRFaLEFOkFx1KWJZwkNN
         ZRtGQWSDjzEr7lvMoikApMhjx+r7yl/FvOvgxYBHjuYbdsz8SuY38r4jU9ef0HYDF7Iz
         Adgw==
X-Forwarded-Encrypted: i=1; AHgh+RqWpXMyRsAovfMkcKjM4oHmGQFiaNnzN8iP2qEoBBot9ay5mKrnZO5P6ndOzfSehQfSc7qe6Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlYVipE2U3aLN+kWtGa7odU1v/AaTwbrUAkxU9DE7PPqRscbC
	nx0YFc6L8BmtOyMUvqIDK1/0Eifz3AgwPx7GkrT3tDrj/6Ibz9CO3NqL
X-Gm-Gg: AfdE7clWHVP0QpTJrFInr/v/pU6pmlMNF7BEq9s2qwRA6drC71ZGRz5Ez3and+72nlC
	kT5+ji0drCMB1Y/GV/91muDRQHXZWBYS+MDomEN7zK5Yh42belK1P7Psdwc8YTzjwEKs4pI9815
	2xfLawt6U9VyQ1Xvvi2DePDzUiMO61+aDWb1PSAYM9j3c4CWUuSG+dCtrdUBrPHQwFu1Y8A9Ml7
	pi4u82Pf1okfgaYIYwxDCC32eNGRgJYB5GhlHjnNQvwej17F2S6BX3NXwQGvpmFNSSywKWE6FiL
	Mua9Sg/M6QWY98SspSJchJH2X3Un216bytxDYUfeonSwFSYHaOhr38q7NQx8lKcYMScSZhctP+w
	9BZlSbch5DGU/tq8lJKDzWSA2ORbBFiB/RVHaVw8wnRHW+FMIYUxTYdNPGNMsrJQ8NsgqhaQn9h
	A05xq7tPlDSIx5U9BfZYOw4oJH33ERQpyJqynRDGoJpsGb
X-Received: by 2002:a17:90b:4a0c:b0:380:873:49cb with SMTP id 98e67ed59e1d1-387572b380cmr4047566a91.21.1783410568403;
        Tue, 07 Jul 2026 00:49:28 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a361asm626710a91.15.2026.07.07.00.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:49:28 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	stable@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH v2 4/6] clk: mediatek: mt8135: fix memory leak on module removal
Date: Tue,  7 Jul 2026 16:48:33 +0900
Message-ID: <20260707074839.240676-5-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707074839.240676-1-akkun11.open@gmail.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272372-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-clk@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:wenst@chromium.org,m:miles.chen@mediatek.com,m:akkun11.open@gmail.com,m:matthiasbgg@gmail.com,m:akkun11open@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[akkun11open@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,chromium.org,mediatek.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akkun11open@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58B0A718D57

clk_mt8135_apmixed_probe() in clk-mt8135-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt8135_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index 19e4ee489ec3..e3b7dc13b458 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -66,6 +66,8 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_plls;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_plls:
-- 
2.54.0



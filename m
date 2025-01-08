Return-Path: <stable+bounces-107977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC8A05572
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 09:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098213A55C8
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F053C1EE006;
	Wed,  8 Jan 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fZUm2b2U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421571E3DF2
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325273; cv=none; b=qtHmsvX/778CBr8+zXcWL+C3C9reBF1M+7ZSwEg0oTp9n0XrnpcLTUvswl33rGuibBUIMXa9o9Ah1yHjG7XQQ+F/JHm9w+2GEmIRmax3khgWelmkQLCr6IsYRu8GwR8Uv53NC7uEFYrtRSe6Lr3rZO7lO+0LFsAmI5UpFeQOumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325273; c=relaxed/simple;
	bh=XEuVxeYxilRGUzODNmGYr/WhJeM6SI0madWdpZlJ1pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx+E6EZd7A8mkccc1KjWS+6lAS/PsfpC5b4N4dDbVY2F0JsNnYXcjQenNrsWfhHOKxFk+KDjacTc+odIQFuw9tQBVCooPRnryoHNJQCbLk3UkCexDZ8e7/1EBN48SZ2c98KCeEjzXIeYNItutbMRZ32VsOsr3Oe23DnxjkIH/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fZUm2b2U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2162c0f6a39so11091735ad.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736325271; x=1736930071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hfaIU/yPmRs9H27LP1GQSu+5nTkg84M2KD+Fv53tNQ=;
        b=fZUm2b2UP+NzNf13VOjm25tmlMMVB6KR5prmzGBxeMvimvS31uK7ZXVxJ9Dm5ghVnG
         QCIBARMN3mDyD8fjknAS1KfDfVCIM+ZapGXRA0VZ59KQminP57XNmYLswgKwe6NXqQ0a
         II5HeUQAbaLxVIo8ARZYHlvgA3O/+kf5pzYEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736325271; x=1736930071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hfaIU/yPmRs9H27LP1GQSu+5nTkg84M2KD+Fv53tNQ=;
        b=s43I7Q3JJDrr9cj0qD5hps3afJgYL8gtzRcNVur14gckbS41KXo311pZKSRrPusi9w
         GTMVQHHQFyZdRFfA+eKo5ODZ4Zaiv3yh+kTKCQ8P4JxqoYKGI8+3YEru37ox1vM3gRp3
         el245BLHoU6NUaoybXuXdD7hmKSM/O44A7WFVoNstGAhOH/egvCJmg4QizTvVARCllyi
         BOf2dLKo3hOXRRg8mOvmtb9UXDt5ZeqXrdSw5P/aYYuzc6C5ZmDzR+VUzsyMkK5LPEkJ
         vFbRRpSqM4uzTZgdOGYCM+KQ3BIaaBQZiimWhH6zZ1+FAFD9QPfxrLpvEGegNXQ6YzIA
         hXXw==
X-Forwarded-Encrypted: i=1; AJvYcCXee2OP3CmfFUoQiPaz8DbU8rBHJ85/lk0qEs52qP2KEgQuKIbequAqswGBTZpjj5Z4jt0Ze4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YweDMhE1N/tgRLcV+9lzlzOzBehXIrK+9TvVyz4p+nTuu2pEMJL
	vUH5RZdXyTuWLf5Vb79W4+4rb9BE7UqqyiyRl2KPI1WocgehiPyVJ+vTL5a/65K6NQ5/4IdNaWs
	=
X-Gm-Gg: ASbGncupz3IKBANChVXDA2DgPOlAFaxYBHaDTOzkP5iKyWONcPUB+Dlg8ZWmFKoxptx
	l/FFJ3nVurGXc1A+GH7kX2yuCCMp87xsdvYmh1QtV76Yi1xwUg8VpuinltUlmFzm5LkWfrBaLuX
	5y5+Ez9foPKOnnlRIXfy2AZj8m7lIemJAKpbQ1SzXA2msu95hjM7H+7tLCzrXfHL6slPjnMs/8z
	j2K1WlvHDQEIl4H4z3qZndAEryQ+1Fp8h7YISPESqXNMscEA5dCSG/UMMUnEYTo2p/vRGYU0jQ=
X-Google-Smtp-Source: AGHT+IHh5Ox0Chj79W0aML3FVEC2y3iYMrkJc9FjsPLlxqd39yrbKX0TlyMbXPcw3G6R3PveYRKL4A==
X-Received: by 2002:a05:6a00:aa05:b0:724:db17:f975 with SMTP id d2e1a72fcca58-72d2174e8a3mr3807524b3a.12.1736325271398;
        Wed, 08 Jan 2025 00:34:31 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:511d:2d5f:1021:f78f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8361b7sm34602275b3a.74.2025.01.08.00.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 00:34:31 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	YH Huang <yh.huang@mediatek.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: mediatek: mt8173: Fix disp-pwm compatible string
Date: Wed,  8 Jan 2025 16:34:22 +0800
Message-ID: <20250108083424.2732375-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250108083424.2732375-1-wenst@chromium.org>
References: <20250108083424.2732375-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8173 disp-pwm device should have only one compatible string, based
on the following DT validation error:

    arch/arm64/boot/dts/mediatek/mt8173-elm.dtb: pwm@1401e000: compatible: 'oneOf' conditional failed, one must be fixed:
	    ['mediatek,mt8173-disp-pwm', 'mediatek,mt6595-disp-pwm'] is too long
	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt6795-disp-pwm', 'mediatek,mt8167-disp-pwm']
	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt8186-disp-pwm', 'mediatek,mt8188-disp-pwm', 'mediatek,mt8192-disp-pwm', 'mediatek,mt8195-disp-pwm', 'mediatek,mt8365-disp-pwm']
	    'mediatek,mt8173-disp-pwm' was expected
	    'mediatek,mt8183-disp-pwm' was expected
	    from schema $id: http://devicetree.org/schemas/pwm/mediatek,pwm-disp.yaml#
    arch/arm64/boot/dts/mediatek/mt8173-elm.dtb: pwm@1401f000: compatible: 'oneOf' conditional failed, one must be fixed:
	    ['mediatek,mt8173-disp-pwm', 'mediatek,mt6595-disp-pwm'] is too long
	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt6795-disp-pwm', 'mediatek,mt8167-disp-pwm']
	    'mediatek,mt8173-disp-pwm' is not one of ['mediatek,mt8186-disp-pwm', 'mediatek,mt8188-disp-pwm', 'mediatek,mt8192-disp-pwm', 'mediatek,mt8195-disp-pwm', 'mediatek,mt8365-disp-pwm']
	    'mediatek,mt8173-disp-pwm' was expected
	    'mediatek,mt8183-disp-pwm' was expected
	    from schema $id: http://devicetree.org/schemas/pwm/mediatek,pwm-disp.yaml#

Drop the extra "mediatek,mt6595-disp-pwm" compatible string.

Fixes: 61aee9342514 ("arm64: dts: mt8173: add MT8173 display PWM driver support node")
Cc: YH Huang <yh.huang@mediatek.com>
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3458be7f7f61..f49ec7495906 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1255,8 +1255,7 @@ dpi0_out: endpoint {
 		};
 
 		pwm0: pwm@1401e000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401e000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM026M>,
@@ -1266,8 +1265,7 @@ pwm0: pwm@1401e000 {
 		};
 
 		pwm1: pwm@1401f000 {
-			compatible = "mediatek,mt8173-disp-pwm",
-				     "mediatek,mt6595-disp-pwm";
+			compatible = "mediatek,mt8173-disp-pwm";
 			reg = <0 0x1401f000 0 0x1000>;
 			#pwm-cells = <2>;
 			clocks = <&mmsys CLK_MM_DISP_PWM126M>,
-- 
2.47.1.613.gc27f4b7a9f-goog



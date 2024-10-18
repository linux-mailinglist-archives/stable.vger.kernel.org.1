Return-Path: <stable+bounces-86785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F929A3863
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF48285C3C
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEDA18CBE6;
	Fri, 18 Oct 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j0ke+elu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C315445B
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239687; cv=none; b=LX6sI0rHWpz5ggETY2bE8LqG7EuPHeAyoTM/Nf5T++84v1BxK8NLhqTs85FQenCbi9z+Fp8lYlKgQCDmcys7UCRZLaIBXe+KoCwQVt1NLCxQW5+7Gc/e/yXdVM4w/936HgzShoDJcDwZJrCDP7FFWFz+aFntvxYE9SE/jCMe66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239687; c=relaxed/simple;
	bh=+b1cMWRvd2/m165u4jRfl6bdFWmMjC5X8GKJ0se5ktk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paobO7bGshPfMCHHmRg9xJEXegN6nw2RYPca8IRf8RWGlWF3TIo7k9EXyZbAsKZVLuUVYGCIKNqwmpHypHc4Gwfg07J+cvZyswg6rRMGamATTH7m2HpFKa4FXaxi0bJY+I3KSsZsuyN2bujJ3Rc2ck1TpZtjlpZC3tu8m7f24ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j0ke+elu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c8b557f91so19751745ad.2
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 01:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729239685; x=1729844485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sw2cnvD53O5L8zKGOZV5sbNVDe/+IEjxX86rJilqAk=;
        b=j0ke+elu0OGjMHJZKJ1aG2SpcsTrrfMvjw6NL7rEsL1w1LkjZjpPbqxilX2wbkIpk9
         cmJKA0AIrz09fbFyrINYIbETOVEzdm4uYtrS+lOYqoUXC3NEcN4lRUWyH0DnMMg9KXDl
         /xuSsUT4W/LfHHR8PKU5j5UxPqRvbgKUDdLNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239685; x=1729844485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sw2cnvD53O5L8zKGOZV5sbNVDe/+IEjxX86rJilqAk=;
        b=bUfVhI2PGxqy/upNKfcvWlOR0EmPP0J0EFMDLCie9yNDOvS27UqA0HmsO+yxEuDZrf
         zR9wlS/csh2LVHR5uk7xpzpHVs8qTGmXvgndJeQiVfylrf9RTKZcyyIc+ONGyBfKvbHg
         0rp7tL6W5gO4NmOZ5jpZz5UUDlzE2Y5a9DY3jxU8vnatP+sXriFjbiGo54ySoL7MfLwV
         lt5s6crCMdj71DXDpdvAEtlfHjt+uOLwhGVrmbOQ94O4u5JL7XQ8ZToQi7l939jVIJls
         ov2lG0Gz6T6Na97JXkH2STngnvI1oAtiCxrtBzPrcrgCVcN2b6gDVKVA76NDWWFyDIg7
         +lig==
X-Forwarded-Encrypted: i=1; AJvYcCXRwRPv+0YrqcfecRCB8xHBlO1JXjRsHX3qvt/qiZ4KLPTpzwBcSxkKQpzibH9l2qXsI+bJHCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGkyYFNi9mJDzNdGO47jwG+PgAgrZibreuVFd4kER67zY+QkL
	naX9C1EJNjB6iYYevTAwZAlqXNdjTqizWb0kOCdmHgC31BH2YjG01I6RGewxcA==
X-Google-Smtp-Source: AGHT+IFOJPmAyaUnxkdtc6GJUuyr1a/qUKidE/urORfJ7bfMi/Vu+97DNhgccSxR9H9P6CXOMHrp/w==
X-Received: by 2002:a17:90b:814:b0:2e2:a96c:f00d with SMTP id 98e67ed59e1d1-2e56185d15bmr1863982a91.21.1729239684929;
        Fri, 18 Oct 2024 01:21:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:5e77:354e:2385:7baa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da79303sm1315149a91.52.2024.10.18.01.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:21:24 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: mediatek: mt8186-corsola-voltorb: Merge speaker codec nodes
Date: Fri, 18 Oct 2024 16:21:11 +0800
Message-ID: <20241018082113.1297268-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Voltorb device uses a speaker codec different from the original
Corsola device. When the Voltorb device tree was first added, the new
codec was added as a separate node when it should have just replaced the
existing one.

Merge the two nodes. The only differences are the compatible string and
the GPIO line property name. This keeps the device node path for the
speaker codec the same across the MT8186 Chromebook line. Also rename
the related labels and node names from having rt1019p to speaker codec.

Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is technically not a fix, but having the same device tree structure
in stable kernels would be more consistent for consumers of the device
tree. Hence the request for a stable backport.

Changes since v1:
- Dropped Fixes tag, since this is technically a cleanup, not a fix
- Rename existing rt1019p related node names and labels to the generic
  "speaker codec" name
---
 .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 21 +++++--------------
 .../boot/dts/mediatek/mt8186-corsola.dtsi     |  8 +++----
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
index 52ec58128d56..b495a241b443 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi
@@ -10,12 +10,6 @@
 
 / {
 	chassis-type = "laptop";
-
-	max98360a: max98360a {
-		compatible = "maxim,max98360a";
-		sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
-		#sound-dai-cells = <0>;
-	};
 };
 
 &cpu6 {
@@ -59,19 +53,14 @@ &cluster1_opp_15 {
 	opp-hz = /bits/ 64 <2200000000>;
 };
 
-&rt1019p{
-	status = "disabled";
-};
-
 &sound {
 	compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound";
-	status = "okay";
+};
 
-	spk-hdmi-playback-dai-link {
-		codec {
-			sound-dai = <&it6505dptx>, <&max98360a>;
-		};
-	};
+&speaker_codec {
+	compatible = "maxim,max98360a";
+	sdmode-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
+	/delete-property/ sdb-gpios;
 };
 
 &spmi {
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index c7580ac1e2d4..cf288fe7a238 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -259,15 +259,15 @@ spk-hdmi-playback-dai-link {
 			mediatek,clk-provider = "cpu";
 			/* RT1019P and IT6505 connected to the same I2S line */
 			codec {
-				sound-dai = <&it6505dptx>, <&rt1019p>;
+				sound-dai = <&it6505dptx>, <&speaker_codec>;
 			};
 		};
 	};
 
-	rt1019p: speaker-codec {
+	speaker_codec: speaker-codec {
 		compatible = "realtek,rt1019p";
 		pinctrl-names = "default";
-		pinctrl-0 = <&rt1019p_pins_default>;
+		pinctrl-0 = <&speaker_codec_pins_default>;
 		#sound-dai-cells = <0>;
 		sdb-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
 	};
@@ -1195,7 +1195,7 @@ pins {
 		};
 	};
 
-	rt1019p_pins_default: rt1019p-default-pins {
+	speaker_codec_pins_default: speaker-codec-default-pins {
 		pins-sdb {
 			pinmux = <PINMUX_GPIO150__FUNC_GPIO150>;
 			output-low;
-- 
2.47.0.rc1.288.g06298d1525-goog



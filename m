Return-Path: <stable+bounces-125272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A61A69022
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9927AB92E
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B11D7E5F;
	Wed, 19 Mar 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbNEytEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055D1E2834;
	Wed, 19 Mar 2025 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395073; cv=none; b=q4vPM8P5pwbvoekisBBHkVCfWFzH4OPlFGhpsWLzyFYZUl/05jGYa6pI7mjWWC/3PXl05VBUpr8anQ54zX4mBFlfk1nY+fdrcXRC5RY56y+8Sx5H95Q6wIcKGndQGjx5HO57r+7hExcI1rk0Jxv0dpGfHfuUNnJqT01rRvGt/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395073; c=relaxed/simple;
	bh=V8fCT3sVTG/a19Eoc36XslV7NnohUPPuaIOJojlDtfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py20KyUZLP0Z8dA6L4duIVP42urIFz+GWvP8qD9Xs9cCSW1Qjfe+O7yx7wg/ewXz3vSWUUQnrLhR11QvZl5w2tn1t2tq8zngxKHGSbhDoIVZpWSL/f8TSqsCmcXHj9Y3X+eep5ym9d7/cq3LP/ycjGZogTA6DtqpfrxuRNSGZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbNEytEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CF2C4CEE4;
	Wed, 19 Mar 2025 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395072;
	bh=V8fCT3sVTG/a19Eoc36XslV7NnohUPPuaIOJojlDtfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbNEytEOzv0/e5e8+Q66xUgb7h3AqY0DxxF375QcHXiyZEGi7KwKx2fkNtNxOKjj2
	 tsnkh/D9jAL7Vf72hTOYbewu8GpyHUNIoci3oHB/J2YCmtoE7eloRTTrfEIvQpKHgr
	 LIjfDFb5W840/XtN3ohHOEx0pAuwFxlu+BcQ6clo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 111/231] ASoC: arizona/madera: use fsleep() in up/down DAPM event delays.
Date: Wed, 19 Mar 2025 07:30:04 -0700
Message-ID: <20250319143029.580932784@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

[ Upstream commit 679074942c2502a95842a80471d8fb718165ac77 ]

Using `fsleep` instead of `msleep` resolves some customer complaints
regarding the precision of up/down DAPM event timing. `fsleep()`
automatically selects the appropriate sleep function, making the delay
time more predictable.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Link: https://patch.msgid.link/20250205160849.500306-1-vitalyr@opensource.cirrus.com
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/arizona.c | 14 +++++++-------
 sound/soc/codecs/madera.c  | 10 +++++-----
 sound/soc/codecs/wm5110.c  |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 402b9a2ff0240..68cdb1027d0c0 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -967,7 +967,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_up_pending++;
-			priv->out_up_delay += 17;
+			priv->out_up_delay += 17000;
 			break;
 		case ARIZONA_OUT4L_ENA_SHIFT:
 		case ARIZONA_OUT4R_ENA_SHIFT:
@@ -977,7 +977,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			case WM8997:
 				break;
 			default:
-				priv->out_up_delay += 10;
+				priv->out_up_delay += 10000;
 				break;
 			}
 			break;
@@ -999,7 +999,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			if (!priv->out_up_pending && priv->out_up_delay) {
 				dev_dbg(component->dev, "Power up delay: %d\n",
 					priv->out_up_delay);
-				msleep(priv->out_up_delay);
+				fsleep(priv->out_up_delay);
 				priv->out_up_delay = 0;
 			}
 			break;
@@ -1017,7 +1017,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 		case ARIZONA_OUT3L_ENA_SHIFT:
 		case ARIZONA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending++;
-			priv->out_down_delay++;
+			priv->out_down_delay += 1000;
 			break;
 		case ARIZONA_OUT4L_ENA_SHIFT:
 		case ARIZONA_OUT4R_ENA_SHIFT:
@@ -1028,10 +1028,10 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 				break;
 			case WM8998:
 			case WM1814:
-				priv->out_down_delay += 5;
+				priv->out_down_delay += 5000;
 				break;
 			default:
-				priv->out_down_delay++;
+				priv->out_down_delay += 1000;
 				break;
 			}
 			break;
@@ -1053,7 +1053,7 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			if (!priv->out_down_pending && priv->out_down_delay) {
 				dev_dbg(component->dev, "Power down delay: %d\n",
 					priv->out_down_delay);
-				msleep(priv->out_down_delay);
+				fsleep(priv->out_down_delay);
 				priv->out_down_delay = 0;
 			}
 			break;
diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index b24d6472ad5fc..fbfd7fb7f1685 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -2322,10 +2322,10 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 	case CS42L92:
 	case CS47L92:
 	case CS47L93:
-		out_up_delay = 6;
+		out_up_delay = 6000;
 		break;
 	default:
-		out_up_delay = 17;
+		out_up_delay = 17000;
 		break;
 	}
 
@@ -2356,7 +2356,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_up_pending--;
 			if (!priv->out_up_pending) {
-				msleep(priv->out_up_delay);
+				fsleep(priv->out_up_delay);
 				priv->out_up_delay = 0;
 			}
 			break;
@@ -2375,7 +2375,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3L_ENA_SHIFT:
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending++;
-			priv->out_down_delay++;
+			priv->out_down_delay += 1000;
 			break;
 		default:
 			break;
@@ -2392,7 +2392,7 @@ int madera_out_ev(struct snd_soc_dapm_widget *w,
 		case MADERA_OUT3R_ENA_SHIFT:
 			priv->out_down_pending--;
 			if (!priv->out_down_pending) {
-				msleep(priv->out_down_delay);
+				fsleep(priv->out_down_delay);
 				priv->out_down_delay = 0;
 			}
 			break;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 502196253d42a..64eee0d2347da 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -302,7 +302,7 @@ static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
 		} else {
 			wseq = wm5110_no_dre_left_enable;
 			nregs = ARRAY_SIZE(wm5110_no_dre_left_enable);
-			priv->out_up_delay += 10;
+			priv->out_up_delay += 10000;
 		}
 		break;
 	case ARIZONA_OUT1R_ENA_SHIFT:
@@ -312,7 +312,7 @@ static int wm5110_hp_pre_enable(struct snd_soc_dapm_widget *w)
 		} else {
 			wseq = wm5110_no_dre_right_enable;
 			nregs = ARRAY_SIZE(wm5110_no_dre_right_enable);
-			priv->out_up_delay += 10;
+			priv->out_up_delay += 10000;
 		}
 		break;
 	default:
@@ -338,7 +338,7 @@ static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
 			snd_soc_component_update_bits(component,
 						      ARIZONA_SPARE_TRIGGERS,
 						      ARIZONA_WS_TRG1, 0);
-			priv->out_down_delay += 27;
+			priv->out_down_delay += 27000;
 		}
 		break;
 	case ARIZONA_OUT1R_ENA_SHIFT:
@@ -350,7 +350,7 @@ static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
 			snd_soc_component_update_bits(component,
 						      ARIZONA_SPARE_TRIGGERS,
 						      ARIZONA_WS_TRG2, 0);
-			priv->out_down_delay += 27;
+			priv->out_down_delay += 27000;
 		}
 		break;
 	default:
-- 
2.39.5





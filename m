Return-Path: <stable+bounces-32-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BDA7F5CDF
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7331A28195D
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B42207F;
	Thu, 23 Nov 2023 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOEoa3ft"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C6019D
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 02:50:24 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a02d12a2444so94538566b.3
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700736623; x=1701341423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWmsEY1Lz0iuLAhKZp25wl97iTeJOnsV2iHbTLKdd7A=;
        b=wOEoa3ftwf0/QNhrOjF+Lr2PWC16AByfxoW6U+BRRovXRjxIMP/5bBrRoLLV2uyI57
         EZtzFLZxfMAS8BlXt7ql6ID22qIiTpD+xL0/IizinUusG4K53CKeanp+2uFQDj6jk+6V
         rnl6iCPKJA/26WbKixGLyAG6kVK21y+3b5fXUc5ACu0vlXIRELb3gmS7UMj8CNJ2pBPm
         vodSKoG9ON3izOSsmKRRjg7koK4hDC5gqV9quIFrLZoPLbGZSwlguNSeNQrbMmix0c3X
         AImZ6/pin6ZbcO9QBhUNFnmjM/NiR0hf91XzUs4R0JX7BCxcOpyiBH4xbknsFveQtTzg
         NBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736623; x=1701341423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWmsEY1Lz0iuLAhKZp25wl97iTeJOnsV2iHbTLKdd7A=;
        b=EHG81esZjPDs4yYTlF4PdS8Wmd+aiPFXIUOhTl030kkILCtsMQZaDg5ho24ANbR+iZ
         cvD+J9TybW11ctOVLIQNFt10zsKWZo2g7b2w3zdotB1wxw4/YUu9MQMrLlZgst1V3lNM
         ponWTXNrnAfoluT7Vcdsvk8iWSIEC2v2+8DTtygRzNfeWl3QPYab88TvwT9LskTKQN3H
         DPq72UAIZmHkv21AkqYy2t0+nCx45GA6yU7gXfRW/qTosBrOchNTwp6KnZNI+s980tJG
         aGL6bXJVNH7m8ewszRos+OvO7T53U7OueG3eTm2JZsMba2wo89TxyHFyj+jiZvyjWE2l
         atIg==
X-Gm-Message-State: AOJu0YzxXopZtmch4P00crfxUIRB9iEH2d33jmcXVeduq1CfOBuL5uhQ
	AsFRkRQ34RGh+SUWLTjyf+rlEA==
X-Google-Smtp-Source: AGHT+IEraM1i8wpahcqSKpNjXQf1ubzx9722VwGXlJdd0hjgZjfDv9ahWVogiErf9rtLA+YfTT4uCA==
X-Received: by 2002:a17:907:d046:b0:9b2:6d09:847c with SMTP id vb6-20020a170907d04600b009b26d09847cmr4337532ejc.10.1700736623254;
        Thu, 23 Nov 2023 02:50:23 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j27-20020a170906255b00b009e5db336137sm619208ejb.196.2023.11.23.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 02:50:22 -0800 (PST)
Message-ID: <11e09282-186b-43bd-b7ef-a179a4fe8f03@linaro.org>
Date: Thu, 23 Nov 2023 10:50:21 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] soundwire: bus: introduce controller_id
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
 gregkh@linuxfoundation.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
 <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Pierre for the patch,

On 17/10/2023 17:09, Pierre-Louis Bossart wrote:
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 55be9f4b8d59..e3ae4e4e07ac 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1612,6 +1612,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	/* FIXME: is there a DT-defined value to use ? */
> +	ctrl->bus.controller_id = -1;
> +

We could do a better than this, on Qcom IP we have a dedicated register 
to provide a master id value. I will send a patch to add this change on 
top of this patchset.

--------------------------------->cut<-------------------------------
 From 78c516995d652324daadbe848fa787dabcede73f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 23 Nov 2023 10:43:02 +0000
Subject: [PATCH] soundwire: qcom: set controller id to hw master id

Qualcomm Soundwire Controllers IP version after 1.3 have a dedicated
master id register which will provide a unique id value for each
controller instance. Use this value instead of artificially generated
value from idr. Versions 1.3 and below only have one instance of
soundwire controller which does no have this register, so let them use
value from idr.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
  drivers/soundwire/qcom.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 8e027eee8b73..48291fbaf674 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1624,9 +1624,13 @@ static int qcom_swrm_probe(struct platform_device 
*pdev)
  		}
  	}

-	/* FIXME: is there a DT-defined value to use ? */
  	ctrl->bus.controller_id = -1;

+	if (ctrl->version > SWRM_VERSION_1_3_0) {
+		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
+		ctrl->bus.controller_id = val;
+	}
+
  	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
  	if (ret) {
  		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
-- 
2.42.0
--------------------------------->cut<-------------------------------


thanks,
Srini
>   	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
>   	if (ret) {
>   		dev_err(dev, "Failed to register Soundwire controller (%d)\n",


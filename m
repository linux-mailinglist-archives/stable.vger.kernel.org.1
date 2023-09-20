Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6CF7A8D9B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjITUNa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjITUN3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 16:13:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4FA9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 13:13:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso2104835e9.2
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695240797; x=1695845597; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zd8Do9SJJUDst37nmnERp+r9LxKeGK/VDgtvpwIPuCY=;
        b=XH00e/Bqpj344sIhJsu42IBEMyjpG9NZQA2sxZwefzELniYcifxD8hrDFlhzfzol21
         rTQ6FEra+fMeit7Q3DbMSF4TEdFMOwFwfgZc5ATUZT4Z+GVy+Xq0P5cuY2apXzABV7y/
         5/NpN1HAYybobV4lRNMIrO8EeN4KcstCCJWbjBQSyDcwgIzCiQTfT0n7aYyOmpXwVw7D
         HGSrBMaYZEaTssmGHnA1nma6PFeR5GL1yjce06kQ1h7WM3TVpAb0RUcxV4tSrmIu7mcP
         H1bwQv7L57AHouACbcuzsa3o6g8EPyobnxVBkZYo4mXj2dGFSJ5U7SbGeuCbcfmuL5/C
         dGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240797; x=1695845597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zd8Do9SJJUDst37nmnERp+r9LxKeGK/VDgtvpwIPuCY=;
        b=prveeRl51Hl/QGDlemVaR9XIkRV4wHM/nBjOQULnyhVre+AHzYnDqFjk2cnVn8wh4/
         8p+itZTzXtgRYNU7DxUwxtmUmXaAYcayjDCc17krqKJH9OaFSLTPcVjc7NyNCEJr9PLy
         pXtIfKH3nlXpzDnACrhK4kbqgMUOa2fL/eeB0vzQ4x0gn1r44wmyc6q6YSA4GudZknKu
         Lh7rjG/V23x/+FaBu9Y5K+o965JUsSNT9nx8lyfZBiDvBM25iiiAf6Nfe+0FLy8e0548
         b7V5szYBvwjsgsZJYuUvH2m/Kr/7hnsRAPvTR9XTSNmwa0iMBHflX9HDE9jtl+IR0xda
         9yPw==
X-Gm-Message-State: AOJu0YyPhoG6nlOqDy/tkq5Lh1yee93HmRaRjjaLljXYtcMPIEBT9G+j
        IVu4eLkwWJUayVufD86xM7Q=
X-Google-Smtp-Source: AGHT+IGar0PuT+VjHqU64mWQ3i2PiNibAkrooc0IjrAJPYVu/s5ByDeuaxe9SVZq4z3GLtKPFhBI6g==
X-Received: by 2002:adf:ee11:0:b0:314:350a:6912 with SMTP id y17-20020adfee11000000b00314350a6912mr3418365wrn.36.1695240797195;
        Wed, 20 Sep 2023 13:13:17 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id k1-20020adfd221000000b003217c096c1esm1390198wrh.73.2023.09.20.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 13:13:15 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id B7506BE2DE0; Wed, 20 Sep 2023 22:13:14 +0200 (CEST)
Date:   Wed, 20 Sep 2023 22:13:14 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 27/83] ASoC: Intel: sof_sdw: Update BT offload
 config for soundwire config
Message-ID: <ZQtSWm3ycmA1W7Ry@eldamar.lan>
References: <20230920112826.634178162@linuxfoundation.org>
 <20230920112827.751203739@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920112827.751203739@linuxfoundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On Wed, Sep 20, 2023 at 01:31:17PM +0200, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Uday M Bhat <uday.m.bhat@intel.com>
> 
> [ Upstream commit a14aded9299187bb17ef90700eb2cf1120ef5885 ]
> 
> For soundwire config, SSP1 is used for BT offload. This is enabled
> in sof_sdw_quirk_table
> 
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Uday M Bhat <uday.m.bhat@intel.com>
> Signed-off-by: Jairaj Arava <jairaj.arava@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Link: https://lore.kernel.org/r/20230731214257.444605-5-pierre-louis.bossart@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/soc/intel/boards/sof_sdw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
> index f36a0fda1b6ae..1955d277fdf20 100644
> --- a/sound/soc/intel/boards/sof_sdw.c
> +++ b/sound/soc/intel/boards/sof_sdw.c
> @@ -214,7 +214,9 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Rex"),
>  		},
> -		.driver_data = (void *)(SOF_SDW_PCH_DMIC),
> +		.driver_data = (void *)(SOF_SDW_PCH_DMIC |
> +					SOF_BT_OFFLOAD_SSP(1) |
> +					SOF_SSP_BT_OFFLOAD_PRESENT),
>  	},
>  	/* LunarLake devices */
>  	{
> -- 
> 2.40.1

I see the following build issue while trying to check 5.10.196-rc1:

sound/soc/intel/boards/sof_sdw.c:218:6: error: implicit declaration of function ‘SOF_BT_OFFLOAD_SSP’ [-Werror=implicit-function-declaration]
  218 |      SOF_BT_OFFLOAD_SSP(1) |
      |      ^~~~~~~~~~~~~~~~~~
sound/soc/intel/boards/sof_sdw.c:219:6: error: ‘SOF_SSP_BT_OFFLOAD_PRESENT’ undeclared here (not in a function)
  219 |      SOF_SSP_BT_OFFLOAD_PRESENT),
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[7]: *** [scripts/Makefile.build:286: sound/soc/intel/boards/sof_sdw.o] Error 1

Regards,
Salvatore

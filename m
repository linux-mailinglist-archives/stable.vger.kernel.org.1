Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1308372C253
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbjFLLEP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbjFLLDx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53AD83D0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30fc1514745so805774f8f.2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686567117; x=1689159117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ycCU1WFirww0GTp9dYLaO0PoUvSleR8ila3gnMax00=;
        b=eAqKzQ8ktefVTbS9DWZ0oTAIrceaxz3tqoIV/g8BVsWxXnrZXzGsCRO7r0Jq2d1VQm
         GLNvGrp/6fEFlchniYMSgUVg5EsUVw6oXjauQmIZa2A+tfTER94NpfhHB7hCDuew7RoU
         uauRz25jTVIqCd/jpNm/+Q56oPkiGpr+5xZ/XSJMDpbRmjnaje2Kbtp6Z3DQFsRi4GcP
         AxSa07zzYiM45pqWn0E1JbwXmtYjCH+V1QnEAvTfomctKBsLkLj5TNZmsekZnrJAYJLn
         gUCIdo1LiRER/4qoMlfuhcE4cxheUnGEifHYOuS7mSFS7N32Io8Fuu51LE4D9mMF2nFh
         pwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567117; x=1689159117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ycCU1WFirww0GTp9dYLaO0PoUvSleR8ila3gnMax00=;
        b=UzOyzsxsh3tDdytrj6PmmHmMY/VGnAz5aTCjSM5jS7znBYzuJHanMq80IplVVfayvf
         2T4nl5FRvtDFeQp8dloCjMqKIZy0KsWcn9wpBDWymXJzaNEBPew+z1lpiV6d0U4GfoUc
         4jz/hsx4yKmTcb0RgNFO9MpxmNIMg/tdlaWSSo5DbfR29wABbM4uLWbi8B+nH2wAqzX2
         EBtpYGRBnhXohztYwEnOr36AqfUUr3b9NMvHlNOeVHeMK+WsQrkgrHzw+W2d7MAP8sic
         v49SvmHLtFrtJYyhO4sB2URSs4Z1ybilmHuKz2+w4cH4hz3qplvrl6Q8KzRfjnkvVjUE
         ZYKg==
X-Gm-Message-State: AC+VfDw+WzwbyB8UZlgVXWNG4vyMwnYCsG3W3U1I10NnmX0r42zpf9ZS
        82/k00v4hX4bjpEPoAqDFWS0qQ==
X-Google-Smtp-Source: ACHHUZ7bIyj2QviICABh0wFHPxLxoXHDE1CaZr5LiKxYYn+FIFOIJfIdpNzvxOvdDcSMQ9YqXbHQZQ==
X-Received: by 2002:a5d:66c1:0:b0:307:8b3e:285a with SMTP id k1-20020a5d66c1000000b003078b3e285amr4618158wrw.67.1686567117352;
        Mon, 12 Jun 2023 03:51:57 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.153])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003095bd71159sm12226779wrz.7.2023.06.12.03.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:51:56 -0700 (PDT)
Message-ID: <2a33ff36-d8f6-bd23-b7e3-4c1f1c00330a@linaro.org>
Date:   Mon, 12 Jun 2023 11:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/5] mtd: spi-nor: spansion: Preserve CFR2V[7] when
 writing MEMLAT
Content-Language: en-US
To:     tkuw584924@gmail.com, linux-mtd@lists.infradead.org
Cc:     pratyush@kernel.org, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, d-gole@ti.com,
        Bacem.Daassi@infineon.com,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        stable@vger.kernel.org
References: <cover.1686557139.git.Takahiro.Kuwano@infineon.com>
 <15d87d29e53945739e7c2b3f58e2f623e2a77f08.1686557139.git.Takahiro.Kuwano@infineon.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <15d87d29e53945739e7c2b3f58e2f623e2a77f08.1686557139.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 6/12/23 11:04, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> CFR2V[7] is assigned to Flash's address mode (3- or 4-ybte) and must not
> be changed when writing MEMLAT (CFR2V[3:0]). CFR2V must be read first,
> modified only CFR2V[3:0], then written back.

Last sentence could be reworded to "CFR2V shall be used in a read,
update, write back fashion."

Please specify in the commit message if this fixes a present bug or it's
just a prerequisite for the support that comes. The change is good but
we should be aware if you hit bugs or not.
> 
> Fixes: c3266af101f2 ("mtd: spi-nor: spansion: add support for Cypress Semper flash")
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/mtd/spi-nor/spansion.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index f2f4bc060f5e..7804be3a9f2a 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -27,6 +27,7 @@
>  #define SPINOR_REG_CYPRESS_CFR2			0x3
>  #define SPINOR_REG_CYPRESS_CFR2V					\
>  	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR2)
> +#define SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK	GENMASK(3, 0)
>  #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
>  #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
>  #define SPINOR_REG_CYPRESS_CFR3			0x4
> @@ -162,8 +163,17 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
>  	int ret;
>  	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
>  
> +	op = (struct spi_mem_op)
> +		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
> +					  SPINOR_REG_CYPRESS_CFR2V, 0, buf);
> +
> +	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> +
>  	/* Use 24 dummy cycles for memory array reads. */
> -	*buf = SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
> +	*buf &= ~SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK;
> +	*buf |= SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;

Use FIELD_PREP please.

>  	op = (struct spi_mem_op)
>  		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
>  					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);

Shall you zeroize the struct before using it again?

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36547720ADD
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 23:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjFBVL3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 17:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBVL2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 17:11:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8CB1A1
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 14:11:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9755A18640D;
        Fri,  2 Jun 2023 17:11:26 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=f8ShItLV8CgghuGuwOojfc7jC2wXuOhPcJdUrt
        uYthc=; b=i2a/7j0RFUPfdHun3yYctOWxM3IPxNuh0kYkSPfYUwcOTzbciZg6/l
        sxMeuF5wO50gvvK/4qQZcgZ/dYFWG3vcD9DeWJvLZyiz+SifjACHe8EZJ4DwT0N+
        EDihUHmGMjw2dZNPT+vraLKQsNKWOndGKK2qYRRQj3Rn1sjm/dL5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E42418640C;
        Fri,  2 Jun 2023 17:11:26 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=f8ShItLV8CgghuGuwOojfc7jC2wXuOhPcJdUrtuYthc=; b=Z0kC22iHVruWmbGvcO7AF/5+zSBH27jOjNdFasgRVZ5ktnLP3AkcFYW20fJKHuwV1FWBVP20hRQbLhUbNqny2Lu3x1tAol1ZunYmi5DPDCcq44IXCg4FKS0XI5MJ3I3qxMEjIDkk5pqXi2vaO3pp6oxliHaAM8FfCEN5YQLvt18=
Received: from yoda.home (unknown [184.162.17.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03FA818640B;
        Fri,  2 Jun 2023 17:11:26 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [10.0.0.101])
        by yoda.home (Postfix) with ESMTPSA id B3F3C7CF1F3;
        Fri,  2 Jun 2023 17:11:24 -0400 (EDT)
Date:   Fri, 2 Jun 2023 17:11:24 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: cfi_cmdset_0001: Byte swap OTP info
In-Reply-To: <20230602204359.3493320-1-linus.walleij@linaro.org>
Message-ID: <1nqsp3n7-n82r-698p-sn82-0231n75p7216@syhkavp.arg>
References: <20230602204359.3493320-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 08D51708-018A-11EE-96D9-307A8E0A682E-78420484!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 2 Jun 2023, Linus Walleij wrote:

> Currently the offset into the device when looking for OTP
> bits can go outside of the address of the MTD NOR devices,
> and if that memory isn't readable, bad things happen
> on the IXP4xx (added prints that illustrate the problem before
> the crash):
> 
> cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x00000100
> ixp4xx_copy_from copy from 0x00000100 to 0xc880dd78
> cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x12000000
> ixp4xx_copy_from copy from 0x12000000 to 0xc880dd78
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address db000000
> [db000000] *pgd=00000000
> (...)
> 
> This happens in this case because the IXP4xx is big endian and
> the 32- and 16-bit fields in the struct cfi_intelext_otpinfo are not
> properly byteswapped. Compare to how the code in read_pri_intelext()
> byteswaps the fields in struct cfi_pri_intelext.
> 
> Adding a small byte swapping loop for the OTP in read_pri_intelext()
> and the crash goes away.
> 
> The problem went unnoticed for many years until I enabled
> CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.
> 
> Cc: Nicolas Pitre <npitre@baylibre.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>

> ---
> ChangeLog v2->v3:
> - Move the byte swapping to a small loop in read_pri_intelext()
>   so all bytes are swapped as we reach cfi_intelext_otp_walk().
> ChangeLog v1->v2:
> - Drill deeper and discover a big endian compatibility issue.
> ---
>  drivers/mtd/chips/cfi_cmdset_0001.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
> index 54f92d09d9cf..02aaf09d6f5c 100644
> --- a/drivers/mtd/chips/cfi_cmdset_0001.c
> +++ b/drivers/mtd/chips/cfi_cmdset_0001.c
> @@ -421,9 +421,25 @@ read_pri_intelext(struct map_info *map, __u16 adr)
>  		extra_size = 0;
>  
>  		/* Protection Register info */
> -		if (extp->NumProtectionFields)
> +		if (extp->NumProtectionFields) {
> +			struct cfi_intelext_otpinfo *otp =
> +				(struct cfi_intelext_otpinfo *)&extp->extra[0];
> +
>  			extra_size += (extp->NumProtectionFields - 1) *
> -				      sizeof(struct cfi_intelext_otpinfo);
> +				sizeof(struct cfi_intelext_otpinfo);
> +
> +			if (extp_size >= sizeof(*extp) + extra_size) {
> +				int i;
> +
> +				/* Do some byteswapping if necessary */
> +				for (i = 0; i < extp->NumProtectionFields - 1; i++) {
> +					otp->ProtRegAddr = le32_to_cpu(otp->ProtRegAddr);
> +					otp->FactGroups = le16_to_cpu(otp->FactGroups);
> +					otp->UserGroups = le16_to_cpu(otp->UserGroups);
> +					otp++;
> +				}
> +			}
> +		}
>  	}
>  
>  	if (extp->MinorVersion >= '1') {
> -- 
> 2.40.1
> 
> 

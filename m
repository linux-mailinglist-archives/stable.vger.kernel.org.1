Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F261576FE5D
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjHDKYW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjHDKYV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:24:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0F30F6
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:24:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 98A373200319;
        Fri,  4 Aug 2023 06:24:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 04 Aug 2023 06:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691144655; x=1691231055; bh=WW
        Wx8vA3jttFz/l/kqhUdIbz1oSt+W7uK3OEb3BhEzg=; b=w3BNtQpS9re0va+arY
        XjK3MYENksWw4URQA1vTsbH84GB/xqLdZslvAx0P3mLKTXl8JJ04Vg6HYTxTP6km
        bKYU6BA83sDUSQ0Cbdkddk80aSoBT3xiHEUGXzEd16rFkr/DWoFasF7/+ffANOP4
        ex2IkRbUEoqvDus4xAvzxLrCs1KhRpbf09M0e8N2PMbfyq0GMq1ZVG4EFhgsG0MU
        meSa04hDOHNTpK8cw3ZRYPVyc5DkKtXKcwbIzE20kIa+CL8aa5GjRYBvd3BQEx8Y
        jgAEFexC164Sb+LkrrubnedFHa5DNZpTpFHNqz5Nq8GF54VQW75DZWNfKwpcay7V
        /aww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691144655; x=1691231055; bh=WWWx8vA3jttFz
        /l/kqhUdIbz1oSt+W7uK3OEb3BhEzg=; b=08HRUFm1bsmArvwrmGtmmUpitQLFm
        /QXsCMgV7MX1QLrFk7jPVLf3OkXa9WVWDne1PqtR6R0q+iLm9LI/67+N+EPg6A5Q
        yzks40F+ksSy+6uCNIF+e3iR6KFxApLBd+4nVktzOqGwLBUkre8o1lcD+OXvWC2X
        r/uKwEm/gJgr8fiPR5Xk1CeEHvqdElG9Lizmnx6Z4liU+iK++KgrhgL7PjHpycdO
        RVwMOvuYIVcAmcmcMfGUyuIJiDGavXUO72ApkhrHiSm0lswhVb+5X1JrBDcF8jnn
        ptUHvJOC4rCPoUnP1sSp2kc1zzzXEDudi1DFqw8LUYA9L1vsj/8JP9cDw==
X-ME-Sender: <xms:ztHMZMzykzp1Y88OBDWaWZqLtqCQRib5FBf_XlEIi-w9TJpI9RsIkQ>
    <xme:ztHMZATFJ-GylcxBEQ0WJFt4RGQmdyrU29GBSY28aAdjkXosB_Wdilh7ILpZFWHhL
    sZaCOGeZpzLgw>
X-ME-Received: <xmr:ztHMZOXSAKg_Fue-vMJT3Cjz2TIZXNGZSIVZvxJnBzmyRRaB9-CRazPBgpEaF4PSyZnGVnulR-vtbQm6Ro-Kot_g9tEw-lSoY4saxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:ztHMZKj10ot2g1erPEwP4EqyCpljUNzQU3oDI_AO-mLQW36X-9cyhg>
    <xmx:ztHMZOBMq3QNkZ-k1DUvWbJumdX0v-9xarnbNQrlz5JFYDoeirxnVg>
    <xmx:ztHMZLKXZzNOVrLpYu6hbC-inMdAPmIKgFzmTt5CRZMbJyYfxTNrKg>
    <xmx:z9HMZK0-TlEym_xEdqtfvHscptsH0tcWXKlSDzqdEu9LUhVlC6VzlA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Aug 2023 06:24:14 -0400 (EDT)
Date:   Fri, 4 Aug 2023 12:24:12 +0200
From:   Greg KH <greg@kroah.com>
To:     ovidiu.panait@windriver.com
Cc:     stable@vger.kernel.org,
        D Scott Phillips <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 5.4 1/2] arm64: Add AMPERE1 to the Spectre-BHB affected
 list
Message-ID: <2023080406-wow-repeated-09d9@gregkh>
References: <20230801093736.4110870-1-ovidiu.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801093736.4110870-1-ovidiu.panait@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 12:37:35PM +0300, ovidiu.panait@windriver.com wrote:
> From: D Scott Phillips <scott@os.amperecomputing.com>
> 
> commit 0e5d5ae837c8ce04d2ddb874ec5f920118bd9d31 upstream.
> 
> Per AmpereOne erratum AC03_CPU_12, "Branch history may allow control of
> speculative execution across software contexts," the AMPERE1 core needs the
> bhb clearing loop to mitigate Spectre-BHB, with a loop iteration count of
> 11.
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> Link: https://lore.kernel.org/r/20221011022140.432370-1-scott@os.amperecomputing.com
> Reviewed-by: James Morse <james.morse@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
>  arch/arm64/include/asm/cputype.h | 4 ++++
>  arch/arm64/kernel/cpu_errata.c   | 6 ++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index f0165df489a3..08241810cfea 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -59,6 +59,7 @@
>  #define ARM_CPU_IMP_NVIDIA		0x4E
>  #define ARM_CPU_IMP_FUJITSU		0x46
>  #define ARM_CPU_IMP_HISI		0x48
> +#define ARM_CPU_IMP_AMPERE		0xC0
>  
>  #define ARM_CPU_PART_AEM_V8		0xD0F
>  #define ARM_CPU_PART_FOUNDATION		0xD00
> @@ -101,6 +102,8 @@
>  
>  #define HISI_CPU_PART_TSV110		0xD01
>  
> +#define AMPERE_CPU_PART_AMPERE1		0xAC3
> +
>  #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
>  #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
>  #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
> @@ -131,6 +134,7 @@
>  #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
>  #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
>  #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
> +#define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
>  
>  /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
>  #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index b18f307a3c59..342cba2ae982 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -1145,6 +1145,10 @@ u8 spectre_bhb_loop_affected(int scope)
>  			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>  			{},
>  		};
> +		static const struct midr_range spectre_bhb_k11_list[] = {
> +			MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> +			{},
> +		};
>  		static const struct midr_range spectre_bhb_k8_list[] = {
>  			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
>  			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> @@ -1155,6 +1159,8 @@ u8 spectre_bhb_loop_affected(int scope)
>  			k = 32;
>  		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
>  			k = 24;
> +		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
> +			k = 11;
>  		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
>  			k =  8;
>  
> -- 
> 2.39.1
> 

Both now queued up, thanks.

greg k-h

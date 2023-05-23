Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84B70D12E
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 04:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjEWCZU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 22:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjEWCZT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 22:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7C11F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B30B62DF0
        for <stable@vger.kernel.org>; Tue, 23 May 2023 02:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F4FC433D2;
        Tue, 23 May 2023 02:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684808716;
        bh=sFUz6+S3tvg5IvXMGVGst7rczjx5uC0SWhIKXcqJU2Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R+R+yrw1dWh7K3Yhsp3aamoCLHtb4oU0eFDRt/fb4mHD7OYAgR7JCZORRHFSn3azZ
         sn72NeYgXvUCseGg076bXOyoUbcuK145Y02mM9F+gKq5wAflG43HGwQ9vY9CLFQUaT
         HFzeUHqsiZqX9cGlQZzv+x6FQ372mX+U94mxbY/DpxAjF8WLkMB03On9EL1nHHHits
         8TyIowX5GIKLUXdwuyzjbte/mebMaYcRpDLamYCAI95avYW7Gm/O9S4Atc29goCPZe
         hGK5Y6ACP8LLCnAlKoxCtpJ1sf3W09YzmZMgjuDUgL7ZfsZjv/P4v61m6tgfboe9MB
         M5XXvmyEXUBNg==
Message-ID: <5450bd82-6a2a-7147-1b99-8c0e1efc724f@kernel.org>
Date:   Tue, 23 May 2023 11:25:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: FAILED: patch "[PATCH] dt-bindings: ata: ahci-ceva: Cover all 4
 iommus entries" failed to apply to 5.15-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, michal.simek@amd.com,
        krzysztof.kozlowski@linaro.org
Cc:     stable@vger.kernel.org
References: <2023052249-duplex-pampered-89cb@gregkh>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2023052249-duplex-pampered-89cb@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/23/23 02:58, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x a7844528722619d2f97740ae5ec747afff18c4be
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052249-duplex-pampered-89cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> Possible dependencies:
> 
> a78445287226 ("dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries")
> f2fb1b50fbac ("dt-bindings: ata: ahci-ceva: convert to yaml")

Mikal,

Do you need this patch added to 5.15 stable as well ? If yes, then please send a
backport. I think the issue is that the bindings file in 5.15 is not yaml format.

> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From a7844528722619d2f97740ae5ec747afff18c4be Mon Sep 17 00:00:00 2001
> From: Michal Simek <michal.simek@amd.com>
> Date: Fri, 12 May 2023 13:52:04 +0200
> Subject: [PATCH] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries
> 
> Current only one entry is enabled but IP itself is using 4 different IDs
> which are already listed in zynqmp.dtsi.
> 
> sata: ahci@fd0c0000 {
> 	compatible = "ceva,ahci-1v84";
> 	...
> 	iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
> 		 <&smmu 0x4c2>, <&smmu 0x4c3>;
> };
> 
> Fixes: 8ac47837f0e0 ("arm64: dts: zynqmp: Add missing iommu IDs")
> Cc: stable@vger.kernel.org # v5.12+
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> index 9b31f864e071..71364c6081ff 100644
> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> @@ -32,7 +32,7 @@ properties:
>      maxItems: 1
>  
>    iommus:
> -    maxItems: 1
> +    maxItems: 4
>  
>    power-domains:
>      maxItems: 1
> 

-- 
Damien Le Moal
Western Digital Research


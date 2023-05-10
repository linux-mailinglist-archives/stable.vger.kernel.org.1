Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7226FE54A
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjEJUky (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJUkx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 16:40:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5F55FD2
        for <stable@vger.kernel.org>; Wed, 10 May 2023 13:40:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaf2ede38fso74966525ad.2
        for <stable@vger.kernel.org>; Wed, 10 May 2023 13:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683751252; x=1686343252;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3K6nAunvvqU+tkofP8qzXjG71Qeq6x9p+fbsBeGbDek=;
        b=lLOFXLAIykmhYu/3xR51sQoM/r+CgP0efdyPQlsf7oBLO+CqPGT52cB196pyiAVlRo
         8ztU5a8nteZ2g+loaBBowINQurLD/6Jbfrmkj6UHPiAtDU+XguauXg8+F4is79QCgAgm
         scH/ZSz5Aj5e0K+hon0ez5RYb9KVfT5G6au5zViroaWSqVj286nvZRlfKevEp0IZpFaO
         6uYmZIsvNgcN6SMn3dU/KXMe2rvUp10Ypa7KlKLCdlmtvnZWmAlRxILRcn1uadRarHlG
         SxoqJUgF1qS4U1aq1djWRJW8JerpzUzv+xrpsjKLcmSdIiAakOo56f3ByXyuWNCLQo91
         Mzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751252; x=1686343252;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3K6nAunvvqU+tkofP8qzXjG71Qeq6x9p+fbsBeGbDek=;
        b=ZvStm08j8qKhXF/JuDYNZKB54SynuB1Md/v30aoZmy9L9xrIJBXfcNETJOV4j9N6lh
         QdQVtxUp0krw95zdhxG5wj46g2FoY+KlmuX81qls3TJpV1D0pGA8ByzoXGREPtfGLYJp
         06dfXPV8O6ScTue8p38MD36XqIDJ8WP/Qpq0XY9Nn3dALz/qSUhwX53GptjuDcJT85XA
         HbwwTKxcPs8shN9zyLvcnSEScpNb4W+z0g6W9h07oZcojGqTegTdTV45iQsbWd7skAOK
         ToQefwmkMyvhye4ibQDVHJLjMDdTo76uVuqzAuMwtmmiZCs2sZhoff7stgsVTGG26VCE
         oXyg==
X-Gm-Message-State: AC+VfDxDFd9KmCZdh/Mi9DAim3uxoW5TM8QiPemJiILu2Gp0HlnDnssd
        KOe0VgC/xgYm9v08JYgRrqU=
X-Google-Smtp-Source: ACHHUZ6lDgMesTVIiV1HTF4YmuyZWwVT01J4tksWd/wf6DezhiYBlI30Xt+s3DB0qgxbTGjrE1yMNw==
X-Received: by 2002:a17:902:eccc:b0:1ac:b449:352d with SMTP id a12-20020a170902eccc00b001acb449352dmr4116398plh.61.1683751252177;
        Wed, 10 May 2023 13:40:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001a9b7584824sm4222107plb.159.2023.05.10.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:40:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 10 May 2023 13:40:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Conor Dooley <conor@kernel.org>
Cc:     stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        palmer@dabbelt.com
Subject: Re: [PATCH 6.1 v1] RISC-V: fix lock splat in
 riscv_cpufeature_patch_func()
Message-ID: <0bcbfbd5-4702-48d4-81dc-118cefc63f46@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 10:36:42PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Guenter reported a lockdep splat that appears to have been present for a
> while in v6.1.y & the backports of the riscv_patch_in_stop_machine dance
> did nothing to help here, as the lock is not being taken when
> patch_text_nosync() is called in riscv_cpufeature_patch_func().
> Add the lock/unlock; elide the splat.
> 
> Fixes: c15ac4fd60d5 ("riscv/ftrace: Add dynamic function tracer support")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> cc: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  arch/riscv/kernel/cpufeature.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 694267d1fe81..fd1238df6149 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -9,6 +9,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/ctype.h>
>  #include <linux/libfdt.h>
> +#include <linux/memory.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <asm/alternative.h>
> @@ -316,8 +317,11 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  		}
>  
>  		tmp = (1U << alt->errata_id);
> -		if (cpu_req_feature & tmp)
> +		if (cpu_req_feature & tmp) {
> +			mutex_lock(&text_mutex);
>  			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> +			mutex_unlock(&text_mutex);
> +		}
>  	}
>  }
>  #endif
> -- 
> 2.39.2
> 

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AC5722435
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 13:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFELJm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 07:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFELJk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 07:09:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF779B8
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 04:09:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso46533705e9.1
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 04:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685963377; x=1688555377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JY8Arx3uiXxRo3IN7aHfCeXojOgXimIgswmmtyKlK6U=;
        b=eG/wF/djQMjYXbfkHBpixqn7v7uPk8UmTtqH8M4vVFGBpzu0co3WalizOxUiFgXIUj
         vt6P4Vcu8jvNRR+d+JiPf0vTnoREHyfkcZoL36uz5vxI81jON1qB9yrZGmxcEVI6Glhh
         01XEUgq1VIuWPbr+9YEytZMTV2VhQsKi0vaIMhAdzFIX3kVcczc6WXIqSz35B+CDJsb6
         fJp3ubSa/3j3Xd81jbGkRJkZSGwzJpJbJBgtikSOrS6Z4cKp8zsYNKzmyEl2ubyvtdM6
         gxbMR4WrlilOUy4WNPdP2FTiSdpRunwfBESDIgUcXbDZy9GVJ+1DG8Tu9e3ZAgvjOk7l
         mtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963377; x=1688555377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JY8Arx3uiXxRo3IN7aHfCeXojOgXimIgswmmtyKlK6U=;
        b=Kvg2PV4Ijq5y5MXTIrQQ1p98p2DSkTfkh8YRabAVzTfSXLGYzR7iXR1bztz2beJUjc
         jVhwLyfqTqWRbUpD83v5PCTwQsdgL/JRWvuEY1VlwyZriOEu5alPEwujhplHSew8hRSy
         Vta0WU+m0rWEzWSMhPoDXq1zHQhseHv1KqUmkwuNwF0DmS7v9Chi5k85TQlJwqTwfC+P
         FZOaByIcCeH3bq0zYhl++sntTsjvUbOfnXO7/dilggFge1VQAiUbZugFGaZBXjzk3Y4c
         USouHlJKq5auboA5Sg0O2XPBMmpH2dHMy1NGj2JqEZqG1X3mtCFen/pHgM9PnKWSgp/v
         df+g==
X-Gm-Message-State: AC+VfDwiL/FnwAxwN+DkbpMeAp0hNq+hkKRniZKy0o9/l9xBQnzGKCHL
        HdqgaQUxd4yR4GPBv96t2SNokEZJULFl1NFtPH7pmQ==
X-Google-Smtp-Source: ACHHUZ6pRUNR2xuzKigxvU7YDDFqjVsWmdar7ZoIcQss6g5SQlJT7XrxGuJj3bn2p4HuvZBErXT1Rw==
X-Received: by 2002:a05:6000:1047:b0:30e:455d:930c with SMTP id c7-20020a056000104700b0030e455d930cmr1206417wrx.6.1685963377373;
        Mon, 05 Jun 2023 04:09:37 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id j18-20020a5d4652000000b0030ae54e575csm9440057wrs.59.2023.06.05.04.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:09:37 -0700 (PDT)
Message-ID: <29be6dca-65c3-adaf-b92a-a39aef9aa6e6@linaro.org>
Date:   Mon, 5 Jun 2023 12:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: FAILED: patch "[PATCH] net: cdc_ncm: Deal with too low values of
 dwNtbOutMaxSize" failed to apply to 4.19-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, kuba@kernel.org,
        simon.horman@corigine.com
Cc:     stable@vger.kernel.org, Lee Jones <joneslee@google.com>
References: <2023052623-tricky-machinist-46c5@gregkh>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2023052623-tricky-machinist-46c5@gregkh>
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

Hi!

In order to apply this without conflicts to 4.19-stable, one needs to
apply a dependency, thus the sequence is:

7e01c7f7046e ("net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize")
0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")

Let me know if you want me to send the patches explicitly.
Cheers,
ta

On 5/26/23 20:04, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7e01c7f7046efc2c7c192c3619db43292b98e997
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052623-tricky-machinist-46c5@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> 
> Possible dependencies:
> 
> 7e01c7f7046e ("net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize")
> 2be6d4d16a08 ("net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero")
> 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 7e01c7f7046efc2c7c192c3619db43292b98e997 Mon Sep 17 00:00:00 2001
> From: Tudor Ambarus <tudor.ambarus@linaro.org>
> Date: Wed, 17 May 2023 13:38:08 +0000
> Subject: [PATCH] net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize
> 
> Currently in cdc_ncm_check_tx_max(), if dwNtbOutMaxSize is lower than
> the calculated "min" value, but greater than zero, the logic sets
> tx_max to dwNtbOutMaxSize. This is then used to allocate a new SKB in
> cdc_ncm_fill_tx_frame() where all the data is handled.
> 
> For small values of dwNtbOutMaxSize the memory allocated during
> alloc_skb(dwNtbOutMaxSize, GFP_ATOMIC) will have the same size, due to
> how size is aligned at alloc time:
> 	size = SKB_DATA_ALIGN(size);
>         size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> Thus we hit the same bug that we tried to squash with
> commit 2be6d4d16a084 ("net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero")
> 
> Low values of dwNtbOutMaxSize do not cause an issue presently because at
> alloc_skb() time more memory (512b) is allocated than required for the
> SKB headers alone (320b), leaving some space (512b - 320b = 192b)
> for CDC data (172b).
> 
> However, if more elements (for example 3 x u64 = [24b]) were added to
> one of the SKB header structs, say 'struct skb_shared_info',
> increasing its original size (320b [320b aligned]) to something larger
> (344b [384b aligned]), then suddenly the CDC data (172b) no longer
> fits in the spare SKB data area (512b - 384b = 128b).
> 
> Consequently the SKB bounds checking semantics fails and panics:
> 
> skbuff: skb_over_panic: text:ffffffff831f755b len:184 put:172 head:ffff88811f1c6c00 data:ffff88811f1c6c00 tail:0xb8 end:0x80 dev:<NULL>
> ------------[ cut here ]------------
> kernel BUG at net/core/skbuff.c:113!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 57 Comm: kworker/0:2 Not tainted 5.15.106-syzkaller-00249-g19c0ed55a470 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> Workqueue: mld mld_ifc_work
> RIP: 0010:skb_panic net/core/skbuff.c:113 [inline]
> RIP: 0010:skb_over_panic+0x14c/0x150 net/core/skbuff.c:118
> [snip]
> Call Trace:
>  <TASK>
>  skb_put+0x151/0x210 net/core/skbuff.c:2047
>  skb_put_zero include/linux/skbuff.h:2422 [inline]
>  cdc_ncm_ndp16 drivers/net/usb/cdc_ncm.c:1131 [inline]
>  cdc_ncm_fill_tx_frame+0x11ab/0x3da0 drivers/net/usb/cdc_ncm.c:1308
>  cdc_ncm_tx_fixup+0xa3/0x100
> 
> Deal with too low values of dwNtbOutMaxSize, clamp it in the range
> [USB_CDC_NCM_NTB_MIN_OUT_SIZE, CDC_NCM_NTB_MAX_SIZE_TX]. We ensure
> enough data space is allocated to handle CDC data by making sure
> dwNtbOutMaxSize is not smaller than USB_CDC_NCM_NTB_MIN_OUT_SIZE.
> 
> Fixes: 289507d3364f ("net: cdc_ncm: use sysfs for rx/tx aggregation tuning")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+9f575a1f15fc0c01ed69@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=b982f1059506db48409d
> Link: https://lore.kernel.org/all/20211202143437.1411410-1-lee.jones@linaro.org/
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Link: https://lore.kernel.org/r/20230517133808.1873695-2-tudor.ambarus@linaro.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 6ce8f4f0c70e..db05622f1f70 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -181,9 +181,12 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
>  	else
>  		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth32);
>  
> -	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
> -	if (max == 0)
> +	if (le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize) == 0)
>  		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
> +	else
> +		max = clamp_t(u32, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize),
> +			      USB_CDC_NCM_NTB_MIN_OUT_SIZE,
> +			      CDC_NCM_NTB_MAX_SIZE_TX);
>  
>  	/* some devices set dwNtbOutMaxSize too low for the above default */
>  	min = min(min, max);
> @@ -1244,6 +1247,9 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
>  			 * further.
>  			 */
>  			if (skb_out == NULL) {
> +				/* If even the smallest allocation fails, abort. */
> +				if (ctx->tx_curr_size == USB_CDC_NCM_NTB_MIN_OUT_SIZE)
> +					goto alloc_failed;
>  				ctx->tx_low_mem_max_cnt = min(ctx->tx_low_mem_max_cnt + 1,
>  							      (unsigned)CDC_NCM_LOW_MEM_MAX_CNT);
>  				ctx->tx_low_mem_val = ctx->tx_low_mem_max_cnt;
> @@ -1262,13 +1268,8 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
>  			skb_out = alloc_skb(ctx->tx_curr_size, GFP_ATOMIC);
>  
>  			/* No allocation possible so we will abort */
> -			if (skb_out == NULL) {
> -				if (skb != NULL) {
> -					dev_kfree_skb_any(skb);
> -					dev->net->stats.tx_dropped++;
> -				}
> -				goto exit_no_skb;
> -			}
> +			if (!skb_out)
> +				goto alloc_failed;
>  			ctx->tx_low_mem_val--;
>  		}
>  		if (ctx->is_ndp16) {
> @@ -1461,6 +1462,11 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
>  
>  	return skb_out;
>  
> +alloc_failed:
> +	if (skb) {
> +		dev_kfree_skb_any(skb);
> +		dev->net->stats.tx_dropped++;
> +	}
>  exit_no_skb:
>  	/* Start timer, if there is a remaining non-empty skb */
>  	if (ctx->tx_curr_skb != NULL && n > 0)
> 

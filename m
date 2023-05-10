Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8976FE708
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 00:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEJWKm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 18:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjEJWKl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 18:10:41 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 15:10:04 PDT
Received: from mx1.bezdeka.de (mx1.bezdeka.de [IPv6:2a03:4000:3f:1f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291707EFB
        for <stable@vger.kernel.org>; Wed, 10 May 2023 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bezdeka.de;
        s=mail201812; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5DNNSgEkG65n37gr9vVLLs8kPXh/vR6k0mKc+dXHa7s=; b=f8YjRq8GbEJGEFIqFgYECSx6Eq
        5gqRVRpdPOhQzphna0q6ypAPeNNw8Le8mEjqmBV1lMjF/VAPS++zFrD4pNxkNgXbD5bz9wfMcfaWP
        VKrOIZKlNwqAb2a6hTKXjysL2I3fwZPka6jWOJAnRbIqnpge0kMOK5fBxyZc21gBqvhsMrSTEK8l7
        9kUCtwahAcIqIOsh+bxhYkcGrA7caWZXCgRGfnuGLF56Tl0+AU8hGWDPvLaiavkqcsoEun1IPsMCJ
        N/INOhrp5TNyxy1jkqGB/Nfje9LBcrXxNqkjk+ru7drqw2TSTtD3FdxmVCyg5/7lL9s8qrFGJI/yb
        +bz72w7g==;
Received: from [2a02:810d:8780:7fd:85b2:ea84:4edf:c4f7]
        by smtp.bezdeka.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <florian@bezdeka.de>)
        id 1pwrsR-006DkE-16;
        Thu, 11 May 2023 00:01:39 +0200
Message-ID: <46a3afc2-4b15-cb2d-b257-15e8928b8eec@bezdeka.de>
Date:   Thu, 11 May 2023 00:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: FAILED: patch "[PATCH] igc: read before write to SRRCTL register"
 failed to apply to 6.1-stable tree
To:     gregkh@linuxfoundation.org, yoong.siang.song@intel.com,
        anthony.l.nguyen@intel.com, brouer@redhat.com, davem@davemloft.net,
        jacob.e.keller@intel.com, leonro@nvidia.com,
        naamax.meir@linux.intel.com, stable@vger.kernel.org
References: <2023050749-deskwork-snowboard-82cf@gregkh>
Content-Language: en-US
From:   Florian Bezdeka <florian@bezdeka.de>
In-Reply-To: <2023050749-deskwork-snowboard-82cf@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-User: florian@bezdeka.de
X-Authenticator: plain
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi all,

On 07.05.23 08:44, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3ce29c17dc847bf4245e16aad78a7617afa96297
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050749-deskwork-snowboard-82cf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Is someone already working on that? I would love to see this patch in
6.1. If no further activities are planned I might have the option/time
to supply a backport as well.

Regards,
Florian

> 
> Possible dependencies:
> 
> 3ce29c17dc84 ("igc: read before write to SRRCTL register")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 3ce29c17dc847bf4245e16aad78a7617afa96297 Mon Sep 17 00:00:00 2001
> From: Song Yoong Siang <yoong.siang.song@intel.com>
> Date: Tue, 2 May 2023 08:48:06 -0700
> Subject: [PATCH] igc: read before write to SRRCTL register
> 
> igc_configure_rx_ring() function will be called as part of XDP program
> setup. If Rx hardware timestamp is enabled prio to XDP program setup,
> this timestamp enablement will be overwritten when buffer size is
> written into SRRCTL register.
> 
> Thus, this commit read the register value before write to SRRCTL
> register. This commit is tested by using xdp_hw_metadata bpf selftest
> tool. The tool enables Rx hardware timestamp and then attach XDP program
> to igc driver. It will display hardware timestamp of UDP packet with
> port number 9092. Below are detail of test steps and results.
> 
> Command on DUT:
>   sudo ./xdp_hw_metadata <interface name>
> 
> Command on Link Partner:
>   echo -n skb | nc -u -q1 <destination IPv4 addr> 9092
> 
> Result before this patch:
>   skb hwtstamp is not found!
> 
> Result after this patch:
>   found skb hwtstamp = 1677800973.642836757
> 
> Optionally, read PHC to confirm the values obtained are almost the same:
> Command:
>   sudo ./testptp -d /dev/ptp0 -g
> Result:
>   clock time: 1677800973.913598978 or Fri Mar  3 07:49:33 2023
> 
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Cc: <stable@vger.kernel.org> # 5.14+
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
> index 7a992befca24..9f3827eda157 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.h
> +++ b/drivers/net/ethernet/intel/igc/igc_base.h
> @@ -87,8 +87,13 @@ union igc_adv_rx_desc {
>  #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
>  
>  /* SRRCTL bit definitions */
> -#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
> -#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
> -#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
> +#define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
> +#define IGC_SRRCTL_BSIZEPKT(x)		FIELD_PREP(IGC_SRRCTL_BSIZEPKT_MASK, \
> +					(x) / 1024) /* in 1 KB resolution */
> +#define IGC_SRRCTL_BSIZEHDR_MASK	GENMASK(13, 8)
> +#define IGC_SRRCTL_BSIZEHDR(x)		FIELD_PREP(IGC_SRRCTL_BSIZEHDR_MASK, \
> +					(x) / 64) /* in 64 bytes resolution */
> +#define IGC_SRRCTL_DESCTYPE_MASK	GENMASK(27, 25)
> +#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	FIELD_PREP(IGC_SRRCTL_DESCTYPE_MASK, 1)
>  
>  #endif /* _IGC_BASE_H */
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index ba49728be919..1c4676882082 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -640,8 +640,11 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
>  	else
>  		buf_size = IGC_RXBUFFER_2048;
>  
> -	srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
> -	srrctl |= buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT;
> +	srrctl = rd32(IGC_SRRCTL(reg_idx));
> +	srrctl &= ~(IGC_SRRCTL_BSIZEPKT_MASK | IGC_SRRCTL_BSIZEHDR_MASK |
> +		    IGC_SRRCTL_DESCTYPE_MASK);
> +	srrctl |= IGC_SRRCTL_BSIZEHDR(IGC_RX_HDR_LEN);
> +	srrctl |= IGC_SRRCTL_BSIZEPKT(buf_size);
>  	srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
>  
>  	wr32(IGC_SRRCTL(reg_idx), srrctl);
> 


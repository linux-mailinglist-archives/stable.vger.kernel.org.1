Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C861D76E388
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjHCIrg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjHCIre (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 04:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744C1982
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 01:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691052368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B1cxWDb2x+ndU67pctL7lnvKXmzS7BnQj9Ld7SM44cY=;
        b=PTwA/2eittG/I5l8I9Ao5UX4pQ38dQUTYSMXHMWABxzrOplnZhWptPyFoF9y9l4I4QKdUS
        YMvAKvVaPCtK7ksWC3xYIrfyozB2zhoSs7+1QAfxKDgYZsIN4iMc0UG1tLB3Ev8Yq3177c
        ARyY4Bj/l2L3arNnmDDEtfsyJvMw4QI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-wlQqUdgpPCay5JhlbeJy_w-1; Thu, 03 Aug 2023 04:46:07 -0400
X-MC-Unique: wlQqUdgpPCay5JhlbeJy_w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cceb8c21aso8256426d6.0
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 01:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052367; x=1691657167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1cxWDb2x+ndU67pctL7lnvKXmzS7BnQj9Ld7SM44cY=;
        b=XjDhnAvyjos0WKfP5IGUzMLY8kRgPGRmQ/uYSaGw64S4Piuf9YLI/Z5L5GxKWRqqx6
         /f1RWwxko0lOavf469tCzUpTiYnyC5Kw2r6j7hFEEBlIKQPU4toBWO/YZ+1Ew0TzNNgD
         Fq4y+YZeKPSegD7l4jxyrPK6VqYl/RDyET2o08Za5/nxqCi2aMWDmpPYn3sN+ZdVuDdf
         dlLCYf0X06cej4OM7waCb9bUIj/F70E0YqEl1GmEsbDJAAnBXJy/msV6tTAlGmLTXaHI
         SrblpYIkrI9iuyyd+4e5X81CTsZHNIm7bV8s7HBRnGKbSjiDOwLYgIcuiimWSK6LtMSb
         4miA==
X-Gm-Message-State: ABy/qLbek417HzP8yJPDdpUu9MDKvIazk4UxGDliZARMcxM+IXHGu1OX
        u7hZvErv8lxEBRkODk9kzLq8R49PxDtOQnUv1UI+NJzg/4t1zRrgHDl5pQD0m+GaBMMLGdxDoD9
        DNlTS89qtxDqtgFuD2dUy4ind
X-Received: by 2002:a05:6214:e86:b0:63d:3d8:6d8 with SMTP id hf6-20020a0562140e8600b0063d03d806d8mr24282811qvb.28.1691052366950;
        Thu, 03 Aug 2023 01:46:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6NZmrORM9rCMWYcM6pMH3vlSil7zGmArCAmNU+w3SZpSN6MIk0SsBfNnHcf4dt7iOKP131Q==
X-Received: by 2002:a05:6214:e86:b0:63d:3d8:6d8 with SMTP id hf6-20020a0562140e8600b0063d03d806d8mr24282802qvb.28.1691052366707;
        Thu, 03 Aug 2023 01:46:06 -0700 (PDT)
Received: from debian ([2001:4649:fcb8:0:b011:aa0c:688c:1589])
        by smtp.gmail.com with ESMTPSA id b4-20020a05620a118400b0076c71c1d2f5sm5012609qkk.34.2023.08.03.01.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:46:06 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:46:01 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        stable@vger.kernel.org, Siwar Zitouni <siwar.zitouni@6wind.com>
Subject: Re: [PATCH net v2] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Message-ID: <ZMtpSdLUQx2A6bdx@debian>
References: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
> This kind of interface doesn't have a mac header.

Well, PPP does have a link layer header.
Do you instead mean that PPP automatically adds it?

> This patch fixes bpf_redirect() to a ppp interface.

Can you give more details? Which kind of packets are you trying to
redirect to PPP interfaces?

To me this looks like a hack to work around the fact that
ppp_start_xmit() automatically adds a PPP header. Maybe that's the
best we can do given the current state of ppp_generic.c, but the
commit message should be clear about what the real problem is and
why the patch takes this approach to fix or work around it.

> CC: stable@vger.kernel.org
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> ---
> 
> v1 -> v2:
>  - I forgot the 'Tested-by' tag in the v1 :/
> 
>  include/linux/if_arp.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
> index 1ed52441972f..8efbe29a6f0c 100644
> --- a/include/linux/if_arp.h
> +++ b/include/linux/if_arp.h
> @@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
>  	case ARPHRD_NONE:
>  	case ARPHRD_RAWIP:
>  	case ARPHRD_PIMREG:
> +	case ARPHRD_PPP:
>  		return false;
>  	default:
>  		return true;
> -- 
> 2.39.2
> 
> 


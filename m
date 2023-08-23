Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA1785B21
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjHWOw1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjHWOw1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 10:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C7E6C
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692802307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ui6+MdQPBHClMUzt17Gxb4m37Amorx/TKujWGiY52KY=;
        b=blhen4WNWI9yf9U4FAra/gvRsZZT9eTnzlIK214su0rKtdvGJp59gGFLVwcepjm5tGfz/c
        Cj0EcMf1JCByjXv+GyWu+fjq2r690QNKA6QQwwo4uu5lROCz+tiLBGBeipCWwp0EQRMknp
        VXkP/h+3admA+WNYbvKlUKuebXdCecQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-pLXLSRWjPI6ye7cPlC5tjw-1; Wed, 23 Aug 2023 10:51:45 -0400
X-MC-Unique: pLXLSRWjPI6ye7cPlC5tjw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe1cdf2024so36395365e9.3
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 07:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802304; x=1693407104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui6+MdQPBHClMUzt17Gxb4m37Amorx/TKujWGiY52KY=;
        b=TuxxCO5pcOzcBnG92P8yhRMuzv2YXiuyLgv6tKv9lVoXvLZ8B5tXQHBnzMvy/gpQkn
         X6KsYMzmzy9Pz8V9ludcG22WCDZZHcmRsS6u9Cf1sF/F+2jctMIOuJFEdOKmuNDcY+hQ
         NWEPyLCvnCX9h5Ao4xvF7riahoGyy93u/HFi5hxsiVIxH2a7BOHFnf5wmI1nY9LCEZfR
         pmyTWfRwxID/1VqULQxiLRFsNUuxe9suLluQsw0PDnsO9i+OWwtJmkSlhTCAQ5kbKB6J
         qyufzNYFNtJBHwpjGPH5/yMMkZTomDuXQi5CDlXUQ1qLo3JjnETpZuWEOkksDHpOkZXk
         JFDw==
X-Gm-Message-State: AOJu0YyMJpASUfEnvA1iPVjjmwa4M98r26NC9GRxbjSCn9ZLVzVah8RX
        rI9Y8Q9Nzy59Tezgx8nacapv7dZXP57Sz+COqO3TOJ+EKgYUu/nCwYiIZys6V5mSUGEcYRUdY6t
        hzkUlH40JYwGm6Q3m
X-Received: by 2002:a7b:c84d:0:b0:3fe:e8b4:436f with SMTP id c13-20020a7bc84d000000b003fee8b4436fmr8627002wml.14.1692802304777;
        Wed, 23 Aug 2023 07:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnVRBi8PK6/x0AzFBEPxF4kWcVG572OSwM5kYFDDA4dIEo8xQwVJCkjQc8s2Db/MeOg5WnoA==
X-Received: by 2002:a7b:c84d:0:b0:3fe:e8b4:436f with SMTP id c13-20020a7bc84d000000b003fee8b4436fmr8626984wml.14.1692802304433;
        Wed, 23 Aug 2023 07:51:44 -0700 (PDT)
Received: from debian (2a01cb058d23d6007d3729c79874bf87.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:7d37:29c7:9874:bf87])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003feee8d8011sm11525804wmi.41.2023.08.23.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:51:43 -0700 (PDT)
Date:   Wed, 23 Aug 2023 16:51:41 +0200
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
Subject: Re: [PATCH net v3] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Message-ID: <ZOYc/Uhb0RSUvi47@debian>
References: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823134102.1848881-1-nicolas.dichtel@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 23, 2023 at 03:41:02PM +0200, Nicolas Dichtel wrote:
> The goal is to support a bpf_redirect() from an ethernet device (ingress)
> to a ppp device (egress).
> The l2 header is added automatically by the ppp driver, thus the ethernet
> header should be removed.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

> CC: stable@vger.kernel.org
> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> ---
> 
> v2 -> v3:
>  - add a comment in the code
>  - rework the commit log
> 
> v1 -> v2:
>  - I forgot the 'Tested-by' tag in the v1 :/
> 
>  include/linux/if_arp.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
> index 1ed52441972f..10a1e81434cb 100644
> --- a/include/linux/if_arp.h
> +++ b/include/linux/if_arp.h
> @@ -53,6 +53,10 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
>  	case ARPHRD_NONE:
>  	case ARPHRD_RAWIP:
>  	case ARPHRD_PIMREG:
> +	/* PPP adds its l2 header automatically in ppp_start_xmit().
> +	 * This makes it look like an l3 device to __bpf_redirect() and tcf_mirred_init().
> +	 */
> +	case ARPHRD_PPP:
>  		return false;
>  	default:
>  		return true;
> -- 
> 2.39.2
> 


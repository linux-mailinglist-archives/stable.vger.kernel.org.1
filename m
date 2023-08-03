Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B276E628
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjHCLCn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 07:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbjHCLCd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 07:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0E3ABC
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691060463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVkdxRqiJFV/CgHX3Xv4YnKDBdfan83bNRrR4xAyeWw=;
        b=P+gdDsSioiluzDH23UPPfdZOQUfbAnBCnF0F1bC5sh5HZ008OtP6gg5ES8PfuaHjQLSEP9
        AZhTb0zK2/wpeEVBmcoe29RFSemUdEmmB2Bxsk7FSKWGhZZEQbfnvcOORiWK9lU3+W8Emo
        WsxsUr6sbOH5P8399EH34ur2ofygbnM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-ZH1Ml3a1N1KVrb_T2Icx2w-1; Thu, 03 Aug 2023 07:00:59 -0400
X-MC-Unique: ZH1Ml3a1N1KVrb_T2Icx2w-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40fe31e76d4so10342001cf.3
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 04:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691060459; x=1691665259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVkdxRqiJFV/CgHX3Xv4YnKDBdfan83bNRrR4xAyeWw=;
        b=KokU+2g5DgaWoTyp+X3znC0fKokhzsU1Ttu/DK++iRTYHypYwVCTIiTj2yp6YSpz3z
         VDo3k0paItKMh+1y25d7dn2ZkCLoCzJefb0q7KdbglEPV4/leklDGw9UHmSYR5ARAeSV
         1ihR1GN31MOkGbHgZ8Y7OXbkFltv7J+TGrlLxo0Dq8ewI8OSw+gLQSNENlbDWK73ziEM
         Xx+1MKsJTB6e3zbAsmVqliyRPq94+BIo56019c1Nx2wVwR3yN9TL/bzSjMmYiu7aEl56
         UrDPyiKSszqYZqXrSH2AwYzpBWgc89p8thR+npVc2TK4z5IK2vc0RX4wE0tbgBRfW1ci
         RemQ==
X-Gm-Message-State: ABy/qLaSzk2Bc/O5Elldth4hmuEeaD3lydQ8Fr6nd6tPH7AYUZMf02vG
        WtTqpF7hxcmvArYDsTYx7SzpB/qM1W/7xvnUaESnK4bn0op9iMOgYF4Y5aPs9cpczCd2dXXV286
        rArTPbosIjoRYRqOn
X-Received: by 2002:a05:622a:1315:b0:403:72fa:630b with SMTP id v21-20020a05622a131500b0040372fa630bmr27721943qtk.58.1691060459354;
        Thu, 03 Aug 2023 04:00:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExG94pWwM09m+J2CoHPjHzWZfKZ8bSnD2jVCgzh5EWriSqtIin9M8JQt4ipFZIiCnZ8blVQA==
X-Received: by 2002:a05:622a:1315:b0:403:72fa:630b with SMTP id v21-20020a05622a131500b0040372fa630bmr27721918qtk.58.1691060459104;
        Thu, 03 Aug 2023 04:00:59 -0700 (PDT)
Received: from debian ([2001:4649:fcb8:0:b011:aa0c:688c:1589])
        by smtp.gmail.com with ESMTPSA id z28-20020ac8431c000000b0040f8ac751a5sm3245433qtm.96.2023.08.03.04.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:00:58 -0700 (PDT)
Date:   Thu, 3 Aug 2023 13:00:54 +0200
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
Message-ID: <ZMuI5mxR704O9nDq@debian>
References: <20230802122106.3025277-1-nicolas.dichtel@6wind.com>
 <ZMtpSdLUQx2A6bdx@debian>
 <34f246ba-3ebc-1257-fe8d-5b7e0670a4a6@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34f246ba-3ebc-1257-fe8d-5b7e0670a4a6@6wind.com>
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

On Thu, Aug 03, 2023 at 11:37:00AM +0200, Nicolas Dichtel wrote:
> Le 03/08/2023 à 10:46, Guillaume Nault a écrit :
> > On Wed, Aug 02, 2023 at 02:21:06PM +0200, Nicolas Dichtel wrote:
> >> This kind of interface doesn't have a mac header.
> > 
> > Well, PPP does have a link layer header.
> It has a link layer, but not an ethernet header.

This is generic code. The layer two protocol involved doesn't matter.
What matter is that the device requires a specific l2 header.

> > Do you instead mean that PPP automatically adds it?
> > 
> >> This patch fixes bpf_redirect() to a ppp interface.
> > 
> > Can you give more details? Which kind of packets are you trying to
> > redirect to PPP interfaces?
> My ebpf program redirect an IP packet (eth / ip) from a physical ethernet device
> at ingress to a ppp device at egress.

So you're kind of bridging two incompatible layer two protocols.
I see no reason to be surprised if that doesn't work out of the box.

> In this case, the bpf_redirect() function
> should remove the ethernet header from the packet before calling the xmit ppp
> function.

That's what you need for your specific use case, not necessarily what
the code "should" do.

> Before my patch, the ppp xmit function adds a ppp header (protocol IP
> / 0x0021) before the ethernet header. It results to a corrupted packet. After
> the patch, the ppp xmit function encapsulates the IP packet, as expected.

The problem is to treat the PPP link layer differently from the
Ethernet one.

Just try to redirect PPP frames to an Ethernet device. The PPP l2
header isn't going to be stripped, and no Ethernet header will be
automatically added.

Before your patch, bridging incompatible L2 protocols just didn't work.
After your patch, some combinations work, some don't, Ethernet is
handled in one way, PPP in another way. And these inconsistencies are
exposed to user space. That's the problem I have with this patch.

> > To me this looks like a hack to work around the fact that
> > ppp_start_xmit() automatically adds a PPP header. Maybe that's the
> It's not an hack, it works like for other kind of devices managed by the
> function bpf_redirect() / dev_is_mac_header_xmit().

I don't think the users of dev_is_mac_header_xmit() (BPF redirect and
TC mirred) actually work correctly with any non-Ethernet l2 devices.
L3 devices are a bit different because we can test if an skb has a
zero-length l2 header.

> Hope it's more clear.

Let me be clearer too. As I said, this patch may be the best we can do.
Making a proper l2 generic BPF-redirect/TC-mirred might require too
much work for the expected gain (how many users of non-Ethernet l2
devices are going to use this). But at least we should make it clear in
the commit message and in the code why we're finding it convenient to
treat PPP as an l3 device. Like

+	/* PPP adds its l2 header automatically in ppp_start_xmit().
+	 * This makes it look like an l3 device to __bpf_redirect() and
+	 * tcf_mirred_init().
+	 */
+	case ARPHRD_PPP:

> Regards,
> Nicolas
> 
> > best we can do given the current state of ppp_generic.c, but the
> > commit message should be clear about what the real problem is and
> > why the patch takes this approach to fix or work around it.
> > 
> >> CC: stable@vger.kernel.org
> >> Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
> >> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> >> Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
> >> ---
> >>
> >> v1 -> v2:
> >>  - I forgot the 'Tested-by' tag in the v1 :/
> >>
> >>  include/linux/if_arp.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
> >> index 1ed52441972f..8efbe29a6f0c 100644
> >> --- a/include/linux/if_arp.h
> >> +++ b/include/linux/if_arp.h
> >> @@ -53,6 +53,7 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
> >>  	case ARPHRD_NONE:
> >>  	case ARPHRD_RAWIP:
> >>  	case ARPHRD_PIMREG:
> >> +	case ARPHRD_PPP:
> >>  		return false;
> >>  	default:
> >>  		return true;
> >> -- 
> >> 2.39.2
> >>
> >>
> > 
> 


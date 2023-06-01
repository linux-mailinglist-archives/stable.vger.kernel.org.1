Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083CE7196F4
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjFAJa1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjFAJa0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 05:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365BB9D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 02:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C45B764289
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AE5C433EF;
        Thu,  1 Jun 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685611824;
        bh=HlUoZFvMdqEnZXQu5hqlOfh2OaMmfzcGQRl52asAWM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yfJ4WlDp8n2t5w+3Mq+vpLd5ZEPO3RvDB4bC3GsxBV3pYPrvTcg1N3hx1XqQrVsdm
         eSXwW1bpleU2O50nqPZvZQECxr1ODZv+2PoabJMH0vZnPcMU2xTSm/5s/zFdyDiU9c
         fxBRPidIFGa8ioPxHGM51v/EwsKSOFGZbuv+kZl0=
Date:   Thu, 1 Jun 2023 10:30:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] ipv{4,6}/raw: fix output xfrm lookup wrt protocol
Message-ID: <2023060146-rewrap-vigorous-807a@gregkh>
References: <2023052622-such-rearview-04a6@gregkh>
 <20230530163312.2550994-1-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530163312.2550994-1-nicolas.dichtel@6wind.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 06:33:12PM +0200, Nicolas Dichtel wrote:
> With a raw socket bound to IPPROTO_RAW (ie with hdrincl enabled), the
> protocol field of the flow structure, build by raw_sendmsg() /
> rawv6_sendmsg()),  is set to IPPROTO_RAW. This breaks the ipsec policy
> lookup when some policies are defined with a protocol in the selector.
> 
> For ipv6, the sin6_port field from 'struct sockaddr_in6' could be used to
> specify the protocol. Just accept all values for IPPROTO_RAW socket.
> 
> For ipv4, the sin_port field of 'struct sockaddr_in' could not be used
> without breaking backward compatibility (the value of this field was never
> checked). Let's add a new kind of control message, so that the userland
> could specify which protocol is used.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> CC: stable@vger.kernel.org
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Link: https://lore.kernel.org/r/20230522120820.1319391-1-nicolas.dichtel@6wind.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> (cherry picked from commit 3632679d9e4f879f49949bb5b050e0de553e4739)
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
> 
> I include the IP_LOCAL_PORT_RANGE define in the backport, to avoid having a hole.
> I can resubmit without this if needed.

No, this is great, thanks!

> This patch can be applied on 5.15, 5.10, 5.4 and 4.19 stable trees also.

Now queued up there, but not to 6.1.y as Sasha took the prereq commit
instead and the original.

thanks,

greg k-h

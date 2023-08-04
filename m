Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5C76FE91
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjHDKd3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 06:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjHDKd2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 06:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750B46B2
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 03:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1267661F94
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 10:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168D3C433C8;
        Fri,  4 Aug 2023 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691145206;
        bh=hEpFQsbpzYsPCEazCB0sx7VnbIpvxMzrH1Aktt4sqa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zKvl0wVeRABZEYI4U7qg3jJNHzCoZZ7hJ70FlB3UTCOyXMG04iS+7bozVvSxsm194
         6nkvdkNKiM5zl0v89GiJXBFXFifMuO8jL/ZUXJMTDCzcm1ONPpxweCnlHk5ZJTYVPD
         q5olbi7Z8K+DOvTlq24KRM7k1qw5zwZDMCZoJq34=
Date:   Fri, 4 Aug 2023 12:33:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     stable@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH 5.10 1/6] bpf: allow precision tracking for programs with
 subprogs
Message-ID: <2023080425-decline-chitchat-2075@gregkh>
References: <20230801143700.1012887-1-pulehui@huaweicloud.com>
 <20230801143700.1012887-2-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801143700.1012887-2-pulehui@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 10:36:55PM +0800, Pu Lehui wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> [ Upstream commit be2ef8161572ec1973124ebc50f56dafc2925e07 ]

For obvious reasons, I can't take this series only for 5.10 and not for
5.15, otherwise you would update your kernel and have a regression.

So please, create a 5.15.y series also, and resend both of these, and
then we will be glad to apply them.  For this series, I've dropped them
from my review queue now.

thanks,

greg k-h

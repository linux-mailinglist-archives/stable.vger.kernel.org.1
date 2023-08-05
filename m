Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15527770DF2
	for <lists+stable@lfdr.de>; Sat,  5 Aug 2023 07:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHEFrR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 5 Aug 2023 01:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEFrQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 5 Aug 2023 01:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D26A4ECB
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 22:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F7C060AD1
        for <stable@vger.kernel.org>; Sat,  5 Aug 2023 05:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5279BC433C7;
        Sat,  5 Aug 2023 05:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691214433;
        bh=0ewYA4CQtyYbLhUCTtG4NwMFqN0+bxh3CbA47vw4JTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJehDj/BIVhabZpVcT5SmcHJayf5L9fD77I2sTzGHuqyyMj0ICHPVVUiuCFWtxPfU
         t0H0Hap+2lpqGCqj6CsF243+ypKhO4rxUfgPoSnhedGQJUxA0ZK73KSfwTJ+44KYEd
         NbwV5rz0kKMVm9FI0LNXytvvz3suKJUwG1BiPSR4=
Date:   Sat, 5 Aug 2023 07:47:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Pu Lehui <pulehui@huaweicloud.com>, stable@vger.kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH 5.10 1/6] bpf: allow precision tracking for programs with
 subprogs
Message-ID: <2023080542-theme-sleet-808c@gregkh>
References: <20230801143700.1012887-1-pulehui@huaweicloud.com>
 <20230801143700.1012887-2-pulehui@huaweicloud.com>
 <2023080425-decline-chitchat-2075@gregkh>
 <96bcca9a-48a2-a2db-bd12-f7b69df90ad8@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96bcca9a-48a2-a2db-bd12-f7b69df90ad8@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 04, 2023 at 08:56:09PM +0200, Thorsten Leemhuis wrote:
> On 04.08.23 12:33, Greg KH wrote:
> > On Tue, Aug 01, 2023 at 10:36:55PM +0800, Pu Lehui wrote:
> >> From: Andrii Nakryiko <andrii@kernel.org>
> >>
> >> [ Upstream commit be2ef8161572ec1973124ebc50f56dafc2925e07 ]
> > 
> > For obvious reasons, I can't take this series only for 5.10 and not for
> > 5.15, otherwise you would update your kernel and have a regression.
> > 
> > So please, create a 5.15.y series also, and resend both of these, and
> > then we will be glad to apply them.  For this series, I've dropped them
> > from my review queue now.
> 
> I see you explaining this occasionally, makes me wonder if we should add
> something like the following to
> Documentation/process/stable-kernel-rules.rst (sorry, no diff/context,
> but I guess you'll understand things nevertheless):
> 
> """
> When using option 2 or 3 you can target a specific stable series. When
> doing so, you have to ensure that the fix or and equivalent is present
> or submitted to all newer stable trees, as users updating to them
> otherwise might encounter regressions. Hence, if you want a patch that
> was merged for 5.19-rc1 included in the 5.10 stable series, you must
> submit it for any stable series still maintained in the v5.11..v5.18
> range.
> """

Sure, hopefully people read the documentation, at the very least, I can
just point the at it and stop saying this over and over :)

thanks,

greg k-h

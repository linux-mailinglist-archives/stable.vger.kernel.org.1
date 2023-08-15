Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FCD77CEDF
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjHOPPP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbjHOPOr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 11:14:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22FC199B
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 08:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80945634BF
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 15:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6450DC433C7;
        Tue, 15 Aug 2023 15:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692112469;
        bh=IzNwg4CCiiXIeHaRgVo+rMcufOaTDrxQF84slft88c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZVDGF95gT3XgkvMortxqlPKycWU/tqCecCZWMWBozMUUIe7MJpCPJ5FzINRNe3kK
         S8Zb0BlkIyU4i28Uf4oWsShtVGgEvvjAiqYUjjGGT1tEs0WBRML92De6umBQn3o2UX
         7TkZafajcamBg4RVfsf10BGAFrhOca1/wWzqHFe0=
Date:   Tue, 15 Aug 2023 17:14:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dong Chenchen <dongchenchen2@huawei.com>
Cc:     kernel@openeuler.org, duanzi@zju.edu.cn, yuehaibing@huawei.com,
        weiyongjun1@huawei.com, liujian56@huawei.com,
        Laszlo Ersek <lersek@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH OLK-5.10 v2 1/2] net: tun_chr_open(): set sk_uid from
 current_fsuid()
Message-ID: <2023081559-excursion-passion-07a3@gregkh>
References: <20230815135602.1014881-1-dongchenchen2@huawei.com>
 <20230815135602.1014881-2-dongchenchen2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815135602.1014881-2-dongchenchen2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 15, 2023 at 09:56:01PM +0800, Dong Chenchen wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> stable inclusion
> from stable-v5.10.189
> commit 5ea23f1cb67e4468db7ff651627892c9217fec24
> category: bugfix
> bugzilla: 189104, https://gitee.com/src-openeuler/kernel/issues/I7QXHX
> CVE: CVE-2023-4194
> 
> Reference: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=5ea23f1cb67e4468db7ff651627892c9217fec24

Why are you not just merging directly from the LTS branches into your
tree?  If you attempt to "cherry-pick" patches like this, you WILL miss
valid bugfixes.

thanks,

greg k-h

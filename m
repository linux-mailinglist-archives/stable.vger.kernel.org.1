Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775B7F3875
	for <lists+stable@lfdr.de>; Tue, 21 Nov 2023 22:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjKUVkL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 21 Nov 2023 16:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjKUVkH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 21 Nov 2023 16:40:07 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D43D78;
        Tue, 21 Nov 2023 13:40:01 -0800 (PST)
Received: from [78.30.43.141] (port=53182 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r5YTL-009ZNJ-MZ; Tue, 21 Nov 2023 22:39:57 +0100
Date:   Tue, 21 Nov 2023 22:39:54 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, stable@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/2] netfilter: fix catchall element double-free
Message-ID: <ZV0jmKNgQpxCvf/R@calendula>
References: <20231121121431.8612-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121121431.8612-1-fw@strlen.de>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg, Sasha,

On Tue, Nov 21, 2023 at 01:14:20PM +0100, Florian Westphal wrote:
> Hello,
> 
> This series contains the backports of two related changes to fix
> removal of timed-out catchall elements.
> 
> As-is, removed element remains on the list and will be collected
> again.
>
> The adjustments are needed because of missing commit
> 0e1ea651c971 ("netfilter: nf_tables: shrink memory consumption of set elements"),
> so we need to pass set_elem container struct instead of "elem_priv".

Please, also apply this series to -stable 5.15, 6.1 and 6.5.

This series apply cleanly to these -stable kernels, I have also tested
this series on them.

Tested-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks.

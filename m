Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F93E76421F
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjGZWaZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGZWaY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 18:30:24 -0400
X-Greylist: delayed 764 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 15:30:23 PDT
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2941FFA;
        Wed, 26 Jul 2023 15:30:23 -0700 (PDT)
Received: from [46.222.17.104] (port=6984 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qOn1P-006lJc-6D; Thu, 27 Jul 2023 00:30:21 +0200
Date:   Thu, 27 Jul 2023 00:30:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: Netfilter -stable patches for 6.1.y
Message-ID: <ZMGeeQiPNLhIlAd4@calendula>
References: <ZMGbe24I9I+FOH57@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMGbe24I9I+FOH57@calendula>
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

On Thu, Jul 27, 2023 at 12:17:31AM +0200, Pablo Neira Ayuso wrote:
> Hi Greg, Sasha,
> 
> Could you please cherry-pick:
> 
>  29ad9a305943 ("netfilter: nf_tables: fix underflow in chain reference counter")
>  b8ae60de6fd3 ("netfilter: nf_tables: fix underflow in object reference counter"

Err. Wrong commit IDs and patch order, apologies.

Correct commit IDs are:

Patch #1 d6b478666ffa ("netfilter: nf_tables: fix underflow in object reference counter")
Patch #2 b389139f12f2 ("netfilter: nf_tables: fix underflow in chain reference counter")

> into 6.1.y?
> 
> Other -stable kernels I have just audited do not need these updates,
> since this fix have been already included in my recent -stable backports.
> 
> Thanks.
> 
> P.S: Moving forward, I will add the Cc: stable@vger.kernel.org tag to
>      patches as Greg suggested.

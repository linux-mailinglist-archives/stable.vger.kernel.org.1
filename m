Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9227A692A
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjISQtQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 12:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISQtP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 12:49:15 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA790
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 09:49:09 -0700 (PDT)
Received: from [78.30.34.192] (port=46926 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qiduL-00GgZv-U3; Tue, 19 Sep 2023 18:49:08 +0200
Date:   Tue, 19 Sep 2023 18:49:04 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Lee Jones <lee@kernel.org>
Cc:     stable@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH 0/5] netfilter: Reinstate dropped Stable patches
Message-ID: <ZQnRAGKWu5Nm/qLw@calendula>
References: <20230919164437.3297021-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919164437.3297021-1-lee@kernel.org>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On Tue, Sep 19, 2023 at 05:44:28PM +0100, Lee Jones wrote:
> Dropped in August:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=da9e96b4de57f6621f21e682bad92b5ffed0eeee
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=8d1dbdfdd7612a9ea73b005f75a3b2b8b0610d4e
> 
> Only re-applied and build tested against v6.1.53.
> 
> If they do apply and test well against linux-5.{4,10,15}, all the better.

I have a pending queue of patches for all these trees.

I will follow up asap, please hold on with this.

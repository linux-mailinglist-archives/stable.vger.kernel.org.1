Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1947D7A2FBB
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjIPLip (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjIPLiQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:38:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F71CCC7
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:38:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F18C433CB;
        Sat, 16 Sep 2023 11:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864291;
        bh=QoDRS50sUKPNOfwLro7Fq3g9UTpB0SXhBrAqlsXZ2z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tao+yrBJ0dWyXJ/+uaeKVhqviX11PHF1L7eFk36l0+o6EDFdjculM0PALpHb6u4vr
         L2+JDFp8IsvmESViUMU80W0wFVHyYsUDnaFcUtiWJd/2nci5NeNwtNaznlO54e7J2J
         aEUgWaZd6WHbd0gSzUrzQ+idaw+7EkULeN8tDT9E=
Date:   Sat, 16 Sep 2023 13:38:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     stable@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Yu Zhao <yuzhao@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] Multi-gen LRU: avoid race in inc_min_seq()
Message-ID: <2023091658-cinnamon-storage-74eb@gregkh>
References: <2023091354-atom-tinderbox-b9be@gregkh>
 <20230913211256.2552031-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913211256.2552031-1-kaleshsingh@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 13, 2023 at 02:12:56PM -0700, Kalesh Singh wrote:
> inc_max_seq() will try to inc_min_seq() if nr_gens == MAX_NR_GENS. This
> is because the generations are reused (the last oldest now empty
> generation will become the next youngest generation).

Now queued up, thanks.

greg k-h

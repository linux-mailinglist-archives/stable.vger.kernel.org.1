Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA575B6A3
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 20:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGTSYW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGTSYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 14:24:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767722D67
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 11:24:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D9275C01A8;
        Thu, 20 Jul 2023 14:24:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 14:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689877440; x=1689963840; bh=Vu
        Vy4pFXi/3cP4FZUSs3RNJIVZzQo3KVyIxMIk7GpXc=; b=guRKK0Uo9FE13YVUuV
        dn1J/BAlimhuTD1bMWuf81ctFfFXwUGTd7/C9tsR0+QegBacRGtGx5dVAHESz9zN
        asLUzt9ja/dxvN4pqSki/opMmvRBlOVo5N+aKaBnMK0G1uAwODYHTsm019vZAqwG
        Ia6kvBzclW5wSmKePVXQLmH8kUuJh+SAqBb5XM9VVeN3Lls4YZw4Cked7tisA+ln
        1+UGZTKdYWKakn91oQRL0P25lTfxQo0mD6ELmS9y4aMYeQlxAEwSRmbtb6AELJ7l
        9QhEGhvZx3IkhcedKAJpIIji06fldpCEfNUd6+lGwmxN3UbzAFPSkQiTMOxDKbs1
        ZosQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689877440; x=1689963840; bh=VuVy4pFXi/3cP
        4FZUSs3RNJIVZzQo3KVyIxMIk7GpXc=; b=0Alds19WeClXudDYG+GBpwbYLahrm
        zAedQzL3oMPSrPHiLtpwoLqazCl+S7UUdbwHrnG2g4LLKlK0tfe9x9JLqm9OG9Hk
        BXvSrVmz+/i02CNWHBTLKDKfB7DLi7rOHoptczEaIhPFpdBo6qF2UTEV2Dg7SKHu
        bXwZhDC7KGWma93P0ymwY6TyS6uLWe3bxMauT2ogtcs+UpWafMy7HNZYLMxz/Dt7
        7wQkLGnqnRoAifC1xuXFHX0PwKR0k/Au6YLlh93OYecexbonWND/beWXfqGMQ/hH
        5r1GyTkuwFQAVX5r4Q4bvQSuYbRxio0OaibAufVoaaYOccYvX2OuLJUtw==
X-ME-Sender: <xms:wHu5ZOQ2jbNNfpS0BplCkLhHvIdbp9biOGAwVGMNgTwwo6opFwsWYg>
    <xme:wHu5ZDxTl-wxva9B3LFXlF0top3E-VMZs-VmJnqmj3dP0dJX0zW71q3lOPZ_MGXpf
    9rnfugK7c5-Cw>
X-ME-Received: <xmr:wHu5ZL2w5msLuwIiGXZGISG1i9ZYTqtGRq_wAWpPJsaufaVZz3MZiQqLaXk0qHCptvHcr6Fu3Lr4JjFJvJ8zoirg7F0g90Ivc7txlQx9sQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:wHu5ZKB6Ik1vKkopchwdWwoPrU2gXh1W1yWc4tHnQXXFByD8qpI6Pw>
    <xmx:wHu5ZHi6ndkYHqWBd40EVfs0dAmxffWqYb3sWMm7DNpI9Z9--4nK9w>
    <xmx:wHu5ZGrRNtXRiqvCWXy_ebDULI3BJyZ7B2owQlwoJjRc3o3sc_RysA>
    <xmx:wHu5ZCUdBrwqbr5-pedBWMJyHLCYYjOmZwa1PDTi-VbZWAinjmAwXA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 14:23:59 -0400 (EDT)
Date:   Thu, 20 Jul 2023 20:23:57 +0200
From:   Greg KH <greg@kroah.com>
To:     Stefan Ghinea <stefan.ghinea@windriver.com>
Cc:     stable@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5.15 1/1] f2fs: fix to avoid NULL pointer dereference
 f2fs_write_end_io()
Message-ID: <2023072049-tribute-lividly-f21b@gregkh>
References: <20230719191019.15285-1-stefan.ghinea@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719191019.15285-1-stefan.ghinea@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 19, 2023 at 10:10:19PM +0300, Stefan Ghinea wrote:
> From: Chao Yu <chao@kernel.org>
> 
> commit d8189834d4348ae608083e1f1f53792cfcc2a9bc upstream

Both now queued up, thanks.

greg k-h

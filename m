Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ECD734BBB
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 08:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjFSG0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 02:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFSG0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 02:26:01 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476C83
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 23:25:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 618A85C0194;
        Mon, 19 Jun 2023 02:25:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Jun 2023 02:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1687155958; x=1687242358; bh=7n
        1JyV1+XKQe5bPImlvHfcgYr7Un0Gx5CBpWDyfSlM8=; b=XRLKC1j8zmeoTRqfYy
        ZhwKjWm89CC6MbgweOn8WGYyuwSYWgwwg/CxVmFAqh+d1PWXH//KgUn9x6c6qqMO
        TjJkpi8UzcPkIlTZTaqeKrmPZa6BVKovmRYyG35+A8MRuMAswHjXOZddENCJ4O5R
        NY4h83PvrgH9eDNdr7/2Gz53lIFJmbX1S3/3/K7yKVN0L8xBo4T3gN0b1vCQJeBc
        yQzphd3p3d7lZMEUiHjLnkLVzAlvbMmq5GzcN+bABVS+tdTEStPcJmsO53u0w0+3
        byuUjLnkOszOM6TmnZs919TAs3MPiAEDhiBGgp0MS12HT44J/W3wMuOPA4ISo11g
        5KOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687155958; x=1687242358; bh=7n1JyV1+XKQe5
        bPImlvHfcgYr7Un0Gx5CBpWDyfSlM8=; b=E9S4dST56Q9JraXvMe6EG7jo6jVBy
        /kumRr/q/dCT13ktmvSgu1tupLADIPhKEh/4e0b2Fa1rPRiGI6pwbbNe98EX+hXl
        ZejMd//v8e9inZi3j/I6bv0OEmu6q+CbxMv6fNKZMZ2XTNWh2SvQcg/DOyfy1P77
        dzE4ER9hoCaLj27JSFV9VGPCMDfRmgaylkASNxMziH/Cv45J9yZblVstHoE+Gfun
        2k5HnekSqyrBQ12JrFHK1mLqdLhq1DKSRbxFxgEnhrKQ0hV/ewTrlnZKzeAxD/vG
        sZaIj6H/1WaLYfXqh5wVhjhL3rODKkfMKrzLyp0kGUS+tpDeI+BKh148g==
X-ME-Sender: <xms:9vSPZB6x5594EqBLDxbDNywrUdQHJAnSkzgfGkhgxYw0PvvVH1oeNQ>
    <xme:9vSPZO55ZdK9xYAulRgwhCpe--t7JzQLnpUQGBTfJxqj5KU5auLs2lETcyVntUwtn
    9U_WLurubFv0w>
X-ME-Received: <xmr:9vSPZIcWiYPefLcMHjRh_r5pAPGXGEasOTv7oqYLTpKd0Q7kI9-NKeuhkYuB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:9vSPZKJN80ahEa4_1yygg-3TBaUGTy7ACFsegfj4NlUWEV64Wg7KAg>
    <xmx:9vSPZFJe8xbKd0V9NbTyQqbh8vgS2y5bme3eRQLyk86FOp-Rgxnq_A>
    <xmx:9vSPZDxx2_y4JQjwZph5o1DjVm1DZLe3NqlN_cNjTBy0z7YGmqT2Fg>
    <xmx:9vSPZCFvFd0N8E-w_7QxpigzLUM7QSgGhVHc_MBxvhL6mm17GHZe7w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 02:25:57 -0400 (EDT)
Date:   Mon, 19 Jun 2023 08:25:55 +0200
From:   Greg KH <greg@kroah.com>
To:     "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Zhang, Eniac" <eniac-xw.zhang@hp.com>
Subject: Re: [PATCH] drm/amdgpu: Don't set struct
 drm_driver.output_poll_changed
Message-ID: <2023061949-sterile-console-b17c@gregkh>
References: <SJ0PR84MB20882EEA1ABB36F60E845E378F5AA@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR84MB20882EEA1ABB36F60E845E378F5AA@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 14, 2023 at 08:52:06PM +0000, Gagniuc, Alexandru wrote:
> Please consider adding the following commit to v6.1.x:
> 
> 0e3172bac3f4 ("drm/amdgpu: Don't set struct drm_driver.output_poll_changed")
> 
> This fixes a few issues where a system resuming may end up with a black screen if the display topology has changed. It would be great to have it in 6.1 branch.

Now queued up, thanks.

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645617C5A07
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbjJKRF0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjJKRFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 13:05:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87460E3
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 10:05:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B48C433C8;
        Wed, 11 Oct 2023 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697043901;
        bh=UR5o0B3rdl0E39dkU0JdIMUuq8WRJmDYDAz+Ok0M5Yk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwZmIqiJGcYWy13YSxdMXC80wMJbg8f3C9PHceMsg6vz+8EO9mbui4oklsbguazyk
         8jDJc82WeEV8IPlmv/969bOYMjdJsbOO0KCRgLPvDfWBH9oMtO/aBBlkUMPmwpj+Du
         PWanziJUg6mrjFEM0QtgOStDasEO4B10loDO62MXzTHBgLmZlmp0x1oGa15/qZF2NW
         TUDhk6RdpsIgfBuYtccuZkTYRl7wCy02+8k6M8bmHVe3WVwF/LKcyVKZ6NbI+anGgh
         WcUogr+fZc5kkjPRxONR7SZXMMGlhQLzxPU2c/IGNBTaJkkduCub86dyzEXM07tvQG
         545xnD0B9v3kQ==
Date:   Wed, 11 Oct 2023 11:04:58 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        vincentfu@gmail.com, ankit.kumar@samsung.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <ZSbVuuE8YxgwpqM8@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com>
 <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
 <20231010074634.GA6514@lst.de>
 <CA+1E3r+2Ce4BCZ2feJX37e1-dtvpZtY6ajiaO_orn8Airu2Bqg@mail.gmail.com>
 <20231011050254.GA32444@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011050254.GA32444@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 11, 2023 at 07:02:54AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 10, 2023 at 07:09:54PM +0530, Kanchan Joshi wrote:
> > 
> > Given the way things are in NVMe, I do not find a better way.
> > Maybe another day for commands that do (or can do) things very
> > differently for nlb and PI representation.
> 
> Fixing just a subset of these problems is pointless.  If people want
> to use metadata on vendor specific commands they need to work with
> NVMe to figure out a generic way to pass the length.

NVMe already tried to solve that with NDT and NDM fields, but no vendor
implemented it. Maybe just require SGL's for passthrough IO since that
encodes the buffer sizes.

I don't think it's reasonable for the driver to decode every passthrough
command to validate the data lengths, or reject ones that we don't know
how to decode. SG_IO doesn't do that either.

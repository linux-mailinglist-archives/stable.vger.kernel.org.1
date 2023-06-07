Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C597268B8
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjFGSad (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjFGS35 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:29:57 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEEAE6C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:29:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DEE665C0129;
        Wed,  7 Jun 2023 14:29:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 07 Jun 2023 14:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686162589; x=1686248989; bh=ro
        +AENaIGg3OiU2s4fKB+kW4lkXTl6h7HzG83vqhSpk=; b=On0sULu8L8L1Vg2rFX
        jIgjAq4Hxhr2897rJSNHuGqTtfVHexGgqs133m0ipDaJ5ckZS11lq8E9xK8vT76d
        61rRgsEf3Orfd3E4H+ivohRUzaqWGSEnzd70T+kRPZbyiYtrhefSc+WdapUdlzC/
        mqHy7u3MVqZE2ZvJxQlJA7xdkvxfVO6Ka3vDIgXBJF9XwJNUAxa06i4u7h1FsbyF
        kIG0jR53qXxcc2mXYd0uF+zCEGydeS4LbWDsRsjdyXs3vpgpFRPsX3QZrNsNAEdt
        FRRtK8sKvJOOYx29sufpH7rnJFPajRn9jO1tmc0wML6VVB141lOPfyMgDG9pZRyh
        Ne2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686162589; x=1686248989; bh=ro+AENaIGg3Oi
        U2s4fKB+kW4lkXTl6h7HzG83vqhSpk=; b=Q7MMmEQU0babLbeYvP7Kzy0oQXecr
        7vJF8Nrcj51xANNO5Q5N+2lLXAQ2u3cpdLqMAZSozEYmly5OXF/axXjTiXwgG5nV
        7jKg05kIM43eprqRV4PkPpwc2Vqe7mTOApwgzY/isZfLm5RRT2Z2uFYCw0xUT+uo
        R2rz9Uw4y8xt7eCuEI9iZg2o2rFFYcE8GzTtETtv9KBwnVpABXxmPrdsakjFqQ0s
        mJQ36q/Qnxblh4UezXBaBSApcN6/2+4gYAtcZROB7Ao7WlYnND1QtVyCbdy6OvW8
        RFNnXLyi6g9IfkIA6pPoQpmMaFWEN89csCclCNC3F9p+FhBKqvfXJBoTA==
X-ME-Sender: <xms:ncyAZFXDCMiYNOXxCgfMhPzJxDLNT8QW9AzLrqatoJ8R45umUrc3Eg>
    <xme:ncyAZFmlixsgFAG69cXixLVfEpofp6ku0jzhMJGtYq3aLaimDD4bDKUP6Rajx-g_G
    6F0PvGxrn__Hw>
X-ME-Received: <xmr:ncyAZBa1b8TMY_f4qexgIXSVZZG1qnIFo_iZKZClgqgxufk1sLdJmu93M4aZBsFRatLOWp0jhc0nioCbO8em5_uniB0gx_Cjc9CFuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:ncyAZIVKbUlhUPN6gIF_Z1dOYXlQW8tLCEljR-rlcA6bYfTKpKL8XQ>
    <xmx:ncyAZPn8W7l8gRcsNfHk3xM-uwI0TIWzcHJzsZ8BepjcwW1ds7iOdA>
    <xmx:ncyAZFcI5TVVcexcyGdvGFc3zfoOLL-GSn1zzBO5gC46-sYwC98LpA>
    <xmx:ncyAZExQwvqiwVvOhzSExETpBmGIbODufQkAhv1nVyYRhjjrL9OBEg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 14:29:49 -0400 (EDT)
Date:   Wed, 7 Jun 2023 20:29:41 +0200
From:   Greg KH <greg@kroah.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] block: fix revalidate performance regression
Message-ID: <2023060735-joystick-ashamed-f686@gregkh>
References: <2023060549-smolder-human-a813@gregkh>
 <20230605231349.1326266-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605231349.1326266-1-dlemoal@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 08:13:49AM +0900, Damien Le Moal wrote:
> commit 47fe1c3064c6bc1bfa3c032ff78e603e5dd6e5bc upstream.
> 
> The scsi driver function sd_read_block_characteristics() always calls
> blk_queue_set_zoned() to set a disk zoned model correctly, in case the
> device model changed. This is done even for regular disks to set the
> zoned model to BLK_ZONED_NONE and free any zone related resources if the
> drive previously was zoned.
> 
> This behavior significantly impact the time it takes to revalidate disks
> on a large system as the call to blk_queue_clear_zone_settings() done
> from blk_queue_set_zoned() for the BLK_ZONED_NONE case results in the
> device request queued to be frozen, even if there are no zone resources
> to free.
> 
> Avoid this overhead for non-zoned devices by not calling
> blk_queue_clear_zone_settings() in blk_queue_set_zoned() if the device
> model was already set to BLK_ZONED_NONE, which is always the case for
> regular devices.
> 
> Reported by: Brian Bunker <brian@purestorage.com>
> Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Link: https://lore.kernel.org/r/20230529073237.1339862-1-dlemoal@kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-settings.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, now queued up.

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B27723397
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjFEXOi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 19:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFEXOh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 19:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54DCD2
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 16:14:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47672622CD
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 23:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D47C433D2;
        Mon,  5 Jun 2023 23:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686006875;
        bh=9KB6hQgzp6ObM8Bv0Flk0zIcuUAw1JpoYHJL3ziDhzo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p9CYlxwwSi6grFJZkzXjK9bCIpa6tRpj1TB7cc056q1ei6axWlyCuLGOoSVZNTvaj
         uZO6dn8JE7ILeyKryba8mSeabMuvgUe6JMB7hgLkVcEKG/YC9cpPV73kyioBhU2xtR
         O0OearO+iZfJ2vj4hyBKZRbA0VCW/EIQHx6L57NBEIT5puA1YD99v0HviHOGrpENWS
         gop40MTV2cPdlklaQ9ri6x/+eVvP9b3JeOkUOb16ohHfDiGnLzhdHp85fsBxHOws/H
         IRLA/6fKJJ0GRrIeDBDDALn2wzu57wbWSvh9zvTzlUEscjiz38lOcfMRlcV/g8Iu5O
         xG5MWXJv1uIGQ==
Message-ID: <1580cc66-0ba0-1178-610f-b57835543c0a@kernel.org>
Date:   Tue, 6 Jun 2023 08:14:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: FAILED: patch "[PATCH] block: fix revalidate performance
 regression" failed to apply to 5.15-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, axboe@kernel.dk, brian@purestorage.com,
        ming.lei@redhat.com
Cc:     stable@vger.kernel.org
References: <2023060549-smolder-human-a813@gregkh>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <2023060549-smolder-human-a813@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/6/23 04:52, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 47fe1c3064c6bc1bfa3c032ff78e603e5dd6e5bc
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060549-smolder-human-a813@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Hi Greg,

I sent a backport using the above command.
Thanks !

> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 47fe1c3064c6bc1bfa3c032ff78e603e5dd6e5bc Mon Sep 17 00:00:00 2001
> From: Damien Le Moal <dlemoal@kernel.org>
> Date: Mon, 29 May 2023 16:32:37 +0900
> Subject: [PATCH] block: fix revalidate performance regression
> 
> The scsi driver function sd_read_block_characteristics() always calls
> disk_set_zoned() to a disk zoned model correctly, in case the device
> model changed. This is done even for regular disks to set the zoned
> model to BLK_ZONED_NONE and free any zone related resources if the drive
> previously was zoned.
> 
> This behavior significantly impact the time it takes to revalidate disks
> on a large system as the call to disk_clear_zone_settings() done from
> disk_set_zoned() for the BLK_ZONED_NONE case results in the device
> request queued to be frozen, even if there are no zone resources to
> free.
> 
> Avoid this overhead for non-zoned devices by not calling
> disk_clear_zone_settings() in disk_set_zoned() if the device model
> was already set to BLK_ZONED_NONE, which is always the case for regular
> devices.
> 
> Reported by: Brian Bunker <brian@purestorage.com>
> 
> Fixes: 508aebb80527 ("block: introduce blk_queue_clear_zone_settings()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Link: https://lore.kernel.org/r/20230529073237.1339862-1-dlemoal@kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..4dd59059b788 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -915,6 +915,7 @@ static bool disk_has_partitions(struct gendisk *disk)
>  void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  {
>  	struct request_queue *q = disk->queue;
> +	unsigned int old_model = q->limits.zoned;
>  
>  	switch (model) {
>  	case BLK_ZONED_HM:
> @@ -952,7 +953,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  		 */
>  		blk_queue_zone_write_granularity(q,
>  						queue_logical_block_size(q));
> -	} else {
> +	} else if (old_model != BLK_ZONED_NONE) {
>  		disk_clear_zone_settings(disk);
>  	}
>  }
> 

-- 
Damien Le Moal
Western Digital Research


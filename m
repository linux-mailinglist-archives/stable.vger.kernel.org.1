Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B57D3A8B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJWPSm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjJWPSm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 11:18:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF841103
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 08:18:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12463C433C9;
        Mon, 23 Oct 2023 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698074319;
        bh=MioXTG7udluvSetup3O78g2HsJEJGk9gLWyJfEWeILA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJx2CfV/+FJCiVWBI6EsJhxvDLnqzg/b1qllHt7cMwV3PatGJp5gmRHX6iK/jxiez
         kRurmaMakEqIWoXrL6DvCBETjyyl0Fyy2X4MyY514jhXPyeevItuZzXmYsk2bXv4cY
         XYCMCInK0g7H2QENhVjX8YksIEBN6OBBnK+VoB8N/fUtxE/MZzypLmDez03xQpMmt3
         URfJbBTtg8BGWvGAo0j1BIChnWdR3OWKYg1YtQsX7AwDj5s8PpC4SGk29PWG803Y7j
         4fzCaoz5+yk2CApd13vd9KnriggdZpxWoB/tOEuhm+3XvBqpQrfBCa2VG0UJorH4qN
         9ZYepcPt3pwCw==
Date:   Mon, 23 Oct 2023 09:18:36 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTaOzORdmFwxCW1c@kbusch-mbp>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
 <ZTBNfDzxD3D8loMm@kbusch-mbp>
 <20231019050411.GA14044@lst.de>
 <ZTKN7f7kzydfiwb2@kbusch-mbp>
 <20231023054456.GB11272@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023054456.GB11272@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 23, 2023 at 07:44:56AM +0200, Christoph Hellwig wrote:
> Yes, you need someone with root access to change the device node
> persmissions.  But we allowed that under the assumption it is safe
> to do so, which it turns out it is not.

Okay, iiuc, while we have to opt-in to allow this hole, we need another
option for users to set to allow this usage because it's not safe.

Here are two options I have considered for unpriveledged access, please
let me know if you have others or thoughts.

  Restrict access for processes with CAP_SYS_RAWIO, which can be granted
  to non-root users. This cap is already used in scsi subsystem, too.

  A per nvme-generic namespace sysfs attribute that only root can toggle
  that would override any caps and just rely on access permissions.

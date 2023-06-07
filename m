Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2177D7267D4
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjFGRzU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjFGRzT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 13:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4301FD4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 10:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A5DA63602
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 17:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091FFC433D2;
        Wed,  7 Jun 2023 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686160517;
        bh=HPODcED1KNKR5QKvjEKBy0q1aRzojVkb/n75vO9nGq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tW/Mcv4Tjv5sTCTFK1HZG5Uji/0Xzx2j7br33K7wWZSFTnQCyBBnKZ/Zpg9JrqG2t
         gpuPb1+Ov/91oOCi6GtQePb+hvML7cQpo1GIBVwmvJf3yZ/t/Cn3SH04QUpUiI3YE2
         ryX9jEyz9sOM5fHxLHooygI+rPB5igqj3esr7x6Y=
Date:   Wed, 7 Jun 2023 19:55:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: randconfig fixes for 5.10.y
Message-ID: <2023060701-playmate-annoying-c03a@gregkh>
References: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b59d1bfe-15b1-4318-a12f-a38143ba35bd@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 11:22:09AM +0300, Dan Carpenter wrote:
> I did some randconfig testing on 5.10.y and the following patches are
> required.
> 
> d7a7d721064c5 ("media: ti-vpe: cal: avoid FIELD_GET assertion")
> 42d95d1b3a9c6 ("drm/rcar: stop using 'imply' for dependencies")
> 
> The first patch is only required on 5.10.y.
> The second "drm/rcar" commit is required in 5.15.y as well.

Thanks, both now queued up.

greg k-h

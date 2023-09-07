Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8DD7975EE
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjIGQAp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242115AbjIGP7V (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 11:59:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545474682
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 08:48:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F471C116B7;
        Thu,  7 Sep 2023 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101302;
        bh=zePQdjSjpAxHSlG2N1mjiwP8rP/tzCKfSbAd9oQ6Whw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9sc8ylv5PC3Fa2MHN441gSLzenPZ75yZ17Ocgqqeh/ncVZm7JYfPUuUbjKKjZtca
         dJqKnkC/u+GpvQ1VGD9IR8s5lBxpOFWWDWPbZ9ehQw52LuFMMW/ql7S2JfeuyLLoQi
         pTaPBNVm02vqXoKvKGRJfTqLv29atzTzsD4W/FqfrHE1yKWH40BOAmh5ONJKSGCAK3
         FKwUO4eHnuNV2ldy1NVdNGqvGmg3fO1BU2foMb3yIRSeJ/AWi3mUx9vbxk0ZIKlreu
         Ju6Mwm1pLzuAkHHSaFn9oKhkhkOqlUWENH4Fz6RugMaQWnHvrYTJUHX2rUA2PLUioa
         cxEJtePsL7KaA==
Date:   Thu, 7 Sep 2023 09:41:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <ZPnvM3kNSHVA8x6Y@kbusch-mbp>
References: <20230814070213.161033-1-joshi.k@samsung.com>
 <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com>
 <ZPH5Hjsqntn7tBCh@kbusch-mbp>
 <20230905051825.GA4073@green245>
 <ZPduqCASmcNxUUep@kbusch-mbp>
 <20230906154815.GA23984@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906154815.GA23984@green245>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Sep 06, 2023 at 09:18:15PM +0530, Kanchan Joshi wrote:
> Would you really prefer to have nvme_add_user_metadata() changed to do
> away with allocation and use userspace meta-buffer directly?

I mean, sure, if it's possible. We can avoid a costly copy if the user
metabuffer is aligned and physically contiguous.

> Even with that route, extended-lba-with-short-unaligned-buffer remains
> unhandled. That will still require similar checks that I would like
> to avoid but cannnot.
> 
> So how about this -

There's lots of bad things you can do with this interface. Example,
provide an unaligned single byte user buffer and send an Identify
command.

We never provided opcode decoding sanity checks before because it's a
bad maintenance burden, adds performance killing overhead, couldn't
catch all the cases anyway due to vendor specific and future opcodes,
and harms the flexibility of the interface. The burden is usually on the
user for these kinds of priviledged interfaces: if you abuse it, "you
get to keep both pieces" territory.

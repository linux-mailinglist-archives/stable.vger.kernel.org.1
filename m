Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76602785F13
	for <lists+stable@lfdr.de>; Wed, 23 Aug 2023 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjHWSBd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 23 Aug 2023 14:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237970AbjHWSBb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 Aug 2023 14:01:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBACE9
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 11:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6D660472
        for <stable@vger.kernel.org>; Wed, 23 Aug 2023 18:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC844C433C8;
        Wed, 23 Aug 2023 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692813688;
        bh=xBcqXRsXzPa+xclRRKdsIwzghxJZHfaUB5a91moYM0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QM0OAdquhW2fFtw38kqNU/0ERDo5j7LxDkChtyS7ysDkdX90fr8nH2qS41tjzdyt8
         RUyMR6dyPVMzm8iNXZoavBqr7oeopJxVeO9qWp1cCqKMfPB8K85QVn2t/jRjcfC+h7
         w1fjTOOPVgENjBSqsvfo5jDToTqLTOvWxLnxDGM0=
Date:   Wed, 23 Aug 2023 20:01:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Easwar Hariharan <eahariha@linux.microsoft.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15 0/2] Fixup IOMMU list in MAINTAINERS
Message-ID: <2023082353-renderer-hypocrite-5935@gregkh>
References: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823175706.2739729-1-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 23, 2023 at 05:57:04PM +0000, Easwar Hariharan wrote:
> The IOMMU list has moved and emails to the old list bounce. Bring stable
> in alignment with mainline.
> 
> Joerg Roedel (1):
>   MAINTAINERS: Remove iommu@lists.linux-foundation.org

Who uses MAINTAINERS for submitting new patches?  No one should,
otherwise we would be syncing these types of changes backwards all the
time :(

So why is this needed?

confused,

greg k-h

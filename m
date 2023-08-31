Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0039078EB16
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjHaKvq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbjHaKvq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 06:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AADE4A;
        Thu, 31 Aug 2023 03:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DCB56274F;
        Thu, 31 Aug 2023 10:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10041C433C8;
        Thu, 31 Aug 2023 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693479048;
        bh=r9Fe3rY/wMptRDVCtiyXTp0HxZpvUHjf+sJtRh2NeSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfIkV4fHMMQF5KAv6YRjk06BYGPbK9zVjMkATEPBxmWCQPGHzRQVabxEdnX2cm47I
         G3Is8HmyBsYbarnKherhGZ/YW4nrowULG5MaxKh8kK0eeL/BQeYGOKvXClGUqzMvN8
         v73EPfh1qyTUbcknqBr6MpAqkhMz7xSO6qBLBZs4=
Date:   Thu, 31 Aug 2023 12:50:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, linux-parisc@vger.kernel.org,
        Vidra.Jonas@seznam.cz, Sam James <sam@gentoo.org>,
        John David Anglin <dave.anglin@bell.net>
Subject: Re: [STABLE] stable backport request for 6.1 for io_uring
Message-ID: <2023083139-outing-outpour-2792@gregkh>
References: <ZO0X64s72JpFJnRM@p100>
 <5aa6799a-d577-4485-88e0-545f6459c74e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aa6799a-d577-4485-88e0-545f6459c74e@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 30, 2023 at 10:17:39AM -0600, Jens Axboe wrote:
> On 8/28/23 3:55 PM, Helge Deller wrote:
> > Hello Greg, Hello Jens, Hello stable team,
> > 
> > would you please accept some backports to v6.1-stable for io_uring()?
> > io_uring() fails on parisc because of some missing upstream patches.
> > Since 6.1 is currently used in debian and gentoo as main kernel we
> > face some build errors due to the missing patches.
> 
> Fine with me.

Now queued up, thanks.

greg k-h

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCD71966E
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjFAJKp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjFAJKn (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 05:10:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3819F
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 02:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ECFE60B7B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88912C433EF;
        Thu,  1 Jun 2023 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685610630;
        bh=QcbGvfbsyDmoWazn0h5bsBBSOc79bwkb68Hqt8cUzXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2eCCPkkhDZ2pnxTRRWH4q6PpvOVerKzUbjt2XrKBCtcr+dpJu9oaIvDMwXmA0YBev
         lqcyGiT+F+SlHC9057/gZr8KEg0H/bmSekNMXxzfazyazaokfqcwP39bhtATOOKfPC
         s6BCBPIvRSq5+KwtvCwmpf7c//hCzSi8uv+bG034=
Date:   Thu, 1 Jun 2023 10:10:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     stable <stable@vger.kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: 5.4-stable patches
Message-ID: <2023060121-activity-phoniness-3113@gregkh>
References: <6a5172c0-de90-d582-baae-37b8c4de1d91@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5172c0-de90-d582-baae-37b8c4de1d91@kernel.dk>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 31, 2023 at 10:00:39AM -0600, Jens Axboe wrote:
> Hi,
> 
> Greg, can you include these in the 5.4-stable batch for the next
> release? Lee reported and issue that really ended up being two
> separate bugs, I fixed these last week and Lee has tested them
> as good. No real upstream commits exists for these, as we fixed
> them separately with refactoring and cleanup of this code.

All now queued up, thanks.

greg k-h

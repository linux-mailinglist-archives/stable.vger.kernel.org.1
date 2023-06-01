Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5AE719E9A
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjFANpG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjFANpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB6189
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A04A16453D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C13AC433EF;
        Thu,  1 Jun 2023 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685627098;
        bh=F1U3nxzwGGTBqOhKN9HXrHvex6iugM7bFzDjW3SL8IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAXakz6QpG5kcWqipFn4VGw16zE+DhC1m+wkIBUVYZhB4pjijLWIe+Z8yqVKLk57l
         yHeDTRosvFV9aArHFDNa6UEr4SaBdk1KC0bzgFWqLF6+5NyC1XroEpLnQdCiS/tn7p
         6DaO6HmFYiLKRqk/dlejjvB9t3pRQa1Jp8FNfIt6mSJjn0GI4vHR1bcg6AVCGePihs
         FN4t6hSJs4refSHA/cDLPFQ9mtlwjpY8xoJWBQnJEq99fseX7sOIjzu2lD9ZKjmwmH
         TBdjz0Kj0CPg3Y/7D0UG9ozrvecgpACkim+2w4FV2MOV9dzjeOUe/ehj6pEQJsHQAs
         P/Mg7B8v6L4mQ==
Date:   Thu, 1 Jun 2023 14:44:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, stable <stable@vger.kernel.org>
Subject: Re: 5.4-stable patches
Message-ID: <20230601134453.GE449117@google.com>
References: <6a5172c0-de90-d582-baae-37b8c4de1d91@kernel.dk>
 <2023060121-activity-phoniness-3113@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023060121-activity-phoniness-3113@gregkh>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 01 Jun 2023, Greg Kroah-Hartman wrote:

> On Wed, May 31, 2023 at 10:00:39AM -0600, Jens Axboe wrote:
> > Hi,
> > 
> > Greg, can you include these in the 5.4-stable batch for the next
> > release? Lee reported and issue that really ended up being two
> > separate bugs, I fixed these last week and Lee has tested them
> > as good. No real upstream commits exists for these, as we fixed
> > them separately with refactoring and cleanup of this code.
> 
> All now queued up, thanks.

Super job!  Thanks for this Jens.

-- 
Lee Jones [李琼斯]

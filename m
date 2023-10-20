Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3037D11D7
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbjJTOus (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377644AbjJTOui (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 10:50:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CD10C1
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 07:50:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C6CC433C8;
        Fri, 20 Oct 2023 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697813426;
        bh=wSIdb8pQDAIv63D3ZjUSTA8CzUKULkYXnlYs9Q3XE3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVzeTnfPqO7ISx667y9TVWEpkejNcg+F2vgNahGVXYMDcd9FhATAnRbuBpLFBgy9x
         oEOy0nAYyrx86o9mS8bkrP3swKikcreMM6o2ja1vQWKCBkK0DI+8G+2SodGyXagXBa
         qXH+yUQyUdjMU+J8BmklCiOX3wYL8qw7IrbS14tc=
Date:   Fri, 20 Oct 2023 16:50:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: [stable] Documentation: sysctl: align cells in second content
 column
Message-ID: <2023102012-engraved-regretful-c99b@gregkh>
References: <29d20ccd1a754c91ba4a23505a096b4051e44c05.camel@decadent.org.uk>
 <db312d7fba700ba12bbbf49c680b499fbcad1a68.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db312d7fba700ba12bbbf49c680b499fbcad1a68.camel@decadent.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 17, 2023 at 10:00:12PM +0200, Ben Hutchings wrote:
> On Tue, 2023-10-17 at 21:53 +0200, Ben Hutchings wrote:
> > Several stable branches (4.14 to 5.15 inclusive) belatedly got
> > backports of commit 1202cdd665315c ("Remove DECnet support from
> > kernel").  This causes a minor regression for the documentation build,
> > which was fixed upstream by:
> > 
> > commit 1faa34672f8a17a3e155e74bde9648564e9480d6
> > Author: Bagas Sanjaya <bagasdotme@gmail.com>
> > Date:   Wed Aug 24 10:58:04 2022 +0700
> >  
> >     Documentation: sysctl: align cells in second content column
> > 
> > Please apply this to the affected branches.
> 
> ...which are actually only 5.4, 5.10, and 5.15.  The backports to the
> older branches had some textual adjustments that avoided the
> regression.

Now queued up, thanks.

greg k-h

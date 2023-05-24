Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8DC70EC9B
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 06:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjEXElf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 00:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEXEle (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 00:41:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08545119
        for <stable@vger.kernel.org>; Tue, 23 May 2023 21:41:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34O4fRtG011592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 00:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684903288; bh=U0ujNxZicY998gnIus/Fq1cB0nHxrNsGemGVRJVlmC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BHsZEe64m8fpJF2VN7Cc+h4iXWAIR02c6fjOfx9aoV9LEBm+u/qLdWzA2YC7/rrAy
         HyB62DjDZdt6/i7hH8z9c5Vs7E0w+v/VxNMPX6Fz5CdszovbHdqTzX80+IeVtplXA3
         bYnrg290z6n47Tf6tLidPJWKGkt0YQMxdoh2MmrsHHwwh9SL6ZGcBBYHcGI+kqhTKr
         VN0PZON+MajX5Fzvv3FKJ/x39e45wyT6C5OmDoG0SYfCQHdqGXummWDBEGxCD4udvP
         qfhpnXVfgP/ArhoWRzSu0y6k5rFcSE1Ziyiu/3CmhSmVfO2Z9mZw0pZJPFt+VwGzmY
         qmfJqYICWbVWg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3E5C615C052B; Wed, 24 May 2023 00:41:27 -0400 (EDT)
Date:   Wed, 24 May 2023 00:41:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: Was there a call for 5.10.181-rc1 review?
Message-ID: <20230524044127.GC779799@mit.edu>
References: <20230522190354.935300867@linuxfoundation.org>
 <20230523022333.GG230989@mit.edu>
 <2023052348-reformer-hatchback-7299@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052348-reformer-hatchback-7299@gregkh>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 07:23:37AM +0100, Greg Kroah-Hartman wrote:
> On Mon, May 22, 2023 at 10:23:33PM -0400, Theodore Ts'o wrote:
> > I can't found a call for reviewing 5.10.181-rc1, either in my inbox or
> > on lore.kernel.org.
> > 
> > There does to be a 5.10.181-rc1 in stable-rc/linux-5.10.y, so did it
> > not get e-mailed out somehow?  Or did I somehow miss it?
> 
> I did not release it, sorry, only 5.15.y and newer for this round.
> 5.10.181-rc will probably happen later this week or next.

Ah, no worries.  I had a bit of extra time and had set up a pull of
the stable-rc git tree, and was looking at trying to automate some
ext4 testing, and I ended up testing the -rc1 of 6.1, 5.15, 5.10, 5.4,
and 4.19.  (At least as was found in the git tree; I assume they
haven't been finalized yet?)

Anyway, I'll retest the 5.10 and earlier LTS trees once you've
released them.

Cheers,

					- Ted

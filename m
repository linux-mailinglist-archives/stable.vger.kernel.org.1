Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACC7BA8FB
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjJESXU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJESXU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 14:23:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590090
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 11:23:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9601C433C7;
        Thu,  5 Oct 2023 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696530198;
        bh=O+4R9sJ3ItttYb7aLCVqUtOczGBHIqVieGpsmvDQ1AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIoPcYI4vfUKR9W2mwKaznpXGrsS83eZofL4iFMBdepsXsNAKTCKmXj6sda7Atxoq
         gZcF610CDlWf9iakSQjJTeEaJWJgBqsAST86Q3vD0kpwTpJ8kCfLZfmyljzq7j9p/2
         YBkT6Nw+bptA1rFQyO4+naP2fGbhfA0QiKPsCRh/Ef8/Q7onzIHkKp8SrE6vTm0mhi
         C+K8A8/YLq8FGquIaa2KxoOyTjcEDeUCn0k2JdUqqinz3oNCKDTu9lKwzPqH529bBE
         JprV7VhhsnQgE9gMCxC8o7BVyBM2vGCIVYCbdeeh/SantUkiQLTlonYo2Ups2u1oJm
         /uXOmfqDMrTfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D500D40508; Thu,  5 Oct 2023 15:23:15 -0300 (-03)
Date:   Thu, 5 Oct 2023 15:23:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Namhyung Kim <namhyung@gmail.com>, stable@vger.kernel.org,
        Akemi Yagi <toracat@elrepo.org>
Subject: Re: 6.5-stable backport request
Message-ID: <ZR7/E4KKl0q7NBUX@kernel.org>
References: <CAM9d7cggeTaXR5VBD1BoPr9TLPoE7s9YSS2y0w-PGzTMAGsFWA@mail.gmail.com>
 <ZRv6IFKjB+KMr6CH@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRv6IFKjB+KMr6CH@sashalap>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Em Tue, Oct 03, 2023 at 07:25:20AM -0400, Sasha Levin escreveu:
> On Thu, Sep 28, 2023 at 01:41:34PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > Please queue up this commit for 6.5-stable:
> > 
> > * commit: 88cc47e24597971b05b6e94c28a2fc81d2a8d61a
> >   ("perf build: Define YYNOMEM as YYNOABORT for bison < 3.81")
> > * Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > The recent change v6.5 series added YYNOMEM changes
> > in the perf tool and it caused a build failure on machines with
> > older bison.  The above commit should be applied to fix it.
> 
> Queued up, thanks!

Thanks a lot!

- Arnaldo

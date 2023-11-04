Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837577E110D
	for <lists+stable@lfdr.de>; Sat,  4 Nov 2023 22:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKDVBa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 4 Nov 2023 17:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjKDVB2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 4 Nov 2023 17:01:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E99D65
        for <stable@vger.kernel.org>; Sat,  4 Nov 2023 14:01:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B51EC433C7;
        Sat,  4 Nov 2023 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699131685;
        bh=twA7n5UROcimD5EOB1LL+geGawfX6n2/Pv5TX8E/Gd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOwYWQv9yGRYdXDRU8tuDn8X5/o9zipQQ+bf/efuY9+WtoHymM1Ca6hnLlMtuoEPZ
         GluiRTW1WSPFg6cCdtqNICSDZUutPuzYxDree4yGrlOQgQUN/Xby2LlOiPF2GEUISO
         1/HACCQJKmEkkH21/g1l3qNwrG4vlmXFgaxXmLJ6GptFIXCTDWhoLfvFygKHfUYlcr
         Cz3wpiFKgQB8O07FPRE0ngyU1GWH82rgMJVjiDrrDG3QSE2nSQI57Rs7aSmVd0UPLY
         bcL5cYo/h20e7dHu1PDD6Wqb3II6VDUHM3mQpYKKftUNODITu1E6xcJSsDbSALvEnN
         AQpmIK/HMD1NA==
Date:   Sat, 4 Nov 2023 17:01:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: Request to backport commit f9cdeb58a9cf ("perf evlist: Avoid
 frequency mode for the dummy event") to stable versions of Linux kernel
Message-ID: <ZUaxJDSu2x3RuLx-@sashalap>
References: <CAL715WLTjMGQrhm6wWqFSeL_Oq-HzoQd5CqewvLRLv0Xbnibgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAL715WLTjMGQrhm6wWqFSeL_Oq-HzoQd5CqewvLRLv0Xbnibgw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 01, 2023 at 12:10:55PM -0700, Mingwei Zhang wrote:
>Hi Greg,
>
>Apology for any inconvenience. This is info and justification for patch.
>
>Commit-id: f9cdeb58a9cf46c09b56f5f661ea8da24b6458c3
>Subject: perf evlist: Avoid frequency mode for the dummy event
>
>Justification:
>
>This patch fixes a critical performance issue at perf-tool level for
>anything running PMU in a virtualized environment.  Majority of the
>justification is within the commit message. The only thing I would
>like to add is that this patch could save up to 50% of the vCPU time
>when running perf in sampling mode with a large number of events in
>the VM.

Queued up, thanks!

-- 
Thanks,
Sasha

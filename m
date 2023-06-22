Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527673A705
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 19:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFVRNU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjFVRNT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 13:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411B1739
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 10:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5FB86186A
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 17:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F96C433C8;
        Thu, 22 Jun 2023 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687453994;
        bh=vnIzXTq8UNm7s6YGrW0UZ4kxJPx6r2S6kadBUrkNPpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rH7oP9rv12o0kTnrzfPRpa6BNqjRlp/r058iQgA3Av204V2Hco5PSLjC7IL0BEZnl
         juGGiS0xNdo5cUCme3znbnDQXdHWroZ4LPDIOgaHtlnEK6vUPoYcmjeUdGEJR22UeO
         icDCrQa8atAYcn/TWUKovNi87rp6JLz8dmCSd5B0=
Date:   Thu, 22 Jun 2023 19:13:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: diag: skip listen tests if not
 supported
Message-ID: <2023062256-salary-glorified-e5c0@gregkh>
References: <2023062242-ripple-resilient-26a8@gregkh>
 <20230622090852.2848019-1-matthieu.baerts@tessares.net>
 <2023062213-job-matriarch-144d@gregkh>
 <6f9987c8-dcdb-6938-9bae-82605162acd4@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f9987c8-dcdb-6938-9bae-82605162acd4@tessares.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 04:06:22PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 22/06/2023 11:19, Greg KH wrote:
> > On Thu, Jun 22, 2023 at 11:08:52AM +0200, Matthieu Baerts wrote:
> >> commit dc97251bf0b70549c76ba261516c01b8096771c5 upstream.
> >>
> >> Selftests are supposed to run on any kernels, including the old ones not
> >> supporting all MPTCP features.
> >>
> >> One of them is the listen diag dump support introduced by
> >> commit 4fa39b701ce9 ("mptcp: listen diag dump support").
> >>
> >> It looks like there is no good pre-check to do here, i.e. dedicated
> >> function available in kallsyms. Instead, we try to get info if nothing
> >> is returned, the test is marked as skipped.
> >>
> >> That's not ideal because something could be wrong with the feature and
> >> instead of reporting an error, the test could be marked as skipped. If
> >> we know in advanced that the feature is supposed to be supported, the
> >> tester can set SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var to 1: in
> >> this case the test will report an error instead of marking the test as
> >> skipped if nothing is returned.
> >>
> >> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> >> Fixes: f2ae0fa68e28 ("selftests/mptcp: add diag listen tests")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> ---
> >> Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1")
> >> Conflicting with commit e04a30f78809 ("selftest: mptcp: add test for
> >> mptcp socket in use"): modifications around __chk_msk_nr() have been
> >> included here.
> >> ---
> >>  tools/testing/selftests/net/mptcp/diag.sh | 47 ++++++++++++-----------
> >>  1 file changed, 24 insertions(+), 23 deletions(-)
> >>
> > 
> > Now queued up, thanks.
> 
> Thank you for having already queued this patch and all the other ones
> from Linus' tree!
> 
> I just sent the last patches fixing conflicts in v5.10. I don't have any
> others linked to MPTCP and I replied to the ones that don't need to be
> backported to older versions than v6.1.
> 

Thanks, I think I got them all now!

greg k-h

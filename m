Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3E1739CEF
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjFVJ2N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjFVJ1m (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38C230DD
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B88617D7
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 09:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550D1C433CA;
        Thu, 22 Jun 2023 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687425564;
        bh=0ZjKLYp+PmArtOlqx3rb1qE22o+JBfbMN6sU2x7si0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCzX4c+5yf37dloPkgp75QHrH33dUca87vFwr6CpegTQ85NJSG4NVUyxM2b5cosnN
         dNJfVGaVYqvZhHv5ALFmBKhvo6jBCjG8XOJCCrMVSG6yN6XKuUbURRUo2cGhOaOcR6
         KK/ClW4uyqU5fmGvDS1yUDGSXckflHPuAFHJXBTQ=
Date:   Thu, 22 Jun 2023 11:19:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: diag: skip listen tests if not
 supported
Message-ID: <2023062213-job-matriarch-144d@gregkh>
References: <2023062242-ripple-resilient-26a8@gregkh>
 <20230622090852.2848019-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622090852.2848019-1-matthieu.baerts@tessares.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 22, 2023 at 11:08:52AM +0200, Matthieu Baerts wrote:
> commit dc97251bf0b70549c76ba261516c01b8096771c5 upstream.
> 
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
> 
> One of them is the listen diag dump support introduced by
> commit 4fa39b701ce9 ("mptcp: listen diag dump support").
> 
> It looks like there is no good pre-check to do here, i.e. dedicated
> function available in kallsyms. Instead, we try to get info if nothing
> is returned, the test is marked as skipped.
> 
> That's not ideal because something could be wrong with the feature and
> instead of reporting an error, the test could be marked as skipped. If
> we know in advanced that the feature is supposed to be supported, the
> tester can set SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var to 1: in
> this case the test will report an error instead of marking the test as
> skipped if nothing is returned.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: f2ae0fa68e28 ("selftests/mptcp: add diag listen tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1")
> Conflicting with commit e04a30f78809 ("selftest: mptcp: add test for
> mptcp socket in use"): modifications around __chk_msk_nr() have been
> included here.
> ---
>  tools/testing/selftests/net/mptcp/diag.sh | 47 ++++++++++++-----------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 

Now queued up, thanks.

greg k-h

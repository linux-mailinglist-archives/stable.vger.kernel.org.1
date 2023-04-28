Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A126F166C
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbjD1LM6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbjD1LM5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347A4EC4
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9693961B05
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F06DC433EF;
        Fri, 28 Apr 2023 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682680376;
        bh=fmB7MNeEDIfkb0alLUTLL1D7xZBCuwzuRsEjTOM4jf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHz/6NsWnLdIZQ47ixohBfq7TyEnsPl3hpWvD0NgaAswYnr6rmYemeVT+US39stbV
         D8tHhLkYJEJrpc4PGGHiWrIDFybj7j9EgkDxCo+9mxJ1GHnfwHA0hRcRL+nQo4F/9M
         ROJP8AT8eApMIGF891Sq6i1DG91XDOZeS/Ptn76c=
Date:   Fri, 28 Apr 2023 13:12:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     kernel test robot <lkp@intel.com>, stable@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.15] selftests: mptcp: join: fix "invalid address,
 ADD_ADDR timeout"
Message-ID: <2023042842-coleslaw-baffle-a9e2@gregkh>
References: <ZEuV586CQyHtECVB@afc780e125e2>
 <d43a4e40-231d-879f-905d-c258e6d688a8@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43a4e40-231d-879f-905d-c258e6d688a8@tessares.net>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Apr 28, 2023 at 12:30:00PM +0200, Matthieu Baerts wrote:
> On 28/04/2023 11:46, kernel test robot wrote:
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
> > Subject: [PATCH 5.15] selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"
> > Link: https://lore.kernel.org/stable/20230428-upstream-stable-20230428-mptcp-addaddrdropmib-v1-1-51bca8b26c22%40tessares.net
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> > Please ignore this mail if the patch is not relevant for upstream.
> 
> @Stable team: I confirm, this is not relevant for upstream, this is a
> specific patch for v5.15 only.

Not a problem, now queued up, thanks!

greg k-h

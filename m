Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5B6F8EC1
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEFFvk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjEFFvd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD17ECB
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D45F0611DC
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4BAC433D2;
        Sat,  6 May 2023 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352284;
        bh=QfsizzTXbo1U1P+Nyl9+6CzR+OauAvFCbgm41rUPaik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vE38q0ocxSwPTsblQbYS065xFM5vQ3QpdeySMXhXRoVozEjtEz0ZGOTqf7JXSdUhf
         kg3l89BWoyGHVFw6DrLCarra8W6vyGbnXPmBVsD0Im3lKLTBo3U4FeuzCpU13Z9PuU
         6K5Ic5yr7PoQp+A6oXMQ56gwxQkNA83aKaBtacnc=
Date:   Sat, 6 May 2023 09:55:07 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
Subject: Re: Pink sardine ACP stability issue
Message-ID: <2023050658-delighted-durably-a2af@gregkh>
References: <093b3c24-2df0-5a8f-4e41-057f39fcd87f@amd.com>
 <db463655-1baf-b882-b940-23f9b0593159@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db463655-1baf-b882-b940-23f9b0593159@amd.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Apr 28, 2023 at 09:19:22PM -0500, Mario Limonciello wrote:
> On 4/28/23 21:17, Mario Limonciello wrote:
> > Hi,
> > 
> > Some Pink Sardine platforms have some stability problems with reboot
> > cycling and it has been root caused to a misconfigured mux for audio.
> > 
> > It's been fixed in this commit:
> > 
> > a4d432e9132c ("ASoC: amd: ps: update the acp clock source.")
> > 
> > Can you please backport this to 6.1.y +
> > 
> > Thanks,
> > 
> Sorry forgot to add that this commit backports cleanly to 6.2.y and 6.3.y
> but 6.1.y will also need this other commit as prerequisite
> 
> 4b1921143595 ("ASoC: amd: fix ACP version typo mistake")

All now queued up, thanks.

greg k-h

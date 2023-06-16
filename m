Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9011E733A6B
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 22:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFPUGp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbjFPUGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 16:06:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D535A3
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XMyky9NnGRex5d9J6o+89iENFnkLTHlH4e4jijnATl0=;
        t=1686946002; x=1688155602; b=j3gbhI53R5txhZ6dU//y/QMggxAK7DXeHHkp0GbOvCr6zas
        yDfnsUavGknM8OUwAWrpMu0dGY3eHUoraSznakWwxyNjocjxBZfRSB1VrJCt8LJQhwP/dls4A73K7
        uFYZ0kZzx38PoK3/a7HNDtcIUNfOQbT7iBJESrVyAzvYqzkxFlON1iZ52kZYiZMTM1090x8HsgpLf
        3NyvDc1uC4yVoY+xxSjXLVhbnDe0ubRidMZxb4cdWBiSjcMNEKl7HtGdjHfVW50GBJVz8fpjPeTOL
        2wfSAsLvIPeCVwcTa/K1m0iLCtmTQzf8+19bLJQf/IOax8yzQyTerxjge8vvKdoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qAFiS-008bMN-02;
        Fri, 16 Jun 2023 22:06:40 +0200
Message-ID: <dd21d369706b89d5a4033e6af344ed7045465077.camel@sipsolutions.net>
Subject: Re: [PATCH 6.3 038/160] wifi: cfg80211: fix locking in regulatory
 disconnect
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 16 Jun 2023 22:06:38 +0200
In-Reply-To: <2023061628-nimbly-ebook-3635@gregkh>
References: <20230612101715.129581706@linuxfoundation.org>
         <20230612101716.793331479@linuxfoundation.org>
         <23db24e1efd0ce7904d0e57289009852cd58e29b.camel@sipsolutions.net>
         <2023061216-pry-mournful-beed@gregkh>
         <1bcc48094ecae8b810e394abb7101bb8f4acb860.camel@sipsolutions.net>
         <2023061628-nimbly-ebook-3635@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 2023-06-16 at 20:48 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 16, 2023 at 06:51:15PM +0200, Johannes Berg wrote:
> > On Mon, 2023-06-12 at 14:10 +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jun 12, 2023 at 01:43:23PM +0200, Johannes Berg wrote:
> > > > On Mon, 2023-06-12 at 10:26 +0000, Greg Kroah-Hartman wrote:
> > > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > >=20
> > > > > [ Upstream commit f7e60032c6618dfd643c7210d5cba2789e2de2e2 ]

> > > > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.g=
it/commit/?id=3D996c3117dae4c02b38a3cb68e5c2aec9d907ec15

> I can pick them up from here, as the git ids are present and that's all
> I need, right?

Correct, thanks!

Note that in 6.0 the indentation for the second patch changed, but
otherwise the logic is the same (just additional indentation due to
multi-link support.) But I can also just send a fixed version when you
bounce it back due to not applying.

Also, FWIW, I did verify all this in the meantime, and in fact there's
an additional bug here since 6.0, I'll send a separate fix. Also another
problem with OCB iftype ... oh well. More fixes to come later, I guess,
though that's probably not that interesting for stable.

Thanks,
johannes

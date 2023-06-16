Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50677336AB
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 18:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjFPQwz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 16 Jun 2023 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbjFPQvw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Jun 2023 12:51:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7016535A4
        for <stable@vger.kernel.org>; Fri, 16 Jun 2023 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zqjLRS5ULsCC7Xjlxjra+VOWosXaiA2+x91ErZ8Mdf8=;
        t=1686934278; x=1688143878; b=hY+MgltDqZNQ/vMkh87+vNnhgvoGqs+ScsB31mr/i5/os3Y
        KnKB5JXagS7XrqGJtoKP3ARFXD0XJ1Wo/LpmIkB0Y4v9CguEJ87mYJ8SCHuqaXmJmShG5walUYQno
        8YRQuseRmXYHeB8JjIiaOFGnJCxelphDZatYlcnGqWryMC6IqpYq5stYKV8H2Bn+9iyBJxTFbq/OF
        +CYnQvEoq6hgCGSjZxdaxbAR2hDbfpaxkD26BHHj4ukAd2UX2PnaHYw+EuBU6jEqubYaP0SJjR3zG
        Ut1qL+PmeIJ9DJgE1w+PiN3zMQ9AdmmfIntPX3OneWpMaP1lVXpQr+TnW5bncn1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qACfL-008WTL-2w;
        Fri, 16 Jun 2023 18:51:16 +0200
Message-ID: <1bcc48094ecae8b810e394abb7101bb8f4acb860.camel@sipsolutions.net>
Subject: Re: [PATCH 6.3 038/160] wifi: cfg80211: fix locking in regulatory
 disconnect
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Sasha Levin <sashal@kernel.org>
Date:   Fri, 16 Jun 2023 18:51:15 +0200
In-Reply-To: <2023061216-pry-mournful-beed@gregkh>
References: <20230612101715.129581706@linuxfoundation.org>
         <20230612101716.793331479@linuxfoundation.org>
         <23db24e1efd0ce7904d0e57289009852cd58e29b.camel@sipsolutions.net>
         <2023061216-pry-mournful-beed@gregkh>
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

On Mon, 2023-06-12 at 14:10 +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 12, 2023 at 01:43:23PM +0200, Johannes Berg wrote:
> > On Mon, 2023-06-12 at 10:26 +0000, Greg Kroah-Hartman wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >=20
> > > [ Upstream commit f7e60032c6618dfd643c7210d5cba2789e2de2e2 ]
> > >=20
> > > This should use wiphy_lock() now instead of requiring the
> > > RTNL, since __cfg80211_leave() via cfg80211_leave() is now
> > > requiring that lock to be held.
> >=20
> > You should perhaps hold off on this. While all this is correct, I misse=
d
> > something that Dan found later:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/c=
ommit/?id=3D996c3117dae4c02b38a3cb68e5c2aec9d907ec15
> >=20
> > I'll have this in the next pull request.
> >=20
> > I suppose _both_ should go to stable, and nobody ever seems to run into
> > this patch (at least lockdep would loudly complain), but stills seems
> > better in the short term to have missing locking than a deadlock.
>=20
> Thanks for letting me know, I've dropped this from all queues now.
>=20

The above commit has landed in Linus's tree, and I think you actually
should pick up both of these now - there's a lockdep assertion there and
locking issues triggered that I (if erroneously) fixed. Seems that we
hardly ever get to that code though.

Should I send those patches individually?

johannes

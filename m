Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97272C363
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjFLLtB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjFLLsr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:48:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC54EFE
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yvCB3v5gxtnLTEpQPY5JHQKObtHsN7WRN1uVn8i+7tA=;
        t=1686570235; x=1687779835; b=gBSvBVyBinluGZw+psB0RAjMk0ECkSUltMDz+z3HpZ7OC/A
        xoTApaU2XXjQ6mCrZXyIFbuTRlljTJwIGUzUFgiFZ78CD2kOIHN5baj/ySu5HSXXF9sabFONljpCW
        EQO1zc+c14pdxeNGxUNYNknRMUY6dlE72HY5+TqRrYdBCgO05FTRBLzf6LYVgMl+xFCyN8r6XEmLr
        6hgeDQbVP4NI7BvYMiDqRyb1Bj1q6LG10CtIYPvtnaTiPcMllZDNXpcF3EhKHloKR0XjZAo6SppAi
        ScgBABSD9xs3V69drJUJ31ORswv0d6RCStrDtilDXF78m2bClX9UtwK4mZEBkj0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q8fxE-003tT5-0k;
        Mon, 12 Jun 2023 13:43:25 +0200
Message-ID: <23db24e1efd0ce7904d0e57289009852cd58e29b.camel@sipsolutions.net>
Subject: Re: [PATCH 6.3 038/160] wifi: cfg80211: fix locking in regulatory
 disconnect
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        Sasha Levin <sashal@kernel.org>
Date:   Mon, 12 Jun 2023 13:43:23 +0200
In-Reply-To: <20230612101716.793331479@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
         <20230612101716.793331479@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 2023-06-12 at 10:26 +0000, Greg Kroah-Hartman wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> [ Upstream commit f7e60032c6618dfd643c7210d5cba2789e2de2e2 ]
>=20
> This should use wiphy_lock() now instead of requiring the
> RTNL, since __cfg80211_leave() via cfg80211_leave() is now
> requiring that lock to be held.

You should perhaps hold off on this. While all this is correct, I missed
something that Dan found later:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3D996c3117dae4c02b38a3cb68e5c2aec9d907ec15

I'll have this in the next pull request.

I suppose _both_ should go to stable, and nobody ever seems to run into
this patch (at least lockdep would loudly complain), but stills seems
better in the short term to have missing locking than a deadlock.

johannes

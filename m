Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48372DD28
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbjFMJAZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 05:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbjFMJAX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 05:00:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4801FAA
        for <stable@vger.kernel.org>; Tue, 13 Jun 2023 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1686646810; x=1687251610; i=s.l-h@gmx.de;
 bh=gbWAOiAH1S0qo/0DEWJ19kZQB9sQn3cSoYgfv9ZLLqw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=kZQexa9XXoegf0D4IpjeVjFFfWMOv5gmq9wmdLxs+MZdi+sENgkoRvdAtn4d2XGRfQxUxlv
 7OwesgSSu1LclTNJ61oO9Z5SIL5hAjaxzf0eMDYd6SIdW6LHEbrodWkb7kmmF+MZMKTVyvnQd
 x1UTKvsw7gXY5GAwi0QTybH8MCkZ/YxENmqr5/h87rACRkRFwUL3sfy6oQvkz7EJ9JI1vcT6k
 wn4oVCfOfRVLn1o/hQaZV9gig0lizHtsPWjDAPEPgKM6WMp1Q+iqPnC6ElPAPtivTQ2b8dSRZ
 qQ8kRaJ2980iTjYJ9vS7CAYj04j59HLg4dl38k1VauB2p9TwLJDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.90.21]) by mail.gmx.net (mrgmx004 [212.227.17.190])
 with ESMTPSA (Nemesis) id 1MdNY2-1pZwBG0P8i-00ZPWd; Tue, 13 Jun 2023 11:00:10
 +0200
Date:   Tue, 13 Jun 2023 11:00:06 +0200
From:   Stefan Lippers-Hollmann <s.l-h@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.3 136/286] media: dvb-core: Fix use-after-free on race
 condition at dvb_frontend
Message-ID: <20230613110006.7c660162@mir>
In-Reply-To: <20230613053314.70839926@mir>
References: <20230607200922.978677727@linuxfoundation.org>
        <20230607200927.531074599@linuxfoundation.org>
        <20230613053314.70839926@mir>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yRIJ5y+vGS5Pm6+FkKMOqmf/15l6vsyTLCn8fXa05KTNaLU/qre
 62huYSiq4kQrImfcCttjcmfxYuGhF8oQs4Uow88ZWjMFaxVbF3oYErEU4GbLyqqH2es/w1S
 65EZTSsmb3z/CK0LGh4sW6TD04j+n9EqkqE+j63h7Nx03mYnyiJtH5dsDCP38atpHrJPUM3
 k/3PCy22Nn/g1UFQJUglw==
UI-OutboundReport: notjunk:1;M01:P0:1AlDcf96GUM=;l6+tcyUR5u4oXTHyKElntQEqCCW
 2BYiKi9L649aTcjjDK49Zjg8a4vMzknhyHNsz9wyRbC3yWWYptIrmAyoW8RiTZbuIMCD6RU03
 fncafB88uh9dE/RVRnc+xQ5zD4HBmxBumbwJbrXRpgj6wmyBU6uTl3FKD6Eb4gtaZJvJOk01r
 ZOtXjwrX//wVoSAU6rYe88KubunMv461nxF+Y6GZHs67wC+22aJ76bczPdK+7hIuVGhrOC2yN
 7xmQGX5wOtFC9CNAak7BEJAYohTa1a+m4vt4cOSYawkRb36891go1hAQp/xTiugyceWksfeGF
 cY5GZE/7wJeOyNF48SSc09mLRcqYFj4v74fl1uvTcmjHooLQno5iveaE9/eKKd/t2+9joS0p7
 mwP1YCyAHzSAYmNdisHErCjNcf5Nce5jR8pUMayphS/y4fgpBV3Ka4pPMBm70LZE0auNlXqif
 w/kBSW3K8X1kbnZ9/LWsbyDskdxW1dKjnaU6srm6wI3lZwYSw+VPABtnmyUAVLXqsa5INSQGI
 PpRiSsYh9b+DrxVrKBXJgsAHpOO2ou7ZRkOsVcyd1CUtSiUaZRBav2IwUfpZVxXgtHihE26B7
 QXng2NkftvcrdcOhiVN44ajWW3FZ47X8+ALZsTKVGSLm7HRnuzj+zSW1ZlPgoyuQdXRXc+cNT
 M1uTvRyH5IX3iZ3Sy5Cz+TK3AI1RIdE+KIJXh1smrm0NsBT7lkLuh56JkRBzoZqN54HzlNNw+
 mtOGl+3XKrAztmYbSVXWd97wRXZuA/NPOyc+jWSxtzBAPOl9QDe0PRsElWF59SZeuSUoMHfKx
 2vhRiU8QG2/YyFYD+EXX7y9a9/brpBnBfxZQJ46aK+6EstKmWQdcqrj9jo3fM0k2vy5bzcZti
 QBUgqResRMgbuaRQLPNOF1yI91eLYB6FECCkXCJtREhjr29uYRzicQFzHAf9lFlOacDnAIMpF
 j6RCqw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi

On 2023-06-13, Stefan Lippers-Hollmann wrote:
> On 2023-06-07, Greg Kroah-Hartman wrote:
> > From: Hyunwoo Kim <imv4bel@gmail.com>
> >
> > [ Upstream commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f ]
> >
> > If the device node of dvb_frontend is open() and the device is
> > disconnected, many kinds of UAFs may occur when calling close()
> > on the device node.
> >
> > The root cause of this is that wake_up() for dvbdev->wait_queue
> > is implemented in the dvb_frontend_release() function, but
> > wait_event() is not implemented in the dvb_frontend_stop() function.
> >
> > So, implement wait_event() function in dvb_frontend_stop() and
> > add 'remove_mutex' which prevents race condition for 'fe->exit'.
> >
> > [mchehab: fix a couple of checkpatch warnings and some mistakes at the=
 error handling logic]
> >
> > Link: https://lore.kernel.org/linux-media/20221117045925.14297-2-imv4b=
el@gmail.com
> [...]
>
> I'm noticing a regression relative to kernel v6.3.6 with this change
> as part of kernel v6.3.7 on my ivy-bridge system running
> Debian/unstable (amd64) with vdr 2.6.0-1.1[0] and two DVB cards
> TeVii S480 V2.1 (DVB-S2, dw2102) and an Xbox One Digital TV Tuner
> (DVB-T2, dvb_usb_dib0700). The systemd unit starting vdr just times
> out and hangs forever, with vdr never coming up and also preventing
> a clean system shutdown (hard reset required). Apart from the systemd
> unit timing out, there don't really appear to be any further issues
> logged.
[...]

I've now also tested v6.4-rc6-26-gfb054096aea0 and can reproduce
this regression there as well, with the same fix of reverting this
corresponding patch.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f

Regards
	Stefan Lippers-Hollmann

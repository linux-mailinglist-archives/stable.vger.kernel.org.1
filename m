Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FDB707BAF
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjERIP1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Thu, 18 May 2023 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjERIP0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 18 May 2023 04:15:26 -0400
Received: from nef.ens.fr (nef2.ens.fr [129.199.96.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B6626BB
        for <stable@vger.kernel.org>; Thu, 18 May 2023 01:15:23 -0700 (PDT)
X-ENS-nef-client:   129.199.127.85 ( name = mail.phys.ens.fr )
Received: from mail.phys.ens.fr (mail.phys.ens.fr [129.199.127.85])
          by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 34I8EVjQ019440
          ; Thu, 18 May 2023 10:14:31 +0200
Received: from skaro.localnet (unknown [176.151.100.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by mail.phys.ens.fr (Postfix) with ESMTPSA id B19771A1A55;
        Thu, 18 May 2023 10:14:30 +0200 (CEST)
From:   =?ISO-8859-1?Q?=C9ric?= Brunet <eric.brunet@ens.fr>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        jouni.hogander@intel.com, jani.nikula@intel.com,
        gregkh@linuxfoundation.org
Subject: Re: Regression on drm/i915, with bisected commit
Date:   Thu, 18 May 2023 10:14:30 +0200
Message-ID: <5681706.DvuYhMxLoT@skaro>
In-Reply-To: <ZGU56n66OAe0DqN3@intel.com>
References: <3236901.44csPzL39Z@skaro> <ZGU56n66OAe0DqN3@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Rspamd-Queue-Id: B19771A1A55
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.38 / 150.00];
         ARC_NA(0.00)[];
         R_SPF_NEUTRAL(0.00)[?all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MIME_TRACE(0.00)[0:+];
         DMARC_NA(0.00)[ens.fr];
         RCPT_COUNT_FIVE(0.00)[6];
         HFILTER_HELO_IP_A(1.00)[skaro.localnet];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[skaro.localnet];
         NEURAL_HAM(-0.00)[-1.000,0];
         IP_SCORE(-1.76)[ip: (-0.16), ipnet: 176.128.0.0/10(-4.87), asn: 5410(-3.66), country: FR(-0.09)];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         ASN(0.00)[asn:5410, ipnet:176.128.0.0/10, country:FR];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[];
         BAYES_HAM(-2.92)[99.66%];
         ONCE_RECEIVED(0.10)[]
X-Rspamd-Server: mail
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef.ens.fr [129.199.96.32]); Thu, 18 May 2023 10:14:31 +0200 (CEST)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Le mercredi 17 mai 2023, 22:32:42 CEST Ville Syrjälä a écrit :
> On Tue, May 16, 2023 at 03:04:53PM +0200, Éric Brunet wrote:
> > Hello all,
> > 
> > I have a HP Elite x360 1049 G9 2-in-1 notebook running fedora 38 with an
> > Adler Lake intel video card.
> > 
> > After upgrading to kernel 6.2.13 (as packaged by fedora), I started seeing
> > severe video glitches made of random pixels in a vertical band occupying
> > about 20% of my screen, on the right. The glitches would happen both with
> > X.org and wayland.
> 
> Please file a bug at https://gitlab.freedesktop.org/drm/intel/issues/new
> boot with "log_buf_len=4M drm.debug=0xe" passed to kernel cmdline, and
> attach the resulting dmesg to the bug.

Thank you for your answer, I have just opened the issue as requested.

https://gitlab.freedesktop.org/drm/intel/-/issues/8480

Éric Brunet



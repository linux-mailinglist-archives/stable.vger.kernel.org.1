Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1697D3669
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjJWMZp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjJWMZn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 08:25:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C507CD7C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 05:25:41 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 70CF620B74C0;
        Mon, 23 Oct 2023 05:25:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 70CF620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1698063941;
        bh=CD0UDW+r4tW96TX3+q3JQSftBZRSjNaIr1AHFddCYmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCxFIIQDthehXUg4byFZyyIyY2fNU+qdvEVFUpS8HbhcMfc/5Odo4EENW8EWnGF/5
         cM1nZ0zf/GIeUyGaYEAhJxTPdIG9ikLoBsawOzAAXBaM0IRvlxJM2Mp9h4gAaq1440
         ojb5qZ5dyhWO6fkfxXtc89lbh5a77UjyuEelUt/k=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4.14.y 0/1] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Mon, 23 Oct 2023 15:25:37 +0300
Message-ID: <4841753.GXAFRqVoOG@pwmachine>
In-Reply-To: <2023102317-liberty-kelp-3492@gregkh>
References: <2023102140-tartly-democrat-140d@gregkh> <20231023094947.258663-1-flaniel@linux.microsoft.com> <2023102317-liberty-kelp-3492@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi!

Le lundi 23 octobre 2023, 13:23:36 EEST Greg KH a =E9crit :
> On Mon, Oct 23, 2023 at 12:49:46PM +0300, Francis Laniel wrote:
> > Hi.
> >=20
> >=20
> > I received messages regarding problems to apply the upstream patch.
> > I was able to reproduce the problem on the following stable kernels:
> > * 4.14,
> > * 4.19,
> > * 5.4
> > * and 5.10
> > But it seems to be false positive for kernel 5.15 and 6.1, is this case
> > possible or I did something wrong?
>=20
> Did you try to build with the patch applied?  That might be the issue
> for those kernels.

Indeed, I did not and there is a problem with an unknown function on these=
=20
kernels; I sent updated patches.
Note that, I did not send updated patches to some kernel as they could reus=
e=20
the patch from an older kernel.
I would like to first get reviews, as I had to modify them to suit stable=20
kernels, on this first batch and once everything is validated I will send t=
he=20
patches for the remaining kernels.

>=20
> thanks,
>=20
> greg k-h

Best regards and thank you in advance



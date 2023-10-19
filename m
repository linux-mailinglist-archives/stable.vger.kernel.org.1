Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815307CF3FB
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjJSJZh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJSJZg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 05:25:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E281A3;
        Thu, 19 Oct 2023 02:25:32 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9A86120B74C0;
        Thu, 19 Oct 2023 02:25:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A86120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697707531;
        bh=AI1qBykrpVmfzjirY+qLYP+PIjRlyk/G8w7WrSnBnFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwQiAf1QcE9x2Q6L5miT2oB1ixIB3a0vuNm8wW0LH7ypMdauTsMRYpMq5YqAbHBfL
         K4uS2HifvX57VkIsJpARq4KxGGsCIV7k+jpvArArQsKgEfTpTJRLbMtxaWk/JqpQlq
         TongDoQtgsNkJ96WRNMVjvewn3Ij3xurc6lhUk+0=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date:   Thu, 19 Oct 2023 12:25:27 +0300
Message-ID: <2703022.mvXUDI8C0e@pwmachine>
In-Reply-To: <20231018130042.3430f000@gandalf.local.home>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com> <20231018130042.3430f000@gandalf.local.home>
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

Le mercredi 18 octobre 2023, 20:00:42 EEST Steven Rostedt a =E9crit :
> On Wed, 18 Oct 2023 17:40:28 +0300
>=20
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > Changes since:
> >  v1:
> >   * Use EADDRNOTAVAIL instead of adding a new error code.
> >   * Correct also this behavior for sysfs kprobe.
> > =20
> >  v2:
> >   * Count the number of symbols corresponding to function name and retu=
rn
> >   EADDRNOTAVAIL if higher than 1.
> >   * Return ENOENT if above count is 0, as it would be returned later by
> >   while
> >   registering the kprobe.
> > =20
> >  v3:
> >   * Check symbol does not contain ':' before testing its uniqueness.
> >   * Add a selftest to check this is not possible to install a kprobe fo=
r a
> >   non unique symbol.
> > =20
> >  v5:
> >   * No changes, just add linux-stable as recipient.
>=20
> So why is this adding stable? (and as Greg's form letter states, that's n=
ot
> how you do that)

Oops! Really sorry for this, I will correct everything for the next version!

>=20
> I don't see this as a fix but a new feature.

You mean I should add a "Fix:" in the commit description?

>=20
> -- Steve

Best regards.



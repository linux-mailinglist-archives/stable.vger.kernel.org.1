Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C833D76DD26
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 03:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjHCB2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 21:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjHCB2j (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 21:28:39 -0400
X-Greylist: delayed 49626 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 18:28:34 PDT
Received: from out-110.mta1.migadu.com (out-110.mta1.migadu.com [95.215.58.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8826BA
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 18:28:34 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691026112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DX+DfpCevvaHH/+OzeFNB+vtLI5Gr1MgyBG+YW0SvOU=;
        b=Ew8BBWfB8ZfCXaaHElN9mzV5jA3hcj1KHwM3b76f1E8oEJmamrodBOTaExZBHKhww1zMl6
        ZJ+eXB24zU2vS0UIDrZdAWgfKULyMbdkGph+EOPD7HgCBm6fHrLzvKmiLSbdhPW58XtwaS
        tQrcogSfSgTnz5nQbrb1QWJty7e8kPk=
Date:   Thu, 03 Aug 2023 01:28:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   cixi.geng@linux.dev
Message-ID: <840c9ebf1d741de735b3a1d882364ff0f3904bdd@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] perf: Fix function pointer case
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     peterz@infradead.org, stable@vger.kernel.org, enlin.mu@unisoc.com
In-Reply-To: <2023080214-unneeded-wireless-3508@gregkh>
References: <2023080214-unneeded-wireless-3508@gregkh>
 <20230802114053.3613-1-cixi.geng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

2023=E5=B9=B48=E6=9C=882=E6=97=A5 19:47, "Greg KH" <gregkh@linuxfoundatio=
n.org> =E5=86=99=E5=88=B0:


>=20
>=20On Wed, Aug 02, 2023 at 07:40:53PM +0800, Cixi Geng wrote:
>=20
>=20>=20
>=20> From: Peter Zijlstra <peterz@infradead.org>
> >=20=20
>=20>  commit 1af6239d1d3e61d33fd2f0ba53d3d1a67cc50574 upstream.
> >  With the advent of CFI it is no longer acceptible to cast function
> >  pointers.
> >=20=20
>=20>  The robot complains thusly:
> >=20=20
>=20>  kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu=
_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompa=
tible-function-type
> >=20=20
>=20>  Reported-by: kernel test robot <lkp@intel.com>
> >  Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >  Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> >  ---
> >  kernel/events/core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
>=20
> What stable tree(s) is this for?
>
Hi Greg
I want to apply this patch for linux-5.15-y and linux-6.1-y,=20
the=20other stable trees not requred for me, thanks!

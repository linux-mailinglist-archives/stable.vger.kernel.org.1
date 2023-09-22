Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9343D7AB28C
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjIVNLG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 09:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjIVNLF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 09:11:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0570C6
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 06:10:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-274d3ff35e5so1416058a91.2
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 06:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695388259; x=1695993059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2oPeZhckOvgIexU3V5j2cMrv17aN9eNzF5o8qmXjZ4=;
        b=YTBmpigEMTjuQtFh9jo2FWlcyHdgdrnJ0yHlmXuMzxCtWwak16PIbNJDenVPEdLSuS
         hDtjGIxskka9Lglbo2li4gZsUwAJ86+uwDPNTZFV2qLnFEe2fHoVj0pRvJTj69r3XtR5
         XpRmPXh2klS4Bcs5OWMxd8fcpRWoEu4txHz34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695388259; x=1695993059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2oPeZhckOvgIexU3V5j2cMrv17aN9eNzF5o8qmXjZ4=;
        b=jAV2CL83tCB8CV1swXBoMIKTXloy464kbuevdpq76a3K2B4OZVzYpFcmBtGMmHHCoK
         PTny0ayPrDYGviX1uGa63+fzVSoVJFqKsPp/gpb8MmbbcpgPe6lzF4Sachk6ADnIfaBE
         oEQT1mX1Cmw8RCqrOi/M/iYQJ06aTfrd/9kGWpM5M+9E7J0SPc/yCbXSiU1MT9+ZltlI
         Sttozmy1mBezCxSE9BY7WP9k73BzYLMFcuCFFDz3tDoAwICoFJkfdL6V/8nrUTUixeEG
         56z5lD09IGnqZM/Luz5dcXRKXRwZhEa7e+Wmg3bZ2zmekWVby5llXxid12pHk4D5o3cz
         YChA==
X-Gm-Message-State: AOJu0Yzhg2JXc3/VjN3+3tfWZx5Dl9T+LkZdCaO7IWEMcNxVjl67LRlo
        fD00FgoLirDnOnc0q7JWbcxdUiOxb/Js6kqqKKagDQ==
X-Google-Smtp-Source: AGHT+IFRIXNGRSiyeeGsj2os9DBwlJZoYk789nEzGMD9JjigPWdKYgad7HmRqJDcmKUsVwCJ+TDjHTw38JL3QO8ExJE=
X-Received: by 2002:a17:90b:2396:b0:273:fa72:ba83 with SMTP id
 mr22-20020a17090b239600b00273fa72ba83mr8151795pjb.47.1695388259003; Fri, 22
 Sep 2023 06:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230828150858.393570-1-revest@chromium.org> <20230828150858.393570-5-revest@chromium.org>
 <20230921182910.2fcce58b27b23f767050033c@linux-foundation.org>
In-Reply-To: <20230921182910.2fcce58b27b23f767050033c@linux-foundation.org>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 22 Sep 2023 15:10:47 +0200
Message-ID: <CABRcYmJzWLQ2jPH6WmugUrePX+=JMo5iqP0S=U4n191GCm9ChA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 22, 2023 at 3:29=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 28 Aug 2023 17:08:56 +0200 Florent Revest <revest@chromium.org> w=
rote:
>
> > Defining a prctl flag as an int is a footgun because on a 64 bit machin=
e
> > and with a variadic implementation of prctl (like in musl and glibc),
> > when used directly as a prctl argument, it can get casted to long with
> > garbage upper bits which would result in unexpected behaviors.
> >
> > This patch changes the constant to an unsigned long to eliminate that
> > possibilities. This does not break UAPI.
> >
> > Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prct=
l")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Why is this being offered to -stable?  Does it fix any known problem?

The background for this was discussed in these threads:
v1: https://lore.kernel.org/all/66900d0ad42797a55259061f757beece@ispras.ru/
v2: https://lore.kernel.org/all/d7e3749c-a718-df94-92af-1cb0fecab772@redhat=
.com/

Cc-ing stable was suggested by David and Alexey:

> On Mon, May 22, 2023 at 8:58=E2=80=AFPM Alexey Izbyshev <izbyshev@ispras.=
ru> wrote:
> > On 2023-05-22 19:22, David Hildenbrand wrote:
> > > Which raises the question if we want to tag this here with a "Fixes"
> > > and eventually cc stable (hmm ...)?
> >
> > Yes, IMO the faster we propagate this change, the better.
>
> Okay, will do

I think that a stable backport would be "nice to have": to reduce the
chances that users build binaries that could end up with garbage bits
in their MDWE prctl arguments. We are not aware of anyone having yet
encountered this corner case with MDWE prctls but a backport would
reduce the likelihood it happens, since this sort of issues has
happened with other prctls. But If this is perceived as a backporting
burden, I suppose we could also live without a stable backport.

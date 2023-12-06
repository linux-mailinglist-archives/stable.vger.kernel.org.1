Return-Path: <stable+bounces-4849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB36807507
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AD61F211C3
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72FA47777;
	Wed,  6 Dec 2023 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hczI5Ffl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB770D66
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 08:32:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2866fe08b32so2753258a91.2
        for <stable@vger.kernel.org>; Wed, 06 Dec 2023 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701880330; x=1702485130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpWHSnwqX6HGw3nev19mj+TqZHsprVdc8TbYWfoKuUE=;
        b=hczI5FflWAyfvrcSjcRo8KE49yShQdAWyJc7PDYOufzjiksL0s4wFG34Jc8x7jg4jY
         3IgvxZne3HgQHxHAIkt+lISSp3v1hw3uTky6+U+60Q2zR/rIRTJ7ueTcKSwjq0Bp1JC9
         Ania92CEkCoL/daTmkCyiKVNJR0MqUWLCsFCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880330; x=1702485130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpWHSnwqX6HGw3nev19mj+TqZHsprVdc8TbYWfoKuUE=;
        b=pXP57sFkOhkR6O26Rx/FPCHnleXPYMWCsGX4qx4Svg28iVBKf9s2FFsnKdUUQkdeHu
         s3DIzdxrVHwpbio7KZbNgynoncQSXaulJM/+b4UkLQDdkHc5toEsKYG5Q7E967nTUQa7
         TOvFDRgRt5+CC/Cyca7vkOkP/55HQu1TKESsZhHybaieaKWai40W0KMQ09a6No5Qqe0m
         cMt0p6ANKu3U+dsFHQxLKSrXRzzRfU5LXelKWYGqAyp6+duEBO4M+g3vSk8p78G76OG6
         EYKvSzJ59X+xA2ODtjpbaJXjJSavsdP59FuY/SompJ0obM46hS6TX/3RuCj/1xtzn4lt
         h/eQ==
X-Gm-Message-State: AOJu0Yzz1y2bcNLpj3N93ahP6MxZd/sky/e0uK0+/RKGb+xp60uyeWlh
	EgQ/fb8DmCWYWqjGGGSJX2n63ObkIKoL3JpOTk5YWA==
X-Google-Smtp-Source: AGHT+IHMeqL8lOmKvUkMF2gAiKe1sHWTw8ksly3QdH0Alfj1FCDrqNZxJ3UJiuivodxNNhhTwt3fLmoYyoFbwHRY8Q8=
X-Received: by 2002:a17:90b:4f49:b0:286:b8a1:f1a2 with SMTP id
 pj9-20020a17090b4f4900b00286b8a1f1a2mr825338pjb.44.1701880330074; Wed, 06 Dec
 2023 08:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206123719.1963153-1-revest@chromium.org> <ZXCNouKlBlAKgll9@Laptop-X1>
In-Reply-To: <ZXCNouKlBlAKgll9@Laptop-X1>
From: Florent Revest <revest@chromium.org>
Date: Wed, 6 Dec 2023 17:31:58 +0100
Message-ID: <CABRcYmKK0F1F5SzXoUpG4etDz2eGhJoSZo56PHq7M+MNjcjTKA@mail.gmail.com>
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 4:05=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> w=
rote:
>
> On Wed, Dec 06, 2023 at 01:37:18PM +0100, Florent Revest wrote:
> > In __team_options_register, team_options are allocated and appended to
> > the team's option_list.
> > If one option instance allocation fails, the "inst_rollback" cleanup
> > path frees the previously allocated options but doesn't remove them fro=
m
> > the team's option_list.
> > This leaves dangling pointers that can be dereferenced later by other
> > parts of the team driver that iterate over options.
> >
> > This patch fixes the cleanup path to remove the dangling pointers from
> > the list.
> >
> > As far as I can tell, this uaf doesn't have much security implications
> > since it would be fairly hard to exploit (an attacker would need to mak=
e
> > the allocation of that specific small object fail) but it's still nice
> > to fix.
> >
> > Fixes: 80f7c6683fe0 ("team: add support for per-port options")
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Thank you for the quick reviews Hangbin & Jiri, I appreciate! :)

I just realized I forgot to CC stable (like I always do... :) maybe I
should tattoo it on my arm) Let me know if you'd like a v2 adding:

Cc: stable@vger.kernel.org


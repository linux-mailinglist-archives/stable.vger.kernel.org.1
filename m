Return-Path: <stable+bounces-10597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7482C5E6
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 20:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A791F247EE
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA37415E99;
	Fri, 12 Jan 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDt7G/WI"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0E415AFA;
	Fri, 12 Jan 2024 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbd029beef4so6188010276.0;
        Fri, 12 Jan 2024 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705087944; x=1705692744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWZyqbuCyes2XUzEpE38w3XGfwfjhbR2pOBjXgvzPqs=;
        b=JDt7G/WIPFFPKjllcNpKRkaKh/pKbMwDU/VoI/N3mM+wcJ0mQyaFW1GfL53yY+8DH7
         RnZXkWT7fLsx/kUh9NjvaFJxl33m4BEnSOgO8eXx963ZlLocTyeVlz7jIuLzf6RIyB/Q
         RjMQvT1jdJIF3RUEF/Kfd7VvP3gp9TxqChGmVvfbRKkvaadq6nSu1J7gMWgxBbKLvU/S
         yQSgYiFOZQhctLR1HUSL3a6oDj7Ldix3oQp4YSEEj4nt7VSYGyHwdBzKK8nSbYI8jOdW
         J0PgobrbE+xcICCocacZzPcSMzjmcKIUqjtikHw/cc9cgL4PcWL4Z6NsUKce9D9DNUtd
         zNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705087944; x=1705692744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWZyqbuCyes2XUzEpE38w3XGfwfjhbR2pOBjXgvzPqs=;
        b=skV1jBNJHweFvEI3r7AYkwnqH9RUftPMVPXmvww9Djp7m8dpp/1KQFxxbYmumgMC3A
         DEobuLjIMQd4/hDKRVhlJFiHUghhYXoypVUgB/a/+IG96fZ27qusqutH9C1nbZYjfq4v
         Zb3zXFGgqgBLqYL5Q7efQmK/vsdhLtv/PMce08YNJORPmauUbN8Yo45E6acp+TUBrpnU
         YFi5zMM78c1AeHci0SpWN2MGneAwDGQzWPL9CkzP9VAeXuPvaZwsEjuncf84QraM+19+
         AkslySiJQo3Tl+KpCO1SVsfXTeQWOVoj70Ml3F0ueSzGDJF9ubCS68cRH3reHDRnV3hl
         EjMw==
X-Gm-Message-State: AOJu0YzRs7d+zNrGuDnYgwl9iI8+vBx1ur3PkfIIQrMa2KpXBWNpJ/cy
	uKCisd0AboW6X2OMzwVmPcPbgrJ0cbC0ndsxj4SjjVoDSfL9aw==
X-Google-Smtp-Source: AGHT+IF5AHQNoTYNYqzXKMf7ayCFabGY/obwfiSYlO9P1bpccUjMLtdMli8LJ/dDqN+pbUy7lEEK02KROV3a91Rj6p0=
X-Received: by 2002:a25:b91:0:b0:dbe:3074:c6f4 with SMTP id
 139-20020a250b91000000b00dbe3074c6f4mr799841ybl.30.1705087944330; Fri, 12 Jan
 2024 11:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzPG9MU2PfTk2Yn+spJqH6mLVsG1p6L6vhJ4LFG+aiojnN6HQ@mail.gmail.com>
In-Reply-To: <CAAzPG9MU2PfTk2Yn+spJqH6mLVsG1p6L6vhJ4LFG+aiojnN6HQ@mail.gmail.com>
From: Justin Chen <justinpopo6@gmail.com>
Date: Fri, 12 Jan 2024 11:32:13 -0800
Message-ID: <CAJx26kVJ=TxxejKACMJOoiEZfwpFJ9A3SGncBtd8QyWM5+ew0w@mail.gmail.com>
Subject: Re: [REGRESSION] In v5.15.146 an ax88179_178a USB ethernet adapter
 causes crashes
To: Jeffery Miller <jefferymiller@google.com>
Cc: stable@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>, kuba@kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:01=E2=80=AFAM Jeffery Miller
<jefferymiller@google.com> wrote:
>
> For 5.15 attempting to use an ax88179_178a adapter "0b95:1790 ASIX
> Electronics Corp. AX88179 Gigabit Ethernet"
> started causing crashes.
> This did not reproduce in the 6.6 kernel.
>
Looks like my patch set was not fully backported. The patchset didn't
have a "Fixes" tag, so it looks it was partially pulled for
d63fafd6cc28 ("net: usb: ax88179_178a: avoid failed operations when
device is disconnected") which does have a fixes tag. Just looks like
a bad backport here. Apologies, I should have caught it when I saw the
stable email, I didn't realize it was only for part of the changeset.

Thanks,
Justin

> The crashes were narrowed down to the following two commits brought
> into v5.15.146:
>
> commit d63fafd6cc28 ("net: usb: ax88179_178a: avoid failed operations
> when device is disconnected")
> commit f860413aa00c ("net: usb: ax88179_178a: wol optimizations")
>
> Those two use an uninitialized pointer `dev->driver_priv`.
>
> In later kernels this pointer is initialized in commit 2bcbd3d8a7b4
> ("net: usb: ax88179_178a: move priv to driver_priv").
>
> Picking in the two following commits fixed the issue for me on 5.15:
> commit 9718f9ce5b86 ("net: usb: ax88179_178a: remove redundant init code"=
)
> commit 2bcbd3d8a7b4 ("net: usb: ax88179_178a: move priv to driver_priv")
>
> The commit 9718f9ce5b86 ("net: usb: ax88179_178a: remove redundant
> init code") was required for
> the fix to apply cleanly.


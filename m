Return-Path: <stable+bounces-125978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDCBA6E54C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 22:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5DF174E9C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B241DF73D;
	Mon, 24 Mar 2025 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbpfAzhb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109831DF971
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850618; cv=none; b=HfM/dRGmIb37zKST3W2tUQYKV8UiQK0KuA/wXzXPFOt27AjNeMx6wrgoT0/XFKT9QSCVZX7YEV0QodKeORe7F5DHxDCXu1ywQeMdOzWobtuipZ9RUQY/i1UoyS13lHq+tTK7mstHuhkRofuJb/J0SUkwdHUUqyO0b6vmSVZ6UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850618; c=relaxed/simple;
	bh=YRZbxcF9Di2VYHWGkzvCqQPBnLYjWa0qGJ8pQ0rENWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx19UtT1VaZQvTEjxo+iha4ab36d2aflcH+cdNoUwNbEYJ0xVASi+thnUYdBxgmdhxzEfoNudRpPy6rYSTO4nLy2v3CJM/dNgqNmJBTrLXkocL/CLdPe3Nl777DzhLJM/LwriqjwFBxNX2FgyYAELnA3cwvi5e73iN/JglHUA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbpfAzhb; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e637669ef11so3297302276.1
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742850615; x=1743455415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K3UkVzO6u1eafgMPvZcwTg1nhlQ6wrhXV7skiiCRrk=;
        b=BbpfAzhbb6sbVemVGOaY7EfLRfl+HsNuaOmsQiEFKZvyoli13yapb+eaImkgjP9IMk
         PYcabnodW1C/ZrCv9Nxnq5HB3eWCjbiWxw5jbjqv/NyWelNjC47Z1j2KFAH4ylDTgmLx
         seR9PB2q18aR79JMzpX16K8lXxLvJc7GRMpttok1xfKca20en2GF50HNca16zU3DKr75
         ESXJssL7ixUNfOVhl4maNgMPmZMuSUwt1TCC6EAcJKf22RS/IrwgXuHPPP8OhhGHQcQq
         1sjy65q2esH+MSm81xOFm48ewieKjKLgubzfW+dG+G7OVxEW8+VcKdTzMAND2e/tU76S
         vbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850615; x=1743455415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K3UkVzO6u1eafgMPvZcwTg1nhlQ6wrhXV7skiiCRrk=;
        b=f6U+Hg8yjOPB6ScN0yrqjT+9haC1VRNnQcSXnc94Bm9EgWVEPtHOjrz/IYZ0Sg1tbT
         I8ZjVOzIt1lEeW6VOJn7ksi4vO/ca1DWH/cCfNYeCyzxPWzvJGRaCY1EOBJhAvuzLC3Z
         7XvqPs1tfD0MFsRQ4krVM9a+8FoTGPyh3jTIOoH9dRYC9LUhLpfBT8qqNUglaf5Cifc+
         AZ14OVx6iPAdeN5mQ3EcZAIuPnUb/W5A1fvkkZJUPCuKc0Dp8W7SGS4pL76lu4SdT58t
         TXZDb99pWOh/lni4ogqH7Jn2AetNb7yduhPCtVJyYXgMBfkHd0+hGZI4W0n6qgDoPP8n
         oh7g==
X-Gm-Message-State: AOJu0Yw4i36JsZKWWDLw9mQjfAZ8XcY5pWmEzIMOgPHjtWQXZM2IFTZo
	ltPh+rsmWboTkztiro/VTKeB3l/HIbA4J3SHpHW66GgHD7SGlKPcWQML4ZVVp43ht81bOvqiU0u
	u2O2hZ1rvX1NVShzkfUGIhZVIIbk=
X-Gm-Gg: ASbGnctTzkhkinryAL9rTeHjd1PChZ/+Lw8Yl0Ev4yqWoQ16kcthZeRIJJLkjS2WB6X
	UI4ZATkqFLcscl4nn/fs3RxeQLJe9bB35hi4UkA5mpBstvUDskBmxUBK/o0J7Jf37kFwAIB74uM
	kfZFa7c9GxoeHnGH5ymKtwDjx2wl7DUosZ4PKouv8doBE4HwkRafcwwPzGry4R
X-Google-Smtp-Source: AGHT+IFerCxCCwUUpDBIAiN7KAA7euu+0sIt9AIHc7jrhXc125Ajrapc5AB1zqBgXQleiZB5PWXL93vA3meHFQlaihQ=
X-Received: by 2002:a05:6902:1682:b0:e63:f2e6:9a4b with SMTP id
 3f1490d57ef6-e66a4db0158mr17773691276.16.1742850614492; Mon, 24 Mar 2025
 14:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313202550.2257219-15-leah.rumancik@gmail.com>
 <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
 <CACzhbgRpgGFvmizpS16L4bRqtAzGAhspkO1Gs2NP67RTpfn-vA@mail.gmail.com>
 <oowb64nazgqkj2ozqfodnqgihyviwkfrdassz7ou5nacpuppr3@msmmbqpp355i>
 <CACzhbgQ4k6Lk33CrdPsO12aiy1gEpvodvtLMWp6Ue7V2J4pu4Q@mail.gmail.com> <wv2if5xumnqjlw6dnedf5644swcdxkc6yrpf7lplrkyqxwdy4r@rt4ccsmvgby4>
In-Reply-To: <wv2if5xumnqjlw6dnedf5644swcdxkc6yrpf7lplrkyqxwdy4r@rt4ccsmvgby4>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Mon, 24 Mar 2025 14:10:03 -0700
X-Gm-Features: AQ5f1Jq7PETmJp_Xhit-cP_ru4m2aFCBfqXg2exRGW7xMe38WTTmErP4Zzt3J3M
Message-ID: <CACzhbgQ2dD7A4hYDES-QdcCQtkMsrdifsaTORTDebPHEooZSLg@mail.gmail.com>
Subject: Re: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
 intent items
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This sounds good to me.

Greg, can we drop the following patches?

'[PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover'
'[PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover'
'[PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in
->iop_recover'

Thanks,
leah

On Mon, Mar 24, 2025 at 1:53=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> On Sun, 23. Mar 17:29, Leah Rumancik wrote:
> > Okay so a summary from my understanding, correct me if I'm wrong:
> >
> > 03f7767c9f612 introduced the issue in both 6.1 and 6.6.
> >
> > On mainline, this is resolved by e5f1a5146ec3. This commit is painful
> > to apply to 6.1 but does apply to 6.6 along with the rest of the
> > patchset it was a part of (which is the set you just sent out for
> > 6.6).
>
> Yeah, that's all correct.
>
> >
> > With the stable branches we try to balance the risk of introducing new
> > bugs via huge fixes with the benefit of the fix itself. Especially if
> > the patches don't apply cleanly, it might not be worth the risk and
> > effort to do the porting. Hmm, since it seems like we might not even
> > end up taking 03f7767c9f6120 to stable, I'd propose we just drop
> > 03f7767c9f6120 for now. If the rest of the subsequent patches in the
> > original set apply cleanly, I don't think we need to drop them all. We
> > can then try to fix the UAF with a more targeted approach in a later
> > patch instead of via direct cherry-picks.
> >
> >  What do you think?
>
> 03f7767c9f6120 is '[PATCH 6.1 14/29] xfs: use xfs_defer_pending objects t=
o recover'
>
> Two subsequent patches depend on it logically so should also be dropped:
>
> '[PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover'
> '[PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in ->iop=
_recover'
>
>
> On the other side, '[PATCH 6.1 13/29] xfs: don't leak recovered attri int=
ent items'
> which is at the start of the original patchset [1] looks OK to be taken.
> It's rather aside from the subsequent rework patches and fixes a pinpoint
> bug.
>
> [1]: https://lore.kernel.org/linux-xfs/170191741007.1195961.1009253680913=
6830257.stg-ugh@frogsfrogsfrogs/
>
>
> So I've tried the current xfs backport series with three dropped commits:
>
> [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
> [PATCH 6.1 15/29] xfs: pass the xfs_defer_pending object to iop_recover
> [PATCH 6.1 16/29] xfs: transfer recovered intent item ownership in ->iop_=
recover
>
> (everything before and after that still applies cleanly and touches
> other things)
>
> and no regressions seen on my side.


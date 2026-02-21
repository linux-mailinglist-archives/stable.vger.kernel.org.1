Return-Path: <stable+bounces-217627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHNWIvdImWk+SgMAu9opvQ
	(envelope-from <stable+bounces-217627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:56:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07CF16C3BD
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF27A301750B
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28638336EE7;
	Sat, 21 Feb 2026 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htq1qKBk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC02EACF9
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771653362; cv=pass; b=bX7Yo4wHolAcEb0B9A8rg4G7PMsCEH/reshzV0/L1jyQBO3CZG0L84+HPRKzMMGhfCVdACr/BGyY7xhBRcHBQJFT6uVVFKMEtePYlzm+vbORdbbbIhKlOnJ3lhwSOA+JObMHuGTKH1XAGLWLBda+uP6P0u6QLDXJGFjWURyB11o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771653362; c=relaxed/simple;
	bh=Ccv9mwt6mLX9xX+lxZglunKn+JwfoIDQEFEaLtcrLyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMS5NU+wPppVfsW+kFYaqfOwKfR4JtDVEr4jMX0EosFMQHCj8cSh9rfPgqPcZsFOTlkFbATyBtXenRi5wCLPbSthuK8i5iVqcH+GxCBIxjITB4gc+d985Y9aw9k2OUBTB2V6uD18zenI+XwUACdFchchWxm+Ex2mAGPseUPJWmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Htq1qKBk; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8d7f22d405so416019166b.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 21:56:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771653360; cv=none;
        d=google.com; s=arc-20240605;
        b=fe+nwOY9NbMhlLn6zKO7BaBpgyRbpWF1wYnojnh6mske3QQKxOOmeftc7Qsse3h6ON
         gKwKRpBv71EZWDcFUhOdeJs7RR+9BUmIz/1AZJApzV42vIPctER07FhfDqyHkMMdSZQG
         8gXzGzMsFS/qILgfE7o6VAwWZBQVidgcncaIvu7vi9nZSAZ1NUDiQ4AziwUFJnIPPYL4
         WV/LQF8GZRuT7UF+Cu7QOr+m4FEDQON7y1vNKPcp7Xl2a9S60YqMb4TkVQzmTWY9tCg3
         JtfCEz9lmdjze43q4Wx3Ge2Oe8ZFYNW6QQBHRC8cMZzOaPZvFZtohq6nUDVgp5NY+yVc
         g7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ccv9mwt6mLX9xX+lxZglunKn+JwfoIDQEFEaLtcrLyQ=;
        fh=iLryWfP5D+1yWWR82cy56fWpQuLvIOi2LdE+FlaUCEY=;
        b=bNmoxSiRMa3Fkrgob/T8JWj1Hy1rq7HDbHuHVdzIYgZKD0n68qkRtNfi/Cjxb27CtA
         hGh44YYtjDqrLf99RVklqiqUzTlkX0v7pxEynOkt2FMftDH6/+BF/fD4BUmdBxliAKpd
         yj4SWKmyWbLSM3N7vVzb4woAA6VErB9K4eJ85zRhyAQBqSoPoJ6rSTSTrPw3u834S3WW
         YdFmM56lP1vCIEwbvMAwqQvYem/aaXCK+mN+ub+/PubTs8J/06M/ODw/PZkzs0ble2kR
         FsVtPtWdTdwIbMdFyxatfoC9eHNvHS05tUmnDV/Aj9BxntnOK/8YOJNhTbIzUcNblv3W
         HPRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771653360; x=1772258160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccv9mwt6mLX9xX+lxZglunKn+JwfoIDQEFEaLtcrLyQ=;
        b=Htq1qKBkFXni8MsDFFJcYkStEYp5bVqUoHTxVe88lM31dhWcbK7qL/syGcQ+3iElD4
         bntAayUvtwsF1rjEpi6UMYiF49Bz4Ib/H2DUzTlNbaFy49y5C4O9VDICPwzXM0Kk2LRw
         y3LFFdgV7mNAuBdDHpIYG1PqGMiDDS3tHvhUwo6Zhch8CH7OYwnHb9uegGklEl33TJ6h
         NWHxPJV8ytXS2NDsTddl15p+e16cOpfjv77V5CUn7Ydiw554CHYNcaKU/TtnxCEU0JnW
         /N9kgF3pfIb4xNlp7pMcHE0hVA5nCqIM3cgTKtANSc8zpxJDvw23ategu2cMnngvDDOx
         Vung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771653360; x=1772258160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ccv9mwt6mLX9xX+lxZglunKn+JwfoIDQEFEaLtcrLyQ=;
        b=oe2DG/CRB4u5uTilTnZfM3XUI0ZMmIDYGZj2BM4w8K20tSJ1uH1xwlghwU/I68W9Iw
         F+RUVuiJRdwhBQYSlwCagapkjqAsdIAZJOae3iA4et80J00D1BvYrZ8iCNgYcvko09ta
         +qTf6ApdJzth7mFmVAOJSzjO/sV+D7edSzjGMFucueF4YjhwfOSU27pokgKIqhxwz+tE
         8cEEKrDV12SMXYF3Jd/p4Z8YSJbjyMtc80KAvKVi20Aj2YoHShYCZ1gHGBlKgDUH+IE3
         qZj6JrXQdayutNFjNGnnNsvarHvXzdRLT2J8eEWJwfC0kfWia828YRQYwAUO/AOTncTO
         MPvQ==
X-Gm-Message-State: AOJu0YyOs9BMT+PClH53HFWsATyl3zd54gXbTWDQDDg1o+py62iBDTtp
	M7dcKU983xLWlo+olysbHrqtcEVrK70k/Vy1aJmOaY5kK227d5uCSlLMj+T+wxS4gmrRliD6tby
	lzeZsQ9jUwQogCfN5XTJuStkmqYjz8qg=
X-Gm-Gg: AZuq6aIn/lV1R6uJKWcxzHSC70f/3argA7ZYD0RvU/fCGcptuoxgSTPpjDczOyNDO/s
	dLtl2D9oqPNESZdU4nA5Bc/05ysYQJGtAJApS3MUOVE3N3Cd6MHAfasl/gKml6SdcKeqKwRcnRx
	Lbx3rmvuG5AgJ7M6NsFURO8LzZTlGChaCF+QJ3euR9ah+VE1PncYfaGHczx8NnbuTA7Gtnq0wrB
	ZC4EoVnHgudv/DQqOhVKX4K/jctK0qF0dmMt4yEhQUcIVky8AJjvcN13XISplZU3YEPHxQWEUQ8
	BekdVeOcc2wR2/1MHs3VXSp55KcbPwEzs4EjHK+ZFfuq+rMSe+US/CEz/umMRCl24pHx4AXzPCf
	H6wneyw==
X-Received: by 2002:a17:906:fd85:b0:b86:f558:ecc0 with SMTP id
 a640c23a62f3a-b9081b4d0ecmr105154766b.29.1771653359889; Fri, 20 Feb 2026
 21:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221034402.69537-1-rosenp@gmail.com> <2026022126-calculate-matador-e7bd@gregkh>
In-Reply-To: <2026022126-calculate-matador-e7bd@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Feb 2026 21:55:48 -0800
X-Gm-Features: AaiRm52sd4wHVH4fvoty83VydXFtxyvYUG7iNjF0rTjocALxFyz7eMIIRUKgihM
Message-ID: <CAKxU2N_+88yrYYv6B+VMSkSgpVBBBFiHo1e_yXV6FWX-bLw9nQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] 6.12 and below: amdgpu: fix panic with SI and DC
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217627-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F07CF16C3BD
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 9:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 20, 2026 at 07:44:00PM -0800, Rosen Penev wrote:
> > The first commit is needed for the second one to be reverted cleanly.
> >
> > The second breaks DC support on my AMD 7750. Kernel panics and I get a
> > black screen on boot. With these two reverted, 6.12 is usable again.
> >
> > Tried to git cherry-pick the fixes but that proved to be difficult to
> > do cleanly.
> >
> > I see 6.6 also has these two commits.
> >
> > Not sure what the proper procedure is to request reverts on stable
> > kernels.
>
> Close, see my comments on the first patch.
OK. I'll wait a bit before resubmitting.
>
> thanks,
>
> greg k-h


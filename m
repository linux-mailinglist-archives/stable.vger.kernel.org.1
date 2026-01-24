Return-Path: <stable+bounces-211472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD41H1tNdWmRDgEAu9opvQ
	(envelope-from <stable+bounces-211472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 23:53:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D747F2BB
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 23:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28B563003600
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9B01531C8;
	Sat, 24 Jan 2026 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThofDDc/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25042048
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769295190; cv=pass; b=ZG5LgMn2dutle9DdKhEaWEiA2/q9mqS/TWg1pQe+/tjnp29Re9wSRAK4KBAYDAMK+qOOTUvEZzBZyIeS6X2Q14QbehacIGDaEg7vP4tU0dt7STkJRpVTiKKQsPGrOWV8jUJXU6bFUnHaA8MS4sud0EZv8wQNK9vdI5w9qDqjG8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769295190; c=relaxed/simple;
	bh=WtZeA9Un4H6oAqMkypPzlOlC8tL1PBEaHDWHQD1Au2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAbaGPB/QDjpf+Jl6DSvnEY8IvqeM54bhJ7l/ZsHlHFjvTwcRoSZZLki0Wzk+4j6SekP+EP5dEl3icBtcS0090XU/b6r1aYOBJTlOduH01sCOz7OGzZbXTfwDipjC7yTT6P099d/G4daNZyZpXOAExfKqRcLJE2LnZz1iOdObZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThofDDc/; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b71a4fdb86so94587eec.0
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 14:53:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769295187; cv=none;
        d=google.com; s=arc-20240605;
        b=KvxtAtwulgN6YlGFTAcJFM8rnbhNN+Z+B4ZbG0juKVn22ZC4ZgP0/c5BTBfhbqS9Bl
         U+7l1YJHR1YR73zwwpxxtATRZ/UfUGdFErao8GOjBvGCtErIs3Mt0wmmStwgx7ORAbnK
         6n2U04dgc0Xqg6gx9kAgaUZG6Od+3GU/tVHUYC1vaZTzpwPSOqmeIMPykjn9qozVD4EN
         /V5mLo4tlSxrsLWtufxcCvKQeqTWbcqeEk7/Q1OkVfMcW2A3ibvlVNGyc5oYLCTAQXEG
         S7MZGbRHXsCQ76bC4KSJJXX/2AZIY1rApE6UgPElOu40KjoqZRgBz+sxxFbGJPObEvZ5
         EZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WtZeA9Un4H6oAqMkypPzlOlC8tL1PBEaHDWHQD1Au2o=;
        fh=5/2LCHS7kjjHcQhMQnbJVOVUQ46rmdS2xodCNu3LwI4=;
        b=HVEXvTbKSe2U2R5YbgPuBiFDPc9fNY/Wkz4f/DJw+YVpUdWCAayE7himpylPDM81+f
         QRXxmG7BBYl5iRTNzy+eGpIp0jetIenoBmBs5BxDbmAhrvCKjX0kIHjKZWtdYv+4rgm8
         yqNTLswqxhAv0NiWpFrkjNdCCo+Gph21sX+FPYUMWhToPPgjfllCISgJsC3U54y6EdfC
         CR7ZPMmMyit5IDtd0wNFItqPjIibnfhhC6DeEc18Ub5lT9LWeC4cCUIwQYn0z1VWrb4B
         iFGbnowe0Lrb/2ArcbN4qRn8igjSqb5uMoOED8jk4MUCEYBAeArFLE3QVtVse0+hvELm
         QWrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769295187; x=1769899987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtZeA9Un4H6oAqMkypPzlOlC8tL1PBEaHDWHQD1Au2o=;
        b=ThofDDc/hNSLRyADG4VDlsg/FnL8sLVb96nTpYeY1lDrteeGRU+DnvKvPPnqC1NFW/
         vI5qo6429ApKkD0VZir+hIIwby+LKYTnyjOlDg2OqKMYJq+CBt1kRzYyQogbboau7V0s
         SpTgpDyD7wyQirvZ+pYdRcYRSYllVjxg4BPCXlYYCkPpdPxK08GwVW777tJCiOmUZjno
         /3bwkhswTELVgPgHMuwHEGYNfbIVbXufuWtdD0YcroQJ2/jJG+79UrWnmVpyPovWKU8Y
         7aTsA2y1oQgnpg6sA3EgVeDOlFJiZmngaoyrom9Q8+2vhAwWCzyCl4axX6bwzDKWmSmi
         bNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769295187; x=1769899987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WtZeA9Un4H6oAqMkypPzlOlC8tL1PBEaHDWHQD1Au2o=;
        b=rPq6BpOOGudOH8fp+IFBULXh/0N+dkXnrYRsKJI1dUqTTOfkMsT/KPHE2XUdEWKH8E
         XGyhPCGSS7fKtGdP+x3M0T1QeBslglXUn5ULkEFarhg6Z+pAkuaZgUzsjZ0cFi/HvBD4
         jDrpf4OZVMaBnIrXM7BsC5OZEIxDOthJpTEXtsVu3yeiVyA/BNHzdZULO8Vk9wk4GLOa
         +ZfHOdvvLa0zUCAaDjGKQhdf18R2KKCmkbSvORrvHMaXLzoW2aG6mAlbs3rTQsRE7a/i
         gqRXfhb9iqRMGkei2zd3XkOx0DZ+ydG+po39/BaT83QHC/pkAikoz4+RidQDo4EY/j0C
         1qrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtxdlUIuRlhi868FsCtsuGR0DX830rxiqELR3TcNjof/TWhlNdOZab/SeqLaYbBv7ydSgWW0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIqWk2C3m4nuKuMAtNITq3bnzUHaNeXUEu1jw7V2Rv62EvGLq4
	psUEr1ecmGejBp0+gh598h8GcozbPqk1tGc0tOIObLSzkNga6QrtW15aehzF9DVeXP+EWQWJcUD
	UIuc/QMRky2bH506NfBOUjBPeOm9Wb2I=
X-Gm-Gg: AZuq6aI+ZjRuFY292s6mxgUEBDxSqScJs5nFPZv5W5jiqTRJOxffeZOx9aDGnP312LB
	0uXree8wf+eTXCPAOtoJ4qnWSDPeMYAsk8ss/T89ccwkdpbRWjCAAlM+KasqGD6q4MQTpfTSUlr
	yoSYAi4dO2b1bRfHu8gf8am3xlTK3fJxPJwj3Wr4lQF/Mury3k3PBUn8S/ZkW1IOoYPn3Lmcqhn
	W+1PWjGRWjTJhCWH1DmZfHAGztQnYp3SxSFq7sBwtgwmE3Wd0mvauZff4lW1DTn2yq1Xesl+w41
	xhPO6V+CBscYC4CItHOPqrPaDaGItSUlBRxBUMEbHdogjyMjS2duX6jPrQK318N1Fmg4O3zr/5O
	Orn8ecV4Xa2FY
X-Received: by 2002:a05:7301:3d1a:b0:2b6:f142:44ce with SMTP id
 5a478bee46e88-2b76433995amr12810eec.2.1769295186994; Sat, 24 Jan 2026
 14:53:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124160948.67508-1-ojeda@kernel.org> <CAH5fLggeH68Z+C2XFf4ONzRBu9HYcvJptz3UM1zUKd90v1g1cg@mail.gmail.com>
In-Reply-To: <CAH5fLggeH68Z+C2XFf4ONzRBu9HYcvJptz3UM1zUKd90v1g1cg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 24 Jan 2026 23:52:54 +0100
X-Gm-Features: AZwV_QhbOY663oaEwGftoI_YIydlVPcnVC_kpewQ58UFuYVtmlpOaxNK2BSzUNM
Message-ID: <CANiq72m3eJSTFzHYe5=H1AWtLQ4SgLOE52tPBy63hsZHPAdM_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: depend on `COMMON_CLK` to fix build error
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	dri-devel@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211472-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,collabora.com,lists.freedesktop.org,gmail.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14D747F2BB
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 11:36=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Thanks Miguel. Since the drm fixes PR for this week was already sent I
> think we can just include this in drm-rust-next.
>
> Though, if you plan a fixes PR for this cycle, you're also welcome to
> include this patch with my ack.
> Acked-by: Alice Ryhl <aliceryhl@google.com>

You're welcome!

Yeah, I am sending the fixes PR in a few days, so I can pick it up if
it is easier for you. Either way, it is not very urgent.

Cheers,
Miguel


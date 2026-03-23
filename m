Return-Path: <stable+bounces-227945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE81IooVwWn5QQQAu9opvQ
	(envelope-from <stable+bounces-227945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:27:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F7F2F0035
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A188730197DA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79FB38AC9F;
	Mon, 23 Mar 2026 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGxRsxJv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB2385517
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261144; cv=pass; b=OOfcaxGuf322/n0ydARY2M6V/xjqNSqnoua4212zQdcL46wYajFVd/vQkIzxj5h2Q+epH333KWs+1aRKA87kxU+ds4iXHiZDxrmIYQu4DWfPkiSV0QAezWkXG1f8XnmPTKrAOlSs96kO0MxAcJeLjBoDvc1FtkRwUXDHJnmUCug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261144; c=relaxed/simple;
	bh=Nz9/2a5/50fvCc1KLouJs7sTDCfItMzZ7aatbbpHwtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGl9/cjzcAhO2PzI1b0Aj2jKlAz439BErNJxBTQaGDHiqwlwIvv91iR0MsbPf3ZTluaOlANMQ7Nfkpxt0/vRozS5cL2JsavJP1sg4Ou4hpqZqLMeVcf7x+UqCAB34MtHe+/JvYaSSyfVbJQqj48huJ1cYxbVynSS1cJQUQwM6gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGxRsxJv; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12a77005d69so100669c88.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774261142; cv=none;
        d=google.com; s=arc-20240605;
        b=gE+LIOCRlUS23N/Tpqya1iCAxF0izDAXXdmLwNDvXMFjg5lB5qwZNV689Y8oqt9eD/
         Xow9F8Vm8+KWL9MplUpzyeGIA4Ayf7jebtWV1y38TOPJKzcYPKgfLMMK+e/Ba2WmFzkq
         5MfMuHnr06qwf68WgRIn6QTcTcKTwTTmNEVOfieAP0Ew9IMd3q7TKGRnKUobTYzynFKw
         2BRzWvjd28/uZLiXpQvccjpr1zMpp8sncFC147RUBBDkMobr9IDjv4PUkUkok5PjyZqb
         Q2jjUV+3b6fUPy6Mvk48ezZ2+VDmP0+PvTxhnkWn0Yiah9WxFOmQlGo2k/iQcocxovvp
         KgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nz9/2a5/50fvCc1KLouJs7sTDCfItMzZ7aatbbpHwtA=;
        fh=7jmKIHPmJfK0pQcn+0tG+pTj5WF2B8IRsnjGAIPvUnk=;
        b=PUlhzpSChb8a42Jg5K7M2ZFyOuEKaBjSyx/HzldP5o4kp5wcoLzp+B9RIpl+o7aTML
         ltLJ5DR5tvXiLzZ/lrO6gPPrNUJvjyGK4s12gsZ/rZQ+Bb1mT58LrP5LGLDt/GsBG/+p
         7OKjtOQjvDojtoLh1wd6dLD4yY1ti4MdeddV4B4/5LH2p9t0xlxsnRYBJ/v4PqB6CEKD
         mMWtz36VJGqRQ15EhXlNyZzLPqgmDMyBMdH5K7tN/8yotJBlQS9wDmcwPkNC3MjXkoyy
         A0MW7P8A+a6LlDmn/s+OUi2ETWpKbqRExVVe1n1JI39jdfnv5xjqjfbI2OKXXGmAkVO2
         /EuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261142; x=1774865942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz9/2a5/50fvCc1KLouJs7sTDCfItMzZ7aatbbpHwtA=;
        b=FGxRsxJvgDMsnOtwwBhE+J+CITGeCo9yVt4rUQO6or9XN00YS8/9ENG8OC/SWj2ui8
         ede7s3C41IbD9MTZkrs/2/AmoXmZL4LMccqCN38D4SRxVUZd3bk62n9pNzGAlzyh1DW/
         hxeAtFSBYsf+TMtXwKKBh6VGSnl4vpBMK+lZ2RGWlAwQ/Z5+GAozMZ7f4jr6/hrkzT98
         HR8FWFDNnl3Fs8B1sug34SuuJKx7MUMVazTN2IE+jLipvs2ljJ2mu6UT+CCwqYw6iBLW
         wvC7lOwBclhBIl86+8xrA8mTmWWaijZ9YcbpA10xe82kHTl/zcSv8eUAmy1QWDKPnMLx
         Yc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261142; x=1774865942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nz9/2a5/50fvCc1KLouJs7sTDCfItMzZ7aatbbpHwtA=;
        b=SSKC3wBctWjd53yNqtuGWc1qutQjCnSvYCcE0fs/FppPd+N1m0ft2Njxabr4VyaD80
         ZzurV4fmg/GMZYUsO3i1rcprxe1t2p6uKwft0MVZXJ6rwy4qrgrz/FK60/FejM3Uk35c
         MuSObsvJ5ldpmwPRtHhiLgqePkdmqphqOu+rOZk1ZCs8LB623WjlkcvuJN8fUKwZBbKu
         xiHqGtscHsgUdH6BWaqrm+PX46LHVJui6eF+KdG7t/0f2KHTLfm2WTm2+1ko5hCu3OJ+
         Bdi1zPWu/qGwNwj8vffwgHuN0t+UZjNzK1NcrQpDjKJNy2aa5jvXxYlmzXiN3qU/kqSI
         X0NA==
X-Gm-Message-State: AOJu0YwKRTvRDkzyaFUJAd1aUnzanmvqPx3g08Ll1kk8yNIRjpfBbTmy
	3hrIk7tUIo8XooTIsu387y8H7XU7HtMLXj7LuMNTZ/6nralVdwU086W6xr9i1xMKBXrP/g3PkXW
	dscTygT95lqk7eAvLbc/FDBX7xlkHbsE=
X-Gm-Gg: ATEYQzw6Dd9GzuBO13NNZwY6PwIgGc2mhqR2fYWmFpL+cL9dRGbnCCGPc5BeExuVp01
	FWCat30diq7VkD3VyX81NDBfDccXB2uo7n/R1Qix2SlQAtt/S6+V08SQbYg4TWPRuyESbSh25EE
	v6wzU+9nSypyqeiJ+N2Nc6ky7DcHJCETAr0uS0t9h8lVjpPDVGCkDHwD1ISkYolRIBv35J868ag
	Br6GqeUijokzUQT1Z9aG7c0GIc9Skgsb9YdiIMGRxW8Mr24+Xm2UDYwb/auolmz0eHeyw9750va
	KI5pkNGTZ1sCYh9fiIEAGt0WQinmSfwN5qJRDBs0qxLtOV74pEiGe7fBUtw9U6vIq95YjjeovUl
	y0FYCKDWMeAZjtAOzvUn9EOk=
X-Received: by 2002:a05:693c:2b01:b0:2be:6e6:e47a with SMTP id
 5a478bee46e88-2c1093faeb5mr2505500eec.0.1774261142465; Mon, 23 Mar 2026
 03:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221161726.4075998-1-sashal@kernel.org> <CAH5fLggmuHNXpfHo2mPS0TYu8mwr8G6EKH0YPuCLX77u_dxF5Q@mail.gmail.com>
In-Reply-To: <CAH5fLggmuHNXpfHo2mPS0TYu8mwr8G6EKH0YPuCLX77u_dxF5Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 11:18:50 +0100
X-Gm-Features: AQROBzC2XDPjLTgsTPYyi1ZAGqFwZbgHl5L7dNdV_gSgKrmqGXLNFxmXQGX8HcY
Message-ID: <CANiq72k6=OSk-vLbmKjqcAUza700v-OtToEXiVbqWPkNpPbVVw@mail.gmail.com>
Subject: Re: Patch "rust: task: restrict Task::group_leader() to current" has
 been added to the 6.18-stable tree
To: Alice Ryhl <aliceryhl@google.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227945-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,umich.edu];
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
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 65F7F2F0035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:11=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I noticed that this was backported to 6.18, but not to 6.12. Is that
> because the first user of this function was merged in 6.18, or is
> there some other reason?

If it was meant to be backported, then the commit should have Cc:
stable@vger.kernel.org.

Perhaps it was picked for 6.18 (and 6.19) because it applied cleanly.

Cheers,
Miguel


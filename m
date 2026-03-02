Return-Path: <stable+bounces-222655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCu7LQrJpWnEFgAAu9opvQ
	(envelope-from <stable+bounces-222655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:29:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 356CE1DDD01
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1D6830427CC
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835C42883D;
	Mon,  2 Mar 2026 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yLaJzPgb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0E3815DF
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472536; cv=pass; b=tMysyJ4LC7KldNagMPQ9zyr3ZPuMk6JFu2hdFSPFrr5glhW03G7TVF/vX/PUuw0KVHnTvl2nmEeBOzi/A+E/DD2v9Ib1kxUFLzuBn8iBzHlnK8ufey8sQII6SphyzOdH9HjZUJlClHqJAgpwRgDiRXdpzN0ucUNn3ErhsaUPZRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472536; c=relaxed/simple;
	bh=G3n0b90DzB04tYV40Bc9lDxOunyy6wXi77KoBPjFJew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lm9wKksvy/U9D9/wSy0bFufd8NHIvQ/TzvpgEIxPl0fAuviE4FSn7gy1xJRBmvAaApue71fr2brmdWSq0qVX8AOSYQSxc4pxLQsX1JF3yVItx8+tO/9HtEQiJGyhkhwih/YhXbyVyBRFAw2CQIJpCpt/+jUU+x4GJt2ZWycxaoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yLaJzPgb; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65f3a35ff13so42a12.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772472534; cv=none;
        d=google.com; s=arc-20240605;
        b=BfrpDDGg0Uw2O95T2s4TTivllD+bJm/22bNJbblPLk/sFO4iCUPalGy2cD/HgcDv4G
         a+p7mg3iiLlDwsP27y7Ltv/b50/ixXUbhZuD2XQvuItJWf0zMAiDIPSKcEA+9Nk30TYk
         EtFt5W1FqlWGqDnapsUR6oo/tpwH1JPSArQQqERzGBs+vSXrfEUqWXa2YZD73uzeNVlo
         cWlMF8zHtw/ooGYAKtcEctSCCm9Sk19snK8M1ZfZ0cwMs5+XCos0/ZIvhBUsgqEcTNVs
         VACy7s+6K7RgE9s0X6p8BU1GQn2Ft3Cskys3C68mm/MRs3hcQikKK0NXJmk64ulvxzRG
         hd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G3n0b90DzB04tYV40Bc9lDxOunyy6wXi77KoBPjFJew=;
        fh=gxKVopnf0rSHYmPgrGf1Xmc6ySBddFKVQjVyN9l52kY=;
        b=JvrO3UAr3anGUGBsUZCsehaurdujpekVDxxVAdyas9eiZhAr/suKFlbz+D8EwgVQzL
         6k/QATWHRsemWzLhiu0HY/Tb8KerdknyR5d+6MiOaiCBkIZNDel2Ju7Yo0a1Yj4pr2RR
         +7y8EVCmBN9v8IbdCYN4r5JzHMztbo7JztRawUympk7Gyd/yi9RUGQ5Rq1WhpTz2/eVG
         gBIm5O1MW8/miIct5zPUKO8zqyf1WjLea0K782vL2iClN6WTcPRgmp9Ut6I4mlY97whR
         gq1WT+5vFxxZTDD6cBFIyHW3mAaTHREQWQCbMjXbGL4Z8B/S60ubCGtbtzMbbJSf1za8
         pBwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772472534; x=1773077334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3n0b90DzB04tYV40Bc9lDxOunyy6wXi77KoBPjFJew=;
        b=yLaJzPgbpwstyVIdBrsY+0JevJta8OWA7YfDVmqIm5h+nYlVCsl3KUP5YV0qKCXJ9Z
         iyPHFK2Ifsn7iiPBlq5wieHJ0cyhIdj+bMqw5KmhVjLP7yjX6kqow8ed2CZiqSIohZKq
         5dprM1j9t5I73CxS2ROQWepQFyHzQwA0y8BkcvF8cFB1zHkkTbFzFLnwNEsg04GHWxVC
         ERZzB82RIWs1N087uy31YWcO1DocAGwZzaxstQbZwLgsfTYMMq9Kt/t8UccpkxisWSwy
         pMQbAdfbqxNk5TtJ1e7qFxAPYj+p+L53DPuWpCRSzVoknVhmh8PV/zN4FDGnKWsrKdhd
         EQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472534; x=1773077334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G3n0b90DzB04tYV40Bc9lDxOunyy6wXi77KoBPjFJew=;
        b=PNt7SEjf0GfXK7aZud01/aziQdhgrjfmNLV1//JbjGFVtMeZyRc2sEDkSpMZH5YUuH
         /JSoxUs3j9JJQU8vrWvu14vS5170tJNG6l3FFV45R7Rgl9LEPhe3YHXhWGbYqRE5C2Bv
         secHo6fXE6G+lTHWFiynRidUR+flOQ+L3ufBAaJheVF84nqtD40iO3iTAzBEYXag0ld9
         1WUGJ8cnglYeBngXoLSkttXfoS1320gfAMrrHGBeWavDqP8911xfqNNkQ5LX0jxx6M6t
         v4HdWuL7/y4KJ+bFUJ+n8OqMp2UKRTn0eChAVtoR4byCZ8exAtY+Tkc/IuWwiBkmY42p
         aWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU710Zu25xOv2UlMhwRwvjfe0rWglE7Her/mrEmhQ4xhFYgiq38Kgdabh5ZFbjy+mP/9ESTg6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy14ojboEvKRiwk/byFvhAtP1y2ym+hSZyFA3msC3GonOHpKukq
	lenP+FiZHdvZMIyKTF8K93/P/619mlGNlApzkk8bXb7AMcr+JaHlD322iNiV9qPVK9+Sm+fJB5p
	yAhsG5BGRiQVr3iP7h2BpyvepeiJobMfoshG1HYSK
X-Gm-Gg: ATEYQzzYugn0f9qDAVfA7HwUB1FG4500aQrkzcmgjcFhvJjJ1Ar5dgVzPwFP+2Bt1nj
	Z8upexl7a7QvrcLayGW9YP5fVD95Rp13j+RKMRRrQ61szWzjmDRoNNuBzLaLRTvknDYtig5WRVP
	IwvvK/5xCp7vZH/jMM8pHbe2aaNeMsDi8GaR9i+xkFDM8ctTVYp1lkIezPFfjV6sfOOocQyjcH8
	1D+XdJ+eKQz1RyuqEa2DxjU6YwQDffqHT0hZ+/xpwr5Np6cLfMWHHXXInvU9ot+AvE47N8/PWOO
	B9sQ+l2W0gNjJeetMrX7VLe2dhg/KhPJd2qY
X-Received: by 2002:a05:6402:f12:b0:65f:ddaf:d1c5 with SMTP id
 4fb4d7f45d1cf-66008e0a08emr235858a12.12.1772472533625; Mon, 02 Mar 2026
 09:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
 <20260218-binder-vma-check-v2-1-60f9d695a990@google.com> <aaXGZlfAmk-DCuBW@google.com>
In-Reply-To: <aaXGZlfAmk-DCuBW@google.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 2 Mar 2026 18:28:17 +0100
X-Gm-Features: AaiRm50SZW8QPqSRhdWDXBgdsHpRSfdrfGzv3dpf9ThjwdH9bYPFTN50ijeQDLs
Message-ID: <CAG48ez2M4fj15gqyKrP7ADRUhNQZkpy9m+NSz2N=vo=PSefm0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust_binder: check ownership before using vma
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 356CE1DDD01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 6:18=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
> On Wed, Feb 18, 2026 at 11:53:26AM +0000, Alice Ryhl wrote:
> > When installing missing pages (or zapping them), Rust Binder will look
> > up the vma in the mm by address, and then call vm_insert_page (or
> > zap_page_range_single). However, if the vma is closed and replaced with
> > a different vma at the same address, this can lead to Rust Binder
> > installing pages into the wrong vma.
> >
> > By installing the page into a writable vma, it becomes possible to writ=
e
> > to your own binder pages, which are normally read-only. Although you're
> > not supposed to be able to write to those pages, the intent behind the
> > design of Rust Binder is that even if you get that ability, it should n=
ot
> > lead to anything bad. Unfortunately, due to another bug, that is not th=
e
> > case.
>
> This all makes sense to me. What I'm missing though is why not reject
> VM_WRITE mappings all together? Is there a downside or something that
> prevents us from setting this check?

You could, and it would probably do the job (assuming that you check
for VM_MAYWRITE instead of VM_WRITE), but I think it'd be more of a
surface-level mitigation than a robust safety check - in my opinion, a
robust check should, at a minimum, confirm that the VMA being accessed
belongs to the right driver, because other drivers might do random
things you don't expect in their own VMAs. (For example, it wouldn't
protect against interaction with a driver like C binder which reads
PTEs back out of the VMA in binder_page_lookup(), makes assumptions
about what kinds of pages that yields, and writes into those pages.) A
driver should not be touching VMAs it doesn't own.


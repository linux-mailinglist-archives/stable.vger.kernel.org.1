Return-Path: <stable+bounces-216900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jSv2AaLJlGluHwIAu9opvQ
	(envelope-from <stable+bounces-216900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:03:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64B14FCCA
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF9903015139
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99B377578;
	Tue, 17 Feb 2026 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRxb4j0j"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE12C21C7
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771358620; cv=pass; b=eQJmaoymUaKx8/0RjhgUC26ipFRn1ii2Hb2dBOwyxqvUsssKUJGU2Mtlr56aJbYQrjmZ2/I5sMxKxEnCs5U+QUd3ux1mEcwsEuU85EtVjKbpCLM7VdhOIu1wCJnwbNtye11p6xqPB+eus+Q4hC3sX1b6hF2Kx+4h1JPgAUniImw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771358620; c=relaxed/simple;
	bh=8IGzT1pKK0tMKZWS/9RzMNxACO8Kd0m/tndhws/hoUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=go0LdM4cEPQBqyTG6avD28RuirhCo7jc9gdb7mMDfgHQNMasRc1DHI7+egns2BHW1f04KaKIAMiWtU0SXBMKFSoZM9m9FjaYiw2Ljh8lwsYAOhQBYHiHS0Os8rMwVszXqLcJkDoqIPOlVfjOsy35bnYQx5mkSOEwP/ZeLaU4j5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRxb4j0j; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483770e0b25so41012555e9.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771358618; cv=none;
        d=google.com; s=arc-20240605;
        b=hlTBHjOwg8y6bJm8MJjxDAnihJXEtylKY0wQGbdUTCCOTD5XsR3VQ1m2/LVctFnqih
         KODe2XrJiNbVMj0PxIW9Q8ciPzhENrtE3gDbi98Kw6UUkdDeufOGfDr2g/eYDZmlaPD8
         jtAPcMuvdUBoU4JpCt2HzbiTVEmLdeXljUcxZe1G9FUqEQFYUFukXyTsJ3GOf5NiEef1
         meHvVi+fglJGjk1J3GtpZs2H8taLGqZi2CHOqMyD/nPdIECtV+3rM1r4ukOOeRQgpxJH
         rIRvzxldE58DMPx7cfhYAxaHCHNVdG1kePsYTWsmDADg+vOe2Xv+hgys6OfekWI/5ghL
         hbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8IGzT1pKK0tMKZWS/9RzMNxACO8Kd0m/tndhws/hoUQ=;
        fh=yRIpXm4ayXJxCaD5K3lJuqtePk2J1QFAHCJmW9A/a/0=;
        b=VOK2BsFZcSY3LQGjppI21IX3Z3guA1yQAOyip6t5+jhWUDu4FA1XFwQwW0MQ9gGuev
         GLpkST2Ji2GKxjJDVwqAsZCJJE4nRAnx4wu0RjT4WQxLz7EI4yZVLyFViS2BShBoJpaU
         PkPjFJzIu1TQ3kxukhqTA4amBBquyqnZeqVSfaYYyiN3dRq1srFNrJvkCOT0RYT96n3D
         NOmULRVutFMImdWB3qhCsjgS/0g2qLN2qj1bPJIMM+M5j4GmCOMdakqlkk021z3y0mK7
         z1MuL9Qc0shLUAON7m+3KbNa0prfXD15BBvsr2WQJZKcu+Jb/pwcvljhfa4q8NJ6PzSm
         hSiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771358618; x=1771963418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IGzT1pKK0tMKZWS/9RzMNxACO8Kd0m/tndhws/hoUQ=;
        b=SRxb4j0j9WoZPeeUqH8rtRqzQurkubEpeCASblUZFLiqfqNCCzkMtdJQpklyaWF+ys
         49V/uxHw8eO6RCQJOQcAB/AZ3JSk9d1tSs44Qt69PXK8+6tsvgHqokfbDYz22SrCMFWv
         X4bA1HmHZ07xEY+xIOV+icifmwi/6Oe1a0FLy58WRQ99YVP4pU815QB87wPd09B4eaXJ
         qhB1MA5JRFEUhJXvFcf5et2tcL9J5njeU8SsXX43VG/VZ0PGBKv/SkZzIHXhsEO6fNC5
         P5MyydFDGIYnPFnGdCOXZAOm6x5cKw7ssHdfBlA17RnuIDdPp6BHomCn02HP4Oof8uYb
         PAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771358618; x=1771963418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IGzT1pKK0tMKZWS/9RzMNxACO8Kd0m/tndhws/hoUQ=;
        b=mLrvwsACpJrj/xyMsMIzq7Yc4sPaTt6DhomF3T4yS+ZjDD+8N/4NDih5/2xwuras8X
         VsCPJ3oekgUWVJByv60FtNrlt5JvG45iBA3BgFP+zkRyfmVXu7qmnhPZylZlY0LzgIb+
         gdLqWOu4PtTSyzgdNwxmvY54Z/hnvpi4bhgeguvMbFf0BqBytm0PDg5wpqagpx3+6GK7
         NjE9wR4U3U6n/Cu4bp9miey/KbLAfn5SixC/FcKEffWwy2xdOC8vJ5ePC5Pj690ZwVB7
         9nNO6qv4pGQ1vgwwijDQqG4unEICvXvOXGBCSIGEsG6YouUAScfxXJiBj48JHrImSd9a
         aEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsGi6WOD6Bl+JNRFLGzNpQrtJ7QxQronMR8+pqg0ZnO60wlMs7JMEsxtj84O2Ns7fGYh1U3Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDlNGk+8CsDB9tKWNY6VpQAHMMAttu97Yo8SusZiN8GauUEtq
	L4sywQkhLCKTo03Ra+CbMLPep4QYhVTA2X70kJskq4Uy1JMhbb/Br+koSothWPYO5RfQ+NKee+B
	VKfiUVJfynKgMV7+vQOgBBRCBMwdyp15+T6YR2uZM
X-Gm-Gg: AZuq6aKY05RD+jOlA35UmJ7g2GgXf8bR+ux+eLrvWjoJZYv9smQmUevNXsGXTMUXsBa
	eXQQqpD+7alU6FBjA4Ak5ASYdlsVsI58d2A8iH9RvE81vzJt0yzp1zCfR7c3dZ/MQoDhV3jul2R
	UkYezz8tqSebMJKHPwA50F25pBMdsncnzC7Pj47rmS/AFc6ltADBHquW6yoPLj+ZpkkhPFWQlxs
	FK/mcKolFpyfyOTjrZd4VOqi4wU0w1TjDU7gKo+l2Cl/kkt9UqUbLlLKzhq7jSv24qFbfEAsQi7
	DVz0i4w5Z4JXieGS2foDgg6ldMmbpod+ifrsFQ==
X-Received: by 2002:a05:600c:4fcf:b0:483:6f82:9723 with SMTP id
 5b1f17b1804b1-48371043085mr263576225e9.4.1771358617090; Tue, 17 Feb 2026
 12:03:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
 <20260217-binder-vma-check-v1-2-1a2b37f7b762@google.com> <CAG48ez2O=_Hd7EjjLSAh36xtOMyX5MZ47xodWkU3FyEar63TnQ@mail.gmail.com>
In-Reply-To: <CAG48ez2O=_Hd7EjjLSAh36xtOMyX5MZ47xodWkU3FyEar63TnQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 17 Feb 2026 21:03:25 +0100
X-Gm-Features: AaiRm53OywEZ-9snmQAwJUPw_yVph9JnQVbkwj0vQh6FVln0Kgy98BO_f8V9K3Q
Message-ID: <CAH5fLgiM3+2URibfBNQr5X80bKvZnwA_tBjHpE-d_FHye7w1ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust_binder: avoid reading the written value in
 offsets array
To: Jann Horn <jannh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216900-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8D64B14FCCA
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 5:35=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Feb 17, 2026 at 3:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > When sending a transaction, its offsets array is first copied into the
> > target proc's vma, and then the values are read back from there. This i=
s
> > normally fine because the vma is a read-only mapping, so the target
> > process cannot change the value under us.
> >
> > However, if the target process somehow gains the ability to write to it=
s
> > own vma, it could change the offset before it's read back, causing the
> > kernel to misinterpret what the sender meant. If the sender happens to
> > send a payload with a specific shape, this could in the worst case lead
> > to the receiver being able to privilege escalate into the sender.
> >
> > The intent is that gaining the ability to change the read-only vma of
> > your own process should not be exploitable, so remove this TOCTOU read
> > even though it's unexploitable without another Binder bug.
>
> With this, the only remaining read from the ShrinkablePageRange is in
> AllocationView::cleanup_object(), correct? If I understand correctly,
> that is fine because it can only drop references on handles (which
> userspace could equivalently do via BC_RELEASE/BC_DECREFS) and on
> binders (which would probably also have its influence limited to the
> process)?

Yeah, that's the idea.

Alice


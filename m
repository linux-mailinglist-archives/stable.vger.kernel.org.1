Return-Path: <stable+bounces-216863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJLHN5mZlGkoFwIAu9opvQ
	(envelope-from <stable+bounces-216863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:38:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBE614E4FD
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B302C3043D77
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F47436EA9B;
	Tue, 17 Feb 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UT5w6tf0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579036B059
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346148; cv=pass; b=WgaTOL4vMoiLZ4JtfBPvS8M7AAUfCLXLVroOVD6Cl+eexmjorlFK+r1ypcOuDzpV/3mQoE+sLnFC9yC9cJAUfi6m8D4GilMOFYEIpamrSoXS7ChNhGt/l3Oivzqk7oqUQ1afpkkvQ/7z9bYbSl9mO/5Q1LajUe+H948XOzZgS5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346148; c=relaxed/simple;
	bh=EfoWbO1N2K5lxt2kPsEb/kyin+BYy7b1ZYySAlSqij8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph5b8QZk5YzzSLl6T1iUwD/XwfJcsT0DbMz/vCFKdO2EFw+SxhJ8yNpgrJcRGA2AlqBbSKrySXsVuqRAkHF2s/m5NdAz1fsRH5BMfTot9i4okRtVRHv5pZawkBAriB2V7QMbbQKOpcAMh16cR2zY9B2C/cvwWYsg5SiQ6l9dS3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UT5w6tf0; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso22682a12.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 08:35:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346146; cv=none;
        d=google.com; s=arc-20240605;
        b=fUUL/DKADmnjw7piLqvED/bm/oc03tWGouSVaENjmbR0j/yNc0BjbVMeYBOWVnLmYB
         VkzpuBOpqUSQXC215P9AkmtEw3ntm84GC1is6GwoiXF0fBW+cbn+4dZzNJjEc6GWL51/
         v1jbnV/DsKkVS9PQmBMliXcPbjqy8kRAP6uj1DuefuGfP1exXwbpIhPkKRxjeB9IdXmg
         0k2t2osn2wHyuwePjjumFLHNz9Gt/oiycWV4KMRxhJ2uhrCBI/YcEHbNs5i9PzEVilKi
         14Cst1WDgn7cA3RzClp8xj15GXcVu2CWbGCAZHrYTx+2lWPQqkB9ZhJOqnwfVa07RukH
         JQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EfoWbO1N2K5lxt2kPsEb/kyin+BYy7b1ZYySAlSqij8=;
        fh=n5gTxaa2gaA9ewR9I5nMyoLcst/M0dpYIAlVw2G21rY=;
        b=Z3fLoJ4NyaYr1vp4U0QRCauAS+5WylJsf4ol8Taqkp8MvRLJEK1g0s3FI6ZIfX9FGy
         nt++Hq/52aQcpqvJwSnNY9roGQu8AlfjjFObu0oPoDKNwfOAFDXBnKz2Vw9o3lJ9ORLf
         rcFP+/VJ17EMLh+dX8pO//yyYRhCZ4iz/unrRCq0BHQMTsU7514jR9dMV4Fi7oVtXPG9
         d85+tFC/Pg1ZAPj1GnCX6uBgLY+XLflkSTqtZcKziVdE3XetTgzrcYiKQ/oIEC/jIJUe
         FzgZvxPfsn669+Of9AXhEH3auXV6vCC2ZKr2lWKWeEXu/8Z1E/Ew87DzH64haUrX3KsH
         ZUzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771346146; x=1771950946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfoWbO1N2K5lxt2kPsEb/kyin+BYy7b1ZYySAlSqij8=;
        b=UT5w6tf0XqVgQ063XdoJtuFKUig8HRqurY6rkopHmPAJKgUt+QM+IodzK4cZnUgHVc
         yc8ffFuGV4H31IFp4s8SsHY2TRBv5ghpSqngxR87Z+80tqF9lmhJ2DTMtG1FTjFmKNJ9
         HCNOCth6XQPpqlpJzNGXOd/b4OvdwC5is2qtYj53VkaLIlcBLNHePqDK4dmC2GbH7IYo
         Zhz/XT0AgEEcle7n+WVY4J6saIarAs/XT2osuZ75iD0d46reqnM6EU5tgIa5Sfp9k0+G
         ZAbPeJB4/l6O1nIFEm0c8mr1dLw0oxnHL0PV3XhCGAr+zNFl7mQeh/wv5MmmNiAortv+
         685A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346146; x=1771950946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfoWbO1N2K5lxt2kPsEb/kyin+BYy7b1ZYySAlSqij8=;
        b=DsxpHC/xkBTOXBosM2LIzEsAjYeMbOe1K8vVDQKeBT3U7GZZEv9tkRTR5nrIGzrP8T
         dFViXLSGp5RjQw5UgNpt1wusbXN0J5i7IsFOLwojRAAijqdUzK6fYY9SusGMR0U/Ud0S
         aU7M8QTiybSMVOAP9vAZ5gH5nULQFp94CARMl3ro63sAp8bwv9sqBiBDJ9NXxDYXYrBM
         uOJB87l5D+MmKLC7DnIAw6jHABF9S6T83G0XCp9jMjgGhl0rUs8ylewj3ekKOVNNOCD0
         agV9EwURCkGocUCQ86Imtv4mDoDVaMFCJyXKACcrIz3cu4h3eqwHt4Wp7AZjhV45Qln+
         cAuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0qEp4+sF6XGn1CrkXFyXx4kleZ27wDqv37jgNH9983SV9vm1TSnEX85CtoadmqOHI+L24XH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6yqKpixGpJXNQkM94PMfg5V6b8lX38a68Y2ZnFIZQl2AKQIG4
	BZ2ETbUWNY68awdVtFOA8yjZVBXp1K3AhWdIavB/G+R7s0VE/2YEHfEPa4L8bTzO4Y+S0zn0FIn
	LMiDA7BwnxwgUhVy77+S1pT93I4QnlkHWJTSqY+Vi
X-Gm-Gg: AZuq6aI/IwdQxov8GBS99PbJiMxTcdAhmJ9raRGST6D7BN2VAyh/dwj2ixGN0zhgbbZ
	3oK6gkNdVvWoWhJ6Ftg52kZFcvALua6WOhETtl55Eb25S0ekxv3SKxkjtMHKVpPq8JZxj+oxxWp
	6lk8vFTkhNnFl8WP/lPuFd/5z9ZLo3I74A68ilrpJdiLHlXZSrrUCo+SrOAjX/5FKuKtxOn7oh+
	r8prkMKo5ZVLdBLsUBUwcWAVU2QnOHHW+u4dNCCbglNqqG7cbqz6zVMBdIyDwX7oHHMrAZQ0Aa/
	NFoiMVyzP6GZGc73MrAuFl068dgBSKQd2xG3jffZyPhaAwdd
X-Received: by 2002:aa7:d454:0:b0:658:eee:f21a with SMTP id
 4fb4d7f45d1cf-65c149a703dmr56554a12.10.1771346145107; Tue, 17 Feb 2026
 08:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com> <20260217-binder-vma-check-v1-2-1a2b37f7b762@google.com>
In-Reply-To: <20260217-binder-vma-check-v1-2-1a2b37f7b762@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 17 Feb 2026 17:35:08 +0100
X-Gm-Features: AaiRm52oKTHP34zclQj7ezY1ha5t7IvLtrRKqEuUAhNd2ttiDd3hEDLvSQutZtc
Message-ID: <CAG48ez2O=_Hd7EjjLSAh36xtOMyX5MZ47xodWkU3FyEar63TnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust_binder: avoid reading the written value in
 offsets array
To: Alice Ryhl <aliceryhl@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216863-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7FBE614E4FD
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 3:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> When sending a transaction, its offsets array is first copied into the
> target proc's vma, and then the values are read back from there. This is
> normally fine because the vma is a read-only mapping, so the target
> process cannot change the value under us.
>
> However, if the target process somehow gains the ability to write to its
> own vma, it could change the offset before it's read back, causing the
> kernel to misinterpret what the sender meant. If the sender happens to
> send a payload with a specific shape, this could in the worst case lead
> to the receiver being able to privilege escalate into the sender.
>
> The intent is that gaining the ability to change the read-only vma of
> your own process should not be exploitable, so remove this TOCTOU read
> even though it's unexploitable without another Binder bug.

With this, the only remaining read from the ShrinkablePageRange is in
AllocationView::cleanup_object(), correct? If I understand correctly,
that is fine because it can only drop references on handles (which
userspace could equivalently do via BC_RELEASE/BC_DECREFS) and on
binders (which would probably also have its influence limited to the
process)?

> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Jann Horn <jannh@google.com>


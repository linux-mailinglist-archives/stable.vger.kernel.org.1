Return-Path: <stable+bounces-224867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEGcA/DJsmmvPAAAu9opvQ
	(envelope-from <stable+bounces-224867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:13:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2536273206
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 185AE30185DB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC3359A66;
	Thu, 12 Mar 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sojfnhlo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D035F189
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324779; cv=pass; b=LZVOSHugvwbCoIQMLICPuJx8WFmGjnoy++BXSoEkoJ2NpWa3+YAC8P1ibtghW57wBOadhyzicDjuAtIVHXiPN+heqwKa1dE8q7nFXohBQhhb5NBx4kJm4oqzDFQPscYmnhMrulCaU/b5yKIJJf7q2K0S+krMmE3Wvy0ZpNWatO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324779; c=relaxed/simple;
	bh=crp4nXRTSnQxu5DrXrn4okeAwkLZ7jy6iVWODJy4Gjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnx6jRj4qaATAzRF0ilWadv1oMXVZA+isWLq9ZFgL7xVcZh+r7sfXnAIVfqzGQFL3PwiPX6sicTrJ29OhaHJmxOhdzLH7puf2Uy8JadBOOURaCfhmFvFKvAyXCHebKAV/3XNpB4dG5ecZX5mXDRA7epgbEcYRJ/r3dug7XRxnEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sojfnhlo; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd801b40dbso65599eec.0
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 07:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773324776; cv=none;
        d=google.com; s=arc-20240605;
        b=hlgu/DfZ8sJyRSXNT0wv1ndl7eLhDy5D5Q08ZpIKErWp86M3jn6wqs0F7+B7fHLX36
         jOiEyvQw+2YbH6qMZBRBeSj+lO6az68QZlJeJdifW2CZGd9SUmbZA7v4TXVzTxwl0hHQ
         xqRTA1fULnsffqiis0aSJm+K4Dnvr4pdm9zKT0e0Wqqh/aOar/xVSnp12NgDDSduENB/
         K9HETK/YM73X8aPp8hJ1xWTd7kmO+8DTP6IKtQNMt/10i+zEroyEctgA23F0pMOtJKMg
         h756dt16dqyBXs0oKYtNlDo0h+JmvUpHpgqrVF75bkp3vnA1m4iF1DWVuZ3nGi9XI46V
         gYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6eOWrX69/YZe4aFBkH+waBiPUXBOMXCfZ8Ty7gGvlRg=;
        fh=8zXDj8IT8BQVYhyOyrxnPthebn+yk6Mwa0wztBMAQhU=;
        b=XaCf5nJGPZlRUutbvDogUeddq6UJbBKD2hhDPCGxlL4pnLR88Xvt8yakxm7ig/ngvg
         IJBJSJRj8gpeVHk88GbP9NqHTFO6tcOq/TjEo+ZruTopRpwtQps739UTzaKhumhrwLLF
         UgO4C5qawgkIwjbI5bTH/B0jXyJec04CrcjWuAMvZDiIfeewzqUiFxh/Z/tSbBoAWkz+
         +HO7NqahZEA+Bcj5IegBF8Rw18KXp9LRlHMW0LcQK0gqVnSiHY6kw87v8vZS5o+AL7LD
         1e7UW/Gtp2t0hy66VZ2WjteI68IlDXdSXJ786N/0ko6MZpMhiOnWl9k3T10psK7ZZ7cV
         LGtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773324776; x=1773929576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eOWrX69/YZe4aFBkH+waBiPUXBOMXCfZ8Ty7gGvlRg=;
        b=SojfnhlosruICIDHrT34kuOviz5EgoPYCimgfL8Pibf58jQovTKT04SFv8kWWaaqvF
         9L0qrCqSGeM2brfXliScUcPXBiXAS9YKx2MtaMdBftp0yHDxwG9E8ojQiZtDnmNnYhRN
         OHvdfG1zqSl2yRjCiv07Prj7sELdH1bTVRg5Xvm9w63y2Srhosl4wsHPMOn/Jtpra5za
         hL+Tn2MhochJfuWwG6WbBs1+1fK6lQoCSTCK05qbuQpula78nMjvNOB9zmZDwzlPQ85u
         Gl/pOnzxrG+levfU0CjGCKCu81Sfo+zs4Eu1EZxWbxDkmDQz62SZxSDjjWdytcn5IlXq
         3GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773324776; x=1773929576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6eOWrX69/YZe4aFBkH+waBiPUXBOMXCfZ8Ty7gGvlRg=;
        b=qRzs5pxihwO0RnA73V+YJjCrAlSHxcKu8B3bgsE8ktILvA2ylqbLTkmpxeovDq2vsN
         BJosz95j0DA4Dsdpl0ErU21RiCacKEa8ddODvWB5V75EIIEmLmx+eziVXJnhfxTpHHxv
         GfDA11fFdjSt8v/4V3bkB4hdq/NKj4yYIBf+TfKuUpDMjRIqxYPaLSyLf443/hcXk+DM
         MfoBYyH+P1OVkDjj7b/On9SLwQwQfVvfW6QxtsK22P1qCpPnW2tl8a7L2drMr3JgE7ix
         ZR9JWqfb1870Jxz6I6KVu9UeMmMslbpgpjrRAo+IO2/G4zj17RG7Oi2EaIjt/Y8hl499
         2JUg==
X-Forwarded-Encrypted: i=1; AJvYcCWVoqk+ibQ6Tn+zSKHzfwEb3iBJpCuwBHGJbSQjvFzINNTGMo5JrYFEWhNbG1vfxmXSeNncE5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxuydhrvQC/HNu2H7Z4nXceohv/OIrhl6iypw9ePaYv9NjbJ5
	2oAnvgSvi5uROXFPi+KmCfh+bwR4xTNFEjQXjbN1MK3f+Yaozt51EHH2ELLX4v5CJdjJD4039vU
	02rxF2JA9X4/dE2fkBEud9z7yhonI1rs=
X-Gm-Gg: ATEYQzyX+XsjmD73kDwkg+GpSrsfh8UISPUDAv3PgzuAaHp5Z2D55JCIUVVyFT7+38o
	UISR7kFoDch0NRVHyI2j1PKeD97KnJ1CmZ4zOQA0vxEKJS3Mz0mUXrJOtcKC77BZcFmEbm/A3px
	56MTUx50wXlee6fSujb1FtKs0fYX+mCowV5dMLx04PI519YBqVro0qJoJjGyMuNJHpBeVrCC5VU
	EiOxn6kBKFAeMAOXCQdnAd0YZB24j/NKbGlrrutMVeA++rQxhpvO15ZryOzBtgewv8R1CAf3Ih4
	IA/3qsK/7RaZTWtAMvGJ2nBYCJvivFHIvwqVslzyu5Zt717tAaU6FN4SKEvSZYawQqmWiBqJ7ts
	NrTpZfbfdUpQHmhTj0WDqW8M=
X-Received: by 2002:a05:7301:3d18:b0:2bd:d17c:b0aa with SMTP id
 5a478bee46e88-2be99a92ca7mr517960eec.6.1773324776231; Thu, 12 Mar 2026
 07:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203221224.GA2703490@ax162> <20260205131815.2943152-1-mlksvender@gmail.com>
 <20260205131815.2943152-2-mlksvender@gmail.com>
In-Reply-To: <20260205131815.2943152-2-mlksvender@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 15:12:43 +0100
X-Gm-Features: AaiRm51IHWWN5UTrr_5ZnPWocBFehwqVL5SrUFu_N1GxcI2hhpEBsuGv-tlBNm8
Message-ID: <CANiq72nnuKJaKrxrut6+noR13PUiSoWWyyp-pGx-fe_2O6ayFA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] rust: Makefile: bound rustdoc workaround to
 affected versions
To: HeeSu Kim <mlksvender@gmail.com>
Cc: nathan@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@google.com, charmitro@posteo.net, 
	dakr@kernel.org, gary@garyguo.net, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, nsc@kernel.org, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224867-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,posteo.net,garyguo.net,vger.kernel.org,umich.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A2536273206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Feb 5, 2026 at 5:18=E2=80=AFAM HeeSu Kim <mlksvender@gmail.com> wro=
te:
>
>  # Similarly, for doctests (https://github.com/rust-lang/rust/issues/1464=
65).
>  doctests_modifiers_workaround :=3D $(rustdoc_modifiers_workaround)$(if $=
(call rustc-min-version,109100),$(comma)sanitizer)

So I was merrily going to apply this, but sadly, this is not so
simple: the patch doesn't work because the doctests (the variable
quoted above, no the one that the patch modifies) need to take into
account the other one, which appends the sanitizer case using a comma.

For instance, for Rust 1.94.0, this would expand to just `,sanitizer`.

And it is not as simple as adding the flag there -- please see what I
wrote in commit fad472efab0a ("rust: kbuild: workaround `rustdoc`
doctests modifier bug"):

    By the way, the `-Cunsafe-allow-abi-mismatch` flag overwrites previous
    ones rather than appending, so it needs to be all done in the same flag=
.
    Moreover, unknown modifiers are rejected, and thus we have to gate base=
d
    on the version too.

I would suggest we take the chance to introduce the range version
check, and also to gate the doctests check up to 1.92, since it should
be fixed in that version.

And perhaps it is simpler if we split (expand) the cases explicitly
version by version for each variable using conditionals with the
version check. That is way more verbose, but it is way easier to see
what is going on in each case and to later on remove the cases when we
upgrade etc.:

    ifeq ($(call rustc-version-range,108800,109000),y)
    rustdoc_modifiers_workaround :=3D -Cunsafe-allow-abi-mismatch=3Dfixed-x=
18
    doctests_modifiers_workaround :=3D -Cunsafe-allow-abi-mismatch=3Dfixed-=
x18
    else ifeq ($(call rustc-version-range,109000,109100),y)
    doctests_modifiers_workaround :=3D -Cunsafe-allow-abi-mismatch=3Dfixed-=
x18
    else ifeq ($(call rustc-version-range,109100,109200),y)
    doctests_modifiers_workaround :=3D
-Cunsafe-allow-abi-mismatch=3Dfixed-x18,sanitizer
    endif

Cheers,
Miguel


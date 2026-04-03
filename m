Return-Path: <stable+bounces-233168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DLdLFqUz2nmxQYAu9opvQ
	(envelope-from <stable+bounces-233168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:20:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2376D3933C4
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E850D3052445
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B245737B019;
	Fri,  3 Apr 2026 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djt6QZTR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151DE38423B
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775210839; cv=pass; b=WedNE6Kzrv7G56m36HyUPz0/2rWuDumRRPL6wP8dKNC4ThDKrVguv71jI6vcBnEmzdhZKP585AnBO4k1KvaSNom1yHZ/4wKrmKn8cnrMJzniUejbctqKT8rcoyhgLwUTf3xrjNMeBzLaQF2mFvqZb7O1lQM6RU5WaXmngKOJ+co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775210839; c=relaxed/simple;
	bh=l6iFZzW+AWF3/QEU6LglpEwpw23G8B8xolbXTX0zh2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU4xSK3Y2rOepfNawIxy0jgvuWkVvxLdBAPoN/0ymEEMPKyD7eLXRJ05FVZ/7hd7enRXK4DSmQrFDRwcu1hoGpOTZ20qepaF2ANL9NYVJDrSDp+Wo+f0PXUAAXkHmzl1ngL11woDGnBWzrfxGAhU7NtFR6GF7f3WploTvNfGzCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djt6QZTR; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a42d3fb6bso1653021fa.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 03:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775210832; cv=none;
        d=google.com; s=arc-20240605;
        b=ABofX3RuC2vBG4sATvB3270/tCb0oJ4xf1qEV3nvlAZQUN31064jOcQl9L/svz+GoZ
         kSG+Y77aWt9mU8xEljtQ2gzr9qnHIaP2tVF07NQvKx2v/+clSTFqzge8RJsSxkroOLA2
         ZrEPa/n6uXCFT7cDYFiXiWJvH0ZKWaQzGUYhSIQGfpHSmR02W5RbOU+ymjIoRLgH6ACz
         CVBYvwKa7v+cSuoulH4Yf1EAcS9K7Z8XDCfHaPy4FyNlfumDrC/DqQyYUXAAre6xfknj
         kNqmkMXAdcPAouEGOjnXuNuk8R9E6mzkyRx9azntdgJdfCjYhpDPwDt0ZyfALE7Aoiqg
         kn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPJMJaHpZbFcRCyZeIIkk5jL0cCGPysTlsDPbLnYuac=;
        fh=YjVNbZwuXT475M72hnub2bAKUjbSO4tDh4R0GTsgSY4=;
        b=S4OlHDm+3wwp6OZAB2EzmuW+QsSUhi0/vwBgDFQvW0QZpymZMAMZKhJnxBrMz4ZLoX
         SbUHICRptLLFv4CAGEvcpbUVbLA1BES5HoprodGYnwxf+SHamaNhrWlQVNIXFW49iYqb
         YbjOZOfxartFhe+DjVWrqZaOKU3h68vcMVKdwM853Gas4odWVv2T3tSv+ru+RdA/REVH
         BfHBDfnQfcsgPysL6bCxsnaLu7LNDZ59wpbKDa7GOmeYmbs0sAOIwgeI9N18i/F29wMN
         jAh6KGbAWR53dQuHBALc58dPwc0rdS1AFTysykfUL8wPD8n2wFJOdjlO4eTPBCogNjyk
         17aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775210832; x=1775815632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPJMJaHpZbFcRCyZeIIkk5jL0cCGPysTlsDPbLnYuac=;
        b=djt6QZTRfT+XcEa1NxzzaJE1gUQlCKaKO6cK/w6rS80EpPop3wYhW02DcP4gx/OMZ6
         yMOvMJMI6seSsYr53wjzyZ5u3r4cd4EXtwf9wRNLRUpgxbDLwI8BNEH0tJG4zkPyX2am
         5khpWbmWgBOe0AfPhHD1CirtkaPoet0ny8l9uSKSrHxiS+DHLiBZmVa41briIfrMxbP5
         gRePp3b4PvkWE4FhUxRkDjnABs/c2zamHosaduIZbyFCb6sXEd5bNVeArrt8kIbLjSu9
         1KazumvICrWNBZWF0T9eFIkwJTD4Bz3CP+qSwmJx2PRff/bUHuHf3QDKBc/iYdidY1il
         UDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775210832; x=1775815632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPJMJaHpZbFcRCyZeIIkk5jL0cCGPysTlsDPbLnYuac=;
        b=GY5vnYIj28rhjz2jXBXPwY5plr/cINj4yEgInYlEO47CQrpI9kAI4y23ar5If5HITO
         saajWvw3z+wEHq35tbUkLktGyoHDHCTfVCb6Qn5fvugqTybsq2+MnBh42ctcn9cSiu/L
         BdJR5cj3MP/LsI7H9YtOykgeZAHoo/TRjK9M6kkXEQO6UwL/+dPMRNFLHjOSrgk1h1PR
         Sjs/zS1o5QCYX8Jku/2rVUiIdPwTJYvA7ZTm1fr6Ki2IPVzjEFi6B2T3+O9YacyFJKSQ
         ZlddnfnAsCrB0HWRZ5Wy/a6q27VlNoiChfzqoRmdB3l91NfKuObIbN1qsZXbNRfZAjVb
         raJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIud0kG1JAZ51789fkP6TKRAeBdKWzidQ4IZd0AjevvxO1kFn1DoBY0IkWW4p9k/h8YGeDw24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUtZSevOTuGY5kre1O/apAPafLYyD16Rn+HfY0V6WOLZtlEab
	vuN7UWVUfPtgBAZjnWp79esy8Z3ZaOulS/wO+x5js38Wyrzuk6LL1OWHo6aGmvKQepZP4G/TfY8
	80zJ1r5R6DoGBh0rKHjI17AiNwJsxMuA=
X-Gm-Gg: AeBDieuaVNI2AJZlhn8ce8gYWquAIyNFTYqTMFsdnVTVrEbnT71fqpl0ptUAQjuAgXi
	zmC5dalfQVg41MuaLNGIvZNziNXXWYkYjnj8e4CWY7JwegWHdhHm58Bf4BgLFpAXQnmd7AJssNS
	9Kg5xzJGi19k6cj3+qLKMUztUxOYZArK50lZukPCeRfNJ/Fm76HSBnU/DMkoY2F+xJtRzgga/Qp
	70RHXi18+E3KraSFk2stIpbFzI1ruugdrJsS5YRy/IoYjDusbpZ1wKAhgfSPRgGZLnxRYDJwSDG
	Kj/wf3i0hUshIf2T4aU9MsadIpVpV8GRUsVYjlMIRCq3Avfb8R7XwzIG/D/rB0kAHzFbwgldaAm
	hcRu0md+55+nm+n6Wn+BUFJA=
X-Received: by 2002:a05:6512:31d6:b0:5a1:4712:376a with SMTP id
 2adb3069b0e04-5a33759184amr467862e87.8.1775210832087; Fri, 03 Apr 2026
 03:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org>
In-Reply-To: <20260331205849.498295-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 12:06:56 +0200
X-Gm-Features: AQROBzBBW7rQ85ZJif0nroczUc04Z6h0dVRy0ZiPuatyp9TJcZiZGUSTP9K1ZwE
Message-ID: <CANiq72=-vxjqPPiAPrN8Oxcs8ExhHY2qvhN_Qd5JnxGGKEOOcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233168-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,google.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,atomlin.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	NEURAL_SPAM(0.00)[0.989];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rust-lang.github.io:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2376D3933C4
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Tue, Mar 31, 2026 at 10:59=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Clippy in Rust 1.88.0 (only) reports [1]:
>
>     warning: variables can be used directly in the `format!` string
>        --> rust/macros/module.rs:112:23
>         |
>     112 |         let content =3D format!("{param}:{content}", param =3D =
param, content =3D content);
>         |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#uninlined_format_args
>         =3D note: `-W clippy::uninlined-format-args` implied by `-W clipp=
y::all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::uninl=
ined_format_args)]`
>     help: change this to
>         |
>     112 -         let content =3D format!("{param}:{content}", param =3D =
param, content =3D content);
>     112 +         let content =3D format!("{param}:{content}");
>
>     warning: variables can be used directly in the `format!` string
>        --> rust/macros/module.rs:198:14
>         |
>     198 |         t =3D> panic!("Unsupported parameter type {}", t),
>         |              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#uninlined_format_args
>         =3D note: `-W clippy::uninlined-format-args` implied by `-W clipp=
y::all`
>         =3D help: to override `-W clippy::all` add `#[allow(clippy::uninl=
ined_format_args)]`
>     help: change this to
>         |
>     198 -         t =3D> panic!("Unsupported parameter type {}", t),
>     198 +         t =3D> panic!("Unsupported parameter type {t}"),
>         |
>
> The reason it only triggers in that version is that the lint was moved
> from `pedantic` to `style` in Rust 1.88.0 and then back to `pedantic`
> in Rust 1.89.0 [2][3].
>
> In the first case, the suggestion is fair and a pure simplification, thus
> we will clean it up separately.
>
> To keep the behavior the same across all versions, and since the lint
> does not work for all macros (e.g. custom ones like `pr_info!`), disable
> it globally.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://lore.kernel.org/rust-for-linux/CANiq72=3DdrAtf3y_DZ-2o4jb6A=
z9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com/ [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/15287 [2]
> Link: https://github.com/rust-lang/rust-clippy/issues/15151 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied series to `rust-next` -- thanks everyone!

(If wanted by modules, I can drop the top commit.)

Cheers,
Miguel


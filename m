Return-Path: <stable+bounces-242206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAYmOIDA82mw6gEAu9opvQ
	(envelope-from <stable+bounces-242206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:50:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A84A7EE1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D7E309450B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19B3AE6F5;
	Thu, 30 Apr 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2HDrsYo"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E103AA1BD
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581889; cv=pass; b=TsmMfGkv7Xn3lJSdev+PxYs9PxsHA1FD3ggISdy1aQJZ5LQpNgvi4bYGecmrmCq7GQw+AFtMO07+4jESZ8eS+eV5PhhbDwzaRKyDvwcy39P/SSt6wkS0+eqn0/BpC2GoJ21v+7BfYOB7au4ALnsX6lGWxaTnR5fstvYqCSmioyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581889; c=relaxed/simple;
	bh=b4+MgMI+H1EJ/zFEqeAfvolr40MDmi9r9YFv3gLEylU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHPmEH3OVWMTHOVgjVUCt40EWIDm8YBkNcfk2Z2Onk8h+AP8T9HriGO6zPQQ3XJGrK7h2H4oSZvcpWkge51JJBb2/7M51ER8rytVMVwdNHGJjNNHDKbjKP7vZMeLfPOLZMsvu8Ji2oPK5FkIHHmpXlP5per3j8MXArpnU4XWwow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2HDrsYo; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2e92c54ba73so155989eec.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777581887; cv=none;
        d=google.com; s=arc-20240605;
        b=NUZve2bo9Zvd8ErlAMtQn655roPWuba71TTlnbYTf9v3jdtluRy6NPRUeeJCln+ONu
         8/VZy/TqoeqNLCfe8ShIf6YReU6nbwsn1PvMuwdX6UdTKTmOL6MacQP9aNV6q7j56MR/
         Uh+RYXBEGxDwFeVrjRaxOWA+15Rn4C714CKcp/x1B9YhB8RC8jUdrNZYfhiu2d0XY6QH
         IkzC0bsUfp1OGrtrGQ4s4DlLBs1hoUCjrX9wmgLohR/mNX/QDCnRBjluUjI6PihnDejb
         XsDHIF2dT32SHJTxHUD6Ft91G700vJsU21RuuISmJx820JSh5C99JTTrCDfUuKN1qdid
         lF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9AZSfuCo9bDJFKcrKgk3T/HVLYY2ffU7PQ+wrb/z8g=;
        fh=G4u0wZNBsRoU79o6LLn7fmh1Wp/kwC1vYrwTyyuYH+o=;
        b=BV4NTIBPsU9xIE+iUXoabGkN2Sh4GxksjfhGP3yr1xvf4tJQnXeMrI09Q0Ad8GAi4b
         FLxh4opTG0ZHhLaGN8U3q9bE9jxBZHSG5PM/eAkjYf5SJFK627iaOV1eYkri0WKV34sB
         dRzc+M0o0zjGvw8l34GQraXmfham0p6LnYy8wXhLxKsoatueyDQq05GW1uDT9V7GOlXe
         iTPwsq1FTlPuZh3/Pm1dcm/gbuHxzmCCzQekVFIlzAEBdXvCmz5wEVcDOdzpol7qzt3S
         o30bxzZr1kBn3nJU5fqSAl+p1AXUkOp6ntsS6nxNn+QLmSjaCK8deCusje6fjOJQPlxp
         vVaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777581887; x=1778186687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9AZSfuCo9bDJFKcrKgk3T/HVLYY2ffU7PQ+wrb/z8g=;
        b=b2HDrsYoC365WpZLDIwVt7Oqol8Atvfl2Wi3zDR7u+s0U72+tTIcTffJ3veLc7Mkk5
         09pOO+Ifvb9tf3kv6TdqnmcStbupnwA22CD46720WfPlsMoecV6k2kAdPJV45DT7wezB
         lphNim3MBPNaqbmWlKeYyp3pAtkcjnhs7Gsmk6TAOYF/WDPLBqq/3w5pDWVamR2+gbcs
         96bDGzRVMK4+QF0JpEBJLp9c0ems2GUQZ26C5Kp/bBhavQYFEm9uskh++VO5TmjGRz1K
         +iXT1WVtaGYjduG1nKmc+nHXs1aIP79WmO8HzWKwTx/nwz7+XAZyqwS3Ikzalr7fwwoX
         Opfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581887; x=1778186687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9AZSfuCo9bDJFKcrKgk3T/HVLYY2ffU7PQ+wrb/z8g=;
        b=boKj+QbhliJ3chpO2Tpm1DEvTBnip3fOCkw5roInMsEAxllzL5x/m0eKYdsFI7Vtlo
         1Vaew4ERtPu5wgBBJ0auW9m2E6TK34zUc/+2ltij6XmdGyHNU4Kn3nbzPi6sbNS7TYKW
         9AFfyWKLn4PytK2vmpXrzC4UTtCkp4YOXyQ/12z00xJ/T+HtOf3XOxMJpmQxAyjfqTq+
         DfcJLoq98ZD1hQ2hKxb6+b/lIJyCXh+ggpsii8T8cIkgWO+rEbX65m/ypxXjpc4uX1wW
         zEE1LaYG3bPHYaoRREkvO2g5tFuuiPhn3GdlT4vmSf9cJL9ZyQAY2CLx9IZcbhIhtcuR
         ELvg==
X-Forwarded-Encrypted: i=1; AFNElJ84BwkmqEMrm1E0YXKosR5jZiqY36s3RJzgLHRt7ud/Y3CnTnAw43AosKi18kqCYpOX9wsrvz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeFuBCiju8ETVSYVOKa0foRn6ulNGsVXScgddOQp0WezXygepP
	eUGdtd/pa6cpx5kILoFXyA5VwMl7nmV/YuKZ5mf28O3FTnPHUl8/KTLOeQ97e80USEmSS8kV5ou
	isaH6JrfEMj+0zZhxG/6bZUMYYMUpmcQ=
X-Gm-Gg: AeBDieuX7dGT5qcCn31bVV2wkpZ594n7xA8WMk9W3vt/Q1xxT5XhmmaUNnRgEsT88Cz
	CTpeD0T7jsFxKtqM6ev/pWNcS3kayr+HOO1BQAHf6WovHLeJaPfuzCxuVobHrIvofTBMdOmOCfN
	cVeokhi9MIj14lMxr4A7Llk3THRcz9W6cnZgCJTD6Rtd54kXQMkqKFLyaLfbTvzlNYvNQD8+Jxn
	nskGy1wCZN4ESPNbFJ6ULoyj8z/qIrC/opDKS4AltdCSwpOiE3Qj1Aels+p4VW5k/b4Y9UsNO7e
	FMB6I61MedJchevJr+qjWHsHxpDMSc5wY457EyaGYbIr7FUnEf9muG0Wq6nAPyY36AqATOctupl
	BGr4dx8AENu059urYVnPnGUzh0hxmQ9XpZQ==
X-Received: by 2002:a05:7300:640d:b0:2ea:ed2b:8085 with SMTP id
 5a478bee46e88-2ed3ea6e4abmr1015049eec.6.1777581887151; Thu, 30 Apr 2026
 13:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
In-Reply-To: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Apr 2026 22:44:32 +0200
X-Gm-Features: AVHnY4KqdHGVaPSvIrabK80Zz0RmFuEVAjFGZEQ1JTgv4BJHAcJmYxi9-IGDZpc
Message-ID: <CANiq72kyqd93wd4cNxRZmWyO7HnGKo31i57ouh5gV5n9jEdu+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rust: pin-init: fix incorrect accessor reference lifetime
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 523A84A7EE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242206-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 5:43=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> When a field has been initialized, `init!`/`pin_init!` create a reference
> or pinned reference to the field so it can be accessed later during the
> initialization of other fields. However, the reference it created is
> incorrectly `&'static` rather than just the scope of the initializer.
>
> This means that you can do
>
>     init!(Foo {
>         a: 1,
>         _: {
>             let b: &'static u32 =3D a;
>         }
>     })
>
> which is unsound.
>
> This series fix the issue. Details can be found in the second patch.

Applied to `rust-fixes` (originally, half a day ago) -- thanks!

There are a couple typos in the contents of #2, but I didn't change
them since I imagine you may want to do that upstream (relinguished,
transfer -> transfers). I only fixed a couple nits in the commit
messages since I assume that has no impact on your processes:

    [ Reworded for missing word. - Miguel ]

    [ Reworded for typo. - Miguel ]

Cheers,
Miguel


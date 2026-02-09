Return-Path: <stable+bounces-214899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MRVHC67iWmEBQUAu9opvQ
	(envelope-from <stable+bounces-214899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 11:47:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91810E4F1
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 11:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 208983023A53
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DEE368284;
	Mon,  9 Feb 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM+EaUYy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612D92F28E3
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633920; cv=pass; b=amUxLE0X6yB4n5CGRYItqFfixTeZtYannIi4/mdhK1uXXS+cDKuzfI4ZDvYnwCc5wmJkjgeUN/lj6YqVn9SWXzYn2kMK1PmYH1DKyWIW3m8mka5MG6X06sYhPmsZVxzSJLFtUtHr818vywAsCkcc8MZfhT/Kmk3fsFVMQqo/EIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633920; c=relaxed/simple;
	bh=hdoWyEBSfzPVnW0gPvG4K2YGowzekBI2D6ClbLg5wVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVA4JwfIzF1+RddHw5gErGQHsPmLIJqU7zo8zTi2PsTZ7hMicHjjfUPJsjzwuajNl4KXNChSg8mDxeOiyZTA7GZNzmnNkxPrc48ny9K7s5FZXyUTRtaCOJWZh501dytpjBE79xxNK0dHMvCNKhAWwXd6Ofa56UlL2KyapaU+KCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM+EaUYy; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba7eb6022eso16631eec.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 02:45:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770633919; cv=none;
        d=google.com; s=arc-20240605;
        b=DW2A4M0deI+iiiJluZLmBXVTlyuHt8yyK1bp0fVh4ACSDVvInI41wz4BaDcZw6VWRY
         8cWnLDPWoiSZexE1gRC2lloq0Bx7CJNFWV2kAJD2mLlSDi6LGTUSoHKC740C25PFcWQl
         orqAf0zgyD/qyZ0E85L4UrSfM7Lq9xBbV9feQsTsOMWxOUvqB7VFzsH2TTfiDfpxgse4
         2XkfcFSoLVuy+S9XdxjINbCTSXDac6QrlOlN7Rsg7nU5fdil5OA5PLf3aZ+hVbD43Vzp
         3N6VbZnuczE/r0bN4AM/Zldo4ofaRVDyqlK+797KaSgeeGLFra72wSZs4ulcb5QGDNNp
         KW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQ+zj5yCqVDGCQMDIhhAeFu/f4Yt8z0Q2y0QTEMA7l4=;
        fh=jmFa/+cK6aIrGggya1LX41T2uQNI2gH9+wG8hG612SU=;
        b=GU13WR53u2hJF0ja/q7P903Y4fbpTWs0zGA2IxHKCmFTuwprysGfbGcObxXDi9s3SY
         Fa++HBFVRCPRVckzuL+LLIpo2c2zMxY238XnK6G2R+KJ+L694zv9eOYy6203Q1ETuBIT
         Wlz9sHUQvkJTM2iDWONXZCzoSqx4hWb6z4Ecxy09TlM+zGUgp+NJkctlfwDeQRhh5CMT
         B+zsQQeR/OiZEj134QGRaAwwCwrUaRWrHXDe73m0C4xkScNOzP5F1uUf4ax1cS5Qv1Ty
         FqrI1ZRs9SzHw+IJGOE0wDREl2ix4rualbc14jXY6mXS4DWKWzCYwwkKtShnD1Vp8Xqj
         jrwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633919; x=1771238719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ+zj5yCqVDGCQMDIhhAeFu/f4Yt8z0Q2y0QTEMA7l4=;
        b=WM+EaUYyZNlHnVMFvc8KLlnLdkIKxNOj3VdSS9bxzEAtScI+AloLPiCzsVcuxwxpKe
         g54LDkFlLp0751hM4J9FJ6GOigRx/wTU6k4WPoY7Ho6C2DX4AvlFJC3X3lVG4QRAXRsX
         11tB5rYdu4ec0YqiV9v6XqR+/Ch2Hg1AUi4KiHkXcmzs3GmmlmdZlruDk+FjlG7QvAa3
         8y43YDkXNFsvqpYj+yJaOH7c8UsxnL123uMMTKHlsNwAaKJZltYXWYoTcQ0ohI0BgYiZ
         eDgxVCVCUAri/9iKZCgZpP7GDvjTsaKWuE3WtCUP/4gxrHnznktNjHartgLrKCagEXXX
         ZCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633919; x=1771238719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQ+zj5yCqVDGCQMDIhhAeFu/f4Yt8z0Q2y0QTEMA7l4=;
        b=XQLKTCXkfyNlljwXFWs/wMVZM4PCsXVasGxntTxlKoVrtC4V/AUXhEldURQzQtPFE1
         if97RabF4ItSdns6byou1jX1WUmWvFkUP0ix/lMgx06lchE/w6NbPbsXL4ndBE2FfLX4
         s5oOmPZnH7luWgjIkL5/bZK3dtZsZFO7nNztJIkVFDHBvmIRBpeVMBUJhRRq5OE473Kg
         W2bo6ZXfmBF5dzJ7r4QB9tBIb4XVACwXDaVeZEd36TA7X2eg0naOGryB0tWDfnoUofxn
         mSYt+62RD3965swlaHmOnEr3r8R3cVsW1Z57cB4a+B7+DEpy6aNkg7jbITgPkulEh69b
         UWfg==
X-Forwarded-Encrypted: i=1; AJvYcCUxeb/X69DeSmcdoRMjOo+ywOVtAB5HHctkrytHwI5AxdcODlu/X/FpiVDqV9n5eEgQe+yYo9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZtEXHJeZJMM4ZmD+zqNAn+hfUtceoxGmKx25tPKqMamzuZVX
	+sRf9jsovvayVSu0uWDW6wDswcsSiE/+yzqwGySKlaX/opEaIb6ajblJ6nXLzWciHEQCDDo5KtO
	7nzx77pTKxT8k2YdzXM9d6enWIX7JCb0=
X-Gm-Gg: AZuq6aJPrH0pHfdOktD/jDRXbnkhNQO+ZPqGik4xVBWEeJHAVqZwuw64FghLQ0JL4yj
	yLki0U7ZmlRE5d13BQypn3HKATJX2ZtrY2t4n7r+HPb+8N9KGl8fab52Y1S78lL0pjxVNRDdEp4
	YLB0UV7MPtIEMhHffcensRMk07h5RKezF6KmbEung1DyN4tIQ4bjKb0mI8HB8O1u2ksQmRbf3w1
	UANJ9gOsV/Q1sUmAwZuiCmza1VpwekrTt6k6V3bYawRDqg073DjMklqiYwSUvqxLqQsIYpOfpyQ
	WqIhOLSsVVsDkzWIuXou58iEHpJxWvzAApgkENbFtRQekKl3sB3oLaIOUnu/9LsXDq83So1OT9q
	bSPFSyQSGU8MG
X-Received: by 2002:a05:7300:5794:b0:2ae:605b:d530 with SMTP id
 5a478bee46e88-2b856c56d5fmr2755426eec.6.1770633919351; Mon, 09 Feb 2026
 02:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209093432.17190-2-phasta@kernel.org>
In-Reply-To: <20260209093432.17190-2-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Feb 2026 11:45:06 +0100
X-Gm-Features: AZwV_QiHWqi_ROFSnn_lrcJXExlxQN4kOMphih_9CH-TnKs3N6CI_nQtq6dZh2w
Message-ID: <CANiq72=wQ0o6Rt1kdyn0=VNPEiZ4NTdjt0-URSTkK037zUEvSQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: list: Add unsafe for container_of
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214899-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DA91810E4F1
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 10:34=E2=80=AFAM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> [PATCH v2] rust: list: Add unsafe for container_of

Isn't this v3?

> -                let container =3D $crate::container_of!(
> +                let container =3D unsafe { $crate::container_of!(
>                      links_field, $crate::list::ListLinksSelfPtr<Self, $n=
um>, inner
> -                );
> +                ) };

This one and another one below need a `// SAFETY:` comment -- I
mentioned it in v2:

  https://lore.kernel.org/rust-for-linux/CANiq72md+0Lerj+kqr6QiU6ySR3XjRzmu=
BiLjkpWWieM72wyeQ@mail.gmail.com/

Thanks for fixing the commit message and resending this!

Cheers,
Miguel


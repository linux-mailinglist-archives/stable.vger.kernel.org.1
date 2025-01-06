Return-Path: <stable+bounces-107758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38DBA030D1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C485A7A14FA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68114B94B;
	Mon,  6 Jan 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdfVpMCP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017FBA34
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192511; cv=none; b=XWWg6wwfY0Awm4uPx1+II/fTtpqkUA/nF2UogPf2VKa6Jg6UzTqcTg3t8t9goJnLvokldYQ9xc1ODjGH6GigrBGZLUfmgKuVAdLh70NEJPvTnOXyDENvLvE9n5rnvJ/gDUaLA0ejglDsF5BY1GpgzhllasvRMWkjDmqxltqfLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192511; c=relaxed/simple;
	bh=twWyptULTcLkSehsQFD+iTHl4e4LK1hECGZumDPToNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn9lFB70rD9LpNW+OpPZ7HZNnGIH2dwuSFwwe7DutCKE1D0q4R71tQIuqk9cKrTqLDwd0JWkLzuRTXnj6A9SLNhY2VTbrA2JsEcbpgIxDBn0MLZg9lkAVaaAr0T8pGqxhVhLHF10638o1JxyfBvzTx1ckjUlfTSuvuAKhCaJK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdfVpMCP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f45526dea0so2945349a91.1
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736192510; x=1736797310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJOqsTsaOkpL/4SJIvdzBqE2nkiOG9fRpxVp/sO3wZ0=;
        b=fdfVpMCPVAmUfm6Jh26BxyrEK0ihjgt/fm2QR/TfH84wvAtvFbtAy2KJxw1UIR0jck
         ZhJ2p2MuxhZ7J6JQ3sKC9Cg3fhi3DWEpWwFSvLZcKjn27oG1T021RJgv2UOjJgnSxjj1
         KrKD7sFRyVon+8gHQeIuiTP5ghKddQlaGJ0tVkOeDajnIh/TAC3w6FBds8ULPsjpnKdZ
         IX8eQURSa3nAqTazDQ5WSH7lHjxyScNDeDefy51sE1yPYi1jcz/5LPQh5zXrQTtgnqOF
         lTJy7hzFXLufkcjhS64Ev4JcAL6SpdkSbaPQ2GvrOcHIvG1OUwZRDTpKCYh8WkOWxria
         CfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736192510; x=1736797310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJOqsTsaOkpL/4SJIvdzBqE2nkiOG9fRpxVp/sO3wZ0=;
        b=KrgwEkWM6qkbFqBcyeNgur0Y23p5dF3FE5vtbQ/4YGn4CUosElodYlJGFXpDF6LrNe
         P6VXF42cssfTdbjQcw8LrpvdxuCpmRMPIYTOjoylOM7i63rCKW5xG2Fqd8kTi6niM38A
         SD9QPn9RWCCktR+YGAuzYVBClzEuTu8oM0Thzttsq+mIV7RIb4y06lzfTGHWMiDcgSCt
         xy2+oupR1F3pQL4n4WQFrmGMXOUSu1KUKEHmBduzJGGq8lXC1DeCvXHrUfMGsze7Z0PZ
         hhSSt8Z3aQjn/OAz/Ht6AVvymmkwEDTBcnBXAZsN0cOoAO+vC9X5yzEcA9av30fTsi1z
         TTjw==
X-Gm-Message-State: AOJu0YyL1qG6ZbwY56cDPBYdOTnb8/dLF2X5OICcmvAdcYCb8f+/1SFg
	wOWCZQ6l518jusGVPAEFfsuwwNe4NCYLe2ONOan6Zx0Nzq0g/vwvZOup7vL173REfCzUL1v7lhz
	7xKmm0rE2EJiyFD1qKeyxjfRXb4o=
X-Gm-Gg: ASbGncv4Wvq9IAtQ2MMV2ApqvgycQQg7R1c5CirywjgFQn3ney1MoiBi8eseazvExAz
	XimoOwdVbCmJcP0E7mAaT4fWzLbhVgZ/5gWcIxg==
X-Google-Smtp-Source: AGHT+IGIQ/c46z7ABVvNz3micMxqEy1D7Lszu9Qr3NMZCuaGtumRtZHM2Kq2ESOGWiyNvTBLi83wSLWjsCy7QvuNZIk=
X-Received: by 2002:a17:90a:c884:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f452debc21mr33898293a91.1.1736192509816; Mon, 06 Jan 2025
 11:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151150.585603565@linuxfoundation.org> <20250106151151.253706204@linuxfoundation.org>
In-Reply-To: <20250106151151.253706204@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 Jan 2025 20:41:37 +0100
X-Gm-Features: AbW1kvamIE7sQQgCjP_D-FznednX6MxT3LGEgKrgqq48FMAOJ5ht2LIxceZ0ZKo
Message-ID: <CANiq72mdUv29ufH2iUc=PD3Lhqi9EJOc28yrsZRWbP2p2in42A@mail.gmail.com>
Subject: Re: [PATCH 6.6 017/222] rust: allow `clippy::needless_lifetimes`
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 4:23=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.

This should not be needed (because in 6.6.y the Rust version is
pinned, unlike in 6.12.y), so both Rust-related commits can be
dropped, but they should not hurt either (built-tested).

See https://lore.kernel.org/stable/CANiq72k9A-adJy8uzog_NdrrfLh6+EgHY0kqPcA=
5Y45Hod+OkQ@mail.gmail.com/

Thanks!

Cheers,
Miguel


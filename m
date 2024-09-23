Return-Path: <stable+bounces-76890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5919597E850
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF826280DED
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3E2194A66;
	Mon, 23 Sep 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8/EPNmh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F776194A45
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082907; cv=none; b=YO+z26cqOWzPz03DNNEQomN3mliwH9hgTxdm8k8y/6+Mk05KBgGewEmc53ScfA5FTuIbgDzsVXaer+jpK0HhNm5vPHWFbsI+/9D79/+SJfCVGPxBs9bAZlf3OQtFJMfZG3G+ZOz5SUB6L0XnEDONgNdDTpdSQiPUo2N8kYBqArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082907; c=relaxed/simple;
	bh=vpM1/ppe8/w/bc48g7obGsulWKXsimiE83aP/y0ewLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBnl9IHYXOcckylEBcNxfCBjIEw2yp/dVQBxVqdppPWL1poJyn5oBRCVmNS4h3/xhPGcHRBD1eQ11eHBbksiR30nx+hsdb57mp4ma4nCaODzVyvsnFQpDVfjBnqTjoJbKqsViUxOt1T1A2bKOsvGPoBjz1iEkKtM7jXXaHqiwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8/EPNmh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so23191585e9.3
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727082904; x=1727687704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpM1/ppe8/w/bc48g7obGsulWKXsimiE83aP/y0ewLQ=;
        b=I8/EPNmhGaUZaSU3COsfo/H0l+L6i0dJxoOUrmMVfP6+r4MyOi6nLc8dm4zKorvyLn
         ZHLy55QjsJMmCdZ6JaPscEZuvtbftT6M4RVz+j77+swI537raY+ryt1Cs/CpoIA4u6EO
         T675OUUZFNc5ggSe8iIadERPbB7fbcaJk82xIGW77k2XL/Gkw+t5pTnXYuOjWWjkE6Dd
         8EibbrHrGtVQnc7XhDhexJtR33Eimugt7sFDiEAIyqcjwLk6dr7xTA0R7Q14TdA7G0hV
         2rREVQHMYlH160i7tQ95bVMY57vH4Fb4bbdtUOkfJbX4jdEk2Khjc969vSMQjqRU6Gpu
         lHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082904; x=1727687704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpM1/ppe8/w/bc48g7obGsulWKXsimiE83aP/y0ewLQ=;
        b=MIetsOImk1/cwg8bkiLyxdBKlYcewnXl1mU6eR5OpdXbCPGDK/J2MZCHYtDMa6MHJz
         JAsG78HUHVBsiS/pTcEetjIkmglJuw0aOQaHlAdQgqupFQzoBsxnTWoMpPG1/N7mklVg
         fl0DUPOfRL+iJ2U0XxYW8AIfGe3/V0ndujVcJSBN8NvHuDBuH9a55jdd6hkdWyiAIKMN
         rMYBgi5l7qKUZ3XfAS5HiLMsC211gSXnlZlKOpZvEDt4Uyt6YJu1IkfdDbM7gVD7jRYT
         x2AHEFlfEnQtrsWZea5ifY9hEfese5GqrojQNYZd/m6cUHE8pstKfjjWD8zFBIBoFvCm
         nJZw==
X-Forwarded-Encrypted: i=1; AJvYcCVpYg/T/ruPwyevSKWgnN/DlqA7Rt5Aq0F75/Tm19WdDPe2oxj/1f23MR1RGYoqtZheMzxj0bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpalrzdxuOlvV93D/ypfuBiefSYGTecF6DoOcb3mcHsOZsWS+k
	R/TrT+Xk64htVWkPwVFPoNJZ0v6xPN4Svu2gizCz2DeIjlMYbRJ1saUceiTqaMDEGfVuKqy9olD
	KrHfKreZFU/SuzNImg0mYG0iG1xii1s+8JteR
X-Google-Smtp-Source: AGHT+IFNogOZ10d6lAwRereUdharZqJEJzF8DMsrbOxZ6T/iGtyA5ahCyYkUVrD0jWXnj2O5vwdKizZE4/hyjaxs9i4=
X-Received: by 2002:adf:ea46:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-37a43129148mr6055444f8f.5.1727082904194; Mon, 23 Sep 2024
 02:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com> <20240915163622.5f3365fe.gary@garyguo.net>
In-Reply-To: <20240915163622.5f3365fe.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Sep 2024 11:14:52 +0200
Message-ID: <CAH5fLgigL5muhhWNvYHbGUf+7eZnvfoZkXpUMXQqNeP4sn-6fw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sync: require `T: Sync` for `LockedBy::access`
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 5:36=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sun, 15 Sep 2024 14:41:28 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > The `LockedBy::access` method only requires a shared reference to the
> > owner, so if we have shared access to the `LockedBy` from several
> > threads at once, then two threads could call `access` in parallel and
> > both obtain a shared reference to the inner value. Thus, require that
> > `T: Sync` when calling the `access` method.
> >
> > An alternative is to require `T: Sync` in the `impl Sync for LockedBy`.
> > This patch does not choose that approach as it gives up the ability to
> > use `LockedBy` with `!Sync` types, which is okay as long as you only us=
e
> > `access_mut`.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
> You probably also want to have a Suggested-by to credit Boqun for
> suggesting the current implementation.

That's fine. Miguel can add that when he picks this.

Alice


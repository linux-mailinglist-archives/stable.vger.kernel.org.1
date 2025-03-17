Return-Path: <stable+bounces-124734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FDA65C69
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 19:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89E42082A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D441D8DFB;
	Mon, 17 Mar 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY7Nng9M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8B1B4F1F
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235694; cv=none; b=NmwNJiQ2oK5IAyHXi1c2tgVJuuvpE0Kd1ud4dYIDOEkMYZZGpyNjIyy0Ff61m1l+moEe3Gh+OsiKH0rZ3u04Rke6yxJ/sX9BLQu94TcolznabY2bXmQPgqkBqRW7lPPKHPMS1SAiyLWXdQnjMWNuq2KE7ECpuVJLlrg+x4e25bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235694; c=relaxed/simple;
	bh=dKSg30IkiLDx7ApCCqA3X8bJMJfD3Y8O4OzusAwIbSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cv1Z7SFuJDxTpxac5f0/QJeV728RpOtXowDa9bDeINKZy2iyp11/2zpWs95DAbXEwhT95qO0gvMNKnDiHGXG/k2HzPk9Am/Iawe6CRqFU0jCvB29E8k9NseXUBbYsCgIkEr87iZAtaIWKd04t9vavRlxJjIECQuBFiIXNM5JZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY7Nng9M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225887c7265so8542575ad.0
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235692; x=1742840492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCf6XJNlnq+SDr05a/r+KtNykp6WZKxbM10o5qQm+BY=;
        b=OY7Nng9Mx5w1u/UY5bWydHDBamfxErhNXXVKeuxEZGKkau0P5LrIkqOcYUJ/7ULUgD
         XEf2M6Ku/2MWIfbf4FQqjuqwa2nAlwD8pAxjf2Dph/NgJlSec+zB7FCrl+KDmNdDlAwy
         mqDjM6aR6pEUG3JtqiOBtukLbV8O/3DfbV4umtyZCBFNjg9YhP53dLZSMKwsphAWEBgV
         vzCmqlKz56b2cAk25e/27ozpon1lEajoKPJw0R/WFjBhbXBGnGEFNAFL/TDMyWYrbfVN
         6qAZOr7zK2Qykb+WP4q46uoYTe8Gla3AdRuvhlWQeUq5+RgalIfp8bEiT4sSlPqNOjPP
         dHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235692; x=1742840492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCf6XJNlnq+SDr05a/r+KtNykp6WZKxbM10o5qQm+BY=;
        b=bMCU3Xe1L5NXMSSrQNBpzLwtrpUtLjhuxG6GSgb/7LiKWoQ9CKM3iLX/Iovdl3SGHF
         NHQ2VuLXft00zrpQGkCdJreU9fK7FGVvYoPX4wfkdMvhg7TSnFXcgF1mSrPS+B4Qo5xD
         RHLslKsyUghQRDE4Nk+9uPv+eOWPb3PZzgSxmx0VK0Z33uSa+iVFxL0K1690Hg6cmVW4
         lSfb6ikZvPsGiDQD5MY3R3W/MeZnOpzgY0ix8Ag4XXL8/5PKZ6gu3qH7o8mYXr4BHl5u
         U1qpvEmGy8+E7V3y2JT5mH6O1J/ZKoman3KiDBSw6Aq8l2mywVk3Jc2C3cFpefO9ey44
         8yYw==
X-Forwarded-Encrypted: i=1; AJvYcCXu34+t/bWjklZxgBPJm4bBB8YrHW3TWaT3XVCyWliucHWoEFUDUtv3QWVP5is6hml+kSkUADY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhcS9TArxGMg1s4gif7CQa/ozeO3hMRzJWwpiLX5Gty5GSIGpM
	gpmgovr8sBg8YW9y5cofuh3f76s1QtePsMLhghxpOpQVhVKZpb+JQGElNO55FX2UyR7mlosGUOz
	CKD9A1I809r6wBGWAN7PecBQmXHc=
X-Gm-Gg: ASbGncsDNQacPKDNNYdyb3eHXYDMgtJoN1rRRm0rRRtY95wQcZ8iy5/cwhNw8r01VIL
	A7eeNmukdv3I/ZEA3aXZASPshtVLwYsaPvVbIrykn+tmTpLc87vpzH3iBDKtELTVEQtIx7rxOGX
	p/fQm2s1TFvbcH5qqsrXhmEXd0HCGX4LUI1FlR
X-Google-Smtp-Source: AGHT+IEgMP3dp0Msa7Kwow/9osyhuB17MrvZg0OdBbJEunhPD7BMP7fjnZKVXd2CxHHl5tNn/AoS3w0F3QY14DKQyac=
X-Received: by 2002:a17:903:2f86:b0:223:28a8:610b with SMTP id
 d9443c01a7336-225e0b19542mr57519125ad.14.1742235691828; Mon, 17 Mar 2025
 11:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025031635-resent-sniff-676f@gregkh> <20250316160935.2407908-1-ojeda@kernel.org>
 <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com> <2025031624-nuttiness-diabetic-eaad@gregkh>
In-Reply-To: <2025031624-nuttiness-diabetic-eaad@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Mar 2025 19:21:18 +0100
X-Gm-Features: AQ5f1JpzO-gmhWw563f4QKc_NB65Oy-EAW_R-GdCEbHqk3Li4LM0fanJ9cURRzo
Message-ID: <CANiq72m9EcxPcaJ0M9Wb9HVjLEi+g2r59WR8=H7F+ikgQeYGHA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<Box<T>>`
To: Greg KH <greg@kroah.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 5:33=E2=80=AFPM Greg KH <greg@kroah.com> wrote:
>
> In the future, sure, that would help.  Don't worry about it this time.

Sounds good, thanks!

In stable-rc I see the original title/message used, is that expected?

Cheers,
Miguel


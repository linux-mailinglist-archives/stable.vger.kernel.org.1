Return-Path: <stable+bounces-112248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F1A27D44
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 22:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBFF164245
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116A21A453;
	Tue,  4 Feb 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+Sjb0qN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276725A62C
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704298; cv=none; b=ZRoZQQHWFDpV5sh+PggbGHsS/X75Vy8XDCvdgPqPfrfbYd2X817+fBFWj3aJoE46GPhfjNzLwzVY3GuJ5qfYqSts8/YrT/SyqdutYjqMjJog1Qw6vEFOE4rK9pjHiZPpJqppWQlvrP4BOI9PBDTUtPfVBkj+kOaeNWKGma2D0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704298; c=relaxed/simple;
	bh=2AWpnrYrNHj2sP7cC9h0IfT7AMwOkKkVEyH205HhNSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIteaItBzD6IMjT1qTnWmlgLeeFj6M1DS7sWGyIKaniATmJEWzVw4hqkKTZLkiog2o1u5yHrS2jC96/KKu9D71vRvYDxi6OZaKFhpelqxOHI/pEjNJxNEn0nK+Iclx7di6vYHEq1AuMNUFvvIehll442Ur4UHgn2JOSr1n5YeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+Sjb0qN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401e6efffcso6448738e87.3
        for <stable@vger.kernel.org>; Tue, 04 Feb 2025 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738704295; x=1739309095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AWpnrYrNHj2sP7cC9h0IfT7AMwOkKkVEyH205HhNSQ=;
        b=t+Sjb0qN5uBpNHeGjF2wL2uiZ3pldfsPbhq0iN5thd88N9f42Gw6ttUzFDJ9CY6fUj
         uQnrXqIZFcY3c1XgxtLVfmeckXBDHsAVbsqjSCHS48BZM0/BzaLizdFCIEvVb2ADX10k
         SqBqY/o1LiQB6wPNZYaNr8TDkflMmbXapNLMd3jTlmxHfcIpy7w6pd27ETnGhWh653Kf
         wuCm7CPqQNl/9sji9locGZ8aL05hsaUwBM7QxqET7r4JgGSYyns5Euf+mrSvurfcxnMU
         7pkWYI2DyKGbAQ7fG7gVF5O6mBLsBX3SDKsuA2WuOjCaultaZrQy9s0XtYFCRpoJA3qd
         5Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738704295; x=1739309095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AWpnrYrNHj2sP7cC9h0IfT7AMwOkKkVEyH205HhNSQ=;
        b=TqEhK0RRNvVjVvLGSAyHAX02T1uL7IIC1trFJ+/kXHGgsoQuACfTdWMVknxJRH4iPw
         Xug7BEdfWihW7Sgh+/JhOpoq1GaZM3sFyDfOku7wiB7INyReLFL4H5bvd8yEmCEtl+qt
         EMziayfWfuykfhFSUAVuN+a1Uk6P+i4JZlT2qa+5uE49oVQ8VrO9VbjOQwDKrseejWQ2
         mKCvxN7VcjVsjS8Um6TDMJ9Gt16RKWKoQuNxUoQX1lTiujDTftx9eEyCLlQlvrNgLWHe
         7FE6SGXpUTHwNpV6FY4j1aTIWhdA3k5Op1l3at3xGRbG05kUJV0Tg2Qi8RCHaqll1a+B
         g5sA==
X-Forwarded-Encrypted: i=1; AJvYcCUPRkdD2T4xp+u5OjbmdQqMnUSjsWRS4UB1iltNiskrpj/Mk5gXtXKiwKG1MCIHSruTYWX9nNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbaZHVkbKGStB9is9nsg4YcJ3gDTFlaNRtZKQReooqzHwSAXGO
	Gvl8GCJjVfFc8BT5SFgrUu6N3Bs/GaQafb49/giFc9ELNHMGYNbJOvhIXPeRQN2NBo1cjWyXM79
	JeQRYa6Qd9LLFNTbEOP5LGUT9eI0uVsbLtEfO
X-Gm-Gg: ASbGncsQnR+8qImXJZ9OcmPPH6KNaTKl2DwnoavPEJZjw1QH75TvLt2FYI5vcoH4V9Q
	6S+9lY0RZGhxTKHeuOEs1QZVH3cBH6uVkFzCPNMhC6gLl+ykhQ2kOOdiuBH0RrSRnE3nZcgYfhP
	+PjhXGYlyVDr0oXbrIUb7/ErEj7Q==
X-Google-Smtp-Source: AGHT+IGd4aAXqz/1BqDq/4Q+rkC64LjvxH1f4R23RO+wjwMcvjRycIEs4NTLvG0m93uM0MeMy+OUKcL2M6QJQUrjNRo=
X-Received: by 2002:a05:6512:401b:b0:540:2257:22ab with SMTP id
 2adb3069b0e04-54405a2e152mr85528e87.27.1738704294770; Tue, 04 Feb 2025
 13:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
 <2025020118-flap-sandblast-6a48@gregkh> <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
 <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>
 <2025020432-stiffen-expire-30bd@gregkh> <2025020423-paycheck-strength-75ff@gregkh>
In-Reply-To: <2025020423-paycheck-strength-75ff@gregkh>
From: Daniel Rosenberg <drosen@google.com>
Date: Tue, 4 Feb 2025 13:24:43 -0800
X-Gm-Features: AWEUYZkc-57RQWkDiyDqyjPM_4WcNvEH9GJRlTVIpP7spqK4QyDnjgw56aZgwQ0
Message-ID: <CA+PiJmS2tgroaF-BYTzUbSUrwCwSKN4XYgtr-jX99cbF0QveQg@mail.gmail.com>
Subject: Re: f2fs: Introduce linear search for dentries
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Todd Kjos <tkjos@google.com>, stable <stable@vger.kernel.org>, 
	Android Kernel Team <kernel-team@android.com>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:33=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> It also does not apply cleanly to 5.4.y and 5.10.y so can we get
> backports for that sent here?
>
> thanks,
>
> greg k-h

So, looking at that branch, the conflict involves the patch that
introduces casefolding and encryption, which is the main case that
breaks this. Without encrypted casefolding, fsck is able to correct
the issue. So it looks like that patch is not needed on 5.4.y and
5.10.y


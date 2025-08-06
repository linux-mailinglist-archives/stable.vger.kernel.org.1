Return-Path: <stable+bounces-166734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D558FB1CB94
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E030217D355
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B29A5CDF1;
	Wed,  6 Aug 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aRdL/JCe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78351B960
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503392; cv=none; b=K6fbzo9nAwNOgD6CdyFxpFxw6TCUt4WnKbq9L0fNJ2ZvlSUZVCoAKOQbHrqhgKpThVy2DBN+GTbF9jBSynDr3huLtY7viq2zbInAk9bDBtQK+xe/1fj4k8uCwCqCDn9MUa6r1HBk10+gLSsxL6WbQBQPGDK5GiOo7Nvd9+4Gg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503392; c=relaxed/simple;
	bh=E5n12EFC4Vs1rlUtBdBREXHzy56Zf6VwAt95CHcrKUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGJe83FhaLf1uWIj0nN/szUZoW1ac7B/j4Ecwr/xBFGgSv/5jnUftkNoyqNXDH/L48CxYB3pY6dQk9r7cDnskbSwstUYgqeZmr1RbVcvNoWrAtS2BT+dGqb65B/3zIM+LcuvYwVK1COpfXgIFgsH1u19GRmQTnMrXki2raYZThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aRdL/JCe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso347877a12.0
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754503387; x=1755108187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3RnG4sPLAep3hOZrSLQRmIeRs3v2sTb621dP3wMjE08=;
        b=aRdL/JCeMHZbmG9ALHEdcOjjlCGfcJDJcswFD5ooNMVjhPUeavUzikYpqGL6oukI22
         jo6pGC7Qyuv5FgFlML+RUQlbgXQkbi6vslJybNHAZ+CAu5CLP6eInErE11BeDJEZcPDe
         8LAgN5y2fyFH6iSPBmgFiS9FJprzEzgnAV/wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754503387; x=1755108187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RnG4sPLAep3hOZrSLQRmIeRs3v2sTb621dP3wMjE08=;
        b=aXQ8R4boZXWrnNaffd5HyPpNrMATrEGtiz6H0g/Ek4j3JugU6lebNvQz72YyHkHP2v
         2m3blCMWfeQZVnYJeXMvftodxnexX90a3XfB8ZGAq/M58qZh5xN3A7NtTyKAvLUnaIqQ
         9lhVLv2KR0wwI4HT+mTm7fV7J12fRkOwT0CyByOBAgSAC+qhITXmzJuyFb3Ooy3ZCdB9
         /0Eg9E4HP24kIhuVY7mMOdLfW0IbsBoMYbQzBb8+lq4Co3u8xazb1R4C3+em3l65x4tb
         OYRmYSk7rNsJt7h69DMmfeTV9ueNAPgMgie1dDHUEY1R5hsYd2t5iwmyVrZNwW12e7hU
         4THA==
X-Gm-Message-State: AOJu0YxYhkav1NZaYSGJ2jKrIeomBFZaK/sumqC+EfCWW8a71QSLEKuq
	5OWP+Hl219yY1dM94nAGo37syNBhbgSguBHESPyGfpliQlBFQT26LTD95+bgxzSVZPc5b0hA9zh
	8tAU4YysyEw==
X-Gm-Gg: ASbGncvRwcbeRX5ycVQk7ixjEeHU5XUhYsv/KBpp7HmVEuTwaj272ogbQ9v70qaxHmA
	UIoI3L9Xg9uVqOD9/ov2RJ32r+0/nligj0GNMZzVnZgyyOSk3DSf9X8/XjQRsPK7eXsB5Xrj7Hj
	uFJqUopKfb1aASzrT2X0ZL/kE2sLhk55DbKLhhZ7my9sWp9xlzm0coEZ1RkQMzfA8xBXVRBuXzU
	0v/EmEW6XKmKttBypsDm+kk+uow0q+/IOeD9wchb4i3QJHCZTjXr5g7fbG2OhkXpG7R+00UhR/Y
	VIv948TOaimqZU5TV7vFnSl4LYhXLjMYKll4CT1m0h6aa+TofUuXLdzY37zWKOPSqfVvwyZYJ3M
	m6Awbecj84I39+qNIxfQUVy/Ow3djLtA6yjp0ZXQY9iuRo0dF4F+Grc3bLuObqrrRj1unQv+C
X-Google-Smtp-Source: AGHT+IFnJiFVQ/nmClkQIRkRVJz9EYj4owgliYBA7kdvpyu3rjttfARhqUSKDxV0yrIrgGNtIB36TA==
X-Received: by 2002:a05:6402:2695:b0:612:a77e:1816 with SMTP id 4fb4d7f45d1cf-61795fb56b2mr2711340a12.0.1754503387054;
        Wed, 06 Aug 2025 11:03:07 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe79a0sm10547722a12.39.2025.08.06.11.03.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 11:03:05 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61557997574so215156a12.3
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 11:03:05 -0700 (PDT)
X-Received: by 2002:a05:6402:84a:b0:617:6472:3a41 with SMTP id
 4fb4d7f45d1cf-617afbe8680mr791439a12.10.1754503384585; Wed, 06 Aug 2025
 11:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 21:02:47 +0300
X-Gmail-Original-Message-ID: <CAHk-=wgW5WRN_Ar9hC_TVTxg=hh=1T0gW27ecPtOFORCWb4ffw@mail.gmail.com>
X-Gm-Features: Ac12FXzKtNzvkT9iuWSmZFDGpYaH4tg4MAuFwlQT1vYLkYg4zh4eYKvh2YaiolM
Message-ID: <CAHk-=wgW5WRN_Ar9hC_TVTxg=hh=1T0gW27ecPtOFORCWb4ffw@mail.gmail.com>
Subject: Re: [PATCH 6.6 v2 0/7] x86: fix user address masking non-canonical
To: Jimmy Tran <jtoantran@google.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, David Laight <david.laight@aculab.com>, 
	Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 19:20, Jimmy Tran <jtoantran@google.com> wrote:
>
> This is v2 of my series to backport the critical security fix,
> identified as CVE-2020-12965 ("Transient Execution of Non-Canonical Accesses"),
> to the 6.6.y stable kernel tree.
>  [...]
> I am ready to implement the second proposed solution if the
> maintainers wish to move forward in that direction, understanding the
> testing implications. Please let me know your preference.

I do think this bigger - but more straightforward - backport is likely
the simplest and safest thing, and it looks fine to me.

          Linus


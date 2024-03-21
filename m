Return-Path: <stable+bounces-28561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C2885B0D
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 15:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73611C2147C
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48D84FBE;
	Thu, 21 Mar 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hv5Y/Mlt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14384A5A
	for <stable@vger.kernel.org>; Thu, 21 Mar 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032216; cv=none; b=NISttcVwLzVCxnq8kvnTV0YOLAfZLxGQvK2Tqhf6AQCE5NG6J02UMCZyVp6RsHh+LlaNXbrh2c9i+noou5vSPLyGUg8tcmWD5+nujWUU3FUvzP2NpUWMg0KwgzkyyqPZneHbGWSJG6fZ7cKoe7FW7Eij8FnzZHR0tuhW0vp2Ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032216; c=relaxed/simple;
	bh=/D28luKO4+fyZRSYkzsSDtWc+iksLHsvoDCEYnwnTXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSZ0bNJX7McWf/6zdVrXPPsuYHUnT6jb59N2gOCSHmh6E3uO6NMljggIr639ToY2CPw70DVIh5slsKSK8CxWGbp0JBL3yGIzoOWlwMrT0jB9XFRwcTXt0F00RvVTrP/CpEvn7XQ1R5IjbD5E0mFfdyPSIr+yKjR/rSOYKYk8z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hv5Y/Mlt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41428b378b9so81845e9.1
        for <stable@vger.kernel.org>; Thu, 21 Mar 2024 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711032213; x=1711637013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/D28luKO4+fyZRSYkzsSDtWc+iksLHsvoDCEYnwnTXg=;
        b=Hv5Y/MltE+elCaGrdW2CFzfyZy7O3O/b8C87XGJuc6+M0zsFKwNSXbtnCBGkxwwzne
         tFF3zuWEQMVgXJmYjJrs+7DqVlpnvn4T1bGHYQuhHbHjV6WEyF0eBHTCmguwSYhjuet7
         PUtHMtWUvIZgp7S0mSofVaDGFRzjjdV8uS5dCS6nrqyuJ8T2lIiikXQ1cC5ZqfVcND3r
         9ewMFyroKo+pNS41nWZd1yZkVDodZv+B5gMhcppejyWUqPhfH4FT/e88tRaI3STJxpBO
         priy478fh6tfNFhZetTcLvA8GveKGbp8sBdNc4JVne8N4sV+645J9oVsUQiMudrclawo
         gvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032213; x=1711637013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/D28luKO4+fyZRSYkzsSDtWc+iksLHsvoDCEYnwnTXg=;
        b=ZmoxJ/+lYWCwEw/RMMzsnGaucMIhxDvXoYdUoDLZtxkFjiGxnEJg1YlRix5ZJVcS9S
         LkMTksbChZuMqyV82ha6JLq4vylFvrDlZR4HcXiD4MJyP647BBaVHdN9AUpwYQaYy0RI
         oHZORFE0dU29uMRNoYkb4giGOQOynNN7SKgujLJGT07ytMTdNZijcCkaxmkra3ddXsxA
         Hm7KLsYMMboGpbTrPu66McepLLub2neT93X4qrOf5XePxWCSspRzbRJ4yFVQlbOklGFW
         9eYEO3+gKnSV1N7RVeh6BQFxuPX+cFBWFqgl0oYamzdh9rX8OAeOzuqVFJyUTpe61zLQ
         ZxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/P+tUNsORt8mt9iMRXjodbpYsnC7sjNg/7gf8Hxw/7FuTdBJB6m9PPSW6Dws1Ynlz+EtoIVM1VZQujyFPoU1AG85pGD8j
X-Gm-Message-State: AOJu0Yy4TNMwlnMIqWpOzXoxeCqZjjNZwjwleXIjN0wpnB/yiR4t35/l
	/zAeQQl1S1O6b4dK65zBFSX1XRC4rWcmEBo3b7X6vmKSHvfG2b5clyKQw8TCHyat/qdUjBtnd0h
	+D9+r/w/4I/ZxMm22idw0ho6lh5DudMfBbrIsSwgAsiPc05gCG5WC
X-Google-Smtp-Source: AGHT+IHnrzU4oucfhBLl6rdWusfmGBuKU2FAwDwrqL/zW5LP5tQFnHqv1UHWVy4naHflA0A3yOMpuY5i7pnie4PGdpo=
X-Received: by 2002:a7b:c850:0:b0:414:1ee:f375 with SMTP id
 c16-20020a7bc850000000b0041401eef375mr234376wml.0.1711032212914; Thu, 21 Mar
 2024 07:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+eDQTFQ45nWGmctp-CkK=xXXQQHc_DTkM1iN4m-0o5fCjt8VA@mail.gmail.com>
In-Reply-To: <CA+eDQTFQ45nWGmctp-CkK=xXXQQHc_DTkM1iN4m-0o5fCjt8VA@mail.gmail.com>
From: Ted Brandston <tbrandston@google.com>
Date: Thu, 21 Mar 2024 10:43:05 -0400
Message-ID: <CA+eDQTEiRyddZYwmyX3q+1bBgFRQydC++i4DDbiQ+zC-j72FVQ@mail.gmail.com>
Subject: Re: efivarfs fixes without the commit being fixed in 6.1 and 6.6
 (resending without html)
To: ardb@kernel.org, linux-efi@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org
Cc: Jiao Zhou <jiaozhou@google.com>, Nicholas Bishop <nicholasbishop@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, this is my first time posting to a kernel list (third try, finally
figured out the html-free -- sorry for the noise).

I noticed that in the 6.6 kernel there's a fix commit from Ard [1] but
not the commit it's fixing ("efivarfs: Add uid/gid mount options").
Same thing in 6.1 [2]. The commit being fixed doesn't appear until 6.7
[3].

I'm not familiar with this code so it's unclear to me if this might
cause problems, but I figured I should point it out.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/efivarfs/super.c?h=linux-6.6.y&id=48be1364dd387e375e1274b76af986cb8747be2c
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.1.y
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.7.y

Thanks!


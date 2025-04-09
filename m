Return-Path: <stable+bounces-131870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE9A819C6
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 02:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F6446B88
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 00:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D79BE67;
	Wed,  9 Apr 2025 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bix6uS7m"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10821EC5
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157716; cv=none; b=UUF1yc2iOS/aOBQjjt0ye/7eGq3Fq/j84stPJyjpXZfiNKIwBfATKWVKdOEsPnMk/YU1WpqptZhfX6+eydvVpe0CA1UrUe85a38r8Op9cWNO6Vo21bpTxS1wg7eNGvTyvovI5XkRMThlidPwyiKS5/Cvi0Mn05mSEu/qOV++a3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157716; c=relaxed/simple;
	bh=kzUr1f5PApCyyaQsNWZA+8T6s6ncUwpR5rXya9vt64M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbsHWin7Oy8pc99+F2PeR6BmzcByF/HyaTYtpkfbEZmVBcw5oFOrl0iaTLK1tZ+3zsbrVXKyGq9wM72af5cC0PayEwc+rccoCVRN3u5lY7kNwLYVvNQ4OehFhwU+Q+w3qtj1HlnD90UD4XmsHjwKSjHzM8oQ9pNiSQnIyCsV1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bix6uS7m; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2aeada833so42767066b.0
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744157712; x=1744762512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7RB+y2EUGP8TtBqM/TIRDMB8wrdZCpt37v8TqudoNA=;
        b=Bix6uS7mmnHJCuU2P0aApB761XAuX7fKx6/FMPhFrzK/nNUkxSHKtu/iWoMcZXUSf9
         XvZsThwa1kkGqyVqT9L7hrUOjifgOJJNu/wLYc6hGt0PQrki4/YRtK5LvVvOg9k0Cs3e
         PSpyJZKECvFDOVjvWMACI+P3+6dpqGdgy998Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744157712; x=1744762512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7RB+y2EUGP8TtBqM/TIRDMB8wrdZCpt37v8TqudoNA=;
        b=gFsZiv+BmHGgLc3K4EAcbNofllFLg6o5DnV+CNcX5TD5lIfrjED+mSaSeolIBXMtlL
         LABSiQNnCcsP2LPvzIKlqpMRN0e/8R5jJs5eufaudrDA+1lSdyXtyn3eEKOhDMH0eJo0
         4cIspsHWU2osN3Fqwnk/wxNJS601VKWr9lXAB7zRvdZ4iWKh+WvYucL32VjcqP1LtJiQ
         9dBkl5bNB1l7qKB+83ZuL8U+FE3Houh/WnWvW56gUykpKbws/NEJDpYZG+paSJukgmGh
         K5jV2YYLnOEokZP66AfDb8YjmJ5GEjs3VwTG4pAjEn80n0iYfonr5Sr3Dg4WQHZwqiNI
         DkCA==
X-Forwarded-Encrypted: i=1; AJvYcCW1/96aGj19/L5AHHNdDWp35E8wzdPloS1dvYarHGvEtc2pn7D3IJ0aTgWhDtjc4MzshNqtzgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoqmFsY1FVxm49BGF7rtyHuAKqWxqKuADwqB/QyImUnXlcn/GG
	QhFmAnU5OoBQnLBSFoROTvMV2lo5gf6GSTbCqyBRvUP1tK0yliEWWcdgERUEtHeTc3t/HDud6Rk
	mxt4=
X-Gm-Gg: ASbGncson2+qevSBYi2QbI7UlltgSomYTt7KzxoebXVnPcza0MbB5HA7sRtt5zr+MQj
	sznzNa9ZHC8xzh/+UWJ653RE8EFv5wakfD4pz1d8PczxjjO2DoWbPJOfdEOTqfCPQEeUbObl3Hr
	BSWZX7LWMLinJpweLfG0ttyzqQ9sk5bzs7sk5zBuh8LcLJ1W5JmUy1LTT/hJm/0JjTyFUoJhrzv
	j1U4hyDGsxs3djYjp7bB9gVFPFnV206/i9JkhreNHDc3snMycj55dJt7zGhjCFj+9fdb8RzrU0w
	H0iPF7FDtAADH2QWT6PxCNRVSCB0sJxlHKzNVnCMt6ASw6nEpVi+KHSxk1Q3CzMfd5Lqs5ExfPN
	0XfStqqSxtdOxeaptK8g=
X-Google-Smtp-Source: AGHT+IFolJGDR7Fc392ZY/6rtBRchU8xioUdvqNI+S1HIg4ApeU8Fz4Jt9GzVwdC86jH9DRupbKKRA==
X-Received: by 2002:a17:907:2d88:b0:ac7:e4a6:20e4 with SMTP id a640c23a62f3a-aca9c0d8b65mr56502666b.19.1744157712156;
        Tue, 08 Apr 2025 17:15:12 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013fda7sm992288366b.117.2025.04.08.17.15.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 17:15:11 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac7bd86f637so40888466b.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 17:15:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEuDRIY3gS81tDiIeEQQ4YaKlFtLBknomLrIuD0iw2t3sdwv7gOuhx4s4CLtIA57cRlebHEXA=@vger.kernel.org
X-Received: by 2002:a17:907:97ca:b0:ac3:ef17:f6f0 with SMTP id
 a640c23a62f3a-aca9bfb0d37mr81837666b.5.1744157710814; Tue, 08 Apr 2025
 17:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-fno-builtin-wcslen-v1-1-6775ce759b15@kernel.org> <202504081632.00837E7921@keescook>
In-Reply-To: <202504081632.00837E7921@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Apr 2025 17:14:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiN62aoWPkgRutvjKpxbXJdvgNNY0DqDc=9_r5FGUjfNA@mail.gmail.com>
X-Gm-Features: ATxdqUEzxdv_c924M2x5edBsLVmXTsnFzfYKX1p8a7EiZ3toGIQu_4WxIx108FY
Message-ID: <CAHk-=wiN62aoWPkgRutvjKpxbXJdvgNNY0DqDc=9_r5FGUjfNA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add '-fno-builtin-wcslen'
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Apr 2025 at 16:33, Kees Cook <kees@kernel.org> wrote:
> Since I have stuff queued for -rc2, do you want me to snag this too?

Well, since I felt so strongly about this one, I already took it...

           Linus


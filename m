Return-Path: <stable+bounces-139419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF160AA6767
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 01:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896751B63454
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 23:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25326773F;
	Thu,  1 May 2025 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HFEnWQ3d"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B657264F9A
	for <stable@vger.kernel.org>; Thu,  1 May 2025 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142128; cv=none; b=gZjQs8/u8ouqEF8PdRBVGUXJ+TBoVR9HsESYU7q60QmdSssOvtggtEL4ERSB9tJjKJIC7qwv0YbNf+D1gsZjVPx4uZELrPH4DGOs/tZS6ZW7CX6yE0fruIG4PnThB8hV2tqiOIhAfRQEtIw/d6LAN7qm6yYxDr1Rj5p0jIsw7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142128; c=relaxed/simple;
	bh=TVZv1wE6IMiopn+lPutQ2XmVSkz9PSPheYWfp32DhNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8XrbIWONEoIs4YH8Rkj9UJmHN2SGc0ZGebwcU/6RTPrBtMcK85w0AurvlD6I/M24dfoX2elDJ3DWmpB0i80xwsJjTTxlZzsZKWLquOVbDsKVKwJvA8V6jJc1Q3PLJts1ODPvgfG7MRdRV7J3rF3FlJMX9CEEdpEh224gzxRdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HFEnWQ3d; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso307219866b.0
        for <stable@vger.kernel.org>; Thu, 01 May 2025 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1746142123; x=1746746923; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xLQxE0ZAajilS9LJlCgVNxjKesNL8CM31Y1I/hwFDe0=;
        b=HFEnWQ3dTrBoBoQnzlnvnkinODrYusBOjLGDe+16Y/s1S21J6fUvekTcDz/eNx/yL/
         HP7fTlfynB7jVfgKdtRZMA4Plq+UARfdwUdqPuYFbchi9BJd+RP4B483S1IU6Dxh9vTf
         W4YSZwH2gXjnyGgsESP5spJ9gL7rfl4PWsNlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142123; x=1746746923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLQxE0ZAajilS9LJlCgVNxjKesNL8CM31Y1I/hwFDe0=;
        b=Lbwjl49PS9+ipX+aEpcxn/YqWL8SHoMGypvkt1io4xl0JDMz1DTJ2gmdxJMdk4p77t
         9FhKrxXunl0ddR5SRpx2+amsjBaF/jEXr8xCerBtFCOne6rgembOXUkVyqY33v4Pf0Sg
         bXVLSfv13/3x6DIrGRMitDRJFEV+OHHobULZ0pVWg1WLuxjgxkAele0pe3iHectrdeFc
         jVg7s+76YjyPWRqiAc7B5OrFdNyHIQkHtBzugmlhWy9CIrezoU3UgSbFqmeUAUd1EY8T
         7htx95/d4/2HPfE8yVa6DyG5fxjtlb0vtuqKRiQDRZbm/c9Un9Mkz1/m1f8aewq41rFh
         wVkA==
X-Forwarded-Encrypted: i=1; AJvYcCVZCmXyqq3u7r3uGdc+aiNxU6YF1ie7TVnuk9P95obnOuPIrcXW5U8PRDMyhh1aeSNSXfz8mBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lSgBB8hcvqbiLMArK0Ad98LqekmdFPOq9kNtJS0g5K1HzapD
	bCLUjCKsA1PMTfGX6ESNIOrXcAgcCNp/wUy8b1NzbZnqcCzsepYfUBE1Hu6IyIkhqIrDfOUvwbl
	+QJo=
X-Gm-Gg: ASbGnctud+eSQOOIVoOQNeGdD+RcBYbKyoZa+quWwq6e7JiaZ6mNvJK67tFM6RtPKTF
	8bHWQda33gycbkJQosuRRgM3dlElHbEdDXn6Z677FyDAwyWndcYOoSAWSDWD3R5ntYLOW3qey4V
	6qNgmAktCRsTYkxN0rLdd8NT1vriaWpZKA1eRSVC7y633HsiBk81/5tjwwX12f07oxayeZKU+nx
	Wm7IdyXzODk8Apnhrt8bqp/TkXjNskK15xf7+XDmmw1cyeN6hB1KnJWkUVA3Zqx1j/ytRWYoDeV
	mWLBn44C5yacTDmbjWX7qmlg8o9N5AY2WYZ1mtYQqT7ttNO1zx8EsQREPpTsXRBhhUppMXLA2zE
	ldGawnoN1I+RJRo0lpIFYEsUs/w==
X-Google-Smtp-Source: AGHT+IFDXLW05aMYAHdQKJYhBdqiBksv2gRtpFjHJUZlr/mvc0qqgPXq5un77dHgRL5ZQABzy36ibw==
X-Received: by 2002:a17:907:3c92:b0:ace:c225:c723 with SMTP id a640c23a62f3a-ad17ad1a245mr89147466b.12.1746142123280;
        Thu, 01 May 2025 16:28:43 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad0c70ef85dsm109906266b.42.2025.05.01.16.28.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 16:28:41 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso221672266b.1
        for <stable@vger.kernel.org>; Thu, 01 May 2025 16:28:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnkcDU/RSqOIfytB3G1F8gQAGBQBw9Z5EFtXskj8sVfM4eObo/sRe0TrZfw5Ni29CD3lt3BJU=@vger.kernel.org
X-Received: by 2002:a17:907:86ab:b0:ac1:df32:ac27 with SMTP id
 a640c23a62f3a-ad17afb8ab0mr88710966b.53.1746142121345; Thu, 01 May 2025
 16:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-default-const-init-clang-v1-0-3d2c6c185dbb@kernel.org> <20250501-default-const-init-clang-v1-2-3d2c6c185dbb@kernel.org>
In-Reply-To: <20250501-default-const-init-clang-v1-2-3d2c6c185dbb@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 May 2025 16:28:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL8rmneKbrXpccouEN1LYDtEX3L6xTr20rkn7O_XT4uw@mail.gmail.com>
X-Gm-Features: ATxdqUGTUyHgnV_iTiKt6DDkeUKklvk9V4X7Te2h_qX7brrmy-_kNjuWcrlAGLY
Message-ID: <CAHk-=whL8rmneKbrXpccouEN1LYDtEX3L6xTr20rkn7O_XT4uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] include/linux/typecheck.h: Zero initialize dummy variables
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
	stable@vger.kernel.org, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Marcus Seyfarth <m.seyfarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 16:00, Nathan Chancellor <nathan@kernel.org> wrote:
>
> +({     type __dummy = {}; \
> +       typeof(x) __dummy2 = {}; \

I'm actually surprised that this doesn't cause warnings in itself.

The types in question are not necessarily compound types, and can be
simple types like 'int'.

The fact that you can write

       int x = {};

without the compiler screaming bloody murder about that insanity blows
my mind, but it does seem to be valid C (*).

How long has that been valid? Because this is certainly new to the
kernel, and sparse does complain about this initializer.

So honestly, this will just cause endless sparse warnings instead. I
think disabling this warning for now is likely the right thing to do.

                Linus

(*) Yes, the empty initializer is new in C23, but we've used that in
the kernel for non-scalar objects for a long time.


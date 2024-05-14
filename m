Return-Path: <stable+bounces-45112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DFE8C5DDC
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 00:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1380C282C03
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 22:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0E182C82;
	Tue, 14 May 2024 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EU402y/J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39E17F378
	for <stable@vger.kernel.org>; Tue, 14 May 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726934; cv=none; b=rvae3WH0QHHHHKIc2iuralqpqU3BEzrnh8BMeNOJtyJkGON7z4yzD+B3lGAxuDqD5XuDzaf9bsHP1rRQzDbP9I+Shb+5lsuC9K7Mu6P4IhUPbbcHFQlH55RXDlPr0TJ/6rk9RlU7SF9DtR0eJ9M3HgNhWxNwcyVAic4uHRnY+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726934; c=relaxed/simple;
	bh=0nhAafwxI5HWL8JnwaWyPULuU+OENNhkR2+xS32Iz2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzPzCJJsAZJYPjYAzDNigGuC1sMvGQ0vgpgLGmzG5NPvbEmskoqZwpPMhBbfiGP8hFGG3E3OKKJXF/doWivOV6ycy0a3qRCLOSCHYzTJgn6KL3MWcDyuOcVPnc9SCeZhYXnS6YoSy2kgedzmycRbpyZe72hO3i5oBPUGOBycGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EU402y/J; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so5181117a12.1
        for <stable@vger.kernel.org>; Tue, 14 May 2024 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715726933; x=1716331733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUJPFVJdz44IFmC7tap3c4+RPSoDFQyAX7g5ibPkXFE=;
        b=EU402y/JKIyMJuAB2SE8tcVmdT2F5hPBKtJyOcXjOKjuC0bi1A+jvE3BTYF8SihD33
         bOUs8cLbHJSVey7GGLQdKIevzMcEEmYsXn4AHOZiahg7p5gbWoEcA54SWJCXn2s/4NPK
         0VwFCmJ2fNMkhgpbb9l81RK2iAZ2l7dgAPs0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715726933; x=1716331733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUJPFVJdz44IFmC7tap3c4+RPSoDFQyAX7g5ibPkXFE=;
        b=IyKRv4lmCr2Sg2UsPA2DiVXm9kyXghL0qHx9Bak4QMPP+PkBLQHzVpg/RGeEXow29l
         U9yCnFTabNavICDkJQWYb9o2TSIQg+YMo+p9cPx/wrvdu6l9VKo2tTz6KsFkaeN4RMZq
         IImThdiOmKeTIJYBtK8RAXyS9x/QgIJB////XSNCBZBvAbLIaRakMhLcjou9MdbJ4fIb
         J4ahWPpUrMf9i9yhmPy7e93Yi66rH1eO1uebdI65cZn4OXJtZcFdqGVRCyIQfg15nZ0X
         LjQuhzOeeQd0x6slSK8A0eAhBdd8C7Ecgxqkz4eHDPiOPkSr6h61rO21VaAd9AK1hKCl
         KN2w==
X-Forwarded-Encrypted: i=1; AJvYcCUOFG4Ys3xbJBHgW++D30tluZNcjm4mQvF5Lvp+drIoAWAcaeiXENwV9zdk82Wu4fgCOcYt8B+ErwIsJc+iuv9vFdn7FHRo
X-Gm-Message-State: AOJu0YyEV6YorWRidcOY1OGrpUUTIbecrNqrdmFQcIQ/FzhNY07kjMpw
	oE3xee3phHrcpTla24HthDDedXBeRDNws6RAwdPeuzupFebfbOUguwEdFMD1bg==
X-Google-Smtp-Source: AGHT+IGU9RLXGa4w3EJiT/EMc0/Mkh53TeXUez1pHBLj1KnUfvY+4gA+rMJz4t5enAU3FThgSiFSvw==
X-Received: by 2002:a05:6a20:244b:b0:1af:dd56:76f0 with SMTP id adf61e73a8af0-1afde0b7407mr22397136637.22.1715726932891;
        Tue, 14 May 2024 15:48:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a6327besm8838766a12.6.2024.05.14.15.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 15:48:52 -0700 (PDT)
Date: Tue, 14 May 2024 15:48:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] locking/atomic: fix trivial typo in comment
Message-ID: <202405141548.E76E681@keescook>
References: <20240514224625.3280818-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514224625.3280818-1-cmllamas@google.com>

On Tue, May 14, 2024 at 10:46:03PM +0000, Carlos Llamas wrote:
> For atomic_sub_and_test() the @i parameter is the value to subtract, not
> add. Fix the kerneldoc comment accordingly.
> 
> Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


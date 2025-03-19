Return-Path: <stable+bounces-125598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE5BA697C6
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 19:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF9C4800D1
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0820B20D;
	Wed, 19 Mar 2025 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SO+my/8i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8A205E36
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407938; cv=none; b=LvKD6Hofx/BoL8tqnKQvW6drJkCluxrNk/z7co742vWl15GZge+I0DdikN4P+wb5LvXVt2zmG85m8O23mwLtfWMWeXm/H5W+upIS3TeyKoPddGtEl4/1jwzQOGCxmta8pMm91DEKUVqV6UPXm/MBbWwJj1CHWx1fqwDeMtPCwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407938; c=relaxed/simple;
	bh=fFeqEDSx+gFrh11ijFVYJhwWlYSMde/JsajtuuK8bvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY2HLvyCSf3NmmjyupnxuP11rTxMJlRqWCTa/rn4l+PoLw3Ag5Wp1Z1Vh+l5+90yWrgJ7YWEwgsNm0ZRgGX3+Xarr//cLSmKcx2p1T9Hn/UzCa58yYIhvYA4bFvnQP1NepohYYaP0Gk7GCgp390fSdqEBzrquHSHQWPB1BjVLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SO+my/8i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so12919547a12.1
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742407935; x=1743012735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtsDpMKG3PVh8c/2wdkRvEAKIrMwiuW7c09tD+wzsRQ=;
        b=SO+my/8iQC8Sry5gW8ScLtTJKz1xPXEWyhJqAmZk6pqTd7ZwdCTM1TQFPBDiePS1d+
         T2u39Hctl8SR4BwtPK1xiHhBW8z3V4hBhIxnOdJ3qzOGK1nSPhn5TIYUixr6dvEsh2bx
         WQPpNR+W3NXEtmu93UpOmsRDn0+jGh5+nwijw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407935; x=1743012735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtsDpMKG3PVh8c/2wdkRvEAKIrMwiuW7c09tD+wzsRQ=;
        b=exHZvvlvNHuaXuB+19PcSab20akDjc74LABdb2APVtwmY6WefV35Vviyr8Zc/zhuoo
         T6MVeS5KhUi4/J+motaFTJ6MFmRHl8RBTKuFuBn0k1bj3qIcRPDHIjtTiCmP7TmSYKV3
         Zm2IfKGYtcpM0VS3AGlpETAb08oeS6D6/jgBcdJjJqKQboniL4pGNwt5x7eIBIYbtjsW
         m2XOfHlxSAq1m86OLtbXr+JD66PgTrr+kqrOhtCzYRnBGuq5gb37mSgcF1WsD89yUe1f
         cHUAsy903OczyFjUg9/1yEWruEv6tZp9XgyfLG8WTcySLoSbqnYDxKymDhzMY+/vjVFN
         iung==
X-Forwarded-Encrypted: i=1; AJvYcCUYqy/1OBVnwF9tZ1XbRs4JapMAsKstGm5bmcveHlOBYCEzzEpwPifSYPfPetgsYwNUf7npiRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPQXVnt18bDjPv26oLSfSA4WwuqkIsH3EqJ3cs/TJzKl+yE0h
	tc9uLISKJtoJyLeTMr9CXWGu/j8wYr0Fm6J+q1W3tecSNAScG5nAEWLZq5cisBMwM5KFHN7SW0m
	8Sf8=
X-Gm-Gg: ASbGncu+wC7vKAO+zqbK+5EZR8MTorIoYZOcpk9Po5n2iOLHY6YYpGH5TC/NeNFPiji
	TPfDogCPD0s8jFPJPLlhMkYQfflrLqIHDnF7c6eEGjviEoRZ8RyUwEyAYodKCKQjE459NCgSOD1
	tMmcJa/jj/cA5LdbQp5VHN+DvXuV6nSgFgykfd5D8OXeNzE/Lpup9DUAwEy71cfCHJHrQJRMqHi
	zXDXU0XIraYvgMXs3gzhs7cAqhg0onaT47B7nL+1wJ3WjZ/IN68cj5+az0dQf05JMTtNQ7Y56qK
	z1uRq/hIPSrsOa0PieY43nZsCeM4I+GLxpYFMDGZ77qiJiOYyVtRw0fLFuOkgoLYyIcZL1/WZ0K
	0fKdhA5YPjhjDDGMPGg==
X-Google-Smtp-Source: AGHT+IELlNBT3dcNXWdc7MHK87XIUhlngCIzsa9wnCjSOQo8G+eQwa5/jiD1E1RgFV6emBbo1WqnxQ==
X-Received: by 2002:a05:6402:348b:b0:5e4:a88a:64e with SMTP id 4fb4d7f45d1cf-5eb80cdc9d9mr4220457a12.5.1742407934623;
        Wed, 19 Mar 2025 11:12:14 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968ce3sm9426107a12.21.2025.03.19.11.12.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 11:12:13 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7430e27b2so164874766b.3
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 11:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVd697TTVv2ofoaDqNhc+34Rv4oXH/Z/mtMUc1RdqRFdPPGBhZZyVQYkFUZGC85ub/ElvlIYec=@vger.kernel.org
X-Received: by 2002:a17:907:ec0d:b0:ac3:bd68:24e4 with SMTP id
 a640c23a62f3a-ac3bd6830damr446966766b.53.1742407933026; Wed, 19 Mar 2025
 11:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2874581.1742399866@warthog.procyon.org.uk> <20250319163038.GD26879@redhat.com>
In-Reply-To: <20250319163038.GD26879@redhat.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 19 Mar 2025 11:11:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqidLD38wYUw-5Y6ztFdAvkX3P+Gv2=K+rpkFBG-bf7g@mail.gmail.com>
X-Gm-Features: AQ5f1JrIwulbm3bCXYePiRgtmwvEUEXDiL2TRjJKyWZ4_ecrDX73K-AxzmDTtIE
Message-ID: <CAHk-=wgqidLD38wYUw-5Y6ztFdAvkX3P+Gv2=K+rpkFBG-bf7g@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Fix UAF in key_put()
To: Oleg Nesterov <oleg@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Josh Drake <josh@delphoslabs.com>, 
	Suraj Sonawane <surajsonawane0215@gmail.com>, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, security@kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 09:31, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Can't resist, smp_mb__before_atomic() should equally work,
> but this doesn't really matter, please forget.

We really should have "test_bit_acquire()" and "set_bit_release()".

Well, we do have the test_bit_acquire().

We just don't have the set_bit side, because we only have the bit
clearing version (and it's called "clear_bit_unlock()" for historical
reasons).

Annoying.

             Linus


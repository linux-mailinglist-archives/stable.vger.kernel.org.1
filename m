Return-Path: <stable+bounces-121359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D09A564E6
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 11:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268633AA10D
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB301FFC70;
	Fri,  7 Mar 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9MWVwyE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA92063FD
	for <stable@vger.kernel.org>; Fri,  7 Mar 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342591; cv=none; b=c68UVaV/4pUFx3KYpQdYW1gnovk6D58Mh2faeaCzQxYuhZJ8UUYba9a5VzXFsaabXeJ3WrzFcMbNPVbA6QdCdmyI2h8kddKFOtBen/CKGAZ6zsUOqFzYtwAw9xto0VYdfVe+3YaoTy0m1S3AAwD9txfBF1bb9fwhpwACl/C2hkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342591; c=relaxed/simple;
	bh=gq98LUzZEsk2yxTmc8tqwmrgX8fpMLkdULxpsH/S7Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9g6bo8UPQljZul8nLzTjbMjhdKm5U6YfKq5/dNaJVXbe5V85gCnpg3MZdn62L8D6G8L7R6Vea9k0eB/dZyK36Uy+h8SEMQ6QmJJhd1Ru2mVw/zJ8+eUZxXv9i78j2BkrZE0pq2I+NJH4b26fXR/2qqoH9gOf1nBcZ0s7XmBQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9MWVwyE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bcc85ba13so12957185e9.0
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 02:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741342588; x=1741947388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QSuS9bPe5UhUC+Md9FsoGNTVMWoRjNLRcpEqLWSHYd4=;
        b=Z9MWVwyEIHknouDTa7MMgoS8J8xgXW7nmwKjXzkmeFNKoK9XxZSKlFBzhzt76Di4Cq
         zN+q6b9cUZsRCixEbt/YTh+KdrWgiUXL+yC6ao3QuavrxaPRLealF5vTJ+31+8ikTPOq
         a4qPKjokYy8ol0bbSgdTFbq7+7bb7bUef5iBCfHb2Oe1z5TzvK6TxxOnE6bHPtlvrDM6
         CKGQici6vBF2rGwNJU4zMImsz1Je+EQbK0aR1NLIlzSxSj3ya1K5tXcnwKPh7l5XQs4L
         MM9VtBntHHnaq1oMCejsAxGpnLmDnjZA4vIjfOuVIb8BXj+61xhQBjfftZmZs4pYFl9a
         uIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342588; x=1741947388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSuS9bPe5UhUC+Md9FsoGNTVMWoRjNLRcpEqLWSHYd4=;
        b=p/Zd2VNzkYs52fwD3vEoAbhJvx+WrJ9m5cyvvpLWkJx0ySQjn0B3MzBypGuZj1ahHO
         YFgj2nDK4j5J5OCV9M6laHNyaDaoaQeJYVs/q4xjusBi9t9m8vYXVljCfWZgixU1EGC4
         66aR9fpiOKmjWJ/cPOTxyteLG/sDC6R9l4GS7aExsKY3z8ackjavM/vEVsJScZxVJM//
         fFcbxPfpL4jDdT0wjRVFNfjDnbe0NkrR+EcUQwyFkQ/dcc932ig0KNZcEeE1wuEp5/86
         n4kux4oofrFpXLn9ucJpu6MT7iZS1m8zTOPYyi3PRobSMzzUU14OCLildurJ5qSOsklT
         CuJw==
X-Gm-Message-State: AOJu0Yz/PIVKXBEewXv/2vPPjUlcYaixMA8QqLH1C27uvQNwg71A2yJE
	wt+sXHXzr1fV0IPc++v8USzGg+l1/2CgX/tAa0EPr8GMziVuEvN0
X-Gm-Gg: ASbGncu42hFs8MxhNHmT80ey1q/bJCgngVFB8/Ra9ljW0DcE4N+9W7h8xyMsE4zBJWh
	9ctCIyCCcZu8C5irPYAYb+HTaTOUHSANbLxKyQ0InzB8hCZuL+Wqk3MMBmoU3QG/OL1gaH/D63/
	lfodT+bkA+RwQTNGcmpi/nvbjfhI9PDh2/m+jqoJZEbQzEVhtqsirmMzMtH5trJ4AvNcXMAs9np
	hx44gewyKfTOJSNgGbSKVAZmX45LXD2IcgmHaj8mAWt1HMjg0btyjy/Gw7+uMU7FHi8+T2UbjrC
	NgFv66KtrWEuHFpp3dSjPQNx3y0IUBj5g/9yQWm+2Ie40g==
X-Google-Smtp-Source: AGHT+IHOiQkD5BTHhwg3nQBnlUOZI7pfk5rpJzpHBQIKMR4tMA/4ocwfz4TCDyKnK7MjTer4k7Ar+w==
X-Received: by 2002:a5d:47cc:0:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-39132db8b3cmr2001025f8f.43.1741342587883;
        Fri, 07 Mar 2025 02:16:27 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:a201:48ff:95d2:7dab:ae81])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e2f39sm4797294f8f.80.2025.03.07.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:16:27 -0800 (PST)
Date: Fri, 7 Mar 2025 11:16:21 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jared Finder <jared@finder.org>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] tty: Require CAP_SYS_ADMIN for all usages of
 TIOCL_SELMOUSEREPORT
Message-ID: <20250307.9339126c0c96@gnoack.org>
References: <491f3df9de6593df8e70dbe77614b026@finder.org>
 <20250223205449.7432-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250223205449.7432-2-gnoack3000@gmail.com>

On Sun, Feb 23, 2025 at 09:54:50PM +0100, Günther Noack wrote:
> This requirement was overeagerly loosened in commit 2f83e38a095f
> ("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN"), but as
> it turns out,
> 
>   (1) the logic I implemented there was inconsistent (apologies!),
> 
>   (2) TIOCL_SELMOUSEREPORT might actually be a small security risk
>       after all, and
> 
>   (3) TIOCL_SELMOUSEREPORT is only meant to be used by the mouse
>       daemon (GPM or Consolation), which runs as CAP_SYS_ADMIN
>       already.


Greg and Jared: Friendly ping on this patch.

Could you please have a look if you can find the time?



To maybe explain in an overview again why this is safe:

The TIOCLINUX ioctl has various subcommands (uapi/linux/tiocl.h),
and one of these has in turn more subcommands.  The structure is:

* TIOCLINUX, with "subcodes":
  * TIOCL_SETSEL, with "selection modes":
    * TIOCL_SELCHAR
    * TIOCL_SELWORD
    * TIOCL_SELLINE
    * TIOCL_SELPOINTER
    * TIOCL_SELCLEAR
    * TIOCL_SELMOUSEREPORT
  * TIOCL_PASTESEL
  * TIOCL_SELLOADLUT
  * ...

While securing TIOCLINUX, we restricted access to various subcommands
with CAP_SYS_ADMIN, but permitted different subcommands.

This table gives an overview of which TIOCL_SETSEL subcommands
required CAP_SYS_ADMIN at which point in time:

                          point in time
  TIOCL_SETSEL sel_mode | 0 | 1 | 2 | 3
  ----------------------|---|---|---|---
  TIOCL_SELCHAR         |   | x | x | x
  TIOCL_SELWORD         |   | x | x | x 
  TIOCL_SELLINE         |   | x | x | x 
  TIOCL_SELPOINTER      |   | x |   |
  TIOCL_SELCLEAR        |   | x |   | 
  TIOCL_SELMOUSEREPORT  |   | x | ? | x  <-- This is the change

  "x" means "requires CAP_SYS_ADMIN"
  "?" means "inconsistently requires CAP_SYS_ADMIN"

The points in time are:

 (0) before we required CAP_SYS_ADMIN on TIOCLINUX subcommands
 (1) after commit 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste subcommands")
 (2) after commit 2f83e38a095f ("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
")
 (3) after this patch ("tty: Require CAP_SYS_ADMIN for all usages of TIOCL_SELMOUSEREPORT")

This patch **reverts the behaviour for TIOCL_SELMOUSEREPORT back to
what it was in phase (1)** after commit 8d1b43f6a6df ("tty: Restrict
access to TIOCLINUX' copy-and-paste subcommands").  We have double
checked this in Emacs and GPM's source code earlier in this mail
thread [1] and have confidence that this is better, because:

 (a) TIOCL_SELMOUSEREPORT can maybe be abused after all,
 (b) it is not required for Emacs as we thought in patch (2)
 (c) the behavior I implemented in patch (2) was accidentally
     inconsistent

Again, apologies for the pointless back-and-forth on this fix, but it
will be better after this iteration.  I hope that this summary helps
in the review.  Please let me know if you have further questions.

Thanks,
–Günther

[1] https://lore.kernel.org/all/491f3df9de6593df8e70dbe77614b026@finder.org/



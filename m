Return-Path: <stable+bounces-180585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B8B86FCF
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 23:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E95281C6
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654A2BE02B;
	Thu, 18 Sep 2025 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBnuifSp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97C801
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229271; cv=none; b=qGZ9ZCXvJpsce9EfEoR1u+mebBXCBC2RN5sbX+V6ja5fXyBsJfs1E/+6pg2tN//UHtKNNfOFMGZ+8kVEsOpuVeWoAVIQhBMQJDsJ5VoGG7ElquBeTLhxsWz2No6g+bK5bpH7ZuHvtExyan6dF2F4Tb8fw0GWWMyCsqcO3Yp+oxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229271; c=relaxed/simple;
	bh=Y0aRlCDI5j7/xTKlaqyzsS75nTjo7oTyY2BP/Z6h+kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ul8jaPuwshROefPuDQQGzimU7x9MpDvC6bUXOWY6Q0odcHIGBLw76KMZnyzz/c7eBVxYgLcibVRkwP9luMZGcned7wnvyzBuLFhxuJfPZNSa2OCKW7BuPXHaSsrgw+7WN8OVm0JNIw4/PhRHHxZxQNbhQeMc8MPNS41y87sX7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBnuifSp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so9776585e9.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758229268; x=1758834068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8whsQSi0AUPF/mAlaYBaLE5rrzm7bWRBeC6D7X3U3TU=;
        b=XBnuifSpk3ERatLsXf9I1n3d+weXBrk//nbzYl2YvWKXW0boogqe/YfRJxT9iK0cCQ
         pW3L0MEYfi0l5pq0NzCFTPjuVrroW9a6NwqZZYgU0r3Y4Gl+T0FvX7V7IjY/hnoLOxo7
         qNdJtHRVcjQJydbAn8ym0HKYMssZf0NXeZ6g9M9cUHCldzh0puIyQFzpss68UCKUg+By
         EMxp2ZE0XUQmBAtW0WXxQKaVGTr6yVBBSj9bbFtEsO1x8nt5PLSvNuRt7Is/2FHKrXze
         kKFcNdytcjzZwbyPEirg+RIXA9KcIlwMEfQ++2ktTVQ5GSvMJBABt4csX5dqr4msPgDu
         iRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229268; x=1758834068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8whsQSi0AUPF/mAlaYBaLE5rrzm7bWRBeC6D7X3U3TU=;
        b=nZjNWlCe7G5pnDJYu6XiVqlAfmNBCy59gkwVsaYS+MfD49Kl3gXLuIFnkEU+4ioT0n
         IqbKpJ9K5MKIqEDsZXA1AWFK/lPH9V9EJQFtxuK7cZz6jQmluHnIBMcbsrvt4AxHgS7C
         +d7FjvDNUzE5ph5pwI0LhxA87omEJCnhJoocOOksE5OZHGadfr198QLt6aZrVBeuVOrf
         3mH8eOp05q15UU2NnxHq8yIaeyzdbwypkJ8Yd2Du9ttPO/ziA4Z5vqncZOcPQbroZFNy
         y9xOZ0mQGyvD7wjX0VfJkZudUnT8f/enDks1Ljiweq70ExqkrFBpkkTIAILtI4l8OgtV
         nYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYKB/Iq4iaXu3277SWGQ5PeaHkrEMpU0sZz9FmuUM/awL7bE8mKOTyzxzSrCcnc7FsTZvAhsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjB0m06k9+F/vmsdyZX3DkQXLUm+jWDGUAuzGk0wsCGVk44rZB
	Xx/EYxuxqxgWhthciBTFomp66dk6OCqGAMfpDVxoqSQX30Mm4mX1ZHHs
X-Gm-Gg: ASbGnctWfHq3ZuJgJ5khB0LuZNuGh86GDenMYQ/7Roim/EPjKRbIczCWqd5/1IowqZj
	SQpXNM9bwopFvRn1P5Jl1fxd2Sz4t/oT9y+23Bm0Vqb4p6TPQTBtGyvsJqxO4Xi8UgElWHXczvA
	3kwXYFPlIyW47Iq5obULBsYk90lVbU3UKsn9TychvL3lUfQyzCn2r9apYePEONSRiKIHrhLE1Wo
	lDZFQpfCuw65OSq/DEChu/AukoWwX9/xodz5YuYo5EqG49B+w0OWX7ZjJ3cVptnVdZcYAJJi1r9
	aHlJcZPfT0Euz4hdHVCcPBqOnFic8aE17gAsQOzumFBEDPKUTHVUO/TdsapMs+Jjt8HmbfJ+802
	l7RtEtCJewm2+deiAjCnUtBn7KmU7Cstyjsa/Iw4kTR9h6XzG1pLb9V7XzwvWjiBpvZRXwfmfz4
	6bi1o=
X-Google-Smtp-Source: AGHT+IH/ADFhHy8Bccvk6S8WFFJzSRKrYkHXLYxTkOPeKEac1vyUf8zwVY5kJnjDYe07TnRqWgVkmQ==
X-Received: by 2002:a05:600c:4588:b0:45b:7be1:be1f with SMTP id 5b1f17b1804b1-467eb325534mr3872295e9.32.1758229267977;
        Thu, 18 Sep 2025 14:01:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46706f755b1sm24361325e9.11.2025.09.18.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:01:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 22:01:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eliav Farber <farbere@amazon.com>
Cc: <luc.vanoostenryck@gmail.com>, <rostedt@goodmis.org>,
 <mingo@redhat.com>, <akpm@linux-foundation.org>,
 <gregkh@linuxfoundation.org>, <sj@kernel.org>, <David.Laight@ACULAB.COM>,
 <Jason@zx2c4.com>, <andriy.shevchenko@linux.intel.com>,
 <bvanassche@acm.org>, <keescook@chromium.org>,
 <linux-sparse@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jonnyc@amazon.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/7 5.10.y] Cherry pick of minmax.h commits from 5.15.y
Message-ID: <20250918220106.75a8191b@pumpkin>
In-Reply-To: <20250916212259.48517-1-farbere@amazon.com>
References: <20250916212259.48517-1-farbere@amazon.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 21:22:52 +0000
Eliav Farber <farbere@amazon.com> wrote:

> This series backports seven commits from v5.15.y that update minmax.h
> and related code:
> 
>  - ed6e37e30826 ("tracing: Define the is_signed_type() macro once")
>  - 998f03984e25 ("minmax: sanity check constant bounds when clamping")
>  - d470787b25e6 ("minmax: clamp more efficiently by avoiding extra
>    comparison")
>  - 1c2ee5bc9f11 ("minmax: fix header inclusions")
>  - d53b5d862acd ("minmax: allow min()/max()/clamp() if the arguments
>    have the same signedness.")
>  - 7ed91c5560df ("minmax: allow comparisons of 'int' against 'unsigned
>    char/short'")
>  - 22f7794ef5a3 ("minmax: relax check to allow comparison between
>    unsigned arguments and signed constants")

I think you need to pick up the later changes (from Linus) as well.
Without them nested min() and max() can generate very long lines from
the pre-processor (tens of megabytes) that cause very slow and/or
failing compilations on 32bit and other memory-limited systems.

There are a few other changes needed at the same time.
The current min() and max() can't be used in a few places because
they aren't 'constant enough' with constant arguments.

	David


> 
> The main motivation is commit d53b5d862acd, which removes the strict
> type check in min()/max() when both arguments have the same signedness.
> Without this, kernel 5.10 builds can emit warnings that become build
> failures when -Werror is used.
> 
> Additionally, commit ed6e37e30826 from tracing is required as a
> dependency; without it, compilation fails.
> 
> Andy Shevchenko (1):
>   minmax: fix header inclusions
> 
> Bart Van Assche (1):
>   tracing: Define the is_signed_type() macro once
> 
> David Laight (3):
>   minmax: allow min()/max()/clamp() if the arguments have the same
>     signedness.
>   minmax: allow comparisons of 'int' against 'unsigned char/short'
>   minmax: relax check to allow comparison between unsigned arguments and
>     signed constants
> 
> Jason A. Donenfeld (2):
>   minmax: sanity check constant bounds when clamping
>   minmax: clamp more efficiently by avoiding extra comparison
> 
>  include/linux/compiler.h     |  6 +++
>  include/linux/minmax.h       | 89 ++++++++++++++++++++++++++----------
>  include/linux/overflow.h     |  1 -
>  include/linux/trace_events.h |  2 -
>  4 files changed, 70 insertions(+), 28 deletions(-)
> 



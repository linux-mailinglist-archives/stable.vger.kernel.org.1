Return-Path: <stable+bounces-146222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EECAC2B40
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 23:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CEE4E7A4F
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 21:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0971F5852;
	Fri, 23 May 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1rxmZJC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F427482;
	Fri, 23 May 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748034863; cv=none; b=KGB4j4S7yJuXrNlIXahESvW3JS3Xqt/BA6W2H1f73beUbtbx7Yg9ICE5VTEdwUeQSLu9mxuATga0hk+/QnHnRcYy4YWJeTrkUHz56o2LQAELl9CCo5jBLQUVKF9BHjVt98cExL81gfX4TcC8/GjfNg6tM4LPXY+KNe0GS1tliME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748034863; c=relaxed/simple;
	bh=hMNht2ITzVXRMNNi8WKcH1SnXd5YaalUM0z6OlrAXCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjQ/9p8p2MwkArWBBdmvhiVLz3TRvfprbUs78Of3mY9VPlbISiHmzbGdF3Cjhi3/PkZ1ODLagkEh0k4OgDgEOdtPQgvm6yig1k+hhXW52YfnDw0PEXjboBlAuw3w93SFcbMINMz5+lJPdxyBfky6XyOcCLdKpTNRZUss0HW+BFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1rxmZJC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so2256115e9.1;
        Fri, 23 May 2025 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748034860; x=1748639660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4M15ENUe5F7Tt92onDS6a+eZzL9Ufa/rc3FCe0HiWM=;
        b=R1rxmZJC95gMJPjWyipx3KPfJFTkV0p1B/pRpvfT333LBPgLUBCZYVya2hZEu61tZf
         dV8Zpe8+7U9exn4oN8B3RPRKfQfPuywoSZ0ycsrDsA8qo/xKW5YC81O4Q3USQhPybb58
         xphqqvFuChK4iEbl9t+BWmWmOiNyt8uG2Ei7Uo1hRfGyggvSSFAnUXpdebGBbxNeQkwV
         UBvmd5/5wS6WENNb8FoZ78GhRPQIxeiyGxHN+kTo/Jv5jFs8ED9EKEdG6RmflxLkCZ+v
         LJd7sFKr6TH1qKNAywB621qjcGgkXySKJy5uuS08uLap/bfH3TrYWXg9sCYUdegtYwhn
         txFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748034860; x=1748639660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4M15ENUe5F7Tt92onDS6a+eZzL9Ufa/rc3FCe0HiWM=;
        b=MFDLicjgyfFmt2SWRXG4pBgf+aG47ZQjPv6G5pE++oKs+iU3JCO9N1lx/etJL5xFOG
         m//Wf6yelVbb2/q7QALlOsgn2SOljz1pE2g5CfrBCSoH32ZO+LjKD17Ha0kHT5JRKd/U
         1FxUrifwmSDpi8mG/RUXamxKUSJMeDz+JET23uWbUq17inDdgFkKydIg2WcLxZnw4+rZ
         I70+xLKE5DBbIKKWXeMdftoawnJIlLIQA0SzynLGWtoIPw6Sn5j8o0KCkrsNsKbfUYWe
         eEDdqs1CUlEXVnS40LVJ+fUXHEUbkC0UuvhX2gBVb8IRD9uBcomhvEM12mcKrdc+1yXb
         TcGg==
X-Forwarded-Encrypted: i=1; AJvYcCVrYtA7bHxpIR0j3ik0OWMIGbb3Gy2tZYMZcOoE+Bwz6yJ51EqCIEVbqiDOXxhl9X5efJGDN6ZG@vger.kernel.org, AJvYcCW6trIVFaI7nFUyL5WDyMC6LLfA9nvscguT39l1gOBWyH60Bvk9NJUpCHdNn9LoiTuxk9Sr7UWvhknw0fQ=@vger.kernel.org, AJvYcCXhnuHCmnJZOjLJhMwKa4AANBnA9KaCbPUutmPEsKHSHJ7W2YYEns4sSbY+SMDFDKvlC2zRqPN/@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBlm3RWoLIYIryYRtAx2BOZeIUGkg1AMIm2JjBSI4cv1bARmI
	cuLa8y8RT/WEHE93YcvVMmwASFiV4QpI8T9n5NxiXwhaXcftlBbWaPcY
X-Gm-Gg: ASbGnctW9cpYcNPCN3woWhjExbm5t42SBhzdVL6m/GUe49j5qIy9Dmo8RXhcZFrLIWe
	RS2nCfKElynRWweRBsegjvEKu8OwfGIIA6C8WpYrPw2VLIwueDpeF0XFMQpcKHywBIWFASoIA6J
	Jjcs3G3Q1buGhyhc/H9ocKmVw8DCQlYRQiVU1dnuHtjin2YdmlNPd6WDQDz8r9NcQ+bFR/1u/Ks
	3227ecmljBaBp4+2IB94bLq4mpIJPZ7aqxIkXjL/JkF1NBU0K2rRXSV/X30IOCKikMmHWO7AdIK
	nGAz/2Qf/4m24B6BAeSSpQQgc2/d/kVTUb5wBeNV2/SQpDK8NK1fILJwFe7x9MFaE1TjNySWwAN
	+en5N+Y0GZKCelQ==
X-Google-Smtp-Source: AGHT+IGPNXHgQPH+t+a7zbToFCeMprVY77XgSiiZZCtrK9j88dVi9oyzaAIdoyF9y6RBaUSD5DnDSw==
X-Received: by 2002:a05:600c:5286:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-44c91ad6c06mr4338205e9.7.1748034859750;
        Fri, 23 May 2025 14:14:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d25b8sm160122845e9.17.2025.05.23.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 14:14:19 -0700 (PDT)
Date: Fri, 23 May 2025 22:14:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Christian Brauner <brauner@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@canonical.com>, Jens Axboe <axboe@kernel.dk>, Sasha
 Levin <sashal@kernel.org>, Michal Luczaj <mhal@rbox.co>, Rao Shoaib
 <Rao.Shoaib@oracle.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v6.1 05/27] af_unix: Replace BUG_ON() with
 WARN_ON_ONCE().
Message-ID: <20250523221418.6de8c601@pumpkin>
In-Reply-To: <20250521152920.1116756-6-lee@kernel.org>
References: <20250521152920.1116756-1-lee@kernel.org>
	<20250521152920.1116756-6-lee@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 16:27:04 +0100
Lee Jones <lee@kernel.org> wrote:

> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [ Upstream commit d0f6dc26346863e1f4a23117f5468614e54df064 ]
> 
> This is a prep patch for the last patch in this series so that
> checkpatch will not warn about BUG_ON().

Does any of this actually make any sense?
Either the BUG_ON() should be just deleted because it can't happen
(or doesn't matter) or there should be an error path.
Blindly replacing with WARN_ON_ONCE() can't be right.

The last change (repeated here)
>  	if (u) {
> -		BUG_ON(!u->inflight);
> -		BUG_ON(list_empty(&u->link));
> +		WARN_ON_ONCE(!u->inflight);
> +		WARN_ON_ONCE(list_empty(&u->link));
>  
>  		u->inflight--;
>  		if (!u->inflight)
is clearly just plain wrong.
If 'inflight' is zero then 'decrementing' it to ~0 is just going
to 'crash and burn' very badly not much later on.

	David

> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Jens Axboe <axboe@kernel.dk>
> Link: https://lore.kernel.org/r/20240129190435.57228-2-kuniyu@amazon.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit d0f6dc26346863e1f4a23117f5468614e54df064)
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  net/unix/garbage.c | 8 ++++----
>  net/unix/scm.c     | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 2934d7b68036..7eeaac165e85 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -145,7 +145,7 @@ static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
>  			/* An embryo cannot be in-flight, so it's safe
>  			 * to use the list link.
>  			 */
> -			BUG_ON(!list_empty(&u->link));
> +			WARN_ON_ONCE(!list_empty(&u->link));
>  			list_add_tail(&u->link, &embryos);
>  		}
>  		spin_unlock(&x->sk_receive_queue.lock);
> @@ -224,8 +224,8 @@ static void __unix_gc(struct work_struct *work)
>  
>  		total_refs = file_count(sk->sk_socket->file);
>  
> -		BUG_ON(!u->inflight);
> -		BUG_ON(total_refs < u->inflight);
> +		WARN_ON_ONCE(!u->inflight);
> +		WARN_ON_ONCE(total_refs < u->inflight);
>  		if (total_refs == u->inflight) {
>  			list_move_tail(&u->link, &gc_candidates);
>  			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
> @@ -318,7 +318,7 @@ static void __unix_gc(struct work_struct *work)
>  		list_move_tail(&u->link, &gc_inflight_list);
>  
>  	/* All candidates should have been detached by now. */
> -	BUG_ON(!list_empty(&gc_candidates));
> +	WARN_ON_ONCE(!list_empty(&gc_candidates));
>  
>  	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
>  	WRITE_ONCE(gc_in_progress, false);
> diff --git a/net/unix/scm.c b/net/unix/scm.c
> index 693817a31ad8..6f446dd2deed 100644
> --- a/net/unix/scm.c
> +++ b/net/unix/scm.c
> @@ -50,10 +50,10 @@ void unix_inflight(struct user_struct *user, struct file *fp)
>  
>  	if (u) {
>  		if (!u->inflight) {
> -			BUG_ON(!list_empty(&u->link));
> +			WARN_ON_ONCE(!list_empty(&u->link));
>  			list_add_tail(&u->link, &gc_inflight_list);
>  		} else {
> -			BUG_ON(list_empty(&u->link));
> +			WARN_ON_ONCE(list_empty(&u->link));
>  		}
>  		u->inflight++;
>  		/* Paired with READ_ONCE() in wait_for_unix_gc() */
> @@ -70,8 +70,8 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
>  	spin_lock(&unix_gc_lock);
>  



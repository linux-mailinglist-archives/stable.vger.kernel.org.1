Return-Path: <stable+bounces-254285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGYhCrBpFWrgUwcAu9opvQ
	(envelope-from <stable+bounces-254285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:36:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2EF5D371A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEFE43048932
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5113D3319;
	Tue, 26 May 2026 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk5w4p22"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7193B6377
	for <stable@vger.kernel.org>; Tue, 26 May 2026 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787868; cv=none; b=bJj7DuUETwlH4ApakmNY3B8ulbvLGg/hBcz/uYBButOThT9ALeSZhHn4t7sCnC+rrryd780YpgfrMqo9OXNvQIc5Z6Zhcg191hTC1qJPYEFfAwYkRRoQR4+E8J7nuB93ymw5qvyG+5loxMyhfEfB0BV31CNC/2K6lrTTw0njr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787868; c=relaxed/simple;
	bh=uvz/kgTUH5nCjt/wXXr7H3t+qy4vkWiuM6wRqHR4LwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQUxicdINpLbp9ZNZSwS5Y6el72BZxRBNagK9Lqt2V5okpZoLIutJgZZisLX4NW/W3bLy6ng78T4SLawlkbLsgbw1iLUieUfNtbrrK+yp6RZFNyT+f/tny30qkhfkh92cGv4CZ8oYd0OAOvKizhOUT4gBP27EMJaYvDWGswUuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk5w4p22; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49068493267so12820645e9.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787865; x=1780392665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhyGEGziB4p1he7Kr6BJJdkSVJk+rI4Mohkv26Jk0G8=;
        b=fk5w4p22H469kjTbAqXGPjbdafQqqIhAKUOmSuq0hdyM6mOLidAfdQduJ5hmt1nn8s
         Zn36+AYkcwj2+Zy616X6CLrIN72cQlp0J8bcyETDBA3rkXfu0KfxtepJ+X+fo1RjhbRh
         jqJYkxRqt5xdjkwusO4vMUEE2npOz6tKB9+QHF18MXRUk/qZdBbRQBTgEa6BHiypq7/5
         zub+pc2EW5Gk9ct2FUNAKcT+Ft5gmJ8pzrA8975rWPxalQVGhBUP3t15njsbHDqR8c3K
         mZiCys7KO4zb/Hao7KCHaCh3J4PPMqtgEWH99+oWJTHihC3xSZp2lZMLdVL/1PMwpkgH
         nyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787865; x=1780392665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhyGEGziB4p1he7Kr6BJJdkSVJk+rI4Mohkv26Jk0G8=;
        b=PGXxhbXAQgvFIfIFBkOugq3yBI/kRfsSD3w5fCp031D+cvyoeP0NVKoIvE9RqrElfM
         PZOgjyw5cbrm1gzjEpyJ0vd+e2NnOkBPWjpjFo0OPAyvB5NpZJiJKWwXS0MXUWbGaWa5
         P1Hd2IPAAxyPnueWSZzVUEN5QK0KeFgsIWyEbc3AkeE5/AO1Mp9pVmxz1gTGa1o4a1s9
         3GZlkHvzYbkht3/2mToKKAAXDV+R1EuUSfWGuT9NpXfa/or+uQyxAQ6Cz46nBkZcFTYj
         Xo7bdrJfXUkDFLnCA200Lf6p1KjK56mksdJ9AOxUk11NIKKAblexpL/CbrDCZWajgyqZ
         xfJw==
X-Forwarded-Encrypted: i=1; AFNElJ9UoJ7JpuGi6VHCsgP5jdwlBHrQDptmlNoqsMAnyi6/d1hQcH7rspbkfkCEv0t1b1Wco9MnZgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysh+YrlfKBkJfoS36fM7aIZ9Jkl+deO9rQSw1OvVYiiH+YfXMM
	MjSNaw/Sx+PjnJ9sMZMlRoX3ge9crvjlCuAPHFReqOw7sFbDFu0Ts9gY
X-Gm-Gg: Acq92OEdczpy84lyX7KZ/88AdVQ8hUhyhcNdmpeUUc6dUNq2gldZ99Z6JycXqvWjk0S
	UinAWjcCJZIzJQrKXxz40LRhOd4RqBPMknibzWJSh0BQ88WipuX4wLex8Uv4wK9edsw3CFAvOcI
	xZnQZpK8dSVGY6sGKBcIvA57Y+2q/wKuUvMBRDOn7NKs6mny7eQz2Zm8YHsFzQOje3G3i1YCgyd
	bsrvy0E1aiBhAoxO8v26MImyXxZ30WKG2+ZjdG9bwy98jwRGO4Bbl29RU2VuqsMXQcwzK03TMUf
	MM8xo4if4YYM7tl/0GE8yNeZhFmui5+npNpckNThtShCvmB4w4HMkjxiB1ynk6aRUCMeQtnrONv
	KHAe8p6bfaoJd5AH8mHeu3xy8fgAMSNdxvydXw/yyEoSWJexO1fJGbBX5Gr/4YyBkNbX17bE3pi
	+9N67NPlSTdQc4w4hHgf2VSGgkAWp68fbdEYRvTM+rRtpcJBVDdGTDsJJDKeQfOFuo
X-Received: by 2002:a05:600c:4ecc:b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-490426cef73mr281947435e9.20.1779787863622;
        Tue, 26 May 2026 02:31:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4741bsm35437657f8f.22.2026.05.26.02.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:31:03 -0700 (PDT)
Date: Tue, 26 May 2026 10:31:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Florian Westphal <fw@strlen.de>, Kacper Kokot
 <kacper.kokot.44@gmail.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Phil
 Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option
 is unaligned
Message-ID: <20260526103102.003aedd9@pumpkin>
In-Reply-To: <b82e4092-1f4e-40ca-b117-31c062ea54c2@suse.de>
References: <20260525201116.407338-2-kacper.kokot.44@gmail.com>
	<ahS--cPlhv6NHAcO@strlen.de>
	<b82e4092-1f4e-40ca-b117-31c062ea54c2@suse.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254285-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[strlen.de,gmail.com,netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5F2EF5D371A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 00:08:15 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> On 5/25/26 11:28 PM, Florian Westphal wrote:
> > Kacper Kokot <kacper.kokot.44@gmail.com> wrote:  
> >> Padding TCP options with NOPs is optional, so it is legal to send an
> >> MSS option that is not aligned to a word boundary and therefore not
> >> aligned for checksum calculation. The current TCPMSS target is not
> >> robust to this: when the MSS option is unaligned it produces an
> >> invalid checksum, and the packet is dropped.  
> > 
> > Is this an actual, real world bug?  This code is 20+ years old, all that
> > this hints at is that they are always aligned in reality?
> >   
> 
> AFAICS, these issues are not present in real environments as MSS option 
> is placed at the beginning of the options block making it aligned by 
> default usually.
> 
> I would say this is more for correctness. I wonder, if we are touching 
> this code, we could use the opportunity to make it use 
> get_unaligned_be16() instead.

gcc and clang convert x[0] << 8 | x[1] (etc) to the appropriate single
instruction (and maybe byteswap) on cpu that support misaligned accesses.
So there is little to gain from doing it any other way.

-- David


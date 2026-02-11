Return-Path: <stable+bounces-215796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wI41HFNxjGn6oAAAu9opvQ
	(envelope-from <stable+bounces-215796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:08:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED25312416C
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5568F3005A80
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C932E6A2;
	Wed, 11 Feb 2026 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b="h3jn3u11"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BB2737E3
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811728; cv=none; b=NQw8l1E2fks19CA+OIgtbnwVYw6+ABdU+PdXIp7bwybxT2y6qca1fOsbj7nOUOXIeesFhaHE/0uKhIo7a7hso08reu/22dHlkdLbGiCgIzpxU0vZwVVoYtJaYmX+9kuJSu7LsgQeBcbCQEFU99ghGLe4Q6JBG5bWnfOoOQNlDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811728; c=relaxed/simple;
	bh=J5zsbkr0ImpZMV93vdPC8f7NDW4AsTSt92c9D/xAUy8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TZAIYVvKf6OAtufTsMpYzaXRfRGB+L7VmlpFBxWGFgC7p05grOnsqK9dkox+kf34ayqd8wBS2kCROUt61CWlPlLA8kS2o4xptQZKb8JTSGPeuc82SRrC6MHckOJzMGSocZUjrlOY3E3n5R9av2cVEUAX2sh6z2mT41atS3IWCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=remarkable.no; spf=pass smtp.mailfrom=remarkable.no; dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b=h3jn3u11; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=remarkable.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remarkable.no
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59e4a04f059so4887260e87.2
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remarkable.no; s=google; t=1770811725; x=1771416525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rL3gRJ2mae9dRxhLsEEPcdH8MNdcxqeXLPM+4bfWMo0=;
        b=h3jn3u111tPaFhRKcyp4oHnFGumVStV2ZRIWrzcx7L6/07sB6uBz5qJ984o7Ev+q9a
         487i3NVjBapXvKrq2e9qPbzpl2M4swqn/LhroTvJiU0+1XxrsTdRmseglueKPAj/IEN5
         vK6hbx5OR4gP5wx7zgLe+plDxz716bQ1aQZLd4kbmovQKbhr9KRRf2syTY12PvCxAC44
         EVUuGpTqB24DTVZQYA7JN7k4Yza+kovIqSmwtYj+JQLkJw38/QtJeISffQNoU4B0tjqx
         tN+/LyUFWpwln2Y4ysHiJznOkiyoRBDmZ5t2zF0mmkE0Ycykwbx73gP6fZZnTqBDc7jB
         KqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770811725; x=1771416525;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL3gRJ2mae9dRxhLsEEPcdH8MNdcxqeXLPM+4bfWMo0=;
        b=lQJW/WLu/ISnhx8DgSOavSx3onoxXtBx0QgdIQ63yd12IFfHbHdGNtR+XFmJr1rLx5
         +6Sd9unqVEW0LpvWBGvkpG5hXD0W5RKPzOQ1y1lzgMtoLTLEZz5Og2OvQxvCP9BHzxI/
         c81Fdy0FPRVfyz0BZcJnOjDisfosMkSK+N3Ag3kPdngvo5uUOklA75zlSQ2WHOW7GaeU
         QGUjY2d3XCuWnyGuBXO6ez73Phactrxg2nFLndx0bsL2vavODyH2Jvkb7Z6nQyA1InN/
         D0wCj3ewKhSwwEhjHZHY4FI4JXfJowGaX2uBePiq+or22lsudZMoVQFXs7nVixvBJYjL
         otNw==
X-Forwarded-Encrypted: i=1; AJvYcCXCMOgCcoTMPyc3z5SUmwEc7DBlKC7kxKAGD2EtcD2nlKpWcD+8nYWZzCs4Xr3shxrmekM84YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjZNWcuRJ8oG7OVSytoB9qF8bp6Mx0PO5cAyIZhtSBh3mer2V
	1No4W6FH+gWUgO6ntB3hqAfr6oAq3kVXr311pyNvExG+EiQRcq9MUtdv6hZ4ZfAAVQWWRcEj223
	XDSlXaCbKR48=
X-Gm-Gg: AZuq6aIS8veXa1NVvfpp0BgUDE7jMs3qXblh8RQvRlWKGQH1mmNWmzz9qJ/5YYdFJXE
	1m6WxQGFcIXi3Un4Q+OoBTLLxkR02w8gQcG3bKHJz/YG3USqZAP3ALXquPMOiHxJLyrPcIDQxRN
	sMiiDgLi9+NAAMkPofx3MHQCSPJbeEWFk5extwBoRwkaAuCmHJVl5kD4wwyrswkXIGxTTCtID8f
	crhZyCl2NJKWeXUp6i71IsFA0+la+5GhTn/FTU+/4KlEkZZSI9aeCS0lTy9DW5EBs1tqB0I1389
	pXs380PS9/eSsQMtyplF6peonXn2R1mMVW8Xklud1o7f7LTrpgxErnkcpg99OkPXoPlzcYcYVjr
	AN6NIVWdhdy5DAh+xEZe5AEoKBIyG+C1fc1A1yq498ucrwjv0RZ4ZUnJTN/7aGis0jn9x9OL5+5
	F7y2DCu1t1y+QDukyP4M9OXmLKkScJKPqTfyvWUy1lvN04NznE8J1klhaKtQ5U8bOrAGhOhkgxS
	717+MBrydPhOsp66qTKl219yUFOQ4BccfZJ5Kn8btIF3VmelgIAUSGJziatFGdnQ1YFobehKAPg
	i2MI
X-Received: by 2002:a05:6512:3c99:b0:59e:39b0:9d4a with SMTP id 2adb3069b0e04-59e5c3f5b29mr979913e87.39.1770811724863;
        Wed, 11 Feb 2026 04:08:44 -0800 (PST)
Received: from ?IPV6:2001:4643:2b9c:0:64dc:7ba4:ffb0:37f7? ([2001:4643:2b9c:0:64dc:7ba4:ffb0:37f7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a4f8dsm295858e87.49.2026.02.11.04.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:08:44 -0800 (PST)
Message-ID: <0e2c72eb-a8ed-4275-9fca-6c9c9e44fd2d@remarkable.no>
Date: Wed, 11 Feb 2026 13:08:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Korsnes <johan.korsnes@remarkable.no>
Subject: Re: [PATCH 6.12] vsock/test: verify socket options after setting them
To: Stefano Garzarella <sgarzare@redhat.com>, stable@vger.kernel.org
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
References: <20260211115948.108140-1-sgarzare@redhat.com>
Content-Language: en-US
In-Reply-To: <20260211115948.108140-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[remarkable.no,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[remarkable.no:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[remarkable.no:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215796-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan.korsnes@remarkable.no,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,remarkable.no:mid,remarkable.no:dkim,remarkable.no:email]
X-Rspamd-Queue-Id: ED25312416C
X-Rspamd-Action: no action

On 11/02/2026 12:59, Stefano Garzarella wrote:
> From: Konstantin Shkolnyy <kshk@linux.ibm.com>
> 
> [ Upstream commit 86814d8ffd55fd4ad19c512eccd721522a370fb2 ]
> 
> Replace setsockopt() calls with calls to functions that follow
> setsockopt() with getsockopt() and check that the returned value and its
> size are the same as have been set. (Except in vsock_perf.)
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [Stefano: patch needed to avoid vsock test build failure reported by
>  Johan Korsnes after backporting commit 0a98de8013696 ("vsock/test: fix
>  seqpacket message bounds test") in 6.12-stable tree]
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

This fixes our build. Thanks!

Tested-by: Johan Korsnes <johan.korsnes@remarkable.no>

Kind regards,
Johan

> ---
>  tools/testing/vsock/msg_zerocopy_common.h |   1 -
>  tools/testing/vsock/util.h                |   7 ++
>  tools/testing/vsock/control.c             |   9 +-
>  tools/testing/vsock/msg_zerocopy_common.c |  10 --
>  tools/testing/vsock/util.c                | 142 ++++++++++++++++++++++
>  tools/testing/vsock/vsock_perf.c          |  10 ++
>  tools/testing/vsock/vsock_test.c          |  51 +++-----
>  tools/testing/vsock/vsock_test_zerocopy.c |   2 +-
>  tools/testing/vsock/vsock_uring_test.c    |   2 +-
>  9 files changed, 181 insertions(+), 53 deletions(-)
> 
> diff --git a/tools/testing/vsock/msg_zerocopy_common.h b/tools/testing/vsock/msg_zerocopy_common.h
> index 3763c5ccedb95..ad14139e93ca3 100644
> --- a/tools/testing/vsock/msg_zerocopy_common.h
> +++ b/tools/testing/vsock/msg_zerocopy_common.h
> @@ -12,7 +12,6 @@
>  #define VSOCK_RECVERR	1
>  #endif
>  
> -void enable_so_zerocopy(int fd);
>  void vsock_recv_completion(int fd, const bool *zerocopied);
>  
>  #endif /* MSG_ZEROCOPY_COMMON_H */
> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> index fff22d4a14c0f..ba84d296d8b71 100644
> --- a/tools/testing/vsock/util.h
> +++ b/tools/testing/vsock/util.h
> @@ -68,4 +68,11 @@ unsigned long iovec_hash_djb2(const struct iovec *iov, size_t iovnum);
>  struct iovec *alloc_test_iovec(const struct iovec *test_iovec, int iovnum);
>  void free_test_iovec(const struct iovec *test_iovec,
>  		     struct iovec *iovec, int iovnum);
> +void setsockopt_ull_check(int fd, int level, int optname,
> +			  unsigned long long val, char const *errmsg);
> +void setsockopt_int_check(int fd, int level, int optname, int val,
> +			  char const *errmsg);
> +void setsockopt_timeval_check(int fd, int level, int optname,
> +			      struct timeval val, char const *errmsg);
> +void enable_so_zerocopy_check(int fd);
>  #endif /* UTIL_H */
> diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
> index d2deb4b15b943..0066e0324d35c 100644
> --- a/tools/testing/vsock/control.c
> +++ b/tools/testing/vsock/control.c
> @@ -27,6 +27,7 @@
>  
>  #include "timeout.h"
>  #include "control.h"
> +#include "util.h"
>  
>  static int control_fd = -1;
>  
> @@ -50,7 +51,6 @@ void control_init(const char *control_host,
>  
>  	for (ai = result; ai; ai = ai->ai_next) {
>  		int fd;
> -		int val = 1;
>  
>  		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
>  		if (fd < 0)
> @@ -65,11 +65,8 @@ void control_init(const char *control_host,
>  			break;
>  		}
>  
> -		if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,
> -			       &val, sizeof(val)) < 0) {
> -			perror("setsockopt");
> -			exit(EXIT_FAILURE);
> -		}
> +		setsockopt_int_check(fd, SOL_SOCKET, SO_REUSEADDR, 1,
> +				     "setsockopt SO_REUSEADDR");
>  
>  		if (bind(fd, ai->ai_addr, ai->ai_addrlen) < 0)
>  			goto next;
> diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/testing/vsock/msg_zerocopy_common.c
> index 5a4bdf7b51328..8622e5a0f8b77 100644
> --- a/tools/testing/vsock/msg_zerocopy_common.c
> +++ b/tools/testing/vsock/msg_zerocopy_common.c
> @@ -14,16 +14,6 @@
>  
>  #include "msg_zerocopy_common.h"
>  
> -void enable_so_zerocopy(int fd)
> -{
> -	int val = 1;
> -
> -	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
> -		perror("setsockopt");
> -		exit(EXIT_FAILURE);
> -	}
> -}
> -
>  void vsock_recv_completion(int fd, const bool *zerocopied)
>  {
>  	struct sock_extended_err *serr;
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index 8a899a9fc9a98..894221a1ff317 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -663,3 +663,145 @@ void free_test_iovec(const struct iovec *test_iovec,
>  
>  	free(iovec);
>  }
> +
> +/* Set "unsigned long long" socket option and check that it's indeed set */
> +void setsockopt_ull_check(int fd, int level, int optname,
> +			  unsigned long long val, char const *errmsg)
> +{
> +	unsigned long long chkval;
> +	socklen_t chklen;
> +	int err;
> +
> +	err = setsockopt(fd, level, optname, &val, sizeof(val));
> +	if (err) {
> +		fprintf(stderr, "setsockopt err: %s (%d)\n",
> +			strerror(errno), errno);
> +		goto fail;
> +	}
> +
> +	chkval = ~val; /* just make storage != val */
> +	chklen = sizeof(chkval);
> +
> +	err = getsockopt(fd, level, optname, &chkval, &chklen);
> +	if (err) {
> +		fprintf(stderr, "getsockopt err: %s (%d)\n",
> +			strerror(errno), errno);
> +		goto fail;
> +	}
> +
> +	if (chklen != sizeof(chkval)) {
> +		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
> +			chklen);
> +		goto fail;
> +	}
> +
> +	if (chkval != val) {
> +		fprintf(stderr, "value mismatch: set %llu got %llu\n", val,
> +			chkval);
> +		goto fail;
> +	}
> +	return;
> +fail:
> +	fprintf(stderr, "%s  val %llu\n", errmsg, val);
> +	exit(EXIT_FAILURE);
> +;
> +}
> +
> +/* Set "int" socket option and check that it's indeed set */
> +void setsockopt_int_check(int fd, int level, int optname, int val,
> +			  char const *errmsg)
> +{
> +	int chkval;
> +	socklen_t chklen;
> +	int err;
> +
> +	err = setsockopt(fd, level, optname, &val, sizeof(val));
> +	if (err) {
> +		fprintf(stderr, "setsockopt err: %s (%d)\n",
> +			strerror(errno), errno);
> +		goto fail;
> +	}
> +
> +	chkval = ~val; /* just make storage != val */
> +	chklen = sizeof(chkval);
> +
> +	err = getsockopt(fd, level, optname, &chkval, &chklen);
> +	if (err) {
> +		fprintf(stderr, "getsockopt err: %s (%d)\n",
> +			strerror(errno), errno);
> +		goto fail;
> +	}
> +
> +	if (chklen != sizeof(chkval)) {
> +		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
> +			chklen);
> +		goto fail;
> +	}
> +
> +	if (chkval != val) {
> +		fprintf(stderr, "value mismatch: set %d got %d\n", val, chkval);
> +		goto fail;
> +	}
> +	return;
> +fail:
> +	fprintf(stderr, "%s val %d\n", errmsg, val);
> +	exit(EXIT_FAILURE);
> +}
> +
> +static void mem_invert(unsigned char *mem, size_t size)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < size; i++)
> +		mem[i] = ~mem[i];
> +}
> +
> +/* Set "timeval" socket option and check that it's indeed set */
> +void setsockopt_timeval_check(int fd, int level, int optname,
> +			      struct timeval val, char const *errmsg)
> +{
> +	struct timeval chkval;
> +	socklen_t chklen;
> +	int err;
> +
> +	err = setsockopt(fd, level, optname, &val, sizeof(val));
> +	if (err) {
> +		fprintf(stderr, "setsockopt err: %s (%d)\n",
> +			strerror(errno), errno);
> +		goto fail;
> +	}
> +
> +	 /* just make storage != val */
> +	chkval = val;
> +	mem_invert((unsigned char *)&chkval, sizeof(chkval));
> +	chklen = sizeof(chkval);
> +
> +	err = getsockopt(fd, level, optname, &chkval, &chklen);
> +	if (err) {
> +		fprintf(stderr, "getsockopt err: %s (%d)\n",
> +			strerror(errno), errno);
> +		goto fail;
> +	}
> +
> +	if (chklen != sizeof(chkval)) {
> +		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
> +			chklen);
> +		goto fail;
> +	}
> +
> +	if (memcmp(&chkval, &val, sizeof(val)) != 0) {
> +		fprintf(stderr, "value mismatch: set %ld:%ld got %ld:%ld\n",
> +			val.tv_sec, val.tv_usec, chkval.tv_sec, chkval.tv_usec);
> +		goto fail;
> +	}
> +	return;
> +fail:
> +	fprintf(stderr, "%s val %ld:%ld\n", errmsg, val.tv_sec, val.tv_usec);
> +	exit(EXIT_FAILURE);
> +}
> +
> +void enable_so_zerocopy_check(int fd)
> +{
> +	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
> +			     "setsockopt SO_ZEROCOPY");
> +}
> diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
> index 8e0a6c0770d37..75971ac708c9a 100644
> --- a/tools/testing/vsock/vsock_perf.c
> +++ b/tools/testing/vsock/vsock_perf.c
> @@ -251,6 +251,16 @@ static void run_receiver(int rcvlowat_bytes)
>  	close(fd);
>  }
>  
> +static void enable_so_zerocopy(int fd)
> +{
> +	int val = 1;
> +
> +	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
> +		perror("setsockopt");
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
>  static void run_sender(int peer_cid, unsigned long to_send_bytes)
>  {
>  	time_t tx_begin_ns;
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 79ef11c0ab14f..8855094202d40 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -455,17 +455,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
>  
>  	sock_buf_size = SOCK_BUF_SIZE;
>  
> -	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> -		       &sock_buf_size, sizeof(sock_buf_size))) {
> -		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
> -		exit(EXIT_FAILURE);
> -	}
> +	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> +			     sock_buf_size,
> +			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>  
> -	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> -		       &sock_buf_size, sizeof(sock_buf_size))) {
> -		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> -		exit(EXIT_FAILURE);
> -	}
> +	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> +			     sock_buf_size,
> +			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>  
>  	/* Ready to receive data. */
>  	control_writeln("SRVREADY");
> @@ -597,10 +593,8 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
>  	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
>  	tv.tv_usec = 0;
>  
> -	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
> -		perror("setsockopt(SO_RCVTIMEO)");
> -		exit(EXIT_FAILURE);
> -	}
> +	setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
> +				 "setsockopt(SO_RCVTIMEO)");
>  
>  	read_enter_ns = current_nsec();
>  
> @@ -866,11 +860,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
> -		       &lowat_val, sizeof(lowat_val))) {
> -		perror("setsockopt(SO_RCVLOWAT)");
> -		exit(EXIT_FAILURE);
> -	}
> +	setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
> +			     lowat_val, "setsockopt(SO_RCVLOWAT)");
>  
>  	control_expectln("SRVSENT");
>  
> @@ -1398,11 +1389,9 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>  	/* size_t can be < unsigned long long */
>  	sock_buf_size = buf_size;
>  
> -	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> -		       &sock_buf_size, sizeof(sock_buf_size))) {
> -		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> -		exit(EXIT_FAILURE);
> -	}
> +	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> +			     sock_buf_size,
> +			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>  
>  	if (low_rx_bytes_test) {
>  		/* Set new SO_RCVLOWAT here. This enables sending credit
> @@ -1411,11 +1400,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>  		 */
>  		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>  
> -		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
> -			       &recv_buf_size, sizeof(recv_buf_size))) {
> -			perror("setsockopt(SO_RCVLOWAT)");
> -			exit(EXIT_FAILURE);
> -		}
> +		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
> +				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
>  	}
>  
>  	/* Send one dummy byte here, because 'setsockopt()' above also
> @@ -1457,11 +1443,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
>  		recv_buf_size++;
>  
>  		/* Updating SO_RCVLOWAT will send credit update. */
> -		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
> -			       &recv_buf_size, sizeof(recv_buf_size))) {
> -			perror("setsockopt(SO_RCVLOWAT)");
> -			exit(EXIT_FAILURE);
> -		}
> +		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
> +				     recv_buf_size, "setsockopt(SO_RCVLOWAT)");
>  	}
>  
>  	fds.fd = fd;
> diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
> index 04c376b6937f5..9d9a6cb9614ad 100644
> --- a/tools/testing/vsock/vsock_test_zerocopy.c
> +++ b/tools/testing/vsock/vsock_test_zerocopy.c
> @@ -162,7 +162,7 @@ static void test_client(const struct test_opts *opts,
>  	}
>  
>  	if (test_data->so_zerocopy)
> -		enable_so_zerocopy(fd);
> +		enable_so_zerocopy_check(fd);
>  
>  	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
>  
> diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
> index 6c3e6f70c457d..5c3078969659f 100644
> --- a/tools/testing/vsock/vsock_uring_test.c
> +++ b/tools/testing/vsock/vsock_uring_test.c
> @@ -73,7 +73,7 @@ static void vsock_io_uring_client(const struct test_opts *opts,
>  	}
>  
>  	if (msg_zerocopy)
> -		enable_so_zerocopy(fd);
> +		enable_so_zerocopy_check(fd);
>  
>  	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
>  



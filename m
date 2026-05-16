Return-Path: <stable+bounces-249035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAOBBdLDCGqJ4QMAu9opvQ
	(envelope-from <stable+bounces-249035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:21:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FFF55D898
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 082713004C86
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9846A3644C3;
	Sat, 16 May 2026 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKFP8Ush"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A72EC0A4
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778959306; cv=none; b=HCbnJUusz/11EzWsvVduE/4mYGFbae9EjHMeJnyYXGscT8ppu13Jt7MIORkNOBthFvbvEVEIaauda8MhmgpciCun3jV4sWm9tTEmIA2hkiGyDrKCDLkrWkBSfI0MeOIYXHLp/5iC0e9Os2v85PBltjUCfRoJPvnkx+86wGyMRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778959306; c=relaxed/simple;
	bh=AwpLiTFnf/aZLz14+tNGOQUNxXaUEnHIez4a1jGAFKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7kSqKJThGrnVsveUOeVQO405iLSr+gpJ/VTQp75r0soIaSIqp7yySTvcVqFpfaVpQBv28XAnqaB66cSBhWvoN4DGswWC4igagUSAwrex/8/INjdGS5/6G92oIOX/NisosKFo5zMRHBZjbn8Yx+eZazur5K3GOgDai7ukzCx20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKFP8Ush; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so13554115e9.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778959303; x=1779564103; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mXUlf0Sm1ANstRJLmc2W7TgH4cPtLhK8378wQUDoPY4=;
        b=jKFP8UshgOsJ5byCjTzLqOLgwVtlFwzm81K1JgORwZnFjm2YTzzDhe8P/PjKyUTLvU
         gKrCzzonCBmM/lEmeQiSV+I+GftEqIPQJLOYLbV+LYxyBMstz4vGCST4q+eTzt+WT5QT
         /fPk1u1B20Z3d/zyKEgARuFmuKH/Hmzv+gblnKe2Bv4CIkMe2PHFBXtW4bjaKS4B7N+8
         Io0zPiFpRjJ6Abq+vwqKmwIdqUj/BvyMZy+nFMbOhMzyy3nsSUwSLfJEQq8lxP+FUeV1
         SdsQftAJ00LoNWLoQwCrOq6oocUEr9erI15zEbOEIrlaVpASlEyOpOrJSVixLzX87g6G
         a8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778959303; x=1779564103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXUlf0Sm1ANstRJLmc2W7TgH4cPtLhK8378wQUDoPY4=;
        b=a/STclNNp3SnV1vyejXlvgCxZHieMKQuooCKTR0gfcFCkfIdtOx6oA0TJPzkJImkyf
         BWuOG/y4iDi6mF2MdhNoxIpu14bF3zy2DinMk4YuyFwOybVSHPawnaKeA21x29Fib/sP
         ndrAeWxxGT3FKzK9rT/EMVifjA1MgPY5iylwClDNimg2aSM5nbY8QIb/DS9J6dcmhrvN
         KklZjIUq1AjZnGkkUIS6wwAd4HzkqFSW2b4rPYw1YZOZzyJwa38kwt2ymLYSXTf4lE9u
         VeyH5jV5mN0tjXcx7Xi/MWy7nXMQ68GZnMB07nVo4BUEScmXjQWNF4Eo2GCWHGyQhyvc
         zuCw==
X-Forwarded-Encrypted: i=1; AFNElJ9ARmAqPHGGcnzjOZICjl/z6JUuaUTWr68b6FO+aOtmLmM6GvM4HiMbz7P6FEuchsB7X1O5Hh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGNzU6oOT3bOyQmgXuJoUJJ0qRYuz/yIyT8yHfFmyReM0VOag
	OUWIxOz7v2A0mkYbwcoXPucbNZPPWsREo5gRSOsSWx8lVkXCKk6y81pj+fj1g6nM
X-Gm-Gg: Acq92OFXxTIJV1Mx46Ah4PKE6l/FGgwg21K7T09JvGYhbAPv8vLYhgR3kNYmtfMw2BR
	I4y+rBfipP/bZb3kfVg9jIjRmTfiWwTekrueFCd/SpNo+2uC+rKpFtcriYeySSj+Y3Bfse6nIXw
	VeewBTwC+ai1ej7nznoJec016Wv2Hv9ejsr0d2hNHVQKw2uE+RQbPgVGozndXrfjlwHGXuTfZnN
	yILTI6aqYfHXytVGwOAwpIOSCjoGAuwNpaXOduOTRC3pXI/53adpOXSHstiKIM+p6ZB7VJiVvd4
	zhk4zhw0b2r84Zwjj6JrOcFjLmElaXY1FRnfixpkOt5MhdwJLgzKhezHEpwPlpGIpbYbc8VgEY2
	JggLcYetghlQ0Nj5pDCCTC8M/OcPrgVZUCRubVDmy7M+XRoCHjVAKmsW2EdtCND5sHfJcbiz9DK
	JzEkKGhYMqdzIy/02oDc7V4wurJSq8XjmvfuI6pRs44O3ymQAL
X-Received: by 2002:a05:600c:c10e:b0:48a:65a5:750f with SMTP id 5b1f17b1804b1-48fe63265ddmr98795675e9.21.1778959302907;
        Sat, 16 May 2026 12:21:42 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf8305dsm58490605e9.9.2026.05.16.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:21:42 -0700 (PDT)
Date: Sat, 16 May 2026 21:21:40 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, lkp@intel.com,
	oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] selftests/landlock: Increase default audit socket
 timeout
Message-ID: <20260516.5fdd905d48d8@gnoack.org>
References: <20260513105112.140137-1-mic@digikod.net>
 <20260513105112.140137-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513105112.140137-2-mic@digikod.net>
X-Rspamd-Queue-Id: 15FFF55D898
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249035-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 12:51:09PM +0200, Mickaël Salaün wrote:
> matches_log_fs() and other audit_match_record() callers intermittently
> return -EAGAIN under heavy debug configs (KASAN, lockdep).  The audit
> record delivery pipeline is asynchronous: landlock_log_denial() queues
> the record to audit_queue, and kauditd_thread dequeues and delivers via
> netlink.  Under debug configs, kauditd scheduling between
> audit_log_end() and netlink_unicast() can exceed a syscall round trip
> (more than 1 usec), which was the value of the socket timeout used for
> the recvfrom() calls.
> 
> The observed failure [1] is an EAGAIN error code (-11) which means that
> the access record had not arrived within the 1 usec timeout of
> recvfrom().  The expected record does arrive, but only after
> matches_log_fs() has already returned.  It is then consumed by a later
> audit_count_records() call, making records.access == 1 instead of 0.
> 
> Switch the default socket timeout to the slow value (1 second) so all
> audit_match_record() callers wait long enough for kauditd delivery, and
> lower it to the fast value (1 usec) only on the two paths that expect no
> record: audit_count_records() and the expected_domain_id == 0 probe in
> matches_log_domain_deallocated().  audit_init() drains stale records
> with the fast timeout (terminating on -EAGAIN once the backlog is empty)
> and switches to the patient default before returning.  1 second gives
> ~10x margin over the observed maximum (~100 ms, while the happy path is
> ~23 us).
> 
> Rename the timeval constants to reflect their new roles:
> - audit_tv_dom_drop (1 second) -> audit_tv_default: default socket
>   timeout, patient enough for asynchronous kauditd delivery.
> - audit_tv_default (1 usec) -> audit_tv_fast: fast timeout for paths
>   that expect no record (drain, audit_count_records(), probes).
> 
> Invert the conditional in matches_log_domain_deallocated().  Check
> setsockopt returns on both the lower and restore paths; preserve the
> first error via !err when the restore fails after a prior error so the
> actionable return code is not masked by a bookkeeping failure.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Cc: stable@vger.kernel.org
> Depends-on: 07c2572a8757 ("selftests/landlock: Skip stale records in audit_match_record()")
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Reported-by: Günther Noack <gnoack3000@gmail.com>
> Closes: https://lore.kernel.org/r/20260402.eb5c4e85f472@gnoack.org [1]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202605111649.a8b30a62-lkp@intel.com
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/audit.h | 80 +++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 699aed5ffab4..936fe20f020e 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -45,17 +45,25 @@ struct audit_message {
>  	};
>  };
>  
> -static const struct timeval audit_tv_dom_drop = {
> +static const struct timeval audit_tv_default = {
>  	/*
> -	 * Because domain deallocation is tied to asynchronous credential
> -	 * freeing, receiving such event may take some time.  In practice,
> -	 * on a small VM, it should not exceed 100k usec, but let's wait up
> -	 * to 1 second to be safe.
> +	 * Default socket timeout for audit_match_record() callers that expect a
> +	 * record to arrive.  Asynchronous kauditd delivery can exceed 1 usec
> +	 * under heavy debug configs (KASAN, lockdep), where kauditd_thread
> +	 * scheduling between audit_log_end() and netlink_unicast() takes longer
> +	 * than the previous 1 usec timeout. 1 second is a generous ceiling: on
> +	 * the happy path, kauditd delivers within dozens of usec.
>  	 */
>  	.tv_sec = 1,
>  };
>  
> -static const struct timeval audit_tv_default = {
> +static const struct timeval audit_tv_fast = {
> +	/*
> +	 * Fast timeout for paths that expect no record (audit_init() drain,
> +	 * audit_count_records(), probes).  Causes audit_recv() to return
> +	 * -EAGAIN once the socket buffer is empty, naturally terminating the
> +	 * read loop.
> +	 */
>  	.tv_usec = 1,
>  };
>  
> @@ -334,8 +342,13 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
>   * Matches a domain deallocation record.  When expected_domain_id is non-zero,
>   * the pattern includes the specific domain ID so that stale deallocation
>   * records from a previous test (with a different domain ID) are skipped by
> - * audit_match_record(), and the socket timeout is temporarily increased to
> - * audit_tv_dom_drop to wait for the asynchronous kworker deallocation.
> + * audit_match_record(), waiting for the asynchronous kworker deallocation with
> + * the default patient timeout.
> + *
> + * When expected_domain_id is zero, the caller is probing for any dealloc record
> + * that may or may not arrive.  Temporarily lowers the socket timeout to
> + * audit_tv_fast for this probe so it returns promptly when no record is
> + * pending; restores audit_tv_default after.
>   */
>  static int __maybe_unused
>  matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
> @@ -361,16 +374,21 @@ matches_log_domain_deallocated(int audit_fd, unsigned int num_denials,
>  	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
> -	if (expected_domain_id)
> -		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
> -			   &audit_tv_dom_drop, sizeof(audit_tv_dom_drop));
> +	if (!expected_domain_id) {
> +		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
> +			       &audit_tv_fast, sizeof(audit_tv_fast)))
> +			return -errno;
> +	}
>  
>  	err = audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
>  				 domain_id);
>  
> -	if (expected_domain_id)
> -		setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
> -			   sizeof(audit_tv_default));
> +	if (!expected_domain_id) {
> +		if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO,
> +			       &audit_tv_default, sizeof(audit_tv_default)) &&
> +		    !err)
> +			err = -errno;
> +	}
>  
>  	return err;
>  }
> @@ -387,6 +405,11 @@ struct audit_records {
>   * audit_init() and after the preceding audit_match_record() call.  Allocation
>   * records are emitted synchronously during landlock_log_denial() in the current
>   * test's syscall context, so only those are counted in records->domain.
> + *
> + * Temporarily lowers SO_RCVTIMEO to audit_tv_fast for the read loop: this is a
> + * "no record expected" path that should terminate on the first -EAGAIN.  The
> + * default patient timeout is restored on exit for subsequent
> + * audit_match_record() callers.
>   */
>  static int audit_count_records(int audit_fd, struct audit_records *records)
>  {
> @@ -403,6 +426,12 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
>  	records->access = 0;
>  	records->domain = 0;
>  
> +	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
> +		       sizeof(audit_tv_fast))) {
> +		err = -errno;
> +		goto out;
> +	}
> +
>  	do {
>  		memset(&msg, 0, sizeof(msg));
>  		err = audit_recv(audit_fd, &msg);
> @@ -429,6 +458,10 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
>  	} while (true);
>  
>  out:
> +	if (setsockopt(audit_fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
> +		       sizeof(audit_tv_default)) &&
> +	    !err)
> +		err = -errno;
>  	regfree(&dealloc_re);
>  	return err;
>  }
> @@ -449,9 +482,9 @@ static int audit_init(void)
>  	if (err)
>  		goto err_close;
>  
> -	/* Sets a timeout for negative tests. */
> -	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
> -			 sizeof(audit_tv_default));
> +	/* Uses the fast timeout to drain stale records below. */
> +	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_fast,
> +			 sizeof(audit_tv_fast));
>  	if (err) {
>  		err = -errno;
>  		goto err_close;
> @@ -467,6 +500,19 @@ static int audit_init(void)
>  	while (audit_recv(fd, NULL) == 0)
>  		;
>  
> +	/*
> +	 * Restores the default timeout for audit_match_record() callers that
> +	 * expect a record to arrive.  Paths that expect no record restore the
> +	 * fast timeout locally (audit_count_records(), the expected_domain_id
> +	 * == 0 probe in matches_log_domain_deallocated()).
> +	 */
> +	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
> +			 sizeof(audit_tv_default));
> +	if (err) {
> +		err = -errno;
> +		goto err_close;
> +	}
> +
>  	return fd;
>  
>  err_close:
> -- 
> 2.54.0
> 

Tested-by: Günther Noack <gnoack3000@gmail.com>


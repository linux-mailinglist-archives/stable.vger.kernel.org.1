Return-Path: <stable+bounces-249034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBCWGdDDCGqJ4QMAu9opvQ
	(envelope-from <stable+bounces-249034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:21:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B79EF55D88D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 245AE300BDB6
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD57235E1A4;
	Sat, 16 May 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h55s76dM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E93603EB
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778959286; cv=none; b=sKDufNzj0XK+8YThPKrmFsvGVGHXzi6KuCZIP4GuXi3MNflOa8iQOKtm2eSRB26NsFKljIanxPr9xp1UriVXj0nQ5Gy9sRhgyR5jYUiPioLV6YsITcOnaE/bQCHYbFjxrvdQjVhMPrMZMoXhK19Uaxh3+hr3QgMsT+6C1k3yiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778959286; c=relaxed/simple;
	bh=ij9RhLklIgc4kT2Edgj8kTj3HFGxKELkieSEBcnJO3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5OzlFp4qa4OhPDwBxO85ibLhw3erdPAzEIXNCBCkOa+iIXrBfMetqu091GK8/eKWze8ZLN9VpKF7VDWQ9sYWvMertNXo8BbRyZZak6MfgBihfN5nGWij1rmIMHoHajALo3gtEHW+sZv/FPLmARPuEQBq4td1yhbfdFGGWJ6q9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h55s76dM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0046078so7710505e9.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778959282; x=1779564082; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hORsZ0lF+2IhvjNKlpi2MPEmhmAHK+ddvNGFULLRIaU=;
        b=h55s76dM+FU8j+Qmf6BavBe+pqIHOMYMpzXHdHTI2wu1b6x1cRENqoxsKQKilo2pXY
         EXTwYw1aKZM+6SLOQ005CBfpmtmtndLXqp697Svm7U3pZI9ml3QRftb+AALBSxt/Vwwz
         EgzO7lWkMfXlvpRQR5COky5AyfO42n4bs7lSVviiRUvv00ixqUPy1rMW1bvyvzcyR+xG
         TwgE1Hzi7TaS9VVxIEQTN0ph5XYwI58BFgI2vxwx2FoBHdEFRrxGAuFuS1MNP510YaqC
         Pcekdt64E5a8147qY8cR0keVfiPpaZX1wOka4Trj6LnK1cJRy0wEjfgeWqwGQ2wFupbl
         41oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778959282; x=1779564082;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hORsZ0lF+2IhvjNKlpi2MPEmhmAHK+ddvNGFULLRIaU=;
        b=TAHCgR3atgB8FeRLuVc5Qxl9k3I7N3g1TjBevmzjd68Oytd1U4ouuYWCT0qHdwlx/x
         OnY0q7fPjPIUX5D9eUvg+7JOXxq08mOuX4qET2rC64a9IufXs2eIl6nWM7arUQVykb1h
         IFzM4hh3fzLjnjbsDin21kRuUQr7kaFOtKjr3tHtrUxMRaiy8Nzy4PxZHzsMPQbTelI/
         cr/2lI6hRAhs3X/C+jsMs25UCm7BtamkQo4GGRofSguVFHLPT80ikvoRDoD4x/GXekXJ
         1S8SmsMUWQRuJhs457CxFh2iEvzRzv/zsDtyfyXirFPqWhHq483UGk9s02+WLbooKgWf
         85pA==
X-Forwarded-Encrypted: i=1; AFNElJ+hSeQ588S6Bcf9qyXBXU2CxZkM1qJLB5Lnq6MJmgWvmO6v8UoUgv9Y+bQ2XbgRxW+eJJ0rlr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cT3EKZSu5d3viDvtC/1DfasB1k2h5uCmIEh4gF2UUFtswMT7
	jhhhkrkzhlMq4l9Kq5Fxr2+LRGs5dk4yxKbAV5q+T/bM04eHPoEYiqyeLF5EKSO1
X-Gm-Gg: Acq92OH19oHDqmOg8xT/Hb25w8r+oQFMASNzTGvZMlBxUAM77b+5zy2NmfesPaHAXmI
	1jrqeCdEGuvHIuRnO7cwpub7LMDFuEDnvDgumqARMFurT+rOvspELqNoswWVGWy77mfSUSzogTu
	TBBalot4UWxWCxpLrvPPm28vJpTkhyIwZqZbhXXaoS3oG8ILdSw/viQoGz2leSFL04zfD06WP8g
	eByQb6fAdPvZ4mFFnQygAT1wjstO8LTeNPMUSyEEUN05GPCbsWFXVZDU/FGDYTcPZ/NYTx9+TGd
	z8E2Uz2CZrTQu/iMyX7hUNkeA3oAiSokPcW5i1KDtvwEFGC8SoWujl4/oDtU0RV17E8NHPM++2B
	ngFDF7ktudT2FaOin1v1XmP/BZTas1nPvorMyUhynE1aKA6NJl5tH0q7lVBDIJca8b+BoTY0gzQ
	r8b4RYa1rKba+dKrZb36uWykoSgw7uwxfYLcNaF75dmwXwAUCd
X-Received: by 2002:a05:600c:6592:b0:48a:557e:6b4f with SMTP id 5b1f17b1804b1-48fe62f8861mr126830015e9.23.1778959281845;
        Sat, 16 May 2026 12:21:21 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm143781825e9.2.2026.05.16.12.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 12:21:21 -0700 (PDT)
Date: Sat, 16 May 2026 21:21:19 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org, lkp@intel.com,
	oe-lkp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] selftests/landlock: Filter dealloc records in
 audit_count_records()
Message-ID: <20260516.781b8f7cc1a3@gnoack.org>
References: <20260513105112.140137-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513105112.140137-1-mic@digikod.net>
X-Rspamd-Queue-Id: B79EF55D88D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249034-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Wed, May 13, 2026 at 12:51:08PM +0200, Mickaël Salaün wrote:
> audit_count_records() counts both AUDIT_LANDLOCK_DOMAIN allocation and
> deallocation records in records.domain .  Domain deallocation is tied to
> asynchronous credential freeing via kworker threads
> (landlock_put_ruleset_deferred), so the dealloc record can arrive after
> the drain in audit_init() and after the preceding audit_match_record()
> call.  This causes flaky failures in tests that assert an exact
> records.domain count: a stale dealloc record from a previous test's
> domain inflates the count by one.
> 
> Observed on x86_64 under build configurations that delay the kworker
> firing the dealloc callback (e.g. coverage instrumentation): the
> audit_layout1 tests in fs_test.c intermittently saw records.domain == 2
> where 1 was expected.  The fix is in the shared helper, so those
> existing checks become robust without needing a fs_test.c edit.
> 
> Filter audit_count_records() with a regex to skip records containing
> deallocation status.  The remaining domain records (allocation, emitted
> synchronously during landlock_log_denial()) are deterministic.
> Deallocation records are already tested explicitly via
> matches_log_domain_deallocated() in audit_test.c, which uses its own
> domain-ID-based filtering and longer timeout.
> 
> With this filter in place, re-add the records.domain == 0 checks that
> were removed in commit 3647a4977fb7 ("selftests/landlock: Drain stale
> audit records on init") as a workaround for this race.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Depends-on: 07c2572a8757 ("selftests/landlock: Skip stale records in audit_match_record()")
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/audit.h      | 39 ++++++++++++-------
>  tools/testing/selftests/landlock/audit_test.c |  2 +
>  .../testing/selftests/landlock/ptrace_test.c  |  1 +
>  .../landlock/scoped_abstract_unix_test.c      |  1 +
>  4 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 834005b2b0f0..699aed5ffab4 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -381,18 +381,24 @@ struct audit_records {
>  };
>  
>  /*
> - * WARNING: Do not assert records.domain == 0 without a preceding
> - * audit_match_record() call.  Domain deallocation records are emitted
> - * asynchronously from kworker threads and can arrive after the drain in
> - * audit_init(), corrupting the domain count.  A preceding audit_match_record()
> - * call consumes stale records while scanning, making the assertion safe in
> - * practice because stale deallocation records arrive before the expected access
> - * records.
> + * Counts remaining audit records by type, skipping domain deallocation records.
> + * Deallocation records are emitted asynchronously from kworker threads after a
> + * previous test's child has exited, so they can arrive after the drain in
> + * audit_init() and after the preceding audit_match_record() call.  Allocation
> + * records are emitted synchronously during landlock_log_denial() in the current
> + * test's syscall context, so only those are counted in records->domain.
>   */
>  static int audit_count_records(int audit_fd, struct audit_records *records)
>  {
> +	static const char dealloc_pattern[] = REGEX_LANDLOCK_PREFIX
> +		" status=deallocated ";
>  	struct audit_message msg;
> -	int err;
> +	regex_t dealloc_re;
> +	int ret, err = 0;
> +
> +	ret = regcomp(&dealloc_re, dealloc_pattern, 0);
> +	if (ret)
> +		return -ENOMEM;
>  
>  	records->access = 0;
>  	records->domain = 0;
> @@ -402,9 +408,8 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
>  		err = audit_recv(audit_fd, &msg);
>  		if (err) {
>  			if (err == -EAGAIN)
> -				return 0;
> -			else
> -				return err;
> +				err = 0;
> +			break;
>  		}
>  
>  		switch (msg.header.nlmsg_type) {
> @@ -412,12 +417,20 @@ static int audit_count_records(int audit_fd, struct audit_records *records)
>  			records->access++;
>  			break;
>  		case AUDIT_LANDLOCK_DOMAIN:
> -			records->domain++;
> +			ret = regexec(&dealloc_re, msg.data, 0, NULL, 0);
> +			if (ret == REG_NOMATCH) {
> +				records->domain++;
> +			} else if (ret != 0) {
> +				err = -EIO;
> +				goto out;
> +			}
>  			break;
>  		}
>  	} while (true);
>  
> -	return 0;
> +out:
> +	regfree(&dealloc_re);
> +	return err;
>  }
>  
>  static int audit_init(void)
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 93ae5bd0dcce..758cf2368281 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -730,6 +730,7 @@ TEST_F(audit_flags, signal)
>  		} else {
>  			EXPECT_EQ(1, records.access);
>  		}
> +		EXPECT_EQ(0, records.domain);
>  
>  		/* Updates filter rules to match the drop record. */
>  		set_cap(_metadata, CAP_AUDIT_CONTROL);
> @@ -917,6 +918,7 @@ TEST_F(audit_exec, signal_and_open)
>  	/* Tests that there was no denial until now. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
>  
>  	/*
>  	 * Wait for the child to do a first denied action by layer1 and
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index 1b6c8b53bf33..4f64c90583cd 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -342,6 +342,7 @@ TEST_F(audit, trace)
>  	/* Makes sure there is no superfluous logged records. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
>  
>  	yama_ptrace_scope = get_yama_ptrace_scope();
>  	ASSERT_LE(0, yama_ptrace_scope);
> diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> index c47491d2d1c1..72f97648d4a7 100644
> --- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> @@ -312,6 +312,7 @@ TEST_F(scoped_audit, connect_to_child)
>  	/* Makes sure there is no superfluous logged records. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);
>  
>  	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
>  	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> -- 
> 2.54.0
> 

Tested-by: Günther Noack <gnoack3000@gmail.com>


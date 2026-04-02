Return-Path: <stable+bounces-233109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE2YLaXSzmnKqQYAu9opvQ
	(envelope-from <stable+bounces-233109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:33:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19838E06B
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44D8C3122880
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 20:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBBD390980;
	Thu,  2 Apr 2026 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psTuyY06"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879753909B2
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161721; cv=none; b=MfkcHv3svZlyJAk76unQOa6ZuEBIxqUiaP/ruMG7owit/+OQkyCU0X+51jhiFWmf+lyV2u2eqBzviWNvU4IqU8fR+kZPgRy4WmcCxTvlc2298ttz1CACuC37dbjYFvdwDEYS88A/6iCY7MCdRtX7wBlh2z9NT5S6CoKKtlE5/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161721; c=relaxed/simple;
	bh=lBzQ0jpitKP98ZTAkwFEdHgUVBlphXCaQwQZuiVivOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cybz7MEzQ0oG/XuQDIxA+Fyw+MQ9srVjYPvIAOSr14sLu4qTpQXkXXFTrlGnGNKDpB6E2tx5XBbAHg0+1VtubVZXoKIkAeNgng4YQEYWV5AStooBCMLXdLNiSwKC1oMCgwNWDX2+ujY9x4p6NWFVy94Xks6KKy9SrSJrYb4I9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=psTuyY06; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso746983f8f.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161718; x=1775766518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IY+wvfMpAE2CGN50Lr532tqIAzIHTJ9V6stJxfVHwGE=;
        b=psTuyY06ReF6N+tEPYvtpMWuW8ZiZP1qWRahvGgf4uC7rVOnZ7vtcOVOzy8ucZCkZ8
         Okt07CQiZQtWpltWLgzbiEfXE2LS8WkvUWn88LNRbj1/JiHygHsmWfBSom79IdXJ5ebE
         r5XJo+8O/w+XotnWT/ER6iZcp9JZjoG/Rx4Qcl0K6ooXk+aaiGuCZtaiC65LmmJPZuCd
         9l4/9C0X0pxDOEYzyP/hQcVTUYBZmUx68URWRFQBr2opYil3YUN5lwt/+M6wRxrJp2hg
         eFhgreNGQJBwdikgA9G/YtYZGaS6yAYc3k4LzyQ8uwtWioJ8XkCGrjyluxJFVO50Yauo
         TeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161718; x=1775766518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IY+wvfMpAE2CGN50Lr532tqIAzIHTJ9V6stJxfVHwGE=;
        b=hEn6oSPahcyhXT8Gbq1XbsfPzJCdVB9A+TzCXyM1YLRV0rz+LPhk0hJarzqLbIy1UO
         hBCjj8jZM9cNY9xRdAaWb+19yGS3oYXiIOQabHAY27iEeTnlzvZnYTMeAvNFOoYLTdaW
         d7P6q78iASetWiTTipRspYWhVueQyEMKe5I+EFaR+7oJYwKQbpBH/2rzivsghuSyNamg
         LqMOwFvdubT5CXafZ0luaKaPVsJSke58hkhckikdo1LgxgUt+UtJOYl1gYLrjsF5Zkw0
         jqYq5b+qY/6C5awyK+3RO3J3JcqM4HMzNgOmuFTlbgin9l6gB2wMw3b/Vecd3vew2P49
         u2/w==
X-Forwarded-Encrypted: i=1; AJvYcCU/2e2ts3xZH7xKyT7wpXSP/EFO54wtII3L++xaiU9PlXADRfOMPwVCzirxIMBhcogTqq2IuUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymVD8bvMfqWHmRcWLe8uZ5lDnKaiPfbHCez4rgEbXvpOpQzojm
	eigXRucY1p5Zb9TBO+mVCwTc4dx+aTaXhQadICE3N/wmQRlJq1hNIL4n
X-Gm-Gg: AeBDiesLJeHxdqpNFCs/4LOHarpYW8tunSG4flcJgL8lANf3L3iCZuJz2xm5WMNF1rL
	qaPinSkahQ0jxPZocN+qyTvLkARn/k5F2+XgCClSUOHZS+yNna8LcXj7n7Nv1neAs+JO+cBJWdh
	xeO76/+HzyxgCbeVobePhksZSwWWmsL4uZa+hWlGCwsF6yeZ22iXDw/ViTZVVUurUXUZG3Yd/XP
	iW2glxrqejoEtBUO1JbM/dcoGDh5nU0jjRbBQCl9pRu74oI0PUFL1MTTcug1e+pr6kSPsg6HZmU
	3Vun/9FOhsjZLAnNZn4zvZM/I61pjSBSej6kVk+N/XWwkk9g47SWtSGpFDXTxrar7MqllPPVKkT
	PI/5Z57GgedcMdkkeYM7SOM+BR5J25WnOeSvufsKrhng9SZZ/+Tsz0SmWHvfbWI/OPr1jmTTSrR
	Z+Cl6cyrJeIbxo28iuVj+6Cyea6ckmpyJve8P3q62Q/SozFjhj
X-Received: by 2002:a05:6000:40cc:b0:43c:dc99:771c with SMTP id ffacd0b85a97d-43d292ff698mr629797f8f.42.1775161717704;
        Thu, 02 Apr 2026 13:28:37 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5016sm11002853f8f.33.2026.04.02.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:28:37 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:28:35 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/5] selftests/landlock: Drain stale audit records on
 init
Message-ID: <20260402.91698fca8a06@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402192608.1458252-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-4-mic@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233109-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,maowtm.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnoack.org:mid,digikod.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F19838E06B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:26:04PM +0200, Mickaël Salaün wrote:
> Non-audit Landlock tests generate audit records as side effects when
> audit_enabled is non-zero (e.g. from boot configuration).  These records
> accumulate in the kernel audit backlog while no audit daemon socket is
> open.  When the next test opens a new netlink socket and registers as
> the audit daemon, the stale backlog is delivered, causing baseline
> record count checks to fail spuriously.
> 
> Fix this by draining all pending records in audit_init() right after
> setting the receive timeout.  The 1-usec SO_RCVTIMEO causes audit_recv()
> to return -EAGAIN once the backlog is empty, naturally terminating the
> drain loop.
> 
> Domain deallocation records are emitted asynchronously from a work
> queue, so they may still arrive after the drain.  Remove records.domain
> == 0 checks that are not preceded by audit_match_record() calls, which
> would otherwise consume stale records before the count.  Document this
> constraint above audit_count_records().
> 
> Increasing the drain timeout to catch in-flight deallocation records was
> considered but rejected: a longer timeout adds latency to every
> audit_init() call even when no stale record is pending, and any fixed
> timeout is still not guaranteed to catch all records under load.
> Removing the unprotected checks is simpler and avoids the spurious
> failures.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
> - Also remove domain checks from audit.trace and
>   scoped_audit.connect_to_child.
> - Document records.domain == 0 constraint above
>   audit_count_records().
> - Explain why a longer drain timeout was rejected.
> - Drop Reviewed-by (new code comment not in v1).
> - Split snprintf and fd leak fixes into separate patches.
> ---
>  tools/testing/selftests/landlock/audit.h      | 19 +++++++++++++++++++
>  tools/testing/selftests/landlock/audit_test.c |  2 --
>  .../testing/selftests/landlock/ptrace_test.c  |  1 -
>  .../landlock/scoped_abstract_unix_test.c      |  1 -
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 6422943fc69e..74e1c3d763be 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -338,6 +338,15 @@ struct audit_records {
>  	size_t domain;
>  };
>  
> +/*
> + * WARNING: Do not assert records.domain == 0 without a preceding
> + * audit_match_record() call.  Domain deallocation records are emitted
> + * asynchronously from kworker threads and can arrive after the drain in
> + * audit_init(), corrupting the domain count.  A preceding audit_match_record()
> + * call consumes stale records while scanning, making the assertion safe in
> + * practice because stale deallocation records arrive before the expected access
> + * records.
> + */
>  static int audit_count_records(int audit_fd, struct audit_records *records)
>  {
>  	struct audit_message msg;
> @@ -393,6 +402,16 @@ static int audit_init(void)
>  		goto err_close;
>  	}
>  
> +	/*
> +	 * Drains stale audit records that accumulated in the kernel backlog
> +	 * while no audit daemon socket was open.  This happens when non-audit
> +	 * Landlock tests generate records while audit_enabled is non-zero (e.g.
> +	 * from boot configuration), or when domain deallocation records arrive
> +	 * asynchronously after a previous test's socket was closed.
> +	 */
> +	while (audit_recv(fd, NULL) == 0)
> +		;
> +
>  	return fd;
>  
>  err_close:
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 46d02d49835a..f92ba6774faa 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -412,7 +412,6 @@ TEST_F(audit_flags, signal)
>  		} else {
>  			EXPECT_EQ(1, records.access);
>  		}
> -		EXPECT_EQ(0, records.domain);
>  
>  		/* Updates filter rules to match the drop record. */
>  		set_cap(_metadata, CAP_AUDIT_CONTROL);
> @@ -601,7 +600,6 @@ TEST_F(audit_exec, signal_and_open)
>  	/* Tests that there was no denial until now. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> -	EXPECT_EQ(0, records.domain);
>  
>  	/*
>  	 * Wait for the child to do a first denied action by layer1 and
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
> index 4f64c90583cd..1b6c8b53bf33 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -342,7 +342,6 @@ TEST_F(audit, trace)
>  	/* Makes sure there is no superfluous logged records. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> -	EXPECT_EQ(0, records.domain);
>  
>  	yama_ptrace_scope = get_yama_ptrace_scope();
>  	ASSERT_LE(0, yama_ptrace_scope);
> diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> index 72f97648d4a7..c47491d2d1c1 100644
> --- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> +++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
> @@ -312,7 +312,6 @@ TEST_F(scoped_audit, connect_to_child)
>  	/* Makes sure there is no superfluous logged records. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> -	EXPECT_EQ(0, records.domain);
>  
>  	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
>  	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>


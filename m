Return-Path: <stable+bounces-233517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHHbI63A1GmWwwcAu9opvQ
	(envelope-from <stable+bounces-233517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:30:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEAD3AB5E2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D2730515D2
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003C3A4F35;
	Tue,  7 Apr 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtUMATAr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0BA3A4537
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550336; cv=none; b=Ic4roYCaMQs+1Rw6sDEz/tPs2pM9txi/dswVVOVTnX76Jr7hTr56ww4G3DvrOL499Unr5LyQkHiYgI6NrAiVm2iRTXSntlvlj/FHlC724AKkOgRJ4CNp1Y0rJ5cxzAilgwfDLECuBEPe7e02ol6DR21qZueCItkv002oDHn4lqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550336; c=relaxed/simple;
	bh=GusHu8Xmn5kuaojOYlB/Zy4ZfogRdeMyIBjXJker584=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux1eZaENE5EY1Sbqoek/ZplagXdi1J/wL3zo1NQMjrqVqJS5kMQAnhuU/JUpQD6aKQ9Mh3B5Lr4FNJxMDMMEq5RCmNMP0L0o7mDT75QXdsLsAxK00y/K6DFSxLjf1e9gShVTBfTzPXlGdPyBElslNZxabh8HpHuOabyv4PsO+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtUMATAr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d02a71526so2719515f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550332; x=1776155132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Qivd73jyjPzYJhuaYmeoZeCmH8Sla6ySONTMHG986w=;
        b=NtUMATArGHVbVgzlj3EiNEjX9aje/BZqUiihfcYWKdvU+W9xBzZ2LL164YgLg2hcmx
         ahFLt3vOheupExBoHrwFvOq6PptnqpU92KpVXjPYFYkcCWR8TviY8Ve+uzx016iobdEP
         h3WzJOfJc9oiZyN6EvlsE8RGWi57u/uc3LFG+SEklD3MI6OgbiNp/A44rM8/xjtHa85/
         RN8thzdvCoc7qt1hnE1GwtpIxTbvSXbuTgLHFDivmHYVApjtAyO1fCe2wBtXlWjK5YkJ
         lM3VWkSBLf4NWVajcTQ2FLHuVpQAWEGxYINxeTNWiUe+hQuIQzM8LtIFYB/oKrQaGtAd
         3JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550332; x=1776155132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qivd73jyjPzYJhuaYmeoZeCmH8Sla6ySONTMHG986w=;
        b=P5tgvH1iGItmglUxsREEhxCTRgbxLUU6hTWhmPjUFAY3YtoWIjcYw9NmW9PzjEO6BY
         bnrEFtvrkyhgPBXWWbqpVhLfiZDzcBoMYXmsZuA1P1EecQPFjSK6eOOGsbnDVecYtWC2
         v97jXY7e64loSRKVtlETuO7beY79eOpCuBpnTq3/33Mcy9WLi+kky5270SGLk9hKxerh
         sKQ+20bB+eeS4vNUMoOkTEiDg54NYryIaSd57np/7hGWrcY0ZiulouyslD3KwlTNm+qp
         1JYwXp5Xd+soPz/Mw1QeO7s8Oi3WckKsVzKh/xilM2Bl2nMvF8CFo2NMF8yZE/x/Ay2z
         YPHg==
X-Forwarded-Encrypted: i=1; AJvYcCXKyC+ygAbTPLR4lVIS95Es4PP8d1S1p4847t/62qZK4ayRKhNOkEa69KhG5yE090tXASPWyIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDROBBFeSIfI/HJZtwszUljd015Q+UZAeFwJ/ZXLxzase95OOE
	FTtdrbXJorGIo78taDLAZ4N+Zsrgx/eXYSBir9btMlhcNN3ngREY1SFC7xq8vL9Z
X-Gm-Gg: AeBDievqXFXvQw7V1iMhbYPPpxn9b30y+CafUL9l7B7mId+RRvCNEv+4cZpwuUWNCg3
	sG7SM6B1VCrWs9alxWD2mAdswpTxVObxmIuh8wbKNXJDDiF+eLLh7FVXNO9QWX/avGyQSXhN7P+
	TuNWpmFk4Pu/dobZK66JnrcLrslwFIvoLkZdCjasEI3gz9pKfE/iK2E3f6lepAJD+HGN0mvQjXt
	X8JWC6+Q06DA8Ab6xXe3TVMx31xunxr7tzHk6+oURkm+KpIfYVedNmnpd6rssW/2ywSil4U8uqH
	k7VO0d50MW9UAtrIm7b6J+yLrD5f4uWDjIdi2nRHZcyAY+8ZWx8c4e25rjKKGzL0BsyuSx1fTcY
	7EWUsdWYY3jhzj+6FozZDJ3XL0O6ur41klSOiAdgRVGuAOzZfYksk8EGAH48FcM/5Jk78ZV73Ct
	nDz8C4jYkFF6V8HykD0vV7w1Gxx4gJ5ftDeeUzmoj3H7xNK+K/KoyMCi1t6SY=
X-Received: by 2002:a05:6000:250e:b0:43c:f81f:3e78 with SMTP id ffacd0b85a97d-43d2927f674mr22606321f8f.5.1775550332178;
        Tue, 07 Apr 2026 01:25:32 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d282esm47920515f8f.18.2026.04.07.01.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:25:31 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:25:30 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] landlock: Allow TSYNC with LOG_SUBDOMAINS_OFF and
 fd=-1
Message-ID: <20260407.7d922b20e863@gnoack.org>
References: <20260404085001.1604405-1-mic@digikod.net>
 <20260404085001.1604405-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260404085001.1604405-2-mic@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233517-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnoack.org:mid,digikod.net:email]
X-Rspamd-Queue-Id: CDEAD3AB5E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello!

On Sat, Apr 04, 2026 at 10:49:58AM +0200, Mickaël Salaün wrote:
> LANDLOCK_RESTRICT_SELF_TSYNC does not allow
> LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with ruleset_fd=-1, preventing
> a multithreaded process from atomically propagating subdomain log muting
> to all threads without creating a domain layer.  Relax the fd=-1
> condition to accept TSYNC alongside LOG_SUBDOMAINS_OFF, and update the
> documentation accordingly.
> 
> Add flag validation tests for all TSYNC combinations with ruleset_fd=-1,
> and audit tests verifying both transition directions: muting via TSYNC
> (logged to not logged) and override via TSYNC (not logged to logged).
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/uapi/linux/landlock.h                 |   4 +-
>  security/landlock/syscalls.c                  |  14 +-
>  tools/testing/selftests/landlock/audit_test.c | 233 ++++++++++++++++++
>  tools/testing/selftests/landlock/tsync_test.c |  74 ++++++
>  4 files changed, 319 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f88fa1f68b77..d37603efc273 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -116,7 +116,9 @@ struct landlock_ruleset_attr {
>   *     ``LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF``, this flag only affects
>   *     future nested domains, not the one being created. It can also be used
>   *     with a @ruleset_fd value of -1 to mute subdomain logs without creating a
> - *     domain.
> + *     domain.  When combined with %LANDLOCK_RESTRICT_SELF_TSYNC and a
> + *     @ruleset_fd value of -1, this configuration is propagated to all threads
> + *     of the current process.
>   *
>   * The following flag supports policy enforcement in multithreaded processes:
>   *
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0d66a68677b7..a0bb664e0d31 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -512,10 +512,13 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  
>  	/*
>  	 * It is allowed to set LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with
> -	 * -1 as ruleset_fd, but no other flag must be set.
> +	 * -1 as ruleset_fd, optionally combined with
> +	 * LANDLOCK_RESTRICT_SELF_TSYNC to propagate this configuration to all
> +	 * threads.  No other flag must be set.
>  	 */
>  	if (!(ruleset_fd == -1 &&
> -	      flags == LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
> +	      (flags & ~LANDLOCK_RESTRICT_SELF_TSYNC) ==
> +		      LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {

Well spotted, thanks!


>  		/* Gets and checks the ruleset. */
>  		ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
>  		if (IS_ERR(ruleset))
> @@ -537,9 +540,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
>  
>  	/*
>  	 * The only case when a ruleset may not be set is if
> -	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set and ruleset_fd is -1.
> -	 * We could optimize this case by not calling commit_creds() if this flag
> -	 * was already set, but it is not worth the complexity.
> +	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF is set (optionally with
> +	 * LANDLOCK_RESTRICT_SELF_TSYNC) and ruleset_fd is -1.  We could
> +	 * optimize this case by not calling commit_creds() if this flag was
> +	 * already set, but it is not worth the complexity.
>  	 */
>  	if (ruleset) {
>  		/*
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 20099b8667e7..a193d8a97560 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -162,6 +162,7 @@ TEST_F(audit, layers)
>  struct thread_data {
>  	pid_t parent_pid;
>  	int ruleset_fd, pipe_child, pipe_parent;
> +	bool mute_subdomains;
>  };
>  
>  static void *thread_audit_test(void *arg)
> @@ -367,6 +368,238 @@ TEST_F(audit, log_subdomains_off_fork)
>  	EXPECT_EQ(0, close(ruleset_fd));
>  }
>  
> +/*
> + * Thread function: runs two rounds of (create domain, trigger denial, signal
> + * back), waiting for the main thread before each round.  When mute_subdomains
> + * is set, phase 1 also mutes subdomain logs via the fd=-1 path before creating
> + * the domain.  The ruleset_fd is kept open across both rounds so each
> + * restrict_self call stacks a new domain layer.
> + */
> +static void *thread_sandbox_deny_twice(void *arg)
> +{
> +	const struct thread_data *data = (struct thread_data *)arg;
> +	uintptr_t err = 0;
> +	char buffer;
> +
> +	/* Phase 1: optionally mutes, creates a domain, and triggers a denial. */
> +	if (read(data->pipe_parent, &buffer, 1) != 1) {
> +		err = 1;
> +		goto out;
> +	}
> +
> +	if (data->mute_subdomains &&
> +	    landlock_restrict_self(-1,
> +				   LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF)) {
> +		err = 2;
> +		goto out;
> +	}
> +
> +	if (landlock_restrict_self(data->ruleset_fd, 0)) {
> +		err = 3;
> +		goto out;
> +	}
> +
> +	if (kill(data->parent_pid, 0) != -1 || errno != EPERM) {
> +		err = 4;
> +		goto out;
> +	}
> +
> +	if (write(data->pipe_child, ".", 1) != 1) {
> +		err = 5;
> +		goto out;
> +	}
> +
> +	/* Phase 2: stacks another domain and triggers a denial. */
> +	if (read(data->pipe_parent, &buffer, 1) != 1) {
> +		err = 6;
> +		goto out;
> +	}
> +
> +	if (landlock_restrict_self(data->ruleset_fd, 0)) {
> +		err = 7;
> +		goto out;
> +	}
> +
> +	if (kill(data->parent_pid, 0) != -1 || errno != EPERM) {
> +		err = 8;
> +		goto out;
> +	}
> +
> +	if (write(data->pipe_child, ".", 1) != 1) {
> +		err = 9;
> +		goto out;
> +	}
> +
> +out:
> +	close(data->ruleset_fd);
> +	close(data->pipe_child);
> +	close(data->pipe_parent);
> +	return (void *)err;
> +}
> +
> +/*
> + * Verifies that LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF with
> + * LANDLOCK_RESTRICT_SELF_TSYNC and ruleset_fd=-1 propagates log_subdomains_off
> + * to a sibling thread, suppressing audit logging on domains it subsequently
> + * creates.
> + *
> + * Phase 1 (before TSYNC) acts as an inline baseline: the sibling creates a
> + * domain and triggers a denial that IS logged.
> + *
> + * Phase 2 (after TSYNC) verifies suppression: the sibling stacks another domain
> + * and triggers a denial that is NOT logged.
> + */
> +TEST_F(audit, log_subdomains_off_tsync)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> +	};
> +	struct audit_records records;
> +	struct thread_data child_data;

The child_data.mute_subdomains field stays uninitialized in this
function (and maybe others).  Please fix.

   struct thread_data child_data = {};


> +	int pipe_child[2], pipe_parent[2];
> +	char buffer;
> +	pthread_t thread;
> +	void *thread_ret;
> +
> +	child_data.parent_pid = getppid();
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +	child_data.pipe_child = pipe_child[1];
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +	child_data.pipe_parent = pipe_parent[0];
> +	child_data.ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, child_data.ruleset_fd);
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	/* Creates the sibling thread. */
> +	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_sandbox_deny_twice,
> +				    &child_data));
> +
> +	/*
> +	 * Phase 1: the sibling creates a domain and triggers a denial before
> +	 * any log muting.  This proves the audit path works.
> +	 */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
> +
> +	/* The denial must be logged. */
> +	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
> +					child_data.parent_pid, NULL));
> +
> +	/* Drains any remaining records (e.g. domain allocation). */
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +
> +	/*
> +	 * Mutes subdomain logs and propagates to the sibling thread via TSYNC,
> +	 * without creating a domain.
> +	 */
> +	ASSERT_EQ(0, landlock_restrict_self(
> +			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
> +					 LANDLOCK_RESTRICT_SELF_TSYNC));
> +
> +	/*
> +	 * Phase 2: the sibling stacks another domain and triggers a denial.
> +	 * Because log_subdomains_off was propagated via TSYNC, the new domain
> +	 * has log_status=LANDLOCK_LOG_DISABLED.
> +	 */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
> +
> +	/* No denial record should appear. */
> +	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
> +					      child_data.parent_pid, NULL));
> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +
> +	EXPECT_EQ(0, close(pipe_child[0]));
> +	EXPECT_EQ(0, close(pipe_parent[1]));
> +	ASSERT_EQ(0, pthread_join(thread, &thread_ret));
> +	EXPECT_EQ(NULL, thread_ret);
> +}
> +
> +/*
> + * Verifies that LANDLOCK_RESTRICT_SELF_TSYNC without
> + * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF overrides a sibling thread's
> + * log_subdomains_off, re-enabling audit logging on domains the sibling
> + * subsequently creates.
> + *
> + * Phase 1: the sibling sets log_subdomains_off, creates a muted domain, and
> + * triggers a denial that is NOT logged.
> + *
> + * Phase 2 (after TSYNC without LOG_SUBDOMAINS_OFF): the sibling stacks another
> + * domain and triggers a denial that IS logged, proving the muting was
> + * overridden.
> + */
> +TEST_F(audit, tsync_override_log_subdomains_off)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> +	};
> +	struct audit_records records;
> +	struct thread_data child_data;
> +	int pipe_child[2], pipe_parent[2];
> +	char buffer;
> +	pthread_t thread;
> +	void *thread_ret;
> +
> +	child_data.parent_pid = getppid();
> +	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
> +	child_data.pipe_child = pipe_child[1];
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +	child_data.pipe_parent = pipe_parent[0];
> +	child_data.ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, child_data.ruleset_fd);
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	child_data.mute_subdomains = true;
> +
> +	/* Creates the sibling thread. */
> +	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_sandbox_deny_twice,
> +				    &child_data));
> +
> +	/*
> +	 * Phase 1: the sibling mutes subdomain logs, creates a domain, and
> +	 * triggers a denial.  The denial must not be logged.
> +	 */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
> +
> +	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
> +					      child_data.parent_pid, NULL));
> +
> +	/* Drains any remaining records. */
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +
> +	/*
> +	 * Overrides the sibling's log_subdomains_off by calling TSYNC without
> +	 * LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.
> +	 */
> +	ASSERT_EQ(0, landlock_restrict_self(child_data.ruleset_fd,
> +					    LANDLOCK_RESTRICT_SELF_TSYNC));
> +
> +	/*
> +	 * Phase 2: the sibling stacks another domain and triggers a denial.
> +	 * Because TSYNC replaced its log_subdomains_off with 0, the new domain
> +	 * has log_status=LANDLOCK_LOG_PENDING.
> +	 */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +	ASSERT_EQ(1, read(pipe_child[0], &buffer, 1));
> +
> +	/* The denial must be logged. */
> +	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd,
> +					child_data.parent_pid, NULL));
> +
> +	EXPECT_EQ(0, close(pipe_child[0]));
> +	EXPECT_EQ(0, close(pipe_parent[1]));
> +	ASSERT_EQ(0, pthread_join(thread, &thread_ret));
> +	EXPECT_EQ(NULL, thread_ret);
> +}
> +
>  FIXTURE(audit_flags)
>  {
>  	struct audit_filter audit_filter;
> diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
> index 2b9ad4f154f4..abc290271a1a 100644
> --- a/tools/testing/selftests/landlock/tsync_test.c
> +++ b/tools/testing/selftests/landlock/tsync_test.c
> @@ -247,4 +247,78 @@ TEST(tsync_interrupt)
>  	EXPECT_EQ(0, close(ruleset_fd));
>  }
>  
> +/* clang-format off */
> +FIXTURE(tsync_without_ruleset) {};
> +/* clang-format on */
> +
> +FIXTURE_VARIANT(tsync_without_ruleset)
> +{
> +	const __u32 flags;
> +	const int expected_errno;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tsync_without_ruleset, tsync_only) {
> +	/* clang-format on */
> +	.flags = LANDLOCK_RESTRICT_SELF_TSYNC,
> +	.expected_errno = EBADF,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tsync_without_ruleset, subdomains_off_same_exec_off) {
> +	/* clang-format on */
> +	.flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
> +		 LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
> +		 LANDLOCK_RESTRICT_SELF_TSYNC,
> +	.expected_errno = EBADF,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tsync_without_ruleset, subdomains_off_new_exec_on) {
> +	/* clang-format on */
> +	.flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
> +		 LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +		 LANDLOCK_RESTRICT_SELF_TSYNC,
> +	.expected_errno = EBADF,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tsync_without_ruleset, all_flags) {
> +	/* clang-format on */
> +	.flags = LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF |
> +		 LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
> +		 LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
> +		 LANDLOCK_RESTRICT_SELF_TSYNC,
> +	.expected_errno = EBADF,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(tsync_without_ruleset, subdomains_off) {
> +	/* clang-format on */
> +	.flags = LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
> +		 LANDLOCK_RESTRICT_SELF_TSYNC,
> +	.expected_errno = 0,
> +};
> +
> +FIXTURE_SETUP(tsync_without_ruleset)
> +{
> +}
> +
> +FIXTURE_TEARDOWN(tsync_without_ruleset)
> +{
> +}
> +
> +TEST_F(tsync_without_ruleset, check)
> +{
> +	int ret;
> +
> +	ret = landlock_restrict_self(-1, variant->flags);
> +	if (variant->expected_errno) {
> +		EXPECT_EQ(-1, ret);
> +		EXPECT_EQ(variant->expected_errno, errno);
> +	} else {
> +		EXPECT_EQ(0, ret);
> +	}
> +}

We are not setting the no_new_privs flag in this test, as we do in the
others.

no_new_privs or CAP_SYS_ADMIN are required in the implementation, even
when ruleset_fd == -1 and passing
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.

> +
>  TEST_HARNESS_MAIN
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

But please fix the flaky test.

–Günther


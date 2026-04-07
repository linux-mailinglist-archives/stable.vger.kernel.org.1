Return-Path: <stable+bounces-233508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDmhOPKy1GnvwQcAu9opvQ
	(envelope-from <stable+bounces-233508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:32:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8313AACDE
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 09:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740BF30315D5
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE401EA7CE;
	Tue,  7 Apr 2026 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyQpwHU2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277825F99F
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547051; cv=none; b=M8H0xgmi0pdzo6JZz8WwsHRNObep7oVy53KLNtaT6Rv6q/Z8OuA0ruiw0UG6c1RfWsTW6GxXa3hvgAreaGNMCNLy2/7uUdPbtjJ7Z4SDVUNyHm5PumAdIZEOniW4yFrpONqIjfToByqfz/eLXNq9iRKA5Y7lY86IMyF3TR6fvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547051; c=relaxed/simple;
	bh=E5y3k0mXPzH/qxF0YXQt/DX16DB+M6XnhTappRzq0Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jks6bqrB9TxAbnC+S2sWiDmWvc67d1z9O+SucUPRyiS7qOks+unBhaQO/6QPMggVN8nofwo/dkB/kYrzIL4Z4x0UIJGvklPSaHZ8GDyuYBmfai20XTFnhkC3Pocg7T9h6e8UQDe3RojnzYtKt3j3ppAl4IXLjWZ2KECIrw57Kww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyQpwHU2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso41605415e9.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 00:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775547048; x=1776151848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jTmaz406rgb4TnsgCDoTRBShvc8OZfMO2qi0BTEdttE=;
        b=TyQpwHU2KH1lemNw0511fliyChdjeUH0wBAbbDX1ioxb0IMazfX9LTcOyMNSS8SIPA
         OI0zAz0MglLgLv03XO8nRNpNtYHgqvOXOMD3v7PF0COy3FW0fkKi3znl/XuemzvV75/P
         IuTuC069EQnCwzogCl8QJkVUQ9jEcmb+UgmRyE7E1LEodMjNny7WWod1ihMPfKXnz5ns
         20gqDuvak62CQ8cGRvycp6FohKG0ltWfQuKoBJFsnXUHBe3OZvmSPJ+IcqainPy0BZzA
         9XGz/IJLwXLTBfBcreR44MWb6U6Vf8j8dPzB0Pn9zwmjnwIR920RFJ6jbDi/rLFOQDgD
         okGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775547048; x=1776151848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTmaz406rgb4TnsgCDoTRBShvc8OZfMO2qi0BTEdttE=;
        b=lz9CZwnj8drn4+X1X3jh67qvg1HMObSoJ73ud+lVWSp0uK9mZHL5fB5h8x0PsJpXa0
         1fMv9m+/rpeKegI9EFD/1MyMeGPqpDdgXfNJvk8QaCBYuMF8axAcyNejp9R6GaeTva3T
         vIUIuEPJZOzQOxIDgWi3uBhGuLNCDxeON0pDlN7t58BznKERuMfozJVFOZqfc0m92gnp
         EoPT6A5uOlx2IydcK4qqgPgPwtiWWVsdDJxzNBHDHhzspFjqVRQzsk9u/ciXlerSRWf9
         KBJm7702Q5QU75tCjFsQ334HYmmPJSMDEQkNkFlqN7zj++kcozfy5mnNcvMVIMcb0BKh
         oL6g==
X-Forwarded-Encrypted: i=1; AJvYcCWwbdONa4yRvBtNhJK4R/fc2BKtIjewplDR/VyJHEAjR4iudqG9ygBdG3uptF/xrYdg/EFHvko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5F20T7Ee2Tn0BcBs1Pbk36Vnhys2tY+xn0xJUXiRKVrpIQ3Kf
	gbi+hjAYa8FvgtXOh8oXshuNZoCHAiERWZg5u0UGtr1+ijCVtO0x5yx/
X-Gm-Gg: AeBDieu40MC/AAg6JZEhsJpw4JCCegGvXgrX7cMpkNz+aQG6Jq+rnc8Btb5b6zv0wp7
	E+bgGotlzVjQkb6il6bjFS2Gnrxn8FAyPzMk6OqxU7FgF5U+SlHzVmpP51f2gKGLIQg/Y48TEEt
	hdjTQjnk/PATwXlx5hGzsuoK65JnnS4DzYHSCUelFFd4ah2au4EnorKvOr5mB4m/G2F+RZFzPOu
	jHDOudMgjGdYbDYqfXL3G2DjmH5AdIGrt0vT2lAXLKVjMhXWCrY+VZbpDCgP3Qy8wfUTV2Ykg3a
	vk6ThJ3lyhdwef4H9TaQf8ZVgyBHzCnr5bJDcm6VAw+ee2tEXDBcheDVBZhlxjBIIVHTAnhxZeQ
	/zD48M/p77tGDJm9GTvJSKkL1goya3nk7nLfEehAEGkqp8IiI+6YngGwF+nzpcZAqa4C7VZWckw
	gUqwc7yG/DsZ8nlIN6JRzvW+kbhVru6+Avc0ol6u2dctXvr4nP
X-Received: by 2002:a05:600c:138f:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4889970e3c4mr215358595e9.11.1775547047220;
        Tue, 07 Apr 2026 00:30:47 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm330139725e9.12.2026.04.07.00.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:30:46 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:30:40 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Fix log_subdomains_off inheritance
 across fork()
Message-ID: <20260407.844e42deb531@gnoack.org>
References: <20260404085001.1604405-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260404085001.1604405-1-mic@digikod.net>
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
	TAGGED_FROM(0.00)[bounces-233508-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,digikod.net:email,gnoack.org:mid]
X-Rspamd-Queue-Id: 3C8313AACDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello!

On Sat, Apr 04, 2026 at 10:49:57AM +0200, Mickaël Salaün wrote:
> hook_cred_transfer() only copies the Landlock security blob when the
> source credential has a domain.  This is inconsistent with
> landlock_restrict_self() which can set log_subdomains_off on a
> credential without creating a domain (via the ruleset_fd=-1 path): the
> field is committed but not preserved across fork() because the child's
> prepare_creds() calls hook_cred_transfer() which skips the copy when
> domain is NULL.
> 
> This breaks the documented use case where a process mutes subdomain logs
> before forking sandboxed children: the children lose the muting and
> their domains produce unexpected audit records.
> 
> Fix this by unconditionally copying the Landlock credential blob.
> landlock_get_ruleset(NULL) is already a safe no-op.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: ead9079f7569 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/cred.c                      |  6 +-
>  tools/testing/selftests/landlock/audit_test.c | 88 +++++++++++++++++++
>  2 files changed, 90 insertions(+), 4 deletions(-)
> 
> diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> index 0cb3edde4d18..cc419de75cd6 100644
> --- a/security/landlock/cred.c
> +++ b/security/landlock/cred.c
> @@ -22,10 +22,8 @@ static void hook_cred_transfer(struct cred *const new,
>  	const struct landlock_cred_security *const old_llcred =
>  		landlock_cred(old);
>  
> -	if (old_llcred->domain) {
> -		landlock_get_ruleset(old_llcred->domain);
> -		*landlock_cred(new) = *old_llcred;
> -	}
> +	landlock_get_ruleset(old_llcred->domain);
> +	*landlock_cred(new) = *old_llcred;

This fix looks correct for the hook_cred_prepare() case (and of
course, hook_cred_prepare() calls hook_cred_transfer() in Landlock).


But I'm afraid I might have spotted another issue here:

If I look at the code in security/keys/process_keys.c, where
security_tranfer_creds() is called, the "old" object is actually
already initialized, and if we are not checking for that, I think we
are leaking memory.

I would suggest to use the helper landlock_cred_copy() from cred.h for
that.  This one is anyway supposed to be the central place for this
copying logic, and it is safe to use with zeroed-out target objects
(because the put is safe for the NULL-pointer).

Maybe this is worth updating while we are at it?


>  }
>  
>  static int hook_cred_prepare(struct cred *const new,
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 46d02d49835a..20099b8667e7 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -279,6 +279,94 @@ TEST_F(audit, thread)
>  				&audit_tv_default, sizeof(audit_tv_default)));
>  }
>  
> +/*
> + * Verifies that log_subdomains_off set via the ruleset_fd=-1 path (without
> + * creating a domain) is inherited by children across fork().  This exercises
> + * the hook_cred_transfer() fix: the Landlock credential blob must be copied
> + * even when the source credential has no domain.
> + *
> + * Phase 1 (baseline): a child without muting creates a domain and triggers a
> + * denial that IS logged.
> + *
> + * Phase 2 (after muting): the parent mutes subdomain logs, forks another child
> + * who creates a domain and triggers a denial that is NOT logged.
> + */
> +TEST_F(audit, log_subdomains_off_fork)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> +	};
> +	struct audit_records records;
> +	int ruleset_fd, status;
> +	pid_t child;
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> +
> +	/*
> +	 * Phase 1: forks a child that creates a domain and triggers a denial
> +	 * before any muting.  This proves the audit path works.
> +	 */
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +		ASSERT_EQ(-1, kill(getppid(), 0));
> +		ASSERT_EQ(EPERM, errno);
> +		_exit(0);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(true, WIFEXITED(status));
> +	ASSERT_EQ(0, WEXITSTATUS(status));
> +
> +	/* The denial must be logged (baseline). */
> +	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd, getpid(),
> +					NULL));
> +
> +	/* Drains any remaining records (e.g. domain allocation). */
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +
> +	/*
> +	 * Mutes subdomain logs without creating a domain.  The parent's
> +	 * credential has domain=NULL and log_subdomains_off=1.
> +	 */
> +	ASSERT_EQ(0, landlock_restrict_self(
> +			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
> +
> +	/*
> +	 * Phase 2: forks a child that creates a domain and triggers a denial.
> +	 * Because log_subdomains_off was inherited via fork(), the child's
> +	 * domain has log_status=LANDLOCK_LOG_DISABLED.
> +	 */
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +		ASSERT_EQ(-1, kill(getppid(), 0));
> +		ASSERT_EQ(EPERM, errno);
> +		_exit(0);
> +		return;
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(true, WIFEXITED(status));
> +	ASSERT_EQ(0, WEXITSTATUS(status));
> +
> +	/* No denial record should appear. */
> +	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
> +					      getpid(), NULL));
> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
>  FIXTURE(audit_flags)
>  {
>  	struct audit_filter audit_filter;
> -- 
> 2.53.0
> 

Test looks fine.

While I do still think we should investigate the memory leak, this
commit is, as it is, already a strict improvement over what we had
before, so:

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

–Günther


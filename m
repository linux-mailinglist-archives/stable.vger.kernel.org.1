Return-Path: <stable+bounces-233680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIBAIIss1Wli1wcAu9opvQ
	(envelope-from <stable+bounces-233680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:10:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 442463B188E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21FB8305D41B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5FF3D88F0;
	Tue,  7 Apr 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ezuRjfrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401013C8702
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577860; cv=none; b=JVd4Q5Oji7Lc0tndUfkF/RMvjIk4c+Fc4lrI1zZFIB4GzGbfu1IRapiEisiGEB2nan9X0/zS8QMDCb6eEve/7/k5IF8NS8YiR1V1K3LMdQ8bqRPXYWIpDL/WsfTwLh5YF/gCesUYzVeEVXehE6Yv/tu918wbCePh3v4PBIcm0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577860; c=relaxed/simple;
	bh=jWqZByCXlQAQsXKN3c+PlprgxesX3EGGcEbVEukzozE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G61EqPQTaP+aM+HROYeC4FzEVYL0KAQAA4pqPaG7o4+Y/u/BC6hlUvkjeM4LCUOBUN8frBYAMDG8nq3OVKkJfssfEdFn0Qt6h+Xy68fEsicWOOYlRnTSSWWEB7gl/m75JxnxyF44uAep6/lTFy4+fu0HHdjKfIQ0MPea3bBjWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ezuRjfrE; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fqrbl1y8bzXH8;
	Tue,  7 Apr 2026 18:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775577843;
	bh=BuJ1b9DLe15rxEHlJRdHRZNAK5vx2fsFxuDBwmg95Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezuRjfrE4QhKci6hwa69kZ6H82WJBNS3Avmb4yswYQ3VL7FJqPrgw9hd9t0xv4Fi5
	 kIkvIfeyX0vaa/MvTCAbH4t6dqf39Gcdzg1DDOP3lBatc9HHHm+QmrBbsOOFkTFRfc
	 eWa3+h5pUrEYCrrOfBHvriV67VFAWcmY8MRSkWy0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fqrbk5YKGzHGb;
	Tue,  7 Apr 2026 18:04:02 +0200 (CEST)
Date: Tue, 7 Apr 2026 18:03:58 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	Jann Horn <jannh@google.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Fix log_subdomains_off inheritance
 across fork()
Message-ID: <20260407.wuaqueid3Pai@digikod.net>
References: <20260404085001.1604405-1-mic@digikod.net>
 <20260407.844e42deb531@gnoack.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407.844e42deb531@gnoack.org>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233680-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	DMARC_NA(0.00)[digikod.net];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,digikod.net:dkim,digikod.net:email,digikod.net:mid]
X-Rspamd-Queue-Id: 442463B188E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 09:30:40AM +0200, Günther Noack wrote:
> Hello!
> 
> On Sat, Apr 04, 2026 at 10:49:57AM +0200, Mickaël Salaün wrote:
> > hook_cred_transfer() only copies the Landlock security blob when the
> > source credential has a domain.  This is inconsistent with
> > landlock_restrict_self() which can set log_subdomains_off on a
> > credential without creating a domain (via the ruleset_fd=-1 path): the
> > field is committed but not preserved across fork() because the child's
> > prepare_creds() calls hook_cred_transfer() which skips the copy when
> > domain is NULL.
> > 
> > This breaks the documented use case where a process mutes subdomain logs
> > before forking sandboxed children: the children lose the muting and
> > their domains produce unexpected audit records.
> > 
> > Fix this by unconditionally copying the Landlock credential blob.
> > landlock_get_ruleset(NULL) is already a safe no-op.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: stable@vger.kernel.org
> > Fixes: ead9079f7569 ("landlock: Add LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/cred.c                      |  6 +-
> >  tools/testing/selftests/landlock/audit_test.c | 88 +++++++++++++++++++
> >  2 files changed, 90 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/landlock/cred.c b/security/landlock/cred.c
> > index 0cb3edde4d18..cc419de75cd6 100644
> > --- a/security/landlock/cred.c
> > +++ b/security/landlock/cred.c
> > @@ -22,10 +22,8 @@ static void hook_cred_transfer(struct cred *const new,
> >  	const struct landlock_cred_security *const old_llcred =
> >  		landlock_cred(old);
> >  
> > -	if (old_llcred->domain) {
> > -		landlock_get_ruleset(old_llcred->domain);
> > -		*landlock_cred(new) = *old_llcred;
> > -	}
> > +	landlock_get_ruleset(old_llcred->domain);
> > +	*landlock_cred(new) = *old_llcred;
> 
> This fix looks correct for the hook_cred_prepare() case (and of
> course, hook_cred_prepare() calls hook_cred_transfer() in Landlock).
> 
> 
> But I'm afraid I might have spotted another issue here:
> 
> If I look at the code in security/keys/process_keys.c, where
> security_tranfer_creds() is called, the "old" object is actually
> already initialized, and if we are not checking for that, I think we
> are leaking memory.

old is only a partially initialized credential, and the Landlock
part is not set yet, which is the goal of hook_transfer_creds(), so
there is no leak.

> 
> I would suggest to use the helper landlock_cred_copy() from cred.h for

This is not required but if we would like to do it anyway, that would
not be backportable and would introduce a (minimal) performance penalty.

> that.  This one is anyway supposed to be the central place for this
> copying logic, and it is safe to use with zeroed-out target objects
> (because the put is safe for the NULL-pointer).
> 
> Maybe this is worth updating while we are at it?
> 
> 
> >  }
> >  
> >  static int hook_cred_prepare(struct cred *const new,
> > diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> > index 46d02d49835a..20099b8667e7 100644
> > --- a/tools/testing/selftests/landlock/audit_test.c
> > +++ b/tools/testing/selftests/landlock/audit_test.c
> > @@ -279,6 +279,94 @@ TEST_F(audit, thread)
> >  				&audit_tv_default, sizeof(audit_tv_default)));
> >  }
> >  
> > +/*
> > + * Verifies that log_subdomains_off set via the ruleset_fd=-1 path (without
> > + * creating a domain) is inherited by children across fork().  This exercises
> > + * the hook_cred_transfer() fix: the Landlock credential blob must be copied
> > + * even when the source credential has no domain.
> > + *
> > + * Phase 1 (baseline): a child without muting creates a domain and triggers a
> > + * denial that IS logged.
> > + *
> > + * Phase 2 (after muting): the parent mutes subdomain logs, forks another child
> > + * who creates a domain and triggers a denial that is NOT logged.
> > + */
> > +TEST_F(audit, log_subdomains_off_fork)
> > +{
> > +	const struct landlock_ruleset_attr ruleset_attr = {
> > +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> > +	};
> > +	struct audit_records records;
> > +	int ruleset_fd, status;
> > +	pid_t child;
> > +
> > +	ruleset_fd =
> > +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> > +	ASSERT_LE(0, ruleset_fd);
> > +
> > +	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> > +
> > +	/*
> > +	 * Phase 1: forks a child that creates a domain and triggers a denial
> > +	 * before any muting.  This proves the audit path works.
> > +	 */
> > +	child = fork();
> > +	ASSERT_LE(0, child);
> > +	if (child == 0) {
> > +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> > +		ASSERT_EQ(-1, kill(getppid(), 0));
> > +		ASSERT_EQ(EPERM, errno);
> > +		_exit(0);
> > +		return;
> > +	}
> > +
> > +	ASSERT_EQ(child, waitpid(child, &status, 0));
> > +	ASSERT_EQ(true, WIFEXITED(status));
> > +	ASSERT_EQ(0, WEXITSTATUS(status));
> > +
> > +	/* The denial must be logged (baseline). */
> > +	EXPECT_EQ(0, matches_log_signal(_metadata, self->audit_fd, getpid(),
> > +					NULL));
> > +
> > +	/* Drains any remaining records (e.g. domain allocation). */
> > +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> > +
> > +	/*
> > +	 * Mutes subdomain logs without creating a domain.  The parent's
> > +	 * credential has domain=NULL and log_subdomains_off=1.
> > +	 */
> > +	ASSERT_EQ(0, landlock_restrict_self(
> > +			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
> > +
> > +	/*
> > +	 * Phase 2: forks a child that creates a domain and triggers a denial.
> > +	 * Because log_subdomains_off was inherited via fork(), the child's
> > +	 * domain has log_status=LANDLOCK_LOG_DISABLED.
> > +	 */
> > +	child = fork();
> > +	ASSERT_LE(0, child);
> > +	if (child == 0) {
> > +		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> > +		ASSERT_EQ(-1, kill(getppid(), 0));
> > +		ASSERT_EQ(EPERM, errno);
> > +		_exit(0);
> > +		return;
> > +	}
> > +
> > +	ASSERT_EQ(child, waitpid(child, &status, 0));
> > +	ASSERT_EQ(true, WIFEXITED(status));
> > +	ASSERT_EQ(0, WEXITSTATUS(status));
> > +
> > +	/* No denial record should appear. */
> > +	EXPECT_EQ(-EAGAIN, matches_log_signal(_metadata, self->audit_fd,
> > +					      getpid(), NULL));
> > +
> > +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> > +	EXPECT_EQ(0, records.access);
> > +
> > +	EXPECT_EQ(0, close(ruleset_fd));
> > +}
> > +
> >  FIXTURE(audit_flags)
> >  {
> >  	struct audit_filter audit_filter;
> > -- 
> > 2.53.0
> > 
> 
> Test looks fine.
> 
> While I do still think we should investigate the memory leak, this
> commit is, as it is, already a strict improvement over what we had
> before, so:
> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>

I'll keep your tag if this patch is ok with you as-is.

> 
> –Günther
> 


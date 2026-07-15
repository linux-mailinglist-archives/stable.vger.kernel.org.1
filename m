Return-Path: <stable+bounces-274784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HU1CAS1PV2oaJAEAu9opvQ
	(envelope-from <stable+bounces-274784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:13:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99D75C4CD
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:13:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FXizJOrD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274784-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274784-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31620301CFBB
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1773890E0;
	Wed, 15 Jul 2026 09:02:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAD3E2AD5;
	Wed, 15 Jul 2026 09:02:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106149; cv=none; b=Cha6Q15KQhVSIi6098NgCb1nWa7utp6kt/Klf8W1rapeRgBG6M9bGM4mCZqwhD7Piojqk51jrqW7Cl6ZjlDpd8hWjYH33n+7petj00Z1j+Dfqt9kTcfeXcfZwE2W+dS065UmycnMKxIP/7Grtgo16uc1/LX4GFifgGQMkDRDpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106149; c=relaxed/simple;
	bh=ODfz8vGNiUv9fPRdRsFdMYMAYSLdq49ZXgq4bLw61/8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OceYSmW0SIloaztArZ93WEISWaK/hJQ2kAHPy1ks3GBkOyIXCRJK4O4x8HFPjA3DMgrh+d3lWaAabhWqGvof8RlohX6fQoblEJurFb4sxNgQjrxpx9BUSHAtMnhG5y0RyiJtxEoalKAujtB0bQOc46UUTd5LMna91yyxOf0P9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXizJOrD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3941F000E9;
	Wed, 15 Jul 2026 09:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106142;
	bh=cAj7gIylunqBhd0ZXQWVbynsV+ph2A+eHj+120ZERnU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=FXizJOrD5j6vCShPj336DFvqzQMEjIG5h/dtlvkql1kafU8JdM/Wc/4LM/fcWMbir
	 Z+BnegbpbczJ5CGRfs6EUAf5RDj2aysUgtY9V8fsHIdU3O28N4OWEV0DdveKqX9qab
	 yvvUkAGQHCsohjIcsmvQGW33fBzc5G/DBgrCVn/6eqF+U83CFzGR767p4tHLRVI34A
	 w01wIqL7mSu4yzQ6GRcWeu/UUbb/dfd0N9k1ESWRlJSG35E2/3uUUFrrjbDVxVwoto
	 CdHSXLHvb9iiuEVhCX0JjQTuej7xPeRyKXxNH7sVWVDOYJXtHk4KGY2MB/QZgOTqyu
	 WxMqp3r7QtizA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] fs: preserve ACL_DONT_CACHE state in
 forget_cached_acl()
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20260713220932.413004-2-amir73il@gmail.com>
References: <20260713220932.413004-1-amir73il@gmail.com>
 <20260713220932.413004-2-amir73il@gmail.com>
Date: Wed, 15 Jul 2026 11:02:17 +0200
Message-Id: <20260715-seilschaft-fahrbahn-talstation-6c45445d2535@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ODfz8vGNiUv9fPRdRsFdMYMAYSLdq49ZXgq4bLw61/8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSF+8x1NMz+tP/fr5/snTPX7brzhW/CwgmupgbMpyPmz
 7orXbrrREcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEDOYwMly+drgvxu/Hw37Z
 Up7kG9GsNVFvV+SuWO7lFnuF765LxGqG/yVaPsqX2Xl3NqacUXstmlnXOKe1qUvPvTLi/ClzNae
 17AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:brauner@kernel.org,m:miklos@szeredi.hu,m:linux-fsdevel@vger.kernel.org,m:fuse-devel@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274784-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A99D75C4CD

> The ACL_DONT_CACHE state is meant to be a constant state for the inode
> for filesystems that want to opt out of posix acl caching.
> 
> Commit facd61053cff1 ("fuse: fixes after adapting to new posix acl api")
> used this facility to opt out of posix acl caching for fuse inodes with
> fuse server that does not negotiate FUSE_POSIX_ACL (fc->posix_acl).
> 
> The commit also takes care to gate the forget_all_cached_acls() call in
> fuse_set_acl() on fc->posix_acl because there is no need for it, but
> there are other placed in fuse code which call forget_all_cached_acls()
> unconditional to fc->posix_acl and those cause the loss of the
> ACL_DONT_CACHE state.
> 
> This is not only a functional bug. Properly timed, a get_acl() from this
> fuse filesystem can return a stale cached value, as was observed in tests,
> because set_acl() does not invalidate the unintentional acl cache.
> 
> We could fix this in fuse, but it actually makes no sense for the vfs
> helper forget_cached_acl() to invalidate the ACL_DONT_CACHE state, so
> let it not do that to fix fuse and future users of ACL_DONT_CACHE.
> 
> Fixes: facd61053cff1 ("fuse: fixes after adapting to new posix acl api")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index b4bfe4ddf64e..3dc62c1c2708 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -93,6 +93,13 @@ static void __forget_cached_acl(struct posix_acl **p)
>  {
>  	struct posix_acl *old;
>  
> +	/*
> +	 * ACL_DONT_CACHE is expected to be a "const" value and xchg it with
> +	 * ACL_NOT_CACHED would enable acl caching for the inode -
> +	 * clearly not what the caller has intended.
> +	 */
> +	if (READ_ONCE(*p) == ACL_DONT_CACHE)
> +		return;

Still on vacation this week but I took a glimpse:

If this isn't what the caller intended, having ACL_DONT_CACHE end up
should be treated like a bug. So shouldn't this then be a WARN_ON_ONCE()
and return?

-- 
Christian Brauner <brauner@kernel.org>


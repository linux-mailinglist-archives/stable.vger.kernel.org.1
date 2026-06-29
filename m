Return-Path: <stable+bounces-269823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zymjNQXSQmrgDQoAu9opvQ
	(envelope-from <stable+bounces-269823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:13:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD26DE90C
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:13:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="lcaLFpw/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269823-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269823-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5F30303663F
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25317343887;
	Mon, 29 Jun 2026 20:13:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D24331214;
	Mon, 29 Jun 2026 20:13:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764032; cv=none; b=f5Q9ON1Vyg+xpaEpUsx7Xi8EymodV/WzCtJ3o41RtxUizZ5ak4OFBG4fmmFr1oDoJ9pADCxelfF76ulXEF2QnyOGY6PrGlJ3YmK/+fNhCT2uA7tmmWkcFCKdBCgOpTH8JAZeIECCY4towMAiUDTLFNKn2Oo/CNlIDpAoDgge5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764032; c=relaxed/simple;
	bh=ttJ9HmpTGHaxnl+741pWJr1o2ymvSTNsFe57II8R7ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXJTGVWJc63yfqN6UcBxhmzgS19sw7kzeHgT80AAAMDQmySTLS9Sf95hCD2VAJXrxQ9YOrdbZtdMtoiKa1/Vlh/1RQhW/jlIP0FofV6m5ungObGLYXqSAuWwWAusHCBGy1/9RgPedCVx8U0BdihAqpTFS33f4/XHHZMNUG9A524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcaLFpw/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7A2071F000E9;
	Mon, 29 Jun 2026 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782764031;
	bh=ffto1oaurlPUM1NgTHXI/foUWWZVOOjQXM+Oj4oh/90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lcaLFpw/iaVuxl26OQIBoUUy4+h6tjpTAOYGvghS+VPf+avExDG7/8gwZViSDxoYL
	 iaPKUCCKmNkpI+swlkHC0GhXp5rUkwNuEoN6nCY43dmcw7E9x3m7w16r6CxcG54/6A
	 j9jkCV6olAXdj0XhXl/H53n6LpJIafLGmuchb3r5m5I+xkMZHpAMS2ywcv2THUpXnl
	 3j2ciM4uD1OgEe3lQNscPM2gcxpVkCrz9b0909vb7ENpOOXrulm8cqpj8HoFapbAl6
	 QMCiOMHLeUeCRe6x+HlP2CovKkifbM39Sz+8keQ+/AQC9kPIEVrXOMbWmdj0tVl6jz
	 gF+Ha0S7XAErQ==
Date: Mon, 29 Jun 2026 13:13:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com
Subject: Re: [PATCH] xfs: initialize first bad log block in head verification
Message-ID: <20260629201350.GC6078@frogsfrogsfrogs>
References: <20260628092513.39620-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628092513.39620-1-alhouseenyousef@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.103.45.18:received,100.90.174.1:received];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-269823-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,b7dfbed0c6c2b5e9fd34];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email,syzkaller.appspot.com:url,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23DD26DE90C

On Sun, Jun 28, 2026 at 11:25:13AM +0200, Yousef Alhouseen wrote:
> xlog_do_recovery_pass() only writes first_bad when it reaches the common
> error exit after processing a log record. An earlier CRC or corruption
> failure can therefore return without initializing the out-parameter.
> 
> xlog_verify_head() tests first_bad on those errors and may then use its
> uninitialized stack value as a log block number while searching for the
> last good record. Initialize it to zero, matching xlog_verify_tail(), so
> an error without a recorded bad block is returned directly.
> 
> Fixes: 7088c4136fa1 ("xfs: detect and trim torn writes during log recovery")
> Reported-by: syzbot+b7dfbed0c6c2b5e9fd34@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b7dfbed0c6c2b5e9fd34
> Cc: stable@vger.kernel.org
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  fs/xfs/xfs_log_recover.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index 09e6678ca487..d8125f3add4b 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -1028,7 +1028,7 @@ xlog_verify_head(
>  {
>  	struct xlog_rec_header	*tmp_rhead;
>  	char			*tmp_buffer;
> -	xfs_daddr_t		first_bad;
> +	xfs_daddr_t		first_bad = 0;

Why is it safe to set this to the first daddr of the log?  Is it
possible that a filesystem could have a log record starting near the end
of the log which wrapped around, and later suffered a CRC corruption in
daddr 0?

xfs_daddr_t already defines an explicit null value (XFS_BUF_DADDR_NULL);
wouldn't it be /much/ safer to set that here and update the if test body
later?

--D

>  	xfs_daddr_t		tmp_rhead_blk;
>  	int			found;
>  	int			error;
> -- 
> 2.54.0
> 
> 


Return-Path: <stable+bounces-233955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC/3GQeR1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:31:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B45553BF9A4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A32103014BEF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F383A5E6E;
	Wed,  8 Apr 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cQ1BbaMI"
X-Original-To: stable@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B37351C0B;
	Wed,  8 Apr 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669505; cv=none; b=M65kIM8FTXzBd9S0ADu6sjn5lhylHEosS2wqTlRCmEcgoTviZk4wSR/VDZzywhQDD1904oCahzyLeyOtTxbTlvJN87KdnLjFABgxNgWV8KSvVWa6bA9Q77wSPDg8+cYuIZdPcuuifIH2JMpXxDHaeJfDQAoTGvBgTYQ1jj591Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669505; c=relaxed/simple;
	bh=EoW567PB8Co2X8bRdM0owi+SL3aZXGUzXZedcdJ3ngk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUNwrxixG7fpZhWvcmw0Jsts9iGuY8uMoTIIwvHa28qxL4dSmMrSbWGpfJuQR5scwvD6b6J642XGUUb75L9loH2sQ8yWCNV75947ydWHW1cUIIVJDpdw/nwP18j/EKK8lFk42qDJzXrFtM8OgxSuLwQ63QVJ/t9miYlfa+sqtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cQ1BbaMI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=resCKqS03kJ38gMbTTM7M3o2jKBYnfBwMXVdShoAF2Y=; b=cQ1BbaMIQGjPVcNiuEP1NErwx5
	ciWQIt5xrSG5sgCMcPxdHKnsA/LSVE6OHqUHei+iEgcoM+zoOKT9PTI9+Y+qrrK/Q8SA4BHUEuy+t
	uVbqAbT214prydyCPOywf0GphqvRiISeAMjtEDGic+IZq019som7tCf26y2ddIyKL8P5BBBStKlX0
	5Khfx6I8vKBPcCKZP9aMYlwqeRz4uUaAOR4rgPLX7bS/6JipEjv2YxrTJjiROK9kHloh8J9DhEP94
	m9N7shO5rxr2tZG1G4OOYMNSYeGAiKgL7PL/VrDGK11WWfDPWCcwDZZOFwkMBBCEYafUkQ7wGl7YV
	Ap1UPEGw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wAWoJ-00000000IUL-1OR4;
	Wed, 08 Apr 2026 17:35:27 +0000
Date: Wed, 8 Apr 2026 18:35:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Arpith Kalaginanavoor <arpithk@nvidia.com>
Cc: brauner@kernel.org, stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/qnx6: fix pointer arithmetic in directory iteration
Message-ID: <20260408173527.GH3836593@ZenIV>
References: <20260310102233.391113-1-arpithk@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310102233.391113-1-arpithk@nvidia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233955-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B45553BF9A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 03:22:33AM -0700, Arpith Kalaginanavoor wrote:

> diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
> index ae0c9846833d..ba5cae49ad1d 100644
> --- a/fs/qnx6/dir.c
> +++ b/fs/qnx6/dir.c
> @@ -139,8 +139,8 @@ static int qnx6_readdir(struct file *file, struct dir_context *ctx)
>  			ctx->pos = (n + 1) << PAGE_SHIFT;
>  			return PTR_ERR(kaddr);
>  		}
> -		de = (struct qnx6_dir_entry *)(kaddr + offset);
> -		limit = kaddr + last_entry(inode, n);
> +		de = (struct qnx6_dir_entry *)(kaddr + (offset * QNX6_DIR_ENTRY_SIZE));
> +		limit = kaddr + (last_entry(inode, n) * QNX6_DIR_ENTRY_SIZE);

Why not simply

		de = (struct qnx6_dir_entry *)kaddr + offset;
		limit = (struct qnx6_dir_entry *)kaddr + last_entry(inode, n);

instead of open-coding the multiplication?


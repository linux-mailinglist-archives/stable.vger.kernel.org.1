Return-Path: <stable+bounces-270396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wjo9LZZBRmq0MwsAu9opvQ
	(envelope-from <stable+bounces-270396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:46:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 638076F622E
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 12:46:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270396-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270396-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6F23045EE4
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9D35F165;
	Thu,  2 Jul 2026 10:30:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D672D5932;
	Thu,  2 Jul 2026 10:30:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988258; cv=none; b=iR5ZUKxuIEJIwATlKlfmiJCQGHk4k7WZQOFIHPrcSDthqq6UBFmvBIXGtXD+pBFX/dksMJDOV1+GEjw0WmJcH4BBk6VGJKmxYAO//r+0iaJdWHXl6amznUl/2I+ZZS3JcWrbfGaS5iDhz/HhoM3wf933SqFfia1+cK+hkpihpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988258; c=relaxed/simple;
	bh=K2l6CCTQ4uK9qLfyfrRUs40u8y96cYvHraEeneXN2IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGGvObbV36jUc5NkjsyPQzGb6cgtXJTUJ6g1ObsaDctnrQ6tBaijC/HXdgQI11J6iZucCT15mBoDu7xCqA+JF4bWMpeSGyur184Vw1tEmXEzSmrRYKv8DXSmMad5hgFivjSTgb1LvZPNl8V2erJmP/gs2valZzya+9XIkJYk7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B2D768BEB; Thu,  2 Jul 2026 12:30:53 +0200 (CEST)
Date: Thu, 2 Jul 2026 12:30:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: cem@kernel.org
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Eric Sandeen <sandeen@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: Re: [PATCH v3 1/5] xfs: fix capability check in xfs
Message-ID: <20260702103052.GA6670@lst.de>
References: <20260702093324.127450-1-cem@kernel.org> <20260702093324.127450-3-cem@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702093324.127450-3-cem@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cem@kernel.org,m:stable@vger.kernel.org,m:jack@suse.cz,m:hch@lst.de,m:serge@hallyn.com,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.orgis@uni-hamburg.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270396-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 638076F622E

On Thu, Jul 02, 2026 at 11:33:17AM +0200, cem@kernel.org wrote:
> index 6339f4956ecb..205fe2dae732 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -835,7 +835,8 @@ xfs_setattr_nonsize(
>  	}
>  
>  	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> -			has_capability_noaudit(current, CAP_FOWNER), &tp);
> +					ns_capable_noaudit(&init_user_ns, CAP_FOWNER),

Extra indentation and an overly long line caused by that here.

Otherwise looks good.


Return-Path: <stable+bounces-270424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4u8JLZdZRmqORQsAu9opvQ
	(envelope-from <stable+bounces-270424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:29:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5EB6F796F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 14:29:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MOD8Nzut;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270424-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270424-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACAF43075290
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC25480324;
	Thu,  2 Jul 2026 12:24:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F3D47D933;
	Thu,  2 Jul 2026 12:24:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995096; cv=none; b=VZtsDL/L7xOVKyz3Z/eziAM4no2kpyzh5ktlbsRkyd5BM6sLq+8PpAdJ1tO+Ku/JGTh+eLm3E2u/NUyneB1P8CoZHS7KN9fZek61kGlLAOUZq7o5r0yArK9JxLG8glElDjb2a8k2ji9lwUeBL0m4gf76Dk+GatkvvWlvbr4ehiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995096; c=relaxed/simple;
	bh=ICx0y48EgCqwfUHNaqvLcqUK7PvEoDZZYH1/W6//A4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMX49pDfGZ8jDm1j9sV47aBowRebvFuWmNRjUMomO6mZWNvuhMXARrvUjmEqWGJiC5gFweQ6AYTHiVA7B+x8K4p3uMwyzDgj1XnLCBQILag3CFt0tTg2LoiDZrBpYwTsr0ucsoo+yDjS9gLOiW22B06I60zD57ztimeMgFv1kFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOD8Nzut; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC061F000E9;
	Thu,  2 Jul 2026 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782995095;
	bh=1F/DnNRQhNjVTQ0PSQv/Zbt1GQU1sT+mz5mYcSd9Uq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MOD8NzutSbE5DdqnftFDp1RWydj64FDIYocU3xGvqy3WYNHeymhmGboz+b/ecsyxd
	 ne49teMDeOFKjgmQZP4/5oeW6D0TPIDziY6fVP4Fp52WUWrXb3RLMtdxTjMpwxlK/7
	 g+/t1XWQS+54f64n16MAi3wR9XTrLWC/NmPChijwUcAgyk0VmPTtaHaSue0Q9fJ9JF
	 RwzEvjqP0p7pG0v39qsOrSDFSeIocbFvAx2lLzKIWyLdFit15ymPHiLASQUksJCBRf
	 Q6ZZMAjJNZzNsN210yoMirZ3kSjEWFnKmVUbnawBolmWRfLYPz+/ZMn2SKYQBJ+M3R
	 alYo2AO7HtjIg==
Date: Thu, 2 Jul 2026 14:24:50 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Eric Sandeen <sandeen@redhat.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Subject: Re: [PATCH v3 1/5] xfs: fix capability check in xfs
Message-ID: <akZYU2T4BkIuTcE3@nidhogg.toxiclabs.cc>
References: <20260702093324.127450-1-cem@kernel.org>
 <20260702093324.127450-3-cem@kernel.org>
 <20260702103052.GA6670@lst.de>
 <akZITB_FDP1nl2_S@nidhogg.toxiclabs.cc>
 <20260702112438.GA10565@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702112438.GA10565@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:stable@vger.kernel.org,m:jack@suse.cz,m:serge@hallyn.com,m:djwong@kernel.org,m:david@fromorbit.com,m:sandeen@redhat.com,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.orgis@uni-hamburg.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-270424-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F5EB6F796F

> > +                               ns_capable_noaudit(&init_user_ns, CAP_FOWNER),
> > +                               &tp);
> 
> This still adds an extra tab.  Like much (but not all) of the kernel
> we use two-tabs by default, which is also in the other two hinks.  This
> now adds a third.  Just keep it as it was:
> 
> 	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
> 			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);
> 
> 

FWIW, I also fixed these in the patch 4 which I had screwed up too :)


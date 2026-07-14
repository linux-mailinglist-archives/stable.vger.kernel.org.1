Return-Path: <stable+bounces-274438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2bf6CA1nVmqX4wAAu9opvQ
	(envelope-from <stable+bounces-274438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:42:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E080757060
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 18:42:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QQNTDeHv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274438-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274438-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9623330C2262
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBF64D8D9E;
	Tue, 14 Jul 2026 16:40:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B91E1C11;
	Tue, 14 Jul 2026 16:40:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047224; cv=none; b=DM2W7PNE6eWWpw3xKcK84hyZ6NRbJ9Ltt/abM0808gE01PKnlik2Mcg+YheffQ+anjQ3e0UOjKbagvK1CmHDyt+i9zqV/UmxatsCC1AmAgPblFI4pBpF/ea62eHJl8KvnO6gmWd3UatrTsLJmQmR+3ifsPl33cnhZhGbN7czxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047224; c=relaxed/simple;
	bh=3SwB5hyURQDw9vSSZawoayeUlCXH+BdU7R6jgc+R89g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6oYeJ0sggCmZ2wM/bf9D/t3J5MSPApF714TjpxkVyDCazZgFEaTAPZHRH1Mo1uCBMNAYIMhevuoQyyDW6Nq+JxMwwrDiKkQCUk38XqWS4rDWPC/kZIvtI6JojxZSQqvyLjGfLXxCiY38N6QGse9S/sxhRNIKIYyMjB/EeQQLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQNTDeHv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A3C791F000E9;
	Tue, 14 Jul 2026 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047222;
	bh=gg603RQYeW5vAGQiWgQctR3lMlGy5oigDzyr2KUGrYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QQNTDeHvuvX4qn3WnKMbzCidEdpjUE2aBk2vvPliQeLUB6o1brKcsnCdigdOHLLEf
	 lfFqNGFTFHnyfwOHSynEMXOC01ClkmY2sHepFJjS/GdIBJTijeFEYJAOkChdcQ+Uyb
	 HktWCNzhFg4GcFLQqFDmBSuZhu+AhvVAYGW6BjWINpywze1qtJCZ6DuA6ZfmjAeH1H
	 oFwnWqvkUNYFza4yPl5TOVxPAYxiZuvkFDd4TpzUD4QgUfvZJzYGe/zCKwUJOSkDAv
	 TaHut5P62GKPbCRR1RDkpyZIvWk+hzWoOlE2qSPsigmApdodrF21EoRFXZfctbXSla
	 8dBk7RxkGHoLg==
Date: Tue, 14 Jul 2026 09:40:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, stable@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: don't zap bmbt forks if they are MAXLEVELS tall
Message-ID: <20260714164019.GE7398@frogsfrogsfrogs>
References: <178400716782.268162.4846177784022689546.stgit@frogsfrogsfrogs>
 <178400716946.268162.18317924649043454437.stgit@frogsfrogsfrogs>
 <20260714061652.GG1072@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714061652.GG1072@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:cem@kernel.org,m:stable@vger.kernel.org,m:linux-xfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274438-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,frogsfrogsfrogs:mid,vger.kernel.org:from_smtp,lst.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E080757060

On Tue, Jul 14, 2026 at 08:16:52AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 13, 2026 at 11:07:30PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > LOLLM noticed a discrepancy between the bmbt level checks in the libxfs
> > bmbt code vs. the inode repair code.  We do actually allow a bmbt root
> > that proclaims to have a height of XFS_BM_MAXLEVELS.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I guess we need a test that actually creates such a deep tree.  But
> we'll probably run out space / extents before..

The bmapinflate command in xfs_db does this by writing a new bmap btree
with as many mappings pointing to the same "reflinked" block as you ask.
The only problem is that to hit maxlevels, you need to create a 1k
fsblock filesystem and then bmapinflate 2^54 records, which will take a
long time and require much memory.  Back in the day when Chandan was
working on nrext64 I tried this and it took 2 days and 400G of RAM to
write the huge bmap btree out to disk and generate the appropriate
rmap/reflink btrees.

--D


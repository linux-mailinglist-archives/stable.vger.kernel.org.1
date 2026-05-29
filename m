Return-Path: <stable+bounces-256799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD4uAgwdGmqx1ggAu9opvQ
	(envelope-from <stable+bounces-256799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:11:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 577AD609A65
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 691083011F15
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEEC371CEA;
	Fri, 29 May 2026 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1oi1wMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D635F60B;
	Fri, 29 May 2026 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096114; cv=none; b=FdMuXqMvM0pe3CilvXsiyoo4DEp8JDxjzCtdAu9OhpyIKtXtVbH9hgPGuqYfId8iWXDP0bE7OzzbUWNWQ2XcylZC+/efBPv1yDKfxlJsyeLZRN6/Ml9YJz+rV5AIlEMWp2+ntbXRCT8+MUBUzWGKNby510bm0t0dNI2pNFZ5BQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096114; c=relaxed/simple;
	bh=eX7WTaZKJayd6U7mlHytWgAtaoC+4htedxWcA00LuVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwdxWrxe6X5R9yuLEheL4OjEBkvOhbGc7oP/Yct7//Le9PfNushLN15K8LOwSKiSFdA6P4RhapL7+mfc4YPBc9JqAtpuhx6S2b0ZR5fcPH5Um2+JECtm2Jn9LDnWUJBoog4Mf7I79MnJ3TNIn2ACIUWU+cmnMDmWyNq9X+pvVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1oi1wMQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ADF1F00893;
	Fri, 29 May 2026 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096113;
	bh=pTri8BUQcNx5FytxVSCnFtx7e/4115rb7iA5Ei7gVqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1oi1wMQkhT+5vUe3xl/z/OPr9v3cjkS70bSLcTudM9itZzRgDbd5Xhi0g39+e2ul
	 5HDAtlwbq9jHySwBVJNNh1W0au5zdHczxKW6dDBOIGeCq48+NrFR1o/aB0/ZS46xbl
	 oG/lsfsTQqCt5HqNnSUoeuF3CVSGqGhY5gd06ATDRl/tZ39w8rY/MfChJPiJQvmh39
	 CRYnqufiox9SKzhelNYg/uArcaDKShGZcTRXMOjiYZxP8PaXcDKW+lhJJwXv7NjaNb
	 iDeu6nItp/AOevw0OOCIbc6QUUcBz0HxdpY/D9J8x6V5kD5xWYaCGfNsZuz8vbdwxq
	 dKgAQbVfsCRfg==
Date: Fri, 29 May 2026 17:08:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <ahocb8YRtqh5rHo-@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
 <ahiHIEhsV2zuG5vH@kbusch-mbp>
 <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256799-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 577AD609A65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 01:32:22AM +0000, Achkinazi, Igor wrote:
> Keith Busch wrote:
> > I double checked the sequences here, and yes, I think the
> > synchronize_srcu's already in place ensure every caller sees the EOD
> > error before it could fail the bio_queue_enter(), so this looks like it
> > happens to be sufficient. I'm okay with it.
> 
> Thanks Keith! May I add your Reviewed-by?

Sure, though I was considering just adding it the nvme tree. I'm giving
a few days to see if there are any other comments.


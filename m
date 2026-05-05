Return-Path: <stable+bounces-244178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBv5EAUG+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:00:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C734CFD92
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37AAA30309E5
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6C480971;
	Tue,  5 May 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwkU6Sq+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFF48094D;
	Tue,  5 May 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993218; cv=none; b=ESoe1xdQDHiEBASZOSXdqNI0IPdH3ckZjldNFKxTR80F3S2y+kbXkoyNJGL4aP+VmWTnYBXxjnhLWx6lFRiuwb/rvw504Jcr1wS3SLyYURbYDxWOHIwLVpk/ao1FNkPzA0zVgBG8SASMeK4BRG52rhbxgKMROmjQ98VV43Gwvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993218; c=relaxed/simple;
	bh=eCqlBdRmeb2KFjOn+gnRLLL3t3sfvTUHkt2SVfOf758=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS8srY4qgAO5E/mLH7UpruiQbfezw9tnm9/Bv5MqvHJlYfeBrx8+wq0xz+FEIZl/6wPlTB5Q8H22ih5R2r/Rl+VS/pLgIDHPhynVzkAgL3au+Qhelv8F/C4mo+2EVzEpZzuORvBJySYnmxCGavyu79a6tiHr40Cg68cInnKKawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwkU6Sq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60158C2BCC7;
	Tue,  5 May 2026 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993217;
	bh=eCqlBdRmeb2KFjOn+gnRLLL3t3sfvTUHkt2SVfOf758=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwkU6Sq+P6UdOZfgWjjYRsDqmIl1QVJczH4pR67nRc4SafiuHRj5giSbH7injokca
	 OEhP8cJnR//3mRJ2DQLhDNQ8ReJ1cI66xChbmhWkjU9y2zghcoXTaSn+9t1ZfPk8xM
	 nSdJgMkxxggBPPSSAIMshYfI0E/v0rRJb7kYFLYOaXTPZ/d+KPMuHM6iVtqQYtzNow
	 cjO+bzPEYvcCv0q29BqVhIubCznqNIsinbXdbN7MEms+FERDVaT++HD5FhGti3LO9+
	 6JglUTODI9eQ/8a8duL/G7yEeUI3fhIM1UoYyZrg1F3S6AepLQ/ikQRQhYnrTaMFcC
	 cgz1RPeeQ4p/Q==
Date: Tue, 5 May 2026 16:00:13 +0100
From: Lee Jones <lee@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Valery Borovsky <vebohr@gmail.com>, Ben Dooks <ben@fluff.org.uk>,
	Vincent Sanders <vince@arm.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: sm501: fix reference leak on failed device
 registration
Message-ID: <20260505150013.GC2661693@google.com>
References: <6b4a9f5ae8a316b6f07f72f2fe3f0b8fc5f18dff.1777889235.git.vebohr@gmail.com>
 <20260504124841.443496-1-vebohr@gmail.com>
 <177790275684.156214.6563585281874262911.b4-ty@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177790275684.156214.6563585281874262911.b4-ty@bootlin.com>
X-Rspamd-Queue-Id: A5C734CFD92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244178-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,fluff.org.uk,arm.linux.org.uk,linux-foundation.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 04 May 2026, Miquel Raynal wrote:

> On Mon, 04 May 2026 15:48:41 +0300, Valery Borovsky wrote:
> > When platform_device_register() fails in sm501_register_device(), the
> > platform device allocated by sm501_create_subdev() has its struct device
> > initialized by device_initialize() inside platform_device_register(). The
> > error path logs the error but returns without dropping the device reference,
> > leaking the memory allocated by sm501_create_subdev():
> > 
> >   sm501_register_device()
> >     -> platform_device_register(pdev)
> >        -> device_initialize(&pdev->dev)   /* kref = 1 */
> >        -> platform_device_add(pdev)       /* fails */
> >     <- dev_err() called, kref still 1, sm501_device_release never called
> > 
> > [...]
> 
> Applied to mtd/next, thanks!

I think you misread the subject line.

> [1/1] mfd: sm501: fix reference leak on failed device registration
>       commit: faa9bba3fe2f37e7dcb26d4501d890fbfd7df160
> 
> Patche(s) should be available on mtd/linux.git and will be
> part of the next PR (provided that no robot complains by then).

Please remove this from your tree.  It should be handled via M[F]D.

Thanks.

-- 
Lee Jones


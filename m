Return-Path: <stable+bounces-241857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPdfOzPb8WmnkwEAu9opvQ
	(envelope-from <stable+bounces-241857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:19:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD98492BE1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D536930095D5
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A6339844;
	Wed, 29 Apr 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfwOF/MA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3726A1AF;
	Wed, 29 Apr 2026 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457831; cv=none; b=T5BFx2Mt2qbYOava6kPvPqk1Q+ZcvjZR3Lg/QekQHPiUvh/wRXR51wi2j8Zg5amw+Z4HLR70YVakpfGDNRr6xGbHJ75PyY07jWj/UfHIezMpHMJuTg62UJC5jlqWMqYPFLCHPIv0HSQBaks8iyvx6wT2VYAFIMg9b2P3DqQ8QBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457831; c=relaxed/simple;
	bh=FxDW8MP39asJpaj8yGsTTBFJjHlxuyGDR/pzws1+SfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7gXLSfYx4HU+UgrOD7OK+HI3loFnxp+ZjOpKJ5vUqLY8jVPmDAqHd1ZombhktQ2sKQaSqeuMujdCl4Mqqm6BJQ0Z3UxQ71swx7wFseHU9sFl79S95AmeHFIviB96dv0KLbH1Z2EpA6fBtEDor++dhKzqdim6d3/gBWoSgWh4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfwOF/MA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F6EC19425;
	Wed, 29 Apr 2026 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777457831;
	bh=FxDW8MP39asJpaj8yGsTTBFJjHlxuyGDR/pzws1+SfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfwOF/MA30c9AocVJCIIcy2q0YZRDdaT60L1cG7FfNSRvH4S+TR71NJq6xbtIpUlj
	 kkE1lVNtHo5tsdAkaLLchHWsYcr3ipZROmeockDq0TLEIMN0qPFfgiiUSW0GATPjHf
	 syQxBzDr9ioxxNR6LFL2yfoF+q9XSEjdacxLy9QpPXtSx4nrb2vBVktDCzF0Qhr61X
	 HAhTKlJ5fOhMuspxNgy2iA/3J0R1e310Fsa4mFGiCsyec0GCvPQ6rgadDsWaH84Wp2
	 MOn0pPdiwIEF9/oXh5zUJi0twWELlibqKT7udsFt6TOduPG0il31yCKos2OW7/eGsq
	 pORpC6KX7EKsQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI1ye-00000000i6Z-3Qa7;
	Wed, 29 Apr 2026 12:17:08 +0200
Date: Wed, 29 Apr 2026 12:17:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] driver core: faux: fix root device registration
Message-ID: <afHapCZz5C42euaD@hovoldconsulting.com>
References: <20260424153127.2647405-1-johan@kernel.org>
 <20260424153127.2647405-2-johan@kernel.org>
 <DI54XY4CNFCD.30M3UJGK1M3BE@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI54XY4CNFCD.30M3UJGK1M3BE@kernel.org>
X-Rspamd-Queue-Id: 2DD98492BE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241857-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hovoldconsulting.com:mid]

On Wed, Apr 29, 2026 at 12:19:06AM +0200, Danilo Krummrich wrote:
> On Fri Apr 24, 2026 at 5:31 PM CEST, Johan Hovold wrote:
> > A recent change made the faux bus root device be allocated dynamically
> > but failed to provide a release function to free the memory when the
> > last reference is dropped (on theoretical failure to register the device
> > or bus).
> >
> > Fix this by using root_device_register() instead of open coding.
> >
> > Also add the missing sanity check when registering faux devices to avoid
> > use-after-free if the bus failed to register (which would previously
> > have triggered a bunch of use-after-free warnings).
> >
> > Fixes: 61b76d07d2b4 ("driver core: faux: stop using static struct device")
> > Cc: stable@vger.kernel.org	# 7.0
> 
> I think this is more of a theoretical issue, do we need this in stable trees?

Sure, this is borderline, but given that autosel would probably pick it
up anyway we might as well mark it directly.

Johan


Return-Path: <stable+bounces-241913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPUZLQ0r8mlvogEAu9opvQ
	(envelope-from <stable+bounces-241913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:00:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D9049761E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 18:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EA403004D0E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA0B37EFF4;
	Wed, 29 Apr 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0zAt8us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF8377EA4;
	Wed, 29 Apr 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478411; cv=none; b=qQGG+fz7XxPOT/o7v35csB3eNndPunJn5YCvyRoL7Zz2WRd/tTJU6pgBEpQJ5O6dsuRh5dxxL/5MKeRIhOqp+JFG0EWYFQgw1PFmOEAEe/uGMRHbMqDhDkJWk1Ga5vZU7gGeNBJ9Js40vuFhJY74R5aStNkfuLlAAEPx+Eqk2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478411; c=relaxed/simple;
	bh=sMdRm/RbUZiy8RJgxiX/P1sf/lsJ0+eeYeKKQlydboM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9/5mK0MQQeCi3lxzWBiXIs6IP9Dm+JKksEMz0ztL/nCRU2J5vpHyhV7MZoyz5H5nNdW/HuvETUGtA0YW/7pEYpSLrkkdgIqLb83WK0QR6RdsNrgN6gdGuM2EJsH5ZN4QIQn6bDp+8imQ0dmneySy//v2V19QNzYnNFL7+00I8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0zAt8us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91431C19425;
	Wed, 29 Apr 2026 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777478410;
	bh=sMdRm/RbUZiy8RJgxiX/P1sf/lsJ0+eeYeKKQlydboM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0zAt8us7Zav7/LvN+zL6WEHDAM8SWvHCYqTrCOf1YSqzVcYmYEzMLvXj6BbrcG3G
	 oGiD4SbWTkiizGsoWc75YFpF0rzWHToF0ZKuKKBBiTgZvEKslazY7Kouj0WQvggdUF
	 v1Zod08XxS+u3jVwnUJlLHRnxypqDL5jn0bwOXSiPM9iQRFrPTfssArygBIYaIK4Sr
	 UM1Ri9VA9p9VmpVxd7V0JkjbLOLc4CqMPJ213wewMynlK4DVOD7qfEVKs0IOTOrr59
	 qB/s9tKVjOPCDXsx5j96zdPGCvDejZPI1c0e/NcoFaHHb7W19qgLJ8omkdhlErz/wL
	 KLKgvFXkqX4CQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI7Ka-00000000mHH-15b1;
	Wed, 29 Apr 2026 18:00:08 +0200
Date: Wed, 29 Apr 2026 18:00:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: reject devices with unregistered buses
Message-ID: <afIrCO3QSL3hx10S@hovoldconsulting.com>
References: <20260427102852.2174-1-johan@kernel.org>
 <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
 <afHZWasOhRaeBCnt@hovoldconsulting.com>
 <DI5LDIQW45PE.LPIWCARJV7WC@kernel.org>
 <afHsgv9SUqfn-G1x@hovoldconsulting.com>
 <DI5Q29QMNVNH.1B2N4VBA2ZVQW@kernel.org>
 <afIe495IbAe7EeDt@hovoldconsulting.com>
 <DI5QUINEJC6U.32I161SD0KU76@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5QUINEJC6U.32I161SD0KU76@kernel.org>
X-Rspamd-Queue-Id: 50D9049761E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241913-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hovoldconsulting.com:mid]

On Wed, Apr 29, 2026 at 05:29:02PM +0200, Danilo Krummrich wrote:
> On Wed Apr 29, 2026 at 5:08 PM CEST, Johan Hovold wrote:
> > No, I'm saying that it's a bug in driver core to silently treat a device
> > that is registered before its bus as a bus-less device.
> 
> This is an argument that I can buy into, but in the previous discussion (and in
> the commit message) the whole motivation evolved around "reject devices with
> unregistered buses to catch any callers that get the ordering wrong", i.e. catch
> other people's bugs.
>
> What you are raising now is "the driver core is conflating no bus with
> unregistered bus handling". However, the commit message does not reflect that at
> all.

The commit message already explains the issue:

	Trying to register a device on a bus which has not yet been
	registered used to trigger a NULL-pointer dereference, but since
	the const bus structure rework registration instead succeeds
	without the device being added to the bus.

namely that

	 registration [...] succeeds [but] without the device being
	 added to the bus.

> Can you please adjust the commit message accordingly?

Perhaps I can add "(i.e. as if it were a bus-less device)" to stress it
more but I'm not sure it's needed.

Johan


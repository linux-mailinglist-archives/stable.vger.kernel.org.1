Return-Path: <stable+bounces-224838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qC9ZOA2XsmmKNwAAu9opvQ
	(envelope-from <stable+bounces-224838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:35:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7903D270608
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 11:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B6CB302A7E3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0C03BBA1B;
	Thu, 12 Mar 2026 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOaGn4lM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EB355F5B;
	Thu, 12 Mar 2026 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311751; cv=none; b=UpIUaPA9noPzJp/r+qIeInsRZP6AWA0gZzGzFZnqxlD91QBHnOWX8WFgbCbBAn3JsvCCVJ8suQ4Mi/UpoOmsckpi05dMl7WmKklnupgCyJp82ZeadirN3R/9BSMOw4kxnX2C0gSBPDLzIkXDlhFPxhQfOXM/6K9gV5NIQs9wY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311751; c=relaxed/simple;
	bh=GTwHdgF7vBAV/IsVwtapwEsSAu9UF5nUCSNkVMRw+fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U73ZYA1ybNCfgXxP1a081qUahr3oMbTG6EcxtsvOmJOIXXywSBwCC96KaTMrwC43dSdaRjcSO3wyxyyRxLiRRwVPER21vGNgQ1e34Zr27An7EGUJiGvH/qqnBY/8eHjHxtSBKWKqccqP/RGnfLXYhh/WQmogykm/Z0zhaI5VP2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOaGn4lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65117C4CEF7;
	Thu, 12 Mar 2026 10:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773311751;
	bh=GTwHdgF7vBAV/IsVwtapwEsSAu9UF5nUCSNkVMRw+fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOaGn4lMFtpFhff53VnZ9raxbzyqqWyYnNqZnriFYucAH87SIXx7Lyut4Visrcr9+
	 WWkL6K2fVwQqFzYZmW0ax89ssBBO7G6CMD/05wi1/RAthptHXRXtsTMiqIzugVKDR+
	 mVrmqs4Ot7pdvnPT0inLKtbOYP7uE0i7St7HdfaN+gJduL898MJDt0IO2sxiRoyw1b
	 a7Q0H6PmNP0gTZrwwncNFq3ra54/CUTYsbKucQx6IQ1VDMQ1ZShT3YR5uO2cmmc4rF
	 QbDiHsBNdy67SRjfY72T7o5Sb9DLGdejXa3TlEHjp8TbHDQrU629mi7d77X8R0c/Yb
	 LNOZI4ansjbAw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0dOP-000000007mh-01Bz;
	Thu, 12 Mar 2026 11:35:49 +0100
Date: Thu, 12 Mar 2026 11:35:49 +0100
From: Johan Hovold <johan@kernel.org>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence98@sch.bme.hu>
Cc: linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: cp2615: fix serial string NULL-deref at probe
Message-ID: <abKXBepGY2ha3DHc@hovoldconsulting.com>
References: <20260309075016.25612-1-johan@kernel.org>
 <32f6793c-d728-451d-9e32-35d864fe0035@sch.bme.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f6793c-d728-451d-9e32-35d864fe0035@sch.bme.hu>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224838-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bme.hu:email,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 7903D270608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 10:40:19PM +0100, Bence Csókás wrote:
> Reviewed-by: Bence Csókás <bence98@sch.bme.hu>
> 
> On 3/9/26 08:50, Johan Hovold wrote:
> > The cp2615 driver uses the USB device serial string as the i2c adapter
> > name but does not make sure that the string exists.
> > 
> > Verify that the device has a serial number before accessing it to avoid
> > triggering a NULL-pointer dereference (e.g. with malicious devices).

> > @@ -297,6 +297,9 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
> >   	if (!adap)
> >   		return -ENOMEM;
> >   
> > +	if (!usbdev->serial)
> > +		return -EINVAL;
> > +
> >   	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
> >   	adap->owner = THIS_MODULE;
> >   	adap->dev.parent = &usbif->dev;

> AFAIK real CP2615s will always have a serial, so returning error should 
> not be a major problem.

That's my reasoning as well. In the unlikely event that there'll ever be
valid firmware without a serial string we can amend the driver.

Johan


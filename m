Return-Path: <stable+bounces-224706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHTJLIGLsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:34:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C458266A0D
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03A1230C25BF
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F543E0229;
	Wed, 11 Mar 2026 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHrg0ISI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98173DEAEB;
	Wed, 11 Mar 2026 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242933; cv=none; b=BGXb/sn0wQqfevuH4+3k8tHdU5lf0fKd7Zz8fnGmzpKnUfMtqt+j6N7RAbjrCYoPjMURE3ZLViC1XAbUo+IoLbWvZ6cCfm0jEpBAEucvQppQCR3nmjbuYqS3JLO5+mPi70164WLYA/gCLUheyyX1Wz8fPth/O6IrubQTvItJRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242933; c=relaxed/simple;
	bh=cK8roTeUNGE88kbK3gM4a1vcI2rUXRoU2VkqZF3mQOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn5wlx41cunaX3ASdv9Dt7Z0oMEBTlPQc34Q/2yREEcK2S4nST8g4tMEEWi4ZHvKUhyynWlK5tAfAuFHCZ2oQmlWlY97OJcuqSRPm8Wy3Pu5NG7EnPSfVrqT1sT+5rcXu26kR6QzD/ps1N1v7/69Q1jcQCzRPHGahHNn4C+yTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHrg0ISI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711F0C19424;
	Wed, 11 Mar 2026 15:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773242933;
	bh=cK8roTeUNGE88kbK3gM4a1vcI2rUXRoU2VkqZF3mQOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bHrg0ISIv5x44cBHM6o1cLEFJmMB6xbB7C2Tp6WXe9T13lRjgxSwz2J7qyMg3gGZb
	 631Gff2WNoLhSOuqs+2Ql6GKPcMKyID7U/M8C/ezYffMjNTbJpyYwW2evoE8oLITei
	 bzwRxMp4eeOD59budJY14Eev2OGl56jBmgWMyD0ER6G4AEuuurZu1vYjB6lQt2bZBE
	 MkVXPhPZWCv/Dx+nqx/kmCxN1yej3U9KnUnkHQ2zbiPBJMNHld5Y2c2B30Wa+X4BUN
	 YC3Bxj/FLaiix0b/JZOjOJqBLHhWjaOyuS7dPPVKFXm4/+DtP61K1PDmYoByy5gDC7
	 SJphF3CvtCqfQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w0LUQ-000000007JJ-3mUj;
	Wed, 11 Mar 2026 16:28:50 +0100
Date: Wed, 11 Mar 2026 16:28:50 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] gpib: lpvo_usb: fix unintended binding of FTDI
 8U232AM devices
Message-ID: <abGKMhiPRS3wDLqn@hovoldconsulting.com>
References: <20260305151729.10501-1-johan@kernel.org>
 <20260305151729.10501-2-johan@kernel.org>
 <2026031131-abdominal-surgery-9b98@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031131-abdominal-surgery-9b98@gregkh>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224706-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 2C458266A0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 03:21:52PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 05, 2026 at 04:17:28PM +0100, Johan Hovold wrote:
> > The LPVO USB GPIB adapter apparently uses an FTDI 8U232AM with the
> > default PID, but this device id is already handled by the ftdi_sio
> > serial driver.
> > 
> > Stop binding to the default PID to avoid breaking existing setups with
> > FTDI 8U232AM.
> > 
> > Anyone using this driver should blacklist the ftdi_sio driver and add
> > the device id manually through sysfs (e.g. using udev rules).

> > @@ -38,8 +38,10 @@ MODULE_DESCRIPTION("GPIB driver for LPVO usb devices");
> >  /*
> >   * Table of devices that work with this driver.
> >   *
> > - * Currently, only one device is known to be used in the
> > - * lpvo_usb_gpib adapter (FTDI 0403:6001).
> > + * Currently, only one device is known to be used in the lpvo_usb_gpib
> > + * adapter (FTDI 0403:6001) but as this device id is already handled by the
> > + * ftdi_sio USB serial driver the LPVO driver must not bind to it by default.
> > + *
> >   * If your adapter uses a different chip, insert a line
> >   * in the following table with proper <Vendor-id>, <Product-id>.
> >   *
> > @@ -50,7 +52,6 @@ MODULE_DESCRIPTION("GPIB driver for LPVO usb devices");
> >   */
> >  
> >  static const struct usb_device_id skel_table[] = {
> > -	{ USB_DEVICE(0x0403, 0x6001) },
> 
> With this change, the driver now "does nothing".  Should we just mark it
> as CONFIG_BROKEN as well?

That would prevent people with this device from using the driver by
manually adding the device id through sysfs.

Some FTDI devices can be programmed with product specific PIDs, but not
sure about 8U232AM. Or if whoever built this is still around to care
enough.

When I saw the skeleton driver included verbatim, including the
example minor number (which has been reserved for something else, but I
guess that's less of an issue these days), and that it was binding to
the default FTDI PID, my initial thought was just to drop the driver (or
move it back to staging, but then we'd still need to drop the device
id).

Johan


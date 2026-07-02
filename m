Return-Path: <stable+bounces-270534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vhDhFehxRmq/VAsAu9opvQ
	(envelope-from <stable+bounces-270534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:12:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4126F8BEB
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:12:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VTKZULeU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270534-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270534-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B166301AC17
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25204C8FE3;
	Thu,  2 Jul 2026 14:12:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015423909C;
	Thu,  2 Jul 2026 14:12:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001573; cv=none; b=ORziPh5eqa5PV0F+RtqTxSu1WP7UbRKbNNHRoSihs43t0I3MD5+SF0QuqeRrmaDRJSxA+Hd5Bh0fOKNiYJg46YseoqOtdolaUPnwIduCQRiMrh4GZjHlNhHWunXkBEiFvm4JZjVIg3vxozAhFg1VMh7eRB1sOAbejjS9t4z6DeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001573; c=relaxed/simple;
	bh=tvTsZDjf2fhGySByE9ROAH4UK4iLC2jPha0ViLQAwTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTdyRQ5elRCES04QedDYLVta7IznLq98dvXND7J6nsmYejsWGdboAhTa/gwyV1XFSVjsZFTCIRMqMAXfxiWktnPqTBUgcWCaaX5pjyqJfz0C3/egUP4YZl4km+vTNb/RRw2G7lFzgEGU/2JZSo8nH3P12I85l6CMVC8zYNdw7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VTKZULeU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D9A1F000E9;
	Thu,  2 Jul 2026 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783001572;
	bh=iqz5Du5IDsnX8TpY2PI/QH6BNGk5SwNhXkvWeledBas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VTKZULeUnvQ9hRBHNV0ZiTFtGinV7y70p0ps0znmHRtzpFmSUNz2rx1WAVnhX97Sk
	 dzqU/65/i8upUcG0m4R6v5eJ19mUyOF/5nJ6meKuInAy6ldc/qJR2M1rkLSaOFnspU
	 0fuw7g5YOv+7OzK6V1t5JqpIk8j2BLP2IQ2Arpc4=
Date: Thu, 2 Jul 2026 16:13:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: stable@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Subject: Re: [RESEND] "ext4: get rid of ppath in get_ext_path()" 6.6.y
 backport request
Message-ID: <2026070251-amnesty-jazz-f40f@gregkh>
References: <DJH7FQUH9KQI.N8NISCQILPH8@smile.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJH7FQUH9KQI.N8NISCQILPH8@smile.fr>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270534-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yoann.congal@smile.fr,m:stable@vger.kernel.org,m:libaokun1@huawei.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC4126F8BEB

On Wed, Jun 24, 2026 at 12:24:21PM +0200, Yoann Congal wrote:
> Hello,
> 
> (Resent with developers/maintainers of the patch in CC)
> 
> I'd like to request the backport of
> 6b854d552711 ("ext4: get rid of ppath in get_ext_path()")
> on the 6.6.y branch.

Please submit it if you wish to see it applied.

thanks,

greg k-h


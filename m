Return-Path: <stable+bounces-227586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDfkKEKFvWnQ+gIAu9opvQ
	(envelope-from <stable+bounces-227586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:34:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 079692DEB84
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5A731CDF5E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872B3D4116;
	Fri, 20 Mar 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YVf3oRnR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E523D47CF
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027636; cv=none; b=QTMuObd7NKQ5c45gROGKo1t/wL6wS9/v7bm/koHHauisbM35GL3gOaL9x53kqEi2jikwKgWYBjYkGO+G2nHrcQ++tKop+k/QteltKwbExf4ABDPrURrKyMCngIlvdEMup6D2pVqPPYMqvHI1UtA+0bOxi0kdbHnVlKYRmyTIpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027636; c=relaxed/simple;
	bh=OgouGxCY0vTwQgsVryBJURSDqhmhr20UC999CFkgByE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ8FjCUG5HNiY9T4wPR3mdppbfCaluabpsvu+9QWklRkmoDXzcUYX6+0M5o15zcBm975MrFbbBnZDMEcu0DrAcvROq1dsy0nNsushV88DvICBRmLl8IZ2MLAz35MvikzLijqGXLdJmwCnpBnRRRjR42hGsmucOLdsQa4m8XPZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YVf3oRnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936E7C19425;
	Fri, 20 Mar 2026 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774027636;
	bh=OgouGxCY0vTwQgsVryBJURSDqhmhr20UC999CFkgByE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVf3oRnRYV+6Syh5vaq8CE0aUVVTaakmLpnNTX4Qap5rPdPIsnbu7oSD0QlBbOvSq
	 PbiAr5VSnju0yHjIX4vAsZEpbYweFUi6HnO9bKlIPVotmqqWsAwAEbFPOCZuQ2IZNT
	 H6goRRxtZRs0PMRUz29piAUVeZgjssC0htLoaOfg=
Date: Fri, 20 Mar 2026 18:27:12 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "jkosina@suse.com" <jkosina@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Message-ID: <2026032008-sulk-glaucoma-d5c1@gregkh>
References: <2026032053-reviver-stock-9da2@gregkh>
 <MAUPR01MB1154696DABA7DD9EE0D6E99D3B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032039-rosy-playmate-f405@gregkh>
 <MAUPR01MB11546A98F8C38646ECEC2FD77B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032013-eggbeater-glamour-d06b@gregkh>
 <MAUPR01MB11546D3BF5B8AE4715111B467B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MAUPR01MB11546D3BF5B8AE4715111B467B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[live.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227586-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 079692DEB84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 05:17:00PM +0000, Aditya Garg wrote:
> 
> 
> > On 20 Mar 2026, at 10:43 PM, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿On Fri, Mar 20, 2026 at 09:17:52AM +0000, Aditya Garg wrote:
> >> 
> >> 
> >>>> On 20 Mar 2026, at 2:45 PM, gregkh@linuxfoundation.org wrote:
> >>> 
> >>> ﻿On Fri, Mar 20, 2026 at 09:01:27AM +0000, Aditya Garg wrote:
> >>>> The driver doesn't exist for kernels before 6.15 so it's not needed there.
> >>> 
> >>> Thanks for letting us know, but backports for newer kernels would be
> >>> appreciated :)
> >> 
> >> I have already sent them to the mailing list using the git send-email command mentioned in the email itself :)
> > 
> > I think you forgot a step that added the git id to the changelog area :(
> 
> Should I resend the patch with the git id?

Please do, thanks!

greg k-h


Return-Path: <stable+bounces-227582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMbNGfSBvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:20:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 693772DE7FA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2D073014923
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E72B3D171D;
	Fri, 20 Mar 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g74IpXwe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305E3CF051
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026813; cv=none; b=Z60ARbRATlfnXjhr3HHWBY3Zpa3GuF4hShYY9pesRxFNSZ7FnKHpVOVGww6YYGRl2nKxyegb4vi51ScGsWOi59CY1QVCcm/1+Fs9eFKxOKJfzifXa7XY8QF1jc2613CBxtnvAcNJRRmQeOt4MESfGvu+nH9YpKo89qLWCkSvTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026813; c=relaxed/simple;
	bh=EW8QhKqmTyHr8EJleyyltkDFHKnCuui5szDMOLFW+IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8AtmbuwRBbvJryJv16y1gOMOkNcyu098XtmeBZdsSFN9JgJ02DwZeAjLLtuAIlKDxfegF3l6OZTpmG+svqSord4Uw2hEnICeZ8CWuL9yPxxbd43p0XmYMn7t4zNagCVAkWr2+G4weUVlmRZbIu3c3QrhqOULI7abV2ohE5nKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g74IpXwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439E7C2BC87;
	Fri, 20 Mar 2026 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774026813;
	bh=EW8QhKqmTyHr8EJleyyltkDFHKnCuui5szDMOLFW+IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g74IpXweDCmn2TmaOGgsa/DqNaMplxf6G+6IkHM57DPHGQsSgYggEw1OwnWVpBrLB
	 uWgm7xpo81stf6onzFlyyu/lU+nks/5/30Y+JxiI1jh0+vsSxAwxWPiNpE71eLZOGw
	 1G8jup6mSu3yMDCHZmSSG4UqeoKC+WIVH+xAaKaU=
Date: Fri, 20 Mar 2026 18:13:29 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "jkosina@suse.com" <jkosina@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Message-ID: <2026032013-eggbeater-glamour-d06b@gregkh>
References: <2026032053-reviver-stock-9da2@gregkh>
 <MAUPR01MB1154696DABA7DD9EE0D6E99D3B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032039-rosy-playmate-f405@gregkh>
 <MAUPR01MB11546A98F8C38646ECEC2FD77B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MAUPR01MB11546A98F8C38646ECEC2FD77B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-227582-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.941];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 693772DE7FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 09:17:52AM +0000, Aditya Garg wrote:
> 
> 
> > On 20 Mar 2026, at 2:45 PM, gregkh@linuxfoundation.org wrote:
> > 
> > ﻿On Fri, Mar 20, 2026 at 09:01:27AM +0000, Aditya Garg wrote:
> >> The driver doesn't exist for kernels before 6.15 so it's not needed there.
> > 
> > Thanks for letting us know, but backports for newer kernels would be
> > appreciated :)
> 
> I have already sent them to the mailing list using the git send-email command mentioned in the email itself :)

I think you forgot a step that added the git id to the changelog area :(


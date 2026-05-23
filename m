Return-Path: <stable+bounces-253902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF71FWxAEWq9jAYAu9opvQ
	(envelope-from <stable+bounces-253902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:51:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A885BD55E
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149D1301B904
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA32F8EB0;
	Sat, 23 May 2026 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="leMg7eOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F63438B5;
	Sat, 23 May 2026 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515458; cv=none; b=uwOUa13AVByImIks2Wm14Hs8JisgAqdKtEJsqNhxzWk/kvkQtXzER8LEZ5g/qZrNQeYif4hwQRS6itDMjy51m8Fylh8iKh7EB1Lognt3iSz6yxH8Ns08O+VK+fPn7mcjaL53dqraaqEmkr5la8ONoQRoViSk4qcttrXzVV9Y4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515458; c=relaxed/simple;
	bh=nRS+wN9zkUZr33WgWLXSQv5niua3cI1+oLDIW6xlW/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ/leE6jaMYi8/Yzvm02fF4TDW1vAvXrnIuKN7r77EIyxTbbOaaGEh9w3+w1Wxb9acceGKNw6wf98LONW7x50hLlRNpeli2LHpG4ZluMBOA/KDiryFwf85ZnqSZBtT61/HguebfJ3YJhF5wC5aA8B+v9f6j4WMFR8GT/aRzMIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=leMg7eOD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764EE1F000E9;
	Sat, 23 May 2026 05:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779515457;
	bh=tMqXD1G1SzKVmD3nov6C+E2xL41ye3E6M+B4ZKYn7g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=leMg7eODLUFbh+daQ1i/w6j7u/DiRvYqQHe2NIYyetKCZgMBCdr94RobXfIyVAQPS
	 T3aCeKknOjTvh/ffiZaU5Rkn+YDdv0Of1VYkrmhRgyzHJji92FwlZT/SgYIWS8Hvix
	 CDZu0C0aLKVw4ILlGwGyufo3G/IxvggURUP8QtCY=
Date: Sat, 23 May 2026 07:50:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: safe_serial: fix memory corruption with
 small endpoint
Message-ID: <2026052354-stability-prone-4fbb@gregkh>
References: <20260522142218.947657-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522142218.947657-1-johan@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253902-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D8A885BD55E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 04:22:18PM +0200, Johan Hovold wrote:
> Make sure that the bulk-out buffer size is at least eight bytes to avoid
> user-controlled slab corruption in "safe" mode should a malicious device
> report a smaller size.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/serial/safe_serial.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Return-Path: <stable+bounces-254503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLTUIbqmFmoOoAcAu9opvQ
	(envelope-from <stable+bounces-254503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:09:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C75E0DC2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87553300E179
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2027739A060;
	Wed, 27 May 2026 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Etv+txQd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3D257849
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869365; cv=none; b=Ab2/UgK7eEVLx+giafkPKmA5Zo5B3dlVnmipeRhEdC28MGlUdTAIxPWi4fP+hpos+nTFxzCaMsKU//AGvQAfU0i0H9EnRHydAGcA6ttmOTC0L7HScXIDBUJKq3ssow3rUX9bJkNZKLndwRf5ECg4umg46GhmWtIDnuvuIhSRbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869365; c=relaxed/simple;
	bh=vDD6Z/wF9FJG2OJ1sL+E6z5VJje7be/lzVJ6TlJHZLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hp//7/hAUWx3zgqI2AL+IF4WG9wd2fI5bmEL3lvfVqh9EIN7Luxh2mx6IxvIQMZPhGu2r5SJco9/f5unsAtaCP9vVu7+pogTTlK9HWbrD5NUEuK0LVQqTAZK4PY9y9Kt8JSd58T6sGC0PzppI95omDe1Y1hDzmw1gpLJ5pCwrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Etv+txQd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAA41F000E9;
	Wed, 27 May 2026 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779869364;
	bh=twKe+XCtClCbDOsar2qTrvVcvoqWOIlYgcPxBevZuhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Etv+txQdGyYlCxVz1m9x/oDZkS07eSmngMyHicXbqxcxh3lbbUweavukNLY0vIT7H
	 C6jMXQDFwKb3/XMdcAIOpiAvTc/np2ZfEluY6M/j41vEVbiDAMTEA4x+uvtgc0ryY0
	 yiOUlylSs3oqtvvYiUs3UX32Kr28j0fkBYZMYg74=
Date: Wed, 27 May 2026 10:08:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: manizada <manizada@pm.me>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Please apply 3da1fdf4efbc to stable
Message-ID: <2026052742-discharge-smudge-6453@gregkh>
References: <HWDVTGhsU6ON7YOl4ipsBa-4aBO4UMs2EdpPPhEyYoOWmVqbo__aVWaSuEIqescKSIxPJalwVPc2BQax8VsPmuZUXyF14lBaCyyrnu2_40g=@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HWDVTGhsU6ON7YOl4ipsBa-4aBO4UMs2EdpPPhEyYoOWmVqbo__aVWaSuEIqescKSIxPJalwVPc2BQax8VsPmuZUXyF14lBaCyyrnu2_40g=@pm.me>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-254503-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0C4C75E0DC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 05:08:43PM +0000, manizada wrote:
> Hi stable team,
> 
> Please apply the following upstream commit to the supported stable trees:
> 
>   3da1fdf4efbc490041eb4f836bf596201203f8f2
>   smb: client: reject userspace cifs.spnego descriptions
> 
> Reason:
>   cifs.spnego descriptions contain authority-bearing fields consumed by
>   cifs.upcall. This commit prevents userspace from creating trusted
>   cifs.spnego descriptions via request_key(2)/add_key(2).
> 
> Requested branches:
>   Please apply to all currently supported stable/LTS branches where it is
>   applicable, including 7.0.y, 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, and
>   5.10.y.

This does not apply to the 5.15.y or 5.10.y tree, please provide a
backported version that can apply there.

thanks,

greg k-h


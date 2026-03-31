Return-Path: <stable+bounces-231384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCNVENahy2lHJwYAu9opvQ
	(envelope-from <stable+bounces-231384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:28:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94784367F40
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 562EF30AA87C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF63ECBE5;
	Tue, 31 Mar 2026 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dm5WcEns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990993ECBED;
	Tue, 31 Mar 2026 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952460; cv=none; b=R+dZFGU8H4fqgHoz1J1QAET2fBgf1zeyXadZQwNOLrZy7QPMTXJuPcHYWjHT2JBvl1+/Sa57wgqbf/SdMJMEa3XbQqNcHJWMR47BlBNy8r6XbI5b1u3FqtpSFfyGfVIT6zpUG1M/E/uZ+Vn0tKJdG7EBk8YeeTwAfgxhRmpKgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952460; c=relaxed/simple;
	bh=BHEsXAaKbfrTXbZu0YNFbP6Pcp3fCQx38/LD4/9y+7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfk1fjT48wbXdGEIMdP60NSKsY3Qny0ggDO95JHulgcY9cr0dhpr2Tz07wGM69+hqA6DIoGCpNHA2IXFbaTj5nFCq9wf3QM/zFBTQMlyjj+edCpXR9xolYo8pV2G4DY1mFjgAozHDePceJt+bkZ2cbPG9fWbzzftbifVwbXxrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dm5WcEns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FE5C2BCB0;
	Tue, 31 Mar 2026 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774952460;
	bh=BHEsXAaKbfrTXbZu0YNFbP6Pcp3fCQx38/LD4/9y+7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dm5WcEnsStHtpWK/aZwkhUyLzoymBLHNV1Dff5LVpvUIl93CqQvWCFMPkXte90VNS
	 wtKeeiKHv+MBYhPFtdXtQ24XaFd5FrEVw8u1tEgtDc5oQaemtsTsgqeWzIzORCreVC
	 sV7MaH6dj4k9wH4UVK8kmitNatoo536RUTAk/Mjw=
Date: Tue, 31 Mar 2026 12:20:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Mario Limonciello <superm1@kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	stable@vger.kernel.org, jslaby@suse.cz,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: Linux 6.18.19 -- amdgpu bug and a new warning
Message-ID: <2026033151-require-onward-f864@gregkh>
References: <2026031914-send-embezzle-1648@gregkh>
 <1df33732-8d66-d669-84a8-259f1b7f3278@absolutedigital.net>
 <156c7e58-df60-44ca-8c26-78ccab2c1647@kernel.org>
 <9223c139-3c0e-49b0-a5c2-27025739e8e9@oracle.com>
 <8e2fcc37-7192-6eca-e4e-f9d6ebef8ec0@absolutedigital.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e2fcc37-7192-6eca-e4e-f9d6ebef8ec0@absolutedigital.net>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-231384-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94784367F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 05:43:41PM -0400, Cal Peake wrote:
> On Thu, 26 Mar 2026, Harshit Mogalapalli wrote:
> 
> > I think backporting this would help ?
> > 
> > commit: e12603bf2c3d ("drm/amd/pm: fix amdgpu_irq enabled counter unbalanced
> > on smu v11.0")
> > 
> 
> Ah, very good find! Thank you, Harshit, this fixes things up.
> 
> Greg, please consider commit e12603bf2c3d in mainline for 6.18 stable.

Now queued up, thanks.

greg k-h


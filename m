Return-Path: <stable+bounces-233007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO4nOIVdzmnvnAYAu9opvQ
	(envelope-from <stable+bounces-233007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:13:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E943388E85
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C84301BCD2
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFFF3E023B;
	Thu,  2 Apr 2026 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+hnucde"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69113E0234;
	Thu,  2 Apr 2026 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131940; cv=none; b=HulQaKm2Z3co9euxQIqbHl2tJ5JkAtTVy1DPbk+eq3aSszlWdfklU8I7VJevxuVLWRj3aTUI7XFcV0LaeTtyjH0WKPrjMtEzYidZCR+L9DEFpDXcdNKO+Q/qBmGVCYQNXb8yKf0ZPefPY4tNFqGKBIQRdhV000CihYFUnwP8lvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131940; c=relaxed/simple;
	bh=mI9VFZsuhgPGi6KsENAPjVx/BbS778vsmGw3e5R4AeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSgNv7AXA8PTLLnsjVvaszJgccFyIlQZQMpdOCJeAB9vzKnMDVgUFCVACwQfjwK7URhwWldvWCak6foGqN5w28DnE4HothxQ/Ft0VN421Scs2KNHHC9/BfgwFxFEivaF91GcZ+7JFnbDkOpN/udYrM/lya8i9FvAbCkINK/XlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+hnucde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F24C19423;
	Thu,  2 Apr 2026 12:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775131940;
	bh=mI9VFZsuhgPGi6KsENAPjVx/BbS778vsmGw3e5R4AeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z+hnucdeXxE0kPbk7CkEzSWGZNnUgpSEM55vmH1f+nisBxT7FED/yUwORM2f2uofU
	 R8On16u+jJ0q3ogDwfU2wM1Y6qfhGLX+SbS/EALV3IvFXR3sWhr9d/oYeH+MGM3TPd
	 /sFC3svWk+oPrg7/lEgZfjr/uaDg5CTTuJuUhi4I=
Date: Thu, 2 Apr 2026 14:12:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Matt Fagnani <matt.fagnani@bell.net>, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Warnings and errors in drm_mode_config_cleanup when booting
 6.19.10 and 7.0-rc5
Message-ID: <2026040259-glacial-reversal-9a75@gregkh>
References: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
 <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233007-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bell.net,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E943388E85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 11:52:48AM +0100, Thorsten Leemhuis wrote:
> Matt, thx for the report.
> 
> On 3/28/26 11:30, Matt Fagnani wrote:
> > I could try to bisect. The commit
> > e493c135980f90c20308d1a98f2e0d1223951e94 drm: Fix use-after-free on
> > framebuffers and property blobs when calling drm_dev_unplug was included
> > in 6.19.10 and changed drm_mode_config_cleanup https://git.kernel.org/
> > pub/scm/linux/kernel/git/stable/linux.git/commit/?
> > h=linux-6.19.y&id=e493c135980f90c20308d1a98f2e0d1223951e94
> 
> Did a quick search. Turns out this is mainline commit 6bee098b914176
> ("drm: Fix use-after-free on framebuffers and property blobs when
> calling drm_dev_unplug") -- and when searching for that (FWIW, this is
> not widely known, but that is really helpful in case like this, as the
> mainline commit id is way more relevant) is turns out that is in the
> process of getting reverted:
> 
> See https://lore.kernel.org/all/20260326082217.39941-2-dev@lankhorst.se/
> or 45ebe43ea00d6b ("Revert "drm: Fix use-after-free on framebuffers and
> property blobs when calling drm_dev_unplug"") [next-20260327
> (pending-fixes)].
> 
> Sasha and Greg: you might want to make sure to pick this up.

When it shows up in a Linus-released kernel, can someone remind us?

thanks,

greg k-h


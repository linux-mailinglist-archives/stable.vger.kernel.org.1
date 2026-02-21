Return-Path: <stable+bounces-217629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGkcLttRmWn2SgMAu9opvQ
	(envelope-from <stable+bounces-217629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 07:34:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CA116C481
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 07:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4553F3023524
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8A927FB37;
	Sat, 21 Feb 2026 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQ7uNqDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26C23504B;
	Sat, 21 Feb 2026 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771655639; cv=none; b=bYvOvKLDmJQYgaiJ0YXizBNMismzoHLShwTNIchQemyigg5bPjPDueSV0OktxSRduZ9WcAnxfTvcWE425zV1F08abYf3aOuG3LdjJLARiTiKFIFDQIyDl31UApZgmmOFap2fQzGgX0DmJPwf7behsp2MoxE9AmVx3sV0mGXiSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771655639; c=relaxed/simple;
	bh=hHq5dcyYTdFsZlLYK9nRJEVSiMhOiqtXt6G6U+a034A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZhdTItmFqq1cTFZNfU3Gw9733LPTTC9yAD0eISRtoFnCb/U50EjS6TkjEhc+9kNoEWS73jD3NwBqAViPb50N7urYdraaEeBiDDINNP031Qmg78TdzwF/4XeL/yseUgVTWN4xAe2xgt6rR830ex5N01CmMK7xjyhYu2iioQDApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQ7uNqDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A85DC4CEF7;
	Sat, 21 Feb 2026 06:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771655638;
	bh=hHq5dcyYTdFsZlLYK9nRJEVSiMhOiqtXt6G6U+a034A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ7uNqDdWUiZrYJoxLWRuOOS4giMJEmmrXgRY7Zr/haqVJZBl3BouBqAc/w1TjTCZ
	 d8iCXbdnlWDVnaIWFMnV8BZSPm1GieSjsz6n+rNbSjlSdg9B974EGiZpEdK2rcue2r
	 RC0Rf5gKCZMlzw+g4o2aOK4eKNWNUmt5kHVGCcHY=
Date: Sat, 21 Feb 2026 07:33:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "drm/amd/pm: Disable SCLK switching on Oland
 with high pixel clocks (v3)"
Message-ID: <2026022126-chair-spout-641a@gregkh>
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-3-rosenp@gmail.com>
 <2026022148-unsorted-pushover-8262@gregkh>
 <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217629-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35CA116C481
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 09:52:29PM -0800, Rosen Penev wrote:
> On Fri, Feb 20, 2026 at 9:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 20, 2026 at 07:44:02PM -0800, Rosen Penev wrote:
> > > This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.
> > >
> > > This commit breaks stable kernels older than 6.18 that are booted with
> > > radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1
> > >
> > > In 6.17, threre are further commits that are needed to get the DC
> > > codepath in amdgpu for Southern Islands GPUs working but they seem to be
> > > too much of a hastle to backport cleanly. The simplest solution is to
> > > revert this problematic commit
> >
> > Ok, this is better, but still, this only applies to 6.12.y, right?
> The reverted commit (or rather the one from master) was backported to
> at least 6.12 and 6.6. I didn't check what other kernels include it.

I see it in the following kernel releases:
	6.1.156 6.6.112 6.12.53 6.17.3 6.18

All except 6.17.y is currently being supported.

thanks,

greg k-h


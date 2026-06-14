Return-Path: <stable+bounces-263067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 94nwNYmOLmozzQQAu9opvQ
	(envelope-from <stable+bounces-263067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 13:20:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFC680E6B
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 13:20:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=t8IBpmE3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263067-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263067-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AD5B30031EC
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD2364029;
	Sun, 14 Jun 2026 11:20:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3835E95F;
	Sun, 14 Jun 2026 11:20:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781436035; cv=none; b=b4abwLzWnTRNMNrVlYPCSIrsqKQKdXED5agXo3hH/2nFh3kBrzVFJ3me8+CxM4xgZNH76uQXC7gH8g6KSYivPorLRvSPmd0DT0zcmk1t+OEzxAMi+xEHy9263RSSYAZlMe9kJ1eYlZfvZLh5F2igKGcUD34BBEHZ8LOx+hUIDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781436035; c=relaxed/simple;
	bh=9bnu40qoEGssx8pIaOPs0+3SkSACtTQtNIpNavpjTjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss0G+MVBeR43sdBL00kuxYw97PDIARgd5kcInhwT6arFbD9gMz9WphCJ3ILivenEDPuyG1qBGFjGYIqRbpwQj15dgBU6Z9n2EtitUTOWcUuz6j7plwwoqbCbDrGClbkrU4UFeXeBGdb8j7suJ6FoDFdDEMRpNpduDa3Wfr7t9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t8IBpmE3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC431F000E9;
	Sun, 14 Jun 2026 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781436033;
	bh=HkbSBTjLVZy3QDSNHMO9AiH5XKRueg+mXoVnWQwxDKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=t8IBpmE3bRoFxgVhKjWDaMZynZzBTsqwvcUtJj1iYyQapydiLTvGvGiy2rSYqQmB5
	 H1+6WH35A/7cZY2i3On6dSF/WfN8kIZ+pGBKpHkv1cEKSrpGMp7zW8ffyMVF+Qf/dV
	 Mw2fugdI9Q6AjFIDGeLcHGFBiMCXkmQQkIQRFnFA=
Date: Sun, 14 Jun 2026 13:19:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [RFC/PROPOSAL] Shifting the x.y.z Stable Tree to a Continuous,
 Signed Patch-Stream Model
Message-ID: <2026061420-emote-resend-9ad0@gregkh>
References: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
 <2026052444-unlawful-eskimo-9c41@gregkh>
 <5f62925e-0faf-40aa-a594-10ef6d50f24e@gmx.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f62925e-0faf-40aa-a594-10ef6d50f24e@gmx.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263067-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aros@gmx.com,m:linux-kernel@vger.kernel.org,m:sashal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FFFC680E6B

On Sun, Jun 14, 2026 at 08:16:06AM +0000, Artem S. Tashkinov wrote:
> Hi Greg,
> 
> Let me try to restate the proposal more narrowly, because I think my
> previous wording mixed several related issues together.
> 
> I am not arguing that stable.git is not already continuous. It obviously is.
> Nor am I arguing that cutting a point release is expensive for upstream. I
> understand that from the stable maintainer side, tagging a release is cheap
> and well automated.
> 
> The problem is that the ecosystem still treats the x.y.z point release as
> the main externally visible consumption boundary, even though it is neither
> the real upstream unit nor the real downstream deployment unit.

Not true at all, I would argue that this is the ONLY real deployment
unit as things are NOT tested in the stable releases except on that
boundry.  We do not do full testing on each individual commit, only at
the release points.  So to assume that you can consume a portion of the
stable release feed is not correct at all.

> The real upstream unit is the stable git branch: a linear sequence of
> accepted backports.
> 
> The real downstream deployment unit is a distro-built kernel package: base
> kernel, stable backports through some point in git history, distro
> patches/configuration, compiler/toolchain, signing, modules, CI, and
> user-visible packaging.
> 
> The x.y.z point release sits awkwardly in between. It is a useful
> compatibility marker for consumers that want that workflow, but it should
> not have to be the canonical boundary for everyone else.

Nope, sorry, unless you want to run all tests on each individual point,
this isn't going to change.

Also, you failed to answer my previous questions, like who is "we" that
is having problems with the current release process that is so difficult
to consume as-is?

thanks,

greg k-h


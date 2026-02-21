Return-Path: <stable+bounces-217622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP3LNH5FmWnNSQMAu9opvQ
	(envelope-from <stable+bounces-217622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:41:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF116C320
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C683038AC2
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97543313287;
	Sat, 21 Feb 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SvJV7tIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B746286410;
	Sat, 21 Feb 2026 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771652473; cv=none; b=dOqGUBFzSPKjfUb+0KbpcrW8UvldAa/RZGoJbKH9vNqROuMHMsq3A3CRZsGdPnN5XhPyWNYMsJ5iA7PpOL1aViCAae0aOuwEEn+yW5NvSzsS/SlfM/65YNt57EkHCQcdh+JIutocXrMuJhVcj5za5SkkGAsGtHss0Cz1hu4RAb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771652473; c=relaxed/simple;
	bh=EtABGilW/ybxyF/sBxk1E7K/D842FMAghACNgHJRUZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL8eXPHZBijAzdFvc11LduFYccUGmzj2YiQzhQ0pwJRaEyESuz13VKeLsseTB6uLJjZ8IeNYF7BJNmLjxRIKihHMFtzXbBvMOKg1rRvy/XFSFhIBi2yngyMztw3/9SPtYx/xzpJdKVnZ+UiunK4osCc9MdeGHluOlpYUePgeFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SvJV7tIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17CBC4CEF7;
	Sat, 21 Feb 2026 05:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771652473;
	bh=EtABGilW/ybxyF/sBxk1E7K/D842FMAghACNgHJRUZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvJV7tIToUjndHp8UPEN96Pi3sKQXusH2kwOSFLfhGp7TDWo9mYVtiS+7/HxYDQTw
	 af9XHIeVDazzUpb89IvjJNYgnor4B0VSYfOme6APdYD1jUwd48aCFCFz8MZgORz4cm
	 h6JkUWbE87I0hVELf0fHZhv4O4swRHsJeZHz7Pjo=
Date: Sat, 21 Feb 2026 06:41:07 +0100
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
Message-ID: <2026022148-unsorted-pushover-8262@gregkh>
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221034402.69537-3-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-217622-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3ADF116C320
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:44:02PM -0800, Rosen Penev wrote:
> This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.
> 
> This commit breaks stable kernels older than 6.18 that are booted with
> radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1
> 
> In 6.17, threre are further commits that are needed to get the DC
> codepath in amdgpu for Southern Islands GPUs working but they seem to be
> too much of a hastle to backport cleanly. The simplest solution is to
> revert this problematic commit

Ok, this is better, but still, this only applies to 6.12.y, right?

thanks,

greg k-h


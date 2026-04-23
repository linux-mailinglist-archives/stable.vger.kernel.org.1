Return-Path: <stable+bounces-240461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ed/LL0B6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:25:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758E4513FF
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A81309DC78
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1961364959;
	Thu, 23 Apr 2026 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyVdK1ub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D0B340A76;
	Thu, 23 Apr 2026 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943345; cv=none; b=syq2nqf9oEGahHqCxEXCAniCPs+yg2ZBVR9UcKijWvcJZvov4tTHPHSRSRP91//V0RhQwvgIkqv1S1gYpDyIBJ0qw0ZvnlSE8V+ScFgFWC4F+fEGMPSMrezvi1ouFjXOZAzbOTVlgIXDL33qo3IpvRl9drFVkaFHRrbhd7cRWyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943345; c=relaxed/simple;
	bh=v5vX1VJ6hD3zefByaEKuGLyZr08vT7W1KOhrYxlfQpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjCmrRTW+GI6aAcCdctNHG66RuoAeJCBvA0ttjGoMY7ljoJAIoUE+BmXz6omYdNybiuS7xjaS4nP1U/2c/js+ESCfhw3MIkbOfCGNO+hwZaKU7Ec+UBXFrTsK+NQ7ltkefnuKV30HPxiEXyG2N4k+xNqo4Zf2DVJM+O0hVQB/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyVdK1ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC05EC2BCAF;
	Thu, 23 Apr 2026 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776943345;
	bh=v5vX1VJ6hD3zefByaEKuGLyZr08vT7W1KOhrYxlfQpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyVdK1ubOcAXp+YKP2Nghh5b/q+AZL8CUbkno1W4J6qFNzaRqb5Q/cGxj/9xWlcd8
	 7AxDYHjbbuAeZ602YL4l7KQtxwNJV5hiOAXeP+xksDwbqUadzxLW1nwN09P+rAPuXm
	 mH4xhcZbwkWaUlxpVc7/06VwsgosoKeUjjkzTOoo=
Date: Thu, 23 Apr 2026 13:22:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
	stable@vger.kernel.org, Robert Garcia <rob_garcia@163.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Pan Xinhui <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Yifan Zha <Yifan.Zha@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Message-ID: <2026042335-probation-heftiness-7399@gregkh>
References: <20260417074010.1607496-1-rob_garcia@163.com>
 <7260936.9J7NaK4W3v@timur-hyperion>
 <6064b45a-b8de-4848-856f-383d2d06680d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6064b45a-b8de-4848-856f-383d2d06680d@amd.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240461-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,163.com,amd.com,ffwll.ch,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0758E4513FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 04:11:15PM +0200, Christian König wrote:
> Those points are certainly valid.
> 
> I've also up-streamed a patch which completely rejects userspace submissions who try to use the CE.
> 
> The problem is that those BUG_ON() can lead to a deny of service because they crash the whole kernel.
> 
> A BUG_ON() is only justified if it prevents even worse things to happen, e.g. data corruption or it would crash later on anyway just not so obvious on what is wrong.
> 
> Otherwise we should use WARN_ON().

WARN_ON() crashes the kernel as well when panic-on-warn is enabled, as
it is in a few billion Linux systems :(

As this commit is upstream, and in other stable trees, I'll apply this
as it's not nice to have a simple way for userspace to crash the system.

thanks,

greg k-h


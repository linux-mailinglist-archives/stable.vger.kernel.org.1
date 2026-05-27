Return-Path: <stable+bounces-254508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO0eJo2oFmrEoAcAu9opvQ
	(envelope-from <stable+bounces-254508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:17:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F6F5E0F42
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 10:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D4B6305AF16
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A5435E92B;
	Wed, 27 May 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tji0R26u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FF221723
	for <stable@vger.kernel.org>; Wed, 27 May 2026 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869752; cv=none; b=lpaR1dYbo1OTuculo+5EgDsX4fZ5HcdRImvZtwHx3DlVVTaGDPf/5fJdsoKW1yoByX9VpE6AXWdNE/QfdG2K/3hcszYDA9uQVbU2np0znfzHfBAvyzXeU9NGn5K/SjKju3JY08Zw6cId6ktGYdP3vNwAZ5VNjZgoT8vUrXLCPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869752; c=relaxed/simple;
	bh=nn9tR6zTpLnJQgK3BxSmk7REr+1IawK14pIcmtOWbpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJuHhuXG7HlnGURdWuFsk60hlq8sc0+N71/2Co9agsNu0hiIpLxf2YuKKOrYsT+iNjpkS/lMjby2R7GuaqzeQ+BuuQmTenqO/gJa/SoZFs2w0KZIUDHw0Nc13W2N0xBs2sK7CBq/K6jnfbQUKIU+hVoWK5nswUyZU8+2C0vkHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tji0R26u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382961F000E9;
	Wed, 27 May 2026 08:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779869750;
	bh=7qSyKBokGhvIQIc32yYUPKEefbJl+iURHnJWp+lRhl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tji0R26ufGZToTsDiAHR6FF3EeiT6CtDBoOs1SBKsi08WyG0Doji38pGenwTR9ycg
	 kURqREbHuMI54IKil1PXhivRA6+DvbeHVK1Leot9soBYRSz7oZBdA5vMFsNDejc/Sv
	 ke1seKVs8axM0q1MBHaE5rWIipjLbkxpxx+xGzYA=
Date: Wed, 27 May 2026 10:14:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiping Ma <jiping.ma2@windriver.com>
Cc: sashal@kernel.org, michael.bommarito@gmail.com, stable@vger.kernel.org,
	stfrench@microsoft.com
Subject: Re: [PATCH 5.15.y] smb: client: validate the whole DACL before
 rewriting it in cifsacl
Message-ID: <2026052742-earlobe-reactor-47ae@gregkh>
References: <20260425003718.2642374-1-sashal@kernel.org>
 <20260526015822.4076817-1-jiping.ma2@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526015822.4076817-1-jiping.ma2@windriver.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254508-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.965];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 43F6F5E0F42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:58:22AM +0000, Jiping Ma wrote:
> Hi, 
> 
> I can not find this patch in queue-5.15 and queue-6.1 of https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git,
> Do you know what happened to this patch for Linux 5.15 and Linux 6.1?

What is the git id of the commit you are looking for?

thanks,

greg k-h


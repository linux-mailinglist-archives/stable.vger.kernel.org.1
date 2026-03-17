Return-Path: <stable+bounces-226090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F3XCDVtuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:03:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8945C2AC9E5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB44030FE797
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16403E6DC7;
	Tue, 17 Mar 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kx4Ab0+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A433E1D0A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759162; cv=none; b=Xr+am+MnepsPvWiNxb0AvtdnYnOAOR2o3y8FWyMoEZZcFw1BrVICsEP78csTlmlaZDnYz6l19qYxAt+vDf2MuNPSfq8ZxOaRKwM7AA2sIqFV5wBz4AJxiZ6osKm3MTr5/LO5kweEl1fRBdNHJvZ8Kbj8LNqMKFdekb0phUzFs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759162; c=relaxed/simple;
	bh=nRmUAUhg90W/Bh2gvuQ9Vw7WYNE1iqA/N00wuni7oqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFlPndODyRhQxeABi6kEKSl0LGvMQ2QpCuGnS6N9kGx7HRJydgN+ta66mGHrPWjp6RiQ6gJZGv6k/UDB28bl0l/cbQhjTGZtrH/iEOLAXK7WST3P0aCC38KcrPmaldckVitdIkpjhetJOtWrp63fWa8C3/np/+ElwVUlLafC5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kx4Ab0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803F4C4CEF7;
	Tue, 17 Mar 2026 14:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773759162;
	bh=nRmUAUhg90W/Bh2gvuQ9Vw7WYNE1iqA/N00wuni7oqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2kx4Ab0+ASxYNCv07G6xhzwnPkx8l2gj4JBh3JHXmbMfP9LBwFCDICZh2u2vLPSrP
	 08TIQQZKaqMZ3ZHZpuV79iqYQsgzc52iz77YPWmS5HdMP5hfHSoaVOvxISE2IuEiDW
	 PK4uKeUvwSisEITiwek40IuNNXL/4a8nIrCdeMoE=
Date: Tue, 17 Mar 2026 15:52:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/xe: allow request_irq on GSC interrupt
Message-ID: <2026031723-ridden-prevent-f005@gregkh>
References: <20260317134741.3420-1-Simon.Richter@hogyros.de>
 <20260317134741.3420-2-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317134741.3420-2-Simon.Richter@hogyros.de>
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
	TAGGED_FROM(0.00)[bounces-226090-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 8945C2AC9E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:47:17PM +0900, Simon Richter wrote:
> The default flags for freshly allocated interrupts are platform dependent,
> and apparently powerpc and arm set IRQ_NOREQUEST by default.
> 
> The normal path is to clear this flag from irq_domain_associate_locked(),
> which wraps the irq domain's "map" function, but the xe driver does not
> define an irq domain and instead allocates the irq descriptor directly, so
> the flags need to be set up manually as well.
> 
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6468
> Fixes: 87a4c85d3a3ed579c86fd2612715ccb94c4001ff

Didn't checkpatch complain about this?  Please use the documented format
for this.

thanks,

greg k-h


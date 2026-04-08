Return-Path: <stable+bounces-233811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ3IOvQF1mnbAQgAu9opvQ
	(envelope-from <stable+bounces-233811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C63B8695
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CD673038782
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270DA382375;
	Wed,  8 Apr 2026 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4bPo0lw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22938236A;
	Wed,  8 Apr 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633642; cv=none; b=tA0xDuKew+Cki2i9lA493Hqa8wnAdSZVBCjdQhGemmAJ07nQQochjliQP6fDf6qMR9/ArrkRxlwFaYk1i5478trcWDekehubAfY4H4Zn93F8+KRaOaDiivkeSdBxKeb3Wv5VrmflPWRIivWB0e3p8zcuG6tKMYa9T5RRJqdb2u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633642; c=relaxed/simple;
	bh=Shv2ZRsbtiCbvwYvbjPxGTs2BTFskGyrLs7Tu0GzFl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqYsoOOJAJrfdodq9a4dXKh2GJ4FRypDGrdZ6+vhf5y1SlRBrQI3EWgULibhtL3L/XPhiWAbAv0/tcKzCdV07sXpto/ql2s0GjHvgZCWlzPrYYEhTds/4IVyHXHfG30QfEM53o1LW9hCMtFRlDLvxCgE5ixjZTEYjPJpUIgL9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4bPo0lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA1CC2BCB0;
	Wed,  8 Apr 2026 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775633642;
	bh=Shv2ZRsbtiCbvwYvbjPxGTs2BTFskGyrLs7Tu0GzFl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4bPo0lwtp7qZ05/+tHhrfjLwUf4Zh8RtDKl1XHJgv/55tNdxoxRIt+3azELtbKV4
	 /ztUcPtI/BbhF2FjjmtyHV2VR9sEnaiIT8jH7qZUxuo93Z9lk7RiTdBxtjH+jnVr5W
	 Pb4GZCvvu7ao20Yhts8ZK1wgmbRcT2wf2Pazp+x5YlnxdUxLXy33dt1/nPUr2RR1Ry
	 Rv5neZeiAPoeQsxSRFOQiC+kwVjIXUpFYw5Lgs/cSjrKMzbrF0KzTkjk6jViJX/dzW
	 3xP3pxD0qFW4KySMbK0YoGUc0q4GsVNTm9+KVizVxTCccNxhkfiDQQspQf+PPXaqbM
	 GOKkIUllbqYZQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wANQG-000000001Ol-1FIu;
	Wed, 08 Apr 2026 09:34:00 +0200
Date: Wed, 8 Apr 2026 09:34:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 2/2] regulator: rk808: fix OF node reference imbalance
Message-ID: <adYE6DsX1xQWmlvd@hovoldconsulting.com>
References: <20260407094156.2573027-1-johan@kernel.org>
 <20260407094156.2573027-3-johan@kernel.org>
 <CAD=FV=WevFKZs5fgvs-ESNaXsZgGnnREuSQv3eDx+SCz_FibXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WevFKZs5fgvs-ESNaXsZgGnnREuSQv3eDx+SCz_FibXw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233811-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,collabora.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hovoldconsulting.com:mid]
X-Rspamd-Queue-Id: 6C2C63B8695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 05:57:06PM -0700, Doug Anderson wrote:

> On Tue, Apr 7, 2026 at 2:42 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > The driver reuses the OF node of the parent multi-function device but
> > fails to take another reference to balance the one dropped by the
> > platform bus code when unbinding the MFD and deregistering the child
> > devices.
> >
> > Fix this by using the intended helper for reusing OF nodes.
> >
> > Fixes: 5111c931f36c ("regulator: rk808: cleanup parent device usage")
> 
> I don't think this is quite the right "Fixes". Even before that
> commit, the driver copied the parent's "of_node" and still set
> "of_node_reused".
> 
> The first place I see the parent's "of_node" being copied is actually
> commit 647e57351f8e ("regulator: rk808: reduce 'struct rk808' usage").
> "of_node_reused" is first set in commit 1b9e86d445a0 ("regulator:
> rk808: fix asynchronous probing"), but really that should have been
> set in the beginning anyway...

Indeed, thanks for catching that. I've just sent a v2 of the series with
the correct tag and that includes all of the regulator fixes that
unfortunately ended up being being spread over three series.

Johan


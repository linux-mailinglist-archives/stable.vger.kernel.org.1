Return-Path: <stable+bounces-223655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIlZHOnNrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:40:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFD239E38
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF59303C2AC
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2ED3A6EFA;
	Mon,  9 Mar 2026 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0RaWA3v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E83CA481;
	Mon,  9 Mar 2026 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063651; cv=none; b=HICEdEDCyCEDBtUxsFdQi2MGRFgbUumkXlevqN8f8hznFewMjC7RLiIKlNcIGqTjEDOGzwAd++Tq53x8BiuwvZcSzNMgKFXZ5TGiiNNY72dgqq5073NT+aHdLFHqHzeSiySllb7GbQJ/tCv4NI92G4TM/DLwaXqj41tjPTkpFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063651; c=relaxed/simple;
	bh=DEvgbGCL4PkGwzJjCa2z65DKqAYCR5PEAbdXQdxG6TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdntPygWoZ+SGGUi2j4gMu3YJuwSHj00j2rJvjOb4wjR2q2o2M39A4vtd9vfA0YGr5F+/Dgsxw3yv/CpKqrDOKh2EOiIhSHJXr0bHRCVCMcurdqObBgvN7grVMBA3FZNM8iqINX5V2MDlvgwDse9+uCrmhjAJcTliBWcsIkCEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0RaWA3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34A9C4CEF7;
	Mon,  9 Mar 2026 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773063650;
	bh=DEvgbGCL4PkGwzJjCa2z65DKqAYCR5PEAbdXQdxG6TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0RaWA3vk52H+GhCy96jycbNKVBuTF+dv36uPhfHp+ybzkxPFy5Cy/UvJGZbsMRAB
	 nc8YnRnBO0Z302S+EalO2R/uXOqxEn5vP1BSqblnSjGxlQelZ4wP3asQzl+JU6pvK7
	 HqP+mXoIcaifDl83lRw43TIQasJCpEHNQRo5uuEQ=
Date: Mon, 9 Mar 2026 14:40:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ian Rogers <irogers@google.com>,
	Leo Yan <leo.yan@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 6.19 027/844] perf metricgroup: Don't early exit if no
 CPUID table exists
Message-ID: <2026030924-recount-halved-605d@gregkh>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <20260228173244.1509663-28-sashal@kernel.org>
 <072e2a07-5c6f-47b5-9695-0a3ffe854ac8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072e2a07-5c6f-47b5-9695-0a3ffe854ac8@kernel.org>
X-Rspamd-Queue-Id: C8AFD239E38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223655-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.307];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 08:40:33AM +0100, Jiri Slaby wrote:
> On 28. 02. 26, 18:19, Sasha Levin wrote:
> > From: Ian Rogers <irogers@google.com>
> > 
> > [ Upstream commit cee275edcdb1acfdc8270f80e96f30750b633220 ]
> 
> This breaks (userspace) perf:
> $ ./perf stat -a -d -p 1 sleep 5
> PID/TID switch overriding SYSTEM
> Error:
> No supported events found.
> 
> Any ideas?

Is it also broken in 7.0-rc3?  Or is this only a 6.19.y issue?

thanks,

greg k-h


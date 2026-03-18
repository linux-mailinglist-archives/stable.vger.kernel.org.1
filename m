Return-Path: <stable+bounces-227043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBosNluUumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:02:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A72BB30E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDE48301025C
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25C3D4109;
	Wed, 18 Mar 2026 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WwfgOmrH"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C103D3D1B
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835350; cv=none; b=k0taskRIzIVcqC1FGXDqglF577uxavFILJtbyijovdymUt+VdOVYIYw7cmaQ9Y6T8F1gOjry7CZRdwC+fJ9zG4effsAHSkT7dug/dVSGBSCCLP5mgFGxQDWxrqvPJb8pIQSWn1ehw+h+Evn9iRSAVMaH//ipcGALazIfkr+ZBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835350; c=relaxed/simple;
	bh=/KmwFDu2H05RituJsoykGt5TR0YsHHBUyFfb08GsZG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwrvj+6DBKhZnjhJV5FAlNTrseOw8odL9tjbWdTm7kubyGuWuEo9aQLvgC6rzrDXhE9CS+C6PpdRB7bNFIc7s1byfx88pbO4ZJM7fUXhOpyKlL0e7HcLt+qWB0KAFDHLRgxkmL1iVFEkXXQjDaydeHXvbZTF/RYQsf2GLt7I5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WwfgOmrH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Mar 2026 13:02:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773835337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDT73PkaI+k9g4g6KPnGOkbBTIXzJuviiQFdZkqtj9c=;
	b=WwfgOmrHgChjrd8f1Mrhhxtkit/IADciszd4lMQyyB+NxRpwtH65l5PA49V4EYvBXMLJVL
	pLfhYSBzuDIuJYsXLFkxNLdo9qwQqIH1vN5eSrAnf83H2cnQ9R4gxxenWQ1XZu/vlTi+V6
	JmmdMw4nwbKdtUrGOGXdF/fEOjwpgl4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kim Phillips <kim.phillips@freescale.com>,
	Yuan Kang <Yuan.Kang@freescale.com>, stable@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: caam - remove HMAC key hex dumps from
 hash_digest_key
Message-ID: <abqUQxdoH7zuszZQ@linux.dev>
References: <20260306111204.302544-1-thorsten.blum@linux.dev>
 <abTqefme_iApfHZi@gondor.apana.org.au>
 <abk4_r-KUYIhvyNL@linux.dev>
 <abpYWkDzofozlOWp@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abpYWkDzofozlOWp@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-227043-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EA3A72BB30E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:46:34PM +0900, Herbert Xu wrote:
> On Tue, Mar 17, 2026 at 12:20:30PM +0100, Thorsten Blum wrote:
> >
> > This is not specifically about caam, but (debug) logging of potentially
> > sensitive key material should generally be avoided, imho. Some other
> > recent examples:
> > 
> > https://lore.kernel.org/lkml/20260227230008.858641-2-thorsten.blum@linux.dev/
> > https://lore.kernel.org/lkml/20260303132552.65235-2-thorsten.blum@linux.dev/
> > https://lore.kernel.org/lkml/20260303190350.78705-2-thorsten.blum@linux.dev/
> > 
> > > Is there a scenario where production systems will run with debugging
> > > enabled in caam?
> > 
> > I don't know - possibly.
> 
> I think a better solution is to turn these sensitive printk's to
> pr_devel.  That way you can still get them by recompiling the kernel
> but they won't be enabled in any distro kernels.
> 
> What do you think?

Sounds reasonable. However, the code is already using the debug-gated
print_hex_dump_debug(), which can also be enabled at runtime with
CONFIG_DYNAMIC_DEBUG.

So I think the question is not necessarily print_hex_dump_debug() vs.
pr_devel(), but whether we want to:

- keep the debug-only hex dumps
- remove the sensitive dumps

My main concern is that with CONFIG_DYNAMIC_DEBUG enabled, which doesn't
require DEBUG, these raw key dumps can still be turned on at runtime in
a deployed kernel.

If we want to keep the dumps for debug-only kernels, then #ifdef DEBUG
plus print_hex_dump() might be a good compromise.


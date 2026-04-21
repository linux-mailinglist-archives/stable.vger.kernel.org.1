Return-Path: <stable+bounces-240169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO2bNFt852nC9QEAu9opvQ
	(envelope-from <stable+bounces-240169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:32:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCA643B62A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 212203012BF1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F743AE187;
	Tue, 21 Apr 2026 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="APcEg1uM"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E42D7D2E;
	Tue, 21 Apr 2026 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778292; cv=none; b=PAacBZHki37kdH0HMRzCX6iXXvbO6r5NCcVJ6LgcMvbvmqnISqiBeWhyXGvjEmaIeMhOlj6j/q0zeU5JFmKjDp8w/ueRsQv5jVYoG1oymafR2wHHegoCGbvRWh9lliQIriP5s61or+Dg/WGbBs4wnxQ/IuiRN+GK5tre9GY2Tk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778292; c=relaxed/simple;
	bh=a+BUb8fVIWcAQqaiskLh2PB8Q4VFzTKQ7wnj0tpS/Gc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JATbNXc9nTKM84uh63mED6uHup47MU+0XjVRWDUArE0Rx1ED+jT4EQSFbLJbFv4OgsmG7hwgndt55P+fQ86V5cYxVfdsJAjzqCZKA3AYK9cbLR2AgXt/zXFj7YsjUQS14b3FkQH/nrLkzq7yvx5Xz3s+ouPRNdaFdl/02CFAXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=APcEg1uM; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 712CC2084C;
	Tue, 21 Apr 2026 15:31:28 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TnZPMGMUYyOI; Tue, 21 Apr 2026 15:31:27 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CD354207B0;
	Tue, 21 Apr 2026 15:31:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CD354207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1776778287;
	bh=SzUsgva2gX0qJtwHIjRgps/L5eTyanVUyNq+0uz330A=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=APcEg1uMLaMaAV5GC8oN9Hqvteh9lGCJnF0daTaxjZr+04KEma+nLR6FPAhwRxRZ0
	 bJPV/6wn48GBVbbd+CC5pVG+IxIxesXskwK7UuRhY+ikS9b5tzJ65kHgMP8YeElzho
	 H77TznabNvibYpxsEdWOC+OYVrNqymj3qdXj5yDburg/x5Ts7fwr2GTH4y5hU/WtpL
	 CQF5Zzecq0sXX5PKNuiIJw9zF54npOG+HmyN7F34h3WoFB20B4sZzYTKkJcsCJEWcg
	 8lNjub1JjtVYGRrAdJ76GeQQEi+ex8XEbh157YCahaXiZgYgiXW2EfjauRH1Sr7FLR
	 BbaaGR77erH3g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 15:31:27 +0200
Received: (nullmailer pid 3293655 invoked by uid 1000);
	Tue, 21 Apr 2026 13:31:26 -0000
Date: Tue, 21 Apr 2026 15:31:26 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>, "David
 S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Fan Du
	<fan.du@windriver.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] xfrm: ah: account for ESN high bits in async callbacks
Message-ID: <aed8Lsf0DSAPX1E9@secunet.com>
References: <20260419223542.2293727-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260419223542.2293727-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240169-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5DCA643B62A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 06:35:42PM -0400, Michael Bommarito wrote:
> AH allocates its temporary auth/ICV layout differently when ESN is enabled:
> the async ahash setup appends a 4-byte seqhi slot before the ICV or
> auth_data area, but the async completion callbacks still reconstruct the
> temporary layout as if seqhi were absent.
> 
> With an async AH implementation selected, that makes AH copy or compare
> the wrong bytes on both the IPv4 and IPv6 paths. In UML repro on IPv4 AH
> with ESN and forced async hmac(sha1), ping fails with 100% packet loss,
> and the callback logs show the pre-fix drift:
> 
>   ah4 output_done: esn=1 err=0 icv_off=20 expected_off=24
>   ah4 input_done: esn=1 auth_off=20 expected_auth_off=24 icv_off=32 expected_icv_off=36
> 
> Reconstruct the callback-side layout the same way the setup path built it
> by skipping the ESN seqhi slot before locating the saved auth_data or ICV.
> Per RFC 4302, the ESN high-order 32 bits participate in the AH ICV
> computation, so the async callbacks must account for the seqhi slot.
> 
> Post-fix, the same IPv4 AH+ESN+forced-async-hmac(sha1) UML repro shows
> the corrected offset (ah4 output_done: esn=1 err=0 icv_off=24
> expected_off=24) and ping succeeds; net/ipv4/ah4.o and net/ipv6/ah6.o
> build clean at W=1. IPv6 AH+ESN was not exercised at runtime, and the
> change has not been tested against a real async hardware AH engine.
> 
> Fixes: d4d573d0334d ("{IPv4,xfrm} Add ESN support for AH egress part")
> Fixes: d8b2a8600b0e ("{IPv4,xfrm} Add ESN support for AH ingress part")
> Fixes: 26dd70c3fad3 ("{IPv6,xfrm} Add ESN support for AH egress part")
> Fixes: 8d6da6f32557 ("{IPv6,xfrm} Add ESN support for AH ingress part")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-4
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Applied to the ipsec tree, thanks a lot Michael!


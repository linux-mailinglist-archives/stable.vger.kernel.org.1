Return-Path: <stable+bounces-231351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJzwGad+y2mLIQYAu9opvQ
	(envelope-from <stable+bounces-231351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:58:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7026F3659DD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E99AE301CC59
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA973C6616;
	Tue, 31 Mar 2026 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GZhiqpQ0"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188523BADB6;
	Tue, 31 Mar 2026 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943262; cv=none; b=pDUSqzL+8peHJaF3vdzVS4f/WxbERpYKeRhm9eMp7qCIZHehQIQV4jI1C1XGb8gdpWGcErAcS7CXL7tyCpLUCH0hxRP7lqFeqH1C4p8ZT6Sc+hQYb3BxJmOi5Snt0qA7+geAaKjbGs0p5p5Cnxz/xITkXrPnLZYu7MkK0IhYtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943262; c=relaxed/simple;
	bh=dtCYFvcV4p+RrOykNQs3acKSTWuiv3ME9H5grBcmQdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nysMpga8asHXx7bMakAqz2PO2knrgB1Idiy+Cse+hXWgw1cgqYj2OYR+O4lJi/t76GBJnPDks/efoasvy7GUUUXB9TxueT/J0ff5rjGIiiDswcJ8Opx6JBNpqueoL3fvpZYxHSVYlEcZViDQvgBEtiA+9ZSQJGEhgGrZa8DforI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GZhiqpQ0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1860B2064C;
	Tue, 31 Mar 2026 09:47:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mka7IKXXR7yI; Tue, 31 Mar 2026 09:47:37 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8ACE8201E4;
	Tue, 31 Mar 2026 09:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8ACE8201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774943257;
	bh=t/vBidxTMjWj/FH0VIFpCszyXZqou4cS8tHqwNT11wk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=GZhiqpQ0S0omOfaoWiJr6B8XL5Ucp+70GFrEHwjO6ZLmy/i+E+hEyRkFIf/d8bSa4
	 CN9gRPuMFYmefPPTGpeQeIDdC20FqmawUqGxNXFUDfA2Oq2lW1h/KrNC8GGTAKGUa+
	 asuk3sRhoQVl+Wt3g+KLaAMu7pZAyWNSy+/txiTqwQ95tJiL29NCCFsk8zOxcKqQmx
	 s3jVWDcDeLBDdGgjIBqPQJYdhU3CHQ1A+DLwG+Yng3sQtLltqtORzGZ1nNeU9fEZxF
	 s9YFgMe2h52Evu+/UFmD5lGS9kZ13nYViQCZRPbtJL+/oIIpNCvPDLsbHYCwI/e/Od
	 T6d025sy1UEdA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 09:47:36 +0200
Received: (nullmailer pid 1484844 invoked by uid 1000);
	Tue, 31 Mar 2026 07:47:35 -0000
Date: Tue, 31 Mar 2026 09:47:35 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] xfrm: clear trailing padding in build_polexpire()
Message-ID: <act8F0uSYWmI7fAN@secunet.com>
References: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326055801.897013-1-yasuakitorimaru@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231351-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7026F3659DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 02:58:00PM +0900, Yasuaki Torimaru wrote:
> build_expire() clears the trailing padding bytes of struct
> xfrm_user_expire after setting the hard field via memset_after(),
> but the analogous function build_polexpire() does not do this for
> struct xfrm_user_polexpire.
> 
> The padding bytes after the __u8 hard field are left
> uninitialized from the heap allocation, and are then sent to
> userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
> leaking kernel heap memory contents.
> 
> Add the missing memset_after() call, matching build_expire().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>

Applied to the ipsec tree, thanks Yasuaki!


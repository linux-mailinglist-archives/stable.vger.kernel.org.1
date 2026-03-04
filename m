Return-Path: <stable+bounces-223025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP1PJMIDqGkRnQAAu9opvQ
	(envelope-from <stable+bounces-223025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 11:04:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19141FE10A
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 11:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91BE1300B461
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9BB388E40;
	Wed,  4 Mar 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hWuiHGtJ"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59037418E;
	Wed,  4 Mar 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618681; cv=none; b=CjaXsa36D37ZpYaHcQFfBhTjC3UsBZaoiUv4kTp5i6yfENfGJyqL2DNKI+iqF4E/GzVlNQqImDnv4eExlmYa3rTOl1oYmQx0fS6qoU/OpdKLUkiFZrBu2CCuy0ST0yxRJlZJnJFOaG11YjeM77x5wHx/r2AQL5Rk87eSVD+DvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618681; c=relaxed/simple;
	bh=wHcmX6BE0UYWWOe1cOuAK7ExFxBka4zV9Z+uBytDbPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtLqnyFV3Geq9vmZydKNWNnkZcOV5AP9wnD2gfO2IFo3oJIGVoYT+ihs7RwzQvvCzI9T8zVVTg0l3fCNDcc1PtXDQNjTkkqbm6pAaef2BMJtjuJPDq46YHoYXrggIcRHOaNPaAJexcpmXAsPBBlgo3V1RMa3YNFwcm7fhX8ch3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hWuiHGtJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4001A2074F;
	Wed,  4 Mar 2026 11:04:30 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gDEuzFDP0NKs; Wed,  4 Mar 2026 11:04:29 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8B962201E5;
	Wed,  4 Mar 2026 11:04:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8B962201E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1772618668;
	bh=pAKisek2J3NbCl+1vaYd4dZP7ej7ACSPZwDJaBJo/oo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=hWuiHGtJ2GSdfzZYpa7gxZ65aEeupKV+ZHM3j1IOrHuPHaVYWAImrzvpyeoGMIX75
	 54oQ+Ff1E9o/T/Ek2vwdEC32H9EEURhYEea28PTFr8OhKecwsB78Fc/TYtx5HAK+Ds
	 AgPzEtWxBnuhB82eczCCqjoFLaSftgTJrU3/PgXz2F82PvBJ+or4JCiJS6oyn88j1S
	 3rnqs0fl7jQo5BBomhEN4lKAtVAtx0yseusfP3Sxv0qPYJNog3ZOzwRj5pbYeUVnpl
	 ANe1vDoIsIVv3K//bahu3TGfmg/zigyuQANxeL0bx2/ZnxANOkostSuXSqeGuWQQ2A
	 UGKwpw0Ywe8Eg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 11:04:27 +0100
Received: (nullmailer pid 1179012 invoked by uid 1000);
	Wed, 04 Mar 2026 10:04:27 -0000
Date: Wed, 4 Mar 2026 11:04:27 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Roshan Kumar <roshaen09@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <chopps@labn.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] xfrm: iptfs: validate inner IPv4 header length in IPTFS
 payload
Message-ID: <aagDqygQrWHBLoKV@secunet.com>
References: <20260301105638.11479-1-roshaen09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260301105638.11479-1-roshaen09@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: E19141FE10A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223025-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 10:56:38AM +0000, Roshan Kumar wrote:
> Add validation of the inner IPv4 packet tot_len and ihl fields parsed
> from decrypted IPTFS payloads in __input_process_payload(). A crafted
> ESP packet containing an inner IPv4 header with tot_len=0 causes an
> infinite loop: iplen=0 leads to capturelen=min(0, remaining)=0, so the
> data offset never advances and the while(data < tail) loop never
> terminates, spinning forever in softirq context.
> 
> Reject inner IPv4 packets where tot_len < ihl*4 or ihl*4 < sizeof(struct
> iphdr), which catches both the tot_len=0 case and malformed ihl values.
> The normal IP stack performs this validation in ip_rcv_core(), but IPTFS
> extracts and processes inner packets before they reach that layer.
> 
> Reported-by: Roshan Kumar <roshaen09@gmail.com>
> Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Roshan Kumar <roshaen09@gmail.com>

Applied to the ipsec tree, thanks a lot!


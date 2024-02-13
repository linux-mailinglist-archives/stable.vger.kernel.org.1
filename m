Return-Path: <stable+bounces-19757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6085354F
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3865B283289
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D785F55B;
	Tue, 13 Feb 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="w1cpRTHe"
X-Original-To: stable@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3075F491
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839636; cv=none; b=dcjTeZAVVxck7jl1no28/utMRB/3VPCMem1HGSPlu7dn1pIqgQZEFCfpA/H42IWXGSDnCEyyZraNMdg/dcZ5+42dBP9fP1Rd65kc8tzjiBiP9AoKjEAQkb0v8qbpLRO8mCmBueADzoaDUwEYH1/UoM9qjWyZBvleJAnXahbfBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839636; c=relaxed/simple;
	bh=QY5lwIMryO9BJKejFN0JPJx2xZ4RjrZmxzbK8quuMsc=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:Cc:
	 In-Reply-To:Content-Type; b=iuAvhpZJ2tkfQVKtfabkSF2yS2pmD4Fi7nOEmh++mjHS+V0Nc1p/MyWQ2lNScIGematFH6L8nY2dmyldaCdIJ0ebIq1USnpQnYfumeIncrJm4bS9IK/dBvurBzh48EglnVdzbpPcawhrHV0KlOIx4JPxXOX9qk+edxzwGRkRAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=w1cpRTHe; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1707839626; x=1708444426;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:Subject:References:Content-Language:To:
	From:Organization:Cc:In-Reply-To:Content-Type:
	Content-Transfer-Encoding; bh=xMppLddvFZEkO+R2Nw0MCdHD9WgBbz7xik
	lQPhQri+I=; b=w1cpRTHerTQn/7MZUhpz2+kkojKY/BumKrWa/x1alvHfgpyA4t
	QHuYOpM9U9I0YIdtQsIOlG3jrZaZDCvI7ReFqvUAeRD33WZ0xzQtevzEjpflyrLk
	FHP2krWVsoCtjbCEAg/97SpTVcwxDGU8K7igQjsmg0sWLqNsYQMpedwFU=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Tue, 13 Feb 2024 10:53:46 -0500
Received: from [IPV6:2603:7000:73c:bb00:ad13:1ab2:8f50:ac1d] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v23.5.2) 
	with ESMTPSA id md5001003801659.msg; Tue, 13 Feb 2024 10:53:46 -0500
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Tue, 13 Feb 2024 10:53:46 -0500
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:ad13:1ab2:8f50:ac1d
X-MDHelo: [IPV6:2603:7000:73c:bb00:ad13:1ab2:8f50:ac1d]
X-MDArrival-Date: Tue, 13 Feb 2024 10:53:46 -0500
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1773cf9644=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <33391482-8c4d-4c27-8be7-f2d014c3ca9a@auristor.com>
Date: Tue, 13 Feb 2024 10:53:44 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Backport request: commit fe92f874f091 ("net: Fix from address in
 memcpy_to_iter_csum()")
References: <20240131155220.82641-1-bevan@bi-co.net>
Content-Language: en-US
To: stable@vger.kernel.org
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Cc: Michael Lass <bevan@bi-co.net>
In-Reply-To: <20240131155220.82641-1-bevan@bi-co.net>
X-Forwarded-Message-Id: <20240131155220.82641-1-bevan@bi-co.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDCFSigsAdded: auristor.com

Please backport to stable 6.7 the following patch which was merged 
upstream as

commit fe92f874f09145a6951deacaa4961390238bbe0d
Author: Michael Lass <bevan@bi-co.net>
Date:   Wed Jan 31 16:52:20 2024 +0100

     net: Fix from address in memcpy_to_iter_csum()

     While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
     address passed to csum_partial_copy_nocheck() was accidentally changed.
     This causes a regression in applications using UDP, as for example
     OpenAFS, causing loss of datagrams.

     Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
     Cc: David Howells <dhowells@redhat.com>
     Cc: stable@vger.kernel.org
     Cc: regressions@lists.linux.dev
     Signed-off-by: Michael Lass <bevan@bi-co.net>
     Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
     Acked-by: David Howells <dhowells@redhat.com>
     Signed-off-by: David S. Miller <davem@davemloft.net>


Thank you.

-------- Forwarded Message --------
Subject: 	[PATCH] net: Fix from address in memcpy_to_iter_csum()
Date: 	Wed, 31 Jan 2024 16:52:20 +0100
From: 	Michael Lass <bevan@bi-co.net>
To: 	netdev@vger.kernel.org
CC: 	David Howells <dhowells@redhat.com>, regressions@lists.linux.dev



While inlining csum_and_memcpy() into memcpy_to_iter_csum(), the from
address passed to csum_partial_copy_nocheck() was accidentally changed.
This causes a regression in applications using UDP, as for example
OpenAFS, causing loss of datagrams.

Fixes: dc32bff195b4 ("iov_iter, net: Fold in csum_and_memcpy()")
Cc: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Signed-off-by: Michael Lass <bevan@bi-co.net>
---
net/core/datagram.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 103d46fa0eeb..a8b625abe242 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -751,7 +751,7 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t 
progress,
size_t len, void *from, void *priv2)
{
__wsum *csum = priv2;
- __wsum next = csum_partial_copy_nocheck(from, iter_to, len);
+ __wsum next = csum_partial_copy_nocheck(from + progress, iter_to, len);
*csum = csum_block_add(*csum, next, progress);
return 0;

-- 
2.43.0





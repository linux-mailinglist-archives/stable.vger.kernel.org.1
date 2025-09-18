Return-Path: <stable+bounces-170710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3776FB2A644
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CD11B65617
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF332277A;
	Mon, 18 Aug 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iufSE74m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB5322DCE;
	Mon, 18 Aug 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523524; cv=none; b=Jg94swR0z7EJIo+oHP9l34Z4f0aBYbVn7lxKAXSLaUgg7+0wAJD09RbXWQrxkKhebbChWfgktbC6gPjaT6mIWxehbVg+MriXe5YDXnw53Nvc+xezkGWya1KB33uKC2QxjcdGGNEJnt6rgX13ovewKTUAr5SlCPwwFxnRE0OXUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523524; c=relaxed/simple;
	bh=BYaRKlcUHE0SC8OsZU0ZdC6KHgJOB+tGcFLExpcCGqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwCSY96yZcvRYTW/8rRSlWFT+8Qo23duC18Uk6+Umf1sERq2vOx+9ZNeeU4SzgXpVFrbM5XM+8AQ4lzyUXjzSckhmDRXAjFeefXvT/6hFYWLmjeMyWn9th0NQgLKr/QKMqAtvLnQ18ACbsueGI+W+waddBVlSZvjseEwulvxOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iufSE74m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29E1C4CEEB;
	Mon, 18 Aug 2025 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755523524;
	bh=BYaRKlcUHE0SC8OsZU0ZdC6KHgJOB+tGcFLExpcCGqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iufSE74mwhK9Mzj9rItoE4jVuhcXTgx4cJMGqjgKoYBd5+igc3gx49G0OC3vbQ87k
	 K6sPU3qag5xJi/xZCUNj4w2zc8DyCjv4ThILlUJBgDA7MN2vRbaZ1uLaEzsOAyHRll
	 oa99bP3SB8Bq9GSCshmhQYBqd+rllvPa3pxS1jno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthoine Bourgeois <anthoine.bourgeois@vates.tech>,
	Juergen Gross <jgross@suse.com>,
	Elliott Mitchell <ehem+xen@m5p.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 198/515] xen/netfront: Fix TX response spurious interrupts
Date: Mon, 18 Aug 2025 14:43:04 +0200
Message-ID: <20250818124505.991460691@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthoine Bourgeois <anthoine.bourgeois@vates.tech>

[ Upstream commit 114a2de6fa86d99ed9546cc9113a3cad58beef79 ]

We found at Vates that there are lot of spurious interrupts when
benchmarking the xen-net PV driver frontend. This issue appeared with a
patch that addresses security issue XSA-391 (b27d47950e48 "xen/netfront:
harden netfront against event channel storms"). On an iperf benchmark,
spurious interrupts can represent up to 50% of the interrupts.

Spurious interrupts are interrupts that are rised for nothing, there is
no work to do. This appends because the function that handles the
interrupts ("xennet_tx_buf_gc") is also called at the end of the request
path to garbage collect the responses received during the transmission
load.

The request path is doing the work that the interrupt handler should
have done otherwise. This is particurary true when there is more than
one vcpu and get worse linearly with the number of vcpu/queue.

Moreover, this problem is amplifyed by the penalty imposed by a spurious
interrupt. When an interrupt is found spurious the interrupt chip will
delay the EOI to slowdown the backend. This delay will allow more
responses to be handled by the request path and then there will be more
chance the next interrupt will not find any work to do, creating a new
spurious interrupt.

This causes performance issue. The solution here is to remove the calls
from the request path and let the interrupt handler do the processing of
the responses. This approch removes most of the spurious interrupts
(<0.05%) and also has the benefit of freeing up cycles in the request
path, allowing it to process more work, which improves performance
compared to masking the spurious interrupt one way or another.

This optimization changes a part of the code that is present since the
net frontend driver was upstreamed. There is no similar pattern in the
other xen PV drivers. Since the first commit of xen-netfront is a blob
that doesn't explain all the design choices I can only guess why this
specific mecanism was here. This could have been introduce to compensate
a slow backend at the time (maybe the backend was fixed or optimize
later) or a small queue. In 18 years, both frontend and backend gain lot
of features and optimizations that could have obsolete the feature of
reaping completions from the TX path.

Some vif throughput performance figures from a 8 vCPUs, 4GB of RAM HVM
guest(s):

Without this patch on the :
vm -> dom0: 4.5Gb/s
vm -> vm:   7.0Gb/s

Without XSA-391 patch (revert of b27d47950e48):
vm -> dom0: 8.3Gb/s
vm -> vm:   8.7Gb/s

With XSA-391 and this patch:
vm -> dom0: 11.5Gb/s
vm -> vm:   12.6Gb/s

v2:
- add revewed and tested by tags
- resend with the maintainers in the recipients list

v3:
- remove Fixes tag but keep the commit ref in the explanation
- add a paragraph on why this code was here

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@vates.tech>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Elliott Mitchell <ehem+xen@m5p.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250721093316.23560-1-anthoine.bourgeois@vates.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/xen-netfront.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 5091e1fa4a0d..186d8ec1eaa6 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -637,8 +637,6 @@ static int xennet_xdp_xmit_one(struct net_device *dev,
 	tx_stats->packets++;
 	u64_stats_update_end(&tx_stats->syncp);
 
-	xennet_tx_buf_gc(queue);
-
 	return 0;
 }
 
@@ -848,9 +846,6 @@ static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev
 	tx_stats->packets++;
 	u64_stats_update_end(&tx_stats->syncp);
 
-	/* Note: It is not safe to access skb after xennet_tx_buf_gc()! */
-	xennet_tx_buf_gc(queue);
-
 	if (!netfront_tx_slot_available(queue))
 		netif_tx_stop_queue(netdev_get_tx_queue(dev, queue->id));
 
-- 
2.39.5





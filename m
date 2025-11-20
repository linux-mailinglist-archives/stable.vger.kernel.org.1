Return-Path: <stable+bounces-195314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B0C754C0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0A0F355EC8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4219363C7F;
	Thu, 20 Nov 2025 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PTKZIhEr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C2363C64
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763655068; cv=none; b=nRyzHJBQmHyz/vrMEk9d8bw+nL5ZHigfOkVMglhtStwUiNBcPwNovSYq581niPny9qF7L5Wr4xYJRbVufJebckpF9m7QMa7FaXph0rbXXOpTNvNV1X5O5CuK4UFrqxFyqFsEK6gWSldjB5QHsJpNlffmZnce1GzdWiMYxl4/a38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763655068; c=relaxed/simple;
	bh=VwoD2uVkin2W8FSSEwGGTSQRN6MVAnwo26RxoYYFCSg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d70duo7Fqsdw9eJIUEBW2tqLwiRu2zG5GyxsbudYt6E77ll9eTHhohlHdp/DF523DdkOyZaJ/HEqd1Or8eLjwPhxhvRuEe5cLSBSlWs0+eG2YId3alD9uqDhu3JewkunZfdShrbN71Ijinbzl73Z2aQyeWjwnH6L1zJejeMGT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PTKZIhEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB670C4CEF1;
	Thu, 20 Nov 2025 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763655068;
	bh=VwoD2uVkin2W8FSSEwGGTSQRN6MVAnwo26RxoYYFCSg=;
	h=Subject:To:Cc:From:Date:From;
	b=PTKZIhErHHKnl769gyKXIGi8hn2fZ+likGtnvPXOwtPgBzItoT6l4j+TPMjKVQFb3
	 rLt99JpQSwkyK2oBv/0zwY+GadwUbEDrE+sXGvVYYHqB/4okF+35+cGSICuG0EUfC8
	 /qKtnPmwsnQIXkjW8EW7rjC8nux3x3AL5z9DPKm0=
Subject: FAILED: patch "[PATCH] net: netpoll: fix incorrect refcount handling causing" failed to apply to 6.12-stable tree
To: leitao@debian.org,horms@kernel.org,jv@jvosburgh.net,kuba@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:11:05 +0100
Message-ID: <2025112005-polio-gratify-8d3b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 49c8d2c1f94cc2f4d1a108530d7ba52614b874c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112005-polio-gratify-8d3b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49c8d2c1f94cc2f4d1a108530d7ba52614b874c2 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Fri, 7 Nov 2025 06:03:37 -0800
Subject: [PATCH] net: netpoll: fix incorrect refcount handling causing
 incorrect cleanup

commit efa95b01da18 ("netpoll: fix use after free") incorrectly
ignored the refcount and prematurely set dev->npinfo to NULL during
netpoll cleanup, leading to improper behavior and memory leaks.

Scenario causing lack of proper cleanup:

1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
   allocated, and refcnt = 1
   - Keep in mind that npinfo is shared among all netpoll instances. In
     this case, there is just one.

2) Another netpoll is also associated with the same NIC and
   npinfo->refcnt += 1.
   - Now dev->npinfo->refcnt = 2;
   - There is just one npinfo associated to the netdev.

3) When the first netpolls goes to clean up:
   - The first cleanup succeeds and clears np->dev->npinfo, ignoring
     refcnt.
     - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
   - Set dev->npinfo = NULL, without proper cleanup
   - No ->ndo_netpoll_cleanup() is either called

4) Now the second target tries to clean up
   - The second cleanup fails because np->dev->npinfo is already NULL.
     * In this case, ops->ndo_netpoll_cleanup() was never called, and
       the skb pool is not cleaned as well (for the second netpoll
       instance)
  - This leaks npinfo and skbpool skbs, which is clearly reported by
    kmemleak.

Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
clarifying comments emphasizing that npinfo cleanup should only happen
once the refcount reaches zero, ensuring stable and correct netpoll
behavior.

Cc: <stable@vger.kernel.org> # 3.17.x
Cc: Jay Vosburgh <jv@jvosburgh.net>
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20251107-netconsole_torture-v10-1-749227b55f63@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c85f740065fc..331764845e8f 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -811,6 +811,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -820,8 +824,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }



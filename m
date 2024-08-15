Return-Path: <stable+bounces-67826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF54952F47
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6021228916A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AAE19DF9E;
	Thu, 15 Aug 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gzzZlLo3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856207DA8A;
	Thu, 15 Aug 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728640; cv=none; b=rrQUxP6SqCiAkc/tOm7qZrqtL83RLb8rAnOkUnRFEc9zr+SCiuRFOVenuvPxFU4R74vpSeVk/KDV9asNk3A3Fh9BvRFw6Vhhgr3T+1VylhiaGT9bE/tixQQg1+RlnJ6zp/58sYXcOPhhm5cStH2bl2kOpM70uZ1pU3Et44GdV4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728640; c=relaxed/simple;
	bh=Qj5dOPZ7NZEMpo0Y2SheO0P7jR/OLO+BoWiXCHdhucs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1rsYdZxzZRR/NUOerIWWXixGyNQPGGgBaOuim4iXRCvQQUptBomIojVqc/X43Zsh3SljtRhqOvC0UWKIv4wKMV8hxFMDKMZoUdXwS/j43VtLaHaPAVnVyEjAfTsVjKjADhLdm+0pHBLaVaZL94D72AK91eC2U+tKmYUmoEC564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gzzZlLo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB70C32786;
	Thu, 15 Aug 2024 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728640;
	bh=Qj5dOPZ7NZEMpo0Y2SheO0P7jR/OLO+BoWiXCHdhucs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzzZlLo30e1qXuvdu++L3MKrVIJ+GQvIh8Ug+0GZSVvmP7TLx0Y3aMxLiVoykTm94
	 msYEZ2BjeM81Ba0qVCDM+Dw4+MqSf0MzzTHgRbaCtN1csoHm7eLu4qAPBmiTdS0tCA
	 gpOxw7p0/V+iHW+s6TLE7x51sSYeDOZjtTZrMRnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 4.19 063/196] net: netconsole: Disable target before netpoll cleanup
Date: Thu, 15 Aug 2024 15:23:00 +0200
Message-ID: <20240815131854.486826559@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 97d9fba9a812cada5484667a46e14a4c976ca330 upstream.

Currently, netconsole cleans up the netpoll structure before disabling
the target. This approach can lead to race conditions, as message
senders (write_ext_msg() and write_msg()) check if the target is
enabled before using netpoll. The sender can validate that the target is
enabled, but, the netpoll might be de-allocated already, causing
undesired behaviours.

This patch reverses the order of operations:
1. Disable the target
2. Clean up the netpoll structure

This change eliminates the potential race condition, ensuring that
no messages are sent through a partially cleaned-up netpoll structure.

Fixes: 2382b15bcc39 ("netconsole: take care of NETDEV_UNREGISTER event")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240712143415.1141039-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/netconsole.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -727,6 +727,7 @@ restart:
 				/* rtnl_lock already held
 				 * we might sleep in __netpoll_cleanup()
 				 */
+				nt->enabled = false;
 				spin_unlock_irqrestore(&target_list_lock, flags);
 
 				__netpoll_cleanup(&nt->np);
@@ -734,7 +735,6 @@ restart:
 				spin_lock_irqsave(&target_list_lock, flags);
 				dev_put(nt->np.dev);
 				nt->np.dev = NULL;
-				nt->enabled = false;
 				stopped = true;
 				netconsole_target_put(nt);
 				goto restart;




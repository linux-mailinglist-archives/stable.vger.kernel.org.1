Return-Path: <stable+bounces-221732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBNEB6abo2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742C1CC0C5
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD6F73091906
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C42E093E;
	Sun,  1 Mar 2026 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQKHrdPJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E771CD2C;
	Sun,  1 Mar 2026 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329005; cv=none; b=Yp6egdlWBDdHCScAU1PzjiJHfWUjtTD8ajbHOEgSeg4/vJtkwlw8PPoEyuWC+g1ltmtLu/n8XTL+0+LgcyKjJr111QqYCmRylYHvfPWy3G+4UYI4JLaqZwWnldNJm//6OUPMXFPpFzqpPzCm2Ncg3IxJnc3ziUzC9Y0txjCuk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329005; c=relaxed/simple;
	bh=4+s8UOxyl3+9j0sEeu1gBMLiqag+x8ZiDV9+Cvh8OtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uv8nr06d4tqCPO/W6roSBjQuAfUs9rO68nyFSbAd+64mwRaG41F6wqLbn0IJizkgqnVO3eFQRPqL1EeY7W7g+d846gBysIHLkU+ARJ1H31fKmIXk5rCfzlXOJhqDowH5yb8Q59/UUYGpzVaeULbvFkZGfbLbP1k/at8rI2BTP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQKHrdPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AABC19421;
	Sun,  1 Mar 2026 01:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329004;
	bh=4+s8UOxyl3+9j0sEeu1gBMLiqag+x8ZiDV9+Cvh8OtA=;
	h=From:To:Cc:Subject:Date:From;
	b=eQKHrdPJet7D23XX21PLwY6o566JMeSzuGhx6irM9FAzibozrP1EPCMwD+1m0a/hG
	 ZMKibPpAyipOV5D/Rh8tmQtfc798LYGGgZDDsAy4X20c3iXAnPKHbqshKoQx9DSKzf
	 kUxtVp2QkMyb1RtSPeoHTtRmurXUO3o/9KhAAN2UKPTJKBGVj04V5QrGrBANUmbsM9
	 092TNRTCvpIE3YTt+Xv4a+veLKIDfvSpAYLmnn8RNH6lzpSJSmkbjtwjLcPl6lqHZt
	 MvELjkjErPlGjfRFPWfCBrw1Ku97uF/hwh32XDFrJZT8R6Y+bdN9TfeVvCbuD0rLhx
	 pm9MsWx+ZcryQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	guojinhui.liam@bytedance.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: Fix pci_slot_trylock() error handling" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:36:42 -0500
Message-ID: <20260301013643.1696741-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221732-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3742C1CC0C5
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9368d1ee62829b08aa31836b3ca003803caf0b72 Mon Sep 17 00:00:00 2001
From: Jinhui Guo <guojinhui.liam@bytedance.com>
Date: Fri, 12 Dec 2025 22:55:28 +0800
Subject: [PATCH] PCI: Fix pci_slot_trylock() error handling

Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
delegates the bridge device's pci_dev_trylock() to pci_bus_trylock() in
pci_slot_trylock(), but it forgets to remove the corresponding
pci_dev_unlock() when pci_bus_trylock() fails.

Before a4e772898f8b, the code did:

  if (!pci_dev_trylock(dev)) /* <- lock bridge device */
    goto unlock;
  if (dev->subordinate) {
    if (!pci_bus_trylock(dev->subordinate)) {
      pci_dev_unlock(dev);   /* <- unlock bridge device */
      goto unlock;
    }
  }

After a4e772898f8b the bridge-device lock is no longer taken, but the
pci_dev_unlock(dev) on the failure path was left in place, leading to the
bug.

This yields one of two errors:

  1. A warning that the lock is being unlocked when no one holds it.
  2. An incorrect unlock of a lock that belongs to another thread.

Fix it by removing the now-redundant pci_dev_unlock(dev) on the failure
path.

[Same patch later posted by Keith at
https://patch.msgid.link/20260116184150.3013258-1-kbusch@meta.com]

Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251212145528.2555-1-guojinhui.liam@bytedance.com
---
 drivers/pci/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31f..59319e08fca61 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5346,10 +5346,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
 		} else if (!pci_dev_trylock(dev))
 			goto unlock;
 	}
-- 
2.51.0






Return-Path: <stable+bounces-138782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37150AA19B0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53F71C0092B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E825394B;
	Tue, 29 Apr 2025 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vh5mMXXs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05C253934;
	Tue, 29 Apr 2025 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950333; cv=none; b=PfXpWP/OxPussrr9gRV/1GgoGL23VeOdjYKEa4yg81gr49GfdzqVd1uFGJU9HeNln6+Fj0i/gD4tPNNSWcqdltxDuxWfKIL8LFO2FEFQrJ8bXF6VXPuII/gbZmV/XSl3lrH6N7k9sq6hAxfHMzjQ7G97SCLiy7AVEbqcwzDmwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950333; c=relaxed/simple;
	bh=2BVBcQlQ1W0PzgP6my6MtjDM4Dng3joU5FLILNbxaxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SABm/D1zGYjqXunjDQftjt/B8ywZse3KFDdx9M+l7xJhKjTNfPUAHrM9wrhDCMHSGUcT0FAwKL9rn/wnGknH0+JIs3jpAoGW/oxsSBqHI/L3NtZP86Ud9sbwqeCXec+2lf+wecWvZc+AS+LJlal645Ae728qyMAIsMEXKVK+zDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vh5mMXXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2DBC4CEE3;
	Tue, 29 Apr 2025 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950333;
	bh=2BVBcQlQ1W0PzgP6my6MtjDM4Dng3joU5FLILNbxaxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vh5mMXXsD7GO/nQgRerluYL/uQD+wpWKoyv7EwPa3WQEFqNzoB82XUNqaVZCjCYHG
	 nkHamU55b4/dahZTYtrsU46jkS/B8mVxGuryC33Kka5h/w+JWWPXl91mXMxI3kNQY2
	 OOapGgDpOZsrOIg1jajcFjYtPuANmQyJHKiC+99U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 061/204] net: dsa: mt7530: sync driver-specific behavior of MT7531 variants
Date: Tue, 29 Apr 2025 18:42:29 +0200
Message-ID: <20250429161101.926820022@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 497041d763016c2e8314d2f6a329a9b77c3797ca ]

MT7531 standalone and MMIO variants found in MT7988 and EN7581 share
most basic properties. Despite that, assisted_learning_on_cpu_port and
mtu_enforcement_ingress were only applied for MT7531 but not for MT7988
or EN7581, causing the expected issues on MMIO devices.

Apply both settings equally also for MT7988 and EN7581 by moving both
assignments form mt7531_setup() to mt7531_setup_common().

This fixes unwanted flooding of packets due to unknown unicast
during DA lookup, as well as issues with heterogenous MTU settings.

Fixes: 7f54cc9772ce ("net: dsa: mt7530: split-off common parts from mt7531_setup")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Chester A. Unal <chester.a.unal@arinc9.com>
Link: https://patch.msgid.link/89ed7ec6d4fa0395ac53ad2809742bb1ce61ed12.1745290867.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 90ab2f1058ce0..2d18a03d92742 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2596,6 +2596,9 @@ mt7531_setup_common(struct dsa_switch *ds)
 	struct mt7530_priv *priv = ds->priv;
 	int ret, i;
 
+	ds->assisted_learning_on_cpu_port = true;
+	ds->mtu_enforcement_ingress = true;
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -2735,9 +2738,6 @@ mt7531_setup(struct dsa_switch *ds)
 
 	mt7531_setup_common(ds);
 
-	ds->assisted_learning_on_cpu_port = true;
-	ds->mtu_enforcement_ingress = true;
-
 	return 0;
 }
 
-- 
2.39.5





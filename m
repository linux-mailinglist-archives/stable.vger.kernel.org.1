Return-Path: <stable+bounces-138610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EEAA18DB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9EE4E25EC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D115D2517A6;
	Tue, 29 Apr 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b9K3/l/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2224111D;
	Tue, 29 Apr 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949793; cv=none; b=UCTExALsP/JZhZyMU/7Iyg05wxCFOBR0wwW5v0QP2Gtd63ajD8/YSlRYVT87V9OZcVnJJLZDkod5t93xw7aDG0Dlf5CwIa5wAGMOkdjEebLxp7ucWcAN12bz4zFTjdW+p3N6uv4TYQNd+9omKrCi8nlMxOhSMTeQKO4z9bCtnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949793; c=relaxed/simple;
	bh=5cp0Y2Q/7WxhuN1c0UN70T6fGjLEsfvIIWAZuGCa3AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJNAi0VGA+jubXq6bUNCsPZ66OobpawQMNu6mt9ANsqOQUWhW3W9etgxa9lEAqxII34AD988PxBiCwujziS7pv7SfrQCjwk/gwhI1lOKWtYjorR84y8FUPCaD8aNwJCGY9a/6GqfRsYdbXAXYYOf3MGuEcsT6py/dVR7U1VCKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b9K3/l/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0734C4CEE3;
	Tue, 29 Apr 2025 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949793;
	bh=5cp0Y2Q/7WxhuN1c0UN70T6fGjLEsfvIIWAZuGCa3AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9K3/l/8wu/40UFmYFs19ihrgTzrMGcTZEo0FrrQmkFCLjPvU0GxzodOpNQVq051m
	 dIfrBzkBhHcYDs2alXMy/0kL5QKh4GN3m6zDcdi0en1VOAd0kQW7DCVfj7El7eRfDe
	 /ev1GgAvVa/+lQhhmrArFAynQ+MMHVbevGMEMCtg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/167] of: resolver: Fix device node refcount leakage in of_resolve_phandles()
Date: Tue, 29 Apr 2025 18:42:17 +0200
Message-ID: <20250429161052.928291952@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit a46a0805635d07de50c2ac71588345323c13b2f9 ]

In of_resolve_phandles(), refcount of device node @local_fixups will be
increased if the for_each_child_of_node() exits early, but nowhere to
decrease the refcount, so cause refcount leakage for the node.

Fix by using __free() on @local_fixups.

Fixes: da56d04c806a ("of/resolver: Switch to new local fixups format.")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250209-of_irq_fix-v2-9-93e3a2659aa7@quicinc.com
[robh: Use __free() instead]
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/resolver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 2dd19dc6987c7..d5c1b2a126a56 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -262,8 +262,9 @@ static int adjust_local_phandle_references(struct device_node *local_fixups,
  */
 int of_resolve_phandles(struct device_node *overlay)
 {
-	struct device_node *child, *local_fixups, *refnode;
+	struct device_node *child, *refnode;
 	struct device_node *overlay_fixups;
+	struct device_node __free(device_node) *local_fixups = NULL;
 	struct property *prop;
 	const char *refpath;
 	phandle phandle, phandle_delta;
-- 
2.39.5





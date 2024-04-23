Return-Path: <stable+bounces-41013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE0F8AFA00
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89817B2B0AB
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806E1487CE;
	Tue, 23 Apr 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qX+tzImE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A93143899;
	Tue, 23 Apr 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908618; cv=none; b=d6E186lHkq9jJGSYrFH3KSIvBijEZ1JuyJK3AsIN/tqPX56+KdyxxJJfnd3TLN60T8afJL4u99YRaPJEQSnuHp0MjSOXQxUASZbnyK2JrPvt7t2dx4RulmIFHQMm9KEHcgUeRCyNSe+FSxS5BtcjdgxkXk66MgGPoICcYUywevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908618; c=relaxed/simple;
	bh=zY9TYw0hXWYtslDWIqFHMeu8hhLXqZwJ30PAMDnrMtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mup9xwcuqk2CTtbF8MyRUbioLg52xB7LgO93h491JCby076QRZKblIJD3WobrJlq3sHXSbmX0YyeJetY617ncW0SUV8PgB7HqXUDvQb+xNUzeMZHl+aF/AjE2eCZ7I9MGdFi74fyuMaLJl+GnLt5lYmWMciDK24Ai0MiNXobWvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qX+tzImE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C995FC32781;
	Tue, 23 Apr 2024 21:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908617;
	bh=zY9TYw0hXWYtslDWIqFHMeu8hhLXqZwJ30PAMDnrMtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qX+tzImEpEa8RqpY5rWupDU4tlEpYerqYjxhbFg7qxa0f4XcWIG61JP8HLYOV+kQK
	 LqnkNpAdtaqJwAQW13A89XUD1x8g2Ya5zvWIlwtLR0a+thFVjsC3DkCJH5NVk0Xdzl
	 +Ptcc6PesmU6YuKO4CoN24PAhXggIJWKynOTsd/M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 091/158] clk: Remove prepare_lock hold assertion in __clk_release()
Date: Tue, 23 Apr 2024 14:38:48 -0700
Message-ID: <20240423213858.703563246@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit 8358a76cfb47c9a5af627a0c4e7168aa14fa25f6 ]

Removing this assertion lets us move the kref_put() call outside the
prepare_lock section. We don't need to hold the prepare_lock here to
free memory and destroy the clk_core structure. We've already unlinked
the clk from the clk tree and by the time the release function runs
nothing holds a reference to the clk_core anymore so anything with the
pointer can't access the memory that's being freed anyway. Way back in
commit 496eadf821c2 ("clk: Use lockdep asserts to find missing hold of
prepare_lock") we didn't need to have this assertion either.

Fixes: 496eadf821c2 ("clk: Use lockdep asserts to find missing hold of prepare_lock")
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20240325184204.745706-2-sboyd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 50228cb0c5590..ac5be561ccdc9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4313,8 +4313,6 @@ static void __clk_release(struct kref *ref)
 {
 	struct clk_core *core = container_of(ref, struct clk_core, ref);
 
-	lockdep_assert_held(&prepare_lock);
-
 	clk_core_free_parent_map(core);
 	kfree_const(core->name);
 	kfree(core);
-- 
2.43.0





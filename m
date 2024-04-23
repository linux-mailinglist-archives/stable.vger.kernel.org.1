Return-Path: <stable+bounces-41257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9598AFAED
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BBE280A04
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF321448D4;
	Tue, 23 Apr 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVTmCmyV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA15148843;
	Tue, 23 Apr 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908784; cv=none; b=XayYLrlQQmMSPBlLI8nhJYsKLsY6paOJIJXx0g0SxPIHTOF/uoh9uCn7Go9P7eMPWtPyettpaNVEIZiwiyb6f33JXn2gdVjuoNCXQHVgipKogW/GHTdvwB6KHAf1VJOspiDj6TqjtmT5qHpe7Goj9whTPZuZn3tQ3h7knglM7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908784; c=relaxed/simple;
	bh=i2/xI4+BMSO8x6qBg8+29o+xGCBF2kK6BA1N7w6IJtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFxRvhqGXGYDU/wlTi2DPWIiDlFcgOsO2ws0jWsYf09F1vQFzyn7LITH8ooPJ5PnAZQy0wWesWAW6Dd5lAnUWuSQiVqPulCk5AYyjMXdE2CPQ7jH1WIOAv7FJ86rCD5kTBa2p5NOtaEyuNk6PfB0N6qJfEIy4Bbh+SA4iYJ4aiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVTmCmyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C9C32782;
	Tue, 23 Apr 2024 21:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908784;
	bh=i2/xI4+BMSO8x6qBg8+29o+xGCBF2kK6BA1N7w6IJtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVTmCmyVH3e3M5OR4mLdWl22hfhEBGSUCbiu0+YA3K3rG4UZTP5wUy0bcf/uODeB9
	 kR95OqMptM4P2q+VqQqhmtSKdoEWKEDwiiLnMsHU4l8bI3BkXk+Oab3lISZ3DaDwkt
	 0/s3eW/wwW+bvaPj6fnt77wTweV1VulkISSmGWSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 34/71] clk: Remove prepare_lock hold assertion in __clk_release()
Date: Tue, 23 Apr 2024 14:39:47 -0700
Message-ID: <20240423213845.320807665@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 84397af4fb336..acbe917cbe775 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4047,8 +4047,6 @@ static void __clk_release(struct kref *ref)
 {
 	struct clk_core *core = container_of(ref, struct clk_core, ref);
 
-	lockdep_assert_held(&prepare_lock);
-
 	clk_core_free_parent_map(core);
 	kfree_const(core->name);
 	kfree(core);
-- 
2.43.0





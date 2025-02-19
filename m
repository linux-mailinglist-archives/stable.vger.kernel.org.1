Return-Path: <stable+bounces-117730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93742A3B830
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659753BAF0F
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221FF1DE2C2;
	Wed, 19 Feb 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H+ZcJJ+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FA1D61B5;
	Wed, 19 Feb 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956175; cv=none; b=QaM/PB7sK/Vd/nQkoRTAzOxDffXaWw2mioMf4d40xPkvIu3edsBXzIKfPwQXs3YZ5o7djPhkQrbMKLqlPGTHNp/SqQlB/9PVmnkcPtZuflXqtO0VfsuRFRWqHNBRZBnBI0xIPib8Sp/ln02Km/bkZMq+PHozz8TgiitEPpEPIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956175; c=relaxed/simple;
	bh=2yQnl7hQjXqC2eODp2RrjKWSnfNj3ZPHlPQkVQxg9nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pac0yR71SToAtYYqErO3D0AMapDQnT2tJ+VzbsHY0cmTKALcOAZN3wWupUd5uOdQZKMz0eyjBznKq7DaQ+Yz2qhzYTaPOK/YJ5+w7LIzD7JwcQVBjLCbAbMbwAa2LjCziuxRE4FlMrVbb7VIsrVvWgY2RnnnhIH7dvgIvWUXYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H+ZcJJ+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDBFC4CED1;
	Wed, 19 Feb 2025 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956175;
	bh=2yQnl7hQjXqC2eODp2RrjKWSnfNj3ZPHlPQkVQxg9nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+ZcJJ+o52jAanyJGoxOo5LT9E1KbQRLB0W6A34lKEuDu08yE3GSvaIkgN6/dlLbL
	 SM2a1i/T1b5AJQ6rXjllo3D63hPBfHWadnTwMLJOsU3t6wWXVpu1wbgQfISsqMl9Ot
	 KvBf9IB/mSvBcLJaP9OEFBl4LsEZnY5/7d3V97K4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bo Gan <ganboing@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 091/578] clk: analogbits: Fix incorrect calculation of vco rate delta
Date: Wed, 19 Feb 2025 09:21:35 +0100
Message-ID: <20250219082656.540010121@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

From: Bo Gan <ganboing@gmail.com>

[ Upstream commit d7f12857f095ef38523399d47e68787b357232f6 ]

In wrpll_configure_for_rate() we try to determine the best PLL
configuration for a target rate. However, in the loop where we try
values of R, we should compare the derived `vco` with `target_vco_rate`.
However, we were in fact comparing it with `target_rate`, which is
actually after Q shift. This is incorrect, and sometimes can result in
suboptimal clock rates. Fix it.

Fixes: 7b9487a9a5c4 ("clk: analogbits: add Wide-Range PLL library")
Signed-off-by: Bo Gan <ganboing@gmail.com>
Link: https://lore.kernel.org/r/20240830061639.2316-1-ganboing@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/analogbits/wrpll-cln28hpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
index 09ca823563993..d8ae392959969 100644
--- a/drivers/clk/analogbits/wrpll-cln28hpc.c
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -291,7 +291,7 @@ int wrpll_configure_for_rate(struct wrpll_cfg *c, u32 target_rate,
 			vco = vco_pre * f;
 		}
 
-		delta = abs(target_rate - vco);
+		delta = abs(target_vco_rate - vco);
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_r = r;
-- 
2.39.5





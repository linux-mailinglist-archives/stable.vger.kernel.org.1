Return-Path: <stable+bounces-127926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE8A7AD1B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564947A3639
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3619125A630;
	Thu,  3 Apr 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kN2rZuUf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7F25A62F;
	Thu,  3 Apr 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707407; cv=none; b=e5WbUcWFuSriF9nJqnUVRSfj5JgbWLT2cLWpIysVuBUMbOii8Hg9jIPa0DcCXdTkp1SXTiMKt5foQlOk8jXiwFrpG5AT8HAOIoYhsQtU0Z7SCueE8kGDhLSf4JMfQ/l90sG8Q7OiKoDNTtLDLtOxxm96t9LubAZbXl9o/GaKJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707407; c=relaxed/simple;
	bh=EgZcr+RgILfzlkPmUksAITZJ2kvsOf2hzqEDPvIfHU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j4P9kC10nzaxHw/FLIkanRk6MswUH1cW3jGRe2TvpqPHprDL7wqBdsMtpN4+a0LM4bZCc/AL3Uzpr563I6cRXLmN29uWRFvuOFeelgEcBJwxfTJMDJWo8Q9l3Fbjhwicugk0zF2910TWn3v4WdxuoafHZaMWL8EUIzXk6eiL8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kN2rZuUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEE9C4CEE3;
	Thu,  3 Apr 2025 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707407;
	bh=EgZcr+RgILfzlkPmUksAITZJ2kvsOf2hzqEDPvIfHU8=;
	h=From:To:Cc:Subject:Date:From;
	b=kN2rZuUfgIFKK6r6aQhi86Cz331vgLhAD3Km+lJUFkXZhkw9dbZdbkL3Huj3qVEvG
	 ieRRs4etJ+uM6ktiXY/D+nL9Z2TXmaIAar9iBjC3w1sd256ZKsdJOLdujSJtIrwl3q
	 0FX9Q2OKnCqOCROsTqjZh+lerj2Trj7fUXHeWr0X99uVwITKcIyuF5c5DGwjQXHZ2X
	 oda1Ttf9/E2cqzr3gSmqOqL3mJ2Ejjnt5EHCdkDPDbtssJ2tzbzqHZCzvnxspv8k8h
	 m+S5ZjuJ7263q6PfMkpYdKT3viStXEphl/+7qTePvx+PeJZJHLh7Gf3/ABHQzHKwT6
	 9usb8aPJZrgcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/15] page_pool: avoid infinite loop to schedule delayed worker
Date: Thu,  3 Apr 2025 15:09:48 -0400
Message-Id: <20250403191002.2678588-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Jason Xing <kerneljasonxing@gmail.com>

[ Upstream commit 43130d02baa137033c25297aaae95fd0edc41654 ]

We noticed the kworker in page_pool_release_retry() was waken
up repeatedly and infinitely in production because of the
buggy driver causing the inflight less than 0 and warning
us in page_pool_inflight()[1].

Since the inflight value goes negative, it means we should
not expect the whole page_pool to get back to work normally.

This patch mitigates the adverse effect by not rescheduling
the kworker when detecting the inflight negative in
page_pool_release_retry().

[1]
[Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
[Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
...
[Mon Feb 10 20:36:11 2025] Call Trace:
[Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
[Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
[Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
[Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
[Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
[Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
[Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
[Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
Note: before this patch, the above calltrace would flood the
dmesg due to repeated reschedule of release_dw kworker.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250214064250.85987-1-kerneljasonxing@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 08fbf4049c108..a11809b3149b4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -485,7 +485,13 @@ static void page_pool_release_retry(struct work_struct *wq)
 	int inflight;
 
 	inflight = page_pool_release(pool);
-	if (!inflight)
+	/* In rare cases, a driver bug may cause inflight to go negative.
+	 * Don't reschedule release if inflight is 0 or negative.
+	 * - If 0, the page_pool has been destroyed
+	 * - if negative, we will never recover
+	 * in both cases no reschedule is necessary.
+	 */
+	if (inflight <= 0)
 		return;
 
 	/* Periodic warning */
-- 
2.39.5



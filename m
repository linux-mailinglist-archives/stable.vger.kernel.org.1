Return-Path: <stable+bounces-127731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992F0A7AA1A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982C1177B00
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140DB256C9C;
	Thu,  3 Apr 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5GgQeXk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8B256C91;
	Thu,  3 Apr 2025 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706966; cv=none; b=j5jq0L0lNfDTaKXyUFq/cKe3lZrAklnbbRxOu6VngqH2L4t1ZQcB9OniFJ0RdtYZE8AM5ZfZj9xs20lVsc+pd/jwSbx+5wV3s97QU0ZGCJJE9ngiQ7nWpL2dUXIazWosJJoKJXgkPT/OAQtU1zENUe/Hdpcap4+8xFAFa3trTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706966; c=relaxed/simple;
	bh=7rE74X9+EgHYZG/1kugO9vNjExrNuzVoYCMDI0L4qbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzJUhsjdFNLgtOPCyVlNPVbhIgZS1YHB5TBLcxoYqqruia/UJVH8yeagwLu+yGitd/iDBGtYqQnaIKi3tJ5lY76IZgh2rUyq+MyjY9XhVgKrijBrYgsYFQQm0OkZUI9D5yh3lnyf8ZK9FAnx5kt2nZ+zDw45jecEMDEBJ1vPG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5GgQeXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0DDC4CEE9;
	Thu,  3 Apr 2025 19:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706966;
	bh=7rE74X9+EgHYZG/1kugO9vNjExrNuzVoYCMDI0L4qbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5GgQeXk7PDiARKvqRhRnc3vbu6HAPDkwcO6qqXn0m8Npi9j4ju5P9h3K8xcTF9RU
	 ep+rrk6c2wBadh8G2qBOuH2UAX2Rg3eGhjFJwDnYSJjnmn2sGd0CFb8+LKJC/b08oc
	 zlRgS3U7TYfvC3nx0FPCfNdgtvOhieYkBbN2hXQrNgbyxBooTb6wWqbbt92Nj0jvaA
	 5ikdocT99fbTEdFRvDpFYCYGOKJx1S9h4nl4CzNTj6vFK/54GA/z4cBBgTmosQU8Tr
	 IyXySnL80wbcZNRD6xwPCgySku35x1OThRkYL/UliMpUsIsRTf7gLDbLkXuI++Y82n
	 +TppmcdKHO9uw==
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
Subject: [PATCH AUTOSEL 6.14 16/54] page_pool: avoid infinite loop to schedule delayed worker
Date: Thu,  3 Apr 2025 15:01:31 -0400
Message-Id: <20250403190209.2675485-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index f5e908c9e7ad8..ede82c610936e 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1104,7 +1104,13 @@ static void page_pool_release_retry(struct work_struct *wq)
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
 
 	/* Periodic warning for page pools the user can't see */
-- 
2.39.5



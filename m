Return-Path: <stable+bounces-88485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B89B262C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F001F21E54
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075C18E348;
	Mon, 28 Oct 2024 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iaJ8qq5s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9615B10D;
	Mon, 28 Oct 2024 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097440; cv=none; b=E1HxqOmavbHskt4g0HLMiihzUCtSBw018XDt4O/gov4q2SIFgSvzvHZcako4MIGEKk5vy6/+oMZYdJXbonfMF6VO0UiBvrQbfqXMW2t53tp7WEOC2sp2woWCtzM76yIxfH9UPx5/EQtLvx835yJMoEku1+FD5CnYqhqsV9TiNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097440; c=relaxed/simple;
	bh=BJquMrIdehB+2qSmoZaFMom5CgEc15Ijk4igIU8Cgds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkjgFWgc/Ts1GDAklAtDb9vk24xFSmnuoZ3ObuNHFp3x6Mm1+g2e7Ww3lPn0xrmoAfMw3q5du+6wRgWYoe0XFvS/wxQzW05lDCwRwHe0RDi5RVlLb+Wmo3uIB1vQ/Qa6uAoBUErW+8HfqeFqB4HCf5Y9PaqfDLo1JaJLKjFyoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iaJ8qq5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1437BC4CEC3;
	Mon, 28 Oct 2024 06:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097440;
	bh=BJquMrIdehB+2qSmoZaFMom5CgEc15Ijk4igIU8Cgds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iaJ8qq5sFN8k/xZxqc/j4zYxBOwcgDvzTODTOG7I/eqkpY4cBUXNcvvQadVcTnts0
	 EZ48lU9/OLl0LxDaxp/T1S51KHSfQpR5L7ybKvxXj/TEl6Lt8smy5Eby0r1pZ9dP5F
	 YsA6YuFGIaVE3VxrQ0O9BQ2YPXqk3gXVWbUzzO6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 104/137] posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime()
Date: Mon, 28 Oct 2024 07:25:41 +0100
Message-ID: <20241028062301.630892250@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 6e62807c7fbb3c758d233018caf94dfea9c65dbd ]

If get_clock_desc() succeeds, it calls fget() for the clockid's fd,
and get the clk->rwsem read lock, so the error path should release
the lock to make the lock balance and fput the clockid's fd to make
the refcount balance and release the fd related resource.

However the below commit left the error path locked behind resulting in
unbalanced locking. Check timespec64_valid_strict() before
get_clock_desc() to fix it, because the "ts" is not changed
after that.

Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in pc_clock_settime()")
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Acked-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
[pabeni@redhat.com: fixed commit message typo]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 8127673bfc45e..05e73d209aa87 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -290,6 +290,9 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 	struct posix_clock_desc cd;
 	int err;
 
+	if (!timespec64_valid_strict(ts))
+		return -EINVAL;
+
 	err = get_clock_desc(id, &cd);
 	if (err)
 		return err;
@@ -299,9 +302,6 @@ static int pc_clock_settime(clockid_t id, const struct timespec64 *ts)
 		goto out;
 	}
 
-	if (!timespec64_valid_strict(ts))
-		return -EINVAL;
-
 	if (cd.clk->ops.clock_settime)
 		err = cd.clk->ops.clock_settime(cd.clk, ts);
 	else
-- 
2.43.0





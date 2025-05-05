Return-Path: <stable+bounces-141373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23487AAB2D5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22E67A5964
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BAE44A638;
	Tue,  6 May 2025 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjZLj76y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B744F37B334;
	Mon,  5 May 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485952; cv=none; b=s4fW5KRnsvyaRKiaHOC3RwBRKGj8zsrvh5byQZ4Emr2W0Dhm1OwF6+cqqrM/D6dKT7TtQOQpz7nOCtK/+I2e9Qh5xkt3KCTLiC+6L+g6RbAd4qN48U5Pjt//LWuKqD5Ps3+zywB4gcK8B7mPrwc6Ac9sLDRi62wNI8XGogm7/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485952; c=relaxed/simple;
	bh=dS6QQO9Cqg/2YcT2b/EwzqYv1BU1w2n7lfxpqM83hrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nb345OV9GrpfmQ1U8GP1C+HZL3oZioHgpuHBeTMCjVA+CxQ95W0Fee8K02M0c6gvNzVt86ImhV2zkRYcLA7/1i1J4EENr2tELb6KExCe3Eu+xx1V40wJTi+7f+A/MUSHyX0OFBuWZgJ4TAQTK/QVw5GI2U9NkhgCJWn5WEBW670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjZLj76y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA639C4CEEE;
	Mon,  5 May 2025 22:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485952;
	bh=dS6QQO9Cqg/2YcT2b/EwzqYv1BU1w2n7lfxpqM83hrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QjZLj76yyLkDASo3+gp+tdlgn0W1FofVdAvKmnFl8EFQZTf1vdJ91GEZZo5FwMnay
	 IjeL1We5+4BVQjGzYs6qtn2XeVWPuSTtuWAEr//XK1qwcj4nDVJF3mAHkk0klPPK76
	 98QtEZC4EFEwZW64qimrllLKaIe/apzbzZHxbbCyG7tHorg5isjCmIH/df3DqIaU6/
	 klxfr7VHIW+95QbQF1YClXLv3qe51WIDl+UdeMN9AcuQvOeAVTfxpbEOW2NamzUGYT
	 ljFetUgoviPLH4wIcBkxILupv0wc2zDe3hFH+vdARf9+8n2fooqrg2LidLlCdndfi8
	 TZ6jIdbzautpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 6.6 082/294] posix-timers: Add cond_resched() to posix_timer_add() search loop
Date: Mon,  5 May 2025 18:53:02 -0400
Message-Id: <20250505225634.2688578-82-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5f2909c6cd13564a07ae692a95457f52295c4f22 ]

With a large number of POSIX timers the search for a valid ID might cause a
soft lockup on PREEMPT_NONE/VOLUNTARY kernels.

Add cond_resched() to the loop to prevent that.

[ tglx: Split out from Eric's series ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250214135911.2037402-2-edumazet@google.com
Link: https://lore.kernel.org/all/20250308155623.635612865@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa4..7534069f60333 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -118,6 +118,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
-- 
2.39.5



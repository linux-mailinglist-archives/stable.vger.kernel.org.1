Return-Path: <stable+bounces-110536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C38BA1C9E7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12603A7DA9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB11F8660;
	Sun, 26 Jan 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9n1SlkO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A001F7913;
	Sun, 26 Jan 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903287; cv=none; b=N4RT//KaKlUqxyISNjoD0Pw65viMmSZ9Aj+uYmu3CEAg40NfHyG/D1JTSDNNHg+3IIo5BJkJITiybesm3z8zpgiPRztA41/KNrCkQ4Af6EfAOalf+oWeBu+5UDIu5Ou27HqgEqxK8/CJDleCw+nDiS6KuLVATQfY3nmpLE7vW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903287; c=relaxed/simple;
	bh=Ueg4UP6zDmQGO3ysgeObxBWh+1qd+reD+R1BBXHMeBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsV2OEqkPjefXN17CWWPNYI1yCwfFlzl8wyCPX/EFvSBLR2FN4RmCNFfz7OSFFVJhi/S+wnDqL4y1nIXaFRO855O4xUHVYYP80M8a2uv1jFKJbH1h65jI1nDx9H3f+lakQZoenmdH25gN3UjoX1XGdxuLp2X82t+wbU5KDUI7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9n1SlkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B385C4CEE2;
	Sun, 26 Jan 2025 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903287;
	bh=Ueg4UP6zDmQGO3ysgeObxBWh+1qd+reD+R1BBXHMeBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9n1SlkOzBPM8q0ZVQfHmhsQuQaK3Taww0Otu5EhHLE8Iol9fkI/rqSdthiOckNwH
	 SBXHIqMmy4jsEgdt26l4kJHPzmeDHMpbH+zHUm1zB7/t4duij/K4uGMIz6ZxJzOAOF
	 AJn+P0FErJWrRGz+ReHxqQIgJrMrvCwh6o6UOlNdnKDSWuTlJ6jJtU6c3VRHwQAa7m
	 yZNKQK9APO3sY8kS7viBybD40YUkBpsKXAaDs1vsMseD9dNXLkpJO/MLkHs+ROsxTA
	 pOQygrBYGav8ug6Yo6PTO9US8kpqJSc+XJzPVfHBOeypcT82eQSAk0PParMTdLI6lp
	 ZvlWceOD627Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 34/34] ring-buffer: Make reading page consistent with the code logic
Date: Sun, 26 Jan 2025 09:53:10 -0500
Message-Id: <20250126145310.926311-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 6e31b759b076eebb4184117234f0c4eb9e4bc460 ]

In the loop of __rb_map_vma(), the 's' variable is calculated from the
same logic that nr_pages is and they both come from nr_subbufs. But the
relationship is not obvious and there's a WARN_ON_ONCE() around the 's'
variable to make sure it never becomes equal to nr_subbufs within the
loop. If that happens, then the code is buggy and needs to be fixed.

The 'page' variable is calculated from cpu_buffer->subbuf_ids[s] which is
an array of 'nr_subbufs' entries. If the code becomes buggy and 's'
becomes equal to or greater than 'nr_subbufs' then this will be an out of
bounds hit before the WARN_ON() is triggered and the code exiting safely.

Make the 'page' initialization consistent with the code logic and assign
it after the out of bounds check.

Link: https://lore.kernel.org/20250110162612.13983-1-aha310510@gmail.com
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
[ sdr: rewrote change log ]
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 60210fb5b2110..6804ab126802b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7059,7 +7059,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
-		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs)) {
@@ -7067,6 +7067,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 
+		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
 				break;
-- 
2.39.5



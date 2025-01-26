Return-Path: <stable+bounces-110567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07010A1CA0E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130BF1635FC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B109A1FC7DA;
	Sun, 26 Jan 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKU+P6Zz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905E1FC7D8;
	Sun, 26 Jan 2025 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903372; cv=none; b=GG7xaoI3CarJnU2fW4Xr7hQxt+Lc80P6+K5qezipDO9DMUtb9nCT/BSZRfY3sBIH1ZwvBN2VmMOZ29mfJtymBtNFvKi/hMZls3nlaF7yAVH+TiI8txdpc7NVcO6RGU87v2XaIdo3OpPaOe7zziNKOJO6n/XeUxT53Dn9tBkRV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903372; c=relaxed/simple;
	bh=eV63UqxWcasLmFKmafSwVGhlsTu3il2siuiSSVmN0AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kasPlLChhnbmAL0wNlV3yVBkHy8klt6sykvUBFdrv1JFtoNqPQkcdX5Eyi4vJZ156HfW7hDQXc+3aUl+FLAUjPk1nQzfn3u56EukvaVavHV/ub68XOAzI62ehnDjB1Y65U+TyB8oqeVMDmN9c0+PYzExVjCLxpb6S4Vj7TKyV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKU+P6Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169B6C4CEE2;
	Sun, 26 Jan 2025 14:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903371;
	bh=eV63UqxWcasLmFKmafSwVGhlsTu3il2siuiSSVmN0AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKU+P6Zz5zgUkRsJ9nsKaDYExQVvC/CJGAfHtyEakzM2U17t1PMan/KDeratoH6nC
	 fWKPmcl8qiIGvyVJT+q080lyPdsfPA+XT7XpHynD/vWw3y32csV7D3p16+UUMXmqr8
	 u1i+XPm3TsARNz72fN5mQ5sueHpea8fnIk2XQurlTBQxqfu2FzvB1Wzy2Qk/NMi3ov
	 z2lXb6SHZ91SzMvAC6HFfPwM+GuhEwAcnrAKG5C5yDgGJRflF7ch072mSWU474ePyd
	 V67Yj4QqNyPpqHofvN40yqNLA+eYTmW5Dv1sHBicI0Vh78uKw+0CMZXFMh2HaDrBUx
	 GD7+UEHKowJhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeongjun Park <aha310510@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 31/31] ring-buffer: Make reading page consistent with the code logic
Date: Sun, 26 Jan 2025 09:54:47 -0500
Message-Id: <20250126145448.930220-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 703978b2d557d..28fad7bcfcf86 100644
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



Return-Path: <stable+bounces-63323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E6941861
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A519028115C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AF1078F;
	Tue, 30 Jul 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tgdFczFN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196C1A617E;
	Tue, 30 Jul 2024 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356459; cv=none; b=C+FvTLofj88W/sP5jAc85ny2+OuTsMTJQ+UMgQY7E2yV8bCEMPWrum1H62FGgURFEJwbIUV5ZSTDlcD+XNULXnz94Fv6zidu3GtGV6xcVlJu3nxPsGWu6Ff9F2rveVrYQwRJBCrolkOBV4nschGT0WT1sUiESCKO5eXoQ5Vk+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356459; c=relaxed/simple;
	bh=ZZxy6S+kBzDThfv+hOQsaTGhJTnq5KySnvHGuTK9Q4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG1/4C51KZ/2zXxCt62H7l4/3GlzMMzSjfWnckmtCMIlpVWsZq0mTLu+VIqaRA2vrGCkox3k0gpqMqzOxall2vjSchMfTIHF1jJCIY4snZ9ybVd7fpN/+flSMFin+5nm7rjYS2vn15Jlzpojso0cPSuIkBc6lEES9MNL27mM894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgdFczFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E19C32782;
	Tue, 30 Jul 2024 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356458;
	bh=ZZxy6S+kBzDThfv+hOQsaTGhJTnq5KySnvHGuTK9Q4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgdFczFNtHQw+FwD3wIz+LWGCq8IKpl/Xa5+4TFAJWaa6lQLkAEEniH/i6kq70mea
	 L79qnUEQtpniACvbyP+qkapUjpKc6NyUOfwHTJqZlDKYlMx8Ob2zo1+cjfnaDDxP4C
	 8ndMG+rARrGo+oTojyXFffkwRSCCXvqlBKyweH+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 150/568] perf: Fix default aux_watermark calculation
Date: Tue, 30 Jul 2024 17:44:17 +0200
Message-ID: <20240730151645.738841242@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 43deb76b19663a96ec2189d8f4eb9a9dc2d7623f ]

The default aux_watermark is half the AUX area buffer size. In general,
on a 64-bit architecture, the AUX area buffer size could be a bigger than
fits in a 32-bit type, but the calculation does not allow for that
possibility.

However the aux_watermark value is recorded in a u32, so should not be
more than U32_MAX either.

Fix by doing the calculation in a correctly sized type, and limiting the
result to U32_MAX.

Fixes: d68e6799a5c8 ("perf: Cap allocation order at aux_watermark")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240624201101.60186-7-adrian.hunter@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index e8d82c2f07d0e..f1f4a627f93db 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -684,7 +684,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		 * max_order, to aid PMU drivers in double buffering.
 		 */
 		if (!watermark)
-			watermark = nr_pages << (PAGE_SHIFT - 1);
+			watermark = min_t(unsigned long,
+					  U32_MAX,
+					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
 		 * Use aux_watermark as the basis for chunking to
-- 
2.43.0





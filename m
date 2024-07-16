Return-Path: <stable+bounces-59759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 394F2932BA5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EFDB21F04
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B519DFBF;
	Tue, 16 Jul 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fmiuq/9N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264719F49E;
	Tue, 16 Jul 2024 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144827; cv=none; b=i0oxwsUlorm/jCmi9iSRPQUw8ojzVbgxYFONtGZngzIqvtm8LUkjepI3i9aBoDJESZgsU56cBxL2qNcINjFWfPyThBGTy5qnZv1IY7IE93T9sQtqaLNcK/1+knqQAEz753cfi7GQoughaHthFKemOX4W+fQbUJNSXBXIO+EC84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144827; c=relaxed/simple;
	bh=9yby9LMVPuH9HrZbKymz+HUdmYnnzHPkXVVFaF8kFnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd2se7SWhc+JsySnEhad28BBOovNCbFY12LVeM5kboMBI8sDnIJaVSxoEBXfIE3YgT+3ZYldIrlJn/R2I5R7aWPkcvp5NQue+IVMtTX5sTLdirAljA1QLAftZJWDyxPJT8NDEXT9f7BXnNpoPeqckwOybS6OzaL5FGNIog59kac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fmiuq/9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1B7C116B1;
	Tue, 16 Jul 2024 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144827;
	bh=9yby9LMVPuH9HrZbKymz+HUdmYnnzHPkXVVFaF8kFnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fmiuq/9Nj29mKlJBE/XV+ibaCcqD2kuIcGFFYQy+irjz9yrnGEJHevp4qDL7DQeiX
	 WtNq/yT5nieycBVYArIzNlOgARxNzvk4lA7d/scDWeVjO+b11ye8601rRQmU3tsCMJ
	 GIEel1zYeBx8JXLbJPqGjCS2f21en9b5nyBjcNsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 001/143] mm: prevent derefencing NULL ptr in pfn_section_valid()
Date: Tue, 16 Jul 2024 17:29:57 +0200
Message-ID: <20240716152756.040209448@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit 82f0b6f041fad768c28b4ad05a683065412c226e ]

Commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
memory_section->usage") changed pfn_section_valid() to add a READ_ONCE()
call around "ms->usage" to fix a race with section_deactivate() where
ms->usage can be cleared.  The READ_ONCE() call, by itself, is not enough
to prevent NULL pointer dereference.  We need to check its value before
dereferencing it.

Link: https://lkml.kernel.org/r/20240626001639.1350646-1-longman@redhat.com
Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing memory_section->usage")
Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmzone.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4f6f1fecc6f3..f8d89a021abc9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1976,8 +1976,9 @@ static inline int subsection_map_index(unsigned long pfn)
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
+	struct mem_section_usage *usage = READ_ONCE(ms->usage);
 
-	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
+	return usage ? test_bit(idx, usage->subsection_map) : 0;
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
-- 
2.43.0





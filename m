Return-Path: <stable+bounces-1085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D87F7DF2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC27028228D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A23A8D7;
	Fri, 24 Nov 2023 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1eqvu3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E139FD0;
	Fri, 24 Nov 2023 18:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70769C433C7;
	Fri, 24 Nov 2023 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850522;
	bh=LA0K6kitJT6VkO6bXrluqYV5/VYxLQwtw9bGanCHAc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1eqvu3Myti182lI5hQOPzUBQPeCEv5qMSI9B/R2gqHn0z1R1OlSn9yxb57huXypP
	 5xOS/YHpZNoXjyJ3LJmsxZlANEsIzBhu6RYJBz9mUegwTkMYYK/TVXesZD7kalQVb8
	 5xynePhJEsf3OMTkzPO4ODWz4TdrsEc3C4nshIRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Airlie <airlied@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Zack Rusin <zackr@vmware.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 058/491] kernel: kexec: copy user-array safely
Date: Fri, 24 Nov 2023 17:44:54 +0000
Message-ID: <20231124172026.410716699@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 569c8d82f95eb5993c84fb61a649a9c4ddd208b3 ]

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-4-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f987766..f6067c1bb0893 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -242,7 +242,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.42.0





Return-Path: <stable+bounces-48131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6368FCCC6
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D291F25585
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0DB196459;
	Wed,  5 Jun 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msG4FhQv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C48196457;
	Wed,  5 Jun 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588950; cv=none; b=cdSwTbeFIs460rf7CbHXVjF64yk7vnOSefCbXcl36Evubj/SRQ2kYleURrUqY+HKKzHbqA3HHs2xsBbY6D5oc2LWi3xT9PSlftResRxDzFHxzE9DoLfOwMwCZyemoCrgx9ZNry5ekMTLItoUHbals2JFTODxmofrarAlbywyjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588950; c=relaxed/simple;
	bh=IGgKpx5j1MkOyKp+cg7XNRPiZbHX1nqPZwkHTCb2kNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbS+EiV81ucYXiHrsgo5Yw+onLKyzV3CVBGUGf2XYjFpw2UGLxtr3OhKltc0ymrdTeXkbc80CmPPO/DybQnJFfagBf/LcKdlBTZz+fmuaZ2BIPQBaP49x2J6ipe4T92aCIm+vTG4uEF387tEBVUxPHAh4XrXw7+RESpDydLgKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msG4FhQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B843CC32781;
	Wed,  5 Jun 2024 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588949;
	bh=IGgKpx5j1MkOyKp+cg7XNRPiZbHX1nqPZwkHTCb2kNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msG4FhQvxob4bhVwBzmsiH0lXTHWyvxOIsr0X6t1nQ0MSHSwryREx7rKEjlZtDf5h
	 P49s+HtV6VQe0n2jDteXwrdc4PQuANjguPgz+hSLUFJr2aGfWYP6VgUkhK4+3+PBGS
	 Uz8JWHotnojCKvZ7zIIQOFWKlfWVeMxaMtGACCfdaVm1jvmB/xICGXh5fXxXMCj+Ze
	 hir9RMgXBv77fYyfLkvve9PJWFwq4Ec/CYNxZiZZKuQPIx/dByZ7AkPj3xdaKQg9Im
	 eLwmD39Kxg8ShRT+p8hLUy6PiFKveQm/5uif3uv7SxVmaHn/m7y4a4Z40rncfWF0DZ
	 k8qpQCS4yAF4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Jan <zoo868e@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 04/23] connector: Fix invalid conversion in cn_proc.h
Date: Wed,  5 Jun 2024 08:01:47 -0400
Message-ID: <20240605120220.2966127-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Matt Jan <zoo868e@gmail.com>

[ Upstream commit 06e785aeb9ea8a43d0a3967c1ba6e69d758e82d4 ]

The implicit conversion from unsigned int to enum
proc_cn_event is invalid, so explicitly cast it
for compilation in a C++ compiler.
/usr/include/linux/cn_proc.h: In function 'proc_cn_event valid_event(proc_cn_event)':
/usr/include/linux/cn_proc.h:72:17: error: invalid conversion from 'unsigned int' to 'proc_cn_event' [-fpermissive]
   72 |         ev_type &= PROC_EVENT_ALL;
      |                 ^
      |                 |
      |                 unsigned int

Signed-off-by: Matt Jan <zoo868e@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/cn_proc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index f2afb7cc4926c..18e3745b86cd4 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -69,8 +69,7 @@ struct proc_input {
 
 static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
 {
-	ev_type &= PROC_EVENT_ALL;
-	return ev_type;
+	return (enum proc_cn_event)(ev_type & PROC_EVENT_ALL);
 }
 
 /*
-- 
2.43.0



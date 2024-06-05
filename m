Return-Path: <stable+bounces-48153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB658FCD09
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DBB1F21C04
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E91993B8;
	Wed,  5 Jun 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hysBa1kQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB451993B0;
	Wed,  5 Jun 2024 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589005; cv=none; b=LGyZe9nCDth0kTF/9Yr1ze5j/UgHsVHi9dll+89hMiiTir3pAPMvzlJGkV7T3kdUi8yTimcY7qow7+II5vdD07G2l6rGMoAykJo9F+ONs+svwH8aQiW4p5LN6DR2/uUd/AkTNAVpc62fsm0kZZ9gbQ35FCY8u76CfMa4iI7Z9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589005; c=relaxed/simple;
	bh=IGgKpx5j1MkOyKp+cg7XNRPiZbHX1nqPZwkHTCb2kNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBHpSLx1NIYb6cqZzMlWkA8RcYt9e1wpGvKJb/9pH/zem1ed+NAi7AZT4gh4lfCDCHscDCqrDshkyo6Q1A+8876/X/zXQDSPf6CqNzBRvpqk4+KrPlPi5yMKT5bQv3tpUp+xCrPSI9kDApYhYhHudk9kkOcWie73u45Nq9e7kyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hysBa1kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24BAC3277B;
	Wed,  5 Jun 2024 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589004;
	bh=IGgKpx5j1MkOyKp+cg7XNRPiZbHX1nqPZwkHTCb2kNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hysBa1kQ3yVT+0xayW/X2DvC3+pa2+KWmA+hkKTX7NxKPwm2d+9GAUnowT4IkUPF3
	 RWHmneIi1OHSACefQd1YFbMBWFZ86cBoNyzJfF5kfphrs4zWxIghMtGvpczCk4d5/S
	 Wh7t1Ci7DTqSCoofL9jwh5bXf6mTf7pWiQHXdaFSP7OjvphCcw3+iUUr87AgXzlKZK
	 WienSsBAYn7zxSkjwEimrEDm+99F6X6hk/Etu1lEI1no359m4LaYIl8ebXZSBLBrht
	 ugbeP/5Z21gh4SFIrf9Hc9BzWdj01V9QtdXjKv+G+IRXQUIpVGklH3eK0RsdG1jdld
	 FQhQA2LPQQs2w==
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
Subject: [PATCH AUTOSEL 6.8 03/18] connector: Fix invalid conversion in cn_proc.h
Date: Wed,  5 Jun 2024 08:02:53 -0400
Message-ID: <20240605120319.2966627-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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



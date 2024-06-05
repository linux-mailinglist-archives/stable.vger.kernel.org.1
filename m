Return-Path: <stable+bounces-48171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7D8FCD52
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B4E1C235B3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBC1C619B;
	Wed,  5 Jun 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msLWi3cc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643F1A3BB1;
	Wed,  5 Jun 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589054; cv=none; b=ptwpX4LN4ViCPCqEzGZ+pTX7+3/kGwoX7KKrBzXeRHg9PXwLL/mOIgwI6ugV7DyM6UeyuJKgxGLwhe4l8NjNpkW/t1AOF0GSZ4p1fsy+wmBsasetqHkuI5EFv116xYNskOda7CPIWroe/UXQxWFjUSBIjGh6bPFNDTEhCojmBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589054; c=relaxed/simple;
	bh=IGgKpx5j1MkOyKp+cg7XNRPiZbHX1nqPZwkHTCb2kNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9MFS3o6O+gqoVIQUHjf0AGVsauu67qoQ7oKaQPBc5vprRpUTE3fmALkrnn3LzTTPEqnOy0VqbuuezGS+2MoNnxa4rV7Ln0NaLjs3dPENlPv7yvblpWwScityrVwmtMNcBzKLFPiClISjYjQdAD2iK1Io1U6JETc1/IVnb1h7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msLWi3cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B07BC4AF09;
	Wed,  5 Jun 2024 12:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589054;
	bh=IGgKpx5j1MkOyKp+cg7XNRPiZbHX1nqPZwkHTCb2kNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msLWi3ccV/3Ru5YBzPqbhzcYAFjt9Z6G6P9Afw8tATAErSti3DSrxUOTd5haU/5Db
	 yBeOp/5Hgw2pqsa3NuLBwkzMUGp/ANJrImLCGHllNnOGi2Gx580cfNM08YXr5Yo/hc
	 burj9ckFVwlvhZeQajQbXuGXC/IjAlDn2lXZII+PnB3HXHilQiQgEhKMjwVUuIPbii
	 XiAIPB3eUd6OfmO4DoZ18Ljyl7rvSHSWzyZJXPsyLrybWu4jxnlhVKtCcufBCh8nwR
	 d1MX2576nsEwvEd/mJzK+5jMnRnfr6Z45d1DP1+3Xdv1g8y4jgMvBSKFk3HAfawCpB
	 5Y0JMNAlm2HQw==
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
Subject: [PATCH AUTOSEL 6.6 03/18] connector: Fix invalid conversion in cn_proc.h
Date: Wed,  5 Jun 2024 08:03:42 -0400
Message-ID: <20240605120409.2967044-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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



Return-Path: <stable+bounces-158082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32239AE56DF
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C997A993E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F50223DF0;
	Mon, 23 Jun 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1G8agq4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA42192EC;
	Mon, 23 Jun 2025 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717438; cv=none; b=VYiX0WX0ONNNqq+fXcBPa1Mc3nrfEdz1X/YPwHB7+sc24k/HOu0fQmOM3eaRNAY9HvFk1H+gi3nzx4EVWlQTVTPr3nhNj3Csrf1aZ4iYrCIOFh3AI76YZMOBe3X76jNrJieEhloX3/1MI2Oz+8dCRiC1LU4yhC6if5W5ioKhs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717438; c=relaxed/simple;
	bh=+bnaW4+QsQ4YVbK7cPPljAie48omWvWWfcMosBxEB94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTWymImfowA4cVKZC88tuSSkwrEGoBA+TvJJo4LNdZlRfpDteBzLvzNX2aJRI2BVv3rzO2JaHgBePBvPkbNuutfB1pzYov3HqbYDUW1Ml8ZCpXFEV9ARkFiP2LvLd+uYMB5E/msTxY5aHS3eL6y6pChg3UOMUYgTUYvCD4r247Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1G8agq4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A615C4CEEA;
	Mon, 23 Jun 2025 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717438;
	bh=+bnaW4+QsQ4YVbK7cPPljAie48omWvWWfcMosBxEB94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1G8agq4nECjG8MnShLPcRRPCeZZ2sdAV8ejRBYex35xHUlam57X6QRAIhFZMcuj1N
	 Pq1HkYbpRI6lGXpY8dBvSXEUO2cHsN1nKQXWyMQoXpV7/Z+xBd9LAkRFgZ0DdWnOdU
	 RUqvTQH/rYlJMa2M6mUhT8xA4oAZoMOkIRtKibj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 426/508] sock: Correct error checking condition for (assign|release)_proto_idx()
Date: Mon, 23 Jun 2025 15:07:51 +0200
Message-ID: <20250623130655.665572977@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit faeefc173be40512341b102cf1568aa0b6571acd ]

(assign|release)_proto_idx() wrongly check find_first_zero_bit() failure
by condition '(prot->inuse_idx == PROTO_INUSE_NR - 1)' obviously.

Fix by correcting the condition to '(prot->inuse_idx == PROTO_INUSE_NR)'

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 168e7f42c0542..d8c0650322ea6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3797,7 +3797,7 @@ static int assign_proto_idx(struct proto *prot)
 {
 	prot->inuse_idx = find_first_zero_bit(proto_inuse_idx, PROTO_INUSE_NR);
 
-	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR - 1)) {
+	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR)) {
 		pr_err("PROTO_INUSE_NR exhausted\n");
 		return -ENOSPC;
 	}
@@ -3808,7 +3808,7 @@ static int assign_proto_idx(struct proto *prot)
 
 static void release_proto_idx(struct proto *prot)
 {
-	if (prot->inuse_idx != PROTO_INUSE_NR - 1)
+	if (prot->inuse_idx != PROTO_INUSE_NR)
 		clear_bit(prot->inuse_idx, proto_inuse_idx);
 }
 #else
-- 
2.39.5





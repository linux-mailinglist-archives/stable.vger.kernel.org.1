Return-Path: <stable+bounces-129007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB4A7FDFB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617CD3BEE51
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB5B26A1AA;
	Tue,  8 Apr 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W8e6VESz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C426A1A3;
	Tue,  8 Apr 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109867; cv=none; b=Q1L36dh0A6WIvwRJDWv8p7O+unVEfhUnOIdbj5MKdadepGLMDasRL8sT9LR0mHhybQXWrTNtI1zZupLf6c+VuA5oZ3P1RuA21ovC1dSi6kfbq3TorgwcH26XYAUYSprdZ6NFAvjRuAa3PRNmFB32FpQvzEd2YA/Ogq6JP2wNlhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109867; c=relaxed/simple;
	bh=fmYA4/LG7tH7n9qZK0dkKg3pfNeseSVGdop+RMWJ5JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYGzetiR+Ld2K9Dkp3Miqt8pkAdeB/ZPonD4J2Wra3CcMQ4oNcywTvzBQPCvmGIYoA+6fcLOahjBnspcX/g+OBoWvHeLEz8Q28ZE8MdEgKf9YO7xx5B2WOc5whPs3FCPtFXtYdxE9HZIO7uZvUd3s6HRPt36gMpQxcrrHM0Ppp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W8e6VESz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB717C4CEEB;
	Tue,  8 Apr 2025 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109867;
	bh=fmYA4/LG7tH7n9qZK0dkKg3pfNeseSVGdop+RMWJ5JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8e6VESzjRKLQQuPOKeQxbqfY2WPxsVK5eI0R51eILa9/vphGYY08On1Yb9l3r0/V
	 xsXmUY/dPjbuDfFD5mJO5p5d03oUyaArml8YBQk7gOWv0lOLEmojwgjzRqtYrZrs8w
	 eM6JFc7YllrTJFJqZIX/oj39ujrfwPs4WuCahAlo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <linma@zju.edu.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 080/227] net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES
Date: Tue,  8 Apr 2025 12:47:38 +0200
Message-ID: <20250408104822.790158710@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 90a7138619a0c55e2aefaad27b12ffc2ddbeed78 ]

Previous commit 8b5c171bb3dc ("neigh: new unresolved queue limits")
introduces new netlink attribute NDTPA_QUEUE_LENBYTES to represent
approximative value for deprecated QUEUE_LEN. However, it forgot to add
the associated nla_policy in nl_ntbl_parm_policy array. Fix it with one
simple NLA_U32 type policy.

Fixes: 8b5c171bb3dc ("neigh: new unresolved queue limits")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Link: https://patch.msgid.link/20250315165113.37600-1-linma@zju.edu.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f04ba63e98515..37f7bcbc2adcc 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2181,6 +2181,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
+	[NDTPA_QUEUE_LENBYTES]		= { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
-- 
2.39.5





Return-Path: <stable+bounces-150338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30EEACB7CD
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6954C3FA0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C24C236A99;
	Mon,  2 Jun 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xO/jo3gg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC492367D7;
	Mon,  2 Jun 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876804; cv=none; b=TUagJ/smlLlUGnRQ0ct6SqFzcXtg+5/6sf6OCB3v+9gAj+5xlXr+rwWR65ZGsuvTTMMMDsKiOKHcAo+yWYBhbB4R9RfNo4ZpaMmp6TPzEw4zo5PBP0VDZEbKNKhRTL612uY19hVuL3Q3uCqeVxWcLTbSWLLV5M3FASTeoi62MJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876804; c=relaxed/simple;
	bh=2UIZO8Fe2jHMw4L7LRbhwPBOP186wahZCjQ9p+dpdXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC4OZDBSJZZD8jtN0mXc8/EbMR6RklucmhM0OwNUWG2jKR9A40JiQMufWmUBft0mGMSyJamnv8kaHrSZsdDY8N2hTNrz/DPrSJ95NvHryDjNtneoM2qXc6cZ/8M2MPIOJUvNn/ADOvdL7LI4DvC1xL/hzYrkgulBxR69JkbxHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xO/jo3gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E63EC4CEEB;
	Mon,  2 Jun 2025 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876804;
	bh=2UIZO8Fe2jHMw4L7LRbhwPBOP186wahZCjQ9p+dpdXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xO/jo3ggD1besv0Z3QMohA4ipmzB/EKjNkhh6o+L97advSaMd4lR69dVyvlmEI1x7
	 +E7OPcMCXhiSDHnKU5a3ZC7rwZ11yCkLmpEX4Szh87x/00fKamlDR1nFtlQp8ykpFb
	 EDoD5g3S6YXBfAX2+IZr6p3hDXco61iMxlYXoXsE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jing Su <jingsusu@didiglobal.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 039/325] dql: Fix dql->limit value when reset.
Date: Mon,  2 Jun 2025 15:45:15 +0200
Message-ID: <20250602134321.342947345@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

From: Jing Su <jingsusu@didiglobal.com>

[ Upstream commit 3a17f23f7c36bac3a3584aaf97d3e3e0b2790396 ]

Executing dql_reset after setting a non-zero value for limit_min can
lead to an unreasonable situation where dql->limit is less than
dql->limit_min.

For instance, after setting
/sys/class/net/eth*/queues/tx-0/byte_queue_limits/limit_min,
an ifconfig down/up operation might cause the ethernet driver to call
netdev_tx_reset_queue, which in turn invokes dql_reset.

In this case, dql->limit is reset to 0 while dql->limit_min remains
non-zero value, which is unexpected. The limit should always be
greater than or equal to limit_min.

Signed-off-by: Jing Su <jingsusu@didiglobal.com>
Link: https://patch.msgid.link/Z9qHD1s/NEuQBdgH@pilot-ThinkCentre-M930t-N000
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/dynamic_queue_limits.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index fde0aa2441480..a75a9ca46b594 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
-- 
2.39.5





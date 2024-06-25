Return-Path: <stable+bounces-55334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F645916326
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA242811A7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B0014A4EB;
	Tue, 25 Jun 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TRzrSIc4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B956B12EBEA;
	Tue, 25 Jun 2024 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308597; cv=none; b=PDI/b9RjK2/GgxNlUvlvFSlklR65yXMjwA8R++y51ju85/7Y8TWHui6f05JRGpUJs8ya3h6r+reIoK3PwDlsTRTpOHc2qwsRowHD1VdxsJ7/+aonVPQgPozxRxk8NCiZ0RdnbSsb/x1Jn6c7e+ixzP2Akr3s0m2QAL5xBUcLLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308597; c=relaxed/simple;
	bh=0y8ap0uZ4SNSSa0xpFXmgFSemcUNb/vIsXp4OWeSL8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRF2B8F/RlOdA1AhhPB3rYhMv0L0x1tPH+U+jSHTS0IGNI1ze+KLNcd8BUXpEfKQSQ92mNtHm0Sy6kW0hKY1zcqWkwo2BbmPMgjqC+EpI9vnDTIC9N14Y8wslQdgcdcLTLg3Ww/ggZfTjnpvpSuWjtfQOz94Ijjyn6B4g3Zq7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TRzrSIc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42248C32781;
	Tue, 25 Jun 2024 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308597;
	bh=0y8ap0uZ4SNSSa0xpFXmgFSemcUNb/vIsXp4OWeSL8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRzrSIc4RRoGeyWeuIwT1aQC11odwBi9J5HCmYtsLAREmi9tx820RE45RiICmf1+m
	 GbgWBwE82GYBVO+sXYDBs9tSCDUBwwSbJkHVxVu855CRNF8UTrnR2XOu93qIB3vN6O
	 n8bP4qrliylUZveHJWGOP2mB3TEO9kjOnjgx0kSM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 176/250] RDMA/mana_ib: Ignore optional access flags for MRs
Date: Tue, 25 Jun 2024 11:32:14 +0200
Message-ID: <20240625085554.807023448@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

From: Konstantin Taranov <kotaranov@microsoft.com>

[ Upstream commit 82a5cc783d49b86afd2f60e297ecd85223c39f88 ]

Ignore optional ib_access_flags when an MR is created.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Link: https://lore.kernel.org/r/1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mana/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
index b70b13484f097..13a49d8fd49d5 100644
--- a/drivers/infiniband/hw/mana/mr.c
+++ b/drivers/infiniband/hw/mana/mr.c
@@ -112,6 +112,7 @@ struct ib_mr *mana_ib_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		  "start 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
 		  start, iova, length, access_flags);
 
+	access_flags &= ~IB_ACCESS_OPTIONAL;
 	if (access_flags & ~VALID_MR_FLAGS)
 		return ERR_PTR(-EINVAL);
 
-- 
2.43.0





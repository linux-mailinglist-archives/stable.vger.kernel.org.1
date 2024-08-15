Return-Path: <stable+bounces-68081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428A95308B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D929287918
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F6719E825;
	Thu, 15 Aug 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZpz0yUW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7807176ADE;
	Thu, 15 Aug 2024 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729437; cv=none; b=bH5bVAOnvlHQXTvWBf+SK3N0RoillxGUwMAj0oVgz4r6PV1DZVn2H7eCeNNOpb1Sd6DP6YUpbgv7r92Fg/B2oz18w7PXW3GVjVxsb6x/uoXwgUkLDoR5+pZowauodM5yurUy4UTkvBAg4TXrmTh9ARBllXnNXbZz0GB+ILK396A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729437; c=relaxed/simple;
	bh=6PFlhknqmVyQOgnF/nX+2Zs/9VzZrkPddalVPUUC1V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJYo0OhRk/ZUkF770kpdThtnUmeEOtmI8xLGOPq5G3xOCrOvgpcjPGX7np+cT8RqYvzczv43CmWnIV8z8XYyjslVqIgyfjdmudrRAVha0vvFPqMasS6m9zyYxtLevd7ryAcQ/Rlz+gkaPV7julFfTQxQ2VvbU5mJutHxv429PV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZpz0yUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F27C32786;
	Thu, 15 Aug 2024 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723729437;
	bh=6PFlhknqmVyQOgnF/nX+2Zs/9VzZrkPddalVPUUC1V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZpz0yUWVQmuVCHhcnUBCn1v/bdb3Cr0whXpxUuXCGMcNmdonSMaolccgZMxS1A4l
	 G8UOREAYmaKxZtLiHrkg5mb84GTlbxagICuvzRshjM6NWWl2qGR/44SSiofs6TS1jo
	 R6QnvRtlLnJGH1Twhr6dHOqhX2TtM4oN5ZIC0uoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/484] netfilter: nf_tables: rise cap on SELinux secmark context
Date: Thu, 15 Aug 2024 15:18:44 +0200
Message-ID: <20240815131943.833229407@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit e29630247be24c3987e2b048f8e152771b32d38b ]

secmark context is artificially limited 256 bytes, rise it to 4Kbytes.

Fixes: fb961945457f ("netfilter: nf_tables: add SECMARK support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 62cc780a168a8..c0edc1a2c8e65 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1320,7 +1320,7 @@ enum nft_secmark_attributes {
 #define NFTA_SECMARK_MAX	(__NFTA_SECMARK_MAX - 1)
 
 /* Max security context length */
-#define NFT_SECMARK_CTX_MAXLEN		256
+#define NFT_SECMARK_CTX_MAXLEN		4096
 
 /**
  * enum nft_reject_types - nf_tables reject expression reject types
-- 
2.43.0





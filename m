Return-Path: <stable+bounces-57215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E59925B85
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196D11F2933E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D13188CD3;
	Wed,  3 Jul 2024 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gAmWliqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAB188CCB;
	Wed,  3 Jul 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004205; cv=none; b=HEgQXxLUEZCEzycmhtGnJKLjaf6i16eZm1EMLalO/0LN2DjQ0b8R4CcJ+9Ux8XtEvAdNCXAZqBcws+D8VJmguPy5SLq97KIR+DA6qMji0mCh3RFPOkbVlQh/xOKP+I7FU8y/9YhsBxmPDl/R6cjkx+ztrXe97OtxXhmceD1hi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004205; c=relaxed/simple;
	bh=0n+w6JRHLAUjb1WQMrBNzUlAXQ0jK2PbFlOYwl7IVWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktONUhxUhHZqJz4bJZuEdRTgxEQxX7c17yIXVVPXGotJ6SkoGpSN8jMKeP6XfZ1Q7FtKn3+4OvZTreZSe3nWuMDjYs5yvSHOAottVXEdlQocWJdEC6Hd8nhko5Fvb1G5y5Hy9Anmel2FqEf5APINsiGIwZqgw0hvs23qeXz4Ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gAmWliqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACEBC2BD10;
	Wed,  3 Jul 2024 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004205;
	bh=0n+w6JRHLAUjb1WQMrBNzUlAXQ0jK2PbFlOYwl7IVWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAmWliqkkqkFEG+m3RdU1+5DwOZ3GMfLVMWaDsuLMnPAvokksBqmZw4dW7RG8qQhV
	 cRVa/2gKZAdTfasb+SRdJzMup7oYvFPu0idCIR6VwYIxSEjJzaydwI+dMP336rQOqO
	 maDHErCHABcEKCCNKZJ7/JoMmYmvuJt0/mLl2eIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 154/189] nvme: fixup comment for nvme RDMA Provider Type
Date: Wed,  3 Jul 2024 12:40:15 +0200
Message-ID: <20240703102847.283339715@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit f80a55fa90fa76d01e3fffaa5d0413e522ab9a00 ]

PRTYPE is the provider type, not the QP service type.

Fixes: eb793e2c9286 ("nvme.h: add NVMe over Fabrics definitions")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index dd2801c28b99c..bdd628c8182fd 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -69,8 +69,8 @@ enum {
 	NVMF_RDMA_QPTYPE_DATAGRAM	= 2, /* Reliable Datagram */
 };
 
-/* RDMA QP Service Type codes for Discovery Log Page entry TSAS
- * RDMA_QPTYPE field
+/* RDMA Provider Type codes for Discovery Log Page entry TSAS
+ * RDMA_PRTYPE field
  */
 enum {
 	NVMF_RDMA_PRTYPE_NOT_SPECIFIED	= 1, /* No Provider Specified */
-- 
2.43.0





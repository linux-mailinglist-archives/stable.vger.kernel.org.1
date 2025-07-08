Return-Path: <stable+bounces-161080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF82AFD345
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F59F16EDF5
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23FF2E266B;
	Tue,  8 Jul 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvljihpG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF92E0B4B;
	Tue,  8 Jul 2025 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993538; cv=none; b=pVeW3E+YZzvVAVj3Vf1qcNDn8puU0qd72ae5Wuw5wRYEbxWvyQNJ5BEPcjFgwsyavY/THl/blD3Qv9tUElmZ0fbb8T0o63DS+bXEQbkCtPpfS8Dzak0CBkrfV6hwn+tF5BmRGHmp5DoJ994aDSIuuN+w/qoRSRhQgxuaom+JM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993538; c=relaxed/simple;
	bh=xPkomWnSu9VHzzUjRBfRKDDvOetEmwr757+s9P9+lmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh/LrBw8gVnXG1NC/gf2u2b5d/jaN432HKn1AL7x9RKiCClDk24G/rj7eF8LBYMZ7J0CKHCqGrfza1GSbPkAbQrGzcxztkcePO9Jfaj8BrAWlH4HmfkArqEFK2s4g8rNrv5Ezt1ruDQuJ6DX7DhAHX3Xpih8L9zVDM9KgKJSzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvljihpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CDFC4CEED;
	Tue,  8 Jul 2025 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993538;
	bh=xPkomWnSu9VHzzUjRBfRKDDvOetEmwr757+s9P9+lmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvljihpG2haBd0yb3hkI1/LId0M2LsYqMW+pQs2mzNkRllziU343kmfTHzBz38S4u
	 ZwxjKAiT64RVUa5Va5u6QAugOKm3rRmFO6BsaGl6dtmvY3q7IFPSFzfyl30QBCcrEH
	 VxxqYuXklyfgj0yZS+uL5uU9aokfN21ZNSuS3ylY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 078/178] nvmet: fix memory leak of bio integrity
Date: Tue,  8 Jul 2025 18:21:55 +0200
Message-ID: <20250708162238.716720294@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

[ Upstream commit 190f4c2c863af7cc5bb354b70e0805f06419c038 ]

If nvmet receives commands with metadata there is a continuous memory
leak of kmalloc-128 slab or more precisely bio->bi_integrity.

Since commit bf4c89fc8797 ("block: don't call bio_uninit from bio_endio")
each user of bio_init has to use bio_uninit as well. Otherwise the bio
integrity is not getting free. Nvmet uses bio_init for inline bios.

Uninit the inline bio to complete deallocation of integrity in bio.

Fixes: bf4c89fc8797 ("block: don't call bio_uninit from bio_endio")
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/nvmet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b6db8b74dc4ad..85e50e2981742 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -857,6 +857,8 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 {
 	if (bio != &req->b.inline_bio)
 		bio_put(bio);
+	else
+		bio_uninit(bio);
 }
 
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
-- 
2.39.5





Return-Path: <stable+bounces-57841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914F925E43
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409AC1F25ADF
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB86E5ED;
	Wed,  3 Jul 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fa5vhA+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205317DA03;
	Wed,  3 Jul 2024 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006094; cv=none; b=aJ4EQ1TEdGJ2Y+HgsSSCb1956k9NyCFmgJpKkVp39QcGILoLVoo8vz5FQ5ubYZRIlXNcP7wZ+MG0LCcqKeAYvcHtd1WcGnD8Gce8huq3TA7e4GeZvgigLHqSWONa8M0viXb6s1EYUwJtJCx2nvA1P5xbdhYP/sp2KqE+uzLXzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006094; c=relaxed/simple;
	bh=faVeVsNsskg8mQE35LtFVG4wqooyKFdMeWr/Uh17wjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FodYrqkiOfKBM8cRyFxGAMfe6lDaOzrpdeOgX7wuDODPJLIaYnOFfydmCyuDrJYZBoVyCYXyrhN1xyB/MietfPF0FxBFemPJAn7jBIfTHrKihjHKlfZf8IIZzXBz0xdZZ49n0u/nR1UkJ5mFJ7RfRwwOggI4B430kdhNk2WQ/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fa5vhA+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65964C2BD10;
	Wed,  3 Jul 2024 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006093;
	bh=faVeVsNsskg8mQE35LtFVG4wqooyKFdMeWr/Uh17wjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fa5vhA+jjhW0OpjRKm2HHea/wf3fo7rj9qDHSGV+Xu7xUBImniK/ns/HyE+cD5mlx
	 UvXg1L+/e5sZ8if4V1KPlM3V1FOOqBPPAUuhT5QiIoRWhcvrw9XDsv2eWRcD0Du9xp
	 L9ut90q70px7ha6Q+C/3iUplfQasWkmSMR0W2RGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 298/356] nvme: fixup comment for nvme RDMA Provider Type
Date: Wed,  3 Jul 2024 12:40:34 +0200
Message-ID: <20240703102924.389448293@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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
index 461ee0ee59fe4..537cc5b7e0500 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -71,8 +71,8 @@ enum {
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





Return-Path: <stable+bounces-107737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A7AA02E1A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8190A7A238C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1901E00BE;
	Mon,  6 Jan 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgpK7kH0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF81E0086;
	Mon,  6 Jan 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181741; cv=none; b=u2IYu02XJUq5lZ989e6jNf7fVhX4SUImdjyLkUg/YtD0iAL+wN1Q5lgBTgZ16wqeWLBSjmtqzTB8b0/lodjwa53sK073PBVpybUHQWYo1u44OpnPv+Z4dgTZhp3iWpHt6WXj+C3mwsSRP+5HGM2cXaGuLmcMLOq/dUYdQf/2qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181741; c=relaxed/simple;
	bh=lTJDTcXnvPTSTl/j45uMusCcXgFltz9HMFI2KWBKckg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kodGXZ6uAw8YCEPHC1AgnXpsCqZpjeXarwP4Ff4okIh7mJJXuuzNHeN76ibabh5nT1d6kwnCTdBQ05XfACZw0XjBvWwIeZjK0vkQlFS8qg8FJ+4WJ7BqjtnNngauIo2oY7ctJPmWUXZU2pDbEfWHfFYoM+GFPmjhPu1yHTB1jOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgpK7kH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CD5C4CED2;
	Mon,  6 Jan 2025 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181741;
	bh=lTJDTcXnvPTSTl/j45uMusCcXgFltz9HMFI2KWBKckg=;
	h=From:To:Cc:Subject:Date:From;
	b=ZgpK7kH0eGfrLbfxxoZyv0+eoVjJ1gH9IvrmW3KGNdNCBf5wuE8pWXzBtLU+ATz0T
	 fkrxM5MLKR/f5EcCseP8Q2Kwehmwne/Ju6yBL5tTiYZyjWLbYKbskwPTtS2yWtf0DJ
	 ko0tIMezvnMnYBEY4dU3qGlyaNcV/E7OCNOqyUko56bLkLJP50AgrraD5URiXwT8ni
	 DzN5BNQtZRcXy1b9v3ROM6QPIDjrj8OxtshhFz/7V8lapx2rUOlWhkjkOe/5TRrel8
	 E7yj1WRtFzoMxr3Fvb0OfiXv4kdgNUfLFGHgzwAzGhyRqa6PDFkmWuShbdTIFcngfV
	 N++Xu2BWoTNqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:18 -0500
Message-Id: <20250106164219.1122426-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.288
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b579d6fdc3a9149bb4d2b3133cc0767130ed13e6 ]

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 32008d85172b..40afe3d0599d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.39.5



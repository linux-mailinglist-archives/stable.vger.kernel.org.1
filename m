Return-Path: <stable+bounces-107734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B9A02E11
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FE6188761E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9331DE897;
	Mon,  6 Jan 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDZ9x7yL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC21DF977;
	Mon,  6 Jan 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181733; cv=none; b=h4OcuMf9a/8O6PAEz6KbCJhOrI5O747wRnuk4/7lKp9+33noy1YLFVbqRIZ/0Mi/zn+UBV6UYeAU2NDQgIfhZKGqYUB3A6+PRJxea1JivDJ1XfXbYLUUyHU9JfVXU8t5ZD+qD3C0HwLpP/XlBGD1aYtP/YpayThjJjLJomZ5+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181733; c=relaxed/simple;
	bh=MMqHdZJR+afNkPyiAkcoQt7WMqJ2INQ4U0BUyM+ywFs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E0l7Hmp3R99Oa9ExgrtyHnRLR29NVd+nDG+Ir+BOnsxBH1UFqvGXft86R0zsCSPA+w9QM/Bg2UqbLhuhGTPv6ojM+nGJRpygXbJlkXz5STii3HkN+MBUHPO+l5rsLRmQFRR+YXoyNyd/XnserWgBdfajW0+3e51KaVdm8MXJBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDZ9x7yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E649DC4CED2;
	Mon,  6 Jan 2025 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181732;
	bh=MMqHdZJR+afNkPyiAkcoQt7WMqJ2INQ4U0BUyM+ywFs=;
	h=From:To:Cc:Subject:Date:From;
	b=fDZ9x7yL9Y1NFpt8fyBgZldCELCzLb/tgh1pDV3R8U5n2Jku+ncTnsEymSZOqAe+k
	 YgZAxirY9KOPDqmkIGFruHycZaENoexE6sUdgnHrWr3dX9LRMI2zdFepnOa5YRBe82
	 +l/Zm9cOhIPPYz2zOCDJSxi8siiNx565VgD0bpeIfvWAYlZMggOvGuCXHbTe0WhijT
	 Hn+omk+cjYxjCa52K/mJXBDETNtXeQCDpQ2sKr6cw6+DLzNoA8fzJ/Hvz5oWx/qwDb
	 M+XnFWfFPksYjoP6sxkAjKRVrWwR9xYdlpeR6uxnWyX4xFM+jKMV3POQiKohfApoEO
	 6ZL/p0cx4l30A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:10 -0500
Message-Id: <20250106164210.1122348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.123
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
index c2d6cea0236b..ada58a4d0d0c 100644
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



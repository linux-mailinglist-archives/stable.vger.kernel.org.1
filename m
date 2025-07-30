Return-Path: <stable+bounces-165286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C464B15C6E
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11B23AC8A8
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC7280033;
	Wed, 30 Jul 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DzC4Tg62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01722156D;
	Wed, 30 Jul 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868525; cv=none; b=OSPvtQyP2tCSiVyBrZVmk5wNHQsUQXPXoxqiTh9Lao5AbdomJEMAbyvND0fBZ5eafVTEQ0z+jzUhhMI1Ndpz4qX8a61OyDCs2rdaz2H+qv0997Ov0nRZFuqrgQc4spZ765G8e8qbGnX/bjiRu+ater42Wsv7lPTcCofQeO0FU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868525; c=relaxed/simple;
	bh=H1KpBRkBezPjTF1ZKUoVv1ylZEOtiVYU7YhrZtElOPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUv0hB/xpB/sWaLZPEs47trpdgx29rw63HtD6DG1zvanDzAW93TpIVWZfU9tTJdU2VdBBsAJymy2TtDWygSM77QLEjeuZTNgM2s88E8+UrEoY8MEUd7tKyIhsLFzouXHxGg0jMtP99ml6xt+UFCr2sRMsKKMjPWIOkWIcJXjZQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DzC4Tg62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F0AC4CEE7;
	Wed, 30 Jul 2025 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868525;
	bh=H1KpBRkBezPjTF1ZKUoVv1ylZEOtiVYU7YhrZtElOPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzC4Tg62JG9G7nlCD5Y5iT2haZRoJoTJRCYkfwaKVKzDMzuZASqucAZv4QRruASYp
	 UbN0sV++c/5vu0loyM7Xwhc3HmatJCxYhMWZMPLFCrwEOFV2SZcEsyG204g5tvL1Tb
	 OD1V15nOnRWuXD0IEndSy0jJqd4doxTLA2sOiWBo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shravan Kumar Ramani <shravankr@nvidia.com>,
	David Thompson <davthompson@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/117] platform/mellanox: mlxbf-pmc: Remove newline char from event name input
Date: Wed, 30 Jul 2025 11:34:40 +0200
Message-ID: <20250730093234.028417790@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shravan Kumar Ramani <shravankr@nvidia.com>

[ Upstream commit 44e6ca8faeeed12206f3e7189c5ac618b810bb9c ]

Since the input string passed via the command line appends a newline char,
it needs to be removed before comparison with the event_list.

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/4978c18e33313b48fa2ae7f3aa6dbcfce40877e4.1751380187.git.shravankr@nvidia.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index fbb8128d19de4..afc07905e235e 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -15,6 +15,7 @@
 #include <linux/hwmon.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <uapi/linux/psci.h>
 
 #define MLXBF_PMC_WRITE_REG_32 0x82000009
@@ -1625,6 +1626,7 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 		attr, struct mlxbf_pmc_attribute, dev_attr);
 	unsigned int blk_num, cnt_num;
 	bool is_l3 = false;
+	char *evt_name;
 	int evt_num;
 	int err;
 
@@ -1632,8 +1634,14 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 	cnt_num = attr_event->index;
 
 	if (isalpha(buf[0])) {
+		/* Remove the trailing newline character if present */
+		evt_name = kstrdup_and_replace(buf, '\n', '\0', GFP_KERNEL);
+		if (!evt_name)
+			return -ENOMEM;
+
 		evt_num = mlxbf_pmc_get_event_num(pmc->block_name[blk_num],
-						  buf);
+						  evt_name);
+		kfree(evt_name);
 		if (evt_num < 0)
 			return -EINVAL;
 	} else {
-- 
2.39.5





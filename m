Return-Path: <stable+bounces-128016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA97A7AE2D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B1B1761EB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466361FCFE5;
	Thu,  3 Apr 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDGSU0Q2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F381FCFC5;
	Thu,  3 Apr 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707771; cv=none; b=GP1f1R8VYXxweZiJmOCtletKJa8XexQ/nxqxR3dJXypHq80lJH6vXwfHVjTGEu8Zyr/uA+fYZ55Ri2HXH9OuFMWs6sPw5jupIIMS8xkLp4jZKAbS5TyxRqARkZATrlLhv885iis/qYHvPXa/fABTow6yyz//MxAelUqZ4ulS0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707771; c=relaxed/simple;
	bh=nt6uNGS/V0xt8u6wXzvWa0K5QDbu+5hTsn14iJypNpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDdAn4zcsLJqZNfZ9s9SbH4qxCsvsPM/iKT59xbJudu7J7zZnqDtEI9VAVYKkLnvIv17qif4AVhlX7d4ievgh0vL6ZNmDESKjKWY4WkMRixiqFbwqjfL3QA8zHUD4/lKzbXAToMFD6/YBqa2vBOHtKHekJvDNpsrqtxqTpcLBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDGSU0Q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CA3C4CEE8;
	Thu,  3 Apr 2025 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707770;
	bh=nt6uNGS/V0xt8u6wXzvWa0K5QDbu+5hTsn14iJypNpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDGSU0Q2HE2AkkWH58REQ37qvVbJK1NF6x6A1scyIyS5AAdAqm0EGWHXNBLJHu2ih
	 cvPkpMcu6qtxp9HSMwk3IQ0BCYrhPTNevHtOVOXSOT7fJCMiZbVXgqqjYKQ7ffYwub
	 GIPX8Nmm2vYR51xZTTZ6Jyo81Fh8WL/fKABGu4OvDDWTC2QVuJqnMmvUUc4BgqF3Y5
	 2iP6sIDqrsisZ2v0NKFZUN44NMJg5JVn9nGaBj8t7nL6Eyd/oU96lzEckNVXMW84gB
	 sZ3pbetxBXyqG6maOaYTBHMrhWhJiE4bar6JlxhGRRb9p/00cRidfkyZEoFYCFfBY8
	 I+4TGRllFVMdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dakr@kernel.org
Subject: [PATCH AUTOSEL 6.13 17/37] drivers: base: devres: Allow to release group on device release
Date: Thu,  3 Apr 2025 15:14:53 -0400
Message-Id: <20250403191513.2680235-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit 8e1ddfada4530939a8cb64ee9251aef780474274 ]

When releasing a device, if the release action causes a group to be
released, a warning is emitted because it can't find the group. This
happens because devres_release_all() moves the entire list to a todo
list and also move the group markers. Considering r* normal resource
nodes and g1 a group resource node:

		    g1 -----------.
		    v		  v
	r1 -> r2 -> g1[0] -> r3-> g[1] -> r4

After devres_release_all(), dev->devres_head becomes empty and the todo
list it iterates on becomes:

			       g1
			       v
	r1 -> r2 -> r3-> r4 -> g1[0]

When a call to component_del() is made and takes down the aggregate
device, a warning like this happen:

	RIP: 0010:devres_release_group+0x362/0x530
	...
	Call Trace:
	 <TASK>
	 component_unbind+0x156/0x380
	 component_unbind_all+0x1d0/0x270
	 mei_component_master_unbind+0x28/0x80 [mei_hdcp]
	 take_down_aggregate_device+0xc1/0x160
	 component_del+0x1c6/0x3e0
	 intel_hdcp_component_fini+0xf1/0x170 [xe]
	 xe_display_fini+0x1e/0x40 [xe]

Because the devres group corresponding to the hdcp component cannot be
found. Just ignore this corner case: if the dev->devres_head is empty
and the caller is trying to remove a group, it's likely in the process
of device cleanup so just ignore it instead of warning.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250222001051.3012936-2-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 2152eec0c1352..68224f2f83fff 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -687,6 +687,13 @@ int devres_release_group(struct device *dev, void *id)
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
 
 		release_nodes(dev, &todo);
+	} else if (list_empty(&dev->devres_head)) {
+		/*
+		 * dev is probably dying via devres_release_all(): groups
+		 * have already been removed and are on the process of
+		 * being released - don't touch and don't warn.
+		 */
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
 	} else {
 		WARN_ON(1);
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
-- 
2.39.5



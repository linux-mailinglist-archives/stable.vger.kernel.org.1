Return-Path: <stable+bounces-108484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1BA0C012
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF9E27A48BD
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B651F9AB3;
	Mon, 13 Jan 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEZDvJAv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A811C5F09;
	Mon, 13 Jan 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793303; cv=none; b=acA7AztwE9GqRJRbTd5346P6aFVXvT+8D+9cQAG8np+dD/psGwxdTSFYmSjmi4h44ttRZ/6WEWJLkeZcCn31NeKPL2pBZWxWMwTabbGz5WGMKJKEp94dzJ71pSHrZBBWX6Mts5bDznwzD6QbDewyD2iduwbskWw3y2txrV68P5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793303; c=relaxed/simple;
	bh=a4cveYbeG8/EhzEDZ7gLlkTYb4O/rdm9OQZaqmMmiIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nz6g63T3cczDXfP/rBENETCuASSolrSisKh5iJs5Y6hRXpft4QmTch12qGzQVafenpeaLHDyAAGyTeJwMes7nZpQQSvD141ghuR7oenD3irDFSPc5lGFMLJ71+/9Vn5BPPSSaCLlaG9oTnk4FXk1mkCUqY4T9FjSFANKF82NUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEZDvJAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23230C4CEE3;
	Mon, 13 Jan 2025 18:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793302;
	bh=a4cveYbeG8/EhzEDZ7gLlkTYb4O/rdm9OQZaqmMmiIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEZDvJAvwsmSWtxwo4oNPzVLKC4qbJYQVwO5yHYQo2vXHMDrvQHyWlzXCC9EByyyk
	 vPaK/QvxEkLj3nZgfYfO5HFHbilcyJ2ZRncINOVMK6SMzO7Quyb7fuZm9ba1V/wuon
	 XEZQi2Hxt4fKDkN8W6ERj9zGIq8jVUJq2KmnyBk6mjG7nOEP+p4VSKpWrG/jtTDMoU
	 9rMfHA8YECYIIGEfk2clSuMvJozfS8FoJevN/QFQmq7UypddVQfEEqspBgTq2vbCyz
	 i24Bs12UsKDm/qJnHSO4pHqWfZJO1A3/8vpuxXl+a3kJ+Qhgi4lGWNQIF22S7DtnF9
	 6Rkhp8cvs20yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 15/20] platform/x86: ISST: Add Clearwater Forest to support list
Date: Mon, 13 Jan 2025 13:34:20 -0500
Message-Id: <20250113183425.1783715-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit cc1ff7bc1bb378e7c46992c977b605e97d908801 ]

Add Clearwater Forest (INTEL_ATOM_DARKMONT_X) to SST support list by
adding to isst_cpu_ids.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20250103155255.1488139-2-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 1e46e30dae96..dbcd3087aaa4 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -804,6 +804,7 @@ EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
 static const struct x86_cpu_id isst_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	SST_HPM_SUPPORTED),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	0),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	SST_HPM_SUPPORTED),
-- 
2.39.5



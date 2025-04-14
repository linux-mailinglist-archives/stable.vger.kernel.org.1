Return-Path: <stable+bounces-132599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E6A883C1
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C1817434E
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F82DA90A;
	Mon, 14 Apr 2025 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyU8GyhT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E932DA905;
	Mon, 14 Apr 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637496; cv=none; b=ozTQ1hAtCjVOAMEsX2LFmfMq1lUkUnE0B9zRpkLY5e3B+4LCpbeOpH/jjnmGokkfpcxjzgKCzKOWJF7rlyQsz3BlO0+IMjkpq8AzJXmWO/PKMnfQov5+FzIfTU1UrYFhO9W5WcCgAXL+Qb4E72zlq8VSW6XO97bWupg4HLbWXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637496; c=relaxed/simple;
	bh=egGOFBMP/rOXw5Cxs3Jz8pNNyapuAC8uiWGLwRvlxuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXtAXb/TXdGq5CpybjX5j0qhHs3kmTZxveXndZSpZVveVe8mJYqoMuRPVJZ/O5WGfwKP1GinCpYLB6RoLaFiQXcBRDoliCeUaJJdUHB0niUB6Mg27NOfXxGX7g2ev/lk5ChmIra0al+SMo1/OgB5dgEFBJG/L9CwWdwJR6LhAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyU8GyhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D8FC4CEE2;
	Mon, 14 Apr 2025 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637495;
	bh=egGOFBMP/rOXw5Cxs3Jz8pNNyapuAC8uiWGLwRvlxuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyU8GyhTxBLNkDxjdbShnLzkoPzWJk77s+8Ki8zeiSGTnd2Q/OWLHrGoAx/Osrk5j
	 XpefLpsy4xZ4H47WZGoNdiewl/ZfZD/vloottH0eLm4CUGCD7jk/wySzVQ7MoPp6U7
	 qlNDAJFNIg+VqC67AIeJjt7qJDtJWg/Bqe44op2Oak4OzoVFPn+WIvHJowaD/w7EWy
	 FnfMN1mVI5j5C0roMBYa3W0uxlB1MEX8+RVqAXV69XFh+cpbvOnIJyX2qElOyxoqCA
	 C946ha060Yv8mKUFm/zfqUbHuDAeSwgbRgddztwR0t1LhvDhjiNSJupKu9PwGRsa7p
	 MJ9QP58Aqz7pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 5.15 04/15] xen: Change xen-acpi-processor dom0 dependency
Date: Mon, 14 Apr 2025 09:31:14 -0400
Message-Id: <20250414133126.680846-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

[ Upstream commit 0f2946bb172632e122d4033e0b03f85230a29510 ]

xen-acpi-processor functions under a PVH dom0 with only a
xen_initial_domain() runtime check.  Change the Kconfig dependency from
PV dom0 to generic dom0 to reflect that.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250331172913.51240-1-jason.andryuk@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 1b2c3aca6887c..474b0173323a6 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -241,7 +241,7 @@ config XEN_PRIVCMD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
-- 
2.39.5



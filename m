Return-Path: <stable+bounces-132461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCF7A88236
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673E93BBA88
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800722E62A6;
	Mon, 14 Apr 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7RqHdGG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E7E2E3399;
	Mon, 14 Apr 2025 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637188; cv=none; b=Cn9qYRhpq1dAo0uZGxGe6mOkGDbQ1s7DbnvbBjniGAIrj1JeHNtgv2jicNFDMYjOdjXdBA4tgkAZBW52DPv0Wlqj+9rbBl8uOaEevNuSYHWh2Jgl8qwMJQlaR94oK0w5wVDBSBFJu/Ryqk0VU21j7eU9pBDX6/nMcW+lzxKMRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637188; c=relaxed/simple;
	bh=l/yHk582AK4bFUjbv7xQMGDY1aE4V/qkqvcLDCRbGaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQGZbjYTWEEozxholXZqBrOldLamR30pZBvh0gno/On7EkVZ8d2wd4PPVpIqjdp5RU/coFS6hQ0vxvqg4JpkKFte8Gk7xJkBqLiIoCybPWxPW6s4lHGqVxhv23jg6o7JrSg+txxFk0u1Jcwwh+zjD5c26d0fK9BzcBGuhU/ULCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7RqHdGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83826C4CEE9;
	Mon, 14 Apr 2025 13:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637187;
	bh=l/yHk582AK4bFUjbv7xQMGDY1aE4V/qkqvcLDCRbGaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7RqHdGGZFXeZP/xoo5V+rC5KVLI2awn3q9FyLvRK94OQP6c2pF7M8WmzEHeq4cup
	 xLItGCJaiXkslKifphH/N9smCSRpJYlUjz5l95xbaTSrVdlVM7RKOoUj6dFPLLhWwK
	 fQuKi5MclnS55oplNXIlXNu94oX14erEis9Kk6oGaaBE54YQtlhOAzQmRjEkF/W13K
	 cw976vw28trSBaLi7wlAr7F9BYUxcn7DGIeHrlYPUzGk4HZtyMujBOVHSppCHY0nhO
	 t5enRW++ZheScNttojFZBoY1z7Fx2tHdAkZsbPX0PWboOztWpm6oDCEOJLtwGF58lL
	 36z9AlgGhvQHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 6.14 07/34] xen: Change xen-acpi-processor dom0 dependency
Date: Mon, 14 Apr 2025 09:25:43 -0400
Message-Id: <20250414132610.677644-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index f7d6f47971fdf..24f485827e039 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -278,7 +278,7 @@ config XEN_PRIVCMD_EVENTFD
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
 	  This ACPI processor uploads Power Management information to the Xen
-- 
2.39.5



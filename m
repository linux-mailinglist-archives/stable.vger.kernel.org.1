Return-Path: <stable+bounces-133366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990CAA9258F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE927B5407
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ECD25742E;
	Thu, 17 Apr 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JRlKBxCN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20341257420;
	Thu, 17 Apr 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912858; cv=none; b=HqHzDH9WvrBf/r9yJXDHt22d2SG4yGOkuKD9ImYmh8AsvCL1lp/4bOwJ6OPznqhi1TCCydMCWjRQB0PcFZuTPyEyd0szsh15jCnszDAxVOmhTrOEVcG5DvxzsU+IWIoT/DVcsBWKb9rJKDAAWc5kbslclp5uyxauE9Y7n3OQnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912858; c=relaxed/simple;
	bh=Hs/+fIO2DUjCtVpGb10kA1LzX8eNSvBIEHmCPfsIy+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKQblcG+w3rvQLqBJ1VEX/+QYbJF1zXiIE05sgnnoV9Q/SEjIMdh2fZLJpa1a3HZsNeQBXvk50nngSH8Q/QxguS1VLYEm6c6TCQc3wA3xsJ8CdEJpTlvaUIYjYdT1IEPuPLqY9HGYUZ6Ngj5T2C///TrCVEtYELuIKQ6kSow4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JRlKBxCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975C5C4CEE4;
	Thu, 17 Apr 2025 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912858;
	bh=Hs/+fIO2DUjCtVpGb10kA1LzX8eNSvBIEHmCPfsIy+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRlKBxCNrWznDRSPPOvxVd8uOgildPmI+40TgGSb9Z/+CcL+8R9IUodisVkLzd0vc
	 5XaDA6wxSF015GcR+XigTic/xIRRFnXgIn8e1fhRmTGfzLFnfnWmdV8LkzyHNbzq8s
	 nTD55X4Sa07ZrsQglVv5O1csHwHylVZTlWZU7lbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Clint Taylor <Clinton.A.Taylor@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 148/449] drm/xe/ptl: Update the PTL pci id table
Date: Thu, 17 Apr 2025 19:47:16 +0200
Message-ID: <20250417175123.932726517@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Atwood <matthew.s.atwood@intel.com>

[ Upstream commit 16016ade13f691da315fac7b23ebf1ab7b28b7ab ]

Update to current bspec table.

Bspec: 72574

Signed-off-by: Matt Atwood <matthew.s.atwood@intel.com>
Reviewed-by: Clint Taylor <Clinton.A.Taylor@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250128175102.45797-1-matthew.s.atwood@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/intel/pciids.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
index 4035e215c962a..f9d3e85142ea8 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -856,12 +856,10 @@
 	MACRO__(0xB080, ## __VA_ARGS__), \
 	MACRO__(0xB081, ## __VA_ARGS__), \
 	MACRO__(0xB082, ## __VA_ARGS__), \
+	MACRO__(0xB083, ## __VA_ARGS__), \
+	MACRO__(0xB08F, ## __VA_ARGS__), \
 	MACRO__(0xB090, ## __VA_ARGS__), \
-	MACRO__(0xB091, ## __VA_ARGS__), \
-	MACRO__(0xB092, ## __VA_ARGS__), \
 	MACRO__(0xB0A0, ## __VA_ARGS__), \
-	MACRO__(0xB0A1, ## __VA_ARGS__), \
-	MACRO__(0xB0A2, ## __VA_ARGS__), \
 	MACRO__(0xB0B0, ## __VA_ARGS__)
 
 #endif /* __PCIIDS_H__ */
-- 
2.39.5





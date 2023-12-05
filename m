Return-Path: <stable+bounces-4506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B28047C8
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F591280BEF
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33988BF7;
	Tue,  5 Dec 2023 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tYNWGyHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5B6FB1;
	Tue,  5 Dec 2023 03:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3E4C433C8;
	Tue,  5 Dec 2023 03:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747731;
	bh=gUo2g4Wf+Y59ZiO/Vb4oUx8cIE7616wOT7aWoY2U45o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYNWGyHWfQOb9HBaPlKhHDzvxSjFCEy84vTq/NVIa9UlN9Nr2yaB4my636lkRrbQN
	 qmZ79xjgVqvSW+MPAe5no7VfY3ZDMa8+NY4CZ2laBi8vXQO3d+INwPAfE9u5aRiDsq
	 TYFHD1TQriijHQbxRh4p+QlQgIcGMWOIbKPv9XF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 48/67] selftests/resctrl: Add missing SPDX license to Makefile
Date: Tue,  5 Dec 2023 12:17:33 +0900
Message-ID: <20231205031522.587221130@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
References: <20231205031519.853779502@linuxfoundation.org>
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

From: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

[ Upstream commit 68c4844985d1f8c1b1a71dfcdbfacb5a30babc95 ]

Add the missing SPDX(SPDX-License-Identifier) license header to
tools/testing/selftests/resctrl/Makefile.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Stable-dep-of: 3a1e4a91aa45 ("selftests/resctrl: Move _GNU_SOURCE define into Makefile")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/resctrl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 9cc7e0108c8b0..5073dbc961258 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
-- 
2.42.0





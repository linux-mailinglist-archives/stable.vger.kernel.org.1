Return-Path: <stable+bounces-40431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29898AD99D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0ECC1C2125D
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CBC156F38;
	Mon, 22 Apr 2024 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXj/XJOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6783156F2D;
	Mon, 22 Apr 2024 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830062; cv=none; b=RIrQO+5S0RElEPUrj7IITGa/jq1AgX81PVAupZzEyxXIzg42//EOr7PiZcD+QeSAO1q2Y7b/1vC0bmQC07+VY+xFO5TfXLTADTEVnzvOYspJf34Xs+3RyzXpxm7sftenu5A0V/TKsipIfAdtucjXrffvnElH53yTthbyeWsBhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830062; c=relaxed/simple;
	bh=rDhbJlcmtvAFacVyrapM9OsIC1FdTdDVBdD5fY5OliQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HozMqZHaOg68OKoup2fy7a2qDxuvf2ERLjvaF1uWLDaJYPVk2L066nGcvoRiexl4cIFW8O236AXOxE4/JHI3HdDps+k6uOSTu0zLTC1BFcTRuqZQEAAT6LqBuK3V7dUlRoUboJTaYXnuoQkV0B++iY8YRWL2kpE43UPI2CJsxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXj/XJOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF582C113CC;
	Mon, 22 Apr 2024 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830061;
	bh=rDhbJlcmtvAFacVyrapM9OsIC1FdTdDVBdD5fY5OliQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXj/XJOU4eOXUPlTmoWtWRTaIQRyCKPTGCvvYs51mkqktTT0YU4WpxoG2q1LY+Dzm
	 DVoG1NIIlTu2eeVKzYoKwSCX5aI7sZxwxbfWYtL4ldAk46ajWIPJ3D0exWsel0WxJH
	 ziyc3/oPiRSbrMYD/S47DD+yQDI5fwC3QH2IeTAK7fdgRRewhuX+kcXyydpX6v9abF
	 fKcxz61xLDT/tFC1p+Bv+iUlfkVoLwT+16oVNrNgsd5L56nfO5tLW3PstTZwGvGIhG
	 MqAtYHZzUcubRywIpEAnH+sQ1kQisNIE5YksitocwMhsfsiZqYvkSQfi6PyQep9+Q1
	 2j5KP9syvx57g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 6.8 12/43] memblock tests: fix undefined reference to `BIT'
Date: Mon, 22 Apr 2024 19:13:58 -0400
Message-ID: <20240422231521.1592991-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Wei Yang <richard.weiyang@gmail.com>

[ Upstream commit 592447f6cb3c20d606d6c5d8e6af68e99707b786 ]

commit 772dd0342727 ("mm: enumerate all gfp flags") define gfp flags
with the help of BIT, while gfp_types.h doesn't include header file for
the definition. This through an error on building memblock tests.

Let's include linux/bits.h to fix it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Suren Baghdasaryan <surenb@google.com>
CC: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/r/20240402132701.29744-4-richard.weiyang@gmail.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gfp_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 1b6053da8754e..495ebf5f2cb6d 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_GFP_TYPES_H
 #define __LINUX_GFP_TYPES_H
 
+#include <linux/bits.h>
+
 /* The typedef is in types.h but we want the documentation here */
 #if 0
 /**
-- 
2.43.0



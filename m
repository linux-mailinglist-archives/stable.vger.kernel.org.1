Return-Path: <stable+bounces-63951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C42941B69
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AFE1F21708
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB11898E0;
	Tue, 30 Jul 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IPmyN9XK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B71A6195;
	Tue, 30 Jul 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358481; cv=none; b=izsepRziSydnw210e7SgSfXEXfun1UWixKTT6ZWKGq9hqcgiMpgJHPcomVndRfIV0JSCgvpgcDdwWX4NEpGqAFwHS4tbkvasQ8xLLSlGx6RKT7EaG6poqCWASGBa62NnY4puw271t3KLt+OdAbkq+DtfK/kfNApsA6tysIDwkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358481; c=relaxed/simple;
	bh=VBaL0HGFT6YsWIPviwKrFoHsZ1A2DU/29Dcq5ggVWFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZ/eoHp7lr5+4GRwFkgdHHLV8iAd+1t1K3z1lDzCkIvtZI475+LodpvzBiNJIA3+l3VjHCFd5Oi/gk9w+F/nbELQuWj2Uws39LadJjoKqWHbQo+myIokScELUZD0mlJcAijBfEJqlHAonquAhg0yUwBNkSIjifhnfountHZbq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IPmyN9XK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC2C4AF10;
	Tue, 30 Jul 2024 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358481;
	bh=VBaL0HGFT6YsWIPviwKrFoHsZ1A2DU/29Dcq5ggVWFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPmyN9XKmNYyP8Sw+roqgR0zChnTcLffvLVOLSwaVlFfY+CzH4uadmK2oBRxazQCh
	 Z0u+/KvphW9cS7EbqV3eFz7gn6riRiojs0kGef/IeZo1qMv8K3PeCCjP00h8G8bLb8
	 tXsF5IgF2SD/w79V7IJyLoo5Zw/Mu4JVoAGbCPXw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 363/809] perf intel-pt: Fix aux_watermark calculation for 64-bit size
Date: Tue, 30 Jul 2024 17:43:59 +0200
Message-ID: <20240730151738.989145289@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 36b4cd990a8fd3f5b748883050e9d8c69fe6398d ]

aux_watermark is a u32. For a 64-bit size, cap the aux_watermark
calculation at UINT_MAX instead of truncating it to 32-bits.

Fixes: 874fc35cdd55 ("perf intel-pt: Use aux_watermark")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240625104532.11990-2-adrian.hunter@intel.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6de7e2d210756..c8fa15f280d29 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -758,7 +758,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	}
 
 	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
-		u32 aux_watermark = opts->auxtrace_mmap_pages * page_size / 4;
+		size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
+		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
 
 		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
 	}
-- 
2.43.0





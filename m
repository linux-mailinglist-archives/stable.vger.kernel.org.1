Return-Path: <stable+bounces-129094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D442AA7FE2E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD271893588
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F5269B0B;
	Tue,  8 Apr 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XOZ2dKhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB62698BC;
	Tue,  8 Apr 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110098; cv=none; b=A8HM5N3CdecXMg5Qt1nVS0d0IZDeBqtbK26TaZcFj2f/spIUqptmuhEQYOOiMNrDSpuU8iJ41mjs1f4QHgf8CmW1LjMIdYmMpHit1Gzy7g0NIQDSHcr0aal3/sERuuB67S0/sXDMsFRKxHHs9zwC16zIcllnwZqByyY8J87zDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110098; c=relaxed/simple;
	bh=deG267a+zAg5REWBVCokdtQ4mv1qSkOSh4ICXreWYWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDlfy+Gq52phhYQNSUTNzBzPa+hfUAjKNCivb4I1rLHWaw2Czs0T764ySX/pftzhnbS/wt0FC8M8marX+RIyXWEcycpWOqUaay79x0CHPHqaTqD1lhW0b7MgV8fIZawb/xcBxPMDO9pI6lCFyXPu5+IuS1wu3TWjeVdlOBBDso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XOZ2dKhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF82C4CEE5;
	Tue,  8 Apr 2025 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110098;
	bh=deG267a+zAg5REWBVCokdtQ4mv1qSkOSh4ICXreWYWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XOZ2dKhn5SklH4KpQG1LC2XCrlZleguUBAVdlOk2Fn8KbLIEjSlr03OkO03ehmL/5
	 JS7l/WK/LJRV+p8RXWuSpu1So9J7FnbaDfKNxqOxEsCUorq4BAxklrRdQfLLOvqth7
	 5R7i5mYVWDrx1mo2uApaToznktbfM50a1T2FQre4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 165/227] perf units: Fix insufficient array space
Date: Tue,  8 Apr 2025 12:49:03 +0200
Message-ID: <20250408104825.266703613@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit cf67629f7f637fb988228abdb3aae46d0c1748fe ]

No need to specify the array size, let the compiler figure that out.

This addresses this compiler warning that was noticed while build
testing on fedora rawhide:

  31    15.81 fedora:rawhide                : FAIL gcc version 15.0.1 20250225 (Red Hat 15.0.1-0) (GCC)
    util/units.c: In function 'unit_number__scnprintf':
    util/units.c:67:24: error: initializer-string for array of 'char' is too long [-Werror=unterminated-string-initialization]
       67 |         char unit[4] = "BKMG";
          |                        ^~~~~~
    cc1: all warnings being treated as errors

Fixes: 9808143ba2e54818 ("perf tools: Add unit_number__scnprintf function")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20250310194534.265487-3-acme@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/units.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/units.c b/tools/perf/util/units.c
index a46762aec4c9f..24c83b8b8c980 100644
--- a/tools/perf/util/units.c
+++ b/tools/perf/util/units.c
@@ -57,7 +57,7 @@ unsigned long convert_unit(unsigned long value, char *unit)
 
 int unit_number__scnprintf(char *buf, size_t size, u64 n)
 {
-	char unit[4] = "BKMG";
+	char unit[] = "BKMG";
 	int i = 0;
 
 	while (((n / 1024) > 1) && (i < 3)) {
-- 
2.39.5





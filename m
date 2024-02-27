Return-Path: <stable+bounces-24478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D08694AA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F7285F23
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800913EFEC;
	Tue, 27 Feb 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cPWC/MYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BD13DBBF;
	Tue, 27 Feb 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042116; cv=none; b=ZfSekw+PB1ZQYxPkEhuZE6PqgWPF9NgQC3qSBUf/0cIcsB4IICec8jG/Lb5xbw0EIdsYLZg/qZqT2qA76r6C2EI9/9XigCvV38VKZ/EOqOtkKqBmTf/XrStQkIYof2KzWiceU2nAeVabROMUNmaFRL4LE4dN3rIEty3H732gZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042116; c=relaxed/simple;
	bh=xWOcKbn2DPhJU5n+l3zCdvryHdKljrWdtY2+jaoX5ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae7C88NrRgMrnwCmwet24YFU43gw20k4+Sr9PxZebPK91UvFIoULk4QR7GBhI3Mad57Bmp54vl7po4krNUtY5+aY97kXAvVhDUSr4xzhcrcuLhKOITPlBTXDtyskOL0txMPleU3hxnYOAMF4woIX4HtggO6HbpNcT7giaPmcA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cPWC/MYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61083C433F1;
	Tue, 27 Feb 2024 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042115;
	bh=xWOcKbn2DPhJU5n+l3zCdvryHdKljrWdtY2+jaoX5ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPWC/MYkoMhCsQlLF5jR7NihMZhdfWDk1G1ViCVLfd0qA+2ecnw3EaM7MJKBBEbW+
	 heD/GsVs7zzjFNc6v8T8o9eqXAZbl9X+/ReWuL0fvGRGSrdf+By7c0gGa479QCmPpa
	 nGEWwcZsZsV/N+w/jtkbEuGhihP/7ztMzsJ1Yecc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Terry Tritton <terry.tritton@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 157/299] selftests/mm: uffd-unit-test check if huge page size is 0
Date: Tue, 27 Feb 2024 14:24:28 +0100
Message-ID: <20240227131630.911204771@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Terry Tritton <terry.tritton@linaro.org>

commit 7efa6f2c803366f84c3c362f01e822490669d72b upstream.

If HUGETLBFS is not enabled then the default_huge_page_size function will
return 0 and cause a divide by 0 error. Add a check to see if the huge page
size is 0 and skip the hugetlb tests if it is.

Link: https://lkml.kernel.org/r/20240205145055.3545806-2-terry.tritton@linaro.org
Fixes: 16a45b57cbf2 ("selftests/mm: add framework for uffd-unit-test")
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/mm/uffd-unit-tests.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1309,6 +1309,12 @@ int main(int argc, char *argv[])
 				continue;
 
 			uffd_test_start("%s on %s", test->name, mem_type->name);
+			if ((mem_type->mem_flag == MEM_HUGETLB ||
+			    mem_type->mem_flag == MEM_HUGETLB_PRIVATE) &&
+			    (default_huge_page_size() == 0)) {
+				uffd_test_skip("huge page size is 0, feature missing?");
+				continue;
+			}
 			if (!uffd_feature_supported(test)) {
 				uffd_test_skip("feature missing");
 				continue;




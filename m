Return-Path: <stable+bounces-44855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED18C54BF
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B31C28A351
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457B12E1C0;
	Tue, 14 May 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ik2iJMyc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C55A0F9;
	Tue, 14 May 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687371; cv=none; b=jz2pSCx9j2gaplE+qB1MftZ2Esb7OTllwhm3oQ10Q03M263yGUpWf2uTex/UxzLBkbiTCTehSdzSDEJN/RZMm2Bwz7MNSDwnqjWt+0K2UdZdewn5xdQ2f+pbPOENIGlRQ3QfUisinEdRgnaSgnCKLSgcpDmNWxDeKmrQFkOHz0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687371; c=relaxed/simple;
	bh=EST9kwq++C9ceYXl/GHrs9eBS/QNCSY/2lSLdRwp7f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH3OU4WjJf+7MklAufTXCRNkB4Hx8d5bX4VpqEsNzF4Xhgw+qgpuLFx0I4XULnuKssIu67WbzMoIlusOlTqLqsitzg/XL8Kd15EArU4xSSmh4X5ibZrDEkNWJGJv/PDVulXw6m1SL/6iMWlrQ76pU82f1WXkDdjmj4seLeis7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ik2iJMyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D49DC2BD10;
	Tue, 14 May 2024 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687371;
	bh=EST9kwq++C9ceYXl/GHrs9eBS/QNCSY/2lSLdRwp7f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ik2iJMycEHIjzLTc10qvD1Q/1A2Oqss9six9I73vfdobqurGHNlg4tKVK44a9YgxI
	 qezPfE3VYmcOUZzwcU2A4DOkd2csPoVUGs3O76trl/Z/GqzM8fAzXkwSffMx86WAbu
	 bRYD4UcPw0pTCANqxVNde0EXLDUCBAn1YCHGBhTA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Liu <liupeng17@lenovo.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 056/111] tools/power turbostat: Fix Bzy_MHz documentation typo
Date: Tue, 14 May 2024 12:19:54 +0200
Message-ID: <20240514100959.263186283@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Liu <liupeng17@lenovo.com>

[ Upstream commit 0b13410b52c4636aacb6964a4253a797c0fa0d16 ]

The code calculates Bzy_MHz by multiplying TSC_delta * APERF_delta/MPERF_delta
The man page erroneously showed that TSC_delta was divided.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 71e3f3a68b9df..f8cc88c56ae8f 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -320,7 +320,7 @@ below the processor's base frequency.
 
 Busy% = MPERF_delta/TSC_delta
 
-Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
+Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
 
 Note that these calculations depend on TSC_delta, so they
 are not reliable during intervals when TSC_MHz is not running at the base frequency.
-- 
2.43.0





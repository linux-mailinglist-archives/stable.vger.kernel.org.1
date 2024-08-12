Return-Path: <stable+bounces-66921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517FB94F31A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CBA1C217BA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8C186E36;
	Mon, 12 Aug 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOo85x43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19493130E27;
	Mon, 12 Aug 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479218; cv=none; b=CWoGVFMhsyULbBXo9aB0AY/LVnSyaMh7pYX/WTAGU0VRczY/9mGOK5ystclteWLkApQwx+m3l5NpD65cpDLc2Qqeda1DUrYPsFEBM6O1Lb6cmCEOzl4XmRi2rrkl7keCQ8tRtiR/F1lCh/SJNrt3ONqXSN7Lp38dw0+9nUQYvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479218; c=relaxed/simple;
	bh=rVMlWJJKlthGTqXNFQrxdA1dOtz0M9jH3qWPAbpTSqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oypbEwkj8hINVhi1xzkF+99z9AtDBVKq/NmLBseUCEPZvQH3sZo/zlhMyVk6K4Q850Ie+bTdLeFvCvEmcaq/dvtu/nWJHklQqRVW1XnMHm3rw68A8umliby6jtnKgWRCkkfrtlxzMkjvv1SE2eYbSO6OTwm+6KUzfBI/dk/iDpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOo85x43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAE0C32782;
	Mon, 12 Aug 2024 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479218;
	bh=rVMlWJJKlthGTqXNFQrxdA1dOtz0M9jH3qWPAbpTSqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOo85x43qSg2idVKLzHgDWUH0FBaMv28jTfV+Ea625qScWjHprOxdngEkRyFTUTyy
	 AWJJHxpI4mK5SCsWjoonw/SjqbYqyMz7m9XNGRZsbPUhKDfv+gYWsfqA5QkeqLoN6H
	 E/rbgi04E7aD6FelgfOs9aZjbaMQT68ITrFB6jv4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/189] net/smc: add the max value of fallback reason count
Date: Mon, 12 Aug 2024 18:01:15 +0200
Message-ID: <20240812160132.883125362@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit d27a835f41d947f62e6a95e89ba523299c9e6437 ]

The number of fallback reasons defined in the smc_clc.h file has reached
36. For historical reasons, some are no longer quoted, and there's 33
actually in use. So, add the max value of fallback reason count to 36.

Fixes: 6ac1e6563f59 ("net/smc: support smc v2.x features validate")
Fixes: 7f0620b9940b ("net/smc: support max connections per lgr negotiation")
Fixes: 69b888e3bb4b ("net/smc: support max links per lgr negotiation in clc handshake")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
Link: https://patch.msgid.link/20240805043856.565677-1-shaozhengchao@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index 9d32058db2b5d..e19177ce40923 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -19,7 +19,7 @@
 
 #include "smc_clc.h"
 
-#define SMC_MAX_FBACK_RSN_CNT 30
+#define SMC_MAX_FBACK_RSN_CNT 36
 
 enum {
 	SMC_BUF_8K,
-- 
2.43.0





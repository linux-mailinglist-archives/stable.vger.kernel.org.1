Return-Path: <stable+bounces-2336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C75D7F83BE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF752834A4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B7364B7;
	Fri, 24 Nov 2023 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mmjKN7sI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96F339BE;
	Fri, 24 Nov 2023 19:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE024C433C8;
	Fri, 24 Nov 2023 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853631;
	bh=cFPq2Tb+Gz9T3LTRYPmXrLTYjPLEVWnb8VGGOusqXRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmjKN7sIkBjc4FujxD4FunnLdm9oEHGtsL3IEO9zuS6FwPLB19yRK38rfm0JzFQjr
	 9gFZsF+c++MzP4UYKkegWHBuVO7+5gNAhAasp2ahdli8d7p+Nu2RVdAEF1NXTLsP/s
	 qeekM6rp5FgZDxDpyCZWvmIWAX+BkV8rHxvifLlw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 241/297] cpufreq: stats: Fix buffer overflow detection in trans_stats()
Date: Fri, 24 Nov 2023 17:54:43 +0000
Message-ID: <20231124172008.631120728@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit ea167a7fc2426f7685c3735e104921c1a20a6d3f ]

Commit 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential
buffer overflow") switched from snprintf to the more secure scnprintf
but never updated the exit condition for PAGE_SIZE.

As the commit say and as scnprintf document, what scnprintf returns what
is actually written not counting the '\0' end char. This results in the
case of len exceeding the size, len set to PAGE_SIZE - 1, as it can be
written at max PAGE_SIZE - 1 (as '\0' is not counted)

Because of len is never set to PAGE_SIZE, the function never break early,
never prints the warning and never return -EFBIG.

Fix this by changing the condition to PAGE_SIZE - 1 to correctly trigger
the error.

Cc: 5.10+ <stable@vger.kernel.org> # 5.10+
Fixes: 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential buffer overflow")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq_stats.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1570d6f3e75d3..6e57df7a2249f 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -131,25 +131,25 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
 				stats->freq_table[i]);
 	}
-	if (len >= PAGE_SIZE)
-		return PAGE_SIZE;
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
 	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 
 	for (i = 0; i < stats->state_num; i++) {
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u: ",
 				stats->freq_table[i]);
 
 		for (j = 0; j < stats->state_num; j++) {
-			if (len >= PAGE_SIZE)
+			if (len >= PAGE_SIZE - 1)
 				break;
 
 			if (pending)
@@ -159,12 +159,12 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 
 			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
 		}
-		if (len >= PAGE_SIZE)
+		if (len >= PAGE_SIZE - 1)
 			break;
 		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
 	}
 
-	if (len >= PAGE_SIZE) {
+	if (len >= PAGE_SIZE - 1) {
 		pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
 		return -EFBIG;
 	}
-- 
2.42.0





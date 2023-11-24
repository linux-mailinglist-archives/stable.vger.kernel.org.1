Return-Path: <stable+bounces-1630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5127F809F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9EB21500
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4573307D;
	Fri, 24 Nov 2023 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JlMKjvhC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB3028E3A;
	Fri, 24 Nov 2023 18:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B02C433C9;
	Fri, 24 Nov 2023 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851881;
	bh=rmumWnGx+lr5xWo3MNcaeqIHj18mDqaIlI/tkOWYmFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlMKjvhCwzlxYyT6jqVweFOk9e/lPNAkwcwogut3lJPjbOP5cndXnxaqSGwKNcImv
	 M/q3GuDhcHNCEG3Ga6TM5g+dGAK7rr35iT3K7DnFx4t4TtpUf6kAh8yMLx8o9DTUdr
	 +jHcgtKPuPMJMUMkbIG+f5PbiSC+cvSVBiRqnGck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yonglong Liu <liuyonglong@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/372] net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
Date: Fri, 24 Nov 2023 17:48:39 +0000
Message-ID: <20231124172014.884722670@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 53aba458f23846112c0d44239580ff59bc5c36c3 ]

The hns3 driver define an array of string to show the coalesce
info, but if the kernel adds a new mode or a new state,
out-of-bounds access may occur when coalesce info is read via
debugfs, this patch fix the problem.

Fixes: c99fead7cb07 ("net: hns3: add debugfs support for interrupt coalesce")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 00eed9835cb55..d2603cfc122c8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -494,11 +494,14 @@ static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 	}
 
 	sprintf(result[j++], "%d", i);
-	sprintf(result[j++], "%s", dim_state_str[dim->state]);
+	sprintf(result[j++], "%s", dim->state < ARRAY_SIZE(dim_state_str) ?
+		dim_state_str[dim->state] : "unknown");
 	sprintf(result[j++], "%u", dim->profile_ix);
-	sprintf(result[j++], "%s", dim_cqe_mode_str[dim->mode]);
+	sprintf(result[j++], "%s", dim->mode < ARRAY_SIZE(dim_cqe_mode_str) ?
+		dim_cqe_mode_str[dim->mode] : "unknown");
 	sprintf(result[j++], "%s",
-		dim_tune_stat_str[dim->tune_state]);
+		dim->tune_state < ARRAY_SIZE(dim_tune_stat_str) ?
+		dim_tune_stat_str[dim->tune_state] : "unknown");
 	sprintf(result[j++], "%u", dim->steps_left);
 	sprintf(result[j++], "%u", dim->steps_right);
 	sprintf(result[j++], "%u", dim->tired);
-- 
2.42.0





Return-Path: <stable+bounces-140586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56E5AAA9DF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB916105F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4E32D9DB5;
	Mon,  5 May 2025 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2l5Favq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35DC370B04;
	Mon,  5 May 2025 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485210; cv=none; b=LEl37UE6TOa97BcN59Vxk1itog7czh8Q7d3OFP4OGUvofYKxk5WcHdvlsWLFdfi2k4hy5nTMPQMMs6OYyW9L3JZyUGD0gZ8qaBAA6pt4LMMrt+PPh8rSqvbm1o1u7CpWDtuF/1jUzBZPD6KOtxVbXKV+3nEHySCB5MHrtH7II2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485210; c=relaxed/simple;
	bh=BaO8pDav+6tqroX8a/mPnbZ58fAJz7E78TKmn3J2j10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1ZEmM9Lu31TnTJlM1gcj2M1cy+osRRBcJ8uchcu6NiZGv+tU+5x4vTQjZj50jmGmPXCLOGGi+3TPh5RYDpKN2hQUwFYaD+moeMpDxFg77r0WZrEKql46DP9VPweWZ3xuPbj3v8w0mv82FM+mfg9Z9q8+Hdl+7WVREl7jrQ5hYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2l5Favq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EAAC4CEE4;
	Mon,  5 May 2025 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485209;
	bh=BaO8pDav+6tqroX8a/mPnbZ58fAJz7E78TKmn3J2j10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2l5FavqZ6KOVX8FzTuF1vIfjCUNfbpxlTtEG4gE928UgZnDfLT2Q+7/F1oQUkDNB
	 yTyWNViKAcrXhzXR/gsSNRe+vVITvsStC0iYkMrNVDMrAcBNkf+fXD99tT3elitNwl
	 v5arpSP14THbuoXxzhs/HB9zFqfHBa99H0wZSG7Uej1JVgDwfWhNw+41w1FZy4ZPSg
	 t267YsI83uhcEyHk4d7Rjxe6UZf5xXTBey6WTHy13piZGt9C4jVU1zR+TdCBnB6HWc
	 JP+wtfm5DrCegRu3cAHFm1kk3xrl61GD25+m/Mmyq25HeODntcMkAOE7aGitkniHHL
	 8rR+Sir/Tg4kA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 212/486] net: pktgen: fix mpls maximum labels list parsing
Date: Mon,  5 May 2025 18:34:48 -0400
Message-Id: <20250505223922.2682012-212-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Peter Seiderer <ps.report@gmx.net>

[ Upstream commit 2b15a0693f70d1e8119743ee89edbfb1271b3ea8 ]

Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS entries (instead
of up to MAX_MPLS_LABELS - 1).

Addresses the following:

	$ echo "mpls 00000f00,00000f01,00000f02,00000f03,00000f04,00000f05,00000f06,00000f07,00000f08,00000f09,00000f0a,00000f0b,00000f0c,00000f0d,00000f0e,00000f0f" > /proc/net/pktgen/lo\@0
	-bash: echo: write error: Argument list too long

Signed-off-by: Peter Seiderer <ps.report@gmx.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/pktgen.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index b6db4910359bb..4d87da56c56a0 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -898,6 +898,10 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 	pkt_dev->nr_labels = 0;
 	do {
 		__u32 tmp;
+
+		if (n >= MAX_MPLS_LABELS)
+			return -E2BIG;
+
 		len = hex32_arg(&buffer[i], 8, &tmp);
 		if (len <= 0)
 			return len;
@@ -909,8 +913,6 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 			return -EFAULT;
 		i++;
 		n++;
-		if (n >= MAX_MPLS_LABELS)
-			return -E2BIG;
 	} while (c == ',');
 
 	pkt_dev->nr_labels = n;
-- 
2.39.5



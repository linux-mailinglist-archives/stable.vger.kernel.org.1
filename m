Return-Path: <stable+bounces-168243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D977AB2341F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485FF3AA37E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBE52EF652;
	Tue, 12 Aug 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwXlut2E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45A27FB12;
	Tue, 12 Aug 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023528; cv=none; b=WpXmH8zASv6+AOwyQEnCFYsXRqvVe2PPNQywc4WyAm8+s+balcjX9qapME4oFnP8S785mH+fBHkmQcHrjob1B57O2CvcNX074mFk9i94lvT6HxsRprtIlWeazI2JsVb+ZZzhgxRXqT+OV3GEuX5zmxIDvUwZqTptyYRjF23bOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023528; c=relaxed/simple;
	bh=2Bdgqg07QLnzvYg+K3t9BN8RmJH22D5l1OIHTw4Wj0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVmOO+eYHUOQYSs1hYMqxuLAuuOaXhJ/6tt7Tkt1gzE90Cx4mitjp34SD7Fp4tc3WClBi2M6IuQ/KdwMrE5yZ8TZbBZICGGhgnJHsuVCFRUJaC3+A+utX2yP1aBUAzZ+khprJkHJUJ705tV/SiOitZ0r2at9xOe/RX++zQYc/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vwXlut2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8D4C4CEF0;
	Tue, 12 Aug 2025 18:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023528;
	bh=2Bdgqg07QLnzvYg+K3t9BN8RmJH22D5l1OIHTw4Wj0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vwXlut2EsGjwJqTzVCR32XahcaKQns0DYCOsWx70z+YQeavBh75nElKzky+KvRMdo
	 rnabtJuO/sufcs3IHV0OE9PufqzF/Sgnx9OTlSvVfc4C0Lr0ITLoBFzI7fgKLfApmF
	 jqIYathndUSb2AsIQxzVS9ypJRIwJIGcHfp3OeTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	pls <pleasurefish@126.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 107/627] PM / devfreq: Fix a index typo in trans_stat
Date: Tue, 12 Aug 2025 19:26:42 +0200
Message-ID: <20250812173423.382927993@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chanwoo Choi <cw00.choi@samsung.com>

[ Upstream commit 78c5845fbbf6aaeb9959c5fbaee5cc53ef5f38c2 ]

Fixes: 4920ee6dcfaf ("PM / devfreq: Convert to use sysfs_emit_at() API")
Signed-off-by: pls <pleasurefish@126.com>
Link: https://patchwork.kernel.org/project/linux-pm/patch/20250515143100.17849-1-chanwoo@kernel.org/
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 713e6e52cca1..0d9f3d3282ec 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1739,7 +1739,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		if (df->freq_table[2] == df->previous_freq)
+		if (df->freq_table[i] == df->previous_freq)
 			len += sysfs_emit_at(buf, len, "*");
 		else
 			len += sysfs_emit_at(buf, len, " ");
-- 
2.39.5





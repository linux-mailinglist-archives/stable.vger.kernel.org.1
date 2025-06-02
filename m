Return-Path: <stable+bounces-150592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDABACB8C5
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C254A19453AE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05242153CB;
	Mon,  2 Jun 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VETGi4Yi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BA21882B;
	Mon,  2 Jun 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877612; cv=none; b=m2ks+ZzeQgbL7dp1cFG4T0Dzg2ZwePn242rkn2p4lc0EAD2k5l3DMyIEohwXb9J7Ao6rzu/ql5fQ/arMtBF+MA7HSQTGiXNUhusO90yY/sVvEyvUkDnhwTm/uEWrR/PSSSVf9IjhzQMvLZVxZjICtlJxyFOslMrA0AtggpVNqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877612; c=relaxed/simple;
	bh=DEshiQPxoJjOBQZhDEbIYYE31nrZ9VJNVHBvK3TBm1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxMScimzg7IyOTfVHL18x0sNIAAm082dEx9LeZFrKTMuR9QEHwWo4YhPxQp1zMFa/JLuDAiNJXMLhXkkHU8EpO1noTq6KIOszcxBRMz2T2Q5uWDTiczLmQ2IZwV/uBQW5Iy/YU+83+hywW1r1YjGcmf48TXsYGSrjJ85WWnRcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VETGi4Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7189EC4CEEB;
	Mon,  2 Jun 2025 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877612;
	bh=DEshiQPxoJjOBQZhDEbIYYE31nrZ9VJNVHBvK3TBm1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VETGi4Yi/go1q1C1vAjT+SaIJHoGE60EmFDxo8bOcoyB+vKact6MkW+fcAfAPkdgB
	 JPwcOlqgo/6fDPkAIDQNPdsvu2omstJrX+9jDs7igz3oYrn0Tt2qqVOKipC+GVkx4x
	 PCK1AI1CfeKoUUJfY0gCUu8rpqXudcyEKAuDBFbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 310/325] perf/arm-cmn: Fix REQ2/SNP2 mixup
Date: Mon,  2 Jun 2025 15:49:46 +0200
Message-ID: <20250602134332.516058781@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

commit 11b0f576e0cbde6a12258f2af6753b17b8df342b upstream.

Somehow the encodings for REQ2/SNP2 channels in XP events
got mixed up... Unmix them.

CC: stable@vger.kernel.org
Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/087023e9737ac93d7ec7a841da904758c254cb01.1746717400.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm-cmn.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -675,8 +675,8 @@ static umode_t arm_cmn_event_attr_is_vis
 
 		if ((chan == 5 && cmn->rsp_vc_num < 2) ||
 		    (chan == 6 && cmn->dat_vc_num < 2) ||
-		    (chan == 7 && cmn->snp_vc_num < 2) ||
-		    (chan == 8 && cmn->req_vc_num < 2))
+		    (chan == 7 && cmn->req_vc_num < 2) ||
+		    (chan == 8 && cmn->snp_vc_num < 2))
 			return 0;
 	}
 
@@ -794,8 +794,8 @@ static umode_t arm_cmn_event_attr_is_vis
 	_CMN_EVENT_XP(pub_##_name, (_event) | (4 << 5)),	\
 	_CMN_EVENT_XP(rsp2_##_name, (_event) | (5 << 5)),	\
 	_CMN_EVENT_XP(dat2_##_name, (_event) | (6 << 5)),	\
-	_CMN_EVENT_XP(snp2_##_name, (_event) | (7 << 5)),	\
-	_CMN_EVENT_XP(req2_##_name, (_event) | (8 << 5))
+	_CMN_EVENT_XP(req2_##_name, (_event) | (7 << 5)),	\
+	_CMN_EVENT_XP(snp2_##_name, (_event) | (8 << 5))
 
 
 static struct attribute *arm_cmn_event_attrs[] = {




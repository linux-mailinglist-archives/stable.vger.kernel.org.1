Return-Path: <stable+bounces-143834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEDAB41F8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDD11693BE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FAA29E041;
	Mon, 12 May 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAB63nsH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20E29DB92;
	Mon, 12 May 2025 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073106; cv=none; b=CToJZdFOdN2X723f0juaLot97rAe3RlVYjdPGxveaCDjndmpbPgttr/TaKXNrPx6JHNIznOVH9ifjppcWy3euUJ0BlhZwSHmwha7LIeBfix2n+ycx392yE4J6kAnmKWqkzy0v3ipPhC5rkxakwK3U7fDvj5UG8VTOOEvcBvQyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073106; c=relaxed/simple;
	bh=CUwTTRBoepiWy3eBVkjtl52xMaizXnQOALV0fmgcrHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bG6U1Bcx0EI/fYxs7e8uFe0GbsPyc7+RrgOs4SJJAmaNN85c6aFHgIBDAbxnE4U9lyHo6p1l+bXYBcvN/ljQUy+DwHM1yLxeJ+n3PEOzQxRlhWPZT6aO5Pp1tbeAP38qkvOooM8FHwcOlGqbhaH2aGqd/aZ9SMocrwhbxxfuMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAB63nsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD05C4CEEF;
	Mon, 12 May 2025 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073106;
	bh=CUwTTRBoepiWy3eBVkjtl52xMaizXnQOALV0fmgcrHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RAB63nsHcTpOzKtm2P4jVzIJJ9bHeKAG2ycXy8HkEScyMbMrSCNRI7MQvueKz1v1U
	 H79sVzfY39Fk9quxMMWnx8NmtYinU8oa+J2q6dwDKYX3wPrn4rThgGOoxJUjwL8W+E
	 HUw1D8A2F+UweffjCsB5rBnupWCoogfSQ4pa/kFHlQQEltX5Hue9Obw5hGPOXfBZjy
	 mQ18QZA1sYB/xuJZdNZC8bjE16n1JvmPzkpv9lmECm1AggAgfK0jLRvEZLPB6iZnTb
	 G3ukswHoBnyWkldW0Qa7TXtkwrC22vN4iVV3/VjKbnudHV+5nudK568SUPWRvEW84X
	 mBoyFNkPVI+JQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	elder@kernel.org,
	chenqiuji666@gmail.com,
	gregkh@linuxfoundation.org,
	xin.wang2@amd.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 5/6] xenbus: Allow PVH dom0 a non-local xenstore
Date: Mon, 12 May 2025 14:04:51 -0400
Message-Id: <20250512180452.437844-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180452.437844-1-sashal@kernel.org>
References: <20250512180452.437844-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.90
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

[ Upstream commit 90989869baae47ee2aa3bcb6f6eb9fbbe4287958 ]

Make xenbus_init() allow a non-local xenstore for a PVH dom0 - it is
currently forced to XS_LOCAL.  With Hyperlaunch booting dom0 and a
xenstore stubdom, dom0 can be handled as a regular XS_HVM following the
late init path.

Ideally we'd drop the use of xen_initial_domain() and just check for the
event channel instead.  However, ARM has a xen,enhanced no-xenstore
mode, where the event channel and PFN would both be 0.  Retain the
xen_initial_domain() check, and use that for an additional check when
the event channel is 0.

Check the full 64bit HVM_PARAM_STORE_EVTCHN value to catch the off
chance that high bits are set for the 32bit event channel.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Change-Id: I5506da42e4c6b8e85079fefb2f193c8de17c7437
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250506204456.5220-1-jason.andryuk@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_probe.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 25164d56c9d99..d3b6908110c6f 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -966,9 +966,15 @@ static int __init xenbus_init(void)
 	if (xen_pv_domain())
 		xen_store_domain_type = XS_PV;
 	if (xen_hvm_domain())
+	{
 		xen_store_domain_type = XS_HVM;
-	if (xen_hvm_domain() && xen_initial_domain())
-		xen_store_domain_type = XS_LOCAL;
+		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
+		if (err)
+			goto out_error;
+		xen_store_evtchn = (int)v;
+		if (!v && xen_initial_domain())
+			xen_store_domain_type = XS_LOCAL;
+	}
 	if (xen_pv_domain() && !xen_start_info->store_evtchn)
 		xen_store_domain_type = XS_LOCAL;
 	if (xen_pv_domain() && xen_start_info->store_evtchn)
@@ -987,10 +993,6 @@ static int __init xenbus_init(void)
 		xen_store_interface = gfn_to_virt(xen_store_gfn);
 		break;
 	case XS_HVM:
-		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
-		if (err)
-			goto out_error;
-		xen_store_evtchn = (int)v;
 		err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
 		if (err)
 			goto out_error;
-- 
2.39.5



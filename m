Return-Path: <stable+bounces-17999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6037E8480F6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122691F21C29
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92E1B950;
	Sat,  3 Feb 2024 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PdCfgDpr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A8FC03;
	Sat,  3 Feb 2024 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933473; cv=none; b=TxvtdnJLdIJBEO964aALljn0fh6L9yvjsrlYNj0Jwx6HJnlonfffvmJVqSRx/wqayIphMgg2vKz3SHp4i7IXiZITtPJZDyYgA3JpNrfeWl1DMJ86LOIu8tuDiNtQjuKMT+5gjqku2MBjNgdL4coASToBZGBlb1akKmtkFFe6dWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933473; c=relaxed/simple;
	bh=hdl190h5m0vep7Vhu0Ud57b7yeyxATOQBi2zMxfkCFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahto6uGKaFpb6yXj5m7pX4BX9dvEBih33Fmnr6iHRbgRunvkMH6OZ41DIw4g5iRT4p/ZXN3tsPGpv9mVX9NG+F2WCbK8WwmGOp3n3gQG6KokUWlGPh2VnVQYDW4etrDBKVwZNc05wjLVXA2CD+HFjUyC8WLhJUiKtItH8FG0Gpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PdCfgDpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD47BC433F1;
	Sat,  3 Feb 2024 04:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933473;
	bh=hdl190h5m0vep7Vhu0Ud57b7yeyxATOQBi2zMxfkCFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdCfgDprjWb8azhpAdDMQauVFL9GsCzRR+5gc2r0A1mzvQBBotegUix5Hv1d8P+ef
	 RAWJ2ixPx/rduFr5YTg53w4MDTYQmSFm5IfSUpxN4QKZbg7gxxK1cduVafSkV6mrhh
	 abtdNDMkNGIhg/ySZgO44zkL6VlVU4Qc3Ea5/ktQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Gray <jsg@jsg.id.au>
Subject: [PATCH 6.1 215/219] Revert "drm/amd/display: Disable PSR-SU on Parade 0803 TCON again"
Date: Fri,  2 Feb 2024 20:06:28 -0800
Message-ID: <20240203035346.907725213@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

From: Jonathan Gray <jsg@jsg.id.au>

This reverts commit 85d16c03ddd3f9b10212674e16ee8662b185bd14.

duplicated a change made in 6.1.69
20907717918f0487258424631b704c7248a72da2

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -818,8 +818,6 @@ bool is_psr_su_specific_panel(struct dc_
 				isPSRSUSupported = false;
 			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
 				isPSRSUSupported = false;
-			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
-				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}




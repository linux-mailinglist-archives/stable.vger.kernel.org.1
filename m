Return-Path: <stable+bounces-102220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5896B9EF20A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2201758C4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE083225407;
	Thu, 12 Dec 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X/4XEipN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC792210E5;
	Thu, 12 Dec 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020425; cv=none; b=HGXeSSliQ91ZjEbxKOscnBe19a9c13oJ5QXFUmx7MIjL2KXyX+Q9rXAljGa7/byVI1Ej68/qYwnH91WNmmgsG7dkbzBh2sBzSdhjUfKUYKTipHWom9Sbf8ADsqX19UIHePR6HSr1vyE4EBknUL1rMG4nRvHBFjqd3phMKsdQmmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020425; c=relaxed/simple;
	bh=M4u4a4KbCrXgV3EPU6+ZSTOnE4YL1VQHARBTSNQK8a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PENb5ywRXHhuUzXB/tbo1F4w/Y2VRiyEGWVyYpNwinYp+MFk49PIi5MsNYEsPrdkHLMFveYTIJXerMLrZrpeMbdaoPkR7qBpiXQrBd0hW/sdRwSXw6rZ+CSHFGPlcAT+eeMQs95CEdmlUPjjYJ+ZchmwVX8dRZiH5Tb7h+H6WdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X/4XEipN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E57C4CED4;
	Thu, 12 Dec 2024 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020425;
	bh=M4u4a4KbCrXgV3EPU6+ZSTOnE4YL1VQHARBTSNQK8a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/4XEipNyGCTrIPDPgZwMnNHlVu/zAr2SFEgIc89IG+iIfMzEKQ8wDIg2il3Xxe1Z
	 BPCXD8xIiR66I/s1CA5Ow0hHGM27TaHkdDoyp5Drkpw2Q4DYmZxoevaK6Yg9MI/VRb
	 mLgU01aIP4PM6MrWhblTCAl43DOYwErEMXTC4z+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.1 465/772] media: amphion: Fix pm_runtime_set_suspended() with runtime pm enabled
Date: Thu, 12 Dec 2024 15:56:50 +0100
Message-ID: <20241212144409.147793367@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit 316e74500d1c6589cba28cebe2864a0bceeb2396 upstream.

It is not valid to call pm_runtime_set_suspended() for devices
with runtime PM enabled because it returns -EAGAIN if it is enabled
already and working. So, call pm_runtime_disable() before to fix it.

Cc: stable@vger.kernel.org
Fixes: b50a64fc54af ("media: amphion: add amphion vpu device driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/amphion/vpu_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/amphion/vpu_drv.c
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -151,8 +151,8 @@ err_add_decoder:
 	media_device_cleanup(&vpu->mdev);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_vpu_deinit:
-	pm_runtime_set_suspended(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	return ret;
 }




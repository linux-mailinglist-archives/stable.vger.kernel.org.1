Return-Path: <stable+bounces-190162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0844C100B9
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315DC462B72
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0331D37B;
	Mon, 27 Oct 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNHmSV/H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2925322755
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590577; cv=none; b=hALSiEtE8QUwHOBBCUVriBo68DGMbQVx6EG9r1co/3D45Yfm3DQesoyIRFqHkkOwy7d0nytWMIq6zEp/M8cUv7ljRyg7/16m7iAg2Hz3UQtY2BH5QbMWAqOECfetVxsQA2/XcpYQ7EX0Ec/mPfozJz15ntjvqK4AGpED498pOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590577; c=relaxed/simple;
	bh=ptsqSqWBW/nazziJ93E22JgLXir7O/lk1JZ3GZ3h+PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2tQKgqYFf9pVvMNeDInRgzm7jrQyx1jxdKJq/iMjdb0HIdqikaxJ2Cdjq1/NAx+c0XClk0AMDjv2edaKN2tG4pIvYOhu10Rjn76mrzDknpqpgi4Mma+Fegdb6qI1vz0CYtvPtIZtIjytRd8QbynLiIBjVOvvnv5dOKt/6FlWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNHmSV/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C3EC4CEF1;
	Mon, 27 Oct 2025 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590577;
	bh=ptsqSqWBW/nazziJ93E22JgLXir7O/lk1JZ3GZ3h+PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNHmSV/HEknYdzI+YTnN3QpiGnX8AZLV/RXsS2BLvEnIGEDLFrjiLT7A5ywqVhTb3
	 0Vae5bE6Mu5BBvxUNB5PPAIzxFaM9QRnEtgxU30PXeT0s23xVX1XWdM5b4h78kM4E7
	 fay69VkTUmMWJZX2sF4J7xVAPY0flTfLAR7ct1cFXe5eIzJTo7mmFOcBFeuopILvJN
	 mp9J+jhnlaZ78lUGgX3BSi7ts6RCgsfsXoZTfoUB+R+Wfi2t1afhrTW10eJ3uQv/+W
	 /B7Ff1/u0+LOWwMYP3wN5uuynrIJMbglJyrlFxzdBiTQSPm5LxRjk690CbFqFdbej6
	 VTCWCuctNH1pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] xhci: dbc: Improve performance by removing delay in transfer event polling.
Date: Mon, 27 Oct 2025 14:42:50 -0400
Message-ID: <20251027184252.639069-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027184252.639069-1-sashal@kernel.org>
References: <2025102714-patriot-eel-32c8@gregkh>
 <20251027184252.639069-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 03e3d9c2bd85cda941b3cf78e895c1498ac05c5f ]

Queue event polling work with 0 delay in case there are pending transfers
queued up. This is part 2 of a 3 part series that roughly triples dbc
performace when using adb push and pull over dbc.

Max/min push rate after patches is 210/118 MB/s, pull rate 171/133 MB/s,
tested with large files (300MB-9GB) by Łukasz Bartosik

First performance improvement patch was commit 31128e7492dc
("xhci: dbc: add dbgtty request to end of list once it completes")

Cc: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241227120142.1035206-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f3d12ec847b9 ("xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 004e69f424860..ce56b9316e124 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -987,7 +987,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 		/* set fast poll rate if there are pending data transfers */
 		if (!list_empty(&dbc->eps[BULK_OUT].list_pending) ||
 		    !list_empty(&dbc->eps[BULK_IN].list_pending))
-			poll_interval = 1;
+			poll_interval = 0;
 		break;
 	default:
 		dev_info(dbc->dev, "stop handling dbc events\n");
-- 
2.51.0



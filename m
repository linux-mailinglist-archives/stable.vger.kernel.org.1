Return-Path: <stable+bounces-74695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF429730CA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0F1C24AEF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E5190472;
	Tue, 10 Sep 2024 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EPTY9AZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC819005B;
	Tue, 10 Sep 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962555; cv=none; b=q6MPlgGbtY+6caWI8EIW1y3ZMXcLu+sTZl57ayimLYjUYB/03/O8RFpV/EkDFuu8me029ntu8uPbmaXTIQV5yX3bMZR9yBn793wEuCRzSdcEN4PmA4Q5gS0yQdSKbCtJmxBW9CoHwOUBofM72DjbeTFhAYoPUZJtAK0K0r8RoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962555; c=relaxed/simple;
	bh=p91ECu1hXXC6sNqXKQ2rWbaOx2oiIbfdclGqxcJkhZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFBqpheN5TjJF1f80Z5h9usZfErelKaCeG0XYOpW/Xo5ArEhhR4OoQFm8V44lXzg+xftwjQsS8XkrMk+1mrBdwKcIjZsXTGA0x5L/87+u+d/m+WGEdfWfcGtaeyF+jNnjBzNJQzoOuQXOfs51LuEfk8iVtVDfDx9Zo9Knu4Nv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EPTY9AZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BC3C4CEC6;
	Tue, 10 Sep 2024 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962555;
	bh=p91ECu1hXXC6sNqXKQ2rWbaOx2oiIbfdclGqxcJkhZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPTY9AZHmuAS1RIC5hlt5wgaTV5psZIImfjLAV4BnVmnNm9eUh7TJ2zOKc2KvJ6dm
	 Bh5HzlVrCD3uy/Axx5Gho/8w0kFKndEOQ6wClzI1v2wROqU3tqndNtAwAqUEwKn6g8
	 WkTZeFSqn4Pkx1+N4JQ602cxTzszkwrz99SFAgUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 074/121] devres: Initialize an uninitialized struct member
Date: Tue, 10 Sep 2024 11:32:29 +0200
Message-ID: <20240910092549.410938486@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 56a20ad349b5c51909cf8810f7c79b288864ad33 ]

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/1719931914-19035-4-git-send-email-quic_zijuhu@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 5a84bafae328..be87133d2cf1 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -561,6 +561,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.43.0





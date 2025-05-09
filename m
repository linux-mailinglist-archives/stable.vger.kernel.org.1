Return-Path: <stable+bounces-143044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE98AB1271
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 13:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C379E465E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262222CBFA;
	Fri,  9 May 2025 11:44:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0317E1
	for <stable@vger.kernel.org>; Fri,  9 May 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791075; cv=none; b=Pg/GtDYlqpM33E06fxsoEVfN+7hs9EWPt4h/fpwyDIt4ZhUYYxFw4U0WtAYSq1p3fEcf9mQlap2tiqVhqk7THm+/l17LMfa6V35VwQv9vHihexgJoWljJbXlOxBOOP70XOvHzgSLSaTpp30wVZCf59zmePZix9y7zsQ6oC8DWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791075; c=relaxed/simple;
	bh=AgiOgoGSwxLuRPfn3NH0JgOjnZXZiFra1/KdCQmqm7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQjsN6Gv8EbTkZWJNK0saY5Ppv2jUwF/I3K8ZbhALluKik15MUV4RaVaUOoTq6osYBhGMzplRPjjx2exZuz9vsEZMX48NEJbOweZ814xSmQ/DWEHloMKxICHddsVORLZR+0y8BkX3hgRqNT3LT47e5wqEbrTa2l52s8DU/CcYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 144C71595;
	Fri,  9 May 2025 04:44:22 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 938ED3F58B;
	Fri,  9 May 2025 04:44:32 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: stable@vger.kernel.org
Cc: Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 6.6.y] firmware: arm_scmi: Add missing definition of info reference
Date: Fri,  9 May 2025 12:44:22 +0100
Message-Id: <20250509114422.982089-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025050930-scuba-spending-0eb9@gregkh>
References: <2025050930-scuba-spending-0eb9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing definition that caused a build break.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 609fbf4563ff..3f3701ed196e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1044,6 +1044,8 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 		 */
 		if (!desc->sync_cmds_completed_on_ret) {
 			bool ooo = false;
+			struct scmi_info *info =
+				handle_to_scmi_info(cinfo->handle);
 
 			/*
 			 * Poll on xfer using transport provided .poll_done();
-- 
2.39.5



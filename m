Return-Path: <stable+bounces-25873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA486FE21
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495F8284248
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD4225AD;
	Mon,  4 Mar 2024 09:56:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10B249E6;
	Mon,  4 Mar 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546175; cv=none; b=EUbjb6sPTUcMcFvdTwH+A5HKBVSajVFxXKmkVkG1Vs5nTPZ/pT62N9IkMbQx0EuGFIKEYicZec+49RAZZxx65IYjZuIwkau1IN/Evm+IzaEEr7aYy5DitjlcFtHOnpeK+X3IQXr0q3sKPLJSmaVvAdLzz+4doiCDyvnfyOA9KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546175; c=relaxed/simple;
	bh=lPMlhZe6Zu/FURCZR//Lp7oBo0dSFp8zW5k/9lO6GAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D0nL3BLixh0opcXjWfE4Ix0HRYC1nBXZopoo4PkV7xGNsCGIosXBOrzNeLfG00I3NZaPQFoCQpqs7xElwMJtYpuWPi3D85JmsxxKq1Hubkhx6rAheMJlGQw6Wikjb7vLeV606/hI/VuAHxYJR6YEo5qyEB9o46gzH3xn1sLyNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Vinod Koul <vkoul@kernel.org>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Ranjani
 Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 5.10/5.15/6.1 1/1] soundwire: stream: use consistent pattern for freeing buffers
Date: Mon, 4 Mar 2024 12:55:42 +0300
Message-ID: <20240304095542.4799-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304095542.4799-1-d.dulov@aladdin.ru>
References: <20240304095542.4799-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit 5ec0c8721c06fc55d8a0bb32c403228358987eb6 upstream

The code should free the message buffer used for data, the message
structure used for control and assign the latter to NULL. The last
part is missing for multi-link cases, and the order is inconsistent
for single-link cases.

Link: https://github.com/thesofproject/linux/issues/4056
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20230119073211.85979-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/soundwire/stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a377c3d02c55..ecde6fcb8be0 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -703,8 +703,8 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
 	}
 
 	if (!multi_link) {
-		kfree(wr_msg);
 		kfree(wbuf);
+		kfree(wr_msg);
 		bus->defer_msg.msg = NULL;
 		bus->params.curr_bank = !bus->params.curr_bank;
 		bus->params.next_bank = !bus->params.next_bank;
@@ -750,6 +750,7 @@ static int sdw_ml_sync_bank_switch(struct sdw_bus *bus, bool multi_link)
 	if (bus->defer_msg.msg) {
 		kfree(bus->defer_msg.msg->buf);
 		kfree(bus->defer_msg.msg);
+		bus->defer_msg.msg = NULL;
 	}
 
 	return 0;
@@ -847,6 +848,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 		if (bus->defer_msg.msg) {
 			kfree(bus->defer_msg.msg->buf);
 			kfree(bus->defer_msg.msg);
+			bus->defer_msg.msg = NULL;
 		}
 	}
 
-- 
2.25.1



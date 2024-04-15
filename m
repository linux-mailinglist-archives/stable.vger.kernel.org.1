Return-Path: <stable+bounces-39554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375278A5331
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABEF3B22081
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA6768FD;
	Mon, 15 Apr 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VceUb2r+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7674E11;
	Mon, 15 Apr 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191115; cv=none; b=pux0AM2b3FU/iwzzEvh9WeK+NWY/Sqfr7JeZQJbDN95u3WtkFWAFhDC98i23O8XuRH5AkVIhtbfJXZ7rlbVyUdPuEBOoizlk+GBf5SFF1c4B0j6xGbBdOU6EGRLyQDmzmkoCvkQzANkEEmZbaea35MfbpdH87W+GChcvlAWmMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191115; c=relaxed/simple;
	bh=04ytzuFq2IskGxiA+UPJyyfUee3BpOfpM8HnslCo2jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf9eeJU3PndJvDCm0bAYQF9DC8rvIz14Bz24hxmYswdfC5EILeD/lDLjHMRema8xfKhlEVw+PNpezVM8TxugJbL6ApONzXNoFY3eMp7oCLsLEy5Fq4cU+9viCts0z1IIh0vpSP/dcti+GY9gSX63ywk7Ylpjz0EzcJsHfkN8HhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VceUb2r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A89C2BD10;
	Mon, 15 Apr 2024 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191115;
	bh=04ytzuFq2IskGxiA+UPJyyfUee3BpOfpM8HnslCo2jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VceUb2r+yf57U3HWy4nCmblGmpsMSQyjEvvdU94iP7zhNm+OArDUyw5JJ/l/BG9w9
	 VHlCrJZv4H7dwpYbT/0Cq+QoGKLu0g296Y3fHjYUPr+hAPdVTv7lPMnCQe86qiuKME
	 Gw2NFqN+KqwCf3j0UJNPnTBMxan4s5lrKqQ2FwMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kwangjin Ko <kwangjin.ko@sk.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 037/172] cxl/core: Fix initialization of mbox_cmd.size_out in get event
Date: Mon, 15 Apr 2024 16:18:56 +0200
Message-ID: <20240415142001.554756211@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kwangjin Ko <kwangjin.ko@sk.com>

[ Upstream commit f7c52345ccc96343c0a05bdea3121c8ac7b67d5f ]

Since mbox_cmd.size_out is overwritten with the actual output size in
the function below, it needs to be initialized every time.

cxl_internal_send_cmd -> __cxl_pci_mbox_send_cmd

Problem scenario:

1) The size_out variable is initially set to the size of the mailbox.
2) Read an event.
   - size_out is set to 160 bytes(header 32B + one event 128B).
   - Two event are created while reading.
3) Read the new *two* events.
   - size_out is still set to 160 bytes.
   - Although the value of out_len is 288 bytes, only 160 bytes are
     copied from the mailbox register to the local variable.
   - record_count is set to 2.
   - Accessing records[1] will result in reading incorrect data.

Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Kwangjin Ko <kwangjin.ko@sk.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 50146161887d5..f0f54aeccc872 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -958,13 +958,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		.payload_in = &log_type,
 		.size_in = sizeof(log_type),
 		.payload_out = payload,
-		.size_out = mds->payload_size,
 		.min_out = struct_size(payload, records, 0),
 	};
 
 	do {
 		int rc, i;
 
+		mbox_cmd.size_out = mds->payload_size;
+
 		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
 		if (rc) {
 			dev_err_ratelimited(dev,
-- 
2.43.0





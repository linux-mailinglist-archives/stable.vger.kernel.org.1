Return-Path: <stable+bounces-163637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFEB0CF7B
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 04:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419E03AE6BC
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 02:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0608018E25;
	Tue, 22 Jul 2025 02:02:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1E78F45
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149720; cv=none; b=ooonGorkkfQyGILhzWoMnXsaaAF36KYilgzccb7fJOmvr9lHtDDZa4IW+8IRmLtJZNEpOJNWAAKr23ffta6Md6bAHN9doEISlqY3wPeoOcYafH7X+O9dL8a9jODtGR5CDbn+1oBG2mj2oedK/Z9CAFB4iIQaXyxODm9p4bsBxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149720; c=relaxed/simple;
	bh=osp4IuI9ZR9z66IEDoOfp1wCdDh9P6j8qg9m9y5pwos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV71cg2KHRzzm5carJUwWqh1PTmWZoqHcYYqei3EtcU8W67fKmjS9lMClJOJfjK+S/EQZGNLobqIcAlOLB4amYV6V4MEdeVaiGbnFajDfra0f1OycXkR0iz2B0LWXTcYPq4MKieRq9V7YF1FhioKG29Y1Tb/jIbG9Zl20wu7V+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1753149700t10f6b83a
X-QQ-Originating-IP: CT6bx6A5Sj7uFBfW7/8o5eYiiAxlrBM3wJ9h03aWusw=
Received: from w-MS-7E16.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 10:01:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2577949941488108746
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.15.y] net: libwx: fix multicast packets received count
Date: Tue, 22 Jul 2025 10:01:29 +0800
Message-ID: <528914E284765D4D+20250722020129.3432-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025072136-steersman-voicing-574e@gregkh>
References: <2025072136-steersman-voicing-574e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nve6/r1uoMSa1FvADTbIM72QBWfz3MJywCnYGYQB8hJPGqFsH/uPgrgL
	8ESL/a7Sp56l8uV7QZxAc93DmarzkIFpgbcC5xknUgI3rl6O84skU7AzwVr1NcTUZsOM11i
	8LUl0zzy2O2htDKVeE5ZibAQ7U44qjk+M+5OSBJSp60HiS5AQe6pv7e9I8yzJ4WliHjhbf7
	9pakhsDJo6gKvWiITuZH8AJ7ssZ+BFq8OwSAINwXEAqTxtCj56z8PncX6bZI5Fl7LXfH7Pm
	KRjRAkqfqX5n+scnZuI4BE2S4L/YxA/l0Os/WDn0X2pJi1fZSiRl6zJqKgebw/9FEslm1x4
	HNyVFCBMvbKkOaFxqbScXMlLJpFseCgrZpVwa3ut9F4cx6Sn/hzZ4F33RH5qtlXSvBr3rsE
	O3AGlG2OI7YAw159tZ3iZTZRhuxVL/X1vJgrzXrQlbpGpULWArCfAhvf9HAx+UiyVYHzWvg
	WuRrlr2IcNVb7sl0AG/2IyHJ6b6rF6CQHNMJxhekpEd3/aCITvg6A6QlySDfazzCwCGs2g7
	/erUFoXnB03Y3iIKLeCkdTHRc8pUV/+XrBQgJN6+UEea0jVu/KjaCS+xVNDCaqfUw+OKurl
	AguPk0N3Uffem5YRgt0zVJcc57DJno8f2NmP1AqyKMALd7J+K9dT0H+IVNVeCQIoqM/Ed0W
	JhmDeQ265md94ooaRSD+/riFmUXFlFul/CIJlc1fS1DYRo+buivUjB7Gz8IWkRVPVebE2ff
	lt4rrJJgn2Y7TPt0+AVrY4ewvMVIzB9jWQrTNbdGWSmZRB1Vmrzl8V8cH+So4mpA1tCZKwS
	JTc8rNi35GOjreiD9K1tk3MyaWBcveKg+CiXFYlZG+a018JSX6JGW+fo7G7xl3hDB/7RSSd
	1Yx4Eex3+Kfx1nb8rt/S1Zsnw11seZwDKXRBnWHN0F/IUkhPowEWa2e0JZEKno9jTCsHYJ3
	tv5u/ZB4KG1gjmxbQ1oaX6STgT9a+hJ7H2M8QNHfArKlkdefEg1HV3rVz7FhCPoXadeku3i
	DMOmLkrU026ihgZQMKWd0K8u2pfw7nWMSDDvsPpizOtmL/sbv6DB83xsrl4sdn4ryoJzgJq
	F06X/YfdjHsyMAGuLNWPxw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Multicast good packets received by PF rings that pass ethternet MAC
address filtering are counted for rtnl_link_stats64.multicast. The
counter is not cleared on read. Fix the duplicate counting on updating
statistics.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 490d34233d38..884986973cde 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2524,6 +2524,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	/* qmprc is not cleared on read, manual reset it */
+	hwstats->qmprc = 0;
 	for (i = 0; i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
-- 
2.25.1



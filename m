Return-Path: <stable+bounces-158744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3486AEB102
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 10:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B636C3B9283
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E25123506E;
	Fri, 27 Jun 2025 08:12:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC613C01;
	Fri, 27 Jun 2025 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011960; cv=none; b=Qa6zNIiXH6ELf96JwPED9zHJKyw5PuXEYih/ggAl8uxxF3mhRHAqyofG2mZEN1fGfJdeN26NZlPU82eG11l4O6Zvehb+irXimaGZ8XgrGCojmeAnayDbV8TwT0PoTZA9CAtJxqvAL4UwToXR8gth3lr6XUAU3QPLDQtrLyKx3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011960; c=relaxed/simple;
	bh=ebVQ0A3hU/5Zztr0mcToWRPpdY94o5HaUmdOTQV0IyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyFLh4Fw2lKSK4/62YzD5KL4K0gqy9LJhDU8yz9LXvyF/m7GzEnsy734LYjiCYMeyxDQsn4/TYDcLXqsA7ShbGX5yWCGXKhVQ452F1lZkNxcgZzP513OAgxVufCRVAMSFQgZbNbm+2vAK7NUkN1+16JWkpAHNuOFiyQWRRSdXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz4t1751011796tf0bed90b
X-QQ-Originating-IP: dLd81xpOnw91kDLzRi/eNWHbMODsXd9cbmUNE83HUFM=
Received: from w-MS-7E16.trustnetic.com ( [36.27.0.255])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Jun 2025 16:09:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9987340576110294093
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: libwx: fix the incorrect display of the queue number
Date: Fri, 27 Jun 2025 16:09:38 +0800
Message-ID: <7F26D304FEA08514+20250627080938.84883-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M8Zk4Li7PoFirik9kQDftExlL36D72JxX7A7KSZH+H5S9yXzmWNdsCX4
	3Rt5issrIUo+M64oIwLwHMhXuG08ffICaLaxkqnuvTJbzOBkdqIPZt8RHvcc/dKk09m2J2E
	jPmO4ZBUcfq5S2fW8lV9GDC/ME51H5Ws+gYxL96mpTZ4BSUtgLbp3ByHOI8fxK2MjgaFPQy
	Z8i7ikQ7xixFyly2T1rrUHZgq9Gu2hIwAanj3hw998hVtYA7nXgcD4SXZ9kYTZWAt49Fk/C
	w7HUuV8RpkWrYmvRA5Z70F3gDQ+eTs6FO2pk+O/CFGMmQnv3kPMMwQ1N9pBvJMMUnAR0I2b
	8zZZTwgA8GvI3N19Dof6qizlfXWRX6orYOi6ucWVnG44Su8CEQogw3KWnSgVup8bbKHGFOi
	H5x1yxGRXS08gAzs8CVx2oL8gD9Zc65BFdi7BQtbeUp8hAciATp+CDTt0ZjgzKrzhfD3M0y
	D2EvKi/UgoQlifLQlInwa0tf/DrReCj3amoFrt+yhTtJlvblRW7ysSQ58EJdxSMDPhTbDCY
	iSm2tYQnBN6Y9JZ10UW9lnIrmWifcMQwNgDAPRIZEmwfK8apVDBduTtUXSRVm6qV+FH218E
	kAEMCpTZ0E7Tyv/BRj4DoUPzTqsrT1hH9CfM5iBbqOSqdifnkvAXX2QOfGaRayHNgVe1NVU
	mq3AmRUZbhW+WcP+WRAFLlM/eyYkk4w8KKXujvxyxJfQO0/hlILPMjpv4epP0KlyZMBXd7A
	YjW0PPe7gbovMOhugjwDODMAXPCZlx77c3X7Sah6qj78+EZd2U4xsKDibyw7O/Hcv4cUOeG
	889RZSqqUcoZVYWkwQ2Q1lFNaPR+LN+c58BJz+p4uv91MnnqOjSgmVXEhMrJ9UMDqEnkobs
	dj6kDjGOZCA+ZDBX8fJBUG3RwXXn4+cAn4XaQKNN8y8l3ob8sy+VcHSGYrIYoxyXpelp0+j
	bn3lBDRrSc03xuFW92lVEyS7fgJyvCyNOquL9pl2Q7pVpRH4AiVXN4IWhTq5IaVgp7Wk/jP
	uh7bu+Gn4jG6J/xSRR0fln2C/kubZr05APmmNX8LyIXZfrZxGu2N4q1Gu8wZ0=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

When setting "ethtool -L eth0 combined 1", the number of RX/TX queue is
changed to be 1. RSS is disabled at this moment, and the indices of FDIR
have not be changed in wx_set_rss_queues(). So the combined count still
shows the previous value. This issue was introduced when supporting
FDIR. Fix it for those devices that support FDIR.

Fixes: 34744a7749b3 ("net: txgbe: add FDIR info to ethtool ops")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index c12a4cb951f6..d9de600e685a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -438,6 +438,10 @@ void wx_get_channels(struct net_device *dev,
 	/* record RSS queues */
 	ch->combined_count = wx->ring_feature[RING_F_RSS].indices;
 
+	/* nothing else to report if RSS is disabled */
+	if (ch->combined_count == 1)
+		return;
+
 	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags))
 		ch->combined_count = wx->ring_feature[RING_F_FDIR].indices;
 }
-- 
2.48.1



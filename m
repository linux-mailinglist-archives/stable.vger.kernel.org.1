Return-Path: <stable+bounces-163655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC6FB0D1B0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5640188EDBF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 06:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0C21CF7AF;
	Tue, 22 Jul 2025 06:09:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328446BF
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164567; cv=none; b=FYkuVHnEXDhP3iN4zZRFvdx++mDy1Hlh+Dj//QVFwUUtXI512H9Pf1J4H/akE00BnjsPG1xPEXtPxcLoiEvrD+v8o2O3u/N8vjX7z+aj5WYlZCna+IY9ryAlr4eGDpTqSn/TI9U4m6wYL1wrUMdFquycgNA7H8sLTeUgWp0IL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164567; c=relaxed/simple;
	bh=4QN4YDFQaGlifaXxRU5S9/RoV/x3s/bnKVEs7XGYC2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5oUSFGCTcpAjHuXPI8B93+hiCkPRkUPPqqlWE1tYt4r9AXjMajKbLPAgeeysfmPYfdVEBCTCO8EmO+0KNl5BjdjGkiQXVncdjNi2nc8dJK6jWUYv17EwY7hv0f18Y3pCutfvt6IoKmV0kxSIa1oupUQacjb2q7NPjW3gOz4+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz14t1753164543t88cff806
X-QQ-Originating-IP: rqEr+Y/16P9O5bzLjJEx1TGhqKNbXr40U/oNM0D9r+8=
Received: from w-MS-7E16.trustnetic.com ( [36.24.205.22])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:08:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8994794122451351785
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: stable@vger.kernel.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] net: libwx: fix multicast packets received count
Date: Tue, 22 Jul 2025 14:08:54 +0800
Message-ID: <1FD2A049AA18CEF9+20250722060854.8327-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025072137-disarm-donator-b329@gregkh>
References: <2025072137-disarm-donator-b329@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nv1Zs1ssfOILRcHuGSlW2qs2cISrXSuBpb2E7aLgtvE/aP/F72lEn3uR
	KF8gnrPoc9K7AsRM94PQ76y9IrldYJ0JarQtOTX7urPtjr6R4IADULZpp85531ZvTrYY1Z+
	WU0IhCgiWR8AbAKSwTXYFrFIjonlgT5pd3OBbHWnkh0OOAh8Xls0d37knYJ1+cjuRypim39
	eUE/NSyWGwDQMZ9k4sqXcJ9Vdz6FLPbbgvBHmePHxSA0Mq24JzIXkvqYO5nHYecqVq+hRvv
	+V6j+iKKpM8TbOhXtQePtgJFmUrp/hKeynI1E452qcoE0WqkqBaX/i31nQpBt8rElgOBHD0
	Dia/7zE2XdXFePgh/Ecx0oYV07beVgmS22hy+YkLwD/qbGlKeyrze9KJuyvrxSqOjtz39VO
	2DCpTQjZBFdofCfwBG7NLtoqOJ5N+em+xws47b5oLFLFroL22HVx9RJJxi7TBzZKUjmovnA
	Ad1K/VcToX825p8h1KToLVUGdO9gtjns++BBsjIP3iKK6Fr9xf5FgmJzcw6ps9IGy6enDaz
	qQxWdrXWJ52WXakqyy9icGMQbLtWREqVB16r8a6eiJRn5wxZYqiBJbNFuzBKV+F4nDc+nNw
	8UqKX039BnX97pqiiWaQRPwqv/JxqXnBSw6vdx3AAoSWqK+0EH21W/XzVXi7UqQIZg42SuS
	5IQZQet77s9lFjLrPfzXSQJ8Qfbm8gtm43VpuyvgCYn+d+Yzvhe+H17RMLFVoeTMjwZO29N
	2BZL8jMDSk6YUgySZdKIpKfTJFR+c7lQAMpcn7PdrPWthOyRajY3Qz+pN/xDkAHQAORaSM8
	4pXMP/JE5kdnoLir/DAIuvqNvzydXX1HegLsSOLX6LyrsNYEOEtAA4KGgOnIj97WI3TCg88
	Sp6gDQlvbOYxmyfCEiVaHqCvznFOBpFI1TlHlKSyYckR82SGHy7SYV6uXfTUdBl7zWHqRf+
	cvMj40XFVA+3gK8/wKuZHxoZc2MpGXfrq4+TO4gCBeUNF0QctEnEEYue1ah7tv4+BstXA6z
	NiJpgRe0IlBWIDzphRfMvulzot259bRGPkas98fnnWJWg8GJMXZqBYd6suOY1FspJrUbYjJ
	PjERLCciLFh
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

commit 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77 upstream.

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
index deaf670c160e..ac5957d31674 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2356,6 +2356,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	/* qmprc is not cleared on read, manual reset it */
+	hwstats->qmprc = 0;
 	for (i = 0; i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
 }
-- 
2.25.1



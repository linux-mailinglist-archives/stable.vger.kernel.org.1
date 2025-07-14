Return-Path: <stable+bounces-161793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A3B0344F
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 03:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D3B189A0A3
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56AC1CAA7B;
	Mon, 14 Jul 2025 01:58:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1B1B040D;
	Mon, 14 Jul 2025 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458306; cv=none; b=rRZcPzbMp8pXq0wmrv2jdPW+dHWDLUQaapORHyeMteEBBCYPZr+EIbz/4OQ7tubMPcBxXcLLEb8zWdYdgwUPLfcAbU/66BVssJdAkQPTcMZF4KXuW8MqeyTsIFmUDrXD8g7vM3QV4RODROKqyfLIbh9W5Y27SWxShmUWsl3dFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458306; c=relaxed/simple;
	bh=R2ppnCArTRe6oY9Q1sM2BxCrBm5PMsCJ90cLN7LC9UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+B1dmFtyYaZmtkiWVK6qbkiDqzqbLtddE17WNbF4fYx47Prwhp12ovWjPQTUOTPRe+v5FSLT8z9LwjTpstL/1vuTF996q6E0DqYmlz2J2KairnJGYYjWO0o129Ux5hrI8sZNU/lmwhvIMWIHT61Gqe9iwvZ6RNgHxX4j8SLn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz16t1752458224te8f4a055
X-QQ-Originating-IP: zplujaUdt6mbLDRbfjmDK1I4FyAPTW/1vdcZELaVOf4=
Received: from w-MS-7E16.trustnetic.com ( [125.118.253.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 09:56:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16147544015878267949
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
Subject: [PATCH net v2] net: libwx: fix multicast packets received count
Date: Mon, 14 Jul 2025 09:56:56 +0800
Message-ID: <DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N0mS+7D7RQfj9Ots3VTYJUVkGXQ39v+FqVsn2VgU9tQNwLdioq3S6zjI
	gEaQoC57yBh+TfDrBblKTsJCLa/uPOF81BWNy/oxd2zb7fSicDf51+0dZD9aH3x+4/C4wGH
	QZoBLjfzDq/c9zP5aFrOyEouk39dLPh/H4S+plbuTJRU3+TuspZt7yKE20ldtt3BkWYImSe
	+Rrjp2gaHL06SUHOA7j5KTGEEr8wjAwVwdpl3X/c5Shk68my0FfV2t96ZaHYsZ4jqpnkTPF
	dlBB7AgyREkmNGmyJ4EfNaqvhf5JZD/pLP/oxHe03r0gMG/9wx+uOvd9dFxCiHQWUD+RKWY
	BIyl4AI29ty+xtSGW13k3c9fBJRGhbMB2v2HWtnJxHadszRCWJKwKsEnESs1GZWE5PZY6E9
	LC+sEU/+Cm1fcmsHZdT5g/KfhueuVAg/fyAgIacjd8pCcE1YvTR8XVV63WO/P+SVbuf6gmc
	et86slqBmiBBhGElZ/85ZgJg3QDiNpmL2oZuv0BWoQ5vndrzIAJl4cWdAEPfevMJ3Sw95Nt
	1EBR2bSckTUeNag8kb5tPX7h4IZE9V72cZ4JqQpwaYyUHAjM3iza2lflegEJ6oM3cmh9N2t
	QvVvB/P8stJG1gWVxcEDT1cbaUQJ/lFaOg86Np6tSH1SOByFzJoIAOpudJ9U8j1hpIgdgAg
	XrMI/sqXM3hz24zDPLLGna/vt1+XCw5Zd3NQLcRKENYIFwe3MkDvb9Sk2dERdld8E57TXxF
	P+GxD26U2/J1+VOUi93pKOac2DZZhGP6COi0foTbJqLbLnph8CDrH0GsBLPq/RBklg/z8Ui
	+PAip+/NEmdNblPIpyUCFs9W1fVnPEu93ijQ9as0MyqJMzdIWiryyMD0PLHyuOguQzO+IvI
	UUhHfEErdPwCokN5my+yvEWIVj8hbSclJ+4GNI74oPsZXWUD90UZ9CCZ6L6OPcqzrQwUvbI
	BId1gkUKZap8mFNa7cEOk0nCJqjnRYQkLt4LOxadrQ0boXhfyohfnopaigPExBbjFLD1VJR
	0D45iRIL/P/j/e84garQfUixJihYU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Multicast good packets received by PF rings that pass ethternet MAC
address filtering are counted for rtnl_link_stats64.multicast. The
counter is not cleared on read. Fix the duplicate counting on updating
statistics.

Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v1 -> v2:
- add code comment
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 0f4be72116b8..7ae3786d90b8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2778,6 +2778,8 @@ void wx_update_stats(struct wx *wx)
 		hwstats->fdirmiss += rd32(wx, WX_RDB_FDIR_MISS);
 	}
 
+	/* qmprc is not cleared on read, manual reset it */
+	hwstats->qmprc = 0;
 	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
 	     i < wx->mac.max_rx_queues; i++)
 		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
-- 
2.48.1



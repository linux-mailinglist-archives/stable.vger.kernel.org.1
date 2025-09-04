Return-Path: <stable+bounces-177691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61741B42FEC
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 04:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 006F57A2EAE
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A521FAC34;
	Thu,  4 Sep 2025 02:44:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030C3D3B3;
	Thu,  4 Sep 2025 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953861; cv=none; b=Vzx/GY8rBgPJlZS0DzavBJtR7kiw+pLt0C2wJKo2lx+/uZ0Tbxnk/hj7nKZRAGRnLYfSodlblZguQOXKSXrc8WVEods4lJNJp6Kz2tz5iNaoCdp33xiFTJy7vSa7x6Zy21d+/iTO4YQSCskQNhZN9+ErXiXg5T4e+zESgJO5JeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953861; c=relaxed/simple;
	bh=YD66YwuccYWlGtsvl6/LekcqlHOc6F23rGa9SmBgnIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZjhl0CF7k895UHvXNgAXbiiwh/FyAURs9defzs+8Xx0aPJHkEcH3zZFRyPkBtfmP61SP3qrTcWNvE9g+cqECYoInjbl0V4YDE5nXrZcx1BPHTg2jV+ZDjjdMXHM6lN4s9oiCM80PrMi8Z5GPz0WsYRqPR9LVEN5Ks+9hw4rszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz9t1756953810t61745008
X-QQ-Originating-IP: r4jLfxAEOjy/CIM6uw4DmMsIuAr4joTAjuWm/tUcR+w=
Received: from w-MS-7E16.trustnetic.com ( [125.120.151.161])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Sep 2025 10:43:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6762453813770135688
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: libwx: fix to enable RSS
Date: Thu,  4 Sep 2025 10:43:22 +0800
Message-ID: <A3B7449A08A044D0+20250904024322.87145-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N79g/BZ3s2bFgxwzqtbSDEol2pNUO+JydbO3KwQgs1hwlwtsUK9FN+lo
	UaoWWqv1r6ouBlXOxn0YY418ygL7SpJ81TwqWxYKJDMbSTGZE+oKeTOKhWIiR8Yix7dFrov
	CrJq9c4Q3A8MUwu3M2WxhfJZm/eZMHQkt3VzC9X2umSqj7Qw5VOR6TEAUNIzhMcAHucpPYI
	r/SOX1orpS12eYAwyARKHSHxPFH/JnEGok1Lk2vFwuVkFBr2jvNuNRINjUqFuh4nViJpFKl
	PQoUOztdyBm2+bVtGObLUO3P1/yeoGs5ib0usuT6RTrWijcjhSrtuK7/0+SHB3NtGHYW2xX
	Q1rAAzeZcsLFV2Di6jLrcuaEZ+38AmxfAD0Kp13bUtz+IEq8fsYTvGq0QnL7SMMp/ohMtP6
	r5/3/rBnqAuSQI6/yv+auVxXFg3Vj7Mx+xomYPjL/9SGsc/OXIKH+NZlQL+I96usEgv7ok4
	guPWLGPrE6YeQMkKsfbPmIkDr9dnqvgEayjrglaW+iHYcHiyYIo3P+yIFMqD6z4KzzDcSfA
	QDlAVgWIEY7OSCbkHY8pr+VIg4YHnoplsV4Wldz3a8XDT0lxc+T4bWCO94Xrtp5wLe/yQQe
	Ql3AmOOzq9jCTNmpZjJ6fy1lW6G32GwvVhEet+fpCGQzON/tPaaK53P7UxEvZ7jCm+27Nor
	DLMZeDXifwjX0DdZNvZWq6O4Solt47hB+OJaBmIwgefW5dXc5k/xqRrCsV/mffePHIDPWGm
	mDE6AfrG9XzaMPupi+p1bKYg4j8m3CdNSStlQB0CwHEVLBJOpClhsS0iMTD09QawHZvjtfB
	4xdlqtewfwbGOzLqZZN4AjCbzoHN2hTQvBpRi+b1moKVnpPROk+54BnCib3lNhoLP+uTYz2
	gHRHj2nBKultejU69y5D7D/+2mkS4jiRQ5opUOMqu+XcooCxM4Xxh6sVdP7UtqBfjkq9FlL
	t4n9Tuz9vUB5JGBMLUJCBOOoLlzvOQBXXsHen9yMWHZGwHQAOpxLvHVxgZbK0SpWHpKjO8M
	vntDzU1Q6+qdBnfh2PKBUTcJudYFbFkOFlf03rJfO3aPBi4sYh
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Now when SRIOV is enabled, PF with multiple queues can only receive
all packets on queue 0. This is caused by an incorrect flag judgement,
which prevents RSS from being enabled.

In fact, RSS is supported for the functions when SRIOV is enabled.
Remove the flag judgement to fix it.

Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2: detail the commit log
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index bcd07a715752..5cb353a97d6d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2078,10 +2078,6 @@ static void wx_setup_mrqc(struct wx *wx)
 {
 	u32 rss_field = 0;
 
-	/* VT, and RSS do not coexist at the same time */
-	if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
-		return;
-
 	/* Disable indicating checksum in descriptor, enables RSS hash */
 	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_PCSD, WX_PSR_CTL_PCSD);
 
-- 
2.48.1



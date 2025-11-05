Return-Path: <stable+bounces-192470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45335C33BDE
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 03:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3C224E4904
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E42264A7;
	Wed,  5 Nov 2025 02:10:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C371E376C;
	Wed,  5 Nov 2025 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308606; cv=none; b=rNEygV0vaO0q1zgvSxMVeSGe29fKBF7Y82p232v+YMb1125GkPqmL6LZUJp2/7/9Wz/CMuoNLBJuZASgq5Oqdu8+OFIT0JLg8bZgmr7Tt2zG0v1fwzzOyKbguBYf6lvIvdjkE3AQGaBVWpMJWbcqsnHbiQbP4+O4tAHydiRfE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308606; c=relaxed/simple;
	bh=lnZwJq6PkoYO/Hvc+AxGWuUMIwZETApGOXOUVFti8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZvASdB9msZff5yyChrp0H64fowLvULpbhtCzzQyauhDENyHt0V5Fglk5GYQc2AtgvWQ6/svA3Mz4YIafNrMkeLkrKWmCHKGS70vpwhBzXmHDUp+2TUu2m0vWnwX7/K1LfHycCkhq4d6Lxlmknmi71vMWXsH6NGWmiXAhXHGUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz15t1762308484t36418741
X-QQ-Originating-IP: d7zhula0p6w+cvd3J1ir/MdpTY2J1CW5Y7dnjMeD77U=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.67])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 10:07:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15245211832796722694
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: txgbe: remove wx_ptp_init() in device reset flow
Date: Wed,  5 Nov 2025 10:07:52 +0800
Message-ID: <17A4943B0AAA971B+20251105020752.57931-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OE2BWzPe+8GtYmIsD0AMcFQ7tNkv7RMY0S0THv7HARzMXbjDf7C8+R+N
	ohESmkQPSZdKC3CNcLc8/d4r1OcR+d5eMod+8Lsu2L2stI8zr2oS+t4zqKo1nnJ2D88uVW5
	g8xGYM/M/PwBM4yWcXe3Tt67q+dlirv5gtFl8G88s5fz4NxIsuS0g+elnzy5RDt4Q/qJkXt
	zYaE5+6R/j9JIOdXbJ5FiBCX0im5lFkM0gMPcuUgV7zqARj4TtmPLlZTcqiAusf6z+N2Hbw
	EWTV1K7nPt/7Ucq3cUVdRwjF84OVE356rFRS85vh1BiBD6+b/QJF2CDzH+Lkk6ebqhbNPcu
	pT/iGQ5NZtlSbXqABRpfxcGjwp7dC43Rs8crjluz4SIlZOVuALKrRgbF7/6MtKyTE1DP2Lo
	zJNuT8KyVW5N82gadQMXkSbw62NtPqDdWwe2LEe6/oBoJBfyHo2T7EDoGl/ujScqmbj1whH
	Iu7SUKHTu9svdkAK7J1lGDABmhTyefcEUEUIsvNwadtWxmjpjytzsDIK3iy3hmKaI+ifLh2
	wN8jE4SUQbDIC56WzHSTWEX7W0p1ANaQmSK9GcB1HBZZ143jcdO8qazTsxj/mGZTJSUwuR/
	zdOWT7puls1hjqeD41sqdXfTH30QGAEOUhJqoBg51kE4iy6l7dXd1aXMSi0zZg6yFXMv2Jr
	b4xXAhSwdE1E22mtLS2t8PwOdOuEcSS7v7+Y1o03OuPOTmuEWo9TR3P0RAdsZZ4vfQfDN4j
	cHcq3rfWK9NhntB9DNWO5iIblesJEw2F3HEAFfgolJ637AbkBwD4HlqZx/kza4OeRPK+yX0
	SEih1jvO7HuIwmmTSbXhPM5omO8+UC0OUnCgdOVd1b+jIxMpLkKfHfmOmQmJRXnbMbaGJyg
	hr2vYDS3X2JuHpk3NRzRXMjOh1B5TQukQam6H/VbCU20KIQqYUzVX7+tkAcxrnVOybjxRrX
	dRab1mBqgMvL/V4XSRckta4snfzzRcNF42H1Rm+iEIZ59kMMO9ewVhvNNb30pu7P/IyhVaq
	59H8NeL5GLiXBE6O45dXQQtJFejyo=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

The functions txgbe_up() and txgbe_down() are called in pairs to reset
hardware configurations. PTP stop function is not called in
txgbe_down(), so there is no need to call PTP init function in
txgbe_up().

Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index daa761e48f9d..114d6f46139b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -297,7 +297,6 @@ void txgbe_down(struct wx *wx)
 void txgbe_up(struct wx *wx)
 {
 	wx_configure(wx);
-	wx_ptp_init(wx);
 	txgbe_up_complete(wx);
 }
 
-- 
2.48.1



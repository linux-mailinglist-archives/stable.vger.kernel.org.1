Return-Path: <stable+bounces-176922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF138B3F28C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 04:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812C51A83B6D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C872DF153;
	Tue,  2 Sep 2025 02:58:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953B242D9F;
	Tue,  2 Sep 2025 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756781928; cv=none; b=mRK0WTqTTHblB+FN5Vt13YEpGJymFpp6Gr3EOXYuHQAl/8WuE07WHFZPgBFP+DERzKB6w0T6VtJci0yH8Vgqy1jZZx+URqKkI1hWrAdMxr0OBmbs6/S+D3jmSamBX7kRlKuufXLY5L8hx0WFbvElWGE+bbhIhjnWjbu4UXZ5suU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756781928; c=relaxed/simple;
	bh=98nSgzsTtX8C7AGEiLA4oJ/sFpVoSU6MJHMRIDOcsYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lw8FrShpTiNZDEQ0DOEGxicZNdPlXYt67xcN6gb66wasQRIm06l7vZVJPSK8Nykcns1CY6vwo/+g3GzrbWMxQcsKk6hkAtYr6yC1tglOuakG4Y0g1WpFfFBQ+LlDBRJ0XxYDv5MDksZeCW55RSQXcgC791ldIeDPXl0RW2MejB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz11t1756781850tb324676b
X-QQ-Originating-IP: 1qlCU2ERdSdj86qPuGnRMxVbir+zAuT1Wt5T+yCWBPo=
Received: from w-MS-7E16.trustnetic.com ( [115.227.135.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Sep 2025 10:57:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9528628371944179183
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
Subject: [PATCH net] net: libwx: fix to enable RSS
Date: Tue,  2 Sep 2025 10:57:13 +0800
Message-ID: <11AD624D55764BDF+20250902025713.51152-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M0vknKB9I1DpKfmYAjXYd4wclNITD/hvuz7hCwvah1UG/TLPElXImTHV
	5Pjn6dFYbKrafgF2GKYVpCcmzCJlSvDL4IsuyrWdRGjoKfzE5xyYVK9ivypu7U4dSwJjweW
	coUMKAT5uHWp+NxmT13WymdzrSOMq9W/6mIMuy6nNrVf6KmYFMWiSsMjASiP/9ThgoY/CQW
	IYIJ9/pmCn04PjobHJbGMUW8V25/yFT6lpWpy0xeKAVg/elIfkvQ2NcPF4G0ABfcYjqizff
	n4iRbS9rYOxnkL/1SeBNBra3Qlg8XQZqyRkM9MpayJTiO/ehjeH+S5u7Hhs3mX9eX6VKgAP
	iQa34yyiGD3aTz6Ue6Bw6t+SjDe7npZesOJpJ+xkZyni+FolbuaYWYCTYVDTbf7u/Cgfwu3
	U8YltWNtrlq5TOkrhYKye5ON+Hwe/mDk7W2d1modeksyQ5XJUECrxekGzaVzTLUhlkfyzas
	V7caYtmjTCit2gJIN1+SXAqk1BsBwAxwWdS4sH2vTIEoAF2kJUwgUL+ED/F82GpHUJ9BMuu
	tu8AfdH35QdQI+L253DmMfRHalahI/g+pO8fOSQzall1GJnZJ0AazJU0LzdQV0S8lPBiCX3
	RlTomuyx52y8oj+qsaqaYh5Hunp9B+8rgXUsle+YnfbxYEeWcfRwpb08knfE2A55Hv6i6HO
	5b8Nzc8FZmyBhkNHff8uixJQJk8cShpo0ko7p0HJpp4hOlX78oJUWugyfNXNUrKGn/8pWzr
	TCvy1VAm0hHe+6+68YLVFPT7dzKNqznDIkha8Ef57ltYenVdXg/DxbJCW9sYoMVLXtTrmKL
	48/R1MF2t76zsBI3WQaO95ep0V4Q5yhlcb2xt5QaE/O7UiEVYCXbRhRomoKFdiA7SFAn9vS
	4dwNL4ayqtcjKL1rtXSU4SCYQmLWqmYHle3dFLVgULXGyGxldNAWRhseod0hjjcXRgWFmGE
	Y/6RZLRwg/tWWyrhSmbDoF6zv4q07y3S46hT99hlJbia7/1/UliM1BaLNrs86kkyYjPQwJI
	N6cB5pI+lWg25eBaA3
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

When SRIOV is enabled, RSS is also supported for the functions. There is
an incorrect flag judgement which causes RSS to fail to be enabled.

Fixes: c52d4b898901 ("net: libwx: Redesign flow when sriov is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
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



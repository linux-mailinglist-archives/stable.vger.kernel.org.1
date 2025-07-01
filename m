Return-Path: <stable+bounces-159124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D70EAEEF78
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 09:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957947A6EB7
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 07:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0225DCE0;
	Tue,  1 Jul 2025 07:07:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6C25D540;
	Tue,  1 Jul 2025 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751353667; cv=none; b=BccJWCayrEXh/vkJ1iZRKcCYGWwCWvj/f9EuJqfdC3JTQZa/3Q8gndnlrIG3WTir5Lvp7foYGoI0ZuT5M9kp5mFztwvgVSRUHlRna+CM7XiW3PD15TVqh0G27Jwk1QQkwqNsVzb9oKW9WywFnAeJD/4ENd/zYC8HqnV9Z5lnXHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751353667; c=relaxed/simple;
	bh=tlHHUGbzjnjjN1AZs4zuzQGO+7V9j+C7NJO8J51CYjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geJ7ZXmUZTAziOE6Dnq5HhemIz78P3LwRNnStrBT5+Vy2nzF7yRs5jWv2UFt4H4Y7knd82+TiApR7rSFp6WGH8gjGcTbvbB4nAs4yNNQ+DBPGTFOrub6cFgTkTfZoIUOtODC21MdSMYaY8W0XqsMYj6qcFmEiJQVwPbYC6Leaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1751353603t68e3e10f
X-QQ-Originating-IP: yI2vLUXjQkEwgpSf/7QTQ9oVnJy+8oBOlJIL5erspIA=
Received: from w-MS-7E16.trustnetic.com ( [125.120.151.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Jul 2025 15:06:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 780739241890360150
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
Subject: [PATCH net v2] net: libwx: fix the incorrect display of the queue number
Date: Tue,  1 Jul 2025 15:06:25 +0800
Message-ID: <A5C8FE56D6C04608+20250701070625.73680-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NxEuS4h95fr9hh5DY5LIi65bJ4InK3EIbpccEIr+osaQVDl9EkZmH281
	QQqEbw3n+8pDXa92GkWaSm8klTaI1eUO6/9lswauoSXpGD0lLlTD81c7eKd6yfFmL5NPrYY
	QnRp8V+v+qPAQdRICq4lw1wv1M7RDjAx7NGmkFXNeTrOrYaOFPbdVvTnq2cJNPTFopFSAjP
	L02g/spSPNPMY2ju6zBtQqrSy6iVQLkPHKW0ARlSytkfoui/aBRBJoLVBdgEYI0XquXCRtU
	o+bpA501uWFUa2jiHeEooRPv2iniOAftaXbpauI5CnCCnmejPAbLGejhHV2a/S6K0CHG6/7
	QSMVyFU13vjeXZLyJvUlilxFhDXoT5ohVkoQM1C5t0QXmNoE6puUPIpFW4eDCr0RXSg96dT
	qJByReEmuh5xF2+M6JCGWWhX6IioQl5c/hY3d2KnmFD/DzHGidDVZpWFYtIV55nhzbjOIHD
	GUj6NbJCcPPmsdU6gc8hFbgscVdiFS4vFLylrYNxT/1YguodKhUTBNiLLUr2V7VxB0p5Yt6
	618hy3hqkv7Kbz3bVI9Rj5joQbPvKzhNwQvBxfnk1FfKbAp25JAtGmrSg1QJCCiZlvqjzT9
	U5i9XwkC8ewp+gnYozegbdJFMafA/EDG/tmrGFOm34Mra+JBg4blmFwEM4+W2rHqEI7gQmg
	7FLJLtFonWqHBxIy5JYudRgvkZN4ilHZhrgGtpvvRF1KeRKiEl3+rbhbcL8Y7fN5B3qkco6
	bcTVb1H0KatI/QtfW5mtyqNqQ6U+dEfjrVoe4OnGxNH7REnEEGAyXTDyy4x7Bq0pSKQA+Wl
	7rpTByxamWmpfV8aYblo6A3D+8Cf6n7bVqVjSN+Ev2jW2L+jKm0hUsoHd6Wqh6Hw16MutOE
	4FtFZSaf1xtl5YasFVO2yOg6piXxkUMirXhLH93jE/CatPJvkdTqvL17Iu7sTbiXL+pBqB6
	qjDQBbX+pwOEWdyyXXyUAkMtbZ9LV+2Envd9PRtbyyI2iC7NXWY1MU9zUiI4sF9F7ee1yqJ
	7c69vUC5VCcDwwTYzOZxLfPJ0InuwHiLnfbEh+aJzyHEUI3O5P
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

When setting "ethtool -L eth0 combined 1", the number of RX/TX queue is
changed to be 1. RSS is disabled at this moment, and the indices of FDIR
have not be changed in wx_set_rss_queues(). So the combined count still
shows the previous value. This issue was introduced when supporting
FDIR. Fix it for those devices that support FDIR.

Fixes: 34744a7749b3 ("net: txgbe: add FDIR info to ethtool ops")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2:
- fix it in wx_set_rss_queues()
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 85c606805e27..55e252789db3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1705,6 +1705,7 @@ static void wx_set_rss_queues(struct wx *wx)
 
 	clear_bit(WX_FLAG_FDIR_HASH, wx->flags);
 
+	wx->ring_feature[RING_F_FDIR].indices = 1;
 	/* Use Flow Director in addition to RSS to ensure the best
 	 * distribution of flows across cores, even when an FDIR flow
 	 * isn't matched.
-- 
2.48.1



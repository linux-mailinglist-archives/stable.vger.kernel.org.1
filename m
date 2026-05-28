Return-Path: <stable+bounces-255071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAa8GiF6GGo8kQgAu9opvQ
	(envelope-from <stable+bounces-255071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:23:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DEE5F596E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C94306A153
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5F39A800;
	Thu, 28 May 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKsDATQg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNAiXosX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E628727D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988706; cv=none; b=FvBu9Gt5LTTBPg7LNoxbtB/OrmOmdXEndILRHAYfCMzoYRsDEs7tjcFZroMLX51axFQy/6TTv45GZElPi2Isf1yORTQqUSQmOiaFY76Ps/tdxpmbO9DRxoCsMkuP0sBbPGWV6Cmyv9gHZBtd1XiKf1NECJRfoDFt0UgxTz1uyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988706; c=relaxed/simple;
	bh=KYjKvckY/VAl6XCtEiN8jjSXIWwmJfrlKKhhzB3/mOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SguCJ/czdKrl7WvNLRAfQhxXfG7wJucAtTkqQ/DxLzUjy3FtHyCYVAOdgp6aG92hi3VqS19l8WmgOmyk2NZC5Qh0VCQhhe2IXBhaVlmHwVD5j/duS9ekTSS0iue4gUHjXRw8v6zGRzhJyzcUOlHrvJnPQLv/kIt1spPIgpuDk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKsDATQg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNAiXosX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SGd4lE3203244
	for <stable@vger.kernel.org>; Thu, 28 May 2026 17:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=861lfeuRlAbmY/H78CLEEr
	qRlCIH8BpNiqVeOaDNe7w=; b=IKsDATQgdKfOLF2p64CxsNb6cCr6SLakMEWPKP
	pTdtcdmevPWwHUyO9/VbXbF3wV03MpVMEa3KZmTlFTgM5yQMgZ248p4QtABfaXcg
	RNLMM7qNBRSL2Im9f/ds+qON6xLNyZxzK0+FKS6PtFgi/bTqLV6AMGsFhSAtZNaK
	ugwfdW/9K3iuK8UCLEZbfJDRP1XeUfOJNmD0L+qPDjrTYORSYPz1rUuM4OAf3qH2
	VZsygK7S4v2DBfnXw2ODHwJltO0YtMCHYwqSkWF3vh57zm3nYCV09WPp0zU/Vfar
	VJlodIDbycF1wQJLmayDQpObLnNr/nrHVVLZgvVhElS7Em6g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynkw5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 28 May 2026 17:18:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-369467ab5bfso11192878a91.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779988704; x=1780593504; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=861lfeuRlAbmY/H78CLEErqRlCIH8BpNiqVeOaDNe7w=;
        b=WNAiXosXnSVx5XpdnPEOy+hjfrWogNYPPEzfQq0AkPuYweldn0qRWgH99vtULOTZ67
         TON/oH3e6mDV9OZ8yDAYO14hNYv0fdUpsLk+FIVzpe8jtW7nFwJf36KvU5RHfmw6RwuD
         qkaLgFAdldmexVOhwgjMJiQ2+I1YJQ89Tps3pu187ko3EWpme7hthhLJcPVRewfi6y/3
         JnnVbDu9h9u1zlRbMnjOhmt4r3rFjO6VzXULHeX0MyUPbVf/dwXjm92C7DTNmH6LJuWu
         C10tIZSWTe7IqGDMxM5M6s8y1aNuVPMhaTSWcYSD3NASGxUSxsgMHEP4WSS7kgBtnCIu
         hfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779988704; x=1780593504;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=861lfeuRlAbmY/H78CLEErqRlCIH8BpNiqVeOaDNe7w=;
        b=bRHtzxQfXguQToN7F9vvhGNn4Bvp351J3rN2d0Bwtvrzzmh7XiUvmfl+3tE/SX9Duh
         Z1mPSkxNJmvJtHeCz38c6P71AC3vB5LMNFgjTN2QATRTfOq2pmRwAKhSSPIdOdizXb8I
         dFTgl9wzPCdyd6lhi5Ox18nP6j4ifx/QTjhrkqKSBl+th8neKqQb58Y36l8+KkJGVZHq
         PcnKcJnVTTO6NVd8UGMTpt9AwFfSUfNI6UNjdpJLBobsPEusVXWGgTLpXrFCe4G0Xogn
         zi6FpkbFJAlWPH/O7q3veLkmqUlnRVaONx2sIHZDwGIIe/+6kj6Ski96HTvWBkKqUXBO
         5h8g==
X-Forwarded-Encrypted: i=1; AFNElJ9JmIfE005Cd5LV6u4hzBnJhGgdeABFG/40fgGhcOCPfF8ohM0eKdV+5D40W6HC6wx2S3OpvKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyATkxYumCzA0npdhgLaOl3TFjKA67xYivmgjZLDONGD6bzZFS1
	Je2ywLYv36jdRtPSo96AJd4HHQYkrj/ll4zXi5/HLCDDY2z+dh7GYT+cMHCEl5vIfRwtygpL3TW
	J2Zsv1kJ6kf9mSJeHBANg5cM088aVbmqR4i8IMklGG8Vz7joRLTDfX+LGcvI=
X-Gm-Gg: Acq92OGBkvChI4SP2eI5RRVSrQxaYuDF18GGiukH0NlapkoJK3y1vF4qrHybJ/2q16L
	Ay8Dli6vzvCJQFEBkbzeluHYNKDJr5SnfDq533TigAhsq0+YPK8SeK+xjEUxHU198yXO/qhzU86
	EeQhrqTwxNlfujcielM9bI2N579/ncPRjeBp6xC3muSyIcxPytOk4cAMMme7dqLRE9OLy9PX1kc
	MzcVwqFvc/3oxpkNzCfLogocTaJNJdMAC3BSDNn2/+95CmX0XMUfrt+J/ICZmz9PyVnEFc6d2yw
	xYY/+3LCqvzo1019WP1kPo5fABmpzAZfvK1Er7gtB1u5iDlI7JzbMyMBtPrR1wK9bhSZqjZy96Q
	oBRqhA25mYFJX9ggpu4RGuO1t9k5SsLVYGmXkBp6Su0Bg7j7o3xwUBRTar5X2k45DiIbR
X-Received: by 2002:a17:90b:5343:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-36a67761c51mr25386496a91.7.1779988704067;
        Thu, 28 May 2026 10:18:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5343:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-36a67761c51mr25386462a91.7.1779988703499;
        Thu, 28 May 2026 10:18:23 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90c03314sm2500410a91.14.2026.05.28.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:18:22 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 28 May 2026 22:48:07 +0530
Subject: [PATCH v2] serial: qcom_geni: Fix RX DMA stall when
 SE_DMA_RX_LEN_IN is zero
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-serial-rx-0-byte-fix-v2-1-b4195cfe342f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM94GGoC/4WNQQ6CMBBFr0K6dkipCpWV9zAsYBikBqh2gEAId
 7fFA7iZ5E3e/38TTM4QizzahKPZsLGDB3WKBLbl8CQwtWehpErlVWkIftmBW0BCtY4EjVmA8FZ
 LjQ1lmoSPvh3591H7KH7MU/UiHENXMFrDo3XrsTsnwfszMSeQQI0X0lmK2TnVd8scf6ayQ9v3s
 T+i2Pf9C1vJtkzRAAAA
X-Change-ID: 20260528-serial-rx-0-byte-fix-ec9d08cfe78e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779988699; l=2081;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=KYjKvckY/VAl6XCtEiN8jjSXIWwmJfrlKKhhzB3/mOk=;
 b=aTPBsPo1CPjLI0wCQbsFX1lYscFAfml4I823i+RA/CpTzZFoKJFg+kGzqK2JqJGlkDA2VYfix
 Eqa75SLa32SCdSfwiik59LX3RqL/iCTpYVeJoBymFfdHiMRRPq3rvIj
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE3NCBTYWx0ZWRfX4mh8p5Qut8wW
 Ul7VayIr1EVWlU5uUlODp3uAc/KJljSZCeGoATOIDulOM+DF3hX5qwOsnqC0onx5O6QaIGB914n
 vs6jDu13PAwNhmUpX6ykUgjLLUDPyoWgwWs4oxZ1nCIclz+3NB/58CvZD5wQUiCeYW+WB5yFTy7
 o/L+0QmN06N0kV3emqEHlkx0o7UBaSGjJheFxCSShUzLia5FDbou6Z6qO+mkCOjyXunaCHMBEL8
 bC4nUhLRBGjUXgoM52e6oFtq4PwMajodOLN6Cbs56T082WTk/26P/gD8q/YC5ZFhfrSJVb+phS+
 NMa4++pbOq5f28HFiS2V3SK5ETEEV9jtNo0aW+Fsn/nUHO+cXWE8gkJSNMGIXcetxglS0cloWOP
 CjKOCmqTXTIBLgBWrUSVQpXge+n9MgOtuOIWZIfvVNf1ThdlYG5bF8ZsH5YaKixF4/2obxGHb6A
 ZfxEucCfOaFctRhBseA==
X-Proofpoint-ORIG-GUID: to-63zo1Ezrl3Y4rVGOHttePMzGa6d2c
X-Proofpoint-GUID: to-63zo1Ezrl3Y4rVGOHttePMzGa6d2c
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a1878e0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=tI4oF7B6g8YmWx8mlzIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280174
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-255071-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viken.dadhaniya@oss.qualcomm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C1DEE5F596E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In qcom_geni_serial_handle_rx_dma(), geni_se_rx_dma_unprep() clears
port->rx_dma_addr before SE_DMA_RX_LEN_IN is read. If the register is zero,
for example when the RX stale counter fires on an idle line, the handler
returns without calling geni_se_rx_dma_prep().

The next RX DMA interrupt then hits the !port->rx_dma_addr guard and
returns immediately, so the RX DMA buffer is never rearmed and later input
is lost.

Keep the handler on the rearm path when rx_in is zero. Warn about the
unexpected zero-length DMA completion, skip received-data handling, and
always call geni_se_rx_dma_prep().

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: stable@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org tag (missed in v1) 
- Link to v1: https://patch.msgid.link/20260528-serial-rx-0-byte-fix-v1-1-dc4e876c7368@oss.qualcomm.com
---
 drivers/tty/serial/qcom_geni_serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d81b539cff7f..7ead87b4eb65 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -905,12 +905,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 	port->rx_dma_addr = 0;
 
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
-	if (!rx_in) {
-		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
-		return;
-	}
-
-	if (!drop)
+	if (!rx_in)
+		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n");
+	else if (!drop)
 		handle_rx_uart(uport, rx_in);
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,

---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-serial-rx-0-byte-fix-ec9d08cfe78e

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>



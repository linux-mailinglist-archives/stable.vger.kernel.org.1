Return-Path: <stable+bounces-240274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EG/JKdk6GmpJwIAu9opvQ
	(envelope-from <stable+bounces-240274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:03:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BF94423D6
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7507F3033D00
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A32DEA89;
	Wed, 22 Apr 2026 06:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="badEfmsv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FASVSOe3"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2F29D26E
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837741; cv=none; b=ZtdsgojeGl3wSdXTOwG9cK+nBvq4QZX0LzIHHoZMJ7c8EH7K2SpKVwR88ZPSpkDQ2b1riiYPo/tM6uEYFWFFRdqYtRqEZmffxADCRl9Y9FyxURRiZQBVnt6S3+w0NCmLPfpEJEON8duiA9yiB6jgm2lshrWlD1VeBctO8/DqCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837741; c=relaxed/simple;
	bh=ZvT7qgSFLpdex2Ylpf+73VTMqkc/s9oyjE//rNwO4D8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=noguhjOecszcCk6jM40CjH8i2g3/P4onC0dBdIL2w13RSjaFVVk+HhKFd2Z0JkxqrcAj/aH1SCznZMKLWwQW7KY2MGdMaZ0y4pDXSV1mhHetzsHwQ/j5My0tc+tDSUnWP/p2RpuUXoSN+lxHTADtjXLObxBsN3ZoLhoghHgM9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=badEfmsv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FASVSOe3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M5StNL976176
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RxeiI/RoaA52ZR6lVCrFiiEopN9Vii0pOak1OkFKITQ=; b=badEfmsvpHpAJQhp
	ICQAMznRv3FpEPu7vDNpZKWYMhUfOWLWMpJdwbmrHqh6XojE9S6h0Do+pX+1GIPX
	KHnQWW+OoWqkPT+Df/TI8YHO+K7HDK8zYKmEbswvJGwPCqH4bPGktLjW4rcMl2u0
	1YMnSTCN7DDzxgeZYNccwtAdfPUdiqZjEBnqtIxxmRnMIuWTFT6l0g89uW/TsNau
	cJVZcGhUd4jLvwbonMzoB9ffliFmF6i6YiOF8InTqAvISsevz6Chwkf5VMNvrkp8
	Vp0DES3lntiZe50A6oLeqDZ8vAj8gQp+PJ6oUnPHfOPJF+YxW5H6jjvtDaBqDkkb
	hVMzjQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpene9w86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 06:02:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eb55e55362so594114685a.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 23:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776837735; x=1777442535; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxeiI/RoaA52ZR6lVCrFiiEopN9Vii0pOak1OkFKITQ=;
        b=FASVSOe3kpEoHrAFSkRBLoSHt5Rf9Euf+wtQgPsczQK9u2C8wtAVdUyl6tgGnCwN+t
         CIVGFpDNnY/IoPNHCOCs1tybDXf4cHwCOqoAfDOtRL12L6U/vwRonkXO5LJU+cpNgcgP
         K6IRx5batAp0wyhoo8u8sNqnjt9oQF2mnkpWk9tP+nrDJV2DIwWE2OZmEV46SHcafR0t
         Sz0eKrQMCWPSr4YZ38vSj+vQdqyW+2ANMdZywygmnVtExRubSraVBNjAWcDIL7hzsBY0
         L02A16xFzK1SYW1bkQHDtgacRKRKKv8L4AChP21Ui5m7cd7yIAebNABMCSECNm0zNLEI
         7TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837735; x=1777442535;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RxeiI/RoaA52ZR6lVCrFiiEopN9Vii0pOak1OkFKITQ=;
        b=nTEYo5cydcjkhlHE9Uda+1oOXrnaebpNKx2ocAR4XXvuz0qXysjJK4c0UeeSNU6edT
         r82w70ROhTjgy4Ik0QIVdmDY1xFiQAToWzXsiWYvGLt9NpxGJ5P7u3oVbR2plDfQ0zLY
         redPSbYaYBY+4E8rZ/AgA0068/vYBq3VU0QekWX7G1FrvxUdHkXMvGGyV3ZMd7dYuaUC
         HjdKjqEi8H9Ee/+/Csjecj8J97o+54nz2bMoYp702u4ZDwLOMV5Fax1aWLOHKdrSrh7p
         d1qz4/XT7i2dIqPFMuLOpmTZxFT8CylNacNta0IQoQeWHmG4cmT+pY4pTjjTbRjjGplu
         oq3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+7zRCiE4N/M4eG4ekmvLi5ANvrLpL2L+HO7MWDifY61GeQ+6kFjbWaa0M5nEzdphlAaGWDwgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8emje/8asD4xSInLtN7JZTCeUBIJh07PIPM/cVXRIkg+3ic1t
	ceZmOCmdwqH8pcCEe2sb072y+l2iuQPSLWNJXF4xsLst7tAcgqXB/MgHTJZgv5pEoTu0F7GWm0R
	ncWmZIOOdIFAOHPcS/4ZeB/BPE7HOCDhnP2nn4Z72Shfe/8v6Mlsshom76tg=
X-Gm-Gg: AeBDievCBwFhpLp+Fuxkh7BtJrLmVwq/hkU9Ktm/TDCq8pcTZLNo2SecwhO4goQzMnl
	IEwvPQdJGyFtmRe8SZZWkv+EpqxOVTPQbMdZHbHfxkVPaXikLlGQxYTZ7aDPs7ndMAf1Fvq1kv0
	vKCl174dYQuKkg9sojopesVdj7AVUd8IHJkFpQi9rYE0+sRJdxtflaqxhNJ6nyPTSP4F9qeFtRD
	C+AM4XrS9xXUzmu4EzxVTTJdwemj7xrZrwu++4xWLCKBJtWlgcBmPdZWUNTNoZbC1OKoMIkbR2Z
	lPDLgFNM22KIPBvEqNPO2wrBaG870q16SQ5Z6iXLuc//Cg7neSZ1HI5xjrPaWk+ZjUMw+NJxJjG
	KdhqhtMPGpVxQQqJgNymNfiMqpwTIo00wLzyiy+ModeEKZzu841vNGoGtXyg+fCDy5Er+yFuHDh
	50m1czYPpzVoWr+yWdmg==
X-Received: by 2002:a05:620a:7113:b0:8d6:2958:ec1e with SMTP id af79cd13be357-8e792962a01mr2883073285a.58.1776837734717;
        Tue, 21 Apr 2026 23:02:14 -0700 (PDT)
X-Received: by 2002:a05:620a:7113:b0:8d6:2958:ec1e with SMTP id af79cd13be357-8e792962a01mr2883070385a.58.1776837734282;
        Tue, 21 Apr 2026 23:02:14 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef12122800sm237379985a.18.2026.04.21.23.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:02:13 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 14:01:51 +0800
Subject: [PATCH v4 1/5] phy: qcom: edp: Unify generic DP/eDP swing and
 pre-emphasis tables
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260422-edp_phy-v4-1-c38bef2d027b@oss.qualcomm.com>
References: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
In-Reply-To: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776837726; l=3913;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ZvT7qgSFLpdex2Ylpf+73VTMqkc/s9oyjE//rNwO4D8=;
 b=gmbKCn9+ZdWurqtMj/95xmyfSF3k0EhnlaeEItcktX7otzcmwJAqLGkk5szavKagMO9Q0Kq9k
 fDdOFSiOC2lBtRwaMk6qCTwzBLqw6pi17aLJm8Go1fAY2RYMJPBz5Pd
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA1NiBTYWx0ZWRfX2e7cDm+mJgel
 Axx+m5MLtHgPaqgx4ZReltxx0knnRkBFT+U9f0OsajaBJdltmVIvPskZC9MEzo24g7NQsP4vohI
 uGuUgdWbG3q/LPOzgJ8gDtO1m2TPUfaUiJYQ3xEgy03xdVv/KhQ8I+4I8lPjN41/vdZxoFLNa/O
 Sldpmx8Kq8nonfM87kQ3KQhvvEcNzclMxFkdcJ8j4qK3q61x4OCTGw1e8NIX61T0hySTG+nSwI0
 B8J5gCoeT+lYHCDLhdgli+X/6OIlT4KABoxnrPIIExbskyS7WTYm1NMJOzjJ5PsMYYa+LOzGr4M
 IT35LgRD5vuuO+B9RGIZ+dul2d2Ol4oN5RjZr3rcMfGSEiwQIMi/8m3XRhdVe4AKOWMcUO1Dxq7
 FW6M4btbG6uJrFXyPLO4EtIKTEAhE7TxVLa+xfSSRPEkGs5ffzlzgnyMixpzRGqN63tTQv8qJRV
 QxIWmd932yetkhFtqUw==
X-Proofpoint-GUID: uReQR1OEej4F158aO4Y1-Tyn14UUEeRE
X-Proofpoint-ORIG-GUID: uReQR1OEej4F158aO4Y1-Tyn14UUEeRE
X-Authority-Analysis: v=2.4 cv=RoT16imK c=1 sm=1 tr=0 ts=69e86467 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_hJh01-1qFuxGScrDK8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220056
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240274-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E8BF94423D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current eDP and DP swing/pre-emphasis tables do not match the HPG
requirements for the supported platforms, correct the table accordingly.

The generic tables which can be shared as follows:

DP mode：
	-sa8775p/sc7280/sc8280xp/x1e80100
	-glymur
	-sc8180x
eDP mode(low vdiff):
	-glymur/sa8775p/sc8280xp/x1e80100
	-sc7280
	-sc8180x

The proper tables for SC8180X and SC7280 will be added in a later patch,
since they need separate table.

Cc: stable@vger.kernel.org
Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 41 +++++++++----------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 7372de05a0b8..2af3fd63832f 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -116,17 +116,17 @@ struct qcom_edp {
 };
 
 static const u8 dp_swing_hbr_rbr[4][4] = {
-	{ 0x08, 0x0f, 0x16, 0x1f },
+	{ 0x07, 0x0f, 0x16, 0x1f },
 	{ 0x11, 0x1e, 0x1f, 0xff },
 	{ 0x16, 0x1f, 0xff, 0xff },
 	{ 0x1f, 0xff, 0xff, 0xff }
 };
 
 static const u8 dp_pre_emp_hbr_rbr[4][4] = {
-	{ 0x00, 0x0d, 0x14, 0x1a },
+	{ 0x00, 0x0e, 0x15, 0x1a },
 	{ 0x00, 0x0e, 0x15, 0xff },
 	{ 0x00, 0x0e, 0xff, 0xff },
-	{ 0x03, 0xff, 0xff, 0xff }
+	{ 0x04, 0xff, 0xff, 0xff }
 };
 
 static const u8 dp_swing_hbr2_hbr3[4][4] = {
@@ -158,7 +158,7 @@ static const u8 edp_swing_hbr_rbr[4][4] = {
 };
 
 static const u8 edp_pre_emp_hbr_rbr[4][4] = {
-	{ 0x05, 0x12, 0x17, 0x1d },
+	{ 0x05, 0x11, 0x17, 0x1d },
 	{ 0x05, 0x11, 0x18, 0xff },
 	{ 0x06, 0x11, 0xff, 0xff },
 	{ 0x00, 0xff, 0xff, 0xff }
@@ -172,10 +172,10 @@ static const u8 edp_swing_hbr2_hbr3[4][4] = {
 };
 
 static const u8 edp_pre_emp_hbr2_hbr3[4][4] = {
-	{ 0x08, 0x11, 0x17, 0x1b },
-	{ 0x00, 0x0c, 0x13, 0xff },
-	{ 0x05, 0x10, 0xff, 0xff },
-	{ 0x00, 0xff, 0xff, 0xff }
+	{ 0x0c, 0x15, 0x19, 0x1e },
+	{ 0x0b, 0x15, 0x19, 0xff },
+	{ 0x0e, 0x14, 0xff, 0xff },
+	{ 0x0d, 0xff, 0xff, 0xff }
 };
 
 static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg = {
@@ -193,27 +193,6 @@ static const u8 edp_phy_vco_div_cfg_v4[4] = {
 	0x01, 0x01, 0x02, 0x00,
 };
 
-static const u8 edp_pre_emp_hbr_rbr_v5[4][4] = {
-	{ 0x05, 0x11, 0x17, 0x1d },
-	{ 0x05, 0x11, 0x18, 0xff },
-	{ 0x06, 0x11, 0xff, 0xff },
-	{ 0x00, 0xff, 0xff, 0xff }
-};
-
-static const u8 edp_pre_emp_hbr2_hbr3_v5[4][4] = {
-	{ 0x0c, 0x15, 0x19, 0x1e },
-	{ 0x0b, 0x15, 0x19, 0xff },
-	{ 0x0e, 0x14, 0xff, 0xff },
-	{ 0x0d, 0xff, 0xff, 0xff }
-};
-
-static const struct qcom_edp_swing_pre_emph_cfg edp_phy_swing_pre_emph_cfg_v5 = {
-	.swing_hbr_rbr = &edp_swing_hbr_rbr,
-	.swing_hbr3_hbr2 = &edp_swing_hbr2_hbr3,
-	.pre_emphasis_hbr_rbr = &edp_pre_emp_hbr_rbr_v5,
-	.pre_emphasis_hbr3_hbr2 = &edp_pre_emp_hbr2_hbr3_v5,
-};
-
 static const u8 edp_phy_aux_cfg_v5[DP_AUX_CFG_SIZE] = {
 	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02, 0x00,
 };
@@ -564,7 +543,7 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
 	.is_edp = false,
 	.aux_cfg = edp_phy_aux_cfg_v5,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v4,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v4,
 };
 
@@ -945,7 +924,7 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
 static struct qcom_edp_phy_cfg glymur_phy_cfg = {
 	.aux_cfg = edp_phy_aux_cfg_v8,
 	.vco_div_cfg = edp_phy_vco_div_cfg_v8,
-	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
+	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
 	.ver_ops = &qcom_edp_phy_ops_v8,
 };
 

-- 
2.43.0



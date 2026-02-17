Return-Path: <stable+bounces-216894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MKbM6nFlGnCHgIAu9opvQ
	(envelope-from <stable+bounces-216894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:46:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7414FB92
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827C23024A6B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0336C5BF;
	Tue, 17 Feb 2026 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="guoqu9sx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NJ/Y7Zgt"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FAB2BD01B
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357606; cv=none; b=lMPreOaBzsCdAl94o5Zr7KE5XvyiPAzYUVYP1nL1LvBotx6X05uFGmGw1sNIHTLZ4H8GMQEwO2yGnViro44LJj1fFltlwXzHhyYFXCIxhFvFrXr6kt6WenChy4ViPUPT6fYZmaAeT4k8/Q2MakSXvzgF7hs4FuaPQRckRF0ArM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357606; c=relaxed/simple;
	bh=POFbySoUt0wsjgeR15xVbsXPSMOBO8Gih8o0Pw5eb6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JEkE3iEL6zd2PVte+/63p9nEWh/LOb0nPuQ2YnAfzAss7onRtnc+yzhdW9QiHDFKzGaoX576II9nu+dwerJlSmObx91kDqs9safjlz6oGTHTUGMP/wXqe74FQCkum46dQ+LOFoCZ3sQxySY2TkT+lj5rwmbB0NqU5KyyMotkUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guoqu9sx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NJ/Y7Zgt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HDqVBr2111841
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=G3nfIYfL3qOpztTEAc378U
	Zco2tlfgxf7znxvk38v60=; b=guoqu9sxKFQq8Uz22LlpoP4CZbQGrYcIwo4D6g
	Sp0DtXg2PLG9Ooj47pLt9bLKa9RsHCwCI2gUGl8ErxhZXlk7YeMHI6LO9+8n9M77
	kMFaxDFict2kSCcKK5DIePUU3QhVHxWL+fBNT82tNgem7KOJua+SaYs7lGAXKt1/
	vu8/VCzNxwNVhxn+LQMLduiseOZGkEYZymoM+SlvRfCTQAJF+BbXnbV2mE8jk/7U
	i++4S/jy/kD1MYYR9V+rl6YIXNlerWrCbosjy7vSKqqpkwp7ULJs4Y9o35rRlGN3
	gst5pkLq35uM3cdVKNUzwIcWpKS6FElr/RcID/Lh02PvCwVw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cchv4je7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:46:44 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-127133794b6so7561652c88.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771357604; x=1771962404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3nfIYfL3qOpztTEAc378UZco2tlfgxf7znxvk38v60=;
        b=NJ/Y7ZgtHYO32pcEA7zIHFu/sfPdn77etrXkKaCKkM7YiHwHW8MkDSe1x9arAfEcnm
         uEgzzl98jP5SOlghkBFM1C6IzoU1Nxrx1RuufyxgUljTlVARcvhFIjaiVrn5YmShHFvR
         WFeq53jb/D2m9jpr5v1ffUWTcnYp0XA57TQYo4s3CByK49MhH5uYxyzGPQT9iBIrMzNC
         /c6t1rcdM701Ft/btGnsBQ4qQshcyt7gJGExGFvmcA3GACZ2lsJg0yK5bWPKReOAME1L
         GaVqorq3qt79lrcJjIYTf10ew8mrfQh4mwzpn5kHLzG2hNwKs7ITqFUpboEs/YyZvLXr
         +IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771357604; x=1771962404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3nfIYfL3qOpztTEAc378UZco2tlfgxf7znxvk38v60=;
        b=Mfe6iguN/8sCYcS76/xApJL78uANAc40T3/IDgvpqseJ9dAqsKWiLVay9HKQRflDrW
         CsnbTLBI362KGz3mLmVSd4kzoxPjjoStyJtX5yeHeBCb4gSo1HJKxrlFADobMo02Trc6
         DZoRZpTzj0R6b15lbY879eKNJ3nSGzmqGc4n7z3RdXLFNbvpbYbSjO1ADH9MceYDgAhr
         34m+xECdWvW98gqZXDJgdd6rSNRilA0XIlLqtscB62+XzY4J/abmxXnZF77ve4uPJZTs
         bTCIOAUrGkctCufnwlYo19RJ8QKwlDf0YksnaAw0Gjkb4fpoliV/diVrT4uteV227Tul
         RbWw==
X-Gm-Message-State: AOJu0YwFKHEICgb78ZVwyl4s37J/YhJ9TII+bJElgPQPuiy6cvI5eUAd
	iTAkjE1XGwPpg/jbijPdy8W2Gtqf3WloE3cMCEViCQOtHcXpwWt/nlHKA1yITZ3ZOWItXpU7u8A
	+5Qml5Kg99dFLcY0jjhIdzw+Hicvh8uFbo+Keg8HCVKowIyP9FxH5j0eJ4d04WoL9h18=
X-Gm-Gg: AZuq6aJzw6I5xREN23WjvrXn+H0bM4bY4OjdMQhJwRqW1fhxjVb2Rqmoo083BweB9hF
	ACJnHQGk/UIFSQ/jv92ZvsMTn1DCv5xxjOrHYIs24XzDQAscIz4bylPGoWhbZzzPD4ixnQ1ETyz
	ef3n+W40fRwM0jKTwujQpjk5FxgZhlcEYtL20wZzeh1awrWE6gBdMos/OtEQEawLUv0aCioidFl
	okbF40Jbe5b1MfHhgRW7Q7ZxOT+sghLTLNSuPtbdJnGd+x5fz6RC2btaEVM+oUDxaVVG9+u4r4g
	gXXI2rn5ho5HRpLblCkSYXnKs7xXHHwElwnwwxrI4CxuToDHwuIsaIwtGTkGNL5ygwgl0UzPGTK
	GhDMoO/4LSijWhnc2OL1fY1PGoFDkSF4BhHImRvOO73v7/0d8zt4W5AZ8x+7r34LZpMTno9YW/B
	E=
X-Received: by 2002:a05:7022:a93:b0:119:e56c:18b1 with SMTP id a92af1059eb24-12739818b81mr7260357c88.25.1771357603569;
        Tue, 17 Feb 2026 11:46:43 -0800 (PST)
X-Received: by 2002:a05:7022:a93:b0:119:e56c:18b1 with SMTP id a92af1059eb24-12739818b81mr7260347c88.25.1771357602991;
        Tue, 17 Feb 2026 11:46:42 -0800 (PST)
Received: from hu-eserrao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cbc900sm17862634c88.14.2026.02.17.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 11:46:42 -0800 (PST)
From: Elson Serrao <elson.serrao@oss.qualcomm.com>
To: elson.serrao@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: [PATCH] phy: qcom: m31-eusb2: clear PLL_EN during init
Date: Tue, 17 Feb 2026 11:46:41 -0800
Message-Id: <20260217194641.2786873-1-elson.serrao@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eYAwvrEH c=1 sm=1 tr=0 ts=6994c5a4 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=49oE3CkF4HoBucdVWpUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE2MiBTYWx0ZWRfX8G8DyabkOgpB
 LjFOvqX6yaZpc2DkckyOKW1xIoUX9jyZvYdo2uSn7gqbNesrij/2vTvqZB3AguY8vyOmC9Yo1pw
 J2rhjxGBCOF0aAbjr01ky8RcQlVnsS3XPfZvmGw7u5Ql8tZi5J5idiRPlYqMTeC7l2A08ZAQYkQ
 d1Bd13a+3BV+vXMreSGjXK025KmHyO8JAas48KHxWxQEjiJ3WKubr0dAb764HVA3PaEenuClBWm
 /G+Ux5MjRNNgBYHHmBnm+A1cV/6q4CFiC2mxpq+9TcypQxrF/ScEbBfX7FdwVQYEYtHB7DxH8E4
 eJW+993idqR90MfZlmRyxmRiXVUFzKdJkWBFuxHqrsS+0b47NnzM7UnjIywde0ucDGqcCe4T9t9
 nhT6e/69qgOkkNC7F5bnKGFi9BkBgtmNNx0v0jTcr8yrVdjYoxDU+6W1FvFACcqvRb8d0BAWjnF
 RnoY4CIGM/7QRg6mFHA==
X-Proofpoint-GUID: 66mds8I43Xadl25XXqDGvbWd7A0iigAg
X-Proofpoint-ORIG-GUID: 66mds8I43Xadl25XXqDGvbWd7A0iigAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170162
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-216894-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[elson.serrao@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 29C7414FB92
X-Rspamd-Action: no action

The driver currently sets bit 0 of USB_PHY_CFG1 (PLL_EN) during PHY
initialization. According to the M31 EUSB2 PHY documentation, this bit
is intended only for test/debug scenarios and does not control the
mission mode operation. Keeping PLL_EN asserted causes the PHY to draw
additional current during USB bus suspend. Clearing this bit results in
lower suspend power consumption without affecting normal operation.

Update the driver to leave PLL_EN cleared as recommended by the hardware
documentation.

Fixes: 9c8504861cc4 ("phy: qcom: Add M31 based eUSB2 PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index 95cd3175926d..68f1ba8fec4a 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -83,7 +83,7 @@ static const struct m31_phy_tbl_entry m31_eusb2_setup_tbl[] = {
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG0, UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_UTMI_CTRL5, POR, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_HS_PHY_CTRL_COMMON0, PHY_ENABLE, 1),
-	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 1),
+	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 0),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_FSEL_SEL, FSEL_SEL, 1),
 };
 
-- 
2.34.1



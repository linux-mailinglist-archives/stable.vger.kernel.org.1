Return-Path: <stable+bounces-219702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF9VOBFan2lRagQAu9opvQ
	(envelope-from <stable+bounces-219702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:22:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4923F19D260
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C68F1302F72B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB626ED59;
	Wed, 25 Feb 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f2NAh41q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LvHr67Do"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF62D249E
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050863; cv=none; b=IlWLZahpmD4jdHaDLfh95eUTz+cCXBTUOUhtVt5TIaRyUqNedKEieBw7bntBs+js1EEWGAIDBY6A5xKOYu88l8i4xjdYF1GBZfHdTzfT4YuA9OjKq8uJ7bMkCmoR398H+Cq2nO4FGX3Cthw1zd5R2yPuELhyBMF1OUM7g0kcHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050863; c=relaxed/simple;
	bh=HVzSM3hrjZuSOOOw2BhcR9Jkh3P72gbnjSi/SB8r00s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd6IolYwCHDnt3vTmv+krAL+Gbjzu6grgLJOEj8z+EPrcLpaT8dzkpt47QNV324PhXHHTQpLWRa7Jefnz8ErHHZGiFiC2dXLuhC0yc4ZuDT6XKrap9Hir9HR4LlEkwMmo2r7Y0XMN/x5VIn5VpqsUH18DTksi6fzdm7V1E1kdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f2NAh41q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LvHr67Do; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PHsxsE1363563
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XB4nyc5Hc9Z3icKgpv5r3iznhz2nFVQoZK9
	tmCr4Vw0=; b=f2NAh41qm8Zvvrbf+THsdBCNwyCpQE6OKlVhW9q2VwBCUOWKE+b
	dLeB4GwBs2S2OuytakdccbSZUIg4DtjbvpLVeg0giWlHTniffqziPrLzCNasn9pY
	wnHwFQ9HsN03Iw6K4a5G4bqegh63u9Wyj0wmrTJZqgHlY9q30LaoJQCBGGyLgjaZ
	omr/n4z5EHHhUfxI8V5pehKT79EvdR8BfVHsFue181y1YdS50Rl/JobT7tWJl67Y
	/00VeWn2EhY/O1SjPE6DHTwDwJQLh78H4gVdkvYvHu18v1Ac7qTGhaaN6ETQNbCL
	Rguen04YPY0t0nmtsDVOl2TjCxcYPlYYM/g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chp15bfhu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 20:20:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70e610242so15211185a.2
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 12:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772050853; x=1772655653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XB4nyc5Hc9Z3icKgpv5r3iznhz2nFVQoZK9tmCr4Vw0=;
        b=LvHr67Doc7x3QmHnQMne9jVfqwhULnmoIWWMaDuGdxI3uaPqIUyGYlKZDQh8gNHF6i
         BfqbyGeRY7GLNUpp65jXJPrONeZDJvmMIXXe+NvHC71VQy/0x/EqSOTbItLMji2/7sbM
         yLT0t9kNE8aEVNN/b57HMPiCDULOE/nHCemRfPKmeakMm8NmLM/Bl0WEsXZLD8qvFsvb
         uFSBMWQJM+wqQ0CEn8DC6BJcuSOUJ2TPY2IOwtDDaikGSTZBzmlzienCXoV/jhK8V5OB
         6NGABejCMY5+T/H+ef4AHsvHIgDCosrhv9RCsUfYeKw1ZSR/zYwpgusjsznWP6nZR5oM
         UnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050853; x=1772655653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB4nyc5Hc9Z3icKgpv5r3iznhz2nFVQoZK9tmCr4Vw0=;
        b=HKM5Ry/jjHfDW/GFNb0Ss3iBDzBKfYh6XTY/lzAyRl4o9B2uHqK8Sa5nBuQdkbAMBo
         JPbfxkGALKcrJUnVpGgpiv2Lp0L6wudi/pKqJx3+v5LzYSuZgFsba/+4Xqd0Px+u2DbB
         c3EOw3pSImoofFhqjXJ9oqfCSS9zPp4Ts+2PH29Ev9KtjdElv6+VT+0GiSYYWAvJjvYy
         AyonuZSP+2iCYs/IHGgDZZdXw+3b6rU/kD9AHTgIkotG9/ALgwWZ+93nUFyD5r5lZdDO
         vO7Htr96xGU2/b/siFd03YcKSGajFDcVG0lwWekHPI5ObxLGjQFER01PqsCKFOIc7/1g
         rAfw==
X-Forwarded-Encrypted: i=1; AJvYcCUee0/OywN/Tu3kNkM7H7IzCL81KNpXq1CyU2UcQOrKBmLnGL3+h0fuSwebG+8n5etMrbEP9Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDnNPMnYY/VAUe3HuD0CSXSlkGBjuUGLU6Df/Nv8OZaZi6l/6
	74us7fjkR6Qofaegd1AMJ5mPX1VpEv0ZVwjQ8ZjTUJm/CKyrCPuiJFnpKSTWCMrNMfOFJHfz5Ej
	TDAc7KLX3oPwTL/sO5lMr0YmldH2HH57PkjJCyHzmevN9U+NgCjuNmnKefWI=
X-Gm-Gg: ATEYQzzexieCndYnWevL747t4z23u0zjKxDDmsXrtvNrlcBbB8bE2/c3tPMuj5kjm4C
	dpQ3Fk6Ly9JuRem1RXY+pS849Ui0lFCbBTDUvbMloEnU6E3+3wi4Ko6X7SrvDDdo3OWFu8gfss3
	BofAzRHO1k1AjYvgxzlCfFZ3Q20+nXSSApB6omzJzll831w15BV7dAtei4CtpSEwU9gaVnPgGz3
	YFNObM+w1ej5NmANYpZQM56dbEfN65MB8M2hdUQb/UpcVfoI3PKP+W4g2VPwgzgf2pPOlI16g3w
	h4c7VV1wd/BtjxgWVl+gtOfE5D4c4xY2cJg40Kbbl6T84fUt5H08eLXw/yaexmbzARwEKSLjRsT
	/1jUpIWqHt55YAJ2npw4XrzgaiDbOEvSgI7TPidd5bno8GYsz84s21MKNpkPi28WN9wKhe73u1R
	kFSUkoesWBjvgQB+1mE3NnkSb0F86sXnD4H85+
X-Received: by 2002:a05:620a:29c9:b0:8cb:5233:8f8a with SMTP id af79cd13be357-8cb8c9cc354mr2048891185a.11.1772050853472;
        Wed, 25 Feb 2026 12:20:53 -0800 (PST)
X-Received: by 2002:a05:620a:29c9:b0:8cb:5233:8f8a with SMTP id af79cd13be357-8cb8c9cc354mr2048886885a.11.1772050852961;
        Wed, 25 Feb 2026 12:20:52 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd4691asm36684a12.14.2026.02.25.12.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:20:51 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] media: ipu-bridge: Add upside-down sensor DMI quirk for Dell XPS 14 9440
Date: Wed, 25 Feb 2026 21:20:48 +0100
Message-ID: <20260225202048.35865-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE5NCBTYWx0ZWRfX0scybl0UXHxU
 l4ilY3DwS5sQtcSyHTq2UJ3tIaSgYhU+I2hm0HKX3kbz70V1hiZYINv46f8WqgCFJ5cwyZ9q6ZM
 Sm2suBgt978h8uLpL+tIjbBaXOvcagQWAQBWGmZskkDTsJvESXbQpZCoWHfAxQ5FL4NqbNVJ7ze
 XetM4uvEctbC8ZgxXPgXZXwaFxXEiodLlf9HfI7dEC7ff+kptLpattQtDBuSy8tgqD2+D2a8QY/
 2z69IcZYXtNcaQY4emC2W6Ak/4VIjdqe/QzhI7829+ZpV18dWjs2Ho+DP5nPYDUuSGRtP/8URCr
 WzyYmt3boVj187W0rNivgxrsi3voDQXO3rKCKzvBUAvEwlWd930ANimaxCJA2p8PDPJFGgTALsv
 PYwjICf3qw5ir5hSx+692rQyp6eQ2ytQpP+Zldb6rmGYt+GLfoifK7OxtJIhqYXByQh2Un4X0Sd
 DH5ghCMzxBsGjJDCJ/A==
X-Proofpoint-GUID: 68w5k5g9ogcgG6r4Nj2cLKimbPJPzvFj
X-Proofpoint-ORIG-GUID: 68w5k5g9ogcgG6r4Nj2cLKimbPJPzvFj
X-Authority-Analysis: v=2.4 cv=etXSD4pX c=1 sm=1 tr=0 ts=699f59a7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ESHlbzvXwd7ObLRsfRYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250194
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-219702-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.goede@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4923F19D260
X-Rspamd-Action: no action

The Dell XPS 14 9440 has an upside-down mounted OV02C10 sensor, just like
the XPS 13 9350 and XPS 16 9640 models.

Extend the existing DMI matches for handling these laptops with a DMI
match for the Dell XPS 14 9440.

Reported-by: Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>
Fixes: d5ebe3f7d13d ("media: ov02c10: Fix default vertical flip")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
This fixes a regression in 6.19 + older versions with the ov02c10
upside-down patches backported, please include this in the next
linux-media fixes PR for 7.0-rc#.

Note no Closes: for the Reported-by:, this was reported by private email
---
 drivers/media/pci/intel/ipu-bridge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index b2b710094914..fbbd393ef025 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -111,6 +111,13 @@ static const struct dmi_system_id upside_down_sensor_dmi_ids[] = {
 		},
 		.driver_data = "OVTI02C1",
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 14 9440"),
+		},
+		.driver_data = "OVTI02C1",
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-- 
2.52.0



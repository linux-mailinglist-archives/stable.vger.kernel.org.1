Return-Path: <stable+bounces-254967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCaZD2EwGGpwfggAu9opvQ
	(envelope-from <stable+bounces-254967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:09:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A55F1E01
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5171303298F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4452B3E7BAF;
	Thu, 28 May 2026 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XKxdT2Zx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fglysgf0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9283E7BB0
	for <stable@vger.kernel.org>; Thu, 28 May 2026 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969815; cv=none; b=r3HRw6Kwcuu6JOA00kG8pcFFVgvB8me9OZkocVmA93x7+AuhdW8RjCYzmHalLNqg8yP9GoFBzoTCjv6KpRyBK2IaL42QndWUmgI531crT9+AgP8KHz+7dUKktCbfSXzcW0SEsEursVP4R3nMVrs1MWUHh/OflSQsV1isifgBljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969815; c=relaxed/simple;
	bh=4BOlVvg3iRSP1swvQ5XO1a679OzNH/v+9k3kUrkeOsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UoJ82n33xsiQ40li6HxnRjcatxDhNQYsX1Fsgzt5A4H6urDlFGdbGoy+4RTKY67w2yDejevQSpk7X1oxuj0TcDpPn1eqQEOYxtJ5RToDnocZIceo3USU7fI8vU+X35CN90ZBZ+pw+dugQr/mGLvBFshMS34xyv+0MpV/i6VSTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XKxdT2Zx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fglysgf0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vebf3546066
	for <stable@vger.kernel.org>; Thu, 28 May 2026 12:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lRDh1Gsgwo/+sLiCfxMrEEDL44ENfFOMWpC
	PwzY9U1A=; b=XKxdT2ZxyET/kRwmmco/ZMp5hTn96amBXkrujkbW72W0YNHe1EH
	nhOIM4bMhT2NGdVjwGz8l1Zj4duffd6plFgnjM0xkxySoiTFfgA6370wKZmL09ek
	FM3H/vg8mpW2weJGjJkAPHVgB9rL29RyKUgAZCh6JjJne0sR4MyZGpzjVDupZT4q
	d7wRvPmP11H4rE7YJSJJAXP3G1qPrBlsnZwTh6EPjj8xlvrqRqkW7MeQlj/ESQRj
	IJnIUqn213P+7sxrpgB4xUX1Hhy01BqKVsbQA0EBQruY3v5XtNr/DSEK3r5wv6VD
	KNLXROP2k7l93zKFSoHrEs3VAbbV8anImbQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y3tm71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 28 May 2026 12:03:32 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-69db09275c8so3116955eaf.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779969812; x=1780574612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRDh1Gsgwo/+sLiCfxMrEEDL44ENfFOMWpCPwzY9U1A=;
        b=Fglysgf0uliv5JFWpVHfuWtsooU1raJT9hxfRnQd1MGfDBTE0TGVlafLVZejbv1YAn
         KyRFoncnY0/nuJDlcZMkYTavWm+VwfEi7WZPkACoCuDqEN+VSglnOVdXYcnRbv8vCj0A
         QyCBXPX48zWHUtAQMUkGOvHbDfOwTyEKsKRnw07YlWkrCT6o/l1C9RM7MJD+hsmGjZQC
         nFZyslItCK5ET/rXKBuzwyhI9siAMldFuauddjDwxdTaJFUJ62/Uz37DUIyVQKl5oYQ1
         oQIKGyimiw+JBaMygW1lFRE6ybzsXz4ybO7ibtBKL515ZAV5fj5gVKdzvu4FLjoZVyuU
         BtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779969812; x=1780574612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRDh1Gsgwo/+sLiCfxMrEEDL44ENfFOMWpCPwzY9U1A=;
        b=Sk/Kb3Y9GykMseUdwRB01ZjO+xP/l4ZfBsielJtt7uMwR5aiIAG/080sjiOh14BDw+
         bazeR/393OtEl2u+Ygm44u9dCnh3CJe/ctg3e75Nwl0CapDUs+t7z+VBGM1Dfv2qDeYp
         Cg2EmlNIzhTyN3BHvdUxxa5Hr43yxSt2xblk27OXmVMLL09Q+kf/J6ob8q37b53UAAz5
         FO0d7UWQ9cyarZ8rFtwdpu28cOPQaarQNG4/1bycLpxx3j5C74ANn3Wm9SoGDqy6xJXA
         FGkpxeO5LtzqmV/fMPHo6k/S0nOwLlyjRKwvcRlxC3lbpDzk8qUv/uVLSBELz9zvnKoL
         PlbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DgrB6D+EoRgE8I2ibF5XGvF+m8zlZK4eLupARS3mdMPnf9iF5U3hkpZuQeT0Tpy6chn48thA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5AlfVC76VHHDi7a5zszFGwMyzmSIEUGklXuqeENvGBtGltCm
	eHIGdnhHwQahmMuK2wkrDFCxAAZ64VZ2kgwjY13iTXfOetjd8+IxwUzJcD28/cvtjooybfq8iZT
	eAlWwk11zgvE4LJ5CNEOzHiVknVZiKDguPbo3KpbV/4iNcQdjoZ3qkVFoDh4=
X-Gm-Gg: Acq92OG3sxSQcu9YvmUjzkHZXq3Uq+VNIi+KO8h7Cmzp1wN4bRCbfeuZPsVGpwlQycn
	ZwgZLEIlRcBu0BbPbcQrstsl4F+CRIGt8EeXH6gGwW2Sx7bNCW7Vvm2MuYb4RpTUUgTAHQhXV+2
	3rKRveJifMCngOHdIgGFQ5Qph7NdO1q6VixucFFzTRZlfonZQtSnpqwmjTpklXEHyndpoPvpKjm
	oPFe6wbM6i9H5Rh4uEdzAZ1ZiCp+VUs0nrxDRx65FDtyyKRlT/aQ8Uo0MsQj5xaCNfLno2SaS0Q
	gnjP84BoFzo+rgxqb5HE57KptpCMdWDHQU5B4quK2Yr3dN6PRQdrch5pfreElXLO+1nDS5oOtm4
	WAfcXHyPvQAKEx+JGNo7tLhvwh9/4obnoAMXIhnudy2JSJQ==
X-Received: by 2002:a05:6820:2222:b0:69d:e8de:7578 with SMTP id 006d021491bc7-69de8de7d2bmr3066708eaf.17.1779969812116;
        Thu, 28 May 2026 05:03:32 -0700 (PDT)
X-Received: by 2002:a05:6820:2222:b0:69d:e8de:7578 with SMTP id 006d021491bc7-69de8de7d2bmr3066668eaf.17.1779969811575;
        Thu, 28 May 2026 05:03:31 -0700 (PDT)
Received: from quoll ([83.144.38.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908dcf850fsm21035695e9.4.2026.05.28.05.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:03:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
        NXP S32 Linux Team <s32@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] arm64: dts: s32g3: Fix SWT8 watchdog address
Date: Thu, 28 May 2026 14:03:24 +0200
Message-ID: <20260528120323.46287-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ls0bc9eXHAAS6lYKMHDtjjkZyadxMM9M
X-Authority-Analysis: v=2.4 cv=JMYLdcKb c=1 sm=1 tr=0 ts=6a182f14 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=gYaODGAG9naNOzoQWaDNdQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=W4yJvGHheH2QdBhsH34A:9 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: Ls0bc9eXHAAS6lYKMHDtjjkZyadxMM9M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEyMiBTYWx0ZWRfXysADD+pOoYJ1
 Lu2z1JTSrpRUQe/p4TLtWqIQcKD9xbmwc4sDVEF2ga2DRQuooZ9nxWDopr4kwSbveIWSSQnjdRN
 5+jrQn4we6Au16jh9hRToHcMvi8wmBNqpDxWYSgz6wsKJAWkCGoHtbqJZidexXvAn3vSdaMW3z2
 7rPdp5fXXnrY9SHTcew8i7WMoeUc9QhoZDbiV4qhx6XGeA2OjAIcaaQC9MNLQ/uanqBddvHbE7s
 VdgIUtOpln6ILmL1AXgDjn26PrpBAbfXmL1jd6IiUjAaAudGUg50h9mx9AqMcicFCl5t9O/Gf/A
 mOWZ8jLBormYgvQyIARowVLr3mdFCrdzdMOLcEnyhh5T1Yw5xpg/nbj6x7RMvoyAb8CsDvXtVpL
 LJQWQq/yCHMDG7Iwf4wzwKkFkLOFJ/bHE5HHmnag5C4+pWbHn7anrpS7l3HiLyKuraemHpP1jUB
 u7HpI2JvEBjR0mjJAog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280122
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254967-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,kernel.org,lists.infradead.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,0.0.0.0:email,qualcomm.com:email,qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[2.105.251.32:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 925A55F1E01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing hex annotation to fix the SWT8 watchdog address in 'reg'
property, as reported by dtc W=1:

  s32g3.dtsi:863.27-869.5: Warning (simple_bus_reg): /soc@0/watchdog@40500000: simple-bus unit address format error, expected "269fb20"

Lack of hex '0x' meant address would be interpreted as decimal thus
completely different value used as this device MMIO.  If device was
enabled this could lead to corruption of other device address space and
broken boot.

Cc: <stable@vger.kernel.org>
Fixes: 6db84f042745 ("arm64: dts: s32g3: Add the Software Timer Watchdog (SWT) nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index e314f3c7d61d..7e28dff53a86 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -862,7 +862,7 @@ gmac0mdio: mdio {
 
 		swt8: watchdog@40500000 {
 			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
-			reg = <40500000 0x1000>;
+			reg = <0x40500000 0x1000>;
 			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
 			clock-names = "counter", "module", "register";
 			status = "disabled";
-- 
2.53.0



Return-Path: <stable+bounces-222559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGzJB5xfpWmx+wUAu9opvQ
	(envelope-from <stable+bounces-222559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:59:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 746CA1D5E24
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B34B30484DE
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48630392800;
	Mon,  2 Mar 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SeegeD1h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SV9V6RJv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79F3939BF
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445535; cv=none; b=j8jzz8UP/gvbhAXFaR68R/ARAEI4y0Z54XG+e8wIEML8sjBuEDgL8uNcDGfWOKxkxnTCNwxoLm004h6Cx0kZXkysZUnvRSe1I3VuSrBmKT6Seq+rbp1CCJal1A7tbXJ+AXVZ8heFrhzDrZcVXBmJa8d14dGheOh48AL12yEYOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445535; c=relaxed/simple;
	bh=bgrDQddMpC0T0+XPN1eI3F9hMvfYD8c9iadBebpyucI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKlJBcRGR8wa6XlIProRYnac3aM9DVBvzPLcWFTQaV9/KhcpU9gKFkQ1arhcgaeppkJKXd50Ml/Fp2S6/56v0cHfCMHAKaRcM4vU3GZNnDWURhEhD0RSxeXY/UzEr/58ohbU1tiufOKroWD4d8uuQeVLTeV78BuVbIpLiwGlcxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SeegeD1h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SV9V6RJv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226hChI2504657
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 09:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bE7cXBgl82noKkmwqoVuvgJNtZGtDdAz98XZIDAB39Y=; b=SeegeD1hz4lXuoZS
	V/AOdYDFg5QWXJxLOEBiqL+531OuD+euR9kOk6mSE2B2tO+zazW0aV5O1WsSN5F3
	/unorODttgAh9ABeowCDTORmAJDqU6UMYfmxaWYeLpJzt82EaS5YLdMsAZCo1M5z
	bMhIu593m6aHF0Srk6qPpu2zM2Z8NsFYTcBQfCUOjvm16NbvbgkOK5Eq75gZEkSU
	BdilVqEkD/TMRMKWSWstvU2kAtveLkfxyKCYRnu6MhpdljziHnGjO3JLhBF/1jiD
	sz3/GfdmL7v+a8P6RnY4TpOYyCZ4v7g2PDv62Uw9ZwGf6ebcyan6z/bTZTXtwlrH
	LrwveA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5herqf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:58:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb42f56c4aso3682020685a.3
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 01:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772445532; x=1773050332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bE7cXBgl82noKkmwqoVuvgJNtZGtDdAz98XZIDAB39Y=;
        b=SV9V6RJvSs1nEVe0U2xrrSXGUJ9HAs5E2jiZRrhLi2TzNquVb43RVaawkT9jLzRo//
         zZSxuVy/Ma4tOWZKZu2s3pKRutduFwcYEqt9N22HcUJuKCLkKw9Wek6Akzac+gB7uN7H
         RCPTx+/F297Nj6kRzwHEfZoXNpOWMUxEHc8+cOCXZoXvDJumB/GIkIKGP9JQhwMc03AA
         73Ig1n3RRSpZyd3nO9QK7tf6nFQ0vGtbRc0M0h+pKtytZksySJUurJEJywmoWEg0KHq3
         Hn+WGyobRSqlxdztC7Yav/euS5oHvKxwimpL0iSUl3RcTkY7LVxOSaHpetdIvzczrcS0
         HUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772445532; x=1773050332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bE7cXBgl82noKkmwqoVuvgJNtZGtDdAz98XZIDAB39Y=;
        b=wHYTrjyogtMJW9bnHaetk2e84VwVd/sJUnEfuie6xUDbQh7W3CNE4Fs5qy6QWJ4AX3
         NvExlJg0BgiKysVzUpMKPKj0j45HvrgYtBRvR5DoqRZFV6lFRm7bwqxBeJm9YUWSBlaa
         ZSD7S8wdzZJiD5vTZUIKyNm4BaFyMb9b1fvcVteaH4ysuNRQANX+qS1799el8TOtmoCo
         CDHUp2G8RFA+s8+w70C2srYtBdstxxt/RhAty/fXZKU7FPhZldCtE2GVtT86UMghxjqq
         oVs8PHNZ/FmeM+mWBz1g2bx6n9ihzA1U5iabAB8tKp6bMAwqRM35QsJPLljcbo60Z+f0
         Dn0A==
X-Forwarded-Encrypted: i=1; AJvYcCUxQxKM3FuK6xR4Ss6z9sAV5mm4vAX16QI5wej5otby75H/Nb7P0fYd8QptnsOkR5ITyMYNdrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3HN0lzKJyLutpXxSvZMOL065xpnEHoc1fnaUYEjelbN+Z6k0+
	OFx/ut8yuMzVnBoLQ4ifoBh41zdKffs64AjhtzEQuk2ma6yP7YaT1bH3mTzg3jDsjl8kN5cDgl/
	WINbMFk+bN8ys7AqgXh6mFifAfWWaADAwl4lXOKzonU+qMDDySWAtOJDx4zU=
X-Gm-Gg: ATEYQzzXmT8FvKKzocFpjrAmLUSx2SQAIUKCmUDXGEZSQYRtGNmhP7+9aCx8VH08bQY
	Xh/RHFCszP0pLhEz7/gFCJ/bk7XBd59xXRw2blcytXW1qiVui/7ARD3cH8utT81dC+XBl25hst5
	yrLd/EZbjuGAhVSmbCyU/vToge6X8/wvwWnEH2A14suJchBLR+10sX4fTk3pdQ8DupQ4gJstH72
	EMqIr9wEBXMmVJ8nP8uecLOrAaSfTuPzzlhusViOCh6qWvScbuVL88EkRvsPc84NjYmcOWJmOOv
	W9qMZH0FrMYlkJna41ixUnXV+MdANhh7ASdcRc1nw8cHc05FyG+Z9PzBcoDKkHMcWYU0o4/lQbW
	75sk2wWOpquLRGXI7Jc/pcLxROcVu3A==
X-Received: by 2002:a05:620a:1aa1:b0:8c9:f9c1:5ed with SMTP id af79cd13be357-8cbc8f35ca7mr1466372085a.63.1772445531994;
        Mon, 02 Mar 2026 01:58:51 -0800 (PST)
X-Received: by 2002:a05:620a:1aa1:b0:8c9:f9c1:5ed with SMTP id af79cd13be357-8cbc8f35ca7mr1466370285a.63.1772445531458;
        Mon, 02 Mar 2026 01:58:51 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm9523027f8f.30.2026.03.02.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:58:50 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 11:58:36 +0200
Subject: [PATCH v3 2/2] dt-bindings: display: msm: Fix reg ranges for DP
 example node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-2-8fe49ac1f556@oss.qualcomm.com>
References: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-0-8fe49ac1f556@oss.qualcomm.com>
In-Reply-To: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-0-8fe49ac1f556@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=bgrDQddMpC0T0+XPN1eI3F9hMvfYD8c9iadBebpyucI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppV9U2PxF2Wt53jeowr46vUdHXLlHmcMIp0kxp
 HhP1C3xc4OJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaVfVAAKCRAbX0TJAJUV
 VpYjD/4v3IpLGU6agRGm9J84EidLO6aT0bomX6Cbei5ENeKZf96Qyko0cFIN3N31RNzqUNH5xpN
 aNZij/c5vwXkbW1R9kwBLH693dEr+CRwqSPLimYTZyS39H2PiAoFoZxIttUaHfHC7RXiqB/4d8/
 G+a5WqMb2i2DkwRzaywptUAcvvY614ZTrfp32ZWeUnuhaj4L9Zg5fad9VbKuSasz2+gFatceh6v
 uvuZdpllWZYwXEPdVenYVQs6MXLUyo6ovB4WV/Tdhaq8ZeS+Jy33LIgIX6GANECmdFH2233M127
 QsCXd/Dc/3xKTrjjgIPO8FXRHpBjHizN/OMe94PSv4kwBJT6j6MZydL9hX+pvGsQMol2QShHBdv
 8XgVi8wNvjRagcDAobEBrGelxOeXSYAypi0sFanWXEXcWvAkxG3+X3IIFQ/ZTYYFtDp7XXcHOW1
 wWwqJsVOrdNB866wl3kebMY00mvOyXyeO3Mo6V14yYzSZUELxpX2NNDLB3rPEmeT0Ade8rwzix6
 R0AhPdqWSl+F7LWXYrwui54Xi/zc0ksv/wDg5vzGDRJE/YaiOVItCHXMX31pQbxDeCAzHS6GG7E
 D4Pkf5Em11AP7V9Pb3PvdjXbPjH8oqVTYvjxOPoyjub1ErKcDgF+Fmfgei/cZK7QEWbf8D+Aec5
 kGilhb1jZiqv3WQ==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a55f5d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rXBtGdtt1y0TR_eNwBUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: PKU65AAB-ClYLh26lOWWjnxbI_aHzIli
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4MiBTYWx0ZWRfX3bToSQNreby1
 wDfq6ppARb26fZxPH9o2yyvWU6Peiub3NQyygAoGAZ8yQxi3D7wX/b65x4bKH4Ia66FXufr4nbz
 U7w/PlvGCG6r7Bi8LbbcVuz33XLeNY9BJ7+EFwl0ECt+5dAD3g75q84AGJASkkqrmVaCPhwW1BK
 5MjqmKjmvzJoqmkPp0Qglx8DvmuUczuIu49Mesz5CdDUIfP1oQn2xR+t+HDrIpx85RenksB++l7
 eVB+YdEJNrrtzHFWaliVh1kKt4oYftV+02z9jvXF6+y84dvMO+TkZpH/kfRQLetfrezoOFJ3zbf
 iXZ4eW+84zSm9xdhNrvVh2ldsFbzXJC3Ab+maiPNTu6/UWrTwNp3o6tT7kUMZOP9QBzV16HlCUj
 Cb7UTm3I0xiLCPMOEG3jnPCrqHqeUTR+blyb+9ILpnkyXyq86NNo5r4IazYSnX9x4ERMUX5v6ty
 dbWP3B3EEupQpMLANuw==
X-Proofpoint-ORIG-GUID: PKU65AAB-ClYLh26lOWWjnxbI_aHzIli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222559-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[af54000:email,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,linux.intel.com,suse.de,ffwll.ch,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 746CA1D5E24
X-Rspamd-Action: no action

Add the missing p2, p3, mst2link and mst3link register blocks to the DP
example node. This is now necessary since the DP schema has been fixed.

While at it, use actual addresses from the first controller instead of
made-up ones. This will align it with the description from SoC devicetree.

Cc: <stable@vger.kernel.org> # v6.19
Fixes: 1aee577bbc60 ("dt-bindings: display: msm: Document the Glymur Mobile Display SubSystem")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,glymur-mdss.yaml           | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
index 2329ed96e6cb..64dde43373ac 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
@@ -176,13 +176,17 @@ examples:
                 };
             };
 
-            displayport-controller@ae90000 {
+            displayport-controller@af54000 {
                 compatible = "qcom,glymur-dp";
-                reg = <0xae90000 0x200>,
-                      <0xae90200 0x200>,
-                      <0xae90400 0x600>,
-                      <0xae91000 0x400>,
-                      <0xae91400 0x400>;
+                reg = <0xaf54000 0x200>,
+                      <0xaf54200 0x200>,
+                      <0xaf55000 0xc00>,
+                      <0xaf56000 0x400>,
+                      <0xaf57000 0x400>,
+                      <0xaf58000 0x400>,
+                      <0xaf59000 0x400>,
+                      <0xaf5a000 0x600>,
+                      <0xaf5b000 0x600>;
 
                 interrupt-parent = <&mdss>;
                 interrupts = <12>;

-- 
2.48.1



Return-Path: <stable+bounces-222835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK0/CRClpmkTSQAAu9opvQ
	(envelope-from <stable+bounces-222835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:08:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF011EBA4D
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3908C30541DE
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3338388E40;
	Tue,  3 Mar 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GciZ3ZLN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hG5oh5sX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444704A23
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528600; cv=none; b=g2NFMKCRQIGnZl5iTIi9TKYxMsQf9ciKW5k762Kf6eio2NFnkiIgN9jnQeoGkda1xG9CbhYK/De8Z+l6QZ+ldq2lkvFdMe282zGto1qBG1zn95W9ZIsKo1fCpxXkyAzdi4r5TvKZ+Y9eO7XCxyAiJ8cOchUbx39nZdE6X/rZCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528600; c=relaxed/simple;
	bh=v6GXIpomCwRaIEBFV0H7mVE2cv9w18Jd0dv/uSNpndo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HvgymqznUns2s1Ea+opaimo0sTSo8WOn4vpVT2BQ2BJejAfvNqTjXb3FhTyv3I3VPPR8NdGrRzPFcYJ6lLH22R0+PyAOKjgvbnmOGgBKsDsrEAoGj+ZVRJAlEn2Ir9YvutftwtsBOgvqxxxI4ZJF/J/VW6LiR1Pm5fYGxB6nRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GciZ3ZLN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hG5oh5sX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6238VhYq669828
	for <stable@vger.kernel.org>; Tue, 3 Mar 2026 09:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TkTFcphozn9ku+tN3w/Wku
	cRtPDQzYjgQnsjNoQKEZc=; b=GciZ3ZLNSU7CZxxtG4FDb/chNJZxUSLoAkSn2N
	DYiFMrZKKYosXhm4IB67iSIC5MfjK3xXvFMQMlMrnGH9lmuFoVUumD8PKjJsiSdZ
	HH8WNNyW4w4v4tNY23Cn/C7GOS4JTacurHxc0Fzf1QL838ggl/GKUzz4XoF0wuNz
	4NGfXyfp3Njg612A7IbICQB6n2J0zfOpicri+jpLwI1gHoNxthJWdiVju++j2Tz6
	7ncLHY3Xin+/ds8WhCLqn89/hhFXQYU11ervuDzJW6uyd+jNhOrvIQ/cEf+FjBkp
	Vbdip4kf3JSvUYHrKMlxUHotosIj4WXhJMFCNrM1pC69uOlQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnngg9gw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Mar 2026 09:03:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ab7f67fso6178099685a.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 01:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772528597; x=1773133397; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TkTFcphozn9ku+tN3w/WkucRtPDQzYjgQnsjNoQKEZc=;
        b=hG5oh5sXute537nF9gZubojSV9DjFQYcBhn+m3TbTmS2qJKbQ7oGSwNkvEcJhnFj/y
         npp+EA33h/qlrd3E3QKCtxIBOnmTMXk+adDX0QHOHWjKbeobYY+tSxY2ZC4AgGMEajlU
         0Dn/eXvQqgYYiPwYsaHC/uqpERWuTfbbc/SWNnghF9lyeyESWehXyDyuzoT5/dQCR/DN
         crQGtW8UhkFdyvxg8d955Y/mI/J7NYn+0B8qpDXot0bl9aqwkEzyrCUwF+jKfjSPzGBU
         tDHZWcT7chxkvwr145pQ9jiAqgMr1qTGOQcMCg3ZeFeIlkawsuBWzUBF+hjOG13gneqq
         omWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528597; x=1773133397;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkTFcphozn9ku+tN3w/WkucRtPDQzYjgQnsjNoQKEZc=;
        b=r7jwQzIhAAzLQRYYqJg9y3DdDHLWL7/OLwJfeMcD2Ki40KvqLz6cYpiJat3dLvYk4F
         fI1DGkmJHuGz40uswWkVTsuohGK2306kNuvJyoFK/tuNWPuN2Ke/Bfx6cNHwpMUq0Pad
         2Nu3p77xye6bFoiFK26ObYTh6hYZcf+6IHhxyVK/Xl47+dt6TBdwGQ8+SIoI7vUe1KKb
         uElwrYLAKP1dJNURyBzymR3TOUkyys4w0a3VC18JJfNhEVdqn2cWRhL0lJzTgXe5y9N2
         X4c/+AKTEPXhdGeDXmRohyYCQIABNpPFSqSx9IfCQFPi/V7v4UjJLeFzrXLHpqZscy5f
         pZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGhD4vzNLHnx69c5c+CNKMhdt+HnsLqn/wQUG9qceHDNblJMR7dDh+NHloTytjmjAAyaMQI9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKH4tvIfhV6THs3FMjuSaXn33n9g6lSstro4vb0117xr+qS/T
	iqRvzTDL+cJWWncKiGP6bOM/OamytRD2LHxv8Y2O/NBtIyWWK8LZUAhm8DlGzSgz/J2r9s3iQOa
	/kY2gf3TzAPo1e8DtKQlQJYgDsz04peKtrL38cPQ1vAJVgTZcyWeivr/J6pY=
X-Gm-Gg: ATEYQzwfPSCh2IeI7oP4i2AWJPw7T85OEDTQNWDDAdrl3/B+1JoJPrC9B+qwr5tABlx
	sUjI8np4ct4iLGYFxAkPCIe8qktXLNYrBouXrwtouO0qAtZeKED0qJwMcMy2Zzgn/NeicD6dA3+
	zW9koVe4ubjcjHvjnxQCdwhUbz3E0PTiFy1rWyaUYnpCYSovTmhz6TCsBteT8QwRr+ZW0h6NvI8
	HF9jjm0oFvvC4na7QpObmZ+unHkfv1Oc08RLuXXycyws5MKjUPqNOFHCQp1c5NNOvLDe2bF9wEQ
	CDJSJvhgwnX2S47UW9E4+RT0FbdiBNsOC7B3BHyHp9NbiHZ3MsCMrO+VBVOIvF9Yj7neH4sCgrf
	GPVcvyC2npPugDQMr2tqbsjvjfuNr2A==
X-Received: by 2002:a05:620a:4515:b0:8c5:c9a0:ac28 with SMTP id af79cd13be357-8cbc8ddefc6mr2051043785a.21.1772528597299;
        Tue, 03 Mar 2026 01:03:17 -0800 (PST)
X-Received: by 2002:a05:620a:4515:b0:8c5:c9a0:ac28 with SMTP id af79cd13be357-8cbc8ddefc6mr2051039085a.21.1772528596805;
        Tue, 03 Mar 2026 01:03:16 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b7713csm305446785e9.11.2026.03.03.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:03:16 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 03 Mar 2026 11:03:11 +0200
Subject: [PATCH v4] dt-bindings: display: msm: Fix reg ranges and clocks on
 Glymur
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-glymur-fix-dp-bindings-reg-clocks-v4-1-1ebd9c7c2cee@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM6jpmkC/5WOQQ6CMBBFr0K6dkgpRcSV9zAu2jKFKlDtCNEY7
 m7RhRsXupnkJS/vz4MRBofEtsmDBZwcOT9EkKuEmVYNDYKrIzPBxZoLUULT3fsxgHU3qM+g3VC
 7oSEI2IDpvDkRlFzW3BiNaCsWO+eA0X5t7A9vplEf0VyX8GK0jq4+3F9PTNni/bM3ZZBBVdlSS
 6FlrtTOE6WXUXXG930aD1tmp/wTzrn4JZwDh41FWSmT2aJYfwnP8/wEZZkgF0QBAAA=
X-Change-ID: 20260227-glymur-fix-dp-bindings-reg-clocks-704d0ccbeef9
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
        stable@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4732;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=v6GXIpomCwRaIEBFV0H7mVE2cv9w18Jd0dv/uSNpndo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppqPQFATVkMVWtiDfAQztcUVwOCLi/R8CS1GNa
 1ZEEvkDgw+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaaj0AAKCRAbX0TJAJUV
 Vsr1D/sHZq+NtGK7x3itFiR2rS3N4JOSxwkr5xJ8vU0K7ETjZBnWJfX04FfFrbF0Ofp4tGFxMrN
 3M3GNtcQvAPBIIXSkFp0Pa5d64auW/8WZXwPh8lMyVD5DbHzEEnfw5k7Zz96qHl0JobEmLTnNxC
 V/30CIjZQRzLrBymmhloBVRC1Bop1J3NY8JonZq0d5jDIrc1yNDWm4GLmCGa1gIih7o1UOGzeIv
 ZkY7rDZst0wGgb9JXpi1q6n5ViKmmDwtFh13qaSbFo/5Te+P+SwHUeLdEORVEpzC8rn8hzZJfYs
 2RbjGi3yKPjmVJ73JK8l7KNrPuYdh1Krw+UEkSRQuurWTOJMLHEb9JlUr1TFaggqXdS3R2qHORC
 geaJVNLKwt7xmKja/GIipiQf8/PZOpk0KLGRfZ0g41JVLgwjkKiaq3/CVQJ6AyMDsaq5Qq2E5l2
 ncMhVoAE1/cjBJnNnB37lbio0OfOcYO4Y22F17ZwS9V11dB06t3SFKaNaXPh27V9T339sgd6QKD
 jFLg9SdkRhAJMAdG6pAjbQXxh31O0KOW+9KidgVq70DBcJ0S7U/+gj7Pe1DZedQ04mVFyCP0kD2
 KBUW5yNZ/EsX20LuLBXyMvDm2tZtLq0lZ/6ATSBYwPHUsWGCTDeYXw6WPoHRfrQr9whd/pBUpk8
 HHyQoTbljkreWsA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=P7E3RyAu c=1 sm=1 tr=0 ts=69a6a3d6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=z1kAzz1p8kaNlQmLfu8A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: HGxk5fB3l3l79XCsgfkECnp3sM6KqrQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA2NiBTYWx0ZWRfX7iCN8bZNlV1S
 Me1oH2aEkOiuikMMKMNDXxb0uX/RVmo2WtskR3LbZ/qp5woMgJbgI9Cux7WihvREf8+U0gG4pr8
 q5N9Zaxoi1PGSj//0GuHj/XfWyfak9vTgIXiiKyMk3QhZZUulriRxVdKjN7v/KTiIIs8ddE61uU
 74n+zQuK5SUPfTHl+s7mJgeHmTW0NbBEMupQxbbDJaDtPs4LPIpZRKx6N/O6QEZlLKzphfy62pi
 6uvtOshBFlULHGHjxfqp00k2LAVlQ9tsbzNA90WYPJkUsuwNeM/37fY0sc3/k+JM8vWQiadv8ax
 553jBGcrNuwMFxyWrPlC4BJWUdqt0MER7fVqLN8PbJtMyzd8AMMeoi0nFHaehtfUADIApMA+aDe
 srwM0qO4BbW74stJqKR7RWw9mbi1R2TBcHjF2wxRE55D1grBlpDOvUeMBAIUIJ5MdTCC/J2GcVa
 A3yHPDYfFCZNe3SsSXQ==
X-Proofpoint-ORIG-GUID: HGxk5fB3l3l79XCsgfkECnp3sM6KqrQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030066
X-Rspamd-Queue-Id: 6CF011EBA4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222835-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,ae90000:email,af54000:email,msgid.link:url];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,linux.intel.com,suse.de,ffwll.ch,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Action: no action

The Glymur platform has four DisplayPort controllers. The hardware
supports four streams (MST) per controller. However, on Glymur the first
three controllers only have two streams wired to the display subsystem,
while the fourth controller operates in single-stream mode.

Add a dedicated clause for the Glymur compatible to require the register
ranges for all four stream blocks, while allowing either one pixel clock
(for the single-stream controller) or two pixel clocks (for the remaining
controllers).

Update the Glymur MDSS schema example by adding the missing p2, p3,
mst2link and mst3link register blocks. Without these, the bindings
validation fails. Also replace the made-up register addresses with the
actual addresses from the first controller to match the SoC devicetree
description.

Cc: stable@vger.kernel.org # v6.19
Fixes: 8f63bf908213 ("dt-bindings: display: msm: Document the Glymur DiplayPort controller")
Fixes: 1aee577bbc60 ("dt-bindings: display: msm: Document the Glymur Mobile Display SubSystem")
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Did not pick up Dmitry's R-b tag as patches have been squashed
and commit message re-worded.
---
Changes in v4:
- Squashed so that it doesn't break bisectability, as
  suggested by Krzysztof.
- Link to v3: https://patch.msgid.link/20260302-glymur-fix-dp-bindings-reg-clocks-v3-0-8fe49ac1f556@oss.qualcomm.com

Changes in v3:
- Fixed the reg ranges in the example node in qcom,glymur-mdss.yaml as well.
- Link to v2: https://patch.msgid.link/20260302-glymur-fix-dp-bindings-reg-clocks-v2-0-e99b6f871e3b@oss.qualcomm.com

Changes in v2:
- mistakenly sent without cover subject line. Please ignore.
- Link to v1: https://patch.msgid.link/20260227-glymur-fix-dp-bindings-reg-clocks-v1-1-99f7b42b43aa@oss.qualcomm.com
---
 .../bindings/display/msm/dp-controller.yaml         | 21 ++++++++++++++++++++-
 .../bindings/display/msm/qcom,glymur-mdss.yaml      | 16 ++++++++++------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index ebda78db87a6..02ddfaab5f56 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -253,7 +253,6 @@ allOf:
             enum:
               # these platforms support 2 streams MST on some interfaces,
               # others are SST only
-              - qcom,glymur-dp
               - qcom,sc8280xp-dp
               - qcom,x1e80100-dp
     then:
@@ -310,6 +309,26 @@ allOf:
           minItems: 6
           maxItems: 8
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              # these platforms support 2 streams MST on some interfaces,
+              # others are SST only, but all controllers have 4 ports
+              - qcom,glymur-dp
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+        clocks:
+          minItems: 5
+          maxItems: 6
+        clocks-names:
+          minItems: 5
+          maxItems: 6
+
 unevaluatedProperties: false
 
 examples:
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

---
base-commit: 7c21b660e919698b10efa8bdb120f0f9bc3d3832
change-id: 20260227-glymur-fix-dp-bindings-reg-clocks-704d0ccbeef9

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>



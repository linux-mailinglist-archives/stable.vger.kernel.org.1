Return-Path: <stable+bounces-222552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMFbA3hZpWnj9wUAu9opvQ
	(envelope-from <stable+bounces-222552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:33:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8721D59AF
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E892300A25A
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5BD38F62A;
	Mon,  2 Mar 2026 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jmWlgbr/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvBZhf+G"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581D30F934
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444012; cv=none; b=ATN1v8N4vBIIaL3voVGDcf0vXvCuO2H4pkH2MmwU9Raouo41t3+nXjn5E8uGGaxfIlRUquvZ+alXcIMX53YqMhJ3rOwKfwEx48/+p3voZZ8XKGSE6/xxU6koirtJwiyAlbmVl0RLnyv2LfPhv+kJ5pm1Xwz5lMXI8eIWVAZz7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444012; c=relaxed/simple;
	bh=wY7IfBK8MfIbdgSrQbHeq1IBuOSDLU4dySVR+TMj+EU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f4gkJb0FKijqKU3SJ8wFEgprX3TTcvYuvEAz9xew42uPIg0wMXetGYk+TgEyQUmsPmY79WVqqzVCUE42iyMOXRbt7ThYn8azXSYYD60tVLrD3JEzt0YMJ39wMZ4TSz++CrzO6Z0M9f6r71qfwVuDVcWmsqSKWkkwJbVrAX2P7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jmWlgbr/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GvBZhf+G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226h9Fi2504592
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 09:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5ubBi6Bvh6rrf+XIS9huHc
	+cLy2tCgROMoo7C9gzJfw=; b=jmWlgbr/epNgbaGvrcR3koGVziEIaQZQlvqU4F
	WCMgULjd6oFL4S/cxogG+Aen9cmaYtmK2jTs9HFLlLq4Iji/JZT4IVYcO7GjtNSs
	ZZjBXv1rn2rM/mD5EL9mNEiSWokfWvdqE+Z8337U1LAI7OBSYzwp6QdpZF7sa0cy
	TqHfI95nnPfbP/FyGfXYdn5t81Vx4YWHk9Gd0SR1TW8L3s8dutzJw4dWINAgtfNt
	MgSYGVjnJinhJM4v71hqZ/dIZLCo8lb0oudH1YLESvdLGV2Hcse0LUpAPfLs8xw2
	TwYKsfCZ+pjQCC9PG3z637jQw6VYsZ/khxRAmuMFdMDo3Iow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn5hermf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 09:33:31 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4a241582so2932342585a.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772444010; x=1773048810; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ubBi6Bvh6rrf+XIS9huHc+cLy2tCgROMoo7C9gzJfw=;
        b=GvBZhf+GVKPA3hQ4WikQU1VEuN9uZejYR7w7iiDmByGOW/WYN4FFUkh6F5XYMDVypy
         vh+M3clj8Ojq9XhnkodDRYZpkcB2QB5oyr3dZPboIFEY1u/Y5YSisB7fvEEgBb5dpws0
         +Y/Pw/f1OAvy7ta3vcZhVlgRT4PKs7QIEORAE9txAoQdS3hErN6Pu/AbhR+s1EdERlX3
         oXWo9l2uFEWKgMUl12Ooth2M3FjUNMjzRRW7OClvqoHcqj8f2zIFY+nwbp3N60cd7VEM
         GxwdX7zwg4QVPjZayvgU7gYKIAPYIGB0vEdfvcdja08LUViWmQgdvo7KU5FobmI2mj/C
         Q77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772444010; x=1773048810;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ubBi6Bvh6rrf+XIS9huHc+cLy2tCgROMoo7C9gzJfw=;
        b=iu32oPVL8rMdPGCXH+cs0BJF0keal9YcJyHyrPkeKjtPF99Nd1smgpjJ5tGGmxvENh
         VG47g9SeEw0Z0xS8JycGFo3KRDf8njImbqZnw4jmt5Tss/HNqp+lq2nNJ4yMlBIKLT/e
         U0/kO8d7EbHYttE7tZpwt7pme9MobJ18EnAulV1xSfobEcRLvnco3f14Zd/UoSry1o7K
         6M0f/R4biq768aVYnyh1SxfEeyG7ZkZqTcENd8MkHtnrNBgyp47h2JR/FvWBdO18DcMz
         z5+pERYr/1l0nbhXav2JfSV4oek/lWVG1AIhV5/168t+zICngGrqJagwvvznWxwq21MC
         gHXg==
X-Forwarded-Encrypted: i=1; AJvYcCVGPVPvAGADKHDbenVX4GkvS0zt5filzte49hzNqKgNDqUbzdX0xZGfm1Fh7olxHsVqZQTa/TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuneoH1ZAJOYhQi3igwWV3wnCMKODEjlh2I5iCsuNmetmEsD4Z
	qDDR5RVfF+mEH/asGKt9Id3huGxY+KVFCGJPoZS3amrHmi6UPAu3wWWnNZlPsKcrnHMYUv5gtuA
	FnAo+k4FvD+TmiRHWjh+kAFbCvP4EFGm50g08T6+l9RXNjat4uoUcUKP36tU=
X-Gm-Gg: ATEYQzyGKE7fStTD/HnDF2yIa1LWG2bCLe4C6tFxjNJc3tjnxQdrmsDf8kDjz6CdN5o
	U+aJlWjpUjMwGzcqK3eNNg5039v8ShX7Dj3MA4pwIzIZFV07ktJC7Yhee+Xh/jBiQYQmxJtD9cv
	pdSaAi+WWgD1BE/MTL0S+IZ1o+D4NDoFOTDv9y/GQrbyaoNHHIFT3SJDDivc4K9irHIWlhtzXN6
	Ild2zvrzHXxVtjdqc/mp5xygwbceYBsADZGKox4Efx3hKPSk8kkyD3hLZfBxmFi/tzld394tGjH
	PKFsTrbRa/E8HrL5y5e6FY1CQgUrUlpYKP8r52THJRPAbByvYm0JKUjLniAunhhOhg1pe9RvcsX
	s/5yZYxZ1ED2E3vdpjF3dyDn+GU6Etg==
X-Received: by 2002:a05:620a:1903:b0:8c6:a2f2:d874 with SMTP id af79cd13be357-8cbc8df7154mr1251283785a.39.1772444009912;
        Mon, 02 Mar 2026 01:33:29 -0800 (PST)
X-Received: by 2002:a05:620a:1903:b0:8c6:a2f2:d874 with SMTP id af79cd13be357-8cbc8df7154mr1251280885a.39.1772444009263;
        Mon, 02 Mar 2026 01:33:29 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm9968789f8f.39.2026.03.02.01.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 01:33:28 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v2 0/2] (no cover subject)
Date: Mon, 02 Mar 2026 11:33:18 +0200
Message-Id: <20260302-glymur-fix-dp-bindings-reg-clocks-v2-0-e99b6f871e3b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5ZpWkC/5WOTQ6CMBSEr2K69pFSiQRX3sOw6M+jVKHFPiASw
 t0teAI3k3zJl5lZGWF0SOx2WlnE2ZELPoE4n5hupbcIziRmgosrF6IE2y39FKFxHzADKOeN85Y
 gogXdBf0iKHlhuNYKsalY6hkiJvvYeNQ/pkk9UY978W60jsYQl+PEnO/eP3tzDjlUVVOqQqjiI
 uU9EGXvSXY69H2WgtXbtn0BjZ2CTusAAAA=
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
        Abel Vesa <abel.vesa@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=836;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=wY7IfBK8MfIbdgSrQbHeq1IBuOSDLU4dySVR+TMj+EU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppVljNJoUYrcp3sFgJgfG7g1yxqArNlmlxiWbg
 LX04b35ul6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaVZYwAKCRAbX0TJAJUV
 VkkmD/9amRQWuF7D6PlMnZhj2NQWbjA6DG5LlhmvAVC3EGZGJwFoG4jnfnYJO4lwoo6Wd5aGXX0
 jhKt4JeiYjupoNG6gGFS6VUM4LdCaTEfzMqmT28axTDvr1M/PILJubPkO7KSyrIPwAQnTmdE1o6
 9jeTfSco28cAAH8f+lUYPaWFU0tNoq9iiaHpP04UPRQXmlmirMAQoxqGOcS0ggU3ZFlsjmPAEiZ
 Ig7Xq58wyQ2EXHBbA4QeGPrX9B3+Up5lf6ZnYTOkrIhQVVomtvclMfKhnImrMwI4RirQMGB1Bvd
 RtF94+mXeuo8u9vY5zzTm3JJc18UaIAj5yBGeIh0XXvsrGqjp/x99+LGvs+Ff0zG2H6LCOjyrMh
 0oBAAHdCjAHGU+wqC6y/3rG9UHJF2bM5JEro7rnsAEb0mLDlXEdbdKm5niDhRZnuuYvBD7/rmKU
 lNuauvlDRxHHmspaUpB+WuwKVf/3GFcuHjar62h46raRtm5XQLfAyqkVhPaew8nlev+u6XSwSJk
 exoBlt0bNF7umd4Ib5b+5vweDolGY9b5DiqROuTSdxim3/iQw+qRkkeUXimQt5M2iFDInY8X7U/
 XHkkpVW9mLurO/HlVD/oO5fTYDE1+mHWVvn9irg2CAhg54P6spBw6q7YlyPYKiCcHHlX8d4909D
 x+9ChDaY+ozmyQg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=BI++bVQG c=1 sm=1 tr=0 ts=69a5596b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=DbH3OLhbisy877XqOIAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: LH3gHDha1_7wijCP5dZZ8LfG_vFEkFPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OSBTYWx0ZWRfX6AriUd7CbUtm
 6lJcRQx6GliqFnb6ZG05BE1Dn55ezFw3aIXaAeeY42hP4ZVAhTICtJExB2GlXKpq7/P4e2asgfp
 XPJyA68R9lr2QspKNvukX+/DL5A5v6v6suJauRu/slRh7m7Zp62tR+7NiI4Z1P4mn2bZepzyqJu
 i5t+ngazgN3A6LkUTjgfZ64+2RujhEU75jZAG19XXA/zm+H1G9hQVJS7L86b/Ze8Z9/pRRJJ8if
 xYPVjcM7cV9ZVbNkQtuSMFS9ZUrpSw15nTTZt/vj6iAE1fBAmPfjjTLkT9Zq5q6y2BIkv9jKu6E
 ++aznRnfKVNi7nPt6mfbUZveanAPfwoieuLSVbj0hu8jc7/F9Z3iutHL4tQb9M7G7xvgFpcPiFk
 oEoyBR9OXi3gdgnqMchmTfF2qb35iU/OgcWChQd5GjympV67UO/zUpkZXZKOsZfXdejmLzTYe9U
 Z7RcFMJ4Aa6Eoy2h4Lg==
X-Proofpoint-ORIG-GUID: LH3gHDha1_7wijCP5dZZ8LfG_vFEkFPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020079
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222552-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,linux.intel.com,suse.de,ffwll.ch,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 2E8721D59AF
X-Rspamd-Action: no action

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v2:
- Fixed the reg ranges in the example node in qcom,glymur-mdss.yaml as well.
- Link to v1: https://patch.msgid.link/20260227-glymur-fix-dp-bindings-reg-clocks-v1-1-99f7b42b43aa@oss.qualcomm.com

---
Abel Vesa (2):
      dt-bindings: display: msm: Fix reg ranges and clocks on Glymur
      dt-bindings: display: msm: Fix reg ranges for DP example node

 .../bindings/display/msm/dp-controller.yaml         | 21 ++++++++++++++++++++-
 .../bindings/display/msm/qcom,glymur-mdss.yaml      | 16 ++++++++++------
 2 files changed, 30 insertions(+), 7 deletions(-)
---
base-commit: 7c21b660e919698b10efa8bdb120f0f9bc3d3832
change-id: 20260227-glymur-fix-dp-bindings-reg-clocks-704d0ccbeef9

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>



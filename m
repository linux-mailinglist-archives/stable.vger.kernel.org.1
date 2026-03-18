Return-Path: <stable+bounces-227084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI+PCMi+umkGbgIAu9opvQ
	(envelope-from <stable+bounces-227084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:03:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8042BDCE0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 662D830BA236
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B63DB62A;
	Wed, 18 Mar 2026 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwhG66If";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iuWcOxoc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D33DC4CA
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844958; cv=none; b=PSkrMGzcQ0niZ/zK5cwgyw5wI/Uqzy8jg1kMTe4hyasBNkLWlhCHDLWwmW8Hjxsp5juhiKsS/qD+E2uJsrF2MzdrmpgVn9KO3kryNJt+WiCrS3I83/1WKl1lDeP20Xef5RspvSjd4W90SSsNFE7L8F+6d5iBI1FQYES/3CKv7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844958; c=relaxed/simple;
	bh=YdZ5k7GUTAo2Mf5Xxz3T37XRI4CgIjwIgMZxRUGa0+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZAcwPcdRNNIaO99893u6tPzqoC9KCcGYcCnDBrnLSoohfC/Pn0go5bDYmx5UKrWDmwx7Y50AVLNaUU/s2810wkIjfnSvMonAOP9SegfCWRCq5Qi0qb8VQmEsXy3204AcW6MwnPwTslhf0rvSXTJW/M1iYKD6HWS1Hmsdl/s9Cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwhG66If; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iuWcOxoc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I9KJGO402512
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jUCbb5iwkyYLYVRbAB1fwG
	3GAnZu6GkdLgWfPUeH8Wo=; b=JwhG66IfmcKIeN+UTJ/F6xDIHPw6/qsjedJ2on
	OOAiy2EfUmkJmt5mboozjdcYlBFPDoqIcrVVuvXwGdjB6z+fka3Rhlc1802eWR9b
	qOm1NNSsPkODN0/KC3O93hRIwecuQdkbzXKvWx68HpLvlFBrLvaN0VYJtAlGfgUj
	7WVnJ1wARWKIr3ASUN3u2NGvDMfQK551FSv4/CSSjwWLJTgHiQXbW2aNnD8STXe+
	8xGJS/F+hpeEaaJ34LL3Zy3M30N9PWQoYj3IT0bLlM3Dlde9iDK+qkqso/7zB/P4
	Vz2yeWfkfjLRgj8yV6f/s3GRDa9Q9hN4MJDMY50RjUZLhD1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyc4dv86r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 14:42:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-509011403a7so8868681cf.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773844955; x=1774449755; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUCbb5iwkyYLYVRbAB1fwG3GAnZu6GkdLgWfPUeH8Wo=;
        b=iuWcOxocHhTjlwaHvLIshq/DIxUAVU7UawsgJPcIRpcNBmAT9H3Qfn1ZIBQzIcfLh3
         MNlP+7MecnfxA1q+yduH+i91hGvywiRa+ldHkXdTilAgAVeO6DUiUeOCSG5j8/DK9Wbv
         hiG9AiuWLGIJNsAXuTnPsk4nPI+ddYjqSoAh9Zd9iP7mDCR19/DpEZo0vAWgMCZVnjzi
         YOR42rAddzlG5yLy3PnI6muOu0ip+sdz5ZBse5UWL8xGZUaaZEU1a/SZR8/Enl0AXFu0
         cgnb++F86TjvdRsGlH/vNDhHyL8uqtt5/tfqlO/+RN7ldckSWKWmKRbb6Wk9+G7T0dPi
         h0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773844955; x=1774449755;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUCbb5iwkyYLYVRbAB1fwG3GAnZu6GkdLgWfPUeH8Wo=;
        b=nmK7VzLa/plJqAfJ5iloG+s+8QwvYyVmnaeerCzBqMDro6DDiPGjLNzFeI4ZHAmwT0
         INbP237sWE9WerfvRwryx2Os4jXEI7/UfvqtW0gzK9+dM2PbdWjY4kbAbRaS861NsPbS
         nhmNv8Tl1wfTCm5VI238Yp/KP+QPW6AV2Mo6TwDT0RGbcAZ7Q5wt3HLvg/bt0hv0ENd7
         dukF4KEEQI7DZkn/KQ9M3mgxfT4UT0Bdn89XjQ+n1sc3yexqp2SkJNJzWG+ZszU06V30
         3HNJffSGR5IB4+Au2MZmNlwId+Ft/92lIL35GdxT2fle8VKRZKt7uJoyDFznAUN3N+rs
         DaMw==
X-Forwarded-Encrypted: i=1; AJvYcCWAwIUL/C0YKK5IaDKqT5eZCZ0oA4xKvy0Ioh5VwRCj6fQKG+2iJqHlRjmYj5GMU1NKFFjCGqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ilPnLNWFLZ8hTEfGsVxqpeS9uMhT+iXuTeJ7dRKmxsidAHXl
	YTGt9t6u66i3b905u+sVCLKmeWWWzxYX12Vzwf5qZow6is5nAzpq6/M1YMf+LAsLZ0SGMuZzLmE
	3nk/QDeDLXJhpNbL4m7tuyBbDlFsmyyfwu6tstF/4+OuimxM/7IyyMtqm1gGhvUszVAs=
X-Gm-Gg: ATEYQzwq1/eFUuV0HAtNjY3oJaXGCwSBLchJK9LUPdaX32F4THAnFwjF0uaWGB2Rg5Y
	q+qYxslWYFI6jTwlcPF7pA3SQRs20Dy67UDN705/g/JQ3D2b/hPreBYXjEz7ZU8NvStV+k9V6uC
	CZsPHVFwNMre8Fm/FFlL5TXLD9swfh6U4MMj+HtROEml9qYG8AEuY15MnEcYuh+XqlF4ccl5lY6
	5ILFcWBICCioYH0IJn/5l1SFlpSGDghlbkwtEYx0BJQPrIjxKVCyx60Lb7dYZ6hqiUyJa7tWBxG
	jChG9GDLYwvTOA6/xGUN/4V16aSfcT/dT1izbJrhSv2mP2GoEto8mgFtOcpQ94ooxVrw1P12yXj
	K8uNRuTraS6irW0vr0znN0jgLmiw=
X-Received: by 2002:a05:622a:343:b0:509:3f5d:4fb3 with SMTP id d75a77b69052e-50b14753402mr45643571cf.13.1773844955112;
        Wed, 18 Mar 2026 07:42:35 -0700 (PDT)
X-Received: by 2002:a05:622a:343:b0:509:3f5d:4fb3 with SMTP id d75a77b69052e-50b14753402mr45643031cf.13.1773844954457;
        Wed, 18 Mar 2026 07:42:34 -0700 (PDT)
Received: from hackbox.lan ([82.79.95.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f420d7b5sm108111695e9.2.2026.03.18.07.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 07:42:33 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Wed, 18 Mar 2026 16:42:25 +0200
Subject: [PATCH v2] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-hamoa-fix-dp3-opp-table-v2-1-3663767e22b0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANC5umkC/4WNQQ6CMBBFr0K6dkhLQcGV9zAspmWQGqC1BaIh3
 N2CBzCTTPKS9/9fWSBvKLBrsjJPiwnGjhGyU8J0h+ODwDSRWcazM5e8gg4Hi9CaNzROgnUOJlQ
 9QV5IVWJBUmnOYtp5itLRfK9/HGb1JD3tdbvRmTBZ/zmmF7F7/1cWAfGwFLloLqKt2psNIX3N2
 Gs7DGl8rN627QtXkU7x1wAAAA==
X-Change-ID: 20260309-hamoa-fix-dp3-opp-table-453b8a5e3bc0
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-7ae85
X-Developer-Signature: v=1; a=openpgp-sha256; l=5310;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=YdZ5k7GUTAo2Mf5Xxz3T37XRI4CgIjwIgMZxRUGa0+0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpurnR5gHE3WILLAAaFsuXxQbePeSnU3/kkI1H5
 7z3cDhVeeSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCabq50QAKCRAbX0TJAJUV
 VnPbD/9EtIAcpfEvd9LO2D5D7J+VCImbBffgfM58Afe0QdAZHnCp6NakvI984gxAUKryoK/VC7T
 U5+hWu3HSaWpxvvIgt5spcSwl5XZnsSfHTcN00fAZ42ZezVcHPg5SsGIYXc2L3ELG23Nu+BuEvX
 yyOlY5kBVGxFMnIn+tBgOR/FuJtenbRpnaugHKut3LRdAj7pRqswdXwLAXwzAZZnaIhiRZIumWm
 +KT6CsjT6zrzjE09PaxnxLgyDqS1zmvnRqx/IVh8he1Q2BMX5V07OBQnOKDJ3/lPuVTJrTUZ7+J
 a7B8M2rNWknQmDsReEilO7w2dLByt46L4jSoiH02paIBYBSn1+cgHgE/Gp+njyiufSVHwwtgfRO
 xZfo2e9r1SjH9lTyDgSzkmltpoCKZAWtd2hAyIxNm4pJCqMa9fcJGjyJ8D8/zP4e1rZIKJcqdTH
 k7jIFfjxcsJKaKbn3HtPeyzCc7pvz+pmrhF5BLgSKcTdvtCkjC2euJJHlhpFBgzJGLScgo8N2+h
 noptNgSyZuF9aQ+XiL75qRQv2LbU0yzAmJUMfWkNCcZEbuSwb1LAlArVBLA6Wb/Pl0PHOzZG23F
 txsX3dsjTlhsMZ32CYcCwKBsX9F4hJ/lJR2CwSP4RrqwbvAahHkrTM3OuwQawjnSJCDCRxuEDdH
 423ILrBwvA5DZGg==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyNSBTYWx0ZWRfX9lFq+Gkw19V2
 NWqSp5MBBlWbq1n/YReEPz57J25FLS1Rs8HBwwX2qLffuwe7ExtSzf8VYbRGwL1h6GGXyAx9zEh
 afwFrsnHpZQQejgEW8UyyJi6ZYT12PNRuiBKJn3CFYXnnyP0naAV2rNhU0WZvznkmQM/thFTu8S
 ca+NRF2fCzAffVmCEA/6Qjk6uciGWTN3shFVQPq2dTyJxte4wDzu7VLjUue2blhMR+1tSxRJ4nP
 eh2C5cFyOuB4tR1iL8m0KF2HEcBas4gpk88JoF0T2dRQUDpz+ikuQs4kTrsiAnCQtaYMLXYzP3Y
 kwb/2QamTOeT86wkRGSdOW2qF+00FqEZA2Y9ICWtVAKFGIw3AU9B27Fwm4wUY3lIAG6qgnRL2He
 FkXcKmSR0Kq3Yvco8IYuy6RRH7x21PYxrjFXAXkldvO8xwsEewjxeC262DbkRgVoFQg6Bt2K1YK
 CUeSqg5v/nuslgWAOlg==
X-Proofpoint-GUID: 0KuMD4F1CWC0FDbtMRdE2Svw_Pk80V9u
X-Authority-Analysis: v=2.4 cv=DfQaa/tW c=1 sm=1 tr=0 ts=69bab9dc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=iKs3dpp2RB4k51ZqCjcyjQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=d4EVK6T340-jQqwUKIwA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 0KuMD4F1CWC0FDbtMRdE2Svw_Pk80V9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180125
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-227084-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aea0000:email,msgid.link:url,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,ae98000:email,ae9a000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2C8042BDCE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to internal documentation, the corners specific for each rate
from the DP link clock are:
 - LOWSVS_D1 -> 19.2 MHz
 - LOWSVS    -> 270 MHz
 - SVS       -> 540 MHz (594 MHz in case of DP3)
 - SVS_L1    -> 594 MHz
 - NOM       -> 810 MHz
 - NOM_L1    -> 810 MHz
 - TURBO     -> 810 MHz

So fix all tables for each of the four controllers according to the
documentation, but since DP0 through DP2 have the same entries in their
tables, lets drop the DP1 and DP2 and have all of them share the DP0
table instead. However keep a separate table for the DP3 as it is
different for the SVS, compared to the rest of the controllers.

The 19.2 @ LOWSVS_D1 isn't needed as the controller will select 162 MHz
for RBR, which falls under the 270 MHz and it will vote for that LOWSVS
in that case.

Cc: stable@vger.kernel.org # v6.9+
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v2:
- Rebased on next-20260317.
- Dropped the DP1 and DP2 opp tables and used the DP0 for them instead.
  However kept the DP3 one in as it is now different.
- Link to v1: https://patch.msgid.link/20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 77 ++++++-------------------------------
 1 file changed, 12 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index d7596ccf63b9..3ff832a68a68 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5658,18 +5658,18 @@ mdss_dp0_out: endpoint {
 				mdss_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-540000000 {
 						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
 						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
@@ -5710,7 +5710,7 @@ mdss_dp1: displayport-controller@ae98000 {
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp1_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -5743,30 +5743,6 @@ mdss_dp1_out: endpoint {
 						};
 					};
 				};
-
-				mdss_dp1_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
-					opp-270000000 {
-						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
-					};
-
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
-					};
-
-					opp-810000000 {
-						opp-hz = /bits/ 64 <810000000>;
-						required-opps = <&rpmhpd_opp_nom>;
-					};
-				};
 			};
 
 			mdss_dp2: displayport-controller@ae9a000 {
@@ -5799,7 +5775,7 @@ mdss_dp2: displayport-controller@ae9a000 {
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp2_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -5831,30 +5807,6 @@ mdss_dp2_out: endpoint {
 						};
 					};
 				};
-
-				mdss_dp2_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
-					opp-270000000 {
-						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
-					};
-
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
-					};
-
-					opp-810000000 {
-						opp-hz = /bits/ 64 <810000000>;
-						required-opps = <&rpmhpd_opp_nom>;
-					};
-				};
 			};
 
 			mdss_dp3: displayport-controller@aea0000 {
@@ -5918,19 +5870,14 @@ mdss_dp3_out: endpoint {
 				mdss_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
+						required-opps = <&rpmhpd_opp_svs>;
 					};
 
 					opp-810000000 {

---
base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
change-id: 20260309-hamoa-fix-dp3-opp-table-453b8a5e3bc0

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>



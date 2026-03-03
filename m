Return-Path: <stable+bounces-222833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPSYDuykpmkTSQAAu9opvQ
	(envelope-from <stable+bounces-222833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:07:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1941EBA28
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31683306C442
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EE638C2C3;
	Tue,  3 Mar 2026 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XI/W+FBk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fvhKw/cZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678338A72F
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528546; cv=none; b=tNmdYeTqmwDbA6JpiU4hrasv4+adT+anptJ1a7pbTXyUAGoo7xUcdaolpCWLlWtOLxxRCH1Sr9kY8YZKCQ2rDZVZW7JDoC5bhLzhdolq5Ysj7r2uN99N3Vmct+QJzc+0TthgG8s07KSCpVXLPxuXi0kT0aAv+rsYJvN/kA6kNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528546; c=relaxed/simple;
	bh=nF3allrJaPSurlBTOy+OjL88YEUKbGJ3Wzw9ZYRFU8w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pLR4ptqD1UJLQxVyrJPlGPzOgRDnqicQhu9v8+2He0hoRLwp/e6ocveBWPk0rxnOooqScj3HT5gWojcQYw7v7ehtQvyl5Eyll60Iohc/OwITtKE9StvH7A5iVdvUJpvw3yqPYafzbnMfiqkkIDHrrHD9MexyI+Q2mpXMJT69fLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XI/W+FBk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fvhKw/cZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62352wTR3355757
	for <stable@vger.kernel.org>; Tue, 3 Mar 2026 09:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x9stiGj0JIZWulRxQkg2eU
	PltuECBDP0mhJ66zEg6Kw=; b=XI/W+FBkv+gkS52+OMQ1NsihkMKe14F2OJLlJK
	ylY4EC5jMGceRtr6ulr0rSMS3xT+eMosVCNvvCYZ+zQjwxgQrbWbFUG6wklgVArV
	4338jO2z1k6fgKOGMXi71GVUc+8t0i0499DmfaZljVyptp9wVuAXgj9VDcub1JdL
	Nokdv9Jaq1cklzMqGSJE6nJwkP3gCeAjFqnv3FDEzNLn6brFLDxLwE8dvII/LL2R
	7afxiL4vRp6AVNysqP7pqe8C+BhB4GkEl19Zs9LP2yEM11d30iRmzLSmtSlnhVoa
	oTncC3ASOj8vcflMec9+OtZa4ITT/uzfItOWkWOp76TtLoBg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cns5frseg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Mar 2026 09:02:24 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-464bbea2120so52708377b6e.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 01:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772528542; x=1773133342; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9stiGj0JIZWulRxQkg2eUPltuECBDP0mhJ66zEg6Kw=;
        b=fvhKw/cZaEdqiydBjbk9WT86fqXHNpn6dmq1tYfam/f2IAJaat6S/FWWwAAkxJ1dyu
         SZlkigavo+vu/KV4Wbg6EfqzdNqw6SLMl0f7ksxiMyvUfirgvVHbq6TSnalQ775MspcQ
         a2i/fQ16e1neW73G2pvEGL9l9FfnB9Wt7mbqN3r5ow/kVaNByGDoN2Aa+O7p5XnNHthf
         phjQ5qE4dMxWLohxl0EKG26zBr2/9fNJGuX+6OlAO1CIazCoQB3SCRAv6jvRu8zHJbXT
         KJ/3RjZGPol81cJtqfUnMRvanb/jfqlhoU1vJqZRNZBV67wA2fu5INa2ZGMxPTRYBm3/
         3Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528542; x=1773133342;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9stiGj0JIZWulRxQkg2eUPltuECBDP0mhJ66zEg6Kw=;
        b=FOzxuz6joTuJjVs6CVh+mT9X9TmBL2X1jIPPEdjUhsXvnzlWie6yCuuGsULVOV8sZz
         wBBUA6YpiCj9OlDQzoSUtRgk7HLhG+9D+4bSHzotWJf6edzQRqt872JGVes/qy5YPvbJ
         XSS0+MjBwUkJJElctxJSohK1UqpRw0QjYTga4ABoONb0gnpUaxKvgr9aYcDbwpSw41oo
         F/rCdjHZMzZ6oPEneLRHxuE26Ag4mrwTj+JRUR0/ROwMF/+JxD5m+JpDqeCbHEAE8BYh
         CNWZ9gSxLI49RISZYS/zSx2rHkkJ/oxvm3MCJZruub3WgBeYeVklWdbyynUsCgZVj+zS
         d2Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWZoRpl/euE7FD6NGCjRKyIW3wTjCicd3uYaQ+zHWrY/d59xN9whBTbuD2hm6TFQq8/thsVo34=@vger.kernel.org
X-Gm-Message-State: AOJu0YztV8pGTASqH4ni1+e6gNiGE3nLLq1pptaNnOdidlegfzJy0zWA
	GG+GXxBvsrR1TQIK90E+fuXsatyt95HhZzyehWumND0gvWcmjnuiNtrvP0NmM7eXsoOgj/x51BO
	jw6mHzd2Q002NOYKVJi8JFDYOCzq6qruMG/fKADKCKZmRaG4yXVkOI2cDEhkb9Mhh+mRJug==
X-Gm-Gg: ATEYQzzUeVnnffcW0Lm9Ap5nD6/5VKX000bhf38ETJabyh67+huxOKqOAHYdHbfEoTp
	q1X+Hnhvtepip2FDM4xoOFYjdCssgRXJAXiRxQrHsfbu23haedWc0MMt4S5cR0vOQuoUOT+jN5U
	KxAw67IRG+p7pUvMmioqulN563Vbs96mpJH8FvPEd0xgbW4U83HIUoKI8Jv8wc/GC1vDC3XwdSr
	jLVUvMuqbnKFtZnv486nxpxbzIUgXWKssZH9z4iadI5ojECX5Gh0GGvFYNKP78mKo726gQfhsTo
	n4iTBVyEBaG9XzpuZGp08G3zQo1k/dQm9+D+uaxcV2hskszUWiWWwn3xT5DWvlgKukAPOPBaQHG
	aUIcbB2jdyHK3kEJwrUyUS3Lfh7od5TyhfgB1HicuWrDTjjR7SqpoLj37JatIYTZLxO3U
X-Received: by 2002:a05:6808:1184:b0:463:c56f:a45b with SMTP id 5614622812f47-464beb27715mr8785053b6e.28.1772528542503;
        Tue, 03 Mar 2026 01:02:22 -0800 (PST)
X-Received: by 2002:a05:6808:1184:b0:463:c56f:a45b with SMTP id 5614622812f47-464beb27715mr8785030b6e.28.1772528541987;
        Tue, 03 Mar 2026 01:02:21 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb604f5esm9288908b6e.18.2026.03.03.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:02:21 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v2 0/2] bus: mhi: host: pci_generic: Improve boot
 performance and cleanup
Date: Tue, 03 Mar 2026 01:02:12 -0800
Message-Id: <20260303-b4-async_power_on-v2-0-d3db81eb457d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSjpmkC/x3MSwqAIBRG4a3EHSeoRWRbiYiyv7oTDYUehHtPG
 n6Dc16KCIxIXfFSwMmRvcvQZUF2n9wGwUs2aakbWclKzLWY4uPsePgLYfROGGWUhUELDcrdEbD
 y/T/7IaUPn+jb3mMAAAA=
X-Change-ID: 20260303-b4-async_power_on-9191ce9e8e2e
To: Manivannan Sadhasivam <mani@kernel.org>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772528541; l=1196;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=nF3allrJaPSurlBTOy+OjL88YEUKbGJ3Wzw9ZYRFU8w=;
 b=pFY9kEsq7rZvI/+O4GGwk6J5ndc3+jp7rMLnCJ738IcFGO9wVwMms9VXx7kt4K6ytaABbCcUH
 N+wM4jRxFyLCgEYE6MFkBoLjS9IXHgpWw/X4lhSj59h3wfP/7ndjq0o
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=Pv2ergM3 c=1 sm=1 tr=0 ts=69a6a3a0 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xtHKfOcq51I26jS6Dc4A:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: xUXm4EcuzU6odqREmy_0jvnMGatPRHpw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA2NiBTYWx0ZWRfX8WTYe89UP6T1
 QlBAtHW+e31L3rhwjpGfOD2IWvsC/VJbMiBA2VeTZMrr8qJx6XFp8fXaOU2p8WdfpBembUZtstm
 +mxKYhoOgpI5QMpxBtdpZMPtlS2yZLS9XqpRE9bZGOCjsOcQL1aYdsG7sl+gAbeA32gZzT9UwvS
 FoQJM4dQblPXOkeyGu3p3L6hXfCqpj/vQMtMc7rc0FZn9PmxuzbC3kmSeynCaNqp5gOu0RbX6hB
 wYefQb77a68wzu1TiIsQJE2CxYaFxe3G1DZCRvDL3jGRFCTMjGNuvjmJ6Z8W7lgCTAh7oD/y6m1
 P4mrHVyBjHlFyWQu9N2uMtRETU5RCnL2OXUbfh1vmT0CtVBvLwlC4FI65O3tXc9c4vYL6CHp8sA
 UrsqtWtx/QOVII9/8DC8qxfwpkf6fQVT2+pEWBu1dKrOc39b8kPhJQyACHWfp5feAmQI1/vSWae
 hwGdhLLTNsKZnTZC7aw==
X-Proofpoint-GUID: xUXm4EcuzU6odqREmy_0jvnMGatPRHpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030066
X-Rspamd-Queue-Id: 8E1941EBA28
X-Rspamd-Server: lfdr
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222833-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[qiang.yu@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This series addresses boot performance issues with MHI PCI generic driver
and adds proper cleanup in the remove path.

Some modems like SDX75 take up to 20 seconds to initialize, which blocks
system boot while waiting for them to reach mission mode. The first patch
switches to async power up so the driver can return immediately and let
initialization happen in the background.

The second patch adds the missing pm_runtime_forbid() call in remove to
balance the pm_runtime_allow() from probe.

Changes in v2:
- Make a separated patch for pm_runtime_forbid in remove callback.
- Link to v1: https://lore.kernel.org/r/20260122-mhi_async_probe-v1-1-b5cb2a3629d0@oss.qualcomm.com

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
Qiang Yu (2):
      bus: mhi: host: pci_generic: Switch to async power up to avoid boot delays
      bus: mhi: host: pci_generic: Add pm_runtime_forbid() in remove callback

 drivers/bus/mhi/host/pci_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 6a7084102bb9659f699005c420eb59eade6d3b4f
change-id: 20260303-b4-async_power_on-9191ce9e8e2e

Best regards,
-- 
Qiang Yu <qiang.yu@oss.qualcomm.com>



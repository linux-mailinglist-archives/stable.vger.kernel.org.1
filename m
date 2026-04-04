Return-Path: <stable+bounces-233292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DddKa5D0WmNHAcAu9opvQ
	(envelope-from <stable+bounces-233292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 19:00:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C739BD97
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 19:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E0C0300DDD3
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40582741A0;
	Sat,  4 Apr 2026 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pH6exHM4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W2Dk+wUd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63F23FC5A
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322024; cv=none; b=TOhoDEK4LHJfH1CfBUo4jdE12tON7sYMe+gV7n+zVKPRiSMXkooDJ5qliy4qZnOCOnE3i8ExXdax3XsPe1XAJamE+l8Hxn5D47CIfMMvF1jDDOvSQ4RTFXBBbVAZs/KqSywNWuytH/BSF//M5KwxxAwks1hfhjlRFS8YtlZF2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322024; c=relaxed/simple;
	bh=gjCBGAGP81EOH2oljnu2NmddwK9MeX+IixvluhZ/qRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AnWjVyF+oGeh2W5MsUp+ppsGDl+XLlRDWRWLKKecq6Pl4GHG1BkJDcahG8QLM4JpaRGJYT9gC4sQitVDYbhgB46VkqkgQXqCZPJX+PoVI/xbG7GoQ8AmyLwwdzcBnurt0MRbQ5UzRH427VIeWm5VMnrIhZp3Hi4wBc9BDKBfmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pH6exHM4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W2Dk+wUd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6344BjFs3884043
	for <stable@vger.kernel.org>; Sat, 4 Apr 2026 17:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BHYoMiuT+hFy3l8CYUd8tWmBQMWoLPghXx653KocS/A=; b=pH6exHM40Mb/jWHv
	EoF7X2tC/uk6AA9v7E9Q/VuVuKiLEkYBvoRmtkc1E+RiedArGBAhQ9IbgkB5fT1N
	rOnUeRcbJSgBNTRFneYmWNKzG0iykmLfa1NqQxZcC19ab+1ZzhkX8kTpOu2Vbbc+
	zf0FSZ+UOlAbmmEI4KtUQ4ZHbIaWMn8rl9EDflmN1FQV77v0iJCkokF2KcPO3UCe
	HM/JmqM4gEMyWre32+vTQVWNA82Dkjngur1J+STLBCllNnPIpXOBDFvNwOOwfxJp
	Y5IXnWteBbyUqmwvuFWeOo0epAbyzj5unJqzRoNWxYgKY52trakJgqP3bTDjSdUc
	vOVEEA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daudd13k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 04 Apr 2026 17:00:22 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82c70d1f56eso1556242b3a.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775322022; x=1775926822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHYoMiuT+hFy3l8CYUd8tWmBQMWoLPghXx653KocS/A=;
        b=W2Dk+wUdxM/r2b7tsRcHyqQGY78yMZ33JILddjK6G23xie3T5usXZnIAczwrUuyeKa
         Q+4tQDUqbP3cgWjqU9Im3auHjttRb9uLAMw43/KdKdX17euby1MAdKP4jvlbgnqI7aRv
         tuYH4gHimFu5on4/jhFoGZ4NiKAm0lW2JqLaeaEU3ihOYOXncA5JgI1kwjowYEpAaSJM
         DoiwJq2BakJBKyfHlIIdftDJ4GErBXa08r0qbIi4PUXNOpfAjxwjmoJLq6D5dMoU6CJK
         CFSCeuX3LnCrnAEwi45kmgEenSw/037KVEqGq2xGg+1DCgsTWLSttItL93ADZdoEnF/B
         dwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775322022; x=1775926822;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHYoMiuT+hFy3l8CYUd8tWmBQMWoLPghXx653KocS/A=;
        b=EHdGWTHsYxEt7MN8C1KKbYxb7gAKTzldJrjWKbzHyLwyBA4+kH28KRcRF+NEvuNB4z
         0x09R8zIJxRjKf87YVas2YzywAovOqR8K4RrcoZUvUiy+VSm8lOOEJayVPVgIE8PgHm+
         Iu6RBFIpYPQYQCJkqF3gNf6XEV3CbI57ko/JRc+yOQFJvuFCYUJeXixHexN9TmWVLi4v
         8zMrQJkwStSie92+GS/ebzzf4gm7vM4JmdFmCX3TmkFSqoDYi37+VeGYX9J79TvVJeqW
         vnnDVVdHBGW9/NlyrU9vJJwX5y1e9+KvuOXwxe+h4NbL5jubvXYVbAtevsOZa7FW1ynF
         hsIw==
X-Forwarded-Encrypted: i=1; AJvYcCXJgpKeiEmUd7W3MqIxA9zA52RoII5V9OfvYyl0KBczzv0b+W2qsBE5cqRchoar3lScIYnOHog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DOfM+HYQJNYPn8h41FJpD9KVxG9pMq/Vn0Xcj0YOb9iAvFwK
	ncdjZSG/En8dIMJzpzWh45hvcgnNqqfLj1r3mvx7nPONdwTdaQBCVJHgEPWgcWJEPFTSZUDG93C
	+R2ultTAzdIcgFaCMsFr2/yRRkwKkutaa7fLGEi/z0eqWMNi7OrWP/JQnOvA=
X-Gm-Gg: AeBDievegAZCtEaiOf2u+jNXKIb40MV4E0WUXn50hOKvk4UMeFRQ2cUWjB4KNqqTeCg
	gCU1w1FCtlCsb3/GfPawz8jNjDXpIxleaM61cTyNiHQfCAR/kgEyC3J9bHuB5KC18ntNJL++LrO
	JvfYWmaqQZaU0J6Bne20ekCsh0eKMYM01QLv0gHUUMojY/U3dYxeDJPreZbsDfdefDPFIEuOuRR
	hHigc5ytcd0RDybBnDMUTw8bmxAGcbkVlg7Ba22AufLEmmh4Ap+C6J72k0MuQJeByPngGr29OlC
	qfNQ6cG5vwOlXfU3AEAud3XlnaCwcZhmcpJpn133xZ3X2DHdnljuX6tS1xHmIyk3h3rKOWJNeWj
	kD53eLgqg8fXYMwFSVb4abJG3
X-Received: by 2002:a05:6a00:a0b:b0:827:2c79:fa84 with SMTP id d2e1a72fcca58-82d0da45d27mr6277602b3a.12.1775322021794;
        Sat, 04 Apr 2026 10:00:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0b:b0:827:2c79:fa84 with SMTP id d2e1a72fcca58-82d0da45d27mr6277559b3a.12.1775322021206;
        Sat, 04 Apr 2026 10:00:21 -0700 (PDT)
Received: from [192.168.31.133] ([2409:4091:a0f4:6806:b530:cb:a537:434d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41bc6sm9368133b3a.29.2026.04.04.10.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:00:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Franz Schnyder <fra.schnyder@gmail.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        stable@vger.kernel.org
In-Reply-To: <20260325093118.684142-1-fra.schnyder@gmail.com>
References: <20260325093118.684142-1-fra.schnyder@gmail.com>
Subject: Re: [PATCH v1] PCI: imx6: Fix reference clock source selection
Message-Id: <177532201484.28194.6879238704665681982.b4-ty@b4>
Date: Sat, 04 Apr 2026 22:30:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: wdr_O0IKJkJZvuuoIG_wxQtGZNvuNCa3
X-Authority-Analysis: v=2.4 cv=JZ2xbEKV c=1 sm=1 tr=0 ts=69d143a6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=d2OGGJ5TCE6yqAnRVzwA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE2MSBTYWx0ZWRfX2EGowLadD67m
 nnbp2cJqUtfBYFcgJGwouztYSKxy8nBOTMNvcZRrmMgAw/a7Q8xBUdUdly0Yh5DXjYLp72pzMIF
 AUtqnHeJd1SSj8ILy4/3+Jt//CJWIgpVlFZR89/c5LSmkVzlEhFhrJfrDY4j7OavszWy/9cXvPC
 ScS7n5LKmcJxHCnnxhwIyIk1FIhLFDsjm+C450nQDW8WvMH7jb7hD5OcR9fhC1xdXdQFLniMB+W
 FXjc656q/Mr4i6hHjp05eNaxT+mhLevp8XRuj0FQ1ibTB4erpeq3sqsav2boHNnwhu9skWd3+hJ
 WcfuLMuW731rDy9ho5iuYrHnyTVuOGW5Bi/HHErKMCXdrs+KWu8FdYg9NkIoFEUjXgGIZZtg7Bz
 5XZTRBMQofR5275MNBWVvHh7YiorySvP9VyRl4sOMh0Z9Oi2sqGZDpgQPDAlMj+bgQ0vJAzEXvj
 9WYbczto5ItGGDp+g6Q==
X-Proofpoint-GUID: wdr_O0IKJkJZvuuoIG_wxQtGZNvuNCa3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040161
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233292-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 068C739BD97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 25 Mar 2026 10:31:16 +0100, Franz Schnyder wrote:
> In the PCIe PHY init for the iMX95, the reference clock source selection
> uses a conditional instead of always passing the mask. This currently
> breaks functionality if the internal refclk is used.
> 
> Pass always IMX95_PCIE_REF_USE_PAD as the mask and clear the bit if
> external refclk is not used.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Fix reference clock source selection
      commit: 575d7268ca07fcb1d1a50399e1399ba60df3cb27

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>



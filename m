Return-Path: <stable+bounces-217901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKHUM+eAnWk/QQQAu9opvQ
	(envelope-from <stable+bounces-217901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 11:43:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AF018590E
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 11:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB6883050CFA
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 10:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A193793C1;
	Tue, 24 Feb 2026 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/oQ9vYR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dwy+DFrO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F659366579
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929829; cv=none; b=eCtVY8XpscJLXp02YKQLuosZcArQoGvApuOM4unOqCOD3CjjE7vdBIKku2gxQJT31IbfohSmknUN0XKRL4lfSzylNx2bQ2EDC4dvPrnRSDQOeLsmjeHIT6ke1lUv0YTI+WhEEQ1+y3MoBw0qGXVYG1UHEe1i8Tdqik/0JDQMcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929829; c=relaxed/simple;
	bh=6sPDie8uUqGDS1bsA07NmZp55tMOfOGlzrz/b5hPRYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V9nYLKbQq1UsxxTwLQC8+XcfxaGUU1RJkFIULbLHb+wtUs4yhwOb53LdR6ZKRhVSjvBjErlD0Fagu1l/urxHrwtohCIKXbU2DALfp7OgrQqtaYX9pl85Y1CohBVOsKv5H7VXq37WEunAaaDxkjABTba35PUQAa+YuD3dRepouXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/oQ9vYR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dwy+DFrO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFVuE2220897
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GVPafuMTkBBvdHOwmIqwEb
	y5N6HPu4j2/4G4NoYv4Ds=; b=d/oQ9vYRMDkrfNc68cBbbYSDw1IQ6cPp24mLeX
	KblHfoB6mwkPmGQ9sxCl77WDjAgfiefYV6LRzDjAaReBxt86oZ+m6nrDXY2GQXB+
	x/5XVbvu+CraARis4OvfkbU36yhSg6XK4uUu466ijZgFkJDyYvsQX4lUMhsUnb8L
	UD//CcI5M4fLbpS+/fSXfR/ZmSiRO+DCj81KyI3oTbTBJ9gvGoQQ5Q04eO3XJmj2
	InicdozEvmXzHIpVklzrHyvQNl3BRDr9CRXBXXiRwZKsS4jeeC577MgDmiYV7wXB
	tvbLh2g5ZMB3PhT6U6a1IBwB3SnJoL2ghBFJksWgjZws+aXQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch4e395c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:43:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70fadd9a3so3229553685a.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929827; x=1772534627; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVPafuMTkBBvdHOwmIqwEby5N6HPu4j2/4G4NoYv4Ds=;
        b=Dwy+DFrOehG8atDEOSN4T2JeyU61aVQ79ex9Z06Gu07PogWqUAvfDyIl5pnsq8rBwU
         dPRqql2+Yc2DNJuZFODF6aBtrfFePCaaNLG4qUQ+UCetuTVJNY14fPddu77bUsZSXVpk
         ODBCq9VQIasCJgj7dzFZ7el7eTM2T3JpjCdNsrGjEzY3f2PzlVqQDL6/QfJC1ghIvSk0
         2rb4SHjsyB5AOHL9mdHgopZf9lO3KlBDqa0JXT7s0rrSLqtIT0306drpl/S/FQKDd0/I
         5COwGAeTG4+vMTJA0PuSgRnfi0T4Ksm6QiofYeVDeXR28FOBoZDwjaSQ3J00931rJ3fN
         4r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929827; x=1772534627;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVPafuMTkBBvdHOwmIqwEby5N6HPu4j2/4G4NoYv4Ds=;
        b=G+pFzCrt1YTcc3wuXK8vSTpzrFf5yckHdMBrr8pNCqmZ1Q2V/Tg+LxXOojvUqRNT4R
         h8v58Di7q+DRcCMJdaKZUu86FpNr0X977MwZ86g44u9NGNscNM1QuxQL0Xcp5vnh8+1W
         DN1B6nHr8E8rigZ+1JtjzRpUa6e72Bd6bRlqa+nGZEnYFls497AXDVYElIQ5TKHHnSqV
         tKKXhsuafGemdYztDAEHWpsTsc21acu6SXnEAgQtXFYu+IQw+0yVUTOkYkydRfiNUznf
         U19rzfr06Krhxr+RgJtNdS4dYNG8DFoFXIv4qCoOfETmyE4o69cCft6esnW8wsoZBKct
         Glmg==
X-Forwarded-Encrypted: i=1; AJvYcCVSO1diVXhnikdeuHnoA+4PQREXtG9fSJViUa8wjNPC6ruzXTujrfOWm7puYimApENBp9y3WCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4HLHsQr5At6KW28Ne8PR47kC1xt0NxmZa8xsgYuzoDi2Nlni
	BL4/U4NqcHMVgwgrBmdCGP5lP+3dhLgDU0g2wNVjWI3cbE2VvcloiL304X13twLTMJe0wbhFPpT
	PMVOi0a7diiBZBds1YTbdeLPS2J/fvq8pE3G+00t+NlFPCh7kOYGyfkrbnoU=
X-Gm-Gg: AZuq6aKpcgJjlxpjyahvQGFc7Mq3gMnbfN9wosdEy1Jt1T2UiUDtE3rP4DApY4O86qh
	JYWsweMKyEQbgnaQvLOYmR8PPjmoMPsaEH7OA7tHdkBN6JJUU8iZ4tOUEHWV+LISOGbtF3JeRS1
	7Fjaf57KJG4Okz+tfzXiJPOqmUZimJzuIA+t4sEnWHC2RTF68kOe2T71hAwPwUKmO6En8qhY88w
	ugs0qaw9LxJGtI5HRIectSGwmbZHaA+PfaNRPixT+rEb234XltoT5uB42B3F++EwhHvjjZQBUdg
	zW2ImQr8ALwGiqbAwgh+zJE12fONwgiN13q0/FZnlHdRJPtqK83XZeH3T2G1neguR0YQSVjP1jv
	WpADk3Vz5w007uJC7244LaTKUETwKHZg23j8vurgGhCBSBw==
X-Received: by 2002:a05:620a:4627:b0:8c6:ffe3:49e4 with SMTP id af79cd13be357-8cb8ca6e217mr1443429385a.52.1771929826685;
        Tue, 24 Feb 2026 02:43:46 -0800 (PST)
X-Received: by 2002:a05:620a:4627:b0:8c6:ffe3:49e4 with SMTP id af79cd13be357-8cb8ca6e217mr1443426885a.52.1771929826083;
        Tue, 24 Feb 2026 02:43:46 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d40004sm25685906f8f.21.2026.02.24.02.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:43:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/4] firmware: arm_scmi: Drop fake 'const' on scmi_handle
Date: Tue, 24 Feb 2026 11:43:38 +0100
Message-Id: <20260224-handle-not-const-v1-0-90bf93b53e27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqAnWkC/x2MQQqAIBAAvxJ7bsE2FOwr0cFyq4XQ0Igg/HvSc
 QZmXsichDMMzQuJb8kSQ4WubWDZXdgYxVcGUmQUUY9V+oMxxAuXGPKF1hmetSarrYKanYlXef7
 lOJXyAf+h7WViAAAA
X-Change-ID: 20260223-handle-not-const-9a6eb5529590
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2696;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6sPDie8uUqGDS1bsA07NmZp55tMOfOGlzrz/b5hPRYY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnYDcRw8HWd8txJCgD3Arumeb3Kt0gJSl22Bwu
 5P16m8ME0mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZ2A3AAKCRDBN2bmhouD
 13RsD/0U2Kzo2qesvlrOb07YD9SW5ZCP1FxlSzAGO4KbDOGkmm5by6HPnMA2oR+qWkAfHJLNNP4
 fOvAtijr6UM7Ckd6ysYb0jQLJ9GcJzeFPY44yghOURRRRQK2i5wa7p64qcCyCp1P32kHsbj7J23
 JzXFCovKdNGyFm41w2LPX4DmdaxDO4z6tRr1QfhCaKxruQefjBuORlAMA0BOVVcA2HSxfvcvJUG
 LUsf/aiM1p7Vb7tniN3bQmUZlhF7lSDwIMfMeR5EMGhHf21vgEOYjJtQRG7ZCtm6uNMdfzR0NXO
 8nJXjDY3rhLTThDp8eig8CybDwLP0kFCNNZi3m4Ro1znCVVbOi97ZsCYhyL2t3/SYXzMioXWyHW
 X9ZdZiO73mFpyEbQveSIcUJSozDn1t2p93rirFPmZkU2rmpk24qotVBI+uTprSRal74HajfsYzr
 fm44jNBruZ3VeX0xToabjB0aOc2S1udXdwlvuP2cCA6mOYdj/25TUWPIqCPWiNCt0U4ONm+eOhs
 cZ4Ysui0ZnEhX8AupCpEl3ji3sTsVGbGVBnImrxiA3jzY6pP+XT31QKcnRrM+YDG4z0Hv1SKMzy
 SmZc5CDHJozCT12HnwAIGab+HOJg8NASzJ/UIaV8Pg7YJ9G6w5imQg22Boz+n3CrFtliY8vg70j
 u6MGUlqTSqnFg0w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=DfIaa/tW c=1 sm=1 tr=0 ts=699d80e3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QjCKVQx7SMNC4EIcHegA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: R-CYEJ0Fztm04OxJYpsaatC4wTW9VW1P
X-Proofpoint-ORIG-GUID: R-CYEJ0Fztm04OxJYpsaatC4wTW9VW1P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX5PoHy8Fag/Qu
 NCpZTfPH+ecwINIRdxRLjxHuq32KYZ0aKlBVmi42vwY8QCPxK+DZEH8DGlTt4UQvF6ElotCNBdA
 lHjbRkn3jSmAEOKyLjtONs5uqmPCi2aAO/DCYUnwm7ZehTPUnb2qL6p3qHdSI0WDrHWkKjoLbYk
 +KaR9Bf3eNrvGK3t1+wiYzU24IqTSdJkOnhhr3WhbXmhp0mXIXkpUjblfeRR9E0o1rciXIGFKxs
 6Dm2hIBBEzLnLPUFOUiN0zYSB57/orlukVQjefoOUteyn8GmDdQKdu2IUIxqqQ4SqTXcPsW1Xyz
 8wSqiviGyapvhW0LeUemGKVoHv9g2GyxiZNsfkBsUiQwzUmkuvHbcFNP3eAFGO6gioSurhy6HAE
 S2CFLJUTI7VSiK4TIXLvMI3y1CtcefJ2CUhOMP3GuQ6gm+tbsxJfyYWpFDYevbxu+pdDRSSufiP
 zsllTmOs+TMiHjrng0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217901-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,arm.com,baylibre.com,nxp.com,pengutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 77AF018590E
X-Rspamd-Action: no action

Severale functions operating on the 'handle' pointer, like
scmi_handle_put() or scmi_xfer_raw_get(), are claiming it is a pointer
to const thus they should not modify the handle.  In fact that's a false
statement, because first thing these functions do is drop the cast to
const with container_of:

  struct scmi_info *info = handle_to_scmi_info(handle);

And with such cast the handle is easily writable with simple:

  info->handle.dev = NULL;

If the function really was not modifying the pointed handle, it would
use the container_of_const() call.

The code is not correct logically, either, because functions like
scmi_notification_instance_data_set() are meant to modify the data
behind the handle (in containing struct).

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      firmware: arm_scmi: Drop fake 'const' on scmi_handle
      firmware: arm_scmi: Drop fake 'const' on scmi_protocol_handle
      firmware: arm_scmi: Use container_of_const() on scmi_handle
      firmware: arm_scmi: Use container_of_const() on scmi_protocol_instance

 drivers/clk/clk-scmi.c                             |  2 +-
 drivers/firmware/arm_scmi/base.c                   |  2 +-
 drivers/firmware/arm_scmi/clock.c                  |  2 +-
 drivers/firmware/arm_scmi/common.h                 | 15 +++---
 drivers/firmware/arm_scmi/driver.c                 | 58 +++++++++++-----------
 drivers/firmware/arm_scmi/notify.c                 |  2 +-
 drivers/firmware/arm_scmi/perf.c                   |  2 +-
 drivers/firmware/arm_scmi/pinctrl.c                |  4 +-
 drivers/firmware/arm_scmi/power.c                  |  2 +-
 drivers/firmware/arm_scmi/powercap.c               |  2 +-
 drivers/firmware/arm_scmi/protocols.h              |  4 +-
 drivers/firmware/arm_scmi/raw_mode.c               |  4 +-
 drivers/firmware/arm_scmi/raw_mode.h               |  2 +-
 drivers/firmware/arm_scmi/reset.c                  |  2 +-
 drivers/firmware/arm_scmi/sensors.c                |  2 +-
 drivers/firmware/arm_scmi/system.c                 |  2 +-
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c |  2 +-
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c |  2 +-
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c |  2 +-
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    |  2 +-
 drivers/firmware/arm_scmi/voltage.c                |  2 +-
 include/linux/scmi_protocol.h                      |  2 +-
 22 files changed, 60 insertions(+), 59 deletions(-)
---
base-commit: 5848db9e2caaa560a21ce692c4c32badef3c813f
change-id: 20260223-handle-not-const-9a6eb5529590

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>



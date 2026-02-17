Return-Path: <stable+bounces-217187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ps9DeHblGmkIQIAu9opvQ
	(envelope-from <stable+bounces-217187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:21:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B2150B2B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2713035AA2
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675B2F12B3;
	Tue, 17 Feb 2026 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxPM4/E9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KajzD2/J"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FD2F5A36
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363268; cv=none; b=JhMmxTT4S/6twsVuS83WUH4ZKslPaMoQEokh38yyQhhriRrJ87nKHtReq9OClLLQ1D7i+JPIHlquize3AwInfLx5HK+A0x99WH3gvXk4YpttwyilAl1vuBKsdgxRkMRkiUHxmKCgruXhfpvBPnHhwRh7kOZqRQFb6xMBeCb2xVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363268; c=relaxed/simple;
	bh=YOLRN55LxJK2qJI6ai1FCwOa5fYTPUTC4n5AkFI9pTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndtYDwlHwfskCcc53Er6+yVvdRIktoCtbxXL0xkxXSKCoBM6isaj0dDwMwh69yUfWXS+Q7vFVWu6NoabWl6NjIJWeEgMziBj58j9NVVTOsIhtZ46m8yDsxCLZNqTq6EoCOEtSuuPBOkbDeUQB5mFyI1CwVp4P4fwGWiEwgZa8OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxPM4/E9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KajzD2/J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HE7K4H3485983
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 21:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tCcmspN6ucVvatxroXWVxT8mrA0MUfhfmZj+e7BSMUo=; b=cxPM4/E9QcuszQiO
	nQqG9bnR1VMU5Xu9rcmdXCQjYzU3lP5C9C1FNUjbIUPhJPLrQpcfHVDFz+fyIkIh
	wsGMVGgmRm3OET1ufPzQw28fVyv4FX49vvJ5EJtrE8eahjL34Wl4CLXUZHbl0iRg
	qc87cWieHJby3aOQ9ZWBaTB3+s9gMyLWoHomRT9PwXa4l8aw9xT3BN66D9qPeDe1
	cOXzPI0PMAgH9By7peL6Vql5T+oyxdpaJhlN1ktHOlyppE47xC2utA/l+18uOPL3
	qm+2tJN+KyJpm96ZF1dXJk9DGuMlcrLVQRFkkAIsHhEzaNBRCXpP+2t2Ecm26AA0
	/dp30Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap3wc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 21:21:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4d191ef1so454903085a.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 13:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771363265; x=1771968065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCcmspN6ucVvatxroXWVxT8mrA0MUfhfmZj+e7BSMUo=;
        b=KajzD2/JD2L9ty2Exf/M2sZjG0MiGZuuu1FqFGA2Q2/YXK6uLMQfaUnoq8Bk7BUdea
         A3e1hW1Ar2XkmwPmFovAHfEVVnPbGsDhfNIrx5GFjjz0p+vde9NOkQwjmsmeKWOaNO/I
         kx5ubfkd+sxTDoScNSO5re7dzK0sn65vXs1KeoBCqw++K9D9HLTKdjZJviX4sH7wiUAk
         AEOCLXioRxjmI/wst4kcY4rlPmx7Y7TzfRrjySV7MJwEmJg5jzMD+0pBFl3fPSxTK9wi
         3RZto+SPxizyNk7jMnPiQh9BoqNleaHmE6+dX2+s5G8P6aALaToWoADhviKibhOW47oF
         qYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771363265; x=1771968065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tCcmspN6ucVvatxroXWVxT8mrA0MUfhfmZj+e7BSMUo=;
        b=avmKjhk8etE4L/Usw7PHXrCXG2U4JTCcrNbNWKLX6kCfiEgWSJR0uUiFrCUDmryrZh
         lMqXAVrHcddr3nzEaDrY76ipDe1wOf1OW/saM0I3sMg8b8VA9h++Bo6qCscvMfUbNImK
         lGjNa9xC7SHwzfgTUo2NxTl3i3+YepMfCVqw9J90IhYwu+y9UhUWpWk/yN7ncoS1Emxe
         tt6wMWemaI7sJ4GwzdUpZCZ/N0LVEurfXEpyyUdPolakUN+c4FqNlZ7LuE11EDn4j8k1
         yu2Tg/uxBOKY7RZcPpuLt3rXEBwqBM3egR993DVk15ByhG/9BZ83S1oifhzT5vtkUchO
         3/5w==
X-Forwarded-Encrypted: i=1; AJvYcCVqvx6qGNXsWrF6Vh1FvNS7tT2FWWh3+/aHKQMxR630QZoG57hRqoxaAjcdhnqUDRONnRW201k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRg6pdZf5a4a81zuttCdHAVRKBmU9uJR9QZ0b5xlxKNTho9TCh
	H9ausGmDtF32F/tYWWY3p+btarEL5UT3CAMnHisZY6Stbx25MiELAh+6wL4tkvpY7/NO7N0hstB
	fMWvdl49tPWScVI2wLXNL3/018JBhRaNF22sDDucKGJ6bov+phoRAxzkTZ58=
X-Gm-Gg: AZuq6aJ9XF5BfhBJvjpIXi8EiYSUsSRlTCDnx0lY5G4p74zh87I8kXq6Rj67ghPcf8+
	YM0t7yp15LcD8WYEPswVgacZaSDdOK+k4w/bv467ednpjehj6Q0lQ9SnB7+l6KirVZjxzHjRXbO
	+9+fk/qbSXJb5vbkdZ8qwL56JuRJJyAK/S46OiiAGCo6V/lKzP5uN0kRk/FC4EgXiNFzV4WeXl0
	0g8fYRgxWcJQTxZJr22l6GdrTraqVedEE4LgXNu9lhoRhuytti2S5TjiSl8ouJdpaDODJ/EjHG6
	vc2CnNnE/Ra0QktmcJ/TUh1wudz5VpHi69CAbNt2PmROfBkX5VkF3oyr0pVNUSkOlVGn9A+IhU2
	TbfejEszB8nCU2BhTYN3zDy0n0HTbpUl7qQJ8DE4E1gmoYWHQfjJewuH1F1idcwFjw2ToRO19E6
	Mi9wZ/6Uac5iIY8YJ4qxdykTqHGn3jeVbhhuI=
X-Received: by 2002:a05:620a:691a:b0:8c6:ee09:5eae with SMTP id af79cd13be357-8cb421628bbmr1869017085a.0.1771363265351;
        Tue, 17 Feb 2026 13:21:05 -0800 (PST)
X-Received: by 2002:a05:620a:691a:b0:8c6:ee09:5eae with SMTP id af79cd13be357-8cb421628bbmr1869012085a.0.1771363264739;
        Tue, 17 Feb 2026 13:21:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068923c3sm39293311fa.5.2026.02.17.13.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 13:21:02 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 23:20:42 +0200
Subject: [PATCH 1/4] clk: qcom: dispcc-sdm845: set GENPD_FLAG_NO_STAY_ON
 flag for MDSS domain
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-sdm845-hdk-v1-1-866f1965fef7@oss.qualcomm.com>
References: <20260217-sdm845-hdk-v1-0-866f1965fef7@oss.qualcomm.com>
In-Reply-To: <20260217-sdm845-hdk-v1-0-866f1965fef7@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10235;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YOLRN55LxJK2qJI6ai1FCwOa5fYTPUTC4n5AkFI9pTg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBplNu6sIUGHxd7FAfse0gREPm1810dj9fAeh9Xr
 Djpk617AoCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaZTbugAKCRCLPIo+Aiko
 1b7wCACBy9OfMluQ6pbvu9r5ivdRF87DvWoApBg3b6Dj1fNxXEVCSzttrlaJ+wx5eWe3PhczTnn
 wCKZtQ2xEhu7uUQUnIwJkIeG0WRkVF8LRPbXA9TVSn4OPf8bcPTBe0uv9MdlNhcpjlXOJ57qzdD
 MrzJ7ST4zFHtTfP2zDpsye5sjlBhono7d5NnJrnaKoMVyIvjaShIFWZVITHjFXcphnf2IYpxevd
 fSLDxf3YWQdDlbE2GcB0TDgNbSqn7vkR688Zd+A3s+7drdOtZGux11CSMsvsZHKhZTMj5ahecem
 6q1BBEQgZfM4ZCIZKWunWNwKXszSuQDmOWAxfRPnTSC93qwo
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE3NSBTYWx0ZWRfX0SkM0yja80R9
 ZMY8BgUglEs/my0a5aD+R8I3l0NP/Ks63Vy//2f4V6A6xV9W26Z1hnRheWRPHURisEOHVBNKqhx
 0Gy6jkL90U7xOdqlxytxx9GkYyvzekhIg39iLdkg7/SZxupIzFzY7dGgyTZceBGVpwjEHLPgHAu
 LL429QWln+ovGeB+gVzHSBvT0Ej+CLbANql4owBX/veG5ymkdFP7jCx3hRv2z+Kuh8vdKvcIpBM
 tEru/zfhQcg8eROrX3a2XmDRm17xv6aQO29Z+8mP8n5eu4WdTMz7xqSrR+Varuo62zj9y9UxLm5
 rQL5yMgmGxe5sUna+Fa8Rdtpa0T5g/mprPyxCogU7E0Qj+uJ/iRp2lCHALNGEHGU4MCkgiHdRbu
 GOTeBICg3b96A3qnz9OT5XgER6lFoRS4telpXKuJMg6Am1hYpgnSaiNOkcKD9GtPZstpfLQONFD
 KPEtThmln1+A3v0lnsg==
X-Proofpoint-ORIG-GUID: n_Q5rW0EFmfynvqpzSs5UiDaxNK8vkWk
X-Proofpoint-GUID: n_Q5rW0EFmfynvqpzSs5UiDaxNK8vkWk
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=6994dbc2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dYJyxWB7gKoe5oMdJBEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170175
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
	TAGGED_FROM(0.00)[bounces-217187-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,linaro.org:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D24B2150B2B
X-Rspamd-Action: no action

Since the commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds
on until late_initcall_sync") setting of the display clocks is partially
broken. For example, when on SDM845-HDK the bootloader leaves display
enabled, later the kernel can't set up DSI clocks, ending up with the
broken display, blinking blue.

 ------------[ cut here ]------------
 disp_cc_mdss_pclk0_clk_src: rcg didn't update its configuration.
 WARNING: CPU: 7 PID: 81 at drivers/clk/qcom/clk-rcg2.c:136 update_config+0xd4/0xf0
 Modules linked in:
 CPU: 7 UID: 0 PID: 81 Comm: kworker/u32:3 Not tainted 6.16.0-rc2-00040-ga3f36de2f3ba #4236 PREEMPT
 Hardware name: Qualcomm Technologies, Inc. SDM845 HDK (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : update_config+0xd4/0xf0
 lr : update_config+0xd4/0xf0
 sp : ffff800080992a30
 x29: ffff800080992a40 x28: 0000000000000001 x27: ffff00008db49080
 x26: ffff00008db49220 x25: 0000000000000000 x24: 0000000008d9ee20
 x23: ffffd6f1bf1f6cd8 x22: 0000000008d9ee20 x21: ffffd6f1becadfa8
 x20: ffffd6f1bf1f6cc0 x19: 0000000000000000 x18: fffffffffffef3f0
 x17: 0000000000000004 x16: 0000000000000024 x15: 0000000000000005
 x14: fffffffffffcf3ef x13: 2e6e6f6974617275 x12: 6769666e6f632073
 x11: 7469206574616470 x10: 752074276e646964 x9 : 72756769666e6f63
 x8 : ffff800080992790 x7 : ffff8000809928c0 x6 : ffff800080992850
 x5 : ffff8000809927d0 x4 : ffff800080994000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000808d1b00
 Call trace:
  update_config+0xd4/0xf0 (P)
  clk_rcg2_configure+0xb8/0xc0
  clk_pixel_set_rate+0x138/0x180
  clk_change_rate+0x124/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_core_set_rate_nolock+0x230/0x2b0
  clk_set_rate+0x38/0x90
  _opp_config_clk_single+0x30/0x98
  _set_opp+0x11c/0x530
  dev_pm_opp_set_rate+0x18c/0x280
  dsi_link_clk_set_rate_6g+0x44/0x100
  msm_dsi_host_power_on+0xc4/0x988
  dsi_mgr_bridge_pre_enable+0x194/0x3e0
  drm_atomic_bridge_call_pre_enable+0x40/0x58
  drm_atomic_bridge_chain_pre_enable+0x50/0x130
  drm_atomic_helper_commit_modeset_enables+0x15c/0x26c
  msm_atomic_commit_tail+0x214/0xb18
  commit_tail+0xa0/0x1a0
  drm_atomic_helper_commit+0x1a8/0x1d0
  drm_atomic_commit+0x8c/0xcc
  drm_client_modeset_commit_atomic+0x258/0x2d0
  drm_client_modeset_commit_locked+0x60/0x1b8
  drm_client_modeset_commit+0x2c/0x58
  __drm_fb_helper_restore_fbdev_mode_unlocked+0xbc/0xe8
  drm_fb_helper_set_par+0x30/0x58
  fbcon_init+0x3cc/0x530
  visual_init+0x8c/0xe0
  do_bind_con_driver.isra.0+0x18c/0x320
  do_take_over_console+0x13c/0x1d4
  do_fbcon_takeover+0x6c/0xe0
  fbcon_fb_registered+0x1dc/0x1e0
  do_register_framebuffer+0x1bc/0x278
  register_framebuffer+0x30/0x5c
  __drm_fb_helper_initial_config_and_unlock+0x2dc/0x5a8
  drm_fb_helper_initial_config+0x48/0x58
  drm_fbdev_client_hotplug+0x7c/0xe0
  drm_client_register+0x5c/0xa0
  drm_fbdev_client_setup+0xa4/0x1c0
  drm_client_setup+0x58/0xa0
  msm_drm_bind+0x3b4/0x460
  try_to_bring_up_aggregate_device+0x16c/0x1e0
  __component_add+0xa8/0x170
  component_add+0x14/0x20
  dsi_dev_attach+0x20/0x38
  dsi_host_attach+0x58/0x98
  devm_mipi_dsi_attach+0x34/0x90
  lt9611_attach_dsi+0x98/0x120
  lt9611_probe+0x3f8/0x4a0
  i2c_device_probe+0x154/0x340
  really_probe+0xbc/0x2c0
  __driver_probe_device+0x78/0x120
  driver_probe_device+0x3c/0x160
  __device_attach_driver+0xb8/0x140
  bus_for_each_drv+0x88/0xe8
  __device_attach+0xa0/0x198
  device_initial_probe+0x14/0x20
  bus_probe_device+0xb4/0xc0
  deferred_probe_work_func+0x90/0xcc
  process_one_work+0x214/0x64c
  worker_thread+0x1c0/0x364
  kthread+0x14c/0x220
  ret_from_fork+0x10/0x20
 irq event stamp: 110949
 hardirqs last  enabled at (110949): [<ffffd6f1be502d78>] _raw_spin_unlock_irqrestore+0x6c/0x74
 hardirqs last disabled at (110948): [<ffffd6f1be502268>] _raw_spin_lock_irqsave+0x84/0x88
 softirqs last  enabled at (109450): [<ffffd6f1be1b9ff0>] release_sock+0x90/0xa4
 softirqs last disabled at (109448): [<ffffd6f1be1b9f88>] release_sock+0x28/0xa4
 ---[ end trace 0000000000000000 ]---
 ------------[ cut here ]------------
 disp_cc_mdss_pclk1_clk_src: rcg didn't update its configuration.
 WARNING: CPU: 7 PID: 81 at drivers/clk/qcom/clk-rcg2.c:136 update_config+0xd4/0xf0
 Modules linked in:
 CPU: 7 UID: 0 PID: 81 Comm: kworker/u32:3 Tainted: G        W           6.16.0-rc2-00040-ga3f36de2f3ba #4236 PREEMPT
 Tainted: [W]=WARN
 Hardware name: Qualcomm Technologies, Inc. SDM845 HDK (DT)
 Workqueue: events_unbound deferred_probe_work_func
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : update_config+0xd4/0xf0
 lr : update_config+0xd4/0xf0
 sp : ffff800080992a30
 x29: ffff800080992a40 x28: 0000000000000001 x27: ffff00008db49080
 x26: ffff00008db49220 x25: 0000000000000000 x24: 0000000008d9ee20
 x23: ffffd6f1bf1f6c48 x22: 0000000008d9ee20 x21: ffffd6f1becb1b50
 x20: ffffd6f1bf1f6c30 x19: 0000000000000000 x18: ffffffffffff0790
 x17: 0000000000000004 x16: 0000000000000024 x15: 0000000000000005
 x14: fffffffffffd078f x13: 2e6e6f6974617275 x12: 6769666e6f632073
 x11: 7469206574616470 x10: 752074276e646964 x9 : 72756769666e6f63
 x8 : ffff800080992790 x7 : ffff8000809928c0 x6 : ffff800080992850
 x5 : ffff8000809927d0 x4 : ffff800080994000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000808d1b00
 Call trace:
  update_config+0xd4/0xf0 (P)
  clk_rcg2_configure+0xb8/0xc0
  clk_pixel_set_rate+0x138/0x180
  clk_change_rate+0x124/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_change_rate+0x1b4/0x620
  clk_core_set_rate_nolock+0x230/0x2b0
  clk_set_rate+0x38/0x90
  _opp_config_clk_single+0x30/0x98
  _set_opp+0x11c/0x530
  dev_pm_opp_set_rate+0x18c/0x280
  dsi_link_clk_set_rate_6g+0x44/0x100
  msm_dsi_host_power_on+0xc4/0x988
  dsi_mgr_bridge_pre_enable+0x194/0x3e0
  drm_atomic_bridge_call_pre_enable+0x40/0x58
  drm_atomic_bridge_chain_pre_enable+0x50/0x130
  drm_atomic_helper_commit_modeset_enables+0x15c/0x26c
  msm_atomic_commit_tail+0x214/0xb18
  commit_tail+0xa0/0x1a0
  drm_atomic_helper_commit+0x1a8/0x1d0
  drm_atomic_commit+0x8c/0xcc
  drm_client_modeset_commit_atomic+0x258/0x2d0
  drm_client_modeset_commit_locked+0x60/0x1b8
  drm_client_modeset_commit+0x2c/0x58
  __drm_fb_helper_restore_fbdev_mode_unlocked+0xbc/0xe8
  drm_fb_helper_set_par+0x30/0x58
  fbcon_init+0x3cc/0x530
  visual_init+0x8c/0xe0
  do_bind_con_driver.isra.0+0x18c/0x320
  do_take_over_console+0x13c/0x1d4
  do_fbcon_takeover+0x6c/0xe0
  fbcon_fb_registered+0x1dc/0x1e0
  do_register_framebuffer+0x1bc/0x278
  register_framebuffer+0x30/0x5c
  __drm_fb_helper_initial_config_and_unlock+0x2dc/0x5a8
  drm_fb_helper_initial_config+0x48/0x58
  drm_fbdev_client_hotplug+0x7c/0xe0
  drm_client_register+0x5c/0xa0
  drm_fbdev_client_setup+0xa4/0x1c0
  drm_client_setup+0x58/0xa0
  msm_drm_bind+0x3b4/0x460
  try_to_bring_up_aggregate_device+0x16c/0x1e0
  __component_add+0xa8/0x170
  component_add+0x14/0x20
  dsi_dev_attach+0x20/0x38
  dsi_host_attach+0x58/0x98
  devm_mipi_dsi_attach+0x34/0x90
  lt9611_attach_dsi+0x98/0x120
  lt9611_probe+0x3f8/0x4a0
  i2c_device_probe+0x154/0x340
  really_probe+0xbc/0x2c0
  __driver_probe_device+0x78/0x120
  driver_probe_device+0x3c/0x160
  __device_attach_driver+0xb8/0x140
  bus_for_each_drv+0x88/0xe8
  __device_attach+0xa0/0x198
  device_initial_probe+0x14/0x20
  bus_probe_device+0xb4/0xc0
  deferred_probe_work_func+0x90/0xcc
  process_one_work+0x214/0x64c
  worker_thread+0x1c0/0x364
  kthread+0x14c/0x220
  ret_from_fork+0x10/0x20
 irq event stamp: 110949
 hardirqs last  enabled at (110949): [<ffffd6f1be502d78>] _raw_spin_unlock_irqrestore+0x6c/0x74
 hardirqs last disabled at (110948): [<ffffd6f1be502268>] _raw_spin_lock_irqsave+0x84/0x88
 softirqs last  enabled at (109450): [<ffffd6f1be1b9ff0>] release_sock+0x90/0xa4
 softirqs last disabled at (109448): [<ffffd6f1be1b9f88>] release_sock+0x28/0xa4
 ---[ end trace 0000000000000000 ]---
 lt9611 3-003b: video check: hactive_a=0, hactive_b=0, vactive=0, v_total=0, h_total_sysclk=0
 [drm:dpu_encoder_phys_vid_wait_for_commit_done:540] [dpu error]vblank timeout: 2
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 fb0: sys_imageblit: framebuffer is not in virtual address space.
 [drm:dpu_encoder_phys_vid_wait_for_commit_done:540] [dpu error]vblank timeout: 2
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 [drm:dpu_encoder_phys_vid_wait_for_commit_done:540] [dpu error]vblank timeout: 2
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 Console: switching to colour frame buffer device 480x135
 [drm:dpu_encoder_phys_vid_wait_for_commit_done:540] [dpu error]vblank timeout: 2
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 [drm:dpu_encoder_phys_vid_wait_for_commit_done:540] [dpu error]vblank timeout: 2
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110

Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
Cc: stable@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/clk/qcom/dispcc-sdm845.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 78e43f6d7502..468b30497746 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -763,6 +763,7 @@ static struct gdsc mdss_gdsc = {
 	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
+		.flags = GENPD_FLAG_NO_STAY_ON,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = HW_CTRL | POLL_CFG_GDSCR,

-- 
2.47.3



Return-Path: <stable+bounces-217900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKZKEaOAnWk/QQQAu9opvQ
	(envelope-from <stable+bounces-217900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 11:42:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34D1858CE
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4827A3088267
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7463A3793BB;
	Tue, 24 Feb 2026 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NBAncbBI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CGdN/8eq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9A378D83
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929734; cv=none; b=uthk55pKz9SLZ3P3CO/4dZkH/CKpDXj6MiMi2kTXf98rn2DUkosmd8vfSFPMhShVkTUJw99Ny9/nPQczfTFoYbGDZgFf3SGIi9kpO8YEDAobHyMpa9OhsM+YUP9ufNsIw16oC4fnbSOkRqQUNTmZ7sBEDCfrfiov7kXD5dqliD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929734; c=relaxed/simple;
	bh=OkAqLih86eGhs+AlEKWaQ18KBTCIZs5r/UQDwG2RYzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unYJRM3cL0QMxAhDiGJHR3muTgkqUnvIlgVb7ak7TEOO/PixlHKVR5blwTTpe1F9+aLGCkhb+QghDJpRlPeRf7rH+TWgZJQn+7i1ohtVUdjWOhj6PXrZkUR7XE3sBiIoTgQQsmez2cHWuqA+j6L+d144cPXIQ12+23Krz0NFke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBAncbBI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CGdN/8eq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFbx33885080
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/GqP17qL1C56/w5WwjYrwodd+5ODSw5Cq1R
	Xmu3/4NI=; b=NBAncbBID0U7GdUe6W7U+YvYxrT2f1OnZIbLJH0vJBhVCPGD/y5
	Mh92sJBbNLboWNq2SosudgPTsXITxbJwmeXULp+G6V5XKGOWdKvYMPIZMefHCcCr
	v1sqihd7jxZlg6vSza4tiwff4vQ2Q+IpD5YSInN4bKlkE6C4zEA6NQh56lzmVc5D
	KSE2UTZiQdJNYSJLVBr7zesxxk4F3wwTZRqJZpbFI5HzYB74wrku7X5/yj/A4KzD
	BdSpKrK29atIuoFQQIPmQhQq1U3sxo3cOjD3CfVODIbWX8aa0QKLbi7n6ADWzPMb
	gzUKBrl5GxKv6r/hhTh9tIMrVrv7DDvBzOw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgte8tug1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 10:42:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70ed6c849so4488516485a.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 02:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929731; x=1772534531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/GqP17qL1C56/w5WwjYrwodd+5ODSw5Cq1RXmu3/4NI=;
        b=CGdN/8eq1scAn4AYApgniCHq5z/9uBeyqOEVeGhFqM3M0E+4QQmspHvpSksReieyyL
         gMGMInDJdKVqgsG6GM4SJVkW8ADDR2TSF9NzW0jUj5jKG+YMD5yTGUFXym1+bomFHyMc
         2h0PqDNK8rawGZKAGi1cJuZwPtnYC1pz4PhSOBImq5Jo98JifMqVQPRXNiCwGF8fq8hg
         B8SUIyREcbArldZyPE53HlzM3egv9TqL6EorL/f73ILRU0dQy+YRwXxW8Tu0G9xIwlDR
         vZgGN4JX2b/p7m9HjuRJQls+nXiEQdskfIsnkBSOzyrF6feGKIKm/zDVQ3goyn1HIcJS
         4H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929731; x=1772534531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GqP17qL1C56/w5WwjYrwodd+5ODSw5Cq1RXmu3/4NI=;
        b=M80SV4LeSD5L2KvN1gzXF3Gc0H7ZBpC93BTgmppQelekwCo8S5ROOI59Sz1XiO6VC8
         JpbZbCQoI5BB+kjNvrsID6tlXyVRQrZQMXndycpFuzQwS4iPA3RH6ds62st4hR9v4ed2
         xGq0Zo/cswf9+SLPBZsNyj5L0T3QQyFCV0x2Zhikga68pdT3pAureQJI30PS07MV6Epd
         PYqokvZjPBmHZ69k8T3th0PUydBRm3Dozhi3jFIhzv65b1q0oPykOXCc3b/LG8zjrd5R
         TiyHBS3D/CGRgBCB+KgAlbVlyoGX4zfuJWbDgJnUB0uFGUGn01Ot0dKknk7Qs/ECziA1
         Ax4g==
X-Forwarded-Encrypted: i=1; AJvYcCUQlCshQsWSjMJEuRrUbOMURh88F7S/nbiOgxK5oxzK/AzJSSXa1oz51qKU9KLzYsPDNiNP5DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClsE31L7zfUBZLbsJNnAFHGE4+WP8X46A7kR3ItN95a/ZkrMG
	MS3It2ZNTFJd6emDc86z4M/k0jN9vlfDvL3ZhZZRxVO2s+I3e1Z4foVQ2ar06v1RJBoKqzmVVIv
	aKf8AQ4mWLRLhcCsE2o4tXCHR1in/FHXwhrI5/nNAeQ0lGh8Ik6VoDquRXIQ=
X-Gm-Gg: AZuq6aItljjUtHwK/Vz1jVnzSGFB/BHGEChBxGbzsL3bWkOhtn3bNKK4wB/c/frS3PK
	++ISqo0YcNyGo4l4FJWKRQSZbt81WV91jCME4SwON11pDyj47ide9Os3TnWno455dY7YhrIwV/q
	4CPfFQvPYYRXsFFGzv2+RmPqlH59PBg3/Sh7tXTacTcq095M+oNUm67FrXPk4Ve0IJFBQZPFrlS
	0pkBLSbQVOwGwN7z45L/u6Z60ItnSyDhxaKkBtBCd3GX/CUTEGTb60wphl/dBoXFaakBJfycImS
	uV3AJXxIs6mpsKaFokfnr/No7fN2S2Hlrp3PsR2Kh338UUt+CFD5ERUAjChozwj64RvPZLVPnDO
	9CSx3DesHHv8vRZxNQ7xGGbohbkkACBhMSJL9uw==
X-Received: by 2002:a05:620a:28c3:b0:8b2:f2c5:e7f6 with SMTP id af79cd13be357-8cb8ca65f56mr1405653585a.37.1771929730802;
        Tue, 24 Feb 2026 02:42:10 -0800 (PST)
X-Received: by 2002:a05:620a:28c3:b0:8b2:f2c5:e7f6 with SMTP id af79cd13be357-8cb8ca65f56mr1405651385a.37.1771929730265;
        Tue, 24 Feb 2026 02:42:10 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d40004sm25676184f8f.21.2026.02.24.02.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:42:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] firmware: exynos-acpm: Drop fake 'const' on handle pointer
Date: Tue, 24 Feb 2026 11:42:04 +0100
Message-ID: <20260224104203.42950-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14898; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=OkAqLih86eGhs+AlEKWaQ18KBTCIZs5r/UQDwG2RYzs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnYB7V7tGPImL9hJcV0yofAD0uRgNe5D6EZDcF
 /YkfFfbOiWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZ2AewAKCRDBN2bmhouD
 11LZD/0Q9SfAdiqa9ATtkIPdMX3sAmI/Co/NoKAvh7VXkbqztu5lzMgrtVxmzmvWK5RpTBm2H+F
 mqIPaVyVJSI/emMri9SrcGFFGRAVfVONCOESZGqR4uSXQ1AS6hT+Pd/ss+dGAzs6Zkm10ayhdu5
 Q96PMGxo+N+HXBR2MvLHYrJOZMDN/m39HZmVavLHNiUYkYvQ3FgBifWmBX/NBxp+yGRabtiZy3t
 eAvNfzRVcenWi0RQcAIZYao6sN/0OBfVzezPZ+1QkLX09YGs0ot/2r/oJB7doXxS/sLM8CjchjJ
 JczIhXuBPFZyY+b4tCb7kL2vNpA7foaYHtTJ19DsflmkN3iPgTJow6qfaLvdg8I2mtG0Ti8X6Ls
 W9AH7CnAcY0JouMR26kYFHMX37FNLTgFOq981za2tB1WOdhuo9OBQiXKZlO0sk3/10KAGc/TMCE
 v04bd5xPPPB2mHpNh13e93SgsbqUI4a8J46Ebuwhr6Gs2P3DLcYED08dlVw0R9+TjQI/6lMPl2F
 +/YfuHr360JrZzhWjg0CvFkuE8bT/FKeoLo1GztkNk5TCY8zCBMhIwh0ksCtUDQwZiS5P6gzQoy
 qY45G6+SR8kTq/uSc2MVnH2piFtMXMh6erSklnlWzJGR/+bZYzo9sD88DJDjj0vnpdxqVqJ/4c3 5TfOVsEbdTw90Bw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wgpUH1lpvD-A2x9TYddKcy92uSn4NCZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX5kSdeuFzjnUd
 FlrGAm43X9R8UbxQHHQaJZcXBW3j/dfY5E82strSoaVlPTkOIZ6AA+kMZ/Kab0ny3oYpOZHy4TS
 sHlfl9gq9x1nZlqNywwd+t/pNtGGkAO4ZibIkJBRnpajSVuH2AD8jt5yMBzhS1z2EkSNK6ih2Ij
 2fEGGaFgYLSE6rK9B8DuEb1EM636vwOuZyPt7+fe978ou0E3lA24aa0nAlB6v0BFGcW0TGvjF+e
 waitOb4M02L+EpmW4qRIztp0OGvaAfxNmhuZHAXhIF7r2+x0QgQfgC+qSx84zkwuu9wVYznihTk
 KrDLmZChs+nSRZ3avDYStMv2FXqFmPFqXAT5y6HSysu0UCld+nhLIK4/GOaFRabZBMWht7v8wOn
 /LuOJTCzPSXOVWvdMSXOMpdc9lWXzwJ3NHJwumwqzoNGlLZg2FrzwUbORr1L4dJ+sBlV7ECYDId
 +VYusiNH92+Fv5SQy8w==
X-Proofpoint-GUID: wgpUH1lpvD-A2x9TYddKcy92uSn4NCZA
X-Authority-Analysis: v=2.4 cv=WqQm8Nfv c=1 sm=1 tr=0 ts=699d8083 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=IG_F2lY0Ax8mXwJdcBoA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217900-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DE34D1858CE
X-Rspamd-Action: no action

All the functions operating on the 'handle' pointer are claiming it is a
pointer to const thus they should not modify the handle.  In fact that's
a false statement, because first thing these functions do is drop the
cast to const with container_of:

  struct acpm_info *acpm = handle_to_acpm_info(handle);

And with such cast the handle is easily writable with simple:

  acpm->handle.ops.pmic_ops.read_reg = NULL;

The code is not correct logically, either, because functions like
acpm_get_by_node() and acpm_handle_put() are meant to modify the handle
reference counting, thus they must modify the handle.  Modification here
happens anyway, even if the reference counting is stored in the
container which the handle is part of.

The code does not have actual visible bug, but incorrect 'const'
annotations could lead to incorrect compiler decisions.

Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

I will have more patches for more drivers like TI, ARM SCMI...

Changes in v2:
1. Update also clk and mfd drivers, fixing build (do'h!) failure.

With Lee's blessing I can take the patch via Samsung.
---
 drivers/clk/samsung/clk-acpm.c                |  4 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.c   |  4 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.h   |  4 +-
 drivers/firmware/samsung/exynos-acpm-pmic.c   | 10 ++---
 drivers/firmware/samsung/exynos-acpm-pmic.h   | 10 ++---
 drivers/firmware/samsung/exynos-acpm.c        | 16 ++++----
 drivers/firmware/samsung/exynos-acpm.h        |  2 +-
 drivers/mfd/sec-acpm.c                        | 10 ++---
 .../firmware/samsung/exynos-acpm-protocol.h   | 40 ++++++++-----------
 9 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acpm.c
index b90809ce3f88..d8944160793a 100644
--- a/drivers/clk/samsung/clk-acpm.c
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -20,7 +20,7 @@ struct acpm_clk {
 	u32 id;
 	struct clk_hw hw;
 	unsigned int mbox_chan_id;
-	const struct acpm_handle *handle;
+	struct acpm_handle *handle;
 };
 
 struct acpm_clk_variant {
@@ -113,7 +113,7 @@ static int acpm_clk_register(struct device *dev, struct acpm_clk *aclk,
 
 static int acpm_clk_probe(struct platform_device *pdev)
 {
-	const struct acpm_handle *acpm_handle;
+	struct acpm_handle *acpm_handle;
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **hws;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 1c5b2b143bcc..66448c8037ac 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -42,7 +42,7 @@ static void acpm_dvfs_init_set_rate_cmd(u32 cmd[4], unsigned int clk_id,
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_dvfs_set_rate(const struct acpm_handle *handle,
+int acpm_dvfs_set_rate(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, unsigned int clk_id,
 		       unsigned long rate)
 {
@@ -62,7 +62,7 @@ static void acpm_dvfs_init_get_rate_cmd(u32 cmd[4], unsigned int clk_id)
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
+unsigned long acpm_dvfs_get_rate(struct acpm_handle *handle,
 				 unsigned int acpm_chan_id, unsigned int clk_id)
 {
 	struct acpm_xfer xfer;
diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.h b/drivers/firmware/samsung/exynos-acpm-dvfs.h
index 9f2778e649c9..b37b15426102 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.h
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.h
@@ -11,10 +11,10 @@
 
 struct acpm_handle;
 
-int acpm_dvfs_set_rate(const struct acpm_handle *handle,
+int acpm_dvfs_set_rate(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, unsigned int id,
 		       unsigned long rate);
-unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
+unsigned long acpm_dvfs_get_rate(struct acpm_handle *handle,
 				 unsigned int acpm_chan_id,
 				 unsigned int clk_id);
 
diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 961d7599e422..52e89d1b790f 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.c
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
@@ -77,7 +77,7 @@ static void acpm_pmic_init_read_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan)
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_pmic_read_reg(const struct acpm_handle *handle,
+int acpm_pmic_read_reg(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 		       u8 *buf)
 {
@@ -107,7 +107,7 @@ static void acpm_pmic_init_bulk_read_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 		 FIELD_PREP(ACPM_PMIC_VALUE, count);
 }
 
-int acpm_pmic_bulk_read(const struct acpm_handle *handle,
+int acpm_pmic_bulk_read(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 count, u8 *buf)
 {
@@ -150,7 +150,7 @@ static void acpm_pmic_init_write_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_pmic_write_reg(const struct acpm_handle *handle,
+int acpm_pmic_write_reg(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 value)
 {
@@ -187,7 +187,7 @@ static void acpm_pmic_init_bulk_write_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 	}
 }
 
-int acpm_pmic_bulk_write(const struct acpm_handle *handle,
+int acpm_pmic_bulk_write(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 count, const u8 *buf)
 {
@@ -220,7 +220,7 @@ static void acpm_pmic_init_update_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_pmic_update_reg(const struct acpm_handle *handle,
+int acpm_pmic_update_reg(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 value, u8 mask)
 {
diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.h b/drivers/firmware/samsung/exynos-acpm-pmic.h
index 078421888a14..88ae9aada2ae 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.h
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.h
@@ -11,19 +11,19 @@
 
 struct acpm_handle;
 
-int acpm_pmic_read_reg(const struct acpm_handle *handle,
+int acpm_pmic_read_reg(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 		       u8 *buf);
-int acpm_pmic_bulk_read(const struct acpm_handle *handle,
+int acpm_pmic_bulk_read(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 count, u8 *buf);
-int acpm_pmic_write_reg(const struct acpm_handle *handle,
+int acpm_pmic_write_reg(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 value);
-int acpm_pmic_bulk_write(const struct acpm_handle *handle,
+int acpm_pmic_bulk_write(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 count, const u8 *buf);
-int acpm_pmic_update_reg(const struct acpm_handle *handle,
+int acpm_pmic_update_reg(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 value, u8 mask);
 #endif /* __EXYNOS_ACPM_PMIC_H__ */
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 0cb269c70460..987b59778ffc 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -412,7 +412,7 @@ static int acpm_wait_for_message_response(struct acpm_chan *achan,
  *
  * Return: 0 on success, -errno otherwise.
  */
-int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
+int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 {
 	struct acpm_info *acpm = handle_to_acpm_info(handle);
 	struct exynos_mbox_msg msg;
@@ -674,7 +674,7 @@ static int acpm_probe(struct platform_device *pdev)
  * acpm_handle_put() - release the handle acquired by acpm_get_by_phandle.
  * @handle:	Handle acquired by acpm_get_by_phandle.
  */
-static void acpm_handle_put(const struct acpm_handle *handle)
+static void acpm_handle_put(struct acpm_handle *handle)
 {
 	struct acpm_info *acpm = handle_to_acpm_info(handle);
 	struct device *dev = acpm->dev;
@@ -700,9 +700,11 @@ static void devm_acpm_release(struct device *dev, void *res)
  * @np:		ACPM device tree node.
  *
  * Return: pointer to handle on success, ERR_PTR(-errno) otherwise.
+ *
+ * Note: handle CANNOT be pointer to const
  */
-static const struct acpm_handle *acpm_get_by_node(struct device *dev,
-						  struct device_node *np)
+static struct acpm_handle *acpm_get_by_node(struct device *dev,
+					    struct device_node *np)
 {
 	struct platform_device *pdev;
 	struct device_link *link;
@@ -743,10 +745,10 @@ static const struct acpm_handle *acpm_get_by_node(struct device *dev,
  *
  * Return: pointer to handle on success, ERR_PTR(-errno) otherwise.
  */
-const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-						struct device_node *np)
+struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
+					  struct device_node *np)
 {
-	const struct acpm_handle **ptr, *handle;
+	struct acpm_handle **ptr, *handle;
 
 	ptr = devres_alloc(devm_acpm_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
index 2d14cb58f98c..6417550f89aa 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -17,7 +17,7 @@ struct acpm_xfer {
 
 struct acpm_handle;
 
-int acpm_do_xfer(const struct acpm_handle *handle,
+int acpm_do_xfer(struct acpm_handle *handle,
 		 const struct acpm_xfer *xfer);
 
 #endif /* __EXYNOS_ACPM_H__ */
diff --git a/drivers/mfd/sec-acpm.c b/drivers/mfd/sec-acpm.c
index 537ea65685bf..0e23b9d9f7ee 100644
--- a/drivers/mfd/sec-acpm.c
+++ b/drivers/mfd/sec-acpm.c
@@ -367,7 +367,7 @@ static const struct regmap_config s2mpg11_regmap_config_meter = {
 };
 
 struct sec_pmic_acpm_shared_bus_context {
-	const struct acpm_handle *acpm;
+	struct acpm_handle *acpm;
 	unsigned int acpm_chan_id;
 	u8 speedy_channel;
 };
@@ -390,7 +390,7 @@ static int sec_pmic_acpm_bus_write(void *context, const void *data,
 				   size_t count)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 	size_t val_count = count - BITS_TO_BYTES(ACPM_ADDR_BITS);
 	const u8 *d = data;
@@ -410,7 +410,7 @@ static int sec_pmic_acpm_bus_read(void *context, const void *reg_buf, size_t reg
 				  void *val_buf, size_t val_size)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 	const u8 *r = reg_buf;
 	u8 reg;
@@ -429,7 +429,7 @@ static int sec_pmic_acpm_bus_reg_update_bits(void *context, unsigned int reg, un
 					     unsigned int val)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 
 	return pmic_ops->update_reg(acpm, ctx->shared->acpm_chan_id, ctx->type, reg & 0xff,
@@ -480,7 +480,7 @@ static int sec_pmic_acpm_probe(struct platform_device *pdev)
 	struct regmap *regmap_common, *regmap_pmic, *regmap;
 	const struct sec_pmic_acpm_platform_data *pdata;
 	struct sec_pmic_acpm_shared_bus_context *shared_ctx;
-	const struct acpm_handle *acpm;
+	struct acpm_handle *acpm;
 	struct device *dev = &pdev->dev;
 	int ret, irq;
 
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 2091da965a5a..13f17dc4443b 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -14,30 +14,24 @@ struct acpm_handle;
 struct device_node;
 
 struct acpm_dvfs_ops {
-	int (*set_rate)(const struct acpm_handle *handle,
-			unsigned int acpm_chan_id, unsigned int clk_id,
-			unsigned long rate);
-	unsigned long (*get_rate)(const struct acpm_handle *handle,
+	int (*set_rate)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			unsigned int clk_id, unsigned long rate);
+	unsigned long (*get_rate)(struct acpm_handle *handle,
 				  unsigned int acpm_chan_id,
 				  unsigned int clk_id);
 };
 
 struct acpm_pmic_ops {
-	int (*read_reg)(const struct acpm_handle *handle,
-			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			u8 *buf);
-	int (*bulk_read)(const struct acpm_handle *handle,
-			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			 u8 count, u8 *buf);
-	int (*write_reg)(const struct acpm_handle *handle,
-			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			 u8 value);
-	int (*bulk_write)(const struct acpm_handle *handle,
-			  unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			  u8 count, const u8 *buf);
-	int (*update_reg)(const struct acpm_handle *handle,
-			  unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			  u8 value, u8 mask);
+	int (*read_reg)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			u8 type, u8 reg, u8 chan, u8 *buf);
+	int (*bulk_read)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			 u8 type, u8 reg, u8 chan, u8 count, u8 *buf);
+	int (*write_reg)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			 u8 type, u8 reg, u8 chan, u8 value);
+	int (*bulk_write)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			  u8 type, u8 reg, u8 chan, u8 count, const u8 *buf);
+	int (*update_reg)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			  u8 type, u8 reg, u8 chan, u8 value, u8 mask);
 };
 
 struct acpm_ops {
@@ -56,12 +50,12 @@ struct acpm_handle {
 struct device;
 
 #if IS_ENABLED(CONFIG_EXYNOS_ACPM_PROTOCOL)
-const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-						struct device_node *np);
+struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
+					  struct device_node *np);
 #else
 
-static inline const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-							      struct device_node *np)
+static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
+							struct device_node *np)
 {
 	return NULL;
 }
-- 
2.51.0



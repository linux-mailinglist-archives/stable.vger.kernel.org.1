Return-Path: <stable+bounces-223274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHu8LbH5qWncIwEAu9opvQ
	(envelope-from <stable+bounces-223274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:46:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD12218949
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35EBE302C2B4
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 21:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8622535E934;
	Thu,  5 Mar 2026 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dbao4P+U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hXdQgguf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B233A031
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747182; cv=none; b=pVVOt6enhO3SESf7Dz7qd/E9YoolN9u2yTAbDEBSlwI9EejhS3p/W/vhoVWbouP3g4MG6gwscPBYKOcDhjwiwlk8mDXY62fbga4IrjrssOasSTyJvo/nYkH2F5uCoObl9OUdKjF9eoXMooSSuR5n4C/gGJlOmvxa5UTq0ElbAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747182; c=relaxed/simple;
	bh=7qKBwP4RT8UWSNgGCGoui9ZGSKnXjO7Z7xGXOQ+rwgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAYgLmL9L61hE8uzghclCxOfyMRX6iXtAv8ex0j/CYSv689TMwCJMlf4rmUJ7WE+Zi8Aqld83Nqc97LkBTNwgDtP77MFiF6/oSh2sHukpIZhmbA+1F/7BbLciG6lPDFtfEUWQpbiciROg8aq1nwUhZgKLAwEDNCc47LzT6w8RKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dbao4P+U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hXdQgguf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625KmWeg1802688
	for <stable@vger.kernel.org>; Thu, 5 Mar 2026 21:46:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MlyEHA9gSBE4x00iU9vPwkk0UY8GbFcxWCKm5P/2jnU=; b=Dbao4P+UefkUl3rm
	ohOcd3z6FUH8e63d6S1tWZznd+NcnMa+/fe7JovY0KiK85uxX6sJqUHevc5uqS12
	xrJXjHZktFtvwh5IUBQztxzmZkXaFHD8uo7uTEKLpxQ3h8R6f3Dju0TNr9H1w3N5
	xEag2YOMrW2WyH8euzmseUeGEjG2U+2M4HPYaVlRhcfqcSwYFNPtOmAFZa73R4IR
	0wQSuVyrW5XByJxUcTi2hxzq2x03dnPFKoNJETHlc3aUtQqRE/HCYtKE2MLHhEgm
	wcr/waY0O7iN5L4AikuVHY5OqtJmqILXkZIHTfoaJyHrIpvaeO96J4WSW5CqHf98
	sOwxNQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq9srhtjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Mar 2026 21:46:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70fadd9a3so913575785a.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 13:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772747179; x=1773351979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlyEHA9gSBE4x00iU9vPwkk0UY8GbFcxWCKm5P/2jnU=;
        b=hXdQggufXdbdnYZF83wez8cTKYxnibSu28bUMgg5US5eCQ1KSoM+LDw38+xUIGpyr4
         E88T6y9Wea37jNs5Lz5wlY4Xz9td/BCvk9Yoi2dt4xWhsNIK3mJhbC6RilOT8Oz8XJ0m
         W0tuFSDsSG93sd+sXdixYHJfXmuAObsGk/18sKVj4OxAyTDj9ZltboqunDhCQMdRDkaA
         0ilPHg3Ajaea/lGl2VwYuQpf6KGJJkBayeq/u8FtpvE3LzInAE8TzAr3huH0tgUTg0bB
         kHPYCirnXrt1HmXWQUTAgSyf03EuLJhAKdX/CSk1mXCouyImH8cCVERw7691TfX8zEZ6
         1YiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747179; x=1773351979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MlyEHA9gSBE4x00iU9vPwkk0UY8GbFcxWCKm5P/2jnU=;
        b=wGLCVkCZ66dGm/MMBIvInPkPtJ3dus4fLJ+n8/AdhTrIASh91JODsgPjDScQyK8T/N
         7M7IGj1LZwP0qjxy0/w1SV0anmHsgfzTau7pEUxBoriyUvk1AjQvyQSVzbja+ToM9Z++
         EolOI8/jJpn6ScA384Xm8bnR+djSw98n68KsKIFWcggTVeUrbCAte4gvW3Qr09JrEDjW
         3nVzXUaay5DhzdiwH47SQcviuhuboRlmj8GyKlFoATEE42KG+pAl+aumKQhYky0L9MTA
         CG+n72VB3tn9cCsgI5tLiy2FL70WUe4wDXKc2ruh0aJr69qdRPamt+Pqk6EwE8RZaJno
         6IqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaExiMQMrPt/6vhmMSVM+7Y4wjoLwxK/OJip12m7rQjHrQfnfCMeNsZCzPB5kyWKjsn7Swxf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6gRJNOYSjBgHNrDt5/KT+Rr8Ih3UH6bhF2HIKGENJgjA5fsj
	LvrPqdew4SacBQjD24AygNvEoFDZHi7I8WRWV6whErv3dr22HD3etY0AWeVymov9EIa6ifhU1Ht
	7vzt/HSrX9NWV21zwubnEj0Dqdt0kPY4a6ZbA+UrBJ8+7o8b8BZrtpegMLYo=
X-Gm-Gg: ATEYQzzL8+AA/tQfGqBKgDbb6Uq+BuP/lFNuIdmOtpVRHulqlQVsMs87ilzTJxUyR93
	8QU3W5/Uk8KuAjjVtR13yiUzE7KG3WULahie/YqRG2RuppH4Vfxar1wUqbdbE57INjTJnng5O2T
	8+vJyjmdvhMwu9rmBdsmujMyJPm5BNRKc5zSE7DGyflTEFe8CSgWU+oF+Z0MJ1obnhSNovh6+/E
	A/A/7P+SeyGLK7z5Q+pqyKLTKopZc2YENHbfiMGbNkJ4j5mTjAOJqViSk5f4xwnZWYgs7W3kWzH
	zai6ucwqFsHHNnDK1Mn89Cb8fSabJJZnEingD/IZ68MAfZZIATrWOuIeNsaRV/qcln6hb+SiBFz
	GG3YI93Enr1aSQspVnYU93AjypvHnyVAHIOBp4L+ZnF2b
X-Received: by 2002:a05:620a:44d1:b0:8c7:1156:efeb with SMTP id af79cd13be357-8cd6d431747mr3988285a.24.1772747179238;
        Thu, 05 Mar 2026 13:46:19 -0800 (PST)
X-Received: by 2002:a05:620a:44d1:b0:8c7:1156:efeb with SMTP id af79cd13be357-8cd6d431747mr3984285a.24.1772747178665;
        Thu, 05 Mar 2026 13:46:18 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm28571575f8f.27.2026.03.05.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 13:46:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 22:45:41 +0100
Subject: [PATCH v2 02/10] power: supply: cw2015: Free allocated workqueue
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-workqueue-devm-v2-2-66a38741c652@oss.qualcomm.com>
References: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
In-Reply-To: <20260305-workqueue-devm-v2-0-66a38741c652@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tobias Schrammm <t.schramm@manjaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Dzmitry Sankouski <dsankouski@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, driver-core@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7qKBwP4RT8UWSNgGCGoui9ZGSKnXjO7Z7xGXOQ+rwgg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpqfmaTscz30XpaIVrSvMJ9NmAZXBjaoCJD1Qtu
 MsSty3dB5+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaan5mgAKCRDBN2bmhouD
 15pAD/4uItAh0+Y/646A3SxgJMd3qGhnE6oah8kL+B+QDXVcgNkJZNqpTsWPqg1ukrpJ0ToFsQR
 RNiOC1FeiFP5X7vtMQJ3v4EOLkUXa0zCrnD+c1aO1FcMnG0Y7gZH+ugMGwOuPFct+bs88d/v49S
 ybptu2xzXKXKBEfAo84Y7OumSKn/LvtJUAk8kBIb8KDuEMZl4r2havJm78odbmy/l7+v9D6T5sH
 DPzVfzNJDdZxNGOQ6OcHWvqDGeNOCv54whjFfsAOEtdgR/5SPJoA4pUbUCWh3RsOMBNnP5h6hSF
 njKtVt2sOP9g2NsX7XKxyDgmUGmg0rLdisILsDZYnguu90Woj+1e4/S3JdqSgdurRvABYmrgiuq
 XQwY8Q6YuGYiMzqX+g5ZvpNN3/9o6ZI7SwqCKrkFeZ7AQaDocx911KL+I/1QlDyP+84NFDreBkM
 2Gj2nSEHDsqtUaRbvrwIAp1Vg4pE9vJrx9fVg6xi/PRznBpoB2kcPOd7BtrCcmYzdMrB/nhq9sC
 tYQqUety3kdK+MSAl70WKyZ7gGpo7fPGOTKz8HXxVEeHiGr+iBOg/MEgylptG4P56NqHhcXWMBs
 xZ0iALks8NvYwqQkLYn2+xyFH3k3z7qEemupGFvVcDLHVbAD/zRk6XrL0Pp2cZXlzqwyenzorOv
 8p1FNzzDKoAJdpg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=a/I9NESF c=1 sm=1 tr=0 ts=69a9f9ab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zwXKoDzk-DkgMqbABcEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: p84UmgN4C_i-YfZ8vcgAbUFrFdU6atoH
X-Proofpoint-ORIG-GUID: p84UmgN4C_i-YfZ8vcgAbUFrFdU6atoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE4NSBTYWx0ZWRfXwXsP4H1YrNH3
 p2hlYQ+MO1IYqgT8L6Cyba52i+1RhZpc8FfyUPP0CvjoKipiTZFAmyLy7vMp6hGuw+ygRZIsEyT
 c4iRoZWuR40vUQLnHqpOcfyG42BohtUWczKxnXlzjJEPFUBUB0kpc51PZDeHoxYF1HUE7g6EudV
 ne62caC91flTV1HEiUiPAP5vcNU1Da9swKSlTLtixHjUvYLVpF80mFKgwc2i2rQtrsjS7p5uqga
 FcfikTEYVpNRFzFE9s+xjM2b2fwrNHgEeXEkblE63DJRoV16hoMKCcWSuIppqGLurHDTdf0zEYu
 yc6TyZ0ar+tC3dVcNLzXNZ/urCoN3CTZCYoK1+kRl15ORpUhjOcZmF7Se8JUbQOO4VPosixCWFM
 aubUUSP06NWTOhwzNwmAXyMQgPNEuB5V7HpdVFppy4ROOQfaOd1jxxgiQKIQNoSY298uFmjRGKR
 3UCjxI1MYk8vsMcpyBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050185
X-Rspamd-Queue-Id: 8CD12218949
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223274-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lwn.net,gmail.com,manjaro.org,linux.intel.com,linaro.org,collabora.com,chromium.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,collabora.com,lists.infradead.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Use devm interface so allocated workqueue will be freed during device
removal and error paths, thus fixing a memory leak.

Change is not equivalent in the workqueue itself: use non-legacy API
which does not set (__WQ_LEGACY | WQ_MEM_RECLAIM).  The workqueue is
used to read updated data from the battery, thus there is no point to
run it for memory reclaim.

Cc: <stable@vger.kernel.org>
Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on devm_xxx() from earlier patches.

Changes in v2:
1. Use devm_alloc_ordered_workqueue(), mention this in commit msg
---
 drivers/power/supply/cw2015_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index a05dcc4a48f2..286524d2318c 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -694,7 +694,8 @@ static int cw_bat_probe(struct i2c_client *client)
 			 "No monitored battery, some properties will be missing\n");
 	}
 
-	cw_bat->battery_workqueue = create_singlethread_workqueue("rk_battery");
+	cw_bat->battery_workqueue = devm_alloc_ordered_workqueue(&client->dev,
+								 "rk_battery", 0);
 	if (!cw_bat->battery_workqueue)
 		return -ENOMEM;
 

-- 
2.51.0



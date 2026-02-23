Return-Path: <stable+bounces-217822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CIMA0qsnGlnJwQAu9opvQ
	(envelope-from <stable+bounces-217822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 20:36:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83E17C712
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 20:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 897DE3046E91
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24DE36CDE3;
	Mon, 23 Feb 2026 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KvPbIilI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jQcqim0Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF81E834B
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875295; cv=none; b=ojh6x+usJYfeNxOGqQ8jDCCDSAacRTuCN/f2EqwsLscu2mZWMXjQANLVgheg0ttg6cHfYcyjDLClUismu03eTQxYXAGiZyHECs5XINgrqbo71y4wqt98xZ2IQF9zd0fiJ5/ximArj93tpFNgDLO2ZARs+Emif6iP8vXGbW9eugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875295; c=relaxed/simple;
	bh=6SkBT54jdGQQfxqV6Yrdqi3MUM9Fu93hXV9Cep9mVb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snhMgVqR8SP3ZagBv0oOyV7VVLy3eNTELzeghsSdQARZT3H8OXwwWQovu2LXFbM8A4gueT49qLH6tqb325n4+aExqngTjG/FIG3px+nMoJnykCkJGSfrvs1CSHtfaCnQyG+Ziwp5QVJfBuYkD6fC5YKKZBe/aXs53sQT01IRsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KvPbIilI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jQcqim0Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NH4crc910666
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 19:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xOe8cPoJ88byYsxtVowBQns9AoXPFIKBl/J
	2eUuUHyU=; b=KvPbIilIM9VjCMlmNzz4z+rHgEpl/GetKDG4KtHLD5bMed9ynH1
	bJ2HJ+uJA+BE0qY1TBxgXS/NrS/pJJ8N1O8FbHeplTFEOKmO94hG1gB5rdjMncV+
	rhHOlmbP/YbFed/POZV6VwWLToytVUOt9ykyRhadbHbkl7WTC78nJdC+d5CZmf+5
	GhJlPaHM70+tJulz6V1mIriphQ1QWDFYS6b7HWpfqPgh0CowmMUr9XqlMmaxVVwB
	C7TxoHRGorOW/bqRDx3Pcksap959iwEO7ZTblhADctMQUyXl004uqaiUePYwQmwd
	Sguf/ByRGE7VigDQyL1I/OtOCEV4pMt0Ftw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtyj8fjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 19:34:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-894a861fd7cso566816446d6.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771875292; x=1772480092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOe8cPoJ88byYsxtVowBQns9AoXPFIKBl/J2eUuUHyU=;
        b=jQcqim0QqTe92S9eNWLyZWh44FjkbPwagWCOUsr6LNP8nK1Vv3fTBmnUiBDwrl1rkc
         WaMTYBmK2bZA1UJHQgjo6/IkJtSftFKlEnZmJHmbQ/ezsVMHzpfecwFHU67O385HdRvw
         KB8eKVh+IoDJ9BhqfznCcj7zpZHStWvRP+Id2tJRqN6Y6LddjVy+sdpV3AkF33OH0jv3
         9BKcwgyR/F7+sWNb3OdQRwxzzAOzE/cdniCWuwgg6VWG9am+NpD3Hztl3zDyLy5pawy1
         lYqRzmEkJrpOYYvQGf+rZA12ahAO/BXa3LF4DMRwSOPqdbxHShANfyPRqnc9sQdwbsa9
         70FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875292; x=1772480092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOe8cPoJ88byYsxtVowBQns9AoXPFIKBl/J2eUuUHyU=;
        b=ggtaDtHJKRophIS+gM8nQrk1hH7vaoPg0x5TX/Frp/jLROgVKJzELo3GwUVQ/iyeJu
         Bt1ELXzalsneYmAg7e2EWGGH/Xm93hKMRA/Gf2FKTXk9D5lj2zGsRl9ywfn2DRkE2zuQ
         1jw6bpZ+YwauTNhQhgeLanJ49TLj1faLVQRvgwj8QiTUIpDlm2ZB47yMgWSD8qSR/rd+
         y3nkv4QRQmgaWL92hKpYNMQ5HH4n6AVDAuWUVuSb7VGHpqd4/ZN9A7MEUEbsjAZxbisN
         Z9szLrOjP2qN2LFEhvrJbIrFD+bLyE9zwqO09NZQ0KOPl5ccCIbj1o9DqwuTxeXqE5vI
         Qrfw==
X-Forwarded-Encrypted: i=1; AJvYcCV6TUtKGCSzEepcw4/05C25b7b1yoLBnScfjjCu6Qfsi9TTe8ssCUFSTWlFXxWSZMoy/5k95Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8Rx65TEsnXpatH2xcblLXZzbnr6n75N+dqZRaUxelFmQvitU
	psUiuFgprEKt7WmoLjYbzrOo32nS2H4+wRmpgXuvInR4b041cLlCXjtqF2XnNLPWLIhHLdg7RzF
	7/XuGitD2raqSa2AFxdJMfsu/R/DUUd+6k1Hu5nv4stDHsqLyFR3aszIAHwg=
X-Gm-Gg: AZuq6aIUfcBYjRqGG16jhLfDBwnA4Qh2kkFK38BfpZsFrlRfabNw5YdN0VLIMu2RSjG
	A1rUuR3SLtd930G3PSayb+aEqmRFrko4kNrHBxAq4JRdkJKvc+D7RvlXvW1TtEqpmmd1Jx3pkxf
	FOKspSqkp1S+90qdl4E4Dtdw7D7M7/FxwjaYC/xx4vVl29X4+mZ9FWr2Fu2PRGKOEHeIwQa3eHV
	IRNBKAQqvDBPc2Uzrk2ckXAZ431GImwByoM0d1lldPvS25sIlkV3mYWMUwd+jPRAre5tTgJyUQD
	Kk1bCiE4hkDusIJYmDG/tA/Dn+SoxAUxo6PP9/KN46r2Re1JwT5+oPyqt3ZLcBWSuWw7Xv1p7h/
	DQhQWhDu77MUtr/JT4Ay0pBK9ayUndTJho74nBQ==
X-Received: by 2002:a05:620a:1289:b0:8cb:9fd4:2ecb with SMTP id af79cd13be357-8cb9fd42ef1mr318779985a.54.1771875292321;
        Mon, 23 Feb 2026 11:34:52 -0800 (PST)
X-Received: by 2002:a05:620a:1289:b0:8cb:9fd4:2ecb with SMTP id af79cd13be357-8cb9fd42ef1mr318775085a.54.1771875291372;
        Mon, 23 Feb 2026 11:34:51 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9caadedsm177232805e9.10.2026.02.23.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:34:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] firmware: exynos-acpm: Drop fake 'const' on handle pointer
Date: Mon, 23 Feb 2026 20:34:17 +0100
Message-ID: <20260223193416.532231-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11784; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=6SkBT54jdGQQfxqV6Yrdqi3MUM9Fu93hXV9Cep9mVb4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpnKu4ZqTXIw/aEfbxxzj4Jyn3WtPAxb1HIV9YI
 Cfh6Wd3N0CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZyruAAKCRDBN2bmhouD
 10VQD/9jd1L0tj+iLoj7aUstzcIdUp2A5wCz+3NJuUFmu+kN/cpTU2VYuV4vPTsfEUb28jCAtZW
 cdD7UHKlfh3Do1pjAPs3DVoDpW23l/Tb+AcsvIICYNeSaE7wbXxzzZcOvAyGt2POCwuIH+FqJ4F
 AY0Te6tAw9f+1cGxFMGWHz7e2K6ZWqnU29x18ko/EZxmMFPpyLvgB2fwnHswqKGelYPhvrXKsWH
 GJkTwdJvekwXQ7yajvmWlQ1rLt+43I9C72gjzWkHZRHXRXVvoQNhFyoiGSVelPSwCqWCAlU6w4v
 Vp38RbnJQVBVEQO0dXqgUgTO6jIAgbXhpztEeQWpNbZDWIkvtf8rggmjKU0hOSBGgNKK1uRH8KW
 MXtVbXFKMXfIqoWpbhKmlAS5fseKGH5j7EOrA1t26E/7kQ8c7Fu/dty9Ab5jeoW1IhgQg1ecIv6
 npBPojujl24Yi/tcQPFSIQBZvYuDwQ6XVoSQe4Vx5f1LytPb2nAylP9/SjtHelC90SFRKznmZXG
 vA9gdy8YdhFy0epRSDwXzMXUY89hvlXN9dKxdQClNMljcDAGFjcdahG54gzmYELLfMDVGX5V+kB
 Qy3O4K3FOEl7/QNznL25IJxOBDkW3PZUROvSLLXzDvTZWU1CBdWoEKFRAreHtxH33Vs9fdglgqo 7XJtS3z2Fdp6HbA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jq/8bc4C c=1 sm=1 tr=0 ts=699cabdd cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6hZ-4XOhd20wvc6P64wA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: GZ-6X3x27i87HKAiOp6SzDDk-o6lyte7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE3MCBTYWx0ZWRfX/msIwyBuNIbG
 XbYqggR4FiaIcG5Mt3fBJy4smQIV95/hbrE9foL2EsXiV3MkFrHcGKtkndQT1Z8UJfr4XL0+EgS
 IZ/Faoz9hW44CQEElUx89eSfw0vf1UG9YQJlygr/g+R4qQ2UsY7XP5L2DfQCZ8vm4g67eSh+6Cj
 WtWRLLjBhrIvP0m+DBSthqKFkzJDlZk81Ofk4xJZieC3wW0D7Y/emFT4qh6hMwOJdo0FTxZP0YG
 bsYOlShyea0sxauFtXy1cMoTcwWvZLRSkjqLCo/MPTSlP/0s6iCWuF2hfoVzCqN/SxLmoNwqPbp
 2WYZWGW4zmBXLTE7GhfhBJMFnGGf8VQE2Ye70+v98bztThBw/aasegJVmJ/cd6Y4exag6Ln5015
 MFSXdbMyni6S4ykOMLW8nrK2XjxsL1Ulj0R6nyb1y9crwL7Nu9gS1J5TXQltm/aXo/jB7jAAlAU
 eWJOXIn9jfjb86v2bLg==
X-Proofpoint-GUID: GZ-6X3x27i87HKAiOp6SzDDk-o6lyte7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217822-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2F83E17C712
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
reference counting, thus they must modify the handle. They could not
work with handle being pointer to const.

The code does not have actual visible bug, but incorrect 'const'
annotations could lead to incorrect compiler decisions.

Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

I will have more patches for more drivers like TI, ARM SCMI...
---
 drivers/firmware/samsung/exynos-acpm-dvfs.c   |  4 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.h   |  4 +-
 drivers/firmware/samsung/exynos-acpm-pmic.c   | 10 ++---
 drivers/firmware/samsung/exynos-acpm-pmic.h   | 10 ++---
 drivers/firmware/samsung/exynos-acpm.c        | 16 ++++----
 drivers/firmware/samsung/exynos-acpm.h        |  2 +-
 .../firmware/samsung/exynos-acpm-protocol.h   | 40 ++++++++-----------
 7 files changed, 41 insertions(+), 45 deletions(-)

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



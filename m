Return-Path: <stable+bounces-214418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPpqCo9ShGkx2gMAu9opvQ
	(envelope-from <stable+bounces-214418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:19:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB91EFCF1
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECD93018D59
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87621360758;
	Thu,  5 Feb 2026 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQgX7HOH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ELaVgsu2"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C62E8DEF
	for <Stable@vger.kernel.org>; Thu,  5 Feb 2026 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279513; cv=none; b=sbqYdAM30HphxVe+NHCOzAsfvUeTG146m7l4tgxcJasgpBCUTISSDS0RItONxsPg32ebGMW+ZJPekwWwHB39bZK6rAL4fuvuOdh0lvhAOrs4AKcUj3BWvrfxLjQ2SFDD1VF/tHPCN1EgXA/32gNABg/KoWfe0wi/uv5qQ3V1SbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279513; c=relaxed/simple;
	bh=hAmFipua3hEk9guV/qzg8m1hmAbVzDb5Iu2dccR+YZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzFjHEyzQo+qQlxMzQxLRxZD7pfEibbE+WiH1hUoTtMsxxwXeCtadfKP1V8E8C7/got38ha7Mys4ARqICB82X3f1iDaaav5u2wh0YSAJ8Irn4yHweqsqxNteXwX5H8PAIhDE83UI++1qa+oYLEjvKbnKvJL8NtxgxlNn8PXPYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQgX7HOH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ELaVgsu2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153dm2b3397139
	for <Stable@vger.kernel.org>; Thu, 5 Feb 2026 08:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ekJb2WIvNeR6oXq79OmiEe7+fzhI7WwRbsy
	gqgOf4uI=; b=SQgX7HOH9sb3zciOrbHN+6PSmvnKEwthepfIU2K1RYjy7bTiNZE
	dQ271ywfJzQyNwC7RJiDdoD/HzmaSoTdFOJWJMnMlVD8XbzhMpSVRbMQ8TYnzgqd
	J/yrs8QG6wN07P5cf57hO9DRxf+H6gty6T0tLuDxDdYO63vqmW+tuBna2FBPcxml
	0ZeSCzgwQ1JvhjM7fGT0+wxITmlDDmHNiZsf7pLyzhF3KTv0U9dajSuyvbsXLGUl
	ST+VLApjbvaeq0rmupsaCCGFbYCeiG+mMRRVfC8jaSO1JVvCmE6uAFtFITxlTSuW
	+hx9jpS7UC66BCH8oA44Q2OUBM8aDIzEnZA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43dh3r5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 05 Feb 2026 08:18:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c711251ac5so193161985a.1
        for <Stable@vger.kernel.org>; Thu, 05 Feb 2026 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770279511; x=1770884311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ekJb2WIvNeR6oXq79OmiEe7+fzhI7WwRbsygqgOf4uI=;
        b=ELaVgsu2nJ9ktzFibK6lY7X5YRlmaXiEe01aqCq3DcYdLoYHqE7CWRPoQOUO+3sVn/
         JsYl6B9gUm1loH7KDZDcWQeIZ8UaC5Z31rgUuH5OUfQvaoU5PK9tt+8v5j3Cg0PgdF3d
         6siPJrxMZazS5HlMDAKUL0E3pVwmsMO5OR28TlQlY/gg874SGv767oDKWyP4tcxDfw7O
         uTPAWQXCl6aNi28Cx2JYprO8NY3S2DxEcADSHVsPvpASN8LNOlVvobty/gmQTe5VDjWu
         i8IjN/bVaZisgoHlqG2r8SPTLqm+/kwmc0mNqMR4r3Td4TOsxTprGZUDPMYFHyKwVzst
         FQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279511; x=1770884311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekJb2WIvNeR6oXq79OmiEe7+fzhI7WwRbsygqgOf4uI=;
        b=LJ/VG0cxD9V+3j7xhELLgrFxkhwdmJyLulLUQzkVkFKF2yWjuz2cMbdfbjptjxgrpp
         o5ywC2XPkbjef7qNGPK+hZXVCITxaQsm/VGfsZvdLHfFfnTQf16gjJM8w7BaAmEaOyFe
         x0AZuRi1i0grg+3PLQPPFDb/ntqwiLQBWpGqsU90ps60U/bWte2gQ01Z9gUiTpabcA15
         9nLBuseIgKiWxrwuIm2YrQTLbBbwCCSPeAk6LVUAuS68TUWfGqAjbPbjW7NrvtHhYNW8
         88kXepmxm6JgiLgHMblswEBEFFOpsGoKWIZ44yJC95ozAHTaOLyz4mBACIHXU+5gzO/8
         AGfw==
X-Forwarded-Encrypted: i=1; AJvYcCU2vxlemKTi5BiLo9su6DGXAv7PaoqYBxrX2ibbflnddWeVs6iCOR7IywgAcmOTxHFIzPMStRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjYCHR1S2stWr+7H/TOl4LNjVNEqy7dZwkVgYhWDCkWPivHF/X
	9/iFPmY3zC2uIzwLfljnNaoq2CMrsz3xythY0Af+yiyinkAafX7m2YCpMgbSJscqy2mcIG6iAnU
	rVYipSimXOwY3e2saBTNyqJhQCSNomIUvU20/dGzRgiOPLscQDxl1AyceIuaPwaVYfFY=
X-Gm-Gg: AZuq6aI3t2TSVX6f0fyLb0+HtJRD3pVD5wjph6clZp5YGbVQuAj6ZChYCbno2Db5M4r
	w6ERZV552F2MCe/xvPMt9VqYW8Lyzi200a3eY/IhYRiUvwIUu1/wHyoTEiyMt7qV5WH23o1lYqe
	GrmIAB1oAr2gJjkkp99Yh+B2jApsPNbz3QAI6LdSTfD6E2Pzigi1aCVNDIK5YtPwfu5Wy8XZ+O9
	5KfxyzjKccdU/LqvfZ9Kd7ufUYqmljUH2OE+PiBgvkef0QFqIsmulywWG4asG/JIj1sQf2AT6A4
	OKlDoDNGqFyP2H1rx8nYkjR38JH1hRfQWD9YkiHiEoDixyVddbCTmLfzYfOMaP+BFHCDY4fuvGW
	kez9D6GO6igCU/q1pLmb27/DkvsZ2yE4X+9afkvrc40M=
X-Received: by 2002:a05:620a:1a1c:b0:8c9:f996:81fc with SMTP id af79cd13be357-8ca2fa75447mr780343985a.83.1770279510868;
        Thu, 05 Feb 2026 00:18:30 -0800 (PST)
X-Received: by 2002:a05:620a:1a1c:b0:8c9:f996:81fc with SMTP id af79cd13be357-8ca2fa75447mr780342885a.83.1770279510455;
        Thu, 05 Feb 2026 00:18:30 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fc0a3bbsm72262405e9.1.2026.02.05.00.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:18:29 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: leqi@qti.qualcomm.com
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH] ASoC: q6apm: fix array out of bounds on lpass ports
Date: Thu,  5 Feb 2026 03:18:25 -0500
Message-ID: <20260205081825.11209-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bMgb4f+Z c=1 sm=1 tr=0 ts=69845257 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MyalSr31lt99Fa30PzAA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 5BXg5XA7dj0ef2JrgMmnmo94mjJMPZIN
X-Proofpoint-GUID: 5BXg5XA7dj0ef2JrgMmnmo94mjJMPZIN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA1OCBTYWx0ZWRfX/fRIOGGYpxkL
 SxXzsbtVA2lALX89u2Y+cWUpusELxeIWPcj349QUQqx5HPcl/p2Kj++wInjB6bWP7dB6Ei6wmnk
 t8JbBHGPm3aLCPDL+RX78kwrQgetFYz+ANjDid/Red9oo1MhqzLEAJejI7mT+wSBFt6qkUHVCbn
 1nZBAvBnupeKqZJQUXhb388IgySJ/dTIQ+Cl75bYA29i5Bx9js9C8ybGElFCKPUAYuI2Zlhxi2x
 KiIXXyNG057ZSK8zpHVscLwYIu2LKMIUTmPou9Aa5+GUNiWjiYL7Y/x9zCmBwd2sWke+wqk9cvH
 ORrV7nrmUgUYxBHycorYO3+6BUMZjrQe89qydBBjFiIcK/ayL15h7hspcbQPLMPaOlZGKYr6zww
 6jVkl1bnEsQJ7EVmZ2uZeRArZ/ShHeEFKwjS1nh4cTkg7alk3f/Sv2DvHQbFU/kXn5yq1rei4PN
 2AszieZmHKYVt3MvDgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050058
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214418-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5AB91EFCF1
X-Rspamd-Action: no action

lpass ports numbers have been added but the apm driver never got updated
with new max port value that it uses to store dai specific data.

This will result in array out of bounds and weird driver behaviour.
Fix this by adding a new LPASS_MAX_PORT which is can be used by driver
instead of using number and any new port additional can only be done in
one place, which should avoid these type of mistakes in future.

Also update the driver to use this LPASS_MAX_PORT.

Fixes: 55b5fb369c02 ("ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add USB_RX port")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 1 +
 sound/soc/qcom/lpass.h                             | 2 +-
 sound/soc/qcom/qdsp6/q6apm.h                       | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
index 6d1ce7f5da51..b4856627ad00 100644
--- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
+++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
@@ -140,6 +140,7 @@
 #define DISPLAY_PORT_RX_6	134
 #define DISPLAY_PORT_RX_7	135
 #define USB_RX			136
+#define LPASS_MAX_PORT		USB_RX
 
 #define LPASS_CLK_ID_PRI_MI2S_IBIT	1
 #define LPASS_CLK_ID_PRI_MI2S_EBIT	2
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index de3ec6f594c1..99b0b6651fad 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -17,7 +17,7 @@
 #include "lpass-hdmi.h"
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
-#define LPASS_MAX_PORTS			(DISPLAY_PORT_RX_7 + 1)
+#define LPASS_MAX_PORTS			(LPASS_MAX_PORT)
 #define LPASS_MAX_MI2S_PORTS			(8)
 #define LPASS_MAX_DMA_CHANNELS			(8)
 #define LPASS_MAX_HDMI_DMA_CHANNELS		(4)
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 7ce08b401e31..189ed8a1a60d 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -16,7 +16,7 @@
 #include <linux/soc/qcom/apr.h>
 #include "audioreach.h"
 
-#define APM_PORT_MAX		127
+#define APM_PORT_MAX		LPASS_MAX_PORT
 #define APM_PORT_MAX_AUDIO_CHAN_CNT 8
 #define PCM_CHANNEL_NULL 0
 #define PCM_CHANNEL_FL    1	/* Front left channel. */
-- 
2.47.3



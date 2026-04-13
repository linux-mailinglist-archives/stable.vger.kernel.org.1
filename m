Return-Path: <stable+bounces-235971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAzFCley3GmbVQkAu9opvQ
	(envelope-from <stable+bounces-235971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:07:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC23E9908
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F10DF300646A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629D3AF65B;
	Mon, 13 Apr 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G9KXiMLD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E31H4kFO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D603AEF4B
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776071251; cv=none; b=sbSkajrdIVTisOcJJqAvvS+7A57gE+8qksTSSeu/RQOat+g1OaVU6CmRDTbQrySORN/Hjr5w5ddnSoEiKwJAFZ7ib3NdEaMbbKI0fdHy9MusLFA5TYDa7SZ83mOVt0sjHuI4QGQNJUWKnAO5hc+FnVq2eOZ1XXvime8N0Mo/sqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776071251; c=relaxed/simple;
	bh=b1tENQvXY+F8W/xm3g4+DZZXahca+UgV07xvDpCrdHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zf480GpPuf9LPNt+m2N6nIGEIjy7ZWvGRgQjIq6VT0V0zTe3JUTqwl93ALvxT8vKExdoz913Nahh51DZyznQoag5qW/1ATF8u7MSqul5RDuSp1L9qcvJFM4Y10G5Vh0Qam9bl8AwULVNzZN9z0SvV0U81qW6cadMrJoF4nduB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G9KXiMLD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E31H4kFO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D794LM479978
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bS4CAqLyyN3vhcD+LdVe9Ic1o3rAepHQ07P
	+f8uMLn8=; b=G9KXiMLD3IsO13FTdHHxr3afEcV3tesQP4+fGLFzwnK79WLH9TJ
	z6d0QgIjp2YiUG9vjG0v2mS17+o1toCL2c9Yy2iWZ75RG78lPOQ+/PdvjKxdqeib
	uAwHmBmPbaAhs9N76sZmVJMWmvALWHvgLIzrKquunVScEC//lIrWlk0qveE7zLpI
	XPPB3ILykMeMEP/BD+Ju4Tkk9sBJt1CuPslXvz6RWzTu5gwvrHQSXmm4ThJqIFvZ
	W2Xit5OEKWxt0lUgAodvPSXPszPQwST3DIpDiQD2Sw5k/eTIBMlRyA6PUXgfZ/+c
	60ha2IjnkZfABmIZrfVPc1dpTaod7ruEu5Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dguuj8d2d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:07:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b220c72bbso92781081cf.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 02:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776071249; x=1776676049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bS4CAqLyyN3vhcD+LdVe9Ic1o3rAepHQ07P+f8uMLn8=;
        b=E31H4kFOnrWI8O02JLY0dntjWQS2LJ9bE7XbV+dTNW8SChjHf7FQBzJJhvjQ1qZhGr
         DgQdb/HcWELx6+M48kY7Qopn5oJWi3NnjCenrOk3PKEVlHfyGgfm66/2LETthDXhpbP1
         KAo2/WXuS3uNZQ/YvpSnFDoMKd8FbJOAO0NA7bM06VO+ZE9nZ/jer4yL/Gde6nIfzwVj
         WeYIWGOCPgzrvlMLL0VBH+6P7ZN6bLosQS8oG/cHX2xDxd2NoUTU+s73evqTemmWNFP3
         vqiHuZJc4EnlqU5wvUzb7BQlSpedLrRVjNlzsrszQ57DLn4TF19GxCwK4lDSql05kPc4
         2vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776071249; x=1776676049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS4CAqLyyN3vhcD+LdVe9Ic1o3rAepHQ07P+f8uMLn8=;
        b=UkdJX+1j4V31u5xaD2JWMpBadW03mnDt4lbv+b1YFeIJvsFeKX4fm/j797ZzA7pBUw
         oI7qis5wviZvog0U3SXl1QD+OmOU7CV7C3yw1s7yoBRwQsma4dsmEANAoNVCapTW/ao+
         7wTh8jGfxbL5C2x1er8SXYvZXGcQ4E11QKgxeb1zaYh75kwsOY5lR9qu2rVb1c4H2puH
         jHW1fnBs/t0U0cpJuCWvd5nzK6L2FW1d8ysFuIUXHs1uAKHgqZtUQzscJiUA9dfLYSQt
         8pWaLcRahgPKTwA0OhfzEC/y4/6aXDTQ4NqGp0iz5TJBIi/OdhvAnpZR21ZILqAdO2Ld
         QeVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p7Ph6oOixh+gmpj1yHugew5EfbM6QFW4WrqtlYltt2NjpCQ4/31wUVW/bgNjNkZ0Uyid03JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjkqMi50vvXVON9Orpa4I3i9mpWIPxcotsC+L8cyL2cQyBjaQT
	fqtvSSZx25z6W5R8ukLbSkefUw4q/TALphUsza+8gU1JB4fQz+81IFQ222qa+SPDxLUtAprWe9T
	ZT0YtvIjzlS3JWAggFOER6Qc7WNObu7V0APv1W8JFe3rZtERBPNzgSG5sf8I=
X-Gm-Gg: AeBDievV+2uA1Q3m74qV8xPRfQa4eMBYqRjHKX1FgJlNNSDMkKcYawwIa3R91OKw6s0
	AMaZ1vqbal0Wd/fOU/Kl1kNGnhmUSz4V3A5FM0JMArKLTQ5xzh6uo1KlU8zk02s2CtMvHYeU4Gl
	gOZHvlaUwW4JxpDVMZZIU1mXqDGCFForxWfH20w3MLRAq+cjpRx5P6CBa3Cv6JUG4Uus8666ms5
	A+Dv8sjd1pJeXYGKdV8J0k6Iqo9puSANxsJAy3qA9q+5JvhgdmBsWGm2gMRqYLWV8YfLNtKcDuB
	wPg6NbKIu5mc8anj2k88HdZ4ovpAPdIXQO9gokIdF99pzhptg15GYbuV0LUeuUBCVCNZucLAwd9
	ls1Kmm4yhcZW2yWtGfTBTJr9Tbxw5N4gk1a4K
X-Received: by 2002:ac8:5944:0:b0:509:211e:3624 with SMTP id d75a77b69052e-50dd5b15e8amr185842661cf.4.1776071248772;
        Mon, 13 Apr 2026 02:07:28 -0700 (PDT)
X-Received: by 2002:ac8:5944:0:b0:509:211e:3624 with SMTP id d75a77b69052e-50dd5b15e8amr185842301cf.4.1776071248352;
        Mon, 13 Apr 2026 02:07:28 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm30759347f8f.35.2026.04.13.02.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:07:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Xu Yang <xu.yang_2@nxp.com>, devicetree@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8ulp-evk: Correct Type-C int GPIO flags
Date: Mon, 13 Apr 2026 11:07:24 +0200
Message-ID: <20260413090723.53277-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=b1tENQvXY+F8W/xm3g4+DZZXahca+UgV07xvDpCrdHg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp3LJLy1g4Z3wLsTX9TEjDy5k3oRMGgxKGR72pO
 vd4nUJlFOaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCadyySwAKCRDBN2bmhouD
 11ufD/9ZfBbErQA0qwmvgVga1ZWnncoEdQfgPmQ5Atvcd8AjusNJNHwI3JxEtW4603nVn215Wat
 sFBZ5kd/GbFG/fQy6AIBQjANCQKaCd7Iv54odcNpyoW3SDFeTDDImTfP8TNQZE/acMLO+yxVrdJ
 mppQKhxN9bUvlN0tvBA1xLoF1unBTLUONg5gRj9LA0N8TKaghrtY5sesJrLaqAj0INi2PurPF4Y
 Py7Czn7wu2B9CMUUN+UUnKVsh38kguO3FAgWrVZ0m0bah3VlXQQEbbbpsmvp1/BA7ioMZp4VY51
 yg7rYiMy0cdhO/52ohzD3odmMaTCYMLeH9vxogDPUAf0HsDLnyNQDZm8EMe9lOFQhdQdj136rIf
 b2YZQYEtt4QBjPUNOS2KucLApABH8lbbEC+jecObhc9vGanpi7oXlJQi/2bIOEauFyxCYEvSWGK
 LNgfXXMMO0dsnQyouIR3LZJLEZ13StW/7GWs1+lsuoQDpdQeJm69e0Bly/VJyRoX5KiRK04Pc4t
 UnA4SyICpw1YXR/7a+jFA1O7wWgvufkIBSrLEmYBzrAviVxEIVQuFmSHvHAmP9OLjlIAR/+j8cl
 zRFc7DV99va+L8jJZWfncZ8tkznxc6FCjf74hhFRensYTBrFHQS9d6N3JOD5kOkZredA3CkyFgA pPZvVLJdACruOkw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4OCBTYWx0ZWRfX0Hyr2K/+s7bQ
 gbsCw99nTH7ksNXaOsk7e1QECDtvAg96d3pg/7HTZUWAkiWzZcmUxyquKCsByG0gVqSYbAHJtEY
 IV1OArUFWw07utYzz1UIQEw78q1yELOh+6Vn+FIN2orOev7GtHktiS/bVmi1bB+rRk8iIgxZ2Nt
 dapSL/OnrKcZyl89EYOXw8bBi6ceVg9loVSBwoD9ivDD/kcvH3YJiF1vNgzTgyyXBwZegncEc0X
 UTWHHpRgXLMQAnXDuWEvPwtBP1ouTYuc/ZVNoIi7Wch1bgC22Z/1okfrInJSrX2lFLwssChJ7sc
 0Q/WH37qCL4W/t57/FqMcfK6ZOfUbOmF6sjXHUxzqNRhHab3URpKlp8ZzCYBvTFKX7DB+M9007d
 t70Dj3QP6m04RCmbYYTy3hNRYO/CFGck6K3RotvLIcotUr4BOnKzRCZxs/M9UIXgZEVqOQ2K5vq
 H7H+8kbC0sPAONbe8ew==
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=69dcb251 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7SNBkYlbXATC84MHoTAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: eyc9TQwR4BLIwsbzTpD--Ml7szjwtHKI
X-Proofpoint-ORIG-GUID: eyc9TQwR4BLIwsbzTpD--Ml7szjwtHKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130088
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235971-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,0.0.0.21:email];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BEFC23E9908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IRQ_TYPE_xxx flags are not correct in the context of GPIO flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning: IRQ_TYPE_EDGE_FALLING = 2 = GPIO_SINGLE_ENDED.

Correct the Type-C int-gpios to use proper flags, assuming the author of
the code wanted similar logical behavior:

  IRQ_TYPE_EDGE_FALLING => GPIO_ACTIVE_LOW

Fixes: c4b4593ecb0b ("arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 290a49bea2f7..5dea66c1e7aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -166,7 +166,7 @@ &lpi2c7 {
 	ptn5150_1: typec@1d {
 		compatible = "nxp,ptn5150";
 		reg = <0x1d>;
-		int-gpios = <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
+		int-gpios = <&gpiof 3 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_typec1>;
 		status = "disabled";
@@ -182,7 +182,7 @@ pcal6408: gpio@21 {
 	ptn5150_2: typec@3d {
 		compatible = "nxp,ptn5150";
 		reg = <0x3d>;
-		int-gpios = <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
+		int-gpios = <&gpiof 5 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_typec2>;
 		status = "disabled";
-- 
2.51.0



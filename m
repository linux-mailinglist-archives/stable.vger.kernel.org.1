Return-Path: <stable+bounces-223752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E2QN3WZr2lbawIAu9opvQ
	(envelope-from <stable+bounces-223752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 05:09:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 573EB24526D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 05:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26327304C624
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579D3CA4BE;
	Tue, 10 Mar 2026 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxuXTtRz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aufOQDiT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA13B9619
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115757; cv=none; b=I58c6O0wLIWHDTJuqIsOpzTihBW+MD0t4I0YJcFA4mBA2ON3YvsDpglUgl2+O7T0sjQOxjrIjqViHMz+1zJiw28SthpIfQUQmFcWa9s0fIoqAYM7QBGexagEi5y4Hmbhjkh4OljP8DF08qTisxL7rb8ygRg4436SFmw1T7YaALM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115757; c=relaxed/simple;
	bh=j0BNFKTy6YhD81KGaBZfVR4UgpqXpUIBSqeGb+WvIjw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DYV0P7NSiMu4+CpVoJHKdiWVAZLpzpMjYD1NGCB8OIK6Xn8ptCN9t2ldoYYMZ/azBn18g+Xt/dAlQwp8Fhjh4dwTvW6+e+9XL13WQ8bRyZl9mpGxK2tbYo3kCmvkHLUAOBuwzUdDj6l3LeFdf6p3hwPKogLx73yCo0ZvTkKItxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxuXTtRz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aufOQDiT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EhM52817805
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DNXiimRcU/ja8ktsL318nq
	SuUFiZZt63sxQ0hRN6KkQ=; b=cxuXTtRz+nA/G+pqN3wV4e/OLdSaf63RH2dZ9U
	44nKSgLlgKKnmEuzzWn9PwHYIE4DuH1iFphH8cdU5l1561GwtUGhwKzOjhSDmn0l
	h/xUTJz0lul+yXE3h2SwAkmNxhBDnLosVSmMWc/tDFI1HjtKkzO7lZBtrGTGi20L
	JQFG3uoJiS2MWqKRmonlfUPdnJq9DGu+En/nbn/Gi60ckpR1xpb4o4tYbY5JsbVM
	9JREnjcAXf6z5op8KI/Pi8MoEtk2lP9f3v2hD3RRKHGic6Jn2P0GiIQ5z1aYgdmL
	HByJY7T9IjF8+pYCCt2pnWXtcboA/gZCSttdOkzOV2CAXgWw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyr42dn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:15 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4171d16aad4so19506506fac.3
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 21:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773115755; x=1773720555; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNXiimRcU/ja8ktsL318nqSuUFiZZt63sxQ0hRN6KkQ=;
        b=aufOQDiT8TBPCA2Pz0/CPH/aG5tvGwciWUeF6W/2Txy2Kvemab+eOrFTnyEx5iXiaK
         KNoL98K4u6YtnmaQAo7HXkGnIR6jlUQF8LDgYp0yYi9bm68EToZDbDEz/xEIP7bi/WB7
         7QozVWNwpdP4pY5/NGbOoVfRE+OLMxKGuL8IJT2FEz9DEzsbQ4wcxQd7Ltwb1OWMRP1b
         gPRv7eqdzg4NjqbrilqSgmJonJM+fG3Q3re7huhMq28mXLVK0FvEvVYi3UAkKbv/FwRJ
         wWqXH80J8Yeh54YOZka9sykGOY9MD2ZsjZ1oZuh+/JtuCUYXgUbZBrj3V6JkZHt4RsCP
         eOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773115755; x=1773720555;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNXiimRcU/ja8ktsL318nqSuUFiZZt63sxQ0hRN6KkQ=;
        b=CVWJ3ZeUYrviY2/UlfvttKH6DxQz78sM0tNeOhfhhlvrpZFHAA5SnQqa3UG4jl8Cx3
         KaUSksMcMwnnIOurCCyDO5pPJVN5maC8Eof4RZ2ZkbkJ5VuWQ0KUeyts5eSzsKKp4/NZ
         gGqVNZcfxxnuCAbI/mEmQWDKTPx5o85sjQMvi5XpB9Mj22MfUhwbE8Uet75CtCAtiRfH
         F1VuG/ekg44Q/Emyta2JmtsW64M+JUXvhBEVqqAyxNgLYcl54b7Mavfy1iaQX3BQJh00
         ORxux+gf15/6Qpw8ysgXhyuAe/H+k0BaJAU5dCGjpMKg+dOwqfdmh7IUmIwN/b8iNTVm
         hXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXkZZwvdJVR2p5xRVRRxFNVcGiYGoENiJRcei4+9OZyoWqp0zyzAWEX5A9RsUcrDXK5c6dPcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZCpmLlxbkzTFiRpj1Rd++Hl4aXPsZhXdE9iK/WhYlZAeclBS
	XtFHsYYXhQDoh37cdFbhSHuh7cz63Vx+FZbBIOaq+i/Ie1Ys+rM3OXSry1bjDbW/6EL1bZyF4Og
	hvPdoLvsxIsH9ReBbxN8cjzCh7CCbSiYex3AiWtMs7ON8Cow/Xmv7tbuJtfk=
X-Gm-Gg: ATEYQzwgHCkk6j2uvXvdPMdS0aXB+fMEVTPRgjRE35EtJU7TqNHX6cuE5vIODKryOl2
	ukoaWJnmkbZZUjqokEj1XqzbR5h1i+0jWuhqmeUOkqnX/zarq3m7h4DalydPZKtW+OElXyaVUXz
	BG7EphMQdB4CZXZhJopE5LWXywsuPS28eaXEujM0HMFz1Ck8VNHuz/WiW76KgwEltMJMjnM9Wne
	h2SDqp+KtRAe0gHbobQidhvsv64OJutnCdwdswVrrIkk1IcJbuKKRiOpzEXx2FG3F5q06kT/Zyk
	h4b5rvIkMSGSJ3YRxe0i2PGt0NObswQNCC+OxzvxcCvhse9tqzTdZzaaQMUrSa0AsgipTEKWwjv
	5BjUfCV/KKBY8Ob5JWZqgiH3zGL8RfPFaYvmwcDUOI8g=
X-Received: by 2002:a05:6870:a919:b0:3ff:4ab4:774c with SMTP id 586e51a60fabf-416e4448983mr8187452fac.43.1773115754881;
        Mon, 09 Mar 2026 21:09:14 -0700 (PDT)
X-Received: by 2002:a05:6870:a919:b0:3ff:4ab4:774c with SMTP id 586e51a60fabf-416e4448983mr8187440fac.43.1773115754466;
        Mon, 09 Mar 2026 21:09:14 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756e24c39sm1595685fac.20.2026.03.09.21.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 21:09:13 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH 0/7] slimbus: qcom-ngd-ctrl: Fix some race conditions and
 deadlocks
Date: Mon, 09 Mar 2026 23:09:01 -0500
Message-Id: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2Zr2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0ND3eKczFzdvPQU3ZTUMl1zE0MzszQjyzQDY1MloJaCotS0zAqwcdG
 xtbUAiaawhl4AAAA=
X-Change-ID: 20260211-slim-ngd-dev-74166f29f035
To: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=j0BNFKTy6YhD81KGaBZfVR4UgpqXpUIBSqeGb+WvIjw=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpr5lo/sm0Oc/SNYaBVYkBX9corkkNtHKlrnJ7G
 33ol92WVd2JAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaa+ZaBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcX26BAAxYhAAgDtmIR4dpqW+cOKTpmOCnBn859XYM+y+yq
 5tvkpSWjhgFBfpAcY2IwtEPvf7G3JVHdxkBZNZT9E5c39/RfY25ivjVXBQoutkZNa6RzgoISnjH
 PBOTja8kFKbnFlX/o1L3KJeor2KAxjhaFKXT5tzjhpnARdWZ45dmxdpPQ8QMPZw46ueLmfJH5dA
 uRO8CU2hWAGotrYZqwJKCecSFrHNTsp1dvoMihjBj3UYX2unvZ7QNOGKvmGEuj034M8ngo1opQW
 4Ulv7tVih38/sDOgGkpKt4EbIwt5hWAHC4O43WlBfnwzkzOJTQ+J2Xi4hJaFKEB3gcRfXM6GziH
 uhceCPWvEun8xJCO/Kpl7pJbmVKTY3QzwFa8bJayOQIQAXjJkSKLEz2pIDK4Yq45vO7ujzhX6pK
 cbMmtTrimblqZcnoW9HGfhhvV6kM6gs5uU27Z2MPDnaMyyoAXcgwqsA4cZG+HllmUEtuKgwm8v5
 Uv0oIxPeQv2Jtian6T7JFEBm/hhUC5VruOWhJbF615fFFs5B8qcRDmIctedaavrKvgDA10UInlc
 PvjY9n1E0XGw5+G9Sf+snp2yIgwR7nt2vonyqCmwS7VxiZ7bdaWhu3BoC1mRgEo5c8yedOeyV+T
 0CniPghvvexKeT53UNVy+hFGUXzsenQvyVeSBsb9QC/Q=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAzMSBTYWx0ZWRfX/4xU9c/ejIWh
 kvd5za4vnggDsrwShhzrdzw2bPbVF6ncsdKfnd35uGK3AyQmUsxBhQ7Jse2Im61H3dlRlmlawEt
 uygfpvQ33rLf+NLk5M80qAhQadmxJQ14VcD+B3Ekha2vStvDx2iGwSgCDfK0ueHwfnMEujImTbj
 psG9a5rRAc5jBzzuHj0UZ/XHVQqqV0CXyr2O9nbXdFTeLwXOgyvtxtwi3SKCDqCufUhcUU+Il68
 bU7bXjvHF182s4PQViCTAFApYLPpMTnCloyOfnSv9hRDLd0PyRuTZ2Uvon17Aqgf84mS3ecMIVL
 OhQ1Na9NT1FNg+V7GP4D0L+2098dMBffPQouVTo+obUCxWVKS+51YaLCYn+16HJWK8PU2ceAIr4
 sYT3kUHHeINg18sMUbpQRbouz6kgvUoLyv8TuGa5zn4aeJolgScB1hMJxnrmJgPftqWVe71OGHF
 y/nuglpx9GVLfxMpnJA==
X-Proofpoint-GUID: 3hy8PGxqeatB6M1A02yNQqigHh2-HhXo
X-Proofpoint-ORIG-GUID: 3hy8PGxqeatB6M1A02yNQqigHh2-HhXo
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=69af996b cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=N-1BD95YXHRArY_OaYMA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100031
X-Rspamd-Queue-Id: 573EB24526D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223752-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bjorn.andersson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When the qcom-ngd-ctrl driver is probed after the ADSP remoteproc, the
SSR notifier will fire immediately, which results in
qcom_slim_ngd_ssr_pdr_notify() attempting to schedule_work() on an
unitialized work_struct.

The concrete result of this is that my db845c/RB3 now fails to boot 100%
of the time.

In reviewing the problematic code, a few other problems where
discovered, such that platform_driver_unregister() is used to unregister
the child device.

Lastly, with the db845c booting, it was determined that attempting to
stop the ADSP remoteproc causes the slimbus driver to deadlock.

Note that while this solves the problems described above, and unblock
boot as well as restart of the remoteproc, this stack needs more love.

Upon tearing down the slimbus controller (when the ADSP goes down), the
slimbus devices attempts to access their slimbus devices - which is
prevented by the controller being runtime suspended. This results in a
wall of errors in the log, about failing transactions.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Bjorn Andersson (7):
      slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
      slimbus: qcom-ngd-ctrl: Fix probe error path ordering
      slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
      slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd
      slimbus: qcom-ngd-ctrl: Initialize controller resources in controller
      slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
      slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->lock

 drivers/slimbus/qcom-ngd-ctrl.c | 127 +++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 47 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260211-slim-ngd-dev-74166f29f035

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>



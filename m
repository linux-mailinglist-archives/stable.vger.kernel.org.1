Return-Path: <stable+bounces-216665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKQKB1vCkmk4xQEAu9opvQ
	(envelope-from <stable+bounces-216665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 08:08:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 46023141326
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77E02300250E
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5432E62D1;
	Mon, 16 Feb 2026 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IeqAAiP9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JEefAqDG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78B2609C5
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225682; cv=none; b=AP1UqkBPq0UlSJpdrA9dXxW88y1nozaN7f+0H11CO/U1ZO+62GM5KGx1sm5GrulQlodnAabpPIWSytLEWb4QuSoklIOiLF1dfZgI3xd+4NxeLYeXv6rLrBwQ5xDRTpLgOhy+b4usYUD7WzFbwyHolbRtdQC/RYi29x6hzWutXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225682; c=relaxed/simple;
	bh=LoHMRhwpy4wi9q82FqzTo9evwLCImd3dyKPb99tN/Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AuBa6Q4yT29UYOhYtleqtGlyRbDUCJAIJW65JylpQIZl63sfxDzVsFgLvxLH8IkxE9Co7pOyNIrJh8a3hHzF87gtsVdrjqSXM5uBCcAcEs4hzay+BGPiB2525SWjZx4luQUFAgQ+BnM+rH/9nyRvqyqoGRmP9SkcwbqAYiD8dZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IeqAAiP9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JEefAqDG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FLoI4o2262627
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 07:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HHYaXoVjbeIMUr+E51fIUr
	kafe5pyMGEDShsm8l6+9o=; b=IeqAAiP95dMP/Z/I7Oeq51rROqtk0QIwS2RvtW
	gb7xdErtxXn2rzTs2wbgEtKqfZDp7LBRiyHKjMPAC/2+f59t3oFtaa5cW0p9Mi39
	TfNybB/wOYlESlphimwqAsdnDX86LQf3XFDs9U6o1EZnJF8jON+LHeyixWr+oQ27
	5raWCEA8UucTAbmABwaYBSuDzcPwGpKMaiJ8cB2Vg7J6LrzAgEIun+DSbvwufXde
	8DqqOnT3niDBY5y1nALpIztuwXHJdXzFhC5+E81xQOcMUMlpmKodFFJpesWuPwAZ
	vWbboive8O/98k405nVBzLUj41VslOLoPoZ6Vei3nRMdwcSg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cahe63p32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 07:08:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35842aa350fso7891815a91.0
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771225679; x=1771830479; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHYaXoVjbeIMUr+E51fIUrkafe5pyMGEDShsm8l6+9o=;
        b=JEefAqDG/xK0i+FFVHBMeNjOd3dIoJ7NYDPZ5zgyY1LyNtndICEppGO2SUGvZetLq/
         0KZb+NRfatRnjM3lZ56dM45E8SNhbyHubVlJR+2tIyYLverH1X1e5R6e6UgqMcJAVtkv
         4f5tNrP2HdC+OQzn3j03iWGsa/CMY2J8EUUWbxIt9NrA9OCCV/xFOuKspZq673MTzh21
         3Ii2OwpJ+A1GC4jTum69PbYTJn0YvMMVWZq7XAEPE+PR6EevN9/tO72Rxu23qobVTpAs
         5fyjEyqhO6b60BuyUUJmAd3uzecJrdoZvINFxxUbTsfxlyQ0VwP2EIwcrCX1G+Jiplyq
         Vqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771225679; x=1771830479;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHYaXoVjbeIMUr+E51fIUrkafe5pyMGEDShsm8l6+9o=;
        b=cvyLA4oJ9Vwx/AzElhTn54yKMAtEefUNHrqKuR7sBxiw6G0FRmP1YnYS/MRscn/GUN
         sdzYiHm/qce5pcDAx/OxsIRoIisoWQ6okkaCff42fsN78iwuApNDYCLY9khwU7TI2ZfM
         9JEPDkPtcRKxombxY6m4brR576rbaFoDhmM0JXZVr+75mycXt37IZZT+Eq3zbsW+yvBs
         orngY/sNl5flhDE/PCT5bsahqVa4TnL+4Ap6nyxeSgTbDGMEC//Vere+Z/dB1xa/6XZP
         ka+tIiXWCAbvHOh/WKwBpEcSMKn0PxprFgOmb/mRa3fMa7KxE7j8ruSpFJX824C8R8fP
         VVUA==
X-Forwarded-Encrypted: i=1; AJvYcCVPcJQwumvyAhikB55+OXN5hbgQ0uztGOWZVz7Jn1RGvsfYimjU+AhGB9eX1P6KAzAWIvpNzCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnavBYoczbnYo8Nxgp6XdkI2WYD6+rl12TdqWfaI/Ew7+vmEV
	ZiQHouabn+4e4ivjcXRgWYsVZMuic/KqYyGjdhekvAjPkC8W9c9QKPGdvCWQEh9JAh/QcV9xhxA
	d2kPTo0MS49AGekoSFnsV2jpwaFQUXtbwCWNyNffaJCjLrDs1ohS08qZF7DU=
X-Gm-Gg: AZuq6aIiN9kdqWi1R9x8EsjhVPgfZ9Uq/3JBWr7mquKYKxkP506fzPg655h/bx9SM2U
	1wSsZDmwJMR4ZQFZA6+V6DptTqsh7PHgdWlHMBC9Ig6csUkx6exxPDpSqrPsKnmllB3xiF9pubs
	//GgsJ9zdpehX7N6ztEHCH/gslcADUTCTOEY/cbgeWhqEoN7cH+mbf7VhqJ3swH7qwrKJ8k/U5b
	zu2WAFd0H1lBkZSm2sHPsHu5IAfTKYexGjEr8LAo637cxu4UFPUg1kO5EGB1AhwovFyK4bh1yxN
	UBK8SQrrQ6qWaCRVzdsGb19oQk+dSKlyIKKzxD2xHkeuNU4mxvRBjdtdYfNUU/f8+i9608ecSPZ
	rUKQNykjyMLbwuq6ZPCLY69KlClzfI5Te9Iw8B8P0KXZysgoA0h0KnptiqaY=
X-Received: by 2002:a17:90b:524b:b0:354:a065:ec3b with SMTP id 98e67ed59e1d1-356a7a88d7fmr9485774a91.27.1771225679369;
        Sun, 15 Feb 2026 23:07:59 -0800 (PST)
X-Received: by 2002:a17:90b:524b:b0:354:a065:ec3b with SMTP id 98e67ed59e1d1-356a7a88d7fmr9485753a91.27.1771225678882;
        Sun, 15 Feb 2026 23:07:58 -0800 (PST)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba9b2esm15634650a91.9.2026.02.15.23.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 23:07:58 -0800 (PST)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Date: Mon, 16 Feb 2026 12:37:42 +0530
Subject: [PATCH] media: iris: Fix use-after-free in
 iris_release_internal_buffers()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iris-smatch-fix-v1-1-51f6b41c43ab@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD3CkmkC/x2MSQqAMAwAvyI5G6gVivUr4qHU1ObgQiMiSP9u8
 DgDMy8IFSaBsXmh0M3Cx67QtQ3EHPaVkBdlsMY6Y7seubCgbOGKGRM/6IbkgjfJR0+g1VlI9X+
 c5lo/eYrwd2EAAAA=
X-Change-ID: 20260213-iris-smatch-fix-68f6a90f9c9e
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Dan Carpenter <error27@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771225674; l=1867;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=LoHMRhwpy4wi9q82FqzTo9evwLCImd3dyKPb99tN/Yg=;
 b=3FOsbON/Coq283e9aOPoX9tQlaJadDzMczfE8St8JI92y3ZuAzdj6Hx0WXGQvolOSw8gZOf8w
 ov9JUvmYPRcCD/om+8BBCZfI6Nd7ZQuU7Ov4nOgSFAatKtxytDFo2Qt
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Authority-Analysis: v=2.4 cv=c5WmgB9l c=1 sm=1 tr=0 ts=6992c250 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=EUspDBNiAAAA:8 a=xD9hxEe0D-iu6yI6bpYA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: kreWGdlLLwGdBZcbN5wI1BLHLiTk3D3p
X-Proofpoint-ORIG-GUID: kreWGdlLLwGdBZcbN5wI1BLHLiTk3D3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA1OCBTYWx0ZWRfX0hHImcTg5pO8
 sBZcqdjFEKFDNXzM6FRXzItnKMPa4mxBQZ89LPyMRkhZNk3K1NR5y31cJkgbz1dUxCqRtUUnmrp
 26UroZOZn4Lr82OA9K69NOt+BSwMVqOOk31OeKj8xvWrWfEL7OgHUYKd3ZMn3b0Sdf2GMkjJFj4
 Ci4SEf3QVAwuhQxv0oJJg92wb8A38Ym/8z9RTU4IHfUxJQqOunLYJjcLoerOVorAbp0l6MleWCk
 j7ZqCvxsZe+KUziEG9f+XGHzPO02KaYGqcsDvhFUJ9/SaFndqtZCxtA5LuxrwMusxp+NuZvmNEx
 2umAqRu0ClTymI198e9rrxf4MGntDBYyHBRKLiv8tbCuFa0f6/qML4R4uSf5reXN1+kuabxMD5p
 d6IFebhzTXI00edDoFiYR3MwWLca3E7Gx/nWxh1UimyGiZl75WjhT9GLSluwDb5CKSw7lTPHdy/
 d+WrnjomxHEg+9yWIEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160058
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-216665-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,vger.kernel.org,oss.qualcomm.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dikshita.agarwal@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 46023141326
X-Rspamd-Action: no action

The recent change in commit 1dabf00ee206 ("media: iris: gen1: Destroy
internal buffers after FW releases") introduced a regression where
session_release_buf() may free the buffer. The caller,
iris_release_internal_buffers(), continued to access `buffer` after the
call, leading to a potential use-after-free.

Fix this by setting BUF_ATTR_PENDING_RELEASE before calling
session_release_buf(), and reverting the flag if the call fails. This
ensures no dereference occurs after potential freeing.

Fixes: 1dabf00ee206 ("media: iris: gen1: Destroy internal buffers after FW releases")
Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Closes: https://lore.kernel.org/lkml/aYXvKAX3Pg3sL37P@stanley.mountain/#r
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index f1f003a787bf22db6f048c9e682ba8ed2f39bc21..fd30ec8e33653bd21d3c4d1057f4f1eea938228d 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -582,10 +582,12 @@ static int iris_release_internal_buffers(struct iris_inst *inst,
 			continue;
 		if (!(buffer->attr & BUF_ATTR_QUEUED))
 			continue;
+		buffer->attr |= BUF_ATTR_PENDING_RELEASE;
 		ret = hfi_ops->session_release_buf(inst, buffer);
-		if (ret)
+		if (ret) {
+			buffer->attr &= ~BUF_ATTR_PENDING_RELEASE;
 			return ret;
-		buffer->attr |= BUF_ATTR_PENDING_RELEASE;
+		}
 	}
 
 	return 0;

---
base-commit: 205697a4aaf20ee56705d7b4771f4081f594e7f7
change-id: 20260213-iris-smatch-fix-68f6a90f9c9e

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>



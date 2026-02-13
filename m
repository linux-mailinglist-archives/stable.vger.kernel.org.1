Return-Path: <stable+bounces-216030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAxHJHLTjmnJFAEAu9opvQ
	(envelope-from <stable+bounces-216030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:32:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A113393D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2B33012260
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C22F28F6;
	Fri, 13 Feb 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eCsJ40mg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vfhn00cW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8B2D97BB
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770967912; cv=none; b=bszzG7A2rCN0E9rAMafvsFv7AKh6348dGDkIsOoqapcff7MW8BBr++RouUqM5Vhgp3R7mmg8GtHSbgZIRy9EEjH0hw1Mid5LZO9kF6uVd2zvl/KO3GHd6h4wXf/WcgwFwYwvHmxc6WqQMc8J0q8h0+++j6VizOKSdbIOP/F7Vhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770967912; c=relaxed/simple;
	bh=Ee1Nf/av7WA7+/1fwJdgqUPEf25bQzrdCmpSHIu/KX4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zkc2S4tf5kW/vIXEsb5tvZkq3quJOdPiCMRJNl5xRFOKZWw3CgDgmb8ZbyLHOr5JLEK37TuBLwvQxFqnyGNryb+ZRrForqWLV2lUTZkc63eYBucaRSbkIUYCPX4u/edv+7flMf/NQuRhbwUP+caEHw9YUfZaZmQf5C1EfZscQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eCsJ40mg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vfhn00cW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D0Bweo2733890
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YWiNt3lTljwCyJwn+r2SC+
	u1cEIq6wj3aixcORgCte0=; b=eCsJ40mglDc9KcSYtFEF8DYVibCDH2dxj8pseH
	XnwS6x9pJkXvTIEzNzGAf+wQoC8KXnTl+Bx6f4GLsi3tvcCZ3IdDdeOPTAqTKhPG
	Kr+nP9MA3wu016S3/KFopK9zR18sVCRqPwatiDSpHJ0g3nXFSTijeUyejVKOr8wu
	O5p1ye9huy+5kwf6fHCSnkQ6NuVujdfX1sZ4+PS335DiAUbYOxCfG8e5PJetaXuk
	zG8rYZ43OWo14mNJ2iLBpyZcXg2qszv/ChJn5anNNgCbLwyUz8NG1Hg+MiZNIXIs
	Vs0ka3xz68S4zCCpywuho0YmPL3sZbaQvpVP14G3O/Ag2BTA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9s6ws9x6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:31:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89700915423so39172586d6.2
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 23:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770967909; x=1771572709; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWiNt3lTljwCyJwn+r2SC+u1cEIq6wj3aixcORgCte0=;
        b=Vfhn00cWv7CnoUaQMwXQYTJGAPZZLRkQdJWNFdD0SE7JdTDG+nRhkWTFg8Jq1klRSb
         CydRSaHAxti4nV70vouV02ubEkNaFuVLXrqSc+7beliSowuWdndIxY+lf84uhGo0lYLC
         GBCGhkKUuFP0UA/ON+oq23N7A9cniR1kKbEe2OBT8hA9xaAFyNs0ch37hG8+ZZHIqWnD
         bo6DuLQVruGSVYPQmHj7ZfmRPIzJ+G5BdUEGJhBRGHQO26LtxoUaFkXzhfFScWNkeT57
         UCmimEhzNEvWNHsw2llcaCM/gUvbNOBXRUIBTi9istmccovDZ+ZIMELpiVzmbxhRWl7V
         ZVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770967909; x=1771572709;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWiNt3lTljwCyJwn+r2SC+u1cEIq6wj3aixcORgCte0=;
        b=X9wylEt9mtzUwYopefXaardVjzGk1DeN270P3T934pJgRj8DCL0zeAhJRd25qwwSnd
         uj5vksJFMsNn3yd2QOHjeRBwTDrfjjNAfc8BtJxuHTqGsoU8GLXBkIcaulPTKjY+t0F2
         yvobcptTqulJ/hlXBYOj7EvwqxFlpouawpA1GeJ6k1V2o0wFNGoA3BKh9ssR1rySxZaf
         aFzILZ3lip7niu0ga244hYocuPV5113f8XXnC+Xd+QL5yRFlTc2nac9UkV0hUY7t1YgZ
         Dh6xN0bbyonnG74F7joDyAxgtKDyHTeQvsWKQC6WGlwr28YXP0RJg/M2l+ZW7L+k1L86
         6ZiA==
X-Forwarded-Encrypted: i=1; AJvYcCX+B7qUJhH463rL7X8GyQrqt8ofbRt1TleRJ6xBCCJT4ChYM6DUFNKvS4LL3mctX3rcWR2IOIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4NIzrDQDgDYHNxhlMF+kJKoZuiz1vL2I8D8ADIro9eahjmeq
	DmFrR/33PsM4dXXnymwlbO6VTPTbiqX0OUWTWvz2KpV+QXPYX+kS+fyPbOOFyaFDaRyA3DxA293
	rBAR1/E3ZwY7gMYt3h3KEe0PlldgsGNuPwHS4RJvycJquIgu6qn3cTtepBI4=
X-Gm-Gg: AZuq6aLTSnj1HsLxZH7W1gXgE8SmihLTQ4yQ+FDiMDsERE77PtD2yls3EG+mCkhbPlC
	VyHJWNJw2tAVdKecSASlb1Ct8Im7n1oi1gjrQcqhgGuFmGyTnvLmBe5q/KOmvbPV+wmFfVT+hPg
	8arf+KDP48F0imxxVaJ6Ly5nJATgob+RN+Z6TxyaeLoEOwXsrfdMGdoBzJ27Ksd0ZgLZTL0Efv9
	LbG53172+Je2yfsKhhjpg7x0jiiCZJsg7Kj9H9LGzEnikbsv7WJ6F4xE0TcFmE4cKo7GIG/rkua
	nq4vp4lq1pg8U5YrRGvOLAL0+wCkrA2xasoLd0av8gwkv0OQB/QWrHFLIZOBMdmOQUWBWMNiGbI
	udW13fV5WUGsgMenMMgu10GwwNcUFRuMmq3167ZuKLzh+2jwVbNHn6MuW+SBuCKdjRzz0s5hXkq
	8J7tjOGFk=
X-Received: by 2002:a05:6214:c28:b0:895:4852:ef4c with SMTP id 6a1803df08f44-897360d0142mr13356686d6.23.1770967909131;
        Thu, 12 Feb 2026 23:31:49 -0800 (PST)
X-Received: by 2002:a05:6214:c28:b0:895:4852:ef4c with SMTP id 6a1803df08f44-897360d0142mr13356346d6.23.1770967908679;
        Thu, 12 Feb 2026 23:31:48 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0bda6fsm541156485a.9.2026.02.12.23.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:31:48 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v2 0/2] phy: qcom: edp: Add DP/eDP switch for phys
Date: Fri, 13 Feb 2026 15:31:41 +0800
Message-Id: <20260213-edp_phy-v2-0-43c40976435e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF3TjmkC/2WOQQrCMBBFr1JmbWSSNNW68h5SJJ1MbEBtTWqxS
 O9urEs3H95nePPfkDgGTnAo3hB5Cin09wxqUwB19n5hEVxmUKgqVGgEu+E8dLOQTFazw11JCPl
 6iOzDazWdmh9HfjyzcPyV0NrEgvrbLYyHwlPJtaRK14TW19pVmrQzLSFzaYw0zu0Mlha+ri6ks
 Y/zOnKSq+xvzyQFCqXlfq/a1msvj31K28fTXr8vtzmgWZblAz44qj7xAAAA
X-Change-ID: 20260205-edp_phy-1eca3ed074c0
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770967906; l=1469;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Ee1Nf/av7WA7+/1fwJdgqUPEf25bQzrdCmpSHIu/KX4=;
 b=Q4lMX6lMSQWQ96OG/ex284RSApliZ1e6b4i6Q+6+OsMsZ+TFmkj0JPXzDHTwwl5rKIo8Ixlzs
 K8nx8mIlsdvBJ2Vu351GG5xeHboHkQLfqEdll1hNwUNefatXjWJq8k2
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: fw5iXu7rkQ2uaPNjPlETufYdT2wYmAY6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA1NyBTYWx0ZWRfX33dnwWfUEmr5
 kHhqGfmVHe62z6TVXojjAmMFhyrVFwtYGVwwaw73WUChP1hA5l9whIicF5mTt3nbtSF7qSHpbIK
 62mPRppVFyQ3M7+y1tZGd3xDeX94eVwzCW2Xqk497H7L1sRUacBserrFIEPUPq+U45DAToqsBfc
 gKz7a11Di8SkppVcQwU/DgFGkAldAHUcKxclAKAJsojhHtuQExsf+C1wImFR176bLWPGMMG/cJV
 BjhHAzqvX9ZTpiFcY7nGTf/rINg1egmwExzemNt8dmwpEDq/cuGQLHnMpj7F+BlZBT96mVqlr5p
 hrYPiYcjfb2RXI/WKa6n0QMKnqRLKdIDrJff2z2wBhN20uGbpJ0xzpF76SXzzOyonOmW67CEk33
 StryVlXI2hy/KnNdNfTBKnOiJ5ADlCVmAEXyKtHA3J5a0i4n4JBwZDwHLn231box0TalVl1NU8w
 kCG/2EJNMakNNtPaf6w==
X-Proofpoint-GUID: fw5iXu7rkQ2uaPNjPlETufYdT2wYmAY6
X-Authority-Analysis: v=2.4 cv=CLInnBrD c=1 sm=1 tr=0 ts=698ed366 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=M-2OMZX0rM6BGFiE4MwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-216030-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 173A113393D
X-Rspamd-Action: no action

Currently the PHY selects the DP/eDP configuration tables in a fixed way,
choosing the table when enable. This driver has known issues:
1. The selected table does not match the actual platform mode.
2. It cannot support both modes at the same time.

As discussed here[1], this series:
1. Cleans up duplicated and incorrect tables based on the HPG.
2. Fixes the LDO programming error in eDP mode.
3. Adds DP/eDP mode switching support.

Note: x1e80100/sa8775p/sc7280 have been tested, while glymur/sc8280xp
have not been tested.

[1] https://lore.kernel.org/all/20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com/

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v2:
- Combine the third patch with the first one.[Dmitry]
- Fix code formatting issues.[Konrad][Dmitry]
- Update the commit message description.[Dmitry][Konrad]
- Fix kodiak swing/pre_emp table values.[Konrad]
- Link to v1: https://lore.kernel.org/r/20260205-edp_phy-v1-0-231882bbf3f1@oss.qualcomm.com

---
Yongxing Mou (2):
      phy: qcom: edp: Add eDP/DP mode switch support
      phy: qcom: edp: Add per-version LDO configuration callback

 drivers/phy/qualcomm/phy-qcom-edp.c | 176 ++++++++++++++++++++++++++----------
 1 file changed, 129 insertions(+), 47 deletions(-)
---
base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
change-id: 20260205-edp_phy-1eca3ed074c0

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>



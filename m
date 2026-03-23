Return-Path: <stable+bounces-227941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KXLLZYPwWk7QQQAu9opvQ
	(envelope-from <stable+bounces-227941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:01:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A74AE2EF943
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 633AC3012BE3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482A5389111;
	Mon, 23 Mar 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozAFeuEd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUY/m+Ez"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0E3890F0
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260086; cv=none; b=lbjH1lvJMVmIATnr5MNWUUOUNyq4u+XY32cSZmbF4PO0tbAsJEa2qn6riwUEXsTiiJQ70FdeDdITHchjlpynd7TU7CeAxOoIdP50QR55V/HBUU73A2Dv6cwQKLvVvpBVGDauYGxA8kW4x5m1Hrp+GLtMQ0E9ELuGaTOw59QA82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260086; c=relaxed/simple;
	bh=CvsF+XgmWtypUhCbqoQ+NNzsnZNfTjXaguT9trPTRgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q9sAT2ad4xoTSAdC5prDE5PILNXlFKgBrWga/FIwpa/XwIMa18LlkyqwNBZLI7lBNOccAk6cjMGZr0gUXDgNsWnK66KJw3RSkBxf7h/D2xs2UTVLYIAGAQ6BSzZrPaKRGJ4gHdGE7+1cyYB+txCF0P70PiyEsJArpUpNMekZvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ozAFeuEd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XUY/m+Ez; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7GHpV2512671
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Eih455ltrzNwTouwaHGU/6
	lt1O9gHr/UXlMlv+6lcy4=; b=ozAFeuEdQpJgNGD1FN+ksBhr7TwqCoj0eFctOV
	CDLTyPmhN2/eXD6ULZcLq+FObEu/70FbXdkyhduQx8SkSztYQtSx3Ff9P4yAusTS
	CmULTQgKKFQyPPwxk1IWGniEBfjs4jP6kkVroGySka870a/yANtO6+ItRKeCUlzd
	0bAkOoCl3AS1VOkdNSUWxqnQHWaGer8nK7UkP+540cko9XZ3DnTQzEOK0B67aKTk
	3UEiN9hi6+p9kKkk02mxJVYjvJzjxHCDN4tB3RrVuNIV4hgmTODKIKo72yC2W87k
	JK6WlhG3GyHm8odSSUbKugTKqg1l7a6/trSP/tqSkyHAkJrA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5mxbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:01:22 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ffaf5b522eso3640985137.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774260082; x=1774864882; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eih455ltrzNwTouwaHGU/6lt1O9gHr/UXlMlv+6lcy4=;
        b=XUY/m+Ezxlgvw6Xka67QYDxhnpYKWHjrbWRgQ1FMcX7/q/l23/NFw0+EQj8+inHpvU
         NSMUDGL6OYFLDevwtXGWSprokvB60CiaP9tTIoeXBcMCOk+kZG3NyC52ASZeHX18L3Xd
         tS5zAo7evhnZR2NMvRWqrIYBdsekpemWibk688iV9GMy+Z99i51klnoIbglEW7EiVcgH
         EiVtIAmgXqbZUbgvjljVjtftVvabjV/tbqNdwDRsWlc5T8y6MEH5jDVude8M+I8jDX/g
         uXGPQst46hXcZbh27urS5eJ1xfMRyU3IWZX5BqKG5Fm3mhIDr9t/hgqQSr6u8unZEzpB
         WJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774260082; x=1774864882;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eih455ltrzNwTouwaHGU/6lt1O9gHr/UXlMlv+6lcy4=;
        b=OzL3zKzxX+kDG08ajbkkH7iIRxyKCQRf/bn3ne8kuE/jz43Ax8IqFgm90EWx03wqk0
         8OXO3S2KjTW70S2yLXHZN5n6KQpzgZvv5J71BFGtHAC9u/d+w3ecJNuJop+2XkatpsRt
         dUFgPlKI66WSe6Zk07Fuyd0MB3e9K4b3K0ukm1NuREYRMRVP3MI59KuoFityp+Bwyytu
         DHav/dxMlRmy/rPjpf7rf6ghHJYlLoAWp1uWdSmqp/KZfNbpMkjlpn4511k6Zv7gEV+k
         5I0xR8XWyDKSW9H2iFkIrtfI2qhIMaFkP9O4HrLjKkuMfzrljGPaqaChylIrZETsEAes
         yIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0QTPdFCyYcy94MGEM6VV1vSP0F8TcPUwU6B/mx1sxOjPKrlzEAgO0z0RQ+B6TW2T2zesdak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVphqBJ/S6j3BwHX82CKWYvuBUv/fO6ZestsfXGk8MraCn2zOj
	BwAEic09Oxtw1xIvm/vSaalo4MpVzSWIoxbVkkwkMyQvpb+2X0s4GHGGEb/NARAQwlf6B2Gr3Kg
	JsYioeJeTY3TkOJZM5BBQI/yOFq2A7DG9NJdf3Dho9pDtxad9TxFmoxyEytk=
X-Gm-Gg: ATEYQzzmyMwlWBa66vLWO+2g4umRvxQtz4ngvd2XvFyS323tucGC+dbi9CxrIY3uPuR
	REHU9GCMAXZ10WeGU9QeWWB1WxFYXXaFISUvTCRUewYhB86pLj9PTOv0849QZDgstB7aEgl83Ay
	zopovgSFGTNLU+jAGPpWEyLM+worXmTA2cgAT8pfaq9/WQEGTbZDp/+GbG9C9szSKKczj4aFViW
	SnHSoQfeR/L9u1Qz3QCzVdWt0dkxSuQUQ+Jl0J1sXA7PWcnpakmQqLCc6Me7rAKQFQMpLvwhYrd
	iczqINL50nB90QbehYN4c8UI3vgB2NNUt+mXGmfoO1bKnb/gd6oNJ7vCzi1DBPjbez4GaXXhZWZ
	hlsKbnHLUJq4NEUAiOUU/jNGP9pE=
X-Received: by 2002:a05:6102:d86:b0:5ff:c510:b7cf with SMTP id ada2fe7eead31-602aed238c8mr5402318137.29.1774260081568;
        Mon, 23 Mar 2026 03:01:21 -0700 (PDT)
X-Received: by 2002:a05:6102:d86:b0:5ff:c510:b7cf with SMTP id ada2fe7eead31-602aed238c8mr5402238137.29.1774260080908;
        Mon, 23 Mar 2026 03:01:20 -0700 (PDT)
Received: from hackbox.lan ([82.79.95.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4baesm526693675e9.13.2026.03.23.03.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:01:19 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 12:01:12 +0200
Subject: [PATCH v3] arm64: dts: qcom: hamoa: Fix OPP tables for all
 DisplayPort controllers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-hamoa-fix-dp3-opp-table-v3-1-a823776bd1b0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGcPwWkC/4WNyw6CMBBFf4V0bUkfUMCV/2FctGWQGqDYQqMh/
 LsFNy40ZpJJbnLuuQvy4Ax4dEwW5CAYb+wQAz8kSLdyuAI2dcyIESYIJxVuZW8lbswD1yPHdhz
 xJFUHOMu5KmUOXGmCYnt0EKHdfL68s5/VDfS06TaiNX6y7rlPB7px/1cCxfFkSTNaF7SpmpP1P
 r3PstO279P40DYW2IeOlr91LOq4ELwQBTCmyBfduq4vrRfD/SYBAAA=
X-Change-ID: 20260309-hamoa-fix-dp3-opp-table-453b8a5e3bc0
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-bc6c4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5666;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=CvsF+XgmWtypUhCbqoQ+NNzsnZNfTjXaguT9trPTRgo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpwQ9odG7dHPi7nZz086qFqwDsY/d+M014XsY/j
 2hlW3JzqE2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCacEPaAAKCRAbX0TJAJUV
 VrSsD/0RfTAMJKLu9uwxuDupulKBjSpR1lz/eRLz+sf9FBOUinz/xHpkFX4y2XPIvfmOwBWdZ7O
 ou7DxrWxw4eUBHAocxM5b/qwD/AxUiESMH7Aysr+tfriR0nJYCm+7QRsri+3jnkC/9x7HLXVHla
 d0rMyg65AtkX4Hcx/Nt0xdaLrQVpW0oEBVj7oXIpd2vstT/oLGPFc6Jr/f8CH0eyEdmkFw9uuGw
 M0MOmJb/Rz2iL0+xI+XUHZNS/huvGepyhIKj/rNzAhIsR9HyZG40rHbuaV3DTvHxFw39TXo5t/p
 cfybW+gB2Qgp34Jz/LKH3euFhlrD4TXVZtuF7rhi5B14ykB/FqqvaGls/8P4ZHz/0PKEOiUg1IF
 +He1Lgk28Ecpcwb6Ks7/HbHNXL9nzRD4jE5m+L8qtXeBHQG9pg6x/dn2SapcoUjo4gdNNmcjEzu
 5GE0KT7R+S0dWz6XF/lFeQc5k7llF5h0Do7FIRir2zcW7hwCCUGY14rHXWkoqlkDJnwAtpNVGn8
 CYuFCZIg1AL0rQ9qyyzDs54ufoyUFrBooJPnv7Rf/j/M88+4AjANrbn4SMYBHnJhjrRo1+KyfC/
 Lr1Bixt9Eb8ToeW4m3+EqGZb88muO/JWTtqfNw1KFb48sMxvk4hMfckXT7HxUl1ljrvneamhjwb
 +Ekcxjg12EtuL9A==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c10f72 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=iKs3dpp2RB4k51ZqCjcyjQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=d4EVK6T340-jQqwUKIwA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: HkKYtV2EWc1IXCU19AKWAFEF3WId8yrK
X-Proofpoint-ORIG-GUID: HkKYtV2EWc1IXCU19AKWAFEF3WId8yrK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA3NiBTYWx0ZWRfX7euCgMidGpk+
 Rdq7gpF8gHl/wslH5opGQu3XF+da1WGBn0Q76hMJ7LgXrEh4yTtDVf9IWDG4lRZ45JWTPON6OEq
 i+lkoc8YO6ScVE+ClLc4a8sqW2xKNrilLFoL7VIf1DJLgRoSEGpUPyOxNsnsDvrFQEJjchEuw8a
 fA2xRqLIewjswTxUGwSjG2L1Yl+f30cyB+Fs5sOAnfDSVqoUf/Jx+bPYW0/0AVZvRaSdTLYVFju
 6+EToGsy2M/Zf1mkEn8BB5UsHgr9WLRjkK+1uO+9C0jrVUtZ3+ktYd/fhoGRcWF7CrdvOhBax/j
 dlzWF+Bu0N+aoiZ312RPcJp4s7fs01NCDJlKNuR7F3XQmmbCG+914Iwbvt6qhYEQT5Tv2snmGlo
 +6qdjPJdyAN6SzRWu3Z2Du3OK7xOdHVQX96GQ7a8f/GXatWDQWLNIpGarmUiGsS8rsSHFYeteRa
 Y+yI4YrBpPs5PDGAfKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230076
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-227941-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A74AE2EF943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to internal documentation, the corners specific for each rate
from the DP link clock are:
 - LOWSVS_D1 -> 19.2 MHz
 - LOWSVS    -> 270 MHz
 - SVS       -> 540 MHz (594 MHz in case of DP3)
 - SVS_L1    -> 594 MHz
 - NOM       -> 810 MHz
 - NOM_L1    -> 810 MHz
 - TURBO     -> 810 MHz

So fix all tables for each of the four controllers according to the
documentation, but since DP0 through DP2 have the same entries in their
tables, lets drop the DP1 and DP2 and have all of them share the DP0
table instead. However keep a separate table for the DP3 as it is
different for the SVS, compared to the rest of the controllers.

The 19.2 MHz @ LOWSVS_D1 isn't needed as it's not an actual working
frequency and the controller will never select it. So remove it.

Cc: stable@vger.kernel.org # v6.9+
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v3:
- Rebased on next-20260320
- Re-worded the commit following Dmitry's suggestion.
- Picked up Dmitry's and Konrad's R-b tags.
- Link to v2: https://patch.msgid.link/20260318-hamoa-fix-dp3-opp-table-v2-1-3663767e22b0@oss.qualcomm.com

Changes in v2:
- Rebased on next-20260317.
- Dropped the DP1 and DP2 opp tables and used the DP0 for them instead.
  However kept the DP3 one in as it is now different.
- Link to v1: https://patch.msgid.link/20260309-hamoa-fix-dp3-opp-table-v1-1-1a8141d71f9f@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 77 ++++++-------------------------------
 1 file changed, 12 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 0efeb7b7ff03..079bbc62c475 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5670,18 +5670,18 @@ mdss_dp0_out: endpoint {
 				mdss_dp0_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-540000000 {
 						opp-hz = /bits/ 64 <540000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
 						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
@@ -5722,7 +5722,7 @@ mdss_dp1: displayport-controller@ae98000 {
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp1_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -5755,30 +5755,6 @@ mdss_dp1_out: endpoint {
 						};
 					};
 				};
-
-				mdss_dp1_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
-					opp-270000000 {
-						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
-					};
-
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
-					};
-
-					opp-810000000 {
-						opp-hz = /bits/ 64 <810000000>;
-						required-opps = <&rpmhpd_opp_nom>;
-					};
-				};
 			};
 
 			mdss_dp2: displayport-controller@ae9a000 {
@@ -5811,7 +5787,7 @@ mdss_dp2: displayport-controller@ae9a000 {
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
 							 <&usb_1_ss2_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
-				operating-points-v2 = <&mdss_dp2_opp_table>;
+				operating-points-v2 = <&mdss_dp0_opp_table>;
 
 				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
@@ -5843,30 +5819,6 @@ mdss_dp2_out: endpoint {
 						};
 					};
 				};
-
-				mdss_dp2_opp_table: opp-table {
-					compatible = "operating-points-v2";
-
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
-					opp-270000000 {
-						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
-					};
-
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
-					};
-
-					opp-810000000 {
-						opp-hz = /bits/ 64 <810000000>;
-						required-opps = <&rpmhpd_opp_nom>;
-					};
-				};
 			};
 
 			mdss_dp3: displayport-controller@aea0000 {
@@ -5930,19 +5882,14 @@ mdss_dp3_out: endpoint {
 				mdss_dp3_opp_table: opp-table {
 					compatible = "operating-points-v2";
 
-					opp-162000000 {
-						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
-					};
-
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_svs>;
+						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
-					opp-540000000 {
-						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
+					opp-594000000 {
+						opp-hz = /bits/ 64 <594000000>;
+						required-opps = <&rpmhpd_opp_svs>;
 					};
 
 					opp-810000000 {

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260309-hamoa-fix-dp3-opp-table-453b8a5e3bc0

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>



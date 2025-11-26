Return-Path: <stable+bounces-196953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB1C882D3
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78FAF3533BA
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 05:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEEB31194C;
	Wed, 26 Nov 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nZbjw/3h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="euxKxTDf"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A524C9D
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764135753; cv=none; b=b3hOtxCKWT5nA2yXUjRLUyXknY5ObeA7v8YYQ3/9X3sedWy6bNLl73kap8l+LcFZwFTdqnLEcQf6AOY+ZB/z6irRs2gP7BO2A8G/5G5YaLgBZKi57RqDnp7k+aavHIU87yr9qzTOwfWOj+/V9PTF7wf9wzWy9u0b1kB2bJdQR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764135753; c=relaxed/simple;
	bh=ZSGldPpQdBPeyeRPvxMinYAqNZms8SedzpBSMlb71HE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PI3cDBwzZxNR3G64OBKVP9uYD9ZNK3pJCDDdvlzhQa5aXn525uDoU5eBxqvusQzS2zgXF3zqrjSvLy8iXnTzsRJ5UxqZggcttdUzFt2DXFLAT9sBKY2JcjeakPhlqD45L0jCjHD+nn/wSHXPNUPMqeej99f0D3vRZaxt673EYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nZbjw/3h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=euxKxTDf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APLV7iC3666218
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 05:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=c5wgl6eITJ72vHqJebcqGjx0u//2f1FOVM5
	I9mWULoU=; b=nZbjw/3hvz+mOK0vKXZI4E1sC73al+Bf4UxEh8Pv3QOPpQqP3nc
	I4Eccng1gU1XN4K0DlY4WeGPH4MnKflF0H+Yw16mMrahQ4nAWJ80GbM2rSg8b1o0
	cIdKxFIytCp0KxbU/zIysqr4wXCc4mXey81wK9qCyBoLFHCyiH/9ckfNDzqPJfmn
	Xr0IbDqbqIGSt2UvV0q3SsaElef7YTLHEfoXs4WHBMD00XiFLKtdtg0B0voT5O5c
	qj4QfyvUs/TakcbTT91fIvAtwRNw67niYwmLYDPZttHzKDglWVvqlmsAt9vAgjRa
	gw/EdVsnBWZX/pjtd7htb6KlMXxlm7ts4Qg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anmemryb7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 05:42:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297f3710070so149902035ad.2
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 21:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764135750; x=1764740550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5wgl6eITJ72vHqJebcqGjx0u//2f1FOVM5I9mWULoU=;
        b=euxKxTDfXta63r9zWU97m5I+BPzaWZL8RnMYsRNKndF2FjVfL5QRxDsfwWE6jqsKA7
         i5HL9Df7gvNSiJkH06KZ+3T4DXtNs1u+vdee19Gzb6KMrPGnllhGJCsUmNw7a537V8Ji
         976ipR3Qn/PCtqGu5VcMIhTyFaj6HV2kKF/82SnHmCoeW29ITuXN2nVdwEl19J6uO/ko
         HZKax896s2li+XBXIV3rmXPLxrSLlBi9gahueAmqZIJ/zZeP5ZGwhWMBGgClr45mS0pZ
         pHXEyX4LfdvalYQiu5TtqM6RA/CyXef2wjCdOL4UVTJWF2RTnoo73P3aYFHjoPowbbnw
         lOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764135750; x=1764740550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5wgl6eITJ72vHqJebcqGjx0u//2f1FOVM5I9mWULoU=;
        b=OMt15AWQlqOG8dy0VRKwWRu/F4DvQ7YxyYg/eMrD96yWpZ+++GNqLkYBwD9h9HPDX5
         FWsLnBTY4d8O1OkYINu2AFKnPF/kh8I1lqVGn5AJmud2YxiNlvj/J+oZ9Cp3tZD5dK6U
         7EBtL/Nd94bVSDQsoxv4+zN2j7nyP4fMTfDOlceuC6mHCyYdieBVzMZAsFEdnNMG30un
         phW8zissu3eATzn5c/zmbHVwuY/wnZisFyFSU4R9T6N2GHpS9cHm2UNGSC0z03w+Xu/Y
         47AsvJ2qcrsmf4quUnlg0wU+BePTx+v1K9tvZnyrEjnYiWm4AolYADViYsq7hDUDVeiu
         GNrg==
X-Forwarded-Encrypted: i=1; AJvYcCW7RYzQeSNQkgBDUvUz9Ji8Xr7YLwGEpZAY4IXgDEriDuq018ccVdBHEDQlFxup5ZECzi9WHkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNVdrbZwK9RZpa1uEOmuAKf08BfGE3Xhyx0MD00pk6NSDrU7w
	n/Kjjx+/z0ypxKYvKEBhndxgkCsZg+jNyv5qwVjEOlUSig1g7BUw2d8JuBNDi+YDB1tFFvykjw9
	6B5ZxkjqcHWuDr/djMCfy7Gen/i5o/ykiy9hSGWAkyAo1LIzYmoI6IIzTiQw=
X-Gm-Gg: ASbGncv9ryOFvDd2AnVcfvlKXVVbz5mCp4CIye8hj/IJwPyvNLyAQqa3SuHkkqKlP7W
	9Nr9AazcmpLikKknUWglra55AmshbiLUIF73BvBa/lxkd9NQ9AThRbjBTRoHpdnVtsv9bImgr9B
	LH5qgsY8ib4EHSuB0uKaVz19oT+g42lkm3rA8P213Reem57vG1qKwNSSJ9Eefo0aOtctc/KzJOQ
	3mk628vi6zmAtIrgWnWZ5eGE0cmQRgA/oeoIFzRY0eqfX2dOvlQGVO4DD6s27y52F/wZhF+shKK
	du9gFIFTAvTcNE4otytHd7Hb0qxyNdAddnzUTyxCGOnixCA2hWEpF8JEhlIe7ulGo8+z2ilaknv
	c2JjQUmXFD96Qx3zJqe8Zpax5yedRGOeqM1DL8+O+OZWT
X-Received: by 2002:a17:902:e545:b0:295:8c80:fb94 with SMTP id d9443c01a7336-29b6c6f1516mr186031305ad.59.1764135750479;
        Tue, 25 Nov 2025 21:42:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJJhXiScgCSr/ZzsfIwxpspEZaHpOeDfSLmXRjvd77UkstRH1vhvctykC6KseW7LJ4BjfKjw==
X-Received: by 2002:a17:902:e545:b0:295:8c80:fb94 with SMTP id d9443c01a7336-29b6c6f1516mr186031065ad.59.1764135750046;
        Tue, 25 Nov 2025 21:42:30 -0800 (PST)
Received: from hu-ugoswami-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b26fed2sm187048575ad.69.2025.11.25.21.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 21:42:29 -0800 (PST)
From: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
        Udipto Goswami <udipto.goswami@oss.qualcomm.com>
Subject: [PATCH] usb: dwc3: keep susphy enabled during exit to avoid controller faults
Date: Wed, 26 Nov 2025 11:12:21 +0530
Message-Id: <20251126054221.120638-1-udipto.goswami@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: m3QMltXQcEdoDRQp1OAkUgAi22lk7Ncv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA0NCBTYWx0ZWRfX01Lg8MrDH1ps
 NHZjwe5nih/OVSC2KscST+ilcK1aowmqj8rb/QCNnjFTawxpdYsLqKggFkb8+49EMKEkZwiYQng
 7EpAXOWX1yGYvFUeQfyNG9jaVWJVDt8GVkgFhEpNr86OTdNkuWUMrZo98lNhCg3K3DobrPKvpfe
 nsIC7eWLj66d0meoQh4ai/INyvSO+3Tra7ko0tEUlbdTFX+Jnx6FW+339j4YT9Ng3zxeW6rhrSu
 LmbaF+Ce1HxYq+DvQPu+xc5+/Jm3kIZ/1HCrp2elCE8Rvq5jsFM1giDXwdbIG4iBDlZi5wGecwu
 kr/FvrCaZ8p03yB4qp+uJy5EUS2p0fB/+w2Tm6ihPfBUOu3Y/tQmhZvSXQhzDbXyNcB++1XXUB4
 N7w/Nck4OHz7QMiKSlKy0M+oKG5c2g==
X-Proofpoint-GUID: m3QMltXQcEdoDRQp1OAkUgAi22lk7Ncv
X-Authority-Analysis: v=2.4 cv=bZBmkePB c=1 sm=1 tr=0 ts=69269347 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=EUspDBNiAAAA:8 a=Ge-yWl1-5HWGKH8EmegA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260044

On some platforms, switching USB roles from host to device can trigger
controller faults due to premature PHY power-down. This occurs when the
PHY is disabled too early during teardown, causing synchronization
issues between the PHY and controller.

Keep susphy enabled during dwc3_host_exit() and dwc3_gadget_exit()
ensures the PHY remains in a low-power state capable of handling
required commands during role switch.

Cc: stable@vger.kernel.org
Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 drivers/usb/dwc3/host.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 321361288935..34c5a4de612e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4804,7 +4804,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
 	usb_put_gadget(dwc->gadget);
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 1c513bf8002e..0c171118bd55 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -223,7 +223,7 @@ void dwc3_host_exit(struct dwc3 *dwc)
 	if (dwc->sys_wakeup)
 		device_init_wakeup(&dwc->xhci->dev, false);
 
-	dwc3_enable_susphy(dwc, false);
+	dwc3_enable_susphy(dwc, true);
 	platform_device_unregister(dwc->xhci);
 	dwc->xhci = NULL;
 }
-- 
2.34.1



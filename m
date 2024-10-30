Return-Path: <stable+bounces-89329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E69B657D
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAAD1F21FBB
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45AD1EF93C;
	Wed, 30 Oct 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uUqa9uOn"
X-Original-To: stable@vger.kernel.org
Received: from ms11p00im-qufo17291901.me.com (ms11p00im-qufo17291901.me.com [17.58.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC95286A8
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297934; cv=none; b=mkEadocpn/+OqSkoZ30+JQKodTRFMWn8vy0KW1TN5pVP3/Q5tjXjVAjnDSf5txzavo7kNQDyF6YHUXHuMT4YY2BezvWrHEHgO/M6i6TtdqRGR4KJEoMPXtGfJ6IafuLPIVPMwfuOy+h6OVkaVy/DXYbJYpeat756AVf3XyQs3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297934; c=relaxed/simple;
	bh=RrZ9/uO0Eg3nRmr5KK25E79bk/S1zIv/0ldOUmbWK9M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fxJUL7AEdM29DN23y7/oxm0lLafY6UmE1mMWx2iMtPvzg3OeWanaeGf+VmuVeKrAeYkXZ8uF5bNEZgcQeneR97A1HpTxwq1ZTLmlNoO8hl8YYkwkJz3gC4s+7ffVeT2dUP4YgMxofDwMCZnBiJdhQZ6E07Rhr+2VgR99v+rh9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uUqa9uOn; arc=none smtp.client-ip=17.58.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730297931;
	bh=A0FjAboQMvWQEwQxQlDsfwbUrI6ArBb/7lMBqoOc/vk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=uUqa9uOn2LYsDKt84Ak+9ii74t8r31TCJ9Rn5OCZtzlKGBTAl3piGlnbW/At1m1A4
	 DH9ttyi6mQhOuIwfv/RoYXRVh3SUKlDHQiTwz/sWAdRJdh20gzmdHJTKurIsRG6JD7
	 3jdbPqyVMCKbl54XoCO2pJJbqdcWU68l8VI/bAMmACHzv0RjRt87XCbQkEaCgbZAxl
	 0au+S3gaywbC2RYnQOY8h5TjaoqDwD1uHMovjxmt/q+Gwm482TTfOMSG8j+uRpyOD7
	 pFwFXIa84Dj/hYyFPBwEVv5LlAWKiBLMFqRGFnEFLSxV8Q0oqqWH30DAgvEj3B4mDC
	 grfnjiOjGfXNA==
Received: from [192.168.1.26] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id AA92ABC001F;
	Wed, 30 Oct 2024 14:18:42 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v3 0/6] phy: core: Fix bugs for several APIs and simplify
 an API
Date: Wed, 30 Oct 2024 22:18:23 +0800
Message-Id: <20241030-phy_core_fix-v3-0-19b97c3ec917@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC9AImcC/3WMSw6CMBQAr2K6tqYfpOjKexhD4PVV3kKKrTYSw
 t0trNTE5UwyM7GIgTCy42ZiARNF8n0Gvd0w6Jr+ipxsZqaEKqRQgg/dWIMPWDt6cdSNLfe2PVT
 OsJwMAbNed+dL5o7iw4dxvSe52D+jJLngwlSiVM7YxsjT/UlAPezA39iySuozL35ylXMHAkptW
 wdOf+fzPL8BLUBLnukAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Johan Hovold <johan@kernel.org>, Zijun Hu <zijun_hu@icloud.com>, 
 stable@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: WLAiNkZScdIytT8vNc4q0i79dFMb4KO3
X-Proofpoint-ORIG-GUID: WLAiNkZScdIytT8vNc4q0i79dFMb4KO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_12,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxlogscore=684 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410300113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix bugs for below APIs:

devm_phy_put()
devm_of_phy_provider_unregister()
devm_phy_destroy()
phy_get()
of_phy_get()
devm_phy_get()
devm_of_phy_get()
devm_of_phy_get_by_index()

And simplify below API:

of_phy_simple_xlate().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- Correct commit message based on Johan's suggestions for patches 1/6-3/6.
- Use goto label solution suggested by Johan for patch 1/6, also correct
  commit message and remove the inline comment for it.
- Link to v2: https://lore.kernel.org/r/20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com

Changes in v2:
- Correct title, commit message, and inline comments.
- Link to v1: https://lore.kernel.org/r/20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com

---
Zijun Hu (6):
      phy: core: Fix that API devm_phy_put() fails to release the phy
      phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider
      phy: core: Fix that API devm_phy_destroy() fails to destroy the phy
      phy: core: Fix an OF node refcount leakage in _of_phy_get()
      phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
      phy: core: Simplify API of_phy_simple_xlate() implementation

 drivers/phy/phy-core.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)
---
base-commit: e70d2677ef4088d59158739d72b67ac36d1b132b
change-id: 20241020-phy_core_fix-e3ad65db98f7

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



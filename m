Return-Path: <stable+bounces-91670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A19BF1B3
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF082B26021
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC116CD29;
	Wed,  6 Nov 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="U2HlP0FO"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F3920408B
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907018; cv=none; b=uqJRen7fVT16p6IJjSBYN+YgPU+Ze9eai/U+Uv4ATzrRyEL+80zldWYc0+WmbxEplxGpKXpFZoW1nNi0iNw8X8A+iz9CPY942ApDggre8gE6vgVqIB3FbRFOgxdVluw0Vw2iKJTrOpEITbZzA+kD4+o/63P+Yi6RC/BDaLXzWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907018; c=relaxed/simple;
	bh=00aCZaEgKX49InuI2Wz4Ia5BrVaLeMvdbRK0fwtEDHw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k/nq6mxGV0Z2yLuqdfj3tPF6Doul1tMOcs2WD0YaXEZuzhVtcADK4+y0H4PsVj1UFs9P1rnvFAjasY/zW1WVlJ4RjXrMH3QH6hdu7Sgdj166y3xZDCvLK3U5Rrvb+GP/FpCtIivSzJT9MDDdVffAi1RI7Oy1rKigQXK1djHYZ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=U2HlP0FO; arc=none smtp.client-ip=17.58.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730907016;
	bh=9eytiettMDhdC8KClvem5ox8R3+qJ+lmrR3oHAoZJTk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=U2HlP0FOw0C7Foy4fFddII7vT9yZUGHs5juKNGfsvUHFTqdo1AlmtktwHmYwRhJJ6
	 CHpezPFxBpJ/V7ZevS8nyjkRMJ1uauuo/GeJtBjfHCjQTjtdG6BwI02/pJP88iCIBd
	 u3q8r63SL52Gjkbw1KJsfdC4OMMImIGXfhvZ4q/DiyGoZqqY+b0DZWOhQHEgjGgY+p
	 HIqPGhwpQhJQJrgBK6wOpkzdLhBWmFBMOz+2BC+VLFIljgebdZjZ3e3SQ7C/AajN7o
	 LNetWkGlDRb0Fpsf6ZAcoJya8QOJDz8JMbFD77lSmJDy3BRuj/7x9zKi7VOiSKGHYb
	 WkgbFyxinRQ8Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 918503A09D8;
	Wed,  6 Nov 2024 15:30:03 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v5 0/6] phy: core: Fix bugs for several APIs and simplify
 an API
Date: Wed, 06 Nov 2024 23:29:16 +0800
Message-Id: <20241106-phy_core_fix-v5-0-9771652eb88c@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEyLK2cC/3XOTQ6CMBAF4KuYrq3pny115T2MITBtpQspFiUaw
 90d2UggLt8k33vzJr3P0ffksHmT7IfYx9Ri2G83BJqqvXgaHWYimFCcCUa75lVCyr4M8Um9rJz
 eu9oWwRAkXfZ4nupOZ8xN7O8pv6b2gX+vf4oGThllpmBaBOMqw4+3R4TYwg7SlXyrBjHnasEF8
 gAMtHR1gCDXXM64XK5L5NzW1oD0YLlZc/XjOL/gCrkKTCtpg+b14vlxHD+Riw2qZwEAAA==
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
X-Proofpoint-GUID: rv887lmYwqiQRT1eIYoosLen9KSvMPEx
X-Proofpoint-ORIG-GUID: rv887lmYwqiQRT1eIYoosLen9KSvMPEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_09,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=593
 adultscore=0 mlxscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411060121
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
Changes in v5:
- s/Fixed/Fix s/case/cause for commit message based on Johan's reminder
- Remove unrelated change about code style for patch 4/6 suggested by Johan
- Link to v4: https://lore.kernel.org/r/20241102-phy_core_fix-v4-0-4f06439f61b1@quicinc.com

Changes in v4:
- Correct commit message for patch 6/6
- Link to v3: https://lore.kernel.org/r/20241030-phy_core_fix-v3-0-19b97c3ec917@quicinc.com

Changes in v3:
- Correct commit message based on Johan's suggestions for patches 1/6-3/6.
- Use goto label solution suggested by Johan for patch 4/6, also correct
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

 drivers/phy/phy-core.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)
---
base-commit: e70d2677ef4088d59158739d72b67ac36d1b132b
change-id: 20241020-phy_core_fix-e3ad65db98f7

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



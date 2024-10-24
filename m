Return-Path: <stable+bounces-88078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA519AE910
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A551C21CFD
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644D1E0E0A;
	Thu, 24 Oct 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="SOyz2ggU"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE8E1D9A72
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780808; cv=none; b=NK0ou+o4z7ku3clx79cyrb3Wyha3aL+L9W1XAia7hlwb8Th4v+xAbbv4vTgUsMdw9/0JY0ovu9CH5f4tqI5OKdcsmug4sDsSiWfKJ/7MrDVQZWZ8rxmmBm7z9vFJ3fZyASloxVhjRipJGA7Rdh3Fy5yfElkk+0RdBysCrZOZHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780808; c=relaxed/simple;
	bh=/+v5qWDFpQpSP4aVgXGxrkHf2Ca3FTpNljsXUZ9EyjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hg6NNsSVVcjEQIeJpij3XbcjM1WcPfCkHD4FbRaO0PcW+S0MWMqrPFMiAGs6/YPx5GtD/NOfNUcZklMonqrax9B29D2s3MEdwpELjrABb123ttGgZVTq/I/HoBZg0EBGjqvRmPm+6L9yd3OvIGnKdV9y8V3yz7IlYzOnMFNP7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=SOyz2ggU; arc=none smtp.client-ip=17.58.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729780806;
	bh=ElEUXfsmj+BGFWeZ+4fY2pT8AL/H58IUKyHjLlkrc24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	b=SOyz2ggUisFgCRAISxeuflGhAWUdYDibnEcSe2fLViYcwdcLBUsm0gngWCzf76JFY
	 3/zkx1p/7gXKY3gDwpeQNV2tWOpJHmpX8GZy7J3SjqxBzCH0ZIRNpCvcjm3kgCZbiN
	 FxSOfUsu74IktD+xLB/jiK6pFZ8XyazGKnwMMJvtgj4Fac5wCaiqKULrlXEm+PjHno
	 oO4htjxXKMrs/vWd7sHflKTDclbOJyPxef7QvooGMrTORo/S3IzZdeLP8OVJEPB2nT
	 Fb5TaByocIkgdIyuuoX1BLmEAOS9UkaWGjoBTVYC2YtND977+3krTufz+XsBeVE1Dg
	 DPhqeS/EZS9Bw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id DD8D3C8018B;
	Thu, 24 Oct 2024 14:39:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH v2 0/6] phy: core: Fix bugs for several APIs and simplify
 an API
Date: Thu, 24 Oct 2024 22:39:25 +0800
Message-Id: <20241024-phy_core_fix-v2-0-fc0c63dbfcf3@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1cGmcC/3WMQQ7CIBAAv9LsWQygltqT/zBNg7DIHiwVlNg0/
 F3s3eNMMrNCwkiYoG9WiJgpUZgqyF0DxuvpjoxsZZBcHgWXnM1+GU2IODr6MDxo257s7dw5BTW
 ZI1a97a5DZU/pFeKy3bP42T+jLBhnXHW8lU5ZrcTl+SZDk9mb8IChlPIF43ttYKoAAAA=
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
 Zijun Hu <zijun_hu@icloud.com>, stable@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: 9n3-w7T1ahFC5qSBvrhN7QQIjqgA1PEY
X-Proofpoint-GUID: 9n3-w7T1ahFC5qSBvrhN7QQIjqgA1PEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=631 clxscore=1011
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410240120
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

 drivers/phy/phy-core.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)
---
base-commit: e70d2677ef4088d59158739d72b67ac36d1b132b
change-id: 20241020-phy_core_fix-e3ad65db98f7

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



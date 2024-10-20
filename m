Return-Path: <stable+bounces-86939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977F99A529E
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 07:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CC01C214D2
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 05:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A672F507;
	Sun, 20 Oct 2024 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gpwA6Neb"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE081759F
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402129; cv=none; b=D58+mjy+KS1vgkqP8sqGQDyci62VCRuuuyinzeQJQuUceZQ/5iTLchOuOSzqF92WmADRlWHYBfl5e9j3DJrM+7b1VpCJhVlA/q1zBWtQhYHB9r+XKr9HSbkrPOD1Jsyu6LKhi6LWmtevnN1pT7k6HKi2+Hq1MdayKzHaW84BbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402129; c=relaxed/simple;
	bh=zw3V8T7ov+wsHzKci7EhxMWXZ+pU508pS/bnECLKxOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4wCRYcAbd0gD2JZmDr45a27C5b4KtSmrSlWGwUEbvUOQOFhjMvid5WLjRJbSIEXs52iuy4Ylvrj83+wdf0aqIjBiwMHxDAEcqW5UgQ+y5kxHZNxsFJo4NNoUCkgDAoh+0vpp+lnyA4oyDJ10h7v4O3V3YasV01otSUqd0R5HZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gpwA6Neb; arc=none smtp.client-ip=17.58.6.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729402128;
	bh=bqgD9TqeRl3fISVSF8RjYIENXrO/0dTFirpvQNfH4Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=gpwA6Nebi6sHyPqVwriErkrRAhyENlFTXgZcArARP8mEwzKBlNqcKlFYAJFtkECLL
	 ya6kIrNGTXEdErFwr9yHehnypMbo9TDrumZZVglnayEeMonZDR5aZs/1tiJDj2Fw9+
	 J3ydjynv9shdosxmzgJvzSjJPXAjWXXdlUQ+szT2HoIjJhJYbHqH6eXd1vvyxofr2f
	 GmoO62berrK2gd/Yg3SXJDmt9x+R3qrzq0AgXDWFse12ZjC6bDj+QnAWaW6//FYFKY
	 gNmBNGcpgnjES50eYR2OZ5vIeOUL4gQ8+J7hbss9dMaXasTJCXA6ivJJwcJs6DTzZa
	 vefo6h7EQZJsg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 7D78D2C013F;
	Sun, 20 Oct 2024 05:28:42 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Oct 2024 13:27:49 +0800
Subject: [PATCH 4/6] phy: core: Add missing of_node_put() for an error
 handling path of _of_phy_get()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-phy_core_fix-v1-4-078062f7da71@quicinc.com>
References: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
In-Reply-To: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Lee Jones <lee@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, stable@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: UKGJg6bDUiFHKz2zU5QVA92RCrgayaQo
X-Proofpoint-GUID: UKGJg6bDUiFHKz2zU5QVA92RCrgayaQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_02,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410200032
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

It is wrong for _of_phy_get()  not to decrease the OF node refcount which
was increased by previous of_parse_phandle_with_args() when returns due to
of_device_is_compatible() error.

Fixed by adding of_node_put() before the error return.

Fixes: b7563e2796f8 ("phy: work around 'phys' references to usb-nop-xceiv devices")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/phy/phy-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 52ca590a58b9..967878b78797 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -629,8 +629,11 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 		return ERR_PTR(-ENODEV);
 
 	/* This phy type handled by the usb-phy subsystem for now */
-	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
+	if (of_device_is_compatible(args.np, "usb-nop-xceiv")) {
+		/* Put refcount above of_parse_phandle_with_args() got */
+		of_node_put(args.np);
 		return ERR_PTR(-ENODEV);
+	}
 
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);

-- 
2.34.1



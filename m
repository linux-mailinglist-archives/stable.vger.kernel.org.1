Return-Path: <stable+bounces-194695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9848C581AE
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1868C350812
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCF2D9494;
	Thu, 13 Nov 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="Blrvp02f"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5533135CBD3;
	Thu, 13 Nov 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045963; cv=none; b=RdPwdTp+ud3nBzxZUSSb5Facq/D5Ka/l3YQf0LhGDaHERHZQk/A08Z8R+ENgI/fpQTjeKPAt6vBOoIr/M14XfTlRtYN7SdQBj7/hwHr5g8+J388mxIpxOs7vlb2TrYyyV8diQftqc5BAEAyzHWyJ41DTyZotb5Q7eXUwhx3uQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045963; c=relaxed/simple;
	bh=Db9hu2HdD//jk91631tPIDTC2WqeaooR8SDMjqObAYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LjpSEHqggDc9NCKZSpnntDWOAAMNe+6iGARqXwnuCedsNIVnKAliISgssEi/TCcPXbOLAeAQQbtWg8a3f4wBBk2Hl46Eho5zxnKil9qN9YZSBOg9U11M6ySdcgzPOLBTYy9ZglC5+RCOF2jI0Rj4VBaGF3QDc2uGohmMbqgcKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=Blrvp02f; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id E73346003C0C;
	Thu, 13 Nov 2025 14:59:16 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with UTF8LMTP id 4hFpyF9LhRyf; Thu, 13 Nov 2025 14:59:14 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 33CF66003400;
	Thu, 13 Nov 2025 14:59:13 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1763045954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=chc/NlipiB+N/nq7OLHWxVwlHw0T2tebinCs9Z7oCSs=;
	b=Blrvp02fgKdi0gybUy5/jQu6fFHa3/odEf9jRtYaWzg7dfTMIVAOF4EN5j5p0mI+lfunUa
	CLTSsv6WAywZgrNJ9i5ibGU+QUh8v19ZVq+aUgFfSys6+a+ml+JINeFsh0XajytK3aoQIM
	yLsQtqCAf8BOOqsd0XO6o6OjTO3iCr2ZPy83PQBvsRqlqDq8Jwl5XrgJrSXnFSP0CMAz0v
	B8N1Tv5lolol3WbvTVgXEktRQNVm2uWU/L0RSTr9yMFnhaBl1GWwKsiL5Lnl+RN+kW+rKK
	Rv8/cE7OJ+2+uIBZRSkKKRV3UOclJBXU+xgyIg9V8vO8D+vGidWyjBB1AiYe9g==
Received: from [10.39.153.220] (unknown [87.58.94.198])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 0A4F136007B;
	Thu, 13 Nov 2025 14:59:11 +0000 (WET)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Date: Thu, 13 Nov 2025 14:59:06 +0000
Subject: [PATCH] usb: phy: Initialize struct usb_phy list_head
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-diogo-smaug_typec-v1-1-f1aa3b48620d@tecnico.ulisboa.pt>
X-B4-Tracking: v=1; b=H4sIADnyFWkC/x3MQQ5AMBBA0avIrE2ilQquIiIto2ZBpUVI4+4ay
 7f4P0IgzxSgzSJ4ujiw2xJEnsG46M0S8pQMspBKCFHixM46DKs+7XA8O42oKiML1Zi6kQZSt3u
 a+f6fXf++HxXsxWVjAAAA
X-Change-ID: 20251113-diogo-smaug_typec-56b2059b892b
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Felipe Balbi <felipe.balbi@linux.intel.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763045951; l=1571;
 i=diogo.ivo@tecnico.ulisboa.pt; s=20240529; h=from:subject:message-id;
 bh=Db9hu2HdD//jk91631tPIDTC2WqeaooR8SDMjqObAYQ=;
 b=KCLSRK3WOMqOzloTkWHQbkZQGg07lhBfJXX+nF3hkqXupGm9rr5HcRbbZMlp/SQBJU5dMMxZ3
 Y2avkf0OvFQB/hDjHpye+rlpQvGJ9F4RxWptdINWjEi5UvMVF3q4JTe
X-Developer-Key: i=diogo.ivo@tecnico.ulisboa.pt; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=

When executing usb_add_phy() and usb_add_phy_dev() it is possible that
usb_add_extcon() fails (for example with -EPROBE_DEFER), in which case
the usb_phy does not get added to phy_list via
list_add_tail(&x->head, phy_list).

Then, when the driver that tried to add the phy receives the error
propagated from usb_add_extcon() and calls into usb_remove_phy() to
undo the partial registration there will be an unconditional call to
list_del(&x->head) which is notinitialized and leads to a NULL pointer
dereference.

Fix this by initializing x->head before usb_add_extcon() has a chance to
fail.

Fixes: 7d21114dc6a2d53 ("usb: phy: Introduce one extcon device into usb phy")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
 drivers/usb/phy/phy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index e1435bc59662..5a9b9353f343 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
 		return -EINVAL;
 	}
 
+	INIT_LIST_HEAD(&x->head);
+
 	usb_charger_init(x);
 	ret = usb_add_extcon(x);
 	if (ret)
@@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
 		return -EINVAL;
 	}
 
+	INIT_LIST_HEAD(&x->head);
+
 	usb_charger_init(x);
 	ret = usb_add_extcon(x);
 	if (ret)

---
base-commit: 35d084745b3ea4af571ed421844f2bb1a99ad6e2
change-id: 20251113-diogo-smaug_typec-56b2059b892b

Best regards,
-- 
Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>



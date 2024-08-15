Return-Path: <stable+bounces-68767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF19533DF
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF15AB2689B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDB91AC896;
	Thu, 15 Aug 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ay2vy+dP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09119DF85;
	Thu, 15 Aug 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731601; cv=none; b=sBaw7dCyZkgrfYpaVdTTM05hqQsghH8J40671cp1DPPRIoAiuwBbhH+vadUoseKNHXz/EIbqOzrQkf93Ujyxx5banQMo7y8j6WMeZ0mqreRGC5HWdDz/zlwN36q/ee/4IMj2bji38P9XGRepLJ590hAHKlIZHR9zh7uPTl8W4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731601; c=relaxed/simple;
	bh=tbn0l5xY3pWQvetktJBN4mTC99pvth9ZMeUa8nQFU54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBWUqJKstLxkTayq0zgwVSJMsQpNVn3a/Y9gCjqcYLiz5NgdX9yKV9Es4G8gvm3gfqpv9AA9+HYEaWOusym3Gn85Q9G29FPOR1d5vtCPsoJj9zmOA/Puk8eeJqJF0vDDtmgz5aNptIpGv0yEIwKdXjTRs8TX7lYM9/NPR+peUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ay2vy+dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E37C32786;
	Thu, 15 Aug 2024 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731601;
	bh=tbn0l5xY3pWQvetktJBN4mTC99pvth9ZMeUa8nQFU54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ay2vy+dP0ih8FrXdKzr/aPo3HmFzduhcoOHWfjdoIqKMQkZxd73jHLPsJmBnp8FhR
	 jU+/cTKPz+0ZzYMPR0XJ7A3Jss6QuPIJcGeXUq2/cj/yAreaJcSmabj/ocnUUa+DU5
	 whEQkSMbuB9k1/2D+OnMdrq5LUo7tCJ2uMxv5Zmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 181/259] net: usb: sr9700: fix uninitialized variable use in sr_mdio_read
Date: Thu, 15 Aug 2024 15:25:14 +0200
Message-ID: <20240815131909.767972426@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 08f3a5c38087d1569e982a121aad1e6acbf145ce upstream.

It could lead to error happen because the variable res is not updated if
the call to sr_share_read_word returns an error. In this particular case
error code was returned and res stayed uninitialized. Same issue also
applies to sr_read_reg.

This can be avoided by checking the return value of sr_share_read_word
and sr_read_reg, and propagating the error if the read operation failed.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/sr9700.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -178,6 +178,7 @@ static int sr_mdio_read(struct net_devic
 	struct usbnet *dev = netdev_priv(netdev);
 	__le16 res;
 	int rc = 0;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(netdev, "Only internal phy supported\n");
@@ -188,11 +189,17 @@ static int sr_mdio_read(struct net_devic
 	if (loc == MII_BMSR) {
 		u8 value;
 
-		sr_read_reg(dev, SR_NSR, &value);
+		err = sr_read_reg(dev, SR_NSR, &value);
+		if (err < 0)
+			return err;
+
 		if (value & NSR_LINKST)
 			rc = 1;
 	}
-	sr_share_read_word(dev, 1, loc, &res);
+	err = sr_share_read_word(dev, 1, loc, &res);
+	if (err < 0)
+		return err;
+
 	if (rc == 1)
 		res = le16_to_cpu(res) | BMSR_LSTATUS;
 	else




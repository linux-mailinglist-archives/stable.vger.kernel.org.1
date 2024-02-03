Return-Path: <stable+bounces-18082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2484814F
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC3CB2AFAA
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7016B171B0;
	Sat,  3 Feb 2024 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2uBCKUAg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A355171A6;
	Sat,  3 Feb 2024 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933534; cv=none; b=W2RKLvfF8kV/FXedB7pGYP2lWM205Tag/rXPZFZaaVXPtrcRD5tGDd/0UniBbA3UobckCDKLExjiFHOroTyKOalaOCdshA+zkdZijkpjJxFzf3tu1WKcrmpF1f3QtEfvfX9WvM8OKI2EQZovMj0UYmkyC5KlikHb1jfNKkjCyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933534; c=relaxed/simple;
	bh=N6UFFb/P/ILmCIlleeyu7kLB3B4kT/+Bk30jEuVRsuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FK02iF+9vnx469s+18tZ2cwg0mbVl+jyEuE1PHjNlNuDv9Cv33i7eHJr+WL411+hUQsb1R7o1O+7RM9tBiI44RagWQacZBvaX6w/jugKIEqbjcM9CBAnYnOzc5xXS/4u1EHvD7BcUJ1CdyffF56BwrOm1FPz7tQkIfNMacGOsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2uBCKUAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BA7C433F1;
	Sat,  3 Feb 2024 04:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933534;
	bh=N6UFFb/P/ILmCIlleeyu7kLB3B4kT/+Bk30jEuVRsuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2uBCKUAgnnm6LNwSeJ1bqFkX+RlUkW2SRqj0y8JxwqxiCbQ6btJcR01VqJ68ZgCIF
	 OLxrY0fbAL9sLfM7OtrVD2Gr/q1k1R+3tChRiblpB1KumAasQL3I0tjTGlcvJVgfHS
	 aa6TIq7Vv0RU7aEfvItRP7HLT64Ljf/8RhTa2E84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herb Wei <weihao.bj@ieisystem.com>,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 078/322] net: usb: ax88179_178a: avoid two consecutive device resets
Date: Fri,  2 Feb 2024 20:02:55 -0800
Message-ID: <20240203035401.686987641@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit d2689b6a86b9d23574bd4b654bf770b6034e2c7e ]

The device is always reset two consecutive times (ax88179_reset is called
twice), one from usbnet_probe during the device binding and the other from
usbnet_open.

Remove the non-necessary reset during the device binding and let the reset
operation from open to keep the normal behavior (tested with generic ASIX
Electronics Corp. AX88179 Gigabit Ethernet device).

Reported-by: Herb Wei <weihao.bj@ieisystem.com>
Tested-by: Herb Wei <weihao.bj@ieisystem.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Link: https://lore.kernel.org/r/20231120121239.54504-1-jtornosm@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/ax88179_178a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 5a1bf42ce156..d837c1887416 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1315,8 +1315,6 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	netif_set_tso_max_size(dev->net, 16384);
 
-	ax88179_reset(dev);
-
 	return 0;
 }
 
-- 
2.43.0





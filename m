Return-Path: <stable+bounces-154541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF1ADD997
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E263019475C5
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868C2FA62F;
	Tue, 17 Jun 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RhPpr3CR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824672FA624;
	Tue, 17 Jun 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179542; cv=none; b=tIz69xYhzYIESfRYxKQlM6t7tk0HCqxDyayXpc+4DCSXi7g9pON6vZu+jJnCSbGmo4Tv83QX09cUFjPqvhYSWedpsYzaiJaz2TyHjvGAjdWZwRvu7YFUv159IcrT7FxpZosgv3yI1vRpHxQaSUKCqB270IwxWtdVHeTCkGaSiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179542; c=relaxed/simple;
	bh=ey6F4vBL6dydjEM80HLh6JhThk0vH/V5tAvoq+0QN/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNnKZRoqw3ccjnEmTSvyuBj95J5Ytf3zKHYXRvxOUKyTB33WrFmarYkV8vZQHnrMvZjvmu7R6V54vdZg8ePTLy+jRef+LcTmedstjmlSi2lbJMIixS/0JFxjrBdXwvKCH7Acs9pQ1tsehW/vZsKkNxWL/pAFN4YdnGB7KS1z0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RhPpr3CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD6DC4CEE3;
	Tue, 17 Jun 2025 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179542;
	bh=ey6F4vBL6dydjEM80HLh6JhThk0vH/V5tAvoq+0QN/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhPpr3CRs1fGsNbkb7gwOcDsZ1hg4K4F7FJXNp3OV7ACo+77BpAl4Ybb3RCLjxdRT
	 bKwiV1iMNhoJO5t+eS3iQhCtN13fBN1oCu9AtoKKh0a2biTlhRp0JJp99ygJ8dW5oV
	 6zUgBNT6/k/kUG16qE5VpYcwP+bW6j5WXyqWNBqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.15 778/780] net: usb: aqc111: debug info before sanitation
Date: Tue, 17 Jun 2025 17:28:06 +0200
Message-ID: <20250617152523.191777154@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit d3faab9b5a6a0477d69c38bd11c43aa5e936f929 upstream.

If we sanitize error returns, the debug statements need
to come before that so that we don't lose information.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 405b0d610745 ("net: usb: aqc111: fix error handling of usbnet read calls")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/aqc111.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -31,11 +31,11 @@ static int aqc111_read_cmd_nopm(struct u
 				   USB_RECIP_DEVICE, value, index, data, size);
 
 	if (unlikely(ret < size)) {
-		ret = ret < 0 ? ret : -ENODATA;
-
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+
+		ret = ret < 0 ? ret : -ENODATA;
 	}
 
 	return ret;
@@ -50,11 +50,11 @@ static int aqc111_read_cmd(struct usbnet
 			      USB_RECIP_DEVICE, value, index, data, size);
 
 	if (unlikely(ret < size)) {
-		ret = ret < 0 ? ret : -ENODATA;
-
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+
+		ret = ret < 0 ? ret : -ENODATA;
 	}
 
 	return ret;




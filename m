Return-Path: <stable+bounces-171674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8898DB2B479
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FA5171F19
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 23:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B424D27281D;
	Mon, 18 Aug 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgU6Qi53"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7196C26FA6F
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558841; cv=none; b=YbahFIzmZI15I+Vg0qZQZtOhpdZvgmTK5Ib0cxBsJSpjZ4Hq3sQhsRrVdvYpB0NFKo3Zc+1Bx2eK+9ijPtA8a+lMTIaSlzKfHpOP+x0zcYMln5UfaP9EmRKRPJ19Ba6vBK+xuWjpThw8S+iUStRfrxHcpSmhIHls33b2bp3AY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558841; c=relaxed/simple;
	bh=jkRIXHAVXT6uUYqz7rizlPIBcJBqyYiGJ9ncGrGEH+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1M7a8dxkqRM8bWROaj/lD2Zi2tq03jWIWbNwvWTu0eij+Fc8uj5ofAuZDKm/jeqVgaeN8XhvBm2bKUeK08u5QgLVNhNrQVh6n5D9cR/M1fwA654vU9zBWXZ8qGPWmmF1ISfiuuvq25FtQ4UTDkhfJCUQLCel6c9veD/XrDBa5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgU6Qi53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8111BC4CEEB;
	Mon, 18 Aug 2025 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558841;
	bh=jkRIXHAVXT6uUYqz7rizlPIBcJBqyYiGJ9ncGrGEH+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgU6Qi53U9lIEOe04uOc7+l0fMvGlRVerk+FXpMxoBAbh5TM3UKDxdA2NuWrAdjSm
	 L1S47NtElZUe+xqPL9hwys52HqA7SX8lLGoZ+CI6XmSZk2K18DjXjMX+0Ie0S4TN65
	 ZaE5U3IajakUUbLFDUQmw8Zel87QGNLaWW8zFES/Vas1zLop/FPu6lDGDKKRoPTlXo
	 5j5h/SqFjcU6+hJ6+Xa9Kg505ewHZReVfcbf+DXs02tO6HIY3H7kZLxt2ve/vhwOD9
	 Cqz/7WxhAcr8gARiFCfcumYqz80VhA2sQTQpY86WQR/ujcMGhCx9sOlaAM9JDb3JEZ
	 eS4JEXGPrQXHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] USB: cdc-acm: do not log successful probe on later errors
Date: Mon, 18 Aug 2025 19:13:57 -0400
Message-ID: <20250818231358.138342-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081847-user-synthesis-c726@gregkh>
References: <2025081847-user-synthesis-c726@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 79579411826647fd573dbe301c4d933bc90e4be7 ]

Do not log the successful-probe message until the tty device has been
registered.

Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20210322155318.9837-9-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 64690a90cd7c ("cdc-acm: fix race between initial clearing halt and open")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 59a354822413..51f2caf0fb3e 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1520,8 +1520,6 @@ static int acm_probe(struct usb_interface *intf,
 	acm->nb_index = 0;
 	acm->nb_size = 0;
 
-	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
-
 	acm->line.dwDTERate = cpu_to_le32(9600);
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
@@ -1541,6 +1539,8 @@ static int acm_probe(struct usb_interface *intf,
 		usb_clear_halt(usb_dev, acm->out);
 	}
 
+	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
+
 	return 0;
 alloc_fail6:
 	if (!acm->combined_interfaces) {
-- 
2.50.1



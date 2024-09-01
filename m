Return-Path: <stable+bounces-72394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB010967A74
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5674C1F23E7E
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39118132A;
	Sun,  1 Sep 2024 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TtqDrUUD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A38208A7;
	Sun,  1 Sep 2024 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209780; cv=none; b=UznRhUiNxgfX/D/2SOKfr0JOtbt+jlqMIwON+K3PapH6gvrFY1O/PXhsVJpZ1qFe0TsBhvGVbyHvynihA4aapsJtnZRnx+Cfkd8Gfl7I47KgK2ur6FEZ70/wCYDimJwRd9sBoLVV0S1OlrqEUMhIhLwBd0FY9RJ4NxHy+mEufic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209780; c=relaxed/simple;
	bh=vqiftrmLhUWLZRp4LCZ7vjSQpwQ1ORRwt6e1nhAhlw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIar02xlqmHQFS/R6fj05gvy9ONxEsj0vtOE6gdTormO/gOmsK1XFYAu7gARJvLpDzAHGTjpftuAnGNm1U9Ok6OvHpfuAr6G3FW/qL4eC+jTadMRQMAqbKDZnDQllBP790fSTDy0YdS1rU9xzYDdurEXeLY5v7tLRVjroe3YqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TtqDrUUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2C0C4CEC3;
	Sun,  1 Sep 2024 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209780;
	bh=vqiftrmLhUWLZRp4LCZ7vjSQpwQ1ORRwt6e1nhAhlw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TtqDrUUDLLDcsU+yjBoeWm5MV5hL939o789rsIRE4jYg8vBnxD3mCDjjExGcH1/lk
	 w9NsnT3eyNPARpplQR7w/ttDbMCFoWIrArDbqQy1fXQOyrxqoZZYsZfRU/klF6DJOc
	 4vvkOnddR+MKSKCeYq3O8EXfiTQ9TQLLl4nU2uFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Ray <ian.ray@gehealthcare.com>,
	Oliver Neuku <oneukum@suse.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.10 143/151] cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller
Date: Sun,  1 Sep 2024 18:18:23 +0200
Message-ID: <20240901160819.490692544@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Ray <ian.ray@gehealthcare.com>

commit 0b00583ecacb0b51712a5ecd34cf7e6684307c67 upstream.

USB_DEVICE(0x1901, 0x0006) may send data before cdc_acm is ready, which
may be misinterpreted in the default N_TTY line discipline.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Acked-by: Oliver Neuku <oneukum@suse.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20240814072905.2501-1-ian.ray@gehealthcare.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-acm.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1757,6 +1757,9 @@ static const struct usb_device_id acm_id
 	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
 	.driver_info = SINGLE_RX_URB,
 	},
+	{ USB_DEVICE(0x1901, 0x0006), /* GE Healthcare Patient Monitor UI Controller */
+	.driver_info = DISABLE_ECHO, /* DISABLE ECHO in termios flag */
+	},
 	{ USB_DEVICE(0x1965, 0x0018), /* Uniden UBC125XLT */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},




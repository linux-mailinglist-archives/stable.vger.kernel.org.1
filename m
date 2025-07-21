Return-Path: <stable+bounces-163578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5ACB0C4E9
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17376188A03B
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836282D8DDC;
	Mon, 21 Jul 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjBe2H9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053342D8DC4
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103328; cv=none; b=TqtOIgxEamTgQOpnpUZcgdWuSS0Wd2SPd8uWnLsdy+bv4KdkSCoX2+6YhYncqYAzWN1GI3KPewCT2sb00gloS4sDFsrTHtSeUmxERU+1MqAUUq3m7IGEKrzwUXup7KWb8/AEDQPGQQlHY5zW7vmOcMLNCsu3CjNdZMyC9iy3zzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103328; c=relaxed/simple;
	bh=G9Vt6CqU+sUwDgAw3Fc39aA+1XFi01h/a20NI8PYSC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZ0X12/7s4jreRWNIP4Nah71wphEWMp+ZqTPqV9vVwLYhzixlPCSrITmqPNVSFZUxLHPCmvrr7nvountaCN1nL3BGyJrbJ0SjORbVKVdbRkJJj0EjS+rx69z+U5Td2r+Eu1bsjXZxbkuJcNNqiEGZ90XZ0M5KPvSk1zc/hYfgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjBe2H9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E11C4CEED;
	Mon, 21 Jul 2025 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753103327;
	bh=G9Vt6CqU+sUwDgAw3Fc39aA+1XFi01h/a20NI8PYSC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjBe2H9nnWz5joNy67BHFe9Gb7E3uWVAOkMu9N+7LM8NyQdQL/a4U1Y1e14KF4cll
	 m7yBpnsIPIgUwQqiOg7g/7IkbrwAjXtwCpDni2Z6jdFqzz+UtQfJIM5K2rjgFMeWIL
	 iTYmgENykHmpRnB/3RQRYLbjHls2u3XPLoGbi5/fzyJto85/201xDrKHbeczxNwypr
	 0BZ4YQDLq52j7q+FKySLcHla+T2dkx5Edroxrg1YonRZIFlEWj2Pf+1Kc2EMfYamZg
	 6zo4HIEvltaezW9WAlJhZnd3N4VUbvMqeZDnPWLywX15RlzkNrfh17kktz0lIm5uTR
	 yFtNV8N7KSLpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Drew Hamilton <drew.hamilton@zetier.com>,
	Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: musb: fix gadget state on disconnect
Date: Mon, 21 Jul 2025 09:08:42 -0400
Message-Id: <20250721130842.833119-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072131-trailing-chaos-96f3@gregkh>
References: <2025072131-trailing-chaos-96f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Drew Hamilton <drew.hamilton@zetier.com>

[ Upstream commit 67a59f82196c8c4f50c83329f0577acfb1349b50 ]

When unplugging the USB cable or disconnecting a gadget in usb peripheral mode with
echo "" > /sys/kernel/config/usb_gadget/<your_gadget>/UDC,
/sys/class/udc/musb-hdrc.0/state does not change from USB_STATE_CONFIGURED.

Testing on dwc2/3 shows they both update the state to USB_STATE_NOTATTACHED.

Add calls to usb_gadget_set_state in musb_g_disconnect and musb_gadget_stop
to fix both cases.

Fixes: 49401f4169c0 ("usb: gadget: introduce gadget state tracking")
Cc: stable@vger.kernel.org
Co-authored-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Drew Hamilton <drew.hamilton@zetier.com>
Link: https://lore.kernel.org/r/20250701154126.8543-1-drew.hamilton@zetier.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f175cb2c3e7bd..cfac979278654 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1925,6 +1925,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	pm_runtime_mark_last_busy(musb->controller);
@@ -2031,6 +2032,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_set_state(musb, OTG_STATE_B_IDLE);
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
-- 
2.39.5



Return-Path: <stable+bounces-163581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F3B0C521
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B953BEF48
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3923A2D8DD3;
	Mon, 21 Jul 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/OlivNC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7F2D7808
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104353; cv=none; b=Figab7TmlgjAPDzrGj37mcneRmns7LgQVrIup3wmWiYi2eca/mXp2ODDl94l/rWvuPMSzTTrsqMoSsSAIMmQwg4FcFLss8T+v8lSC/mc25ZArJ50Im5EsMycf4IaD5h2ELz5gRBmbwvG2l5aHFROsAPl+2WyNNr9ur23gCMg4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104353; c=relaxed/simple;
	bh=j542seurEr1vvUf3A9KhcXzr0aFQfjkhrPH4jiDNhKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkyPehL+spfNL2C+pN1YDuzx0PgNpLq+HF6Q2s69A59QlAMAKoUdKDa6F+wElCRDXt1EnKDefTdz/KvCYG7Zej7IF2f3I2qmvFp5kUMukBlRl6QJGovKx3rqg4GdZocTuP3nuYE+HqUxr+K7+tRpRa6z96I5V3e54B77hig8+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/OlivNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F8EC4CEF6;
	Mon, 21 Jul 2025 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753104352;
	bh=j542seurEr1vvUf3A9KhcXzr0aFQfjkhrPH4jiDNhKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/OlivNC+qribVoH68W6x+XNQb6ZRcshtQag7oRLTR6+1Atn3CQ1OxnR83i7cthWp
	 cH95j++g7VfzyvcVmkdFDm4U7LU5Fx10f25qnUN2tvvMTNaLyJsslQ/8Iiq0ZP2E/O
	 vLpYZtCp4KoXlrGWsZYYPs+HjkSRZ1PRQsOUyyNcNzff6aG3k/mNP9H9gUZBq/hqc0
	 3iX5lIk7nQGjO79z0FxOCCW+c97RDEtpg3E1CSDOBoLVnTyfO4hjPqu62vIzsNaR09
	 xprAlZklOGCEwxqNxbG4AYUIEkQAc0h6KW2J2FbtXeTNK//6uf1Ftem7Iy5RsxhxRC
	 Vx9wXhtZ4vOjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Drew Hamilton <drew.hamilton@zetier.com>,
	Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: musb: fix gadget state on disconnect
Date: Mon, 21 Jul 2025 09:25:47 -0400
Message-Id: <20250721132547.837296-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721132547.837296-1-sashal@kernel.org>
References: <2025072131-crushing-unsworn-a3b0@gregkh>
 <20250721132547.837296-1-sashal@kernel.org>
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
index a358f7fe0ecf3..e3a5d136717d7 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1916,6 +1916,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	pm_runtime_mark_last_busy(musb->controller);
@@ -2022,6 +2023,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_set_state(musb, OTG_STATE_B_IDLE);
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
-- 
2.39.5



Return-Path: <stable+bounces-56830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4D924628
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2043D1F22A63
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666EF1BE225;
	Tue,  2 Jul 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v03PwgDp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2595B63D;
	Tue,  2 Jul 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941504; cv=none; b=iGhhOvDogsNFscGkv3b1kfntpJ5pXGDNm80QF8ecnMcRr0BERUlcovKwdnI1LBkiA2QxobOKomOGM+uXJ7Wi0TS//XzKLJfTLBZXKVG5t9wSeqWzV2oXmL414sdrF1cihLbtoIXlRlF5tSE7Ej7uwNfrkneBh16iE7vYTd5xZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941504; c=relaxed/simple;
	bh=d8ZyV2rPPitIvh3f0e2VFkWNyB8/sWz7uPyKB0L0/HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kx/grVuG/zeHj71Wdc/XIvXEaEKmrcnpAyxTVOV8ap/bQxZeffIRjK5noYXB83sxJOfUMpMmtEIKnj+y5281IuJedQW3/FC0ii9KTBk0fSpwGCpGAnYpMJ+7ikPBokYi+EFfnqft/DzH2/u1Z+kofl2ngkPY8phCwRy77Bs/sGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v03PwgDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B096C116B1;
	Tue,  2 Jul 2024 17:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941504;
	bh=d8ZyV2rPPitIvh3f0e2VFkWNyB8/sWz7uPyKB0L0/HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v03PwgDpoXdKrp/6AzlmF8doz8QPQJMqQ4HSizo5Kcxc3O2vpZFPPzSHepkoExp/J
	 evTPPQHYHtfByQQyntmtG3TjArpIP/QWJQDjInD20Nn245fRnOm89AmqYPPmSazAen
	 EvPvMmKVe+FJHt5O7d/aUMsGoaFAzgH68KNs0/I8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 083/128] usb: gadget: printer: SS+ support
Date: Tue,  2 Jul 2024 19:04:44 +0200
Message-ID: <20240702170229.363525319@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit fd80731e5e9d1402cb2f85022a6abf9b1982ec5f upstream.

We need to treat super speed plus as super speed, not the default,
which is full speed.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20240620093800.28901-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_printer.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -210,6 +210,7 @@ static inline struct usb_endpoint_descri
 					struct usb_endpoint_descriptor *ss)
 {
 	switch (gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
 	case USB_SPEED_SUPER:
 		return ss;
 	case USB_SPEED_HIGH:




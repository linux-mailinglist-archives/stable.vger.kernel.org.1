Return-Path: <stable+bounces-138678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05FFAA1916
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF32188E1C6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722FA1A5BBB;
	Tue, 29 Apr 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qQmb/XjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36D2AE96;
	Tue, 29 Apr 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950006; cv=none; b=mp72a+eMpDPFcjt5OGvKgVcwX1f/LfnDmY54TIHGOYu7Bg+sG2dGgEjsvHfvlGkxIaL0x5+agr7WINhWebKpfrh9Je/QDyqaQNSDN4yJCxixdxCtZi51krZseAEjnyUPuSJZCrGMd+ZTn9liQ6ue1Csc6AX9uru83uXRA/ALgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950006; c=relaxed/simple;
	bh=mkPDP5SBfE8lPzHwEvTAm3igCPpDJl1nzeU9QBt20bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dB8IVoOOIPdgIBquUM1/h7UILct7hPb8pCS9QX3z3LKti9cwkha01ux03gx2wbHE6QSGhN2EhHb8q7RhMvwohsVGOiFhUZ2sWCU7mPkAw3siAgVfNTHITuMFvNeTXhOLE5nMH+XA/Eh98+uh5SATdeWgUFkOV9ude0eP06Xreag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qQmb/XjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C16C4CEE9;
	Tue, 29 Apr 2025 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950006;
	bh=mkPDP5SBfE8lPzHwEvTAm3igCPpDJl1nzeU9QBt20bY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQmb/XjDSSG/7V2XlQFlBWNaeLsE7qyqbFdrpY9Wlzf2v9UdcZvs018AKBLc2LSuo
	 VLVt5LAa+YsKjYf1xXujWDk1ex5pem0QODHtll/UOyUJ/HKceFmIacpBtIYyP29bvs
	 0Fp/YKQcN+DgssxwnNhYUogfVUqtRTdHid2vLgBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 6.1 096/167] USB: wdm: add annotation
Date: Tue, 29 Apr 2025 18:43:24 +0200
Message-ID: <20250429161055.638563089@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 73e9cc1ffd3650b12c4eb059dfdafd56e725ceda upstream.

This is not understandable without a comment on endianness

Fixes: afba937e540c9 ("USB: CDC WDM driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20250401084749.175246-5-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-wdm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -909,7 +909,7 @@ static int wdm_wwan_port_tx(struct wwan_
 	req->bRequestType = (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE);
 	req->bRequest = USB_CDC_SEND_ENCAPSULATED_COMMAND;
 	req->wValue = 0;
-	req->wIndex = desc->inum;
+	req->wIndex = desc->inum; /* already converted */
 	req->wLength = cpu_to_le16(skb->len);
 
 	skb_shinfo(skb)->destructor_arg = desc;




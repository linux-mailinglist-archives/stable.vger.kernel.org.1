Return-Path: <stable+bounces-235827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHCdAFXF22kRGgkAu9opvQ
	(envelope-from <stable+bounces-235827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:16:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 522F93E4B22
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B016300D686
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 16:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF022D877B;
	Sun, 12 Apr 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5oMlGnN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227928150F
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010574; cv=none; b=Cw5E60iJHfjwc/1NoBJufknedPzs+gLj2gIa5ZmuIPNp1cubI1xtyrkVohWluUSJcvFP8l+c2UlaaFxjcmMcyO7Pa/s1wxLIthYPMHmLtgxMnDdVA/BrMQx73SOebvMF06xVS2Rzdnon1chx4pTsE6G5D2oBdNoAFQf6RylUxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010574; c=relaxed/simple;
	bh=6IlgXTFSmFVd7hT6b2wcB0Awnk4YrKROVYLwrLdRd0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=izJx/0kWt/0wLxsVLY9CeVszmhqurq1ehsQrZ9ZFTmeIPRv5YU1TyqZJGeeIRNmgB6BujDDPLvt9tOba8F0lzxbaRClx/bbt9RCN8aNtLnminiii2EfZE3ANO7TxuNShQw3NUIS3IhtcVEx2i/w86z29pueF43XnF1QnmXdShag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5oMlGnN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2503753efso30502215ad.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776010572; x=1776615372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBpA6cw876MX1y6VPWdZbugAryZAfoX9nVBjKfMU+gc=;
        b=h5oMlGnNKlq/XPXcTJMDh7SS6vKhBIk6zZAm2kIwZr4vQwLHyp1bbT7cuFPVzNS9NU
         l9bX2UxulWqsvv/VBkzVRVbbB1yWyRxs2do6uD57je8VumCD67RBTy84GceKTi9UHdLj
         fvbJNHS4yj4bqg3FN2ltgv1fxPermhpGsiH9uwEfMv/kz+XREcmh4ykRU/+dYIGImFLN
         vwjwpP4s3sJ3E4DzMkSeUr/7xUPcTTXG2AH4IGOK2K85lZFkT8pV6/oMcyvtvPduoPtu
         E9e2wVK6dgefbS+m+Dmm6ppNn47e/ySdI3lCqtNzIY2BzottROug+eY/T7ZbZcqhjW1N
         +Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776010572; x=1776615372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBpA6cw876MX1y6VPWdZbugAryZAfoX9nVBjKfMU+gc=;
        b=hnMCoMd92V2tjY/Sdi6K498DViyMB7ZaMOkEUn5Dd8md9J2+Ol994iplO7jeEbzL+D
         GR/Spc1UsmAML2PnkFNz/0RjhEyVExPS4ZQppJqd2LvFPhQWZOZUF7otzgCe8Nvtpe/2
         fZzywnkXawVsK1MZYLyZ8xE6X0wg8ik372DCSfnCkde0/0I9kQ/5l9wdmrvQxVBhglGS
         fldRJYpPq8RWIzT+OXw+5zV7XR6OOxQIWdkdPrtCPVBCLR6y3gcbSGTwG9oamvmpnn07
         pqNmRzK5RQ2L9hSb+krt3YjT+JWgXpufzd/I4aA/KNpYqUjasQrN3hOAfTjrAR4oz8vZ
         WVQA==
X-Gm-Message-State: AOJu0YyQFmjfb4US4EHs+oofqVEtGrtES4jpCSE4LoJEgKqIYWUs6t65
	lYVv2W3dfYH0MlPddoyr159XgLgU3wYY5U7MzMXUHvHmzMPy+BoAzFEo
X-Gm-Gg: AeBDieuOEz6YE61csyXM6oxBAsiz1QDJ3P2xvzYOIsT/BngnIl2d8xJs4+iR4re6y0f
	JDS0ZVhN+qEjqFqhoIKQqvx5WGSBHx2KC0nWWA+20G4GRZZqVH7tGjm+HJSE+TU07lpOpyoPkD8
	anH+Wj9V/C0qh00qnrd15hsDsqkPigxPJkjy44uYZ3rtr3dqAzsR9DuSTYKhtNOAu/zMzaCGDSV
	Nm3sTblYdgAQwDKT4WftCwgS3dV2+WzX/grmGmDN0H44IcSHs3x0Zzp28WxD7PGi5kApYc64FcL
	BvXfgWvaq/0JFTNt2Am6TXRNXeq1GMgwBt8Fk3LjT/EazrNdlMDimPN2vqPffjGiG/5UcbiZRRu
	93g8w6XLMVGuVfOp99LkC7aXSVGhbXF7Cz9dBBjPC2gto7OGVtR+CB7XtZ1sWvnQa8JJ7Fa6AQP
	KhIAUb5fbkSJVOe1IOMIHmXEG76D3D/CGNLg==
X-Received: by 2002:a17:902:8211:b0:2b2:d126:4e77 with SMTP id d9443c01a7336-2b2d5975bdfmr73934235ad.11.1776010572329;
        Sun, 12 Apr 2026 09:16:12 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:f515:539:1a62:ab91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4daede9sm117501075ad.14.2026.04.12.09.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 09:16:11 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ben Hoff <hoff.benjamin.k@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	William Wu <william.wu@rock-chips.com>,
	Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	John Keeping <john@keeping.me.uk>,
	Lee Jones <lee@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: gadget: f_hid: fix device reference leak in hidg_alloc()
Date: Mon, 13 Apr 2026 00:15:55 +0800
Message-ID: <20260412161555.2568840-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235827-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,suse.com,gmail.com,rock-chips.com,cosmicgizmosystems.com,collabora.com,keeping.me.uk,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 522F93E4B22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hidg_alloc() initializes hidg->dev with device_initialize() before
calling dev_set_name(). If dev_set_name() fails, the function currently
jumps to err_unlock and returns without calling put_device().

This leaves the device reference unbalanced and prevents hidg_release()
from being called. Calling put_device() here is also safe, since
hidg_release() only frees resources owned by hidg.

Route the dev_set_name() failure path through err_put_device so the
device reference is dropped properly.

Fixes: 944fe915d00d ("usb: gadget: f_hid: tidy error handling in hidg_alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 3ddfd4f66f0b..2734ebd35bda 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1610,7 +1610,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
 	if (ret)
-		goto err_unlock;
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1647,7 +1647,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 err_put_device:
 	put_device(&hidg->dev);
-err_unlock:
 	mutex_unlock(&opts->lock);
 	return ERR_PTR(ret);
 }
-- 
2.43.0



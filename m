Return-Path: <stable+bounces-236112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOeqLWf83GlJYwkAu9opvQ
	(envelope-from <stable+bounces-236112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:23:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3C3ED4A5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD4EA30285AD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF23DDDA2;
	Mon, 13 Apr 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y71jz3FF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8D3DB629
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090101; cv=none; b=h+qqvxH4y8n5t/njCZSljptm0HxT8LDzEEMbFsoFVaaQcP3zmQFyeMqMljFsTf+K0oON6CpQOoLNx766J/m4G+GcRXKZ18JugkgfCmR//anIJwVmcaVIBD4HraJnhU7LV6TwDp7/ADiVWoR/I2kZ+tAlWbXabaFam4aZ0JZ258g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090101; c=relaxed/simple;
	bh=wUuiTpK15zyn5hV2DVktQywHOc6nIUCjJeLdNjsqI48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIlbQfq+b/HUzMGoLc9UNc0XrqVj9E8iNdSvre0tX/Na9B45PoGT8PGYb/ZnKjf4naitPoyzj8bgrz3BAzf8ucZ6Rlrc8haC2B3FhpClhM7FCQt71gl92Eox8zYlYqRPMxgwttGEFg6PaJ3LH6QmBwXEultt+CaSY/bCGbgnD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y71jz3FF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso2538484a91.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776090096; x=1776694896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBYOrlMuwKgniT2kucvgYI8tCUxUSyygqBtilwNBNy8=;
        b=Y71jz3FFdVZq84s9JwTwapFVF6LNurvblpDHLhssEaCAkN6waVLqSU1XpzaAvcl/AI
         dzYYosC/tpohTMPuPJC1jJ4rWlr6IZWfMCeNecVUqiMP9uJsA5fYh8y7p3B2MJKU9fQf
         vZ3L6sCxEDyt0wOk0RSnuJXOZAIkKI+WWx2+3EeJGpqO1AsBC9OjczMUnLOAV0lnsAaw
         hzM4Z+Kto0CTKaDviROutgi+bPSF78+rjR2r3VAucrN61gDhcoUGFUTT9x9YllTDzAjs
         qveynFkTPOBxPV/a/jvHviOoV18l+Q3yAGfwG3vv8MQwqMR68RV5QfepA+mg86Sw86kb
         zeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090096; x=1776694896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBYOrlMuwKgniT2kucvgYI8tCUxUSyygqBtilwNBNy8=;
        b=aa0AxEeFnkUb/fiN3AqZFYVsZwXG8/MQ+dym3RJd28ORV3HsR09FUgsNLPEPY5NklA
         QFc4oR/UmO2aREOpfO6gSbPsuHJFYzoU2SJcO3sw4hC/eEGlGbKqe4IcNc/nclcDXiMC
         sfKYZYx6Maquie5BzHBnea+S1J9L6Acxf9PC5Wp6U18qRGQaq0aqjTHeIKIMr0voIWg2
         RTy8DHHT1LtgrHHEj016ckaYNK+s65iR8T18gJi3vIy6w2154+B+FX1lRYkktWoQS//E
         GkL2o+xVOr8//kGDkwaOhlieSDxZFGPU5GaaYgZAp9+Zipw2hyeYnPYU+aemFKIiheV0
         pFgA==
X-Gm-Message-State: AOJu0Yz5cntM170pMceq0zzhxzfkAweKTu3taidLcEy/EjtCONWIFcJ4
	+OUTwFUpKFfsxusSd+vaB4Hh/NTU85N48ctoOUdtjdb9FqM87u1tAves
X-Gm-Gg: AeBDietqxwgFu3K5kSmgP6wWzeKnc6QjLIr7tEm3WixEGu48tAaKkCzcBjIz+ZiEerF
	R5R1lRIIlPo1UsrtJC1sPXP9toXLYmMaW19TtBsShpbHKNwwIPx3yn0I1MlW4S60nfmWHrCZpf2
	oRSF64I+DDv6OKSu1S+iy6pRyTDmKw59DaeYKTKSCwHrHWjFBdUOYwMdPttBrL+DeFiGHnEq5CI
	i+7SC1GfwWkehMYSKrUIc9qjhfRNyUfMCgKGHEFRYbDTrxqkoekPG2k4FdQDRiJymHPqAkIAp7M
	jLbw3VA5QtDmBVOLB7In/1+oQzaXaTXOfTmPzoqHHxL1EjQP7KQxThnTl6/uJIZ4Mt39y0pjYN3
	/BNzVMbykPU1DnLmipWfPzGuMcMGlFnOEuZJIUhOoGOoTHwdxH6pFFlmQcV7LfyloS34cHghGhe
	u7PkGsG46/PXE79bgSN08CkGnTt/eqFQs=
X-Received: by 2002:a17:90b:3950:b0:35c:1695:24a3 with SMTP id 98e67ed59e1d1-35e4281374emr13692490a91.23.1776090096314;
        Mon, 13 Apr 2026 07:21:36 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e41f17991sm4258473a91.3.2026.04.13.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:21:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ben Hoff <hoff.benjamin.k@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jiri Kosina <jikos@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	William Wu <william.wu@rock-chips.com>,
	Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Lee Jones <lee@kernel.org>,
	John Keeping <john@keeping.me.uk>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3] usb: gadget: f_hid: fix device reference leak in hidg_alloc()
Date: Mon, 13 Apr 2026 22:21:19 +0800
Message-ID: <20260413142119.2977716-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236112-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com,outlook.com,kernel.org,suse.com,rock-chips.com,cosmicgizmosystems.com,keeping.me.uk,collabora.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5DF3C3ED4A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hidg_alloc() initializes hidg->dev with device_initialize() before
calling dev_set_name(). If dev_set_name() fails, the function currently
jumps to err_unlock and returns without calling put_device().

This leaves the device reference unbalanced and prevents hidg_release()
from being called. Calling put_device() here is also safe, since
hidg_release() only frees resources owned by hidg.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Route the dev_set_name() failure path through err_put_device so the
device reference is dropped properly.

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

v2:
  - correct Fixes tag to 89ff3dfac604
  - add Reviewed-by from Johan Hovold

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



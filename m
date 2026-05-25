Return-Path: <stable+bounces-254165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP5tGWtnFGqwNAcAu9opvQ
	(envelope-from <stable+bounces-254165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:14:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADA05CC20C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EB853016CA9
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559083F411A;
	Mon, 25 May 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwhJpUAg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007403F39FA
	for <stable@vger.kernel.org>; Mon, 25 May 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722086; cv=none; b=fXsXtpnPLgpqbEmElwFcQVFb/tQCSzlnJj96+cROcJEEqIcRgQXUYI7er8AzIKG69FslJiszlyoDyKXLjmtQkbGrZbxti4d9lYmnjwbHkO3mpLTX5Mz/iyrtyXSz0si6/CIZyc20muFEr0KiOSrPaCZxzOKt4bS8Iiq5MCW77eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722086; c=relaxed/simple;
	bh=yZfleqqgRxjy4Am5CNAwgS6zya8iAH/d6o7PPJgGwaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmwTzGVkYCx+h8KrPObCWVqoMqbVFNzE7sUtknBVaLVoy+/EDX7eM6x+8IUdjhsDPC5SfvLp08z4/7wTWlIEfro2UyDyeuaIjZGf/Cy6avgnxgL1p/BkiUpuwZNUpw/iIpueR0Z11+l023ZYmlicz3OZvnBjSxo6NRWbm1f34ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwhJpUAg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so4246055a91.3
        for <stable@vger.kernel.org>; Mon, 25 May 2026 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779722084; x=1780326884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ekN9RA6xWGM9vsTg+kkP2fzePZkZ7mF7z+5w6nzPco=;
        b=RwhJpUAgVWVYMKpF+DhH7H22vz5C78oQYac7V6CTJ8G9qyEY57Ke+CzaEtAtH+qMBd
         zF3fRgQvEqwgDpnwrl0v7u/83tlWEc/bNoBg+7ZNw2zDLaL0JHoB4SMkjL/g0m3zfy51
         dL92Ctei0X4jLpmmTBmfrMb7J0S4Mc/C8Hz4UW7wUOIjYqivKrRXVZe7He8B9tgYQtPr
         pnLMY40TaXNqd9irUyws1r88LECH73N4GsOpyr1mAnKL/mZoTi3Ih7gZu97NaSUzZdaz
         QE1ClFUC4g9qswsNYw5E1IKKeH1QKtbJ8cIhprvxMRlbmWKZfV/CEuseChlQMRTwKQx+
         pTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722084; x=1780326884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ekN9RA6xWGM9vsTg+kkP2fzePZkZ7mF7z+5w6nzPco=;
        b=V1D2tbghD4G4BYbjjKb7trgSK3o98lwy4ITO7EN3GiEVnkZ7Mk7aGoo52ySZbjvloz
         jw7lhuYS89mmJgsdtDmnRH1u4i4zjR8F5lG6UxY3ywtKQmulGWxB0ZlZG2Js0qQYoagL
         emDXAVVZnoU806EcIdz2Okkyt5lSB0SEd7uJHY70+ftiRNlkz2g2Kwz0PuoNRCrtSZJp
         qhOXRjgGASm5PmJJkaQtTZdWOivZKLfaM/zDwEvlUVuiC0khFHt+DXE1u/Chv3MOYPim
         dp+BlePBrvw9kPJ20Y/cpKduIaiyt8tM+C4RHfiG1WTVwhTRD2HzeSPWhqjMPypDqLYZ
         680g==
X-Forwarded-Encrypted: i=1; AFNElJ9XMAxdkF2msJkRMTKytVD7edZTmIh5Mm35/xczTLMCMYNxy3Z/9xszkzZ1Q1f22tszQDNPQ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1Rao4MBX0PLxzxhDyQuIlyWOXs9+vD98LzsZk7jraqX8zXNv
	PzDeXb++9bPbJQURqwY8dQgOzVmHi2DTaWCCZESXTo18X+SyFFYs2BD2
X-Gm-Gg: Acq92OGI1237TyaBeMqrT9TC3ZODE9hNa0XEo8PJZd1yq2Lkfy5T5dhExyx7Dv/BxT+
	QfwT+NKOQO1W4zSVPqYjV129tTMpyR5OgsRb2DjB0NooFLz09EdyIfEUEIhx+m668z7KOIsy5zx
	iY24vUFfFBSHSCuU8wuELhyaUaGYMfOekbnWRrT9X/qlpjsLWUzBxOn4cxhGTtAD51MC4mrW/Id
	vOzJwO24sI9Fxms9R/ZoMevnP+z0Rt4gKuhmHogSbvBdE4JyhYwjCkX3UyUP13on6Ws2OEUIl6q
	YOEzeoIn98VlEW+/vRlVAPmxqu/C8+4/TVXWuKB367JJRFf1Um7kzENg856lacuoSDckFQAmruj
	O4W4fVeCQGjWRbb+C/aPVdM/GuIOWhUch+12JRlXhzrvWDWc36xNJqAgn7t+nmI8Nr6UaoMWObm
	xkWLKoLBNPZHZGnPZk18BujZB5z11zhhV2vsP2FF5yFF7h1QyXFOoWtF1QqRUBcIExq+LNlw+K
X-Received: by 2002:a17:90b:4d0a:b0:368:f0a:1c48 with SMTP id 98e67ed59e1d1-36a671e2735mr14075939a91.0.1779722084256;
        Mon, 25 May 2026 08:14:44 -0700 (PDT)
Received: from lza-virtual-machine.localdomain ([223.160.230.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7cf9sm10097658a91.10.2026.05.25.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:14:43 -0700 (PDT)
From: Zhian Liang <liangzhan5dev@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhian Liang <liangzhan5dev@gmail.com>
Subject: [PATCH] Input: ims-pcu - fix use-after-free in probe error path
Date: Mon, 25 May 2026 23:14:10 +0800
Message-Id: <20260525151410.42750-1-liangzhan5dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254165-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liangzhan5dev@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0ADA05CC20C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If the driver fails during init (e.g. in ims_pcu_init_application_mode),the error path frees the pcu struct without clearing the interface data.

If the device is disconnected while in this state, the disconnect handler will retrieve the stale pointer from
usb_get_intfdata() and trigger a use-after-free

Fix this by setting the interface data to NULL in the probe before freeing the pcu struct.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4c022a36dbe8..fce3232ebf07 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -2063,6 +2063,10 @@ static int ims_pcu_probe(struct usb_interface *intf,
 	ims_pcu_buffers_free(pcu);
 err_unclaim_intf:
 	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);
+	goto err_clear_intfdata;
+err_clear_intfdata:
+	if (pcu->ctrl_intf)
+		usb_set_intfdata(pcu->ctrl_intf, NULL);
 err_free_mem:
 	kfree(pcu);
 	return error;
-- 
2.34.1



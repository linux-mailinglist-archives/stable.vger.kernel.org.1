Return-Path: <stable+bounces-247260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKsrL+YJBmpOeQIAu9opvQ
	(envelope-from <stable+bounces-247260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:44:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B964545805
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A243300914C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603E38734A;
	Thu, 14 May 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Z8ZGBs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA32E542C
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780643; cv=none; b=k1AIr7UlykHA+FDa7N6OP/Q49RK4C9kBcc4LOdhLrsy98VDbJjOKbuKJKAb0B/37aNz/CVsYbqG2w8JXn5zKpgcrCn4QPA9AMaf2H/4kWyW4glxadYO7HmO4ojaZvo+9GUGzd4sgHMKWOs+vKdX/OJZimV5qvI+DRrAu+llyUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780643; c=relaxed/simple;
	bh=yowZezkBBgskMLosGJiG0SiaeuIzu2KjKFSMLHA5Hss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRcfANSOxTDweBeWDPbK85TyEbtA+Ip1Vfjpms0kHWgG00ZE3LIf/bf0QwoNT+e8H+rUpKK+ck6bXWhyUEi9SQhQvufQqo2LGPQmO5NE3xzeGdw7xL6X/6FQsOGl2xc5h2rp1jxENlxE2P7Odk+4jsVsCQrFqjFwQOSHMZyBgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5Z8ZGBs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48910865133so6322745e9.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780641; x=1779385441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSkQwjSClU3t6n5qA8FNKqSsPFaEwqM8tCQVsiA4MwE=;
        b=V5Z8ZGBsRIdj/uh+bgOC+GH75yPyHL9NXpm7xKpYPAbqvIo3kLWfaxZpEBBNz6NFUG
         pTwznWVmhuHQWzbnBkCcrjTRGNY1Skv7FvbmjMgW9hvv22c4QmrqaL4AST5NAuN3yM97
         tqdgJXlB52iOqcLrCDMouq2DCYQkZTWDrEtuyaNQwkJh1Jhk0qkEl1gPod1knzb0qRmS
         5KN4ENacfXHzhO1fFSG/VIMwIcv++Az73v84RID2lrGXN2Rv5NwUYxL4t5ZPxZ4EFsU/
         IcZ1Ac4jHmBu5BnLpY/O+dIICgfmHDO69IUlHPoKbxSGpcvX1Nzy6BAo1zqgz0PHY52l
         /90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780641; x=1779385441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSkQwjSClU3t6n5qA8FNKqSsPFaEwqM8tCQVsiA4MwE=;
        b=sURN8DXBSHQXHsYj34EKqZNfnj0a6m3I5MMo9JJRcG+1POXFt1MzI2sqrZ4qLWWnWm
         rzvYG7yZAsA9UqztVcn+0SHj/CVYADthubWxamxFgMZNzHnslMKpg/poXPQ3isUEOGAw
         ppJOXV1C9fEjl3qdQxd9qRyWrFGVKKI2vtEhwBqRURJZa8TRFTJmSafb21bci2UMS5oa
         8/JmUrHjtuh8PjNedHtpRYYmlMGQ/Ux0uRaHndKhcYVR6EbVeLoGe3SBblS/cajBP0Qm
         kadF6zZzCoOgY5ZAxUarsWIfLDhciJljmSovfjcYfXbSUzrNkRFwrJmXPirM7HGWGy0F
         Holw==
X-Forwarded-Encrypted: i=1; AFNElJ/AtHYGSQUbB3RVMFz+WuoctKFrJcZyExUgwIJJETJEM/EqzfB5dqO4DmKQtz5BSSAgvT2f+Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTTfF4Ryi0NEuaHC1JmsGrgpNGeqgK/11pG3zqC7+eqPr1h4p
	EcgaExGkMrxzuPj+Xgz7k1SfmaqydSsVZ+lzvNCgrSYh1yLmuf7GsAQK
X-Gm-Gg: Acq92OGDkwTaw2YhrjGOmwOhrL7QbAMZe1rBlupEY68A8OkQYerqmTZ4eY5BZi4Fo9g
	QJAcrgx2pZE5e+NbRpUx8sGPXAjAMkoetccfzv3UNvVmsi98JMHoTLTIP4u6zmuEZ8B3i/X942c
	5UqNFQGbZY+5AO8e2vNLtrFRc4Y4Xr5ncNDep8eG6YjsRzIHwP2xGlGGZU1R3psdwpFqvYAyl5S
	6dIt1kRKkyT7LnyM+3nLgEVkCUupn2MR/d+OExBCzOaWsPsoYyy6Gvtz7G5gD2BAedBDS1kKLFM
	8w2ZF+W++Nh5Kvq1DpvNm6yOfCi1Rce2KMsQ9Da1qGk/192TJVQjNgZohn1Y2dXGr4HITDUXpKu
	xTbJarF9FeHMD95WpOdamWlBS0NxKZn7zMYXCdoXprqqgzvXVtJiGIWYL2HrZCLVDCdt2pDyXLW
	/2v+xYAIHq8ddR9+GnTKO0GKTB3Z7ReC6hikkt0flyI7Cu
X-Received: by 2002:a05:600c:a48:b0:48f:c8d4:487a with SMTP id 5b1f17b1804b1-48fe63138d7mr2814385e9.8.1778780640606;
        Thu, 14 May 2026 10:44:00 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd76822d6sm22249125e9.26.2026.05.14.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:44:00 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andy@kernel.org
Cc: geert@linux-m68k.org,
	hcazarim@yahoo.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] auxdisplay: line-display: fix OOB read on zero-length message_store()
Date: Thu, 14 May 2026 22:43:42 +0500
Message-Id: <20260514174342.28451-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B964545805
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-247260-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-m68k.org,yahoo.com,linuxfoundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

linedisp_display() unconditionally reads msg[count - 1] before
checking whether count is zero, so a write of zero bytes to the
message sysfs attribute hits msg[-1]:

	write(fd, "", 0);

	-> message_store(..., buf, count=0)
	   -> linedisp_display(linedisp, buf, count=0)
	      -> msg[count - 1] == '\n'  ; OOB read

The kernfs write buffer for that store is a 1-byte allocation
(kernfs_fop_write_iter() does kmalloc(len + 1) with len == 0),
so msg[-1] is a 1-byte read before the slab object. On a
KASAN-enabled kernel this trips an out-of-bounds report and
panics; on stock kernels it silently reads adjacent slab data
and, if that byte happens to be '\n', the following count--
wraps ssize_t 0 to -1 and is then passed to kmemdup_nul().

linedisp_display() is reached from the message_store() sysfs
callback (drivers/auxdisplay/line-display.c message attribute,
mode 0644) and from the in-tree initial-message setup with
count == -1, so the OOB path is only userspace-triggerable via
zero-byte writes; vfs_write() does not short-circuit on
count == 0 and kernfs_fop_write_iter() dispatches the store
callback regardless.

Guard the trailing-newline trim with a count check. The
existing if (!count) block then takes the clear-display path
unchanged.

Affects every auxdisplay driver that registers via
linedisp_register() / linedisp_attach(): ht16k33, max6959,
img-ascii-lcd, seg-led-gpio.

Fixes: 7e76aece6f03 ("auxdisplay: Extract character line display core support")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/auxdisplay/line-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index fb6d92941..915eb5cd9 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -173,7 +173,7 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 		count = strlen(msg);
 
 	/* if the string ends with a newline, trim it */
-	if (msg[count - 1] == '\n')
+	if (count && msg[count - 1] == '\n')
 		count--;
 
 	if (!count) {
-- 
2.43.0



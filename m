Return-Path: <stable+bounces-235707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JjOENkg2mnEyggAu9opvQ
	(envelope-from <stable+bounces-235707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:22:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F73DF4CD
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4843303CE01
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745B33B6DB;
	Sat, 11 Apr 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0kxDyK8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF825524C
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775902845; cv=none; b=af2st7v/b80M7iwwE+wWNei0RMY/u1zG4ge9/cV3vLMhNul2nxbtHCH4m7+yvYD7PG5A0zY6UKG5Wboq/4DVmjhX68HHGAHTXc7UixNizVasuLT7fRtGA50mIwZ3feKNJsG89WeXwPjzwrhUFeY28ab/ER1weZuAufQc1dL2JS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775902845; c=relaxed/simple;
	bh=v/MHjmzIaGHN4Qn7xMSgzvsQfHk+V7OhpRzw6XqcYq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqeNkEC4hvz7fvVLX7YehgXbWTVnXEc1mgUakxTNt7Qg7HOpDrz9Ccl5/yOnja4GCYnPMRClT5zLBSbatQ/vx3J5esjwVhpeWcn5t3o4BmvtZmZzWpUMRnTL7759cX9ZFjh7RZjBT9qXqIbaixau5T77YKBPO+Gdq2UfvUPpW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0kxDyK8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so44913085e9.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775902843; x=1776507643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bcNm6kUH/j+VOxDc1J57rxd+Hi0doQAdioZZTWHdjs=;
        b=R0kxDyK8CBy7CY0Ljiie5zV5y8kz0uD6O0D/ejEWpkTeGuP3mB8CxAEz/rHPSILvUj
         i0WovglCZpzdwKs2HFhI9tvcSYnzL6iKkOhcmIz9hnSjuqPzZzsNspvR1Z6OnbB2nHSY
         MCrw8ggqn1hzkpD0SukraeLdEolriMz59D9exzgWSqolLGiz1snQhaT/FHR0i5pW/pAi
         DYxo9LLIxfgMqGkrWI8yz5jCIKIX+bC4b772gqk0Mdwpjd4hc7cFGs1OcKvksbBiYUqD
         60gBGkBbBipTRsOmzw4HFvbSAtqpH14Ly2j8jQ6sukiJoiG2Ac7ZSNqWXI2OmtfBYxoA
         Vujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775902843; x=1776507643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bcNm6kUH/j+VOxDc1J57rxd+Hi0doQAdioZZTWHdjs=;
        b=QRHhUgFgu8sIIRNT1bstG8kfL0jkD/yno3Y4pV3uI4lwvGwxROz7vH+rjc8J/gW+OC
         hJPivKFOwv4zOd7NO117MKJYD9slezomQe4Hgm36aEEM8YtArl2uBweLTk13ZIhE5xUB
         0mmWJD5BtxqpRFEgdGGJAKNNplAONfVipFBp/itU1ylAcLFGBJVxjZVI3TYeWmGrYBfh
         C+bFL10WCgHdEV4SM28i2Q9cbBV5OEikBEBAKRtwbR9FCXhjxYon0KoN7yVy5Lk7qGnL
         YNPH7MJv5kLUI01SEQ7iE4hxRqSBPZXqFDHHJ6zQQeu9TjZqQLLgvkdhaq6vGbkCfCoo
         rbzA==
X-Gm-Message-State: AOJu0YxoDWz+v6Vb1UyiR+EVF2zG2N3eCpyOBzb6H5wEm48+0bEOMlz9
	LiuLa5hr3/BOczsIXvZg4+NPNMwi04kHLqQfHNI/XRKwW8CjsL6QcG4B
X-Gm-Gg: AeBDievXHr9aQRw8N9MRqmYa+7VvuWJguMr+lg9FYTI5huEGUDiEu05waj3BqT41QJb
	PCf31Q7v6IXrw9IvSR4WvoDlUXwFm7NDuA/yOD0121NscZJdAaYVf5WuLIzQnHuA0KIssLcqoVl
	ZJl7ZgXNHje+JjNljVpr4NVHLUpnq+uNZJy+/tvNnURdnBa00SylF6L5i/24bRrs5is4c1XFKQ3
	gBKPqsX+axQLv/x+eGoVVW27ogyF27yq+sunWKqrmIrbYamiM5WLFePzX9ud4PxKJcae/eFjdLY
	OCLEdTDlQDreyEhXsdQq8eSkahRpTMw4oh4rN3dmw3+/QWUvQRIj5FxOa1ohCtQq3jK3tNqC/Ar
	rGDfMkEGvb+x8GOcweT3/6GF/9D151aWNYi/k9UJZRusAb84FExQ8W/U6CFnuWK2CjOeRCzZwqr
	lpsTdA9tND+914uTibowu5zNKT1UHbv6Es+C4Wl1I=
X-Received: by 2002:a05:600c:3149:b0:488:ab26:8fe0 with SMTP id 5b1f17b1804b1-488d68432f2mr84578065e9.15.1775902842815;
        Sat, 11 Apr 2026 03:20:42 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ec15sm41856945e9.20.2026.04.11.03.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:20:42 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 1/2] gpib: Remove useless code
Date: Sat, 11 Apr 2026 12:20:24 +0200
Message-ID: <20260411102025.2000-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411102025.2000-1-dpenkler@gmail.com>
References: <20260411102025.2000-1-dpenkler@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235707-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B52F73DF4CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This code is a hangover from an earlier approach in the
driver where the driver modules were called gpibXX
It no longer serves any purpose.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/common/gpib_os.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpib/common/gpib_os.c b/drivers/gpib/common/gpib_os.c
index 2b4ec6aa893b..fca181b8c749 100644
--- a/drivers/gpib/common/gpib_os.c
+++ b/drivers/gpib/common/gpib_os.c
@@ -544,13 +544,6 @@ int ibopen(struct inode *inode, struct file *filep)
 	priv = filep->private_data;
 	init_gpib_file_private((struct gpib_file_private *)filep->private_data);
 
-	if (board->use_count == 0) {
-		int retval;
-
-		retval = request_module("gpib%i", minor);
-		if (retval)
-			dev_dbg(board->gpib_dev, "request module returned %i\n", retval);
-	}
 	if (board->interface) {
 		if (!try_module_get(board->provider_module)) {
 			dev_err(board->gpib_dev, "try_module_get() failed\n");
-- 
2.53.0



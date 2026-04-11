Return-Path: <stable+bounces-235716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDzeMSQ+2mlCzQgAu9opvQ
	(envelope-from <stable+bounces-235716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:27:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEBF3DFE30
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B23302C5FF
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296132E8DEC;
	Sat, 11 Apr 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpY7rEit"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C0231836
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910097; cv=none; b=LPU/W8uwvJI50xm+HY5K/bTQmp0L1zBad7En1rBYCwArR7mBFocS8EZuQn1QbAzETK75gRbrDGS9RCFAoRggE7q3HDQOCF6fXNHpQe9mDqrEoxrdHfHTdsfgoJl2egqJEHF+1PPc0xsbJVOmjIcfwPaYHrwEc9mKk5FF/ONJuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910097; c=relaxed/simple;
	bh=dncHFYmx2lD4i3iuabbimop9yucPCZTFPtZn1GhKhDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJ1vIWb05cUYXUcE5xe9RurTYmgTB06AqBUYvpWhV3pWP51HhAyKgQguy871acrTU8SI4Qu6svq8pcl8r7H4+1YlKmsny2z4kNh4ZW2toROGheT2uMKshEDs0CXH6iymbwEb+6UVK4H7vitVAkwiFaBwlww5KiMd2sGoYAYmfF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpY7rEit; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so2819182a91.1
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775910095; x=1776514895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDhxS46WB9cNJon+ZSJd5o32lpx1Hn2DEDhx5qw0Ti8=;
        b=OpY7rEitu0d4P4Sc61G18lhUFoY544YoI4iGieCEeHFZbGTfYBPTz3ZYuvbf69lPn0
         1KszIrTxk6WF30wYWWGj6fYpPcy72RKcrb2mfQYl1qdVSlmpPFFbKQeRJzvrNIymI6kR
         LNX95op9oDWffeXYfaxRtyInuPxgsFlCqla4Pded1oj3zU7Wfeve/lX+TaGGG3HxiqCA
         vp6hNkrGPfwy2TiVSLw4U9VAW2DZUZ/fPO7OFStSS96IHTRJXobQ7MLxjvKjeYajvU5Z
         XdH6nBzFomgGYCFzAs+EyG9gfHyAQ72FzJUF/La+jjaBEcZrhZJ3un6AAoABur88PG4t
         +eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775910095; x=1776514895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDhxS46WB9cNJon+ZSJd5o32lpx1Hn2DEDhx5qw0Ti8=;
        b=n5hI6mWLW4kq+l2wMpxSHjXOlc9djzF4y+yNcXBDVTVZ0/Drw7wXEvvtUCkuXnxxxB
         E4jBuXjIB7fM7j2Gr2wTXjVkMu+t+M7VbX1nmYMvz7RclcM2RtSAhRuUWmp0s6Omwih6
         DBpAjZci0Xw9sTJoL7g1kFYfL4rpMunf44hnHYv2ZKVhbrvViahZbFmqxHIeo8K5RKqw
         sB1ylNnhmBKj6GjUPEsf8pb3uneaRfGJvLJ6bLT5DPqRwte778uuD6aHsI2ZlUj9Oqy4
         nXZtrOM1wd63xw+Z5DlGcXXDHhIs13yFg3eQAW8cHE/CMWjVyqHXWCB8iQ218L6MKJ8g
         2clw==
X-Forwarded-Encrypted: i=1; AJvYcCX1+azWIQ/n378bJyuKH9hBRAKnlYUZDGx9Zd6NeM4WExXC4tbMdWlkSGb0uXlCH/7m0PnwfOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpemYqMNbfvaJToyErowNdDa5LxXeffMQ0DVKA3VWGKlmF3wm3
	nOQkJzJoZQr+CENfoMbtIxh+P5TIcqd6wJB0LM03jIxpA+wfOQOwMR7q
X-Gm-Gg: AeBDieu98QDgnk23SQeWNQLtr4/JV8sbHjOh+2F8yo2RMx3ewThhq0o964jXhcNYxOy
	EkpOWQK6mVPvbw44nFJ6IKu2atSFDfW+Fs8TixtFmQW2rOCku6N2ILiEcP0Nlewj+rKXrFIaOdt
	VLTuwZWe0K6KUDmgZ4Fvh3XA2BeWDpdsxFnHAQpkeZxufvNn7d1s3sJSPd0mGPswBunvE5COH72
	yiW4ZTdmR9crkTV+P7AXeBsgrrAmEadByKZwQTd8faAR/wghS/eAcS+8PApg5+3L6mN+T8XxkcV
	6dFHyiwQktB+HYTSsF7y5PIEIsqGnbuNp1A5pUEXyJ9Apv2lLYKU2lrfSm/onUV5g3fqp6dPSdR
	r/dwDJCj3tpCdjjrnef0MSqyTr+E2kFGInP4L5ToupTij/EwZH1fTYkOHg4zRoTiBzPuwA67RYu
	7lG0lY5AIyTDGZQxw=
X-Received: by 2002:a17:903:3b51:b0:2b2:42da:25cb with SMTP id d9443c01a7336-2b2d59aaa97mr50470925ad.19.1775910095243;
        Sat, 11 Apr 2026 05:21:35 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0a393sm60736815ad.40.2026.04.11.05.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:21:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"J. German Rivera" <German.Rivera@freescale.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Alexander Graf <agraf@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: Fix refcount leak in fsl_mc_device_add() error path
Date: Sat, 11 Apr 2026 20:21:18 +0800
Message-ID: <20260411122118.2196540-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235716-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BEBF3DFE30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In fsl_mc_device_add(), all failures after device_initialize() jump to
error_cleanup_dev, where mc_dev and its associated resources are freed
directly instead of releasing the device reference with
put_device(&mc_dev->dev). This bypasses the normal device lifetime
rules and may leave the reference count of the embedded struct device
unbalanced, resulting in a refcount leak and potentially leading to a
use-after-free.

Fix this by using put_device(&mc_dev->dev) in the error path and let
fsl_mc_device_release() handle the final cleanup.

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 25845c04e562..6d132144ce25 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,11 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	return 0;
 
 error_cleanup_dev:
-	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	put_device(&mc_dev->dev);
 
 	return error;
 }
-- 
2.43.0



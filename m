Return-Path: <stable+bounces-166691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA7BB1C2E7
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 11:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8AB18C1D5C
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E148228A719;
	Wed,  6 Aug 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qb6Z8smB"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7C1F9EC0
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471170; cv=none; b=SrCJ95WkzWYuo5HTS9WPTc0eac9X0W2w4OXHavdVq2+xhA+hCI5cCztaye838xwsZpZLR/3K6WT9OSBZPa9JlcbgnRfoWztCH9TfOUZYJoRLlAapiB/FjDWYRsDeotlTkt4Ie3pug6bz+1a6/fupqfiWQjBE8QUu8j56sgLhlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471170; c=relaxed/simple;
	bh=gUrJ9cn4Pe/bhEdgkhZVA43480O1QgPBFx85hAGe4T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyJDhObekC1Hj9s3j7gjMVR0lV9kVPYJeJ9fvckl2vd8Ir43BBIZ9Pk/PTsm8qnjoOjgRapiZlO9qRkMBhEK+SbEa/trGA6mTmqMFH385vZi7QD39vRhCN2AJ8nD1p7jvSc0HtpQUa+0NEyulpB0AZtFAb0IqSPqbBnDw8eiKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qb6Z8smB; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754471163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fQl06gM0vFWsGEKl06dPGs5k/6Zlv72uEjuzIVb1fys=;
	b=Qb6Z8smBnQ7m0nikI2EIbHAxM/AeGJETlZ0/M6yVpeO2nsV9FbmcJC5JPlWGB+k53fnAxW
	xf0qdb7I8D7DQIPewdH/lWmMbPkJX4FbvYHmPf0hHGUJFksYpxTTCPdxef4/z/RI10JP9y
	FgIvacuhjLou+w84uFk2LQhN8swoFzY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cdx: Fix off-by-one error in cdx_rpmsg_probe()
Date: Wed,  6 Aug 2025 11:05:09 +0200
Message-ID: <20250806090512.121260-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In cdx_rpmsg_probe(), strscpy() is incorrectly called with the length of
the source string (excluding the NUL terminator) rather than the size of
the destination buffer. This results in one character less being copied
from 'cdx_rpmsg_id_table[0].name' to 'chinfo.name'.

Use the destination buffer size instead to ensure the name is copied
correctly.

Cc: stable@vger.kernel.org
Fixes: 2a226927d9b8 ("cdx: add rpmsg communication channel for CDX")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/cdx/controller/cdx_rpmsg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cdx/controller/cdx_rpmsg.c b/drivers/cdx/controller/cdx_rpmsg.c
index 04b578a0be17..61f1a290ff08 100644
--- a/drivers/cdx/controller/cdx_rpmsg.c
+++ b/drivers/cdx/controller/cdx_rpmsg.c
@@ -129,8 +129,7 @@ static int cdx_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = rpdev->dst;
-	strscpy(chinfo.name, cdx_rpmsg_id_table[0].name,
-		strlen(cdx_rpmsg_id_table[0].name));
+	strscpy(chinfo.name, cdx_rpmsg_id_table[0].name, sizeof(chinfo.name));
 
 	cdx_mcdi->ept = rpmsg_create_ept(rpdev, cdx_rpmsg_cb, NULL, chinfo);
 	if (!cdx_mcdi->ept) {
-- 
2.50.1



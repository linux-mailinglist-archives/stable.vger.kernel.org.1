Return-Path: <stable+bounces-177770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B4B446F9
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 22:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF250AA084A
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804E27A928;
	Thu,  4 Sep 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifRrZylz"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0427C150
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757016397; cv=none; b=UCQL8MJynGx1bjEgtkczSeeoy0JGGKETDUhFghaqy/0kidCFS7BXftJAknacrZx/Dh6TGUVJridTtK0j7TcQs1fZnMl+sIUxDB+F27rTip1IwRJgkRuevAfNXhjlq9xJO4AMhpjS/StG/yYtPNHuX64PJjw3zm/a4JTa7I3Wi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757016397; c=relaxed/simple;
	bh=L6pJCJRQlpGz4vRVZTttL4VLEPacbukwogeVseG1pvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Blk7iKgI8AqNeBAyffP1glT1Jy4Sl3robOaQjC6qs4CFjfDgkRbTuIp2c/diEBsWlTa/AS8Kd6RmV9m8UzIxeRmB4/a/BcxnnhCKCVenjSiTzqhDwV8QGMJDe/iT02kWEJBJ1O3mlKiNydzbY+GWSkVxIjCf/G86Y5TUw86zPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifRrZylz; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757016393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5OCK17bkD8uC3U/dYZyCUkvEyfsk5UZB3M9kPb7WAEA=;
	b=ifRrZylzsXqQIk2kH8MX03L8RIZiFrdSjK+p1QmEXrAR6dxmNEEdtGQPu3Oi3oXrC6+6TT
	HHGf2rulwEMZtIl83+4GZpFJUEUw4dcawGz+effGaqdijf+NsLEoTSaSpIdXevT2pUYo15
	SjLksRMHTBkBx2M4UvSCs2oDTB90feo=
From: andrey.konovalov@linux.dev
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH] usb: raw-gadget: do not limit transfer length
Date: Thu,  4 Sep 2025 22:06:30 +0200
Message-ID: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

Drop the check on the maximum transfer length in Raw Gadget for both
control and non-control transfers.

Limiting the transfer length causes a problem with emulating USB devices
whose full configuration descriptor exceeds PAGE_SIZE in length.

Overall, there does not appear to be any reason to enforce any kind of
transfer length limit on the Raw Gadget side for either control or
non-control transfers, so let's just drop the related check.

Cc: stable@vger.kernel.org
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 20165e1582d9..b71680c58de6 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
-	if (io->length > PAGE_SIZE)
-		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
-- 
2.43.0



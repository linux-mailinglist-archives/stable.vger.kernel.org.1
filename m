Return-Path: <stable+bounces-109542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B294A16E20
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF95167AA2
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1CC1E32B6;
	Mon, 20 Jan 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPfUMLTu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rETqDUmD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9191E25F4;
	Mon, 20 Jan 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382193; cv=none; b=rSa3BlIKFg4Ca+RXy6MyH4mgHgk5I1QC5BeRIZLOqP8Q2DiJo6d/rXBVfzIPxUggGjvxs0kFsW40qOjL2MWC158yYGSSciPS2RXbhk+8TPnDE7M6f42fY3l4FtnAUd+qNnNxWXVAJSTmK3mk1r+fZU91R7WvtBR7SzVuGNCINeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382193; c=relaxed/simple;
	bh=iO54gGGAG5AFoGnuF65FTvlTPDdABM86p8xV86UBslE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5hG2nUehklq9FLG//H4MGSGHBj++hlWkV/7T7B3ofDGGi0grNT8/AAO0Bu/+JG+XXL2PkDWhS7IvW2UFCNw+x6c+US4D61Emzy5FREfuXr0XOuFJCbsk9RYugn7/kiUXinIRGazwK8c3pNvJ+ar+5Of8KKM7PI4iwMw+jcnHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPfUMLTu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rETqDUmD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737382190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra6oY9qhR7iHUWWddvK05MGuCrM9P5GPJWJo5lGlMCQ=;
	b=FPfUMLTu4TzoqMngodlfbdtfcQ0uolfqZtKIyHGb5aNGX9XR2ik9XItHrNnElj3cTj7FSH
	3kYXu1P8FUATE2B9xw/seKQI6jkbbql+oXYLqRxGZGhAB0PKqyHjcZxtoAMq4f7ozudtN2
	VXoGQ9l3vpOfL9QJtYohfMmfCz3WNwch9x7p9k8DVUmSKii0Decz4xy/gX2epKY+eGV3Kh
	GPUrDaUQFVlUqBmX6PA4PlC+ECc5NvbVWPzBQ7Tu6Q4pUiVBF7KQnTMe2gpvYReYxDZ4O6
	yAmnwj9P08kl9MzYP2Pbkuj1yeUwcJfj8LlqlTrT0/Ba64b+EQw2u0bHW6O9oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737382190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ra6oY9qhR7iHUWWddvK05MGuCrM9P5GPJWJo5lGlMCQ=;
	b=rETqDUmDZvLlzeO/KpLSvr/GSA+ZR9whoBvW5IqIpuXM3omvAZ3livm8TenQrzOdA7uUDa
	jxmyadfJR9FB8UAQ==
Date: Mon, 20 Jan 2025 15:09:40 +0100
Subject: [PATCH 1/2] of: address: Fix empty resource handling in
 __of_address_resource_bounds()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250120-of-address-overflow-v1-1-dd68dbf47bce@linutronix.de>
References: <20250120-of-address-overflow-v1-0-dd68dbf47bce@linutronix.de>
In-Reply-To: <20250120-of-address-overflow-v1-0-dd68dbf47bce@linutronix.de>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Basharath Hussain Khaja <basharath@couthit.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737382189; l=1515;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iO54gGGAG5AFoGnuF65FTvlTPDdABM86p8xV86UBslE=;
 b=ms5GmHavQ/k9IGC17cI2VD5Ki7AhyZyowb91MShGXolACbUT42f6oWYncR74vQX4/GEQFPSmN
 KLSJT2Fo2ztCCXUuD/r4skqqkiJD67vBt6C+KaZdRhh4AS9JgPpXCwb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

"resource->end" needs to always be equal to "resource->start + size - 1".
The previous version of the function did not perform the "- 1" in case
of an empty resource.

Also make sure to allow an empty resource at address 0.

Reported-by: Basharath Hussain Khaja <basharath@couthit.com>
Closes: https://lore.kernel.org/lkml/20250108140414.13530-1-basharath@couthit.com/
Fixes: 1a52a094c2f0 ("of: address: Unify resource bounds overflow checking")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/of/address.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8770004d9b085f1ff40f693d695d284a6ef3dfde..5c0663066a7f3816a05077f99124ca25e3c152d7 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -200,17 +200,15 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 
 static int __of_address_resource_bounds(struct resource *r, u64 start, u64 size)
 {
-	u64 end = start;
-
 	if (overflows_type(start, r->start))
 		return -EOVERFLOW;
-	if (size && check_add_overflow(end, size - 1, &end))
-		return -EOVERFLOW;
-	if (overflows_type(end, r->end))
-		return -EOVERFLOW;
 
 	r->start = start;
-	r->end = end;
+
+	if (!size)
+		r->end = wrapping_sub(typeof(r->end), r->start, 1);
+	else if (size && check_add_overflow(r->start, size - 1, &r->end))
+		return -EOVERFLOW;
 
 	return 0;
 }

-- 
2.48.1



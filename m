Return-Path: <stable+bounces-133436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06C0A925AF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E9F3AE294
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298982561A2;
	Thu, 17 Apr 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iyE01OOe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FA71E1DEF;
	Thu, 17 Apr 2025 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913071; cv=none; b=Fa6xfwz1liRMWno4756iu9EsD3aHk68NSZy9LrRQytaQFR5MH2oDT+dosYiRheww2px8k3vKkWixZwoBBv21kPx4FKntM09CkpN8BrFq9yyfoHHB6lfx4uLZHYQxXOBzD+031R/bE/puhYO3kDHVCN8iyd7dED1zz/92FjMHPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913071; c=relaxed/simple;
	bh=p53TzXtcMlu7BaPX8X0M2POZi6m4MdIV1Em9DKBKCxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VETMI131NAaXzWdIh4Iav9NXfAdez5qTBXYv4W5FVkxXiqyZ2IyD7NMj6DVcg7u4GuaaL4HtIT7u8Ej568ezAIyqvZN+PTwrj/haNDUHp15+ta9oS7fxU1ADyK9L+emWYVvRVFYZXWAXVLlBKDuXBkeBKnat3mpoVDW6FEokmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iyE01OOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CC1C4CEE4;
	Thu, 17 Apr 2025 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913071;
	bh=p53TzXtcMlu7BaPX8X0M2POZi6m4MdIV1Em9DKBKCxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyE01OOeRYAvSqeyu4lEvc0Kfl2tQlpnk8KQ4pZcizl+4SPiIDzo1wUY2O/5bwSN9
	 lVoQzw3VN+Rz7kAhnGw20+q1kTLGW41x/Sf2JNfKI5hW32COVCOeqVMJLpPZS5qhsb
	 f1pIcUmspc+9jpasKsazdhMbYyRBqxKvJOtGP+/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6.14 217/449] auxdisplay: hd44780: Fix an API misuse in hd44780.c
Date: Thu, 17 Apr 2025 19:48:25 +0200
Message-ID: <20250417175126.706998383@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <haoxiang_li2024@163.com>

commit 9b98a7d2e5f4e2beeff88f6571da0cdc5883c7fb upstream.

Variable allocated by charlcd_alloc() should be released
by charlcd_free(). The following patch changed kfree() to
charlcd_free() to fix an API misuse.

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/auxdisplay/hd44780.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -313,7 +313,7 @@ static int hd44780_probe(struct platform
 fail3:
 	kfree(hd);
 fail2:
-	kfree(lcd);
+	charlcd_free(lcd);
 fail1:
 	kfree(hdc);
 	return ret;
@@ -328,7 +328,7 @@ static void hd44780_remove(struct platfo
 	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
-	kfree(lcd);
+	charlcd_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {




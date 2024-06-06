Return-Path: <stable+bounces-49430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA78FED39
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CADB1C2239A
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D261B581C;
	Thu,  6 Jun 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DoTy5vHe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A271974EB;
	Thu,  6 Jun 2024 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683462; cv=none; b=TK+CnoNJGJGpe4jRxn2K2A5QxV2DBChDwNFfSVQKNiJC8c8FKM31+sC5xagXoFH2G6QNBLxt9QISwV0EgEQaG9U2nmhj9nolRewAS1NH1FKEOJpBbX/U9KjK/tqFiK6/B+ELd31XHR4V09s1NCEhV75P5iQheEV1HocccDJe9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683462; c=relaxed/simple;
	bh=Nfx3rUFm+xBy9mP3yWtbEVdfRnqVETlaqNt2E32hICc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jx+MFL6TKdHrpcXi+keBYDQus5ONJi9aHy7qTRKr5I+ad3SOLv3j87TXKLHMbWqrNnScrDWYQEFmZo1vD09/a0qoLRmCmJyi9lR1foZHGe7xY/mUHfL51f9NgWsuVcKcsQ0ciQRWMXY3ccqD59BHMUkmkF9A1UazQtJKx+4pRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DoTy5vHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89E1C2BD10;
	Thu,  6 Jun 2024 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683461;
	bh=Nfx3rUFm+xBy9mP3yWtbEVdfRnqVETlaqNt2E32hICc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoTy5vHeifUPXnrVZUQXgQ7N0Lok5MFbr2Ff04amIswaua7s00h84+gCAx+v0I2t4
	 /8niarIlurpsygKDQ13/N0UWjlHtFOmZ6MDDjXxB73tlEUiZyJ3tiyhLVHXngmCJ/k
	 bW19MKMTSy46WCwdvG2n7n30BZ9A2DPl8GaXufjo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Jean Delvare <jdelvare@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 406/744] firmware: dmi-id: add a release callback function
Date: Thu,  6 Jun 2024 16:01:18 +0200
Message-ID: <20240606131745.484694189@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit cf770af5645a41a753c55a053fa1237105b0964a ]

dmi_class uses kfree() as the .release function, but that now causes
a warning with clang-16 as it violates control flow integrity (KCFI)
rules:

drivers/firmware/dmi-id.c:174:17: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  174 |         .dev_release = (void(*)(struct device *)) kfree,

Add an explicit function to call kfree() instead.

Fixes: 4f5c791a850e ("DMI-based module autoloading")
Link: https://lore.kernel.org/lkml/20240213100238.456912-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/dmi-id.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 5f3a3e913d28f..d19c78a78ae3a 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -169,9 +169,14 @@ static int dmi_dev_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static void dmi_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 static struct class dmi_class = {
 	.name = "dmi",
-	.dev_release = (void(*)(struct device *)) kfree,
+	.dev_release = dmi_dev_release,
 	.dev_uevent = dmi_dev_uevent,
 };
 
-- 
2.43.0





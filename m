Return-Path: <stable+bounces-58366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E777092B6A1
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9133C285656
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30641586C7;
	Tue,  9 Jul 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n8jfPeXk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6B158D84;
	Tue,  9 Jul 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523719; cv=none; b=c3RO8XKKI5cL7DMf1kmmjkJCJ5gb6eGYv3MygYZ+y9ay53R6MD0malBhk4mFwzUq1TNlbXg5cXPZKKz+8iJCGDA2VmjpOeA0ta/g2PvCk3G4gTY/c0hLm5spKlyos5AYUhh5yBRrksqc3ncwjqtRpDbqin7Ou1lNhFLckAuXRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523719; c=relaxed/simple;
	bh=0+qO+fK7VwkUAfVZlen99svfGgpK5otXdSRCw74Ndh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFTCuj8PVr53FtXkqC0XtyeFADNiLjdo8RUvRQzZWmCFMYO/vj2gyv8+v7jm06TwC2HmhHm2Da5jD1kAwUJSWmZ0PCQgpX4d11ioYvFGvVACpSvQeBovFwNwy4rMMHKajHotML5vQ/IPAlsc+W2skfEhWaqT+/HIkfzY/sn1K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n8jfPeXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694E3C4AF14;
	Tue,  9 Jul 2024 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523718;
	bh=0+qO+fK7VwkUAfVZlen99svfGgpK5otXdSRCw74Ndh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8jfPeXkvjrHQAr+Qx3Bqth5+zL8P5lwwDdIPB2GK6Z+steSwMxVSeEMFpY4a3drL
	 BItbKcNmiOeAohxTVSe9BXz8CZqMrIPHlsq7pbEze+/PrAQhQ9dmFHEH1KvMDEFLnp
	 W5X1Y0XdO8cFp37yKI+SP+q6QS/yANuWN02RDHVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 054/139] s390/pkey: Wipe sensitive data on failure
Date: Tue,  9 Jul 2024 13:09:14 +0200
Message-ID: <20240709110700.258731812@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

From: Holger Dengler <dengler@linux.ibm.com>

[ Upstream commit 1d8c270de5eb74245d72325d285894a577a945d9 ]

Wipe sensitive data from stack also if the copy_to_user() fails.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 6cfb6b2340c99..d2ffdf2491da0 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1369,7 +1369,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (rc)
 			break;
 		if (copy_to_user(ucs, &kcs, sizeof(kcs)))
-			return -EFAULT;
+			rc = -EFAULT;
 		memzero_explicit(&kcs, sizeof(kcs));
 		break;
 	}
@@ -1404,7 +1404,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (rc)
 			break;
 		if (copy_to_user(ucp, &kcp, sizeof(kcp)))
-			return -EFAULT;
+			rc = -EFAULT;
 		memzero_explicit(&kcp, sizeof(kcp));
 		break;
 	}
-- 
2.43.0





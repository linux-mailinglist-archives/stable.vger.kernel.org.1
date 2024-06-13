Return-Path: <stable+bounces-51927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84791907244
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319011F216F0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A61EEE0;
	Thu, 13 Jun 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhXc7tbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24991EB30;
	Thu, 13 Jun 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282725; cv=none; b=lqNdO6+L+1tSkSOu6I8chj5LCrpLx31zPpsQjKHoNaPRENBYC7AGH4zjxn5NMTyB9GtR/8BzOOM5G5GvUJm/lIdFyJXt3BoiUkLyMXi3HmFd9+ogLmLekeWmla62MykVTTI68mmPIXtcUNevqKKmlRhXrUXtjGBhw5Fq/GSRAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282725; c=relaxed/simple;
	bh=1nOrWV+IjFBfL7zU/PW5GrTfEGNNxSilD9cDfv2PE+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp3j8zrWQrmF2CxwC2UvsdPDL4keWausZQNq7XcbkEYUr4OOREPViEaWvfnhlKn+93qLOCP/Z3N3X/wjAoCIpkWplWKE4x57QOCOMcXlVVG/Tq3UKUeTk5sA+68K41jTPUbsxpJ1YYIiiJC/GzEvNcfOupQVx18MSr3plaTPLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LhXc7tbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FECC2BBFC;
	Thu, 13 Jun 2024 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282725;
	bh=1nOrWV+IjFBfL7zU/PW5GrTfEGNNxSilD9cDfv2PE+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhXc7tbWWcSopVDAPMlV/Tio1chH7dntIyUZdj6OX8f5D8cXT09n/9UyIOEVxen8p
	 PaVuSk0YgbKQWd5ypkUP2mU/FCp9GqCy3cAgZnnldaWXxfjRw0j7ZhNyarqV80Yxga
	 S3D2nz3zmropkW3ksGImIWRNfxQDyicVsv3PzCdk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cai Xinchen <caixinchen1@huawei.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15 374/402] fbdev: savage: Handle err return when savagefb_check_var failed
Date: Thu, 13 Jun 2024 13:35:31 +0200
Message-ID: <20240613113316.724798965@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cai Xinchen <caixinchen1@huawei.com>

commit 6ad959b6703e2c4c5d7af03b4cfd5ff608036339 upstream.

The commit 04e5eac8f3ab("fbdev: savage: Error out if pixclock equals zero")
checks the value of pixclock to avoid divide-by-zero error. However
the function savagefb_probe doesn't handle the error return of
savagefb_check_var. When pixclock is 0, it will cause divide-by-zero error.

Fixes: 04e5eac8f3ab ("fbdev: savage: Error out if pixclock equals zero")
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/savage/savagefb_driver.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2271,7 +2271,10 @@ static int savagefb_probe(struct pci_dev
 	if (info->var.xres_virtual > 0x1000)
 		info->var.xres_virtual = 0x1000;
 #endif
-	savagefb_check_var(&info->var, info);
+	err = savagefb_check_var(&info->var, info);
+	if (err)
+		goto failed;
+
 	savagefb_set_fix(info);
 
 	/*




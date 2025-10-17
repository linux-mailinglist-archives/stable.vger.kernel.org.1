Return-Path: <stable+bounces-187546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3853BEA549
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214181884E03
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A31A9FB7;
	Fri, 17 Oct 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2JXAWjQy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A2330B1E;
	Fri, 17 Oct 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716382; cv=none; b=E1HTdsdpdLiOkOVMswd+cKg9YNRYkY7GYvTxj/4L3BDbssW8cwoltb5pkug1b5IlPUiWldknLVOSLXaiB6AmnZHd19kbIxxRGoayEgluRIekeXxIDDsBJYeKe26DaYWUkGtPpMGcQBObtOpdsDkjRN/DbCsakeVZJuoc3ls43rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716382; c=relaxed/simple;
	bh=rsqAAjT3XsIbOnYuzWFjmVU1RM8DIx2934+/gQdI2S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVZcSrMo8+l7mTWSdykK47u7JYQHIZtU2cCxjFdzQNnPR5qJKhawM/9SPu8Ow/TFsyJ63VrKtt9cnqgJnzPHdJiYnRLGIVxS3brsfgBF0ATOmPTrN1uOwee2zu788B/MRnLqxd2PefRF8jGD6CPnbaoNtmK3LsIEE9WIGUSVRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2JXAWjQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1104C4CEE7;
	Fri, 17 Oct 2025 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716382;
	bh=rsqAAjT3XsIbOnYuzWFjmVU1RM8DIx2934+/gQdI2S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2JXAWjQyJ6Ad7mfOYmcs+HLaz1Jsz+ljFZ9rSRwcUjCaaw4ATshVaXfxejkO/SQ6v
	 mo9ULtSPb1b4jqujTJ6iQ3CuI4TgKk8CXEnxC7QsW6ius4vDVuzd3lEfDEFu04k/i5
	 Z9RBkODDPqGW0p+W2lKi+Gm+7GbdTyYnVHZHTtlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.15 171/276] xen/manage: Fix suspend error path
Date: Fri, 17 Oct 2025 16:54:24 +0200
Message-ID: <20251017145148.714572775@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Lukas Wunner <lukas@wunner.de>

commit f770c3d858687252f1270265ba152d5c622e793f upstream.

The device power management API has the following asymmetry:
* dpm_suspend_start() does not clean up on failure
  (it requires a call to dpm_resume_end())
* dpm_suspend_end() does clean up on failure
  (it does not require a call to dpm_resume_start())

The asymmetry was introduced by commit d8f3de0d2412 ("Suspend-related
patches for 2.6.27") in June 2008:  It removed a call to device_resume()
from device_suspend() (which was later renamed to dpm_suspend_start()).

When Xen began using the device power management API in May 2008 with
commit 0e91398f2a5d ("xen: implement save/restore"), the asymmetry did
not yet exist.  But since it was introduced, a call to dpm_resume_end()
is missing in the error path of dpm_suspend_start().  Fix it.

Fixes: d8f3de0d2412 ("Suspend-related patches for 2.6.27")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v2.6.27
Reviewed-by: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <22453676d1ddcebbe81641bb68ddf587fee7e21e.1756990799.git.lukas@wunner.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/manage.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -116,7 +116,7 @@ static void do_suspend(void)
 	err = dpm_suspend_start(PMSG_FREEZE);
 	if (err) {
 		pr_err("%s: dpm_suspend_start %d\n", __func__, err);
-		goto out_thaw;
+		goto out_resume_end;
 	}
 
 	printk(KERN_DEBUG "suspending xenstore...\n");
@@ -156,6 +156,7 @@ out_resume:
 	else
 		xs_suspend_cancel();
 
+out_resume_end:
 	dpm_resume_end(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
 
 out_thaw:




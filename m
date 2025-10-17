Return-Path: <stable+bounces-187188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A646BEA3CB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E57C5681AB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B036CDE0;
	Fri, 17 Oct 2025 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GcNpQgB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773363328EA;
	Fri, 17 Oct 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715365; cv=none; b=qsbgBPglKWyHAnSHmEBYNyx93DPGgWqz/966hMA5biGbm7jmdWI5P7q+pBsxn74iPiruNuF6859O0RPVkbC/OHJDKJeHSILdQxdu+q3PBQoytJVRyHRIJvIyOjmtdVnPHEWbJb55wElzQCwAwr0EDmTiq4G3mQDXB7tirhR7zJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715365; c=relaxed/simple;
	bh=bnrub2W215sTQaywyEdFtK8nKRY70LNJ5+vZkJQHulM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agMOruo8j0EqRBd/zojb2P4AAOngd9z/JjbWHEBq8euVRuc7f9NxcOW6FWiTesfUAXqmyvepyUESuC2iDPTiI9cWLUo2HZ55O5JVZI1rHTitAft5qEHx7GLfm72KWGbwqAKHFoVJRjaFs5OWBUvTSi3iG0x4tKaOYhkacKbx5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GcNpQgB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2BCC4CEFE;
	Fri, 17 Oct 2025 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715364;
	bh=bnrub2W215sTQaywyEdFtK8nKRY70LNJ5+vZkJQHulM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GcNpQgB5mLsFkv9bf7nnsffhfErsYZT7l7q+n3gjmdyConVrRNJIcgkDWNakZ0KwE
	 xIVK/3X3JTeXxRxzkd9ET4aBNUKbfEf1kZTDJ8wUgQ9aGleeNMwv7IVRlkzIoFQBm0
	 iMwefQp1R+PwjQcVwJThP2fqwm8/CLaPPFFDXy3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 6.17 163/371] xen/manage: Fix suspend error path
Date: Fri, 17 Oct 2025 16:52:18 +0200
Message-ID: <20251017145207.829961903@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -117,7 +117,7 @@ static void do_suspend(void)
 	err = dpm_suspend_start(PMSG_FREEZE);
 	if (err) {
 		pr_err("%s: dpm_suspend_start %d\n", __func__, err);
-		goto out_thaw;
+		goto out_resume_end;
 	}
 
 	printk(KERN_DEBUG "suspending xenstore...\n");
@@ -157,6 +157,7 @@ out_resume:
 	else
 		xs_suspend_cancel();
 
+out_resume_end:
 	dpm_resume_end(si.cancelled ? PMSG_THAW : PMSG_RESTORE);
 
 out_thaw:




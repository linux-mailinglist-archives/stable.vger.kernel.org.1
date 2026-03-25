Return-Path: <stable+bounces-230267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBsgKVZ2w2ktrAQAu9opvQ
	(envelope-from <stable+bounces-230267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 06:44:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDF31FEB9
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 06:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21E4E305B245
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC43195FD;
	Wed, 25 Mar 2026 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aIAPHZx0"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782C30F535;
	Wed, 25 Mar 2026 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774417458; cv=none; b=ikClgCcUiRLw93FOhkMxU0B0E91xwbHSh8sPRjhqcG8vCT3b3+VTRTX90NTvJPyGnZuGb2us+I3a9mT8s/D7miL08TDpAZumzZX1TM0iFaPKvbGQSQQIwxddfT2yn30H6ocoq+h750QfT2KOQeNbbAt+du9GoyxvJxKWsyLOf0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774417458; c=relaxed/simple;
	bh=P2vsmHaG85VL7IOTuwdGn8heZirpnFu+tq+OC1J5dRQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=U5Uufv4a1lplJmmtuTwAZ8TRfLHTojaaJBsYD49Zk8IhyKASkPeKse6aiaESmIQJ72iBjytSGxy5IsRnFT+vAjM+iUHi60H5aFRbMdstTeHVYZTq1eR1iWQx2gZ6zxoS5ooRoOSgoBk1ZPudhsVRhFvWXWUOUi3Z9O32uIrSZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=aIAPHZx0; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1774417446;
	bh=lsRs0w3s1XR78ZUa0hs24rqGxcYjBv9JQ4RsHoC6kU8=;
	h=From:To:Cc:Subject:Date;
	b=aIAPHZx00D1yNGeUE4A3z93NR5EXC2P5HKdty8dI/3oZL79jF1QmNiSzJHdDtsiz3
	 60Iz0Ln7VPP2Dc1gUpdX04a8/xUJ4mXzSCPyNweCmoqUfE5JZxtCDQm4hPpBLOtM//
	 JKfggU6vjWTYKG44nP/fqVcYV9gSGQhhPNB9sa1A=
Received: from China-team ([60.247.85.88])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id B019964C; Wed, 25 Mar 2026 13:44:01 +0800
X-QQ-mid: xmsmtpt1774417441tialpb5b7
Message-ID: <tencent_DAD116D7DC7CB44A8E5BB7E2CCC0E835F00A@qq.com>
X-QQ-XMAILINFO: OOyEews/EdUg6nw6roCgOEuNTrX7cM0xj+CLaS7nB7CUOe2/s3PCIq1EC3mdKj
	 4Ejny0jLyTsnhDCUvtG80AEBNykpsrXGIaEJlrvnEHAjkz2UKl7H9BP97/g0ePxC3fVLpIOnVgvg
	 zB8DbetfYFQvNGp6JY/D/XvatkOOSlqmGzLQ4mOjYS52NS7sv4QhVFxQ5JYIUyLDM+jyqDRC8eIS
	 REuhkwJlm8k9H7aKOYyBG1VZSm0EbTU/01NkuBTb6mODTQESvrf+rhsVWNHH/On0IrXr+BZZmxW9
	 jwmzo1tEDyY8oGjt4duedhlwuNEH5yYEU9rNQsHfS8bLdcTwKH8PfwhJK+MvsOB8rp67OOEj8snO
	 jOJCOH/sBwdAAeqO23mOEu9Wms6turWPQX0UMu3fVU98ZX2HuplvthWiBMav/fnnuCZ8bfzVMNH5
	 MjRJEedxQYzBXKG4eWGH2MyT4G8HQvGgU9yplFxNIn0NbC49w8qgGBxGnfBE4/9mFAlATBhbX9bU
	 rYPwa/RiNRJ/ErdkgWR+VQGuDwPU6wUNkaPzYmDtrhjV7WOzqFoYt7LzV/RGW75bw4PoSIL6ReoX
	 Sj+Hbxt5AC5W0yj3Udmnf5MXLTReVBht9/QxR5luAp6A6Rm8EoZ6wMZQX2wj8saabcQLfouYyh7C
	 XqTEm79st4Y98DENgfyNbNob23vGop5aLpLYPLoOtQIRQuKDnHcfug92oRSfXMQ8ZAtQeEncKiuI
	 ZnJeqEwneQpCzTVjKJyayL00skAoygXdiOgAYrtZyGvv8lIr1+1wVtfYq05639P3rcS+w/JfbNtS
	 sKu3LTd+CVP3KW410fwsZr11GQMNvZh80CD69qol/3uZDp42LyKPwQ4+s7tJ1DFvG6TFk883Nic6
	 Qe/mefQM1PZLbikMA25QgIBYCFPPWihVi92Bt9hD/Qfkku1InJjSSSlT5tiSbmBZvswH/EJJQzXH
	 gRRrP+fioGZZXTTAxV0LQa2Z2GKLHF+I2dUyR0VkWkRR2dd8GXi3o6cvw10+bUiCQ3ykb0COEbhT
	 5WURg+81Yzk5oKvebLPBsPkQk5jYnJKhR6qRp+eyddp3YrMFD+5qhnW5QAoYzfRc0tP8Elqw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Helge Deller <deller@gmx.de>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] fbdev: efifb: Register sysfs groups through driver core
Date: Wed, 25 Mar 2026 13:43:39 +0800
X-OQ-MSGID: <20260325054339.1030580-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[foxmail.com];
	TAGGED_FROM(0.00)[bounces-230267-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[foxmail.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,weissschuh.net,gmx.de,foxmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,qq.com:mid,foxmail.com:dkim,foxmail.com:email]
X-Rspamd-Queue-Id: 57CDF31FEB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 95cdd538e0e5677efbdf8aade04ec098ab98f457 ]

The driver core can register and cleanup sysfs groups already.
Make use of that functionality to simplify the error handling and
cleanup.

Also avoid a UAF race during unregistering where the sysctl attributes
were usable after the info struct was freed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Helge Deller <deller@gmx.de>
[ Minor context conflict resolved. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/video/fbdev/efifb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index b3d5f884c544..f029cbe9cefb 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -581,15 +581,10 @@ static int efifb_probe(struct platform_device *dev)
 		break;
 	}
 
-	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
-	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
-		goto err_unmap;
-	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
 		pr_err("efifb: cannot allocate colormap\n");
-		goto err_groups;
+		goto err_unmap;
 	}
 
 	if (efifb_pci_dev)
@@ -608,8 +603,6 @@ static int efifb_probe(struct platform_device *dev)
 		pm_runtime_put(&efifb_pci_dev->dev);
 
 	fb_dealloc_cmap(&info->cmap);
-err_groups:
-	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
 	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 		iounmap(info->screen_base);
@@ -629,7 +622,6 @@ static int efifb_remove(struct platform_device *pdev)
 
 	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 
 	return 0;
 }
@@ -637,6 +629,7 @@ static int efifb_remove(struct platform_device *pdev)
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
+		.dev_groups = efifb_groups,
 	},
 	.probe = efifb_probe,
 	.remove = efifb_remove,
-- 
2.43.0



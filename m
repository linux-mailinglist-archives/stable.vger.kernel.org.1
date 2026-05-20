Return-Path: <stable+bounces-250492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOIKH/noDWrr4gUAu9opvQ
	(envelope-from <stable+bounces-250492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:01:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D6592D58
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C92CF308BDAE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE4352C52;
	Wed, 20 May 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mlMPgErl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FE285061;
	Wed, 20 May 2026 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295551; cv=none; b=HFQklKOGq60k1BYpPScQ2C5eF6qbO1bCmy4+N136PYiLa/YJ7PrFkXowFH/MNwB5vJGQtMOluCML/NB8T9gIYjZM++4uuugXJsUyQ2icP+gbrAyMhF0eWAO1I6XfvrhzVs+1TrBcVuxQ/apYzGb7YhpcZj8UHbsOUt+FilJmbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295551; c=relaxed/simple;
	bh=y3b2iVbDttGZ8kNW+IbHPGASZf3lYArUBOQu2lBgfqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpLypKiZAXhdb4hct34p99mFgDPwlbN5xcdcRLNL7SqI/W0fFcI4CN+k2Iz2nKqmFMy7Dndn5ocp2cETwvWtFVVjV93rOFU1RglE7v/K7/7c9v8DSeMLapROO8CGphRYOOJN+HoA1T+Xjy6fY8445HPY0dKANWoQKMXWXaDxka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mlMPgErl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B201F000E9;
	Wed, 20 May 2026 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295550;
	bh=BAz2siFvpJoLq9LwMLXKmbVBydjIP4f9FtrrxR+U/GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mlMPgErlGus2w93ba/U7Z6seYwqC76qk/XHpU7JntRecUYg9wS8f3hZFR0P8mzvM7
	 FKzAS/pq8pKR0Ra5FnoNvYLG7Iei+xTlObAobN881VWdxgkPPtwmVPHbOdO3h5KAz1
	 xtNSzDT6DO5A26TBF2h5q8NapMUKYUcl7UoDZbuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0461/1146] vfio: unhide vdev->debug_root
Date: Wed, 20 May 2026 18:11:51 +0200
Message-ID: <20260520162158.630603524@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250492-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[arndb.de:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,arndb.de:email]
X-Rspamd-Queue-Id: 590D6592D58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 555aa178f8d22261d71da74df6267e6e6e97f95a ]

When debugfs is disabled, the hisilicon driver now fails to build:

drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c: In function 'hisi_acc_vfio_debug_init':
drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:1671:62: error: 'struct vfio_device' has no member named 'debug_root'
 1671 |         vfio_dev_migration = debugfs_lookup("migration", vdev->debug_root);
      |                                                              ^~

The driver otherwise relies on dead-code elimination, but this reference
fails. The single struct member is not going to make much of a difference
for memory consumption, so just keep this visible unconditionally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b398f91779b8 ("hisi_acc_vfio_pci: register debugfs for hisilicon migration driver")
Link: https://lore.kernel.org/r/20260327165521.3779707-1-arnd@kernel.org
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/vfio.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514a..ef02a4996d451 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -72,13 +72,11 @@ struct vfio_device {
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
-#ifdef CONFIG_DEBUG_FS
 	/*
 	 * debug_root is a static property of the vfio_device
 	 * which must be set prior to registering the vfio_device.
 	 */
 	struct dentry *debug_root;
-#endif
 };
 
 /**
-- 
2.53.0





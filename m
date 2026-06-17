Return-Path: <stable+bounces-266816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iGXmMFi2Mmre4AUAu9opvQ
	(envelope-from <stable+bounces-266816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:59:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64969ABDC
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:59:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=temperror ("DNS error when getting key") header.d=seu.edu.cn header.s=default header.b=lVZqgi1H;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266816-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266816-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=temperror reason="SPF/DKIM temp error" header.from=seu.edu.cn (policy=temperror);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B71A3004D28
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1644E025;
	Wed, 17 Jun 2026 14:59:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D72DF701;
	Wed, 17 Jun 2026 14:59:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708366; cv=none; b=AyKmuyNjwR2k1UMeQiwjzQ8V4UPxr1uWCdlI1abtcDHWeXVpAgTJiv2UhUvn/D8gp34wqFAeuCP4T168JB08pfIvWkY8Y3tm6Cs0074Z0ycfpFMqx9S5TD8x/cDhYqOJgMNfAhMSwDIY9+MY2dznEhenuuHZN8nRjbw6AE6IIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708366; c=relaxed/simple;
	bh=mqJ9CDPdN13Tk1t1hJVgjmBUF+9AliE5GbvZD9w1/jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vhy9BrRxtJYwhiGSC1uVKHFzfc8pfZ8w8vcry1KMMmz0WtmzqPQoeBq138QKQL9oJ7jiFev+q7Dq0YADfvq/6i4n/mEtIuwDgfH7CGSuUvZ33LyFCNBIUIsQhLJvgV4ht0y598RXOVPsDSqnjZKrit9WvIACOkTW0r434iznXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=lVZqgi1H; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42c69639e;
	Wed, 17 Jun 2026 22:54:00 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Alexander Graf <graf@amazon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] misc: nsm: only unlock nsm_dev on post-lock error paths
Date: Wed, 17 Jun 2026 22:53:50 +0800
Message-Id: <20260617145350.513875-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed6132a9503a1kunmb71436e171af3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaQx0aVkIYS0oeTUtIS08dH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=lVZqgi1HSrjp8VxZUFATnbLtKNx7A+ZOoRI7gFUSm3G7+MqklCFARR2VGZpiYmB1+8u4Zaxqc/ioNbBpXCyCsZ7xsvNUzfGaPSw/PcqPVriNkVMMLDLRikXo/Yu7V8WAZGPiwo58/Sc0od81K2zp4DcW7D98akjDF1QYO391+0c=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=8lNDahgHw3h1ashyvSXOpRVgmpNM1Tqg52/ufq23fcU=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266816-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:graf@amazon.com,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:aws-nitro-enclaves-devel@amazon.com,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[seu.edu.cn:?];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_DNSFAIL(0.00)[seu.edu.cn : SPF/DKIM temp error,none];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[seu.edu.cn:s=default];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C64969ABDC

nsm_dev_ioctl() jumps to the common out label even when the initial
copy_from_user() fails before nsm->lock has been taken.  The error path
then blindly unlocks a mutex that was never acquired.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the miscdevice ioctl entry and the pre-lock
copy_from_user(&raw, argp, _IOC_SIZE(cmd)) failure path by issuing
NSM_IOCTL_RAW with an invalid user pointer.  That failure reaches the
shared out label before mutex_lock(&nsm->lock).  Lockdep reported:

  WARNING: bad unlock balance detected!
  exploit/193 is trying to release lock (&global_nsm.lock) at:
  nsm_dev_ioctl+0x5f/0xcf [vuln_msv]
  but there are no more locks to release!
  no locks held by exploit/193.

Return immediately on the pre-lock copy_from_user() failure and keep the
common unlock label for the post-lock paths only.

Fixes: b9873755a6c8 ("misc: Add Nitro Secure Module driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/misc/nsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index ef7b32742340..185900cdad4a 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -367,7 +367,7 @@ static long nsm_dev_ioctl(struct file *file, unsigned int cmd,
 	/* Copy user argument struct to kernel argument struct */
 	r = -EFAULT;
 	if (copy_from_user(&raw, argp, _IOC_SIZE(cmd)))
-		goto out;
+		return r;
 
 	mutex_lock(&nsm->lock);
 
-- 
2.34.1



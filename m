Return-Path: <stable+bounces-164428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F9B0F1DC
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 14:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC51565EA1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A4A2E54C9;
	Wed, 23 Jul 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b="fS0YXnJf"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0127EFFA;
	Wed, 23 Jul 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272315; cv=none; b=LlQs/Za2z0CqGos9WvIr3pAuGkodv5OCVxOgGIcCzbUKGDhQYnaPEeKaip7P6OjGR6HVEp9C90jV2w3YysDsfIGlx5vk1edPh8g/w4I1KhEQeTprYtoj5pX678gCuh3hVKx7IYQ/XDA2kAG1ZDQvh22hdR7Vk/vfjRlW2Gv1dYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272315; c=relaxed/simple;
	bh=p3Y86nc38LoiKKqABtDaF5tDDqxNVBq0P6kFqBg05XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m/OxjZ4CTFDKI7nH8zGfhSF78mC0MvhVcYyi4FflYJFlGkgPYveew0EoAtRCiPZeG7CkmUq8rSZRXRMAr/8BnqXSy/DUP+rwZppBcH2iEvCS6dH3VVLcM6LPvbmT57f8UlbcXsOHN12I7xTg7jvKpUQ6mx/uYbMpifUekb4RlTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun; spf=none smtp.mailfrom=bbaa.fun; dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b=fS0YXnJf; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bbaa.fun
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbaa.fun;
	s=goar2402; t=1753272271;
	bh=+I7xsf7G7jFeIPNE7axWQVp7+uIyws4cVypDWIf1bKg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fS0YXnJf7DMxMZxH1RzA2SIRZQvT4uDe9hJxUOoaqblFPMEhJp6F4TGR1GhC0hWft
	 nagbG6AcwWJ6Y+CLZlgKCNfoxNkGkJ/aVHv92ElsdFSawc0DOu9hxnqG/IeYVJnQFS
	 nmCfZTKwqGxhGwg73bixwpfjCsDUKQTeRCTRZCMw=
X-QQ-mid: zesmtpip2t1753272266tcc89ea27
X-QQ-Originating-IP: KheH5zzepJwErfQEAABqPMuD/+8ySdoAYJ2HK++Onls=
Received: from localhost ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 20:04:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14388533980788281363
EX-QQ-RecipientCnt: 6
From: Ban ZuoXiang <bbaa@bbaa.fun>
To: stable@vger.kernel.org
Cc: iommu@lists.linux.dev,
	baolu.lu@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Ban ZuoXiang <bbaa@bbaa.fun>
Subject: [PATCH] iommu/vt-d: Fix misplaced domain_attached assignment
Date: Wed, 23 Jul 2025 20:04:23 +0800
Message-ID: <468CF4B655888074+20250723120423.37924-1-bbaa@bbaa.fun>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:bbaa.fun:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MpO6L0LObisWl+PGsSopayhkh5clV6lzYsQ/+m0W7hBGvlarcuCwvNob
	53vetMWNsXF3TlGNn1MeV+IXukoMsbgQNdFgwxWbs/SNbhx8p1yVNFEL+kH2rlpDnR1RNkP
	aIOXT1MAOZAxNi2dy/rQazFBMaRvlbT46O13mC5F7aAuIRpjaMCqmLnuxEjD10ypsAZJ+Ew
	fumM5n9viUfZryQiBo7dSV1UMtvFVHot6iHBbH/Ypj0KzdkgmtjPxm0Tc/99g2pXw4mgwQ5
	rZzZ+XE0RZogBMw3LcCIkQUqmTQDA5ry1A788/aRCCmXP6ENKGkStuIQvBTIuW/eFyH6H1u
	2KpX71x1z9qxBxJ11E4hPd384NYHVXaemyOPLm++surmhSIqmD6JhkH4u1JScnWt6Qbj7bx
	W43u6zW13PjB/QQ2rp/K3fNMh1TDZJc4WU+/HMscIBGJRRkACUaECC7jQp+HVZfmwIZ7qJj
	noPw4jqBK/ncwZ3zYjEstqjN1JGx8y+R64ODJa8TMYtixe9VXq0aZsFlZDB+hJeg7UTk13T
	p3k7pEEhKoMkAg/jjjYyHWa5GSKpzeZRj34XKwYAffcxxbDsPpZL1B//tCsMEyYdh8Kl+c+
	EG4LZwZ8Ft+Gea8S9dWRw8NiLWMgEkyHvcGGJ0t2HpmCbo4MNOXfBCs/ySB5UGKJldz2b+c
	p/6NC9l0zgPF0ATgUvKttdIDdUHEekyA/e+IhD5QAobLrbhdIDC++qYY+MhSSxsBhh2h0v9
	xQuC997DjEDNCC2z0MX+ccLa+t4KNTDxsshxSg0TgFqfl66ptOEZqZrbX+n8tmJqGp12Uka
	XMu8Cd5P4OWDmuZMktjyqHuwTOPcwPqd86SqeFsEe1G1QcAQpniQHkSrWA7WfvxVDjH8cFl
	+FjxZ0riqmyAzDxCx1GpJYOhC6eblSLMGWvje+pODbm5T0MMJrsWmtS9xv+AuqdtxGC0Zsn
	WoiHQjbdKen/NsaBmcVAIqMrX5lhKMqOy754ldleCamzntnEiDBA8vsxrHE3aKNjZsDdR23
	DjG4OL6g==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Commit fb5873b779dd ("iommu/vt-d: Restore context entry setup order
for aliased devices") was incorrectly backported: the domain_attached
assignment was mistakenly placed in device_set_dirty_tracking()
instead of original identity_domain_attach_dev().

Fix this by moving the assignment to the correct function as in the
original commit.

Fixes: fb5873b779dd ("iommu/vt-d: Restore context entry setup order for aliased devices")
Closes: https://lore.kernel.org/linux-iommu/721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun/
Cc: stable@vger.kernel.org
Reported-by: Ban ZuoXiang <bbaa@bbaa.fun>
Signed-off-by: Ban ZuoXiang <bbaa@bbaa.fun>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 56e9f125cda9..af4e6c1e55db 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4414,9 +4414,6 @@ static int device_set_dirty_tracking(struct list_head *devices, bool enable)
 			break;
 	}
 
-	if (!ret)
-		info->domain_attached = true;
-
 	return ret;
 }
 
@@ -4600,6 +4597,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 		ret = device_setup_pass_through(dev);
 	}
 
+	if (!ret)
+		info->domain_attached = true;
+
 	return ret;
 }
 
-- 
2.50.1



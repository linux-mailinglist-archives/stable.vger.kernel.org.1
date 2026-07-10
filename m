Return-Path: <stable+bounces-273219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OqWEKEPmUGqX8AIAu9opvQ
	(envelope-from <stable+bounces-273219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:32:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D47973ACC0
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=smail.nju.edu.cn header.s=iohv2404 header.b=EGq9rTf6;
	dmarc=pass (policy=reject) header.from=nju.edu.cn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273219-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273219-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBF7B3007B81
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAE421896;
	Fri, 10 Jul 2026 12:31:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AF3FE37C;
	Fri, 10 Jul 2026 12:31:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686712; cv=none; b=Ne1/g++FHZ3m+lSBGYGj0dDQJiWv3hN7b9NsO55QTyS10vv+SYfOEYretwH+5IzGHT5hytlAhFITEfiDmsC2VtUaiMb67743/HbTvI6RrW9uKwSWrywiruJE0iCp2rviSGEku4dxYmFgqHNaCAfyPJAkaWLW8CpsdMEBCkitroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686712; c=relaxed/simple;
	bh=ZGn51/2KJMOlLQyHgSlaaORnnCNkoqbmH/lcwzFF+fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYLU9cfY0rlRpPTeYpYn9RS6J40N4moQcRPBs+kOsyNCLBJbbJeFvCXOXC6xZZh8GsIaJQPcfwDWwL2Er6uIO47uoWd506z0CBMqh2fzvck5awH3fCtyMc24hjuNKJIoiDtXzEYjrTeL9toFbYjp03bWRe+v1+1fRxqsSLml7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=EGq9rTf6; arc=none smtp.client-ip=18.132.163.193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783686642;
	bh=UrM/L6cbWjMus7RDeF7oMlzJ9Ll1lnZu/w1HVGR/Pv8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EGq9rTf6dsPmvl4gUlbV+kzrqQgZgf2zJpEb5iyWub3rkAK0IDaTilWvmsuI+rXve
	 eC8Y13k5FN4RRK/P4oXTEb8brEQh+OQk2+O8AzLx84kLlxoip96alIea8CmWAmlej1
	 jZcNYXnUqHJpmhJSNjBwBzJz9SoK2rEjFUGLonnI=
X-QQ-mid: esmtpsz18t1783686634tdb7a833a
X-QQ-Originating-IP: 2CsnxbqJsp3mSW5RGrvs0lhDp/q8qqtL/6Dh5MXpzk8=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jul 2026 20:30:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10002618754095322046
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	nicolinc@nvidia.com,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] iommufd: Fix wrong hwpt passed to iommufd_auto_response_faults on replace
Date: Fri, 10 Jul 2026 20:29:52 +0800
Message-ID: <9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NPN5fA0Ilhx2xIhTq0JlD9TOnz+3tNhnLO26c7YGXvxWP2AW7Ia+460S
	TTVmmVZMdkMNHrPsmWAVWXTmzn4mycvojt6XiOmhntl1MzyAkkpxv6v+mbV6AmZp8OgcKmU
	4XP1a5BR2zpjS+r3++9yax7BMW+qANOg5R/w/8Ux+sHgEN1p+Lcpa/1DGQvr++smHMVhrHs
	VaT4N4Hm5r/ahIebWNX3nkuA46/OgiHmFQhcBUTsDp2AGJZrH3ZVDeKUQN5L3RjFP0yQfZZ
	6nhNHlTOMHbR3rBUMdsKUPJTJnAxmfsd8V0AkqKvOXUVbZHJzMkwifeJBDH+WDQkrcBRf7R
	JPs/KL1D8Rfk0pCU8dgo3TsNeU+kadXX2Nyh+pVgCZ/mVc7xJsG5xt38cvK4sIU+c5qWGvg
	UbsE7WAIR11fRspiVXCe93heiq1SGCt8WU/WY8yNVVCZVJh436JJjIX55O/pEh+P9AN2P0K
	YX8CBIYXvUEHL6pOAzFj1sPLnQ8y9vMFhEL4ScSYa6d5Ti3VtPdu2HBIk6ng5QiE0+1WJcO
	kVLoCVXY7p5HT+qR0xNLEe4p819c+xtsQhxZhrl7L+BBHIj7oNjQ8QHimeH8R09Acj2rxsT
	QU/DbQOpG3CYbCgtbblZAbJ4xLwtIHwinOdeQtLbPwBtXzEC6vyhKsmjxUX71FGoyFFCW21
	GLuLlvE8rjwjSCjUgN+h0U+TQii7SRng/JsPa7Dx3VWJdJ3GsCRXVWynWXc3lkIix8bZy1u
	gPhVXW28ArYZolZT9FHgYlQB427wd93GmspJPKDGgWaCJFoJw6TEDhEP5NRuuVoH7b48qar
	JoLpMKp5A/5oiAtIdnWP+r3qgMhFEUYvtmGQ1whY4BfdWyZqpWtK22inWih4SfbHcn+aTzX
	tCMaa/igJG1ci1vjVUYCfuMXSsvAzXnq+OtpZ/A9SAivWGjqH+URg4EOGp5THvJ/E4Z13QD
	gjp2RrzPxlzsXtZ66R24jplr5tkxc0vIHn6RzjeGJGCUE+ON9thWxJJFv+q2uvY/BFhSkZ8
	7dcytkmxQDb2xvSm+pXgBxPGV8n7dGRqKOoY6U2YBiCLiIEiSE
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nju.edu.cn,reject];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273219-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:kevin.tian@intel.com,m:joro@8bytes.org,m:will@kernel.org,m:iommu@lists.linux.dev,m:robin.murphy@arm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:nicolinc@nvidia.com,m:peiyang_he@smail.nju.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[peiyang_he@smail.nju.edu.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peiyang_he@smail.nju.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smail.nju.edu.cn:from_mime,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D47973ACC0

iommufd_hwpt_replace_device() calls:

	iommufd_auto_response_faults(hwpt, old_handle);

passing the *new* hwpt together with the handle of
the device's *old* domain. This should be a parameter mismatch:

1. Semantically, iommufd_auto_response_faults(x, handle) scans
   x->fault's deliver list and response xarray for groups matching
   "handle". A group is queued under the hwpt that was attached at
   fault-delivery time. old_handle is fetched *before* the domain switch,
   so its group lives on old->fault, not on the new hwpt->fault.

2. Historically, the first argument was "old". The routine was
   introduced by commit b7d8833677ba ("iommufd: Fault-capable hwpt
   attach/detach/replace") as __fault_domain_replace_dev() in
   fault.c, correctly calling iommufd_auto_response_faults(old, curr).
   Commit fb21b1568ada ("iommufd: Make attach_handle generic than
   fault specific") moved this into iommufd_hwpt_replace_device() in
   device.c and swapped it to "hwpt". This should be a refactor regression,
   not an intentional change.

Fix this by passing "old" instead.

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Fixes: fb21b1568ada ("iommufd: Make attach_handle generic than fault specific")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..2895e5370910 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -589,7 +589,7 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	if (rc)
 		goto out_free_handle;
 
-	iommufd_auto_response_faults(hwpt, old_handle);
+	iommufd_auto_response_faults(old, old_handle);
 	kfree(old_handle);
 
 	return 0;

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0



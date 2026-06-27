Return-Path: <stable+bounces-269358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AjehLsdtP2r+TAkAu9opvQ
	(envelope-from <stable+bounces-269358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:29:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F6B6D14A6
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=foQN5aGC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269358-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269358-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD9AE3035B52
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3838E8AD;
	Sat, 27 Jun 2026 06:29:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D902EEE9B;
	Sat, 27 Jun 2026 06:29:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782541751; cv=none; b=CF+I6BHclDx1xL6zV719mfJxvHbIjvFGyOcDK52XPYrlLv/FImCAzV0Q1Zk2NoRNHwp8t9ghRb4J/CScr2xr8szNtxAqqNgRNmbWlSLPdcvehcbhLIMKK1aKgfH/6JvBZFtZHNaU4hOXPyfqhndvqjaUaTmXz51bPZzKmDEePBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782541751; c=relaxed/simple;
	bh=rNJOUaCkDPacOFqNkrUkc0E59ah+yyGct/mPpROxGdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VKX4JEvPGWUFvCorb5/Cachec5k3ni5F48ND28ImrW8fl19kj4ZWeOReHGrg76kdyY/nvMi8pbUdJuMFBI7wFaVMfBeR83M060t3l+kNI4aiT7LGqA1xQ8x3FTnZRy7WyKEiw2XWnnZIJaXLHLXO4StwuAONll9fqnOmwXZo+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=foQN5aGC; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ljDY3nyizF2W/GnFcYTLCUCIDdg/cS8Qmi/xhTH76YA=;
	b=foQN5aGC/VZ1V6Ge30Kh4AHMUq+z1fmWM0dSgkv62fq5XuBAxa6hrMjEpQ27ofdjVFZwxiLKb
	Xv8boOBQaw3EQIbwE6iFBROkms+gBVa0FSTww8zU3S0v1k6ijvp06fRlkjiLjOPlNBTRAMj2ZdG
	7+L5pt/2gIIb7ENB35v0qyM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gnMpn3Gd4z1T4Fw;
	Sat, 27 Jun 2026 14:20:17 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F657203B7;
	Sat, 27 Jun 2026 14:29:02 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Jun 2026 14:29:02 +0800
Received: from octopus.huawei.com (10.67.174.191) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 27 Jun 2026 14:29:01 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<miklos@szeredi.hu>, <amir73il@gmail.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>, <gregkh@linuxfoundation.org>,
	<bboscaccy@linux.microsoft.com>, <caixinchen1@huawei.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-unionfs@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<selinux@vger.kernel.org>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
	<lujialin4@huawei.com>
Subject: [PATCH v2 stable/linux-6.6.y 0/3] Backport Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Sat, 27 Jun 2026 14:57:17 +0800
Message-ID: <20260627065720.1945589-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200017.china.huawei.com (7.202.195.228)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[caixinchen1@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:miklos@szeredi.hu,m:amir73il@gmail.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:gregkh@linuxfoundation.org,m:bboscaccy@linux.microsoft.com,m:caixinchen1@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:lujialin4@huawei.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,gmail.com,paul-moore.com,namei.org,hallyn.com,redhat.com,linuxfoundation.org,linux.microsoft.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269358-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:dkim,huawei.com:mid,huawei.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53F6B6D14A6

v2: Add static to struct kmem_cache *lsm_backing_file_cache; and define
lbs_backing_file as int for keeping the same type as 6.6 lts. Use macro
backing_file to replace inline function to eliminate the const warning.

Backport the patch series
"Fix incorrect overlayfs mmap() and mprotect() LSM access controls" [1]
to 6.6 lts

I test selinux-testsuite[2] overlay test, it pass 135 tests.

[1] https://lore.kernel.org/all/20260403030848.731867-5-paul@paul-moore.com/
[2] https://github.com/SELinuxProject/selinux-testsuite

Amir Goldstein (1):
  fs: prepare for adding LSM blob to backing_file

Paul Moore (2):
  lsm: add backing_file LSM hooks
  selinux: fix overlayfs mmap() and mprotect() access checks

 fs/file_table.c                   |  46 +++++-
 fs/internal.h                     |   3 +-
 fs/open.c                         |   7 +-
 fs/overlayfs/file.c               |   8 +-
 include/linux/fs.h                |  15 +-
 include/linux/lsm_audit.h         |   2 +-
 include/linux/lsm_hook_defs.h     |   5 +
 include/linux/lsm_hooks.h         |   1 +
 include/linux/security.h          |  22 +++
 security/security.c               | 110 ++++++++++++++
 security/selinux/hooks.c          | 242 ++++++++++++++++++++++--------
 security/selinux/include/objsec.h |  11 ++
 12 files changed, 395 insertions(+), 77 deletions(-)

-- 
2.18.0.huawei.25



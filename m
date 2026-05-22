Return-Path: <stable+bounces-253765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J9cFlRAEGrzVAYAu9opvQ
	(envelope-from <stable+bounces-253765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:39:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF65B31E1
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 593A7301474C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141A3D47D9;
	Fri, 22 May 2026 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="WHnUuWQM"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA063E9C0E;
	Fri, 22 May 2026 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449935; cv=none; b=K6h6HmqSHeVFFy3DWCiQ1L3wDt+19x4v48Zcp/f1l+Xm0Y3Ka5ktY45oVn4YZwYYFOE3orOhhsd1iJFmvae4mxEdFW2fZ29RDx7Aqv1Sprp/wjeqrlaCLH2YRxkWLj0kT7JOgz47lT26htKIlkzI2NZCajog00MaWygbR307Zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449935; c=relaxed/simple;
	bh=qh3YNZGJRUDOa+QVVkDaqj8eq2RubUdVh8YVYgpPH7U=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oW67/X0/e5L2dcn88JtWKFA3SscZv9B5QMIaOfeyrjSnRfHXSWW44cgxYTWULaRaB0oVowvBmhlx+yOzbNYAktsF9sCeA4AFKZvFY4fpbDyQo4AsrjYA4tvVjFP+I67weM0RSioF4OZg6Fn0ETZSEWYwJsoTdl59lfFQq5qaECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=WHnUuWQM; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779449919;
	bh=X19125/Y1fGW2WoQvpDKVfejXVNWaXfO4KcQ6hX1YWI=;
	h=From:To:Cc:Subject:Date;
	b=WHnUuWQM5g36oNgoVFD52ToU6sJcHw1epR9jzRInJxC71OqrL4G+++wFCONzOBa9u
	 KYjR75GaJkTCLK7hNmNK+8Je3Uny2KI7Ns0hzScWXaJu/8Z2WoLIsyk4xh2AXdabl8
	 dhW9a3zi5Omf+zuKHbTHhrfX7KxtKqI2bTfEStc0=
Received: from China-team ([120.244.195.95])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 9A0B9AEF; Fri, 22 May 2026 19:38:32 +0800
X-QQ-mid: xmsmtpt1779449912te3cbofzk
Message-ID: <tencent_DE479764A6B5230E038C7F4315AD4C0DC606@qq.com>
X-QQ-XMAILINFO: OD8Oy9jBXVxFu9znx03zy3AjWWmz48nSG7wRPPOyBvVOxBOs3ez5Z5nlM4IMMo
	 cx76rdmdDZySQbGbwjVnVNJwburqqtvQoPdo1FT/x5NS/0QOTCD6TCu2ytDQwhMQeff0Q4tXhrtg
	 LsNr6pvMlwQBgRfphdbKVL9Yez2rJishvGUG0+23aARFTzjbUVGxRyfIZs3ZErj0tEt8TGVXb1jN
	 uNOjyH9njL0m7F5ed3aNkHak8mYmIxeH2rNvxjv2o+yuGyNc2EjMwbO+rXxANT/FSHTBGvvBts1l
	 591PMixv0QGTFtSqoflf0N8rTduRoIIcxOflvM093pZ/Sc1W18lazAjLHtChRNeTu/WRUIwsT7pz
	 rLVg0wHQ8lhuIWHRqmzKqIdi5O7zCbgPzTUkbk0BuucLQpApe5pdrba4IuuFilMzxkoP81B6GPYS
	 VE0KfCEYSsSo+5e7S4V6er1DsrP2DF6XzC59BjNdZE/ujrSO2RTIPNKaaVrQzW9JSlTt4ounj2Dd
	 gYrtunqNgDGe2eM7MSylZ8Z/QWZOD58fIdob9ExuwplhbMNhYfT4Cm0DJoP7NMQ4MSIy28ztW62D
	 JHZfOhZJUMyouYpE4TOBCT/GIDFVJBXZ+XirkWdOd6FMyyTdMrwc1rvaVODmFqnIM8FtufE1ppem
	 G540c13YIydgAWM2PbNaqmwZyYWs+OvpzoLPfgTi5V64mGAXOIwRd7vj0wi4muvjQIW7DdjMD4do
	 50WgLr8IAjkqbhND5iqCo4tFt8z6oIBM+ZIliC4lfGSFHITDDcNhI0LUav7BPzojXcIorEF5VkNL
	 EMk++qZr7rSnSRH8KdlDVWfG4OvSMYveQbGCNJmAAqx/jVYH/aOKYDyK8UyhY19j6uo9O3SdOoju
	 VLs543iecJ6QDO5s1l4YlcRbJZY6CPivt4oly2y6iZatYCIDxGCKGQ1d/8i4Zib/Lvv0Pt0GJBW+
	 tmvC/5DNIkx+7cYhExcI6IHSO36S+40lsD39unRNgk1Z0qEFqcqsZVl7QnN/AeIKmvkBqa5K7ayA
	 1fy/TX41OpGDSkr/p6QBMJkjQ7QWIGEXkaQvQoFgraGw5/veRNnXmgkX7GJUFKbqNenqB4178jy3
	 U2gm6gVTnn3JO+Bs8r0XcBF4X25MZp49z2xM5K
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y 0/1] ksmbd: validate owner of durable handle on reconnect
Date: Fri, 22 May 2026 19:38:08 +0800
X-OQ-MSGID: <20260522113808.20461-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253765-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,foxmail.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 62DF65B31E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch backports upstream commit 49110a8ce654 ("ksmbd: validate owner
of durable handle on reconnect") to the 6.6.y stable branch to address
CVE-2026-31717.

The vulnerability allows any authenticated user to hijack an orphaned
durable file handle by predicting or brute-forcing the persistent ID.

The fix adds owner identity (UID, GID, account name) tracking to durable
handles and validates it during SMB2_CREATE (DHnC) reconnect, per the
MS-SMB2 specification.

An additional adaptation was needed for 6.6.y: in ksmbd_free_global_file_table(),
the call to ksmbd_destroy_file_table(&global_ft) was replaced with
idr_destroy/kfree, since the function changed to take a
struct ksmbd_session *. This matches the approach in upstream commit
d484d621d40f ("ksmbd: add durable scavenger timer").

Testing:
- Build tested: compiled cleanly on x86_64 with CONFIG_SMB_SERVER=y
- Boot tested: kernel 6.6.140 boots and ksmbd serves shares normally
- Functional test: verified using a Python SMB2 test client that:
  1. Legitimate owner (user_a) can reconnect to own durable handle (PASS)
  2. Different user (user_b) is rejected when attempting DHnC reconnect
     with user_a's persistent file ID (PASS - STATUS_OBJECT_NAME_NOT_FOUND)
- Regression test: normal SMB operations (upload, download, delete, mkdir)
  work correctly for both users

Thanks,
Alva Lan

Namjae Jeon (1):
  ksmbd: validate owner of durable handle on reconnect

 fs/smb/server/mgmt/user_session.c |  8 +--
 fs/smb/server/oplock.c            |  7 +++
 fs/smb/server/oplock.h            |  1 +
 fs/smb/server/smb2pdu.c           |  3 +-
 fs/smb/server/vfs_cache.c         | 90 +++++++++++++++++++++++++++----
 fs/smb/server/vfs_cache.h         | 12 ++++-
 6 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.43.0



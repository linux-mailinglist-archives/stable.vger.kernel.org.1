Return-Path: <stable+bounces-253702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMd6NvkEEGqLSQYAu9opvQ
	(envelope-from <stable+bounces-253702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31D5AFF6B
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 500AB300DE33
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF9385D6F;
	Fri, 22 May 2026 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="H+gY2NYY"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA9379C41;
	Fri, 22 May 2026 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434695; cv=none; b=VO1rpQsHe/rBrNrXDybG2FJWMwaajXcT/iXq/azIdJSDu9cNItREtqtLRvVuQ16rNUPnk+t+8ddEdkCF7GbOBTl990h2Xs1oFKTR4QqRt/qFw9YVd+GDaY+pEZvgLpM31fHJSMT9iU1qliAQ/0BRXGsV+O5sVSmxTusx7y+HNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434695; c=relaxed/simple;
	bh=WPlKM/lj1sjmTklcjjg0yrhEi4nQ/F7CRUTQhZjKvTY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=llpjzl4sCU0emvnZF78WlWyIMtQAdMa5KOAut3BPV1UqCHofneyrd5lyoKuqpnPjhsg+RSg9Gk6ZF66C0EMuYTSqsICzMNYdS+aBFvqoSqfCKksvjBnZ8v2rU28qVceHInyj9fg3csX1M5mHBmAJmQyEurkQ2E5DXTXY70hv2MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=H+gY2NYY; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779434681;
	bh=ZmP15dF68ZZARYXTgxlwo+JCt5bWeYMJpCtINbqr+LM=;
	h=From:To:Cc:Subject:Date;
	b=H+gY2NYYu8gRv8t6xRGaMgF8lq92HYOSDo0R5HyAZTrzsPP7jIxV5QhDdq9+wWjKQ
	 5M5/Qqt1NuV3uyuJGcq61Ww4D3tCnF8EwMequ4OSNzbRR36xlb94h6wkaofA4VzJm1
	 wAoCizcjZ3QNIKUGt+/3toq9TPE67gtdFEpmzPPo=
Received: from China-team ([120.244.195.95])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5D598295; Fri, 22 May 2026 15:23:21 +0800
X-QQ-mid: xmsmtpt1779434601tcks9u6av
Message-ID: <tencent_0E921F0C9250D64D384E305D0D4EB46C3508@qq.com>
X-QQ-XMAILINFO: MdQlRvFjDAz/gaplPXvjfUXbWxz2aI8uq9+cYUddiAB9BzKuos7vLzKa/+pMLg
	 sfA9oBT9Nzh0Xf6okDSPPdqEU+mHXpwZ5u9crI2L0DMIdM3p8LmzmtOt4cB+5PiaoPF4GkaCoflO
	 JdtiNo08jBtriSeEi2f/TyZVAFAEXm+7XWCOf/+u7UlE0jYn47XmxPsVqM9VOSeXBXI8lZ4jXLXh
	 077TNbCdjEl4ZgGg3hm4RZdP0V96+KGBwTT2sBe5OY9L81pfBAev80tC7svbnlQzq96tvUAaewL/
	 tZckQUJe/C6U1Jo6Ixjzwpn3d2ycV9B8akKkelS6eBHZArnAjUPByzic4/sbhEFp9yhxeYcIiCuz
	 eeAkT7aJpI0sS3l3w9NlXesf2UHHL/AoiVit5D9KgOFAi9kRLqJBPiun/4592kOWd2k0X7gH31pO
	 uqFusjsWi3PhNuXA94xxvZewvRvxuWkU+L/rbDBufJkir51mkAGJ5qeURUdECUDdX3ckjc9tSv+y
	 67xq4Cxm6lD1eO9TeYisKqXiRhaEb1cxhJJ5a6Dsbf8rG5mVxQsnaY39XPIKkdm7B5v1cI1XKOFl
	 LTkhn+Vb3tARDhioTDxNnDbpOaEhiNGjcV5V4qcf/wYVcrzNjJiHWA//c19JVQyIUgtOktEMgCLF
	 A/15lWTOzXKvfZCszIHOLJsPoBerGsMgOixyNfkd3ftlE9d8s/NGxj9sFBclb/xFuj3Z6nBlfOJt
	 XXsWNbp5JE0W/tX9zpUbdf957fxySssulomTvzVayXk2478OWRaE9iDx739op+jb9z8u+HMIlMRL
	 1ryjg3J38j6VDBa8210ZDvrLAc6iuiNdQDqI10nmYlDq5GOWmn6bNrnQs5/oNtV60WhM2Me8AvRk
	 rQlbn3SLElEudU+TutUDlnMJnYzr/UaKO4rvJmMcNFywOZxiZGXyQsgpm/LzTXKYRTOju8sp+/iS
	 al83vkVJSXqwTgGwBGI/Ylk+gs+JRMdOxOMWijeYQKS/gRn4e/cXoOflTfVrgFvxwKoLSRW8Wd+C
	 4nnwDTqBqJbXn42S8O5lcnIr/kKEqdMcdbBG+Dh3kNhQ9RZUqnIHYDje5mSkQEMbrhRB9aWw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	alvalan9@foxmail.com
Subject: [PATCH 6.12.y 0/1] ksmbd: validate owner of durable handle on reconnect
Date: Fri, 22 May 2026 15:22:54 +0800
X-OQ-MSGID: <20260522072254.960-1-alvalan9@foxmail.com>
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
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253702-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid,foxmail.com:dkim]
X-Rspamd-Queue-Id: 3D31D5AFF6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch backports upstream commit 49110a8ce654 ("ksmbd: validate owner
of durable handle on reconnect") to the 6.12.y stable branch to address
CVE-2026-31717.

The vulnerability allows any authenticated user to hijack an orphaned
durable file handle by predicting or brute-forcing the persistent ID.

The fix adds owner identity (UID, GID, account name) tracking to durable
handles and validates it during SMB2_CREATE (DHnC) reconnect, per the
MS-SMB2 specification.

Testing:
- Build tested: compiled cleanly on x86_64 with CONFIG_SMB_SERVER=y
- Boot tested: kernel boots and ksmbd serves shares normally
- Functional test: verified using a Python SMB2 test client that:
  1. Legitimate owner (user_a) can reconnect to own durable handle (PASS)
  2. Different user (user_b) is rejected when attempting DHnC reconnect
     with user_a's persistent file ID (PASS - STATUS_OBJECT_NAME_NOT_FOUND)

Thanks,


Namjae Jeon (1):
  ksmbd: validate owner of durable handle on reconnect

 fs/smb/server/mgmt/user_session.c |  7 ++-
 fs/smb/server/oplock.c            |  7 +++
 fs/smb/server/oplock.h            |  1 +
 fs/smb/server/smb2pdu.c           |  3 +-
 fs/smb/server/vfs_cache.c         | 87 +++++++++++++++++++++++++++----
 fs/smb/server/vfs_cache.h         | 12 ++++-
 6 files changed, 102 insertions(+), 15 deletions(-)

-- 
2.43.0



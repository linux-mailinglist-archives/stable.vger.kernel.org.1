Return-Path: <stable+bounces-254263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M5lN3ZSFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:57:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC745D223D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 09:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 529DD3025C6D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F223B2FC8;
	Tue, 26 May 2026 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="zbOCiHqo"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592718B0F;
	Tue, 26 May 2026 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782254; cv=none; b=vGqCtjm1C1d8bFeJhMYc5LuohNgzIvNk/PVYnzYrjkhwLIkDW7+dy2f2UOccLvKoQl52SV+sdRq7QBddHkUJQ58IWdImxGhljA5u6eGoPp3fFXEI6AQB5OVc8nmwiLm8O8PiQX0einbtPwnLKCLXOVs6T47oEheKxmvTPS/HWmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782254; c=relaxed/simple;
	bh=PnqTV9V+fnvoN4F8px5Nd6NNQC+yd1mhucLYOO0MwMM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=rLs346ik2Z2h7luqOCdyVl1Yz/BYbZg+LUMoDNs5VjtGsIYG+rww+wiK4AhtoW+4WRE9+Dbjwh0O4uXTiMClyFQuvTgh8oNsgwRjvhGX6WJ4uMbbCgsO6sG4hl6P5rUNagIM8QQvx9O2R+x96wqCdbFsheg+1P3BRvkv7IAZQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=zbOCiHqo; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779782249;
	bh=sqMgRSCFvAis5biVx32P2iNc6U2jdHWfyVRXIcQRFBQ=;
	h=From:To:Cc:Subject:Date;
	b=zbOCiHqo+O0kAaJ6TcvdnxmkO0MTWcZ9ryvW4Dl9mLIYGKRMZxoIUuYyb71i52OkZ
	 qoKmekSmixOgd2WYP7IB2vqszoBOjp4dR0ZMVOp1fPdqwVCjIqVc5n1PpJXRNpmQ1d
	 kJHT39IPVYhgZFiHiX1OzWgl9YdHwzxwSNKXoNDE=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id E4D83A4E; Tue, 26 May 2026 15:57:13 +0800
X-QQ-mid: xmsmtpt1779782233t210ellyy
Message-ID: <tencent_03EB621C56988886195ADF9AA78F33494007@qq.com>
X-QQ-XMAILINFO: OUdSXDVXBTEGrF/++qSZr8QspowMmCmp4fqza+JdNUQmfzImkMtARi3RuiQdKX
	 60bz4ZfmEbpoFoUmES5MH6V1lQrUownLkt72W7eDnIc8dKY0QOQURFwvlMSXA69S4DYtRUcNLpcj
	 Ktvnil7fnf2In2m4/BUn4jrTkv3AYDlE2CSE/FtDB0vW0575/RIYbQba3PQ/U8tKtWYbAVXp5xwV
	 KVLn9pB5FW3mUAegMcVzsnwpJEFkVkOT/mVaFiv95SP9APLL8bWROPnqgU+VNqp69zdQzcekPXFo
	 r0NAuZv0py1KW4I5XChfsaai7nUYNtceiSdgQayhy6PKIvWtvwjAe9ykl+2htuONHolh8rJbKVs3
	 MjIPeMPA+6+crNO4KmasPqDHILX1Qt7Yw/g23UONfwwL6oYvQEzG6w0jwz/Pi8UI4SMILSC/iyXG
	 jMBYQdfY7jewuJI1IQ79EBp/Kj+UzuHXv/WHQCiFiYRdVHiOf8LVkhL5TQmDCFrsnkxNmfi4FVf+
	 jW1P2XjbDlOHLaBtDsJJKcfRNe33eZhiIOIMWDYn45Oja0wOjV8Y5AT+UKMNhqQAAKo/Sy92KdSc
	 pOTdNaJrHqI4y5VN8g1cBNq5lpnXCGuDpmwrxBsUJvjtjX29yBnd3YDOGh8UWEiKhpwPX99xwL24
	 VMdJNPE3hHzqhG4nKio8zCdFQvpx9Q5cXDIcOOnpoWgHsEmAVVCzGqEF4M3U/tZLszYTJDTQOuNq
	 ZdVtbkunVjA9DqY05cfvTyHEEIwjnZ3lOjVXL52Exn1n6QnN2DaupFqJ55ghYl3Zqn+OiDdyE9SN
	 8XQwKIkgooKIrHJ5UnduAjTTtytbIUdnDWvauEpiO+MoKy8hTt6EMLyO7F8as7v40FRHoXDAYsl2
	 2pSzhlPma5k51BaXgblCgv/8/U2dmmApH94ZCO1dBbtF4wEIcKgcOYSpZwBrT8ClxpekxqRSYxRx
	 qC3r8LQjZWf7M8YZINkB/GdJS5IV64l+paov3Nkp0G3okL4aLUr0E0Gl69iXNN4iWgLclRq3dBVO
	 q7quijC+9wkzMZv7J/inkkwbH5JZth2TisG+m3uKoAMxTfubTQoLUKF1NW+SaG/Xt8gJ0p9Is03c
	 EjDTSM
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	charsyam@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y v3 0/4] ksmbd: validate owner of durable handle on reconnect
Date: Tue, 26 May 2026 15:57:01 +0800
X-OQ-MSGID: <20260526075707.50228-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254263-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microsoft.com,gmail.com,foxmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,qq.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BC745D223D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v1->v2: add two prerequisite commits
v2->v3: add bf736184d063 ("ksmbd: close durable scavenger races against m_fp_list lookups")  

This series backports four upstream commits to the 6.6.y stable branch.

The patches fix:

1. Patch 1 and 2 are prerequisites that add proper durable handle lifecycle
management (scavenger timer and expiration handling).
2. Patch 3 fixes a missing validation that allowed any authenticated user to 
hijack orphaned durable handles by predicting or brute-forcing the persistent
ID.
3. Patch 4 fixes race conditions in the durable scavenger thread that could 
lead to list corruption (fp->node reuse) and use-after-free when concurrent
m_fp_list walkers interact with handle expiration.

Patches:
  [1/4] ksmbd: avoid reclaiming expired durable opens by the client
  [2/4] ksmbd: add durable scavenger timer
  [3/4] ksmbd: validate owner of durable handle on reconnect
  [4/4] ksmbd: close durable scavenger races against m_fp_list lookups

Testing performed:
  - Boot: x86_64 target
  - Functional regression (all pass):
      * mkdir / rmdir (single, nested, recursive)
      * read / write (small files, 1MB, 10MB)
      * append, rename (file + directory), delete
      * chmod, stat, directory listing
      * concurrent I/O (5 parallel writers)
      * multi-user access (cross-user read/write)
  - CVE-specific tests (all pass):
      * Race 1: fp->node list-head reuse — no CONFIG_DEBUG_LIST reports
      * Race 2: UAF via refcount race — no KASAN reports under concurrent
        rename + scavenger expiry
      * persistent_id recycling — new handles remain valid after old ones
        expire
      * open_files_count — no underflow when detached fp closed by
        unrelated connection
      * Owner validation — same user reconnects successfully; different
        user cannot hijack durable handle via DHnC
  - Server stability: ksmbd remains healthy after all stress tests,
    dmesg clean (no list corruption, KASAN, UAF, ODEBUG, or WARNING)

DaeMyung Kang (1):
  ksmbd: close durable scavenger races against m_fp_list lookups

Namjae Jeon (3):
  ksmbd: avoid reclaiming expired durable opens by the client
  ksmbd: add durable scavenger timer
  ksmbd: validate owner of durable handle on reconnect

 fs/smb/server/mgmt/user_session.c |  10 +-
 fs/smb/server/oplock.c            |   7 +
 fs/smb/server/oplock.h            |   1 +
 fs/smb/server/server.c            |   1 +
 fs/smb/server/server.h            |   1 +
 fs/smb/server/smb2pdu.c           |   5 +-
 fs/smb/server/smb2pdu.h           |   2 +
 fs/smb/server/vfs_cache.c         | 309 ++++++++++++++++++++++++++++--
 fs/smb/server/vfs_cache.h         |  15 +-
 9 files changed, 329 insertions(+), 22 deletions(-)

-- 
2.43.0




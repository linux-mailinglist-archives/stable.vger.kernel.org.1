Return-Path: <stable+bounces-254123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIaIKBMnFGrfKAcAu9opvQ
	(envelope-from <stable+bounces-254123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:40:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E105C94EB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52BA33011A43
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE17357D12;
	Mon, 25 May 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="nlnRBu6W"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A634F24A;
	Mon, 25 May 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705615; cv=none; b=U+OVDS1LVpIUuvl7kpnGoFd3/PENUlgsV4eWsWeJmcYI6kcTZmKd8TRJEVbJbxMTuyOh9DehYOG73tcuNJy4EjRcwSMAoeV2jcxXFSwGsikJaMRyHWrrFyjUlbdZxgi7rPpC0OtLC36evZBJO12kpVCgsy3U60KUY6pBroA2/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705615; c=relaxed/simple;
	bh=c56zK7PwjSz5Ts+zrxCx9znz4Bg1idB/dBVGkmu5nmE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nEFkLMu0HfvmTjZ+mOGS4Z3VoAmwIhDDchZV4X3os9AZysxZNNbKY8wbUuZ3YOMrrWbRNkB7M+s4ZDzac5QIN906ghDG5+y5shAoeYkgbL2aPVWyfPtHEUfu8bC7f4Y7vylechVJRhZFeDUMsLECVlnko5DQZi0DLRGndJkNzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=nlnRBu6W; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779705601;
	bh=v5EnzdfeGWLhVdhlBe50e+oFPBlpVGSN/N5s/YOU5k4=;
	h=From:To:Cc:Subject:Date;
	b=nlnRBu6WIP9H9j+lMuUz8CvraujoSOfhQ8diZHUmtw9IxeKpu8dh9PGSYSwkXgujX
	 MpUKJhJNut799zVJ4hZ79fqgbNP9Q0aoQJWBdcy/hUbappiPNEQNxDAOQO/HnDuH6L
	 lQkKjzf9tDZcLIbMd9gZlrCkx8JlSrzuOiHBTkkU=
Received: from China-team ([183.241.55.175])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 9F323408; Mon, 25 May 2026 18:39:51 +0800
X-QQ-mid: xmsmtpt1779705591tlmexgx0c
Message-ID: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06iZAb2TwKlcpLWKCS90BSfikC4n3+7D2aCFdxDi62pIFLE3Shs5H
	 vmZjjV+dGlqDLlGeKjJe56kQmzolWJ+uW763QmoNxi8sy+P1HjwzaRnkaIyeaSJKp4ReiXSzvuN2
	 /VkAiB/3chb6pGRo22W1jWna0AnGK4i2vzYbdCeY1iiFtNXiUSrnRFNHsDg6NrQN/DXwyrY1xtzf
	 35WkR6/9Uo73R3BTKSSsCBmGDAnU9Bcw5C80A8YxTNLHUQ1UuzPIXfWJEdyzNiZss2lAwFZcCw8I
	 lRkLBEwPwdOh4SKhdy9Abuz9rjmCXo9lig5NbL5dU7hrsxd0eMsCdzGJEnXV56svs6wAuN/Ku9xY
	 LdNGp94XNOEN9SRC3xPh+nJqlg2FvQMWpVT8HedvmUEwkWQURrnlUlPhr3FHqVTMvQCKbcWDJ7Oq
	 CK4m/Nyc0rp++9rWRnpQCAxTpxXGWxRYe+dbKHofJoAgHNiTUdus+mZ9BkRf9oidwoqOKSbiOyGo
	 zYIkrEr1mm9YpqDcUSmFuJAwzzTjP4sYKAf3HMHDPEedV7wV0/Ie/yXGKxMk243Qi7qS0Pt2IphW
	 CAziItQ9OBzZS7S3XtNVa86yRwlQdLCzETekjc7pWfRHOoedgdO7iqXtPkjYbUWzt26YxIO/HL8q
	 h47K3AENRTwqpgIKbsPjYjBmpMQvMaEXCFatoLb4V4TGaOtkz7EpA9hUbaHCWIgOF0HESYXJMx5I
	 8nrhfG7CbDAF3RnbNz0obD7TLyyr/q9+5A2K+Ob3mTCtUdXCX+t4OA9ilucn+uYaZeS10PgyM1bV
	 nJ4klTApqqu8Nvc83z7ObrAy6Epx6CKOlfsItDSMphWSr+UgiTgPQOf7dUZRkBp3qhbX9dDiQGCW
	 JAfPB+i2xNWiHXPz8nSL7B4haPl9V7LhpWToA58IX2y7IfyNcWtkyFTTb6QfbzStEAOttda1kN/o
	 vcXicUlWdDWHLjU4H8QxUuUE0bt7xy1vEq6k8ub/sleOdr7eHMxCiiTPmRf0FAcMFLi7LQSFtyiQ
	 C125SzgbANECmBcv7afLT0iAsbjJBJ9RtcGFDOS7qk6DvQfSrBGmHZ+wick8RH0ZDB9Gjbe7hOCy
	 zHTlHg
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
Subject: [PATCH 6.6.y v2 0/3] ksmbd: validate owner of durable handle on reconnect
Date: Mon, 25 May 2026 18:38:58 +0800
X-OQ-MSGID: <20260525103858.1035-1-alvalan9@foxmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254123-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 48E105C94EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v1-v2: add two prerequisite commits

This series backports three upstream commits to the 6.6.y stable branch
to address CVE-2026-31717.

The vulnerability allows any authenticated user to hijack an orphaned
durable file handle by predicting or brute-forcing the persistent ID.

Patch 1 and 2 are prerequisites that add proper durable handle lifecycle
management (scavenger timer and expiration handling). Patch 3 is the
actual security fix that adds owner identity (UID, GID, account name)
tracking to durable handles and validates it during SMB2_CREATE (DHnC)
reconnect, per the MS-SMB2 specification.

Upstream commits:
- 098c0ac3808c ("ksmbd: avoid reclaiming expired durable opens by the client")
- 894947e0736d ("ksmbd: add durable scavenger timer")
- 49110a8ce654 ("ksmbd: validate owner of durable handle on reconnect")

Testing:
- Build tested: all modified files compile cleanly on x86_64 with
  CONFIG_SMB_SERVER=y
- Boot tested: kernel boots and ksmbd serves shares normally
- Functional test (Python SMB2 client with DHnC create contexts):
  1. Legitimate owner (user_a) can reconnect to own durable handle (PASS)
  2. Different user (user_b) is rejected when attempting DHnC reconnect
     with user_a's persistent file ID (PASS - STATUS_OBJECT_NAME_NOT_FOUND)
- Regression test (smbclient): basic file operations, concurrent sessions,
  sequential cross-user access, and authentication all work correctly
  (11/11 PASS)

Thanks,

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
 fs/smb/server/vfs_cache.c         | 259 ++++++++++++++++++++++++++++--
 fs/smb/server/vfs_cache.h         |  15 +-
 9 files changed, 279 insertions(+), 22 deletions(-)

-- 
2.43.0



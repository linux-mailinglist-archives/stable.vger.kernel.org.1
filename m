Return-Path: <stable+bounces-268721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mETEBgL9PWot+AgAu9opvQ
	(envelope-from <stable+bounces-268721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:16:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9B16CA145
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:16:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="pZhc/42i";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268721-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268721-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C8D3016933
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C497539183A;
	Fri, 26 Jun 2026 04:15:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23A3002A9
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:14:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447305; cv=none; b=us2U71rU+R5xfAzC826H+iLdJV24BDjeXgMxl+Ks52nQGWulho6RCaTCfD1JzuANssobP1RAwCoFkDcC8a3HF0StG/oVYxxhmcqCbLpa1G0r+CXnAqOTprX6vhuEsCaM5AG4PvcBrrNDaEvjDlKZXOIDthZsigjl3VzWYspxz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447305; c=relaxed/simple;
	bh=oI9QGYJth1gjNQ8oDgeZkKfupAiSowBbCeYr5lPt/rM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPMw+xWjJfeUXgSzz43lbPLGF1bJ4BHJmMOGDnWZ73kPLJWs5/6jp8EhqutZEMmZcYIqLxfGdRUQ2PnPqhS2+5VxnZSU5jq8BjtP0TzHZDSYqypX2tG27ggoqUzZSv2Mahts7No6/Renak8hzBBDwktoTfxL84lHfPnf8xYMqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=pZhc/42i; arc=none smtp.client-ip=18.169.211.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447268;
	bh=S66SZcPyNPUpr4UFHh0U02fZjcAIt3m4dW8k3XmnXhY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=pZhc/42i6KmT4CrUD0sKGAGpKILQZhRYkZRJ2OBCd7ijE5MIRpfkxeFDDGNKoix3x
	 2GSkTL4Lj7BI2j7QSiPL4BKcQkmEmF6UmgYoG2EGq8oaPWbxY4uXpKNvrtmfC4/kJu
	 Ke87jfRcYRJnHGunoeZtbKgQuqZjRr9opi9+Dh8k=
X-QQ-mid: zesmtpgz1t1782447250t18671444
X-QQ-Originating-IP: CivRGHKaUaY4cJVzKNnVTa2E6I4eVh67wCfkqeaYtbw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13279727966186682748
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll / struct file UAF 
Date: Fri, 26 Jun 2026 12:13:55 +0800
Message-Id: <20260626041403.85968-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MykGmXyv/f/uaVwNd3p7B0B9GNEp3JgMMox8UI/qfHW8UN9InjQ1vY0L
	27mkAx0E3ilhV2cLl4oZy45pUMkMHUqu6+5rw+cDda+Z/4uOxQVQ/TE1uYfygEGuiLQ98i9
	j8jJwhjfHqlW2H0515+rrRZ5Z17L7Wx32wpxdl4rBErbIr10aH6k12nZMWS9RBO/yq0pfj5
	d9O7a1buQVmPc3302xRtwYnc2T7z7Ku+HYydQqX1KFAHkBrpaNXSVbUe1SE0rzRknY/kJIA
	HBVfmEz/BuH7GUntv5XJ4Pd5fALyUV9gso3355Zh4PgNY/MwzcsRoj2yzDJUAeluPirM9zi
	nPrFnZ7nUkZ7Z5Af5ufX5SHXZxu1w8UQbhNvJlcBH+SVWfF5hap+PUmVTZ95aQuzoMmJSvI
	SBjbvdZZSEI0DVLaTtQUrrDA+16FtBfUnZMCWyqeR7MGP2/ocXaQLDug+VR+1nFcZ8EIXXe
	0UBlBP20RBr3aJxCOXsyBsNuFccCn/idXAladE8sM8pL+QGMQr4plY+Zbmmo5mLnvORlAMx
	DVxcojpAC6zkHnfUvQKwI2s5B7mo1QnnFCdQ4ORZ9fkehdl7eT9nBvjNRYR2ijXjL/ACwXW
	bkK6cgB2kJFYRbZcaip4/k7NnHRs/lYoeA4KzJQTaO9mVUAMoM7AlPc8OFa3jrBx3qsi2Sy
	vsISTiYX3+F+dn11XgfUOXSCpwh9r7alLjxbRkm3mCM76u7ttKnNvy36FAcf4fgMGZk4GsB
	Oms2Nsh2vfDowTu8z8+WNmok0cf0guDi4Fg9SmMCLvA6FUYG7NaDZlFL6OEEwObE2KHUHkX
	ZVW/Ejoc7VZqoTpsyaniJT0oKxLyAVLmDlK2cnBR7/zUCH2Yq4YlIy0YT9jQCL1OI21sKWj
	Zho5d7JWUbTHOArr/gRz8utlSqEMHVyZirO6czdbNaoPllXsP83XxI9NAnL+iR5BYWCepbh
	4li9B4X0MY0zEwm0O4CzCX/G9GmK6e3+57VjvCeNkqB85hieDq4aOwYkSUg69KCJv0uayup
	mVbpAQcHZ9dy+jwozpjKZKD6bPBgfqngTu1a5ZGSoZocaels0QRx29v0opy2id5ScuX5F60
	O9jjoqw7+q0PpX/OitHI4A=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268721-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:foss+kernel@0leil.net,m:stable@vger.kernel.org,m:brauner@kernel.org,m:guanwentao@uniontech.com,m:foss@0leil.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B9B16CA145

Fixes CVE-2026-46242 eventpoll: fix ep_remove struct eventpoll / struct file UAF

base on link: https://lore.kernel.org/stable/20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de/

add commit ("file: add fput() cleanup helper") to fix build error in v6.6.y :
error: cleanup argument not a function
struct file *file __free(fput) = NULL;

Christian Brauner (8):
  file: add fput() cleanup helper
  eventpoll: use hlist_is_singular_node() in __ep_remove()
  eventpoll: split __ep_remove()
  eventpoll: kill __ep_remove()
  eventpoll: drop vestigial __ prefix from ep_remove_{file,epi}()
  eventpoll: rename ep_remove_safe() back to ep_remove()
  eventpoll: move epi_fget() up
  eventpoll: fix ep_remove struct eventpoll / struct file UAF

 fs/eventpoll.c       | 142 ++++++++++++++++++++++++-------------------
 include/linux/file.h |   2 +
 2 files changed, 81 insertions(+), 63 deletions(-)

-- 
2.30.2



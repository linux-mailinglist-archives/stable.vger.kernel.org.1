Return-Path: <stable+bounces-260471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A0JfF3trIWqdGAEAu9opvQ
	(envelope-from <stable+bounces-260471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:11:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F3B63FBD1
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:11:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=Wv9LYyop;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260471-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260471-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03291312D514
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B442DFF1;
	Thu,  4 Jun 2026 12:04:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E14266A5;
	Thu,  4 Jun 2026 12:04:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574643; cv=none; b=ElHaMJaBUSI8/hKXm+923gSAfIp71P4vsgkPMHFKMwwLu2MnNasdVFBeaLDr3RzKkbSDZU8xc1Rg2mBlBsVkHqhGtTQG3P2NZqJpA5sNggMgPu6VNhRORTxe+YXf6dPjZn7MgRqPSyWldkyqnU8UNLQg2iDX6QJMacnkdju+1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574643; c=relaxed/simple;
	bh=ZM6f0eCw9JYN0eFB+IzJL2AO5YSNKkge7oh3x0mIL9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1efq4s5RXBPwhgryp9KmrbRzJqskD7FQQm5w0ThxwzucDpdhrms9EALrVZvTWaFfAhnsIT5t7T2rjAUlj9wOqJd7rJmaQhtx/v4+HQtqIEx5qq2AvfN0tLPWfBzp8rk2IAIcfKUVYQmV2NrwX02NhZhEyL6CHxjHoTUYOmYvXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wv9LYyop; arc=none smtp.client-ip=54.204.34.129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780574627;
	bh=s0SOSgnZPxT0aZX+C5VOVu4hhsXwJgTrAroZMlvrXik=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Wv9LYyopZfFF+wgWWssw6pTKXYDub7UyjG1yCx4aeDaYHxqTqXM24SuVGVYN9fk+f
	 Uz07cZEES2ZE0UBjulOy0C/jS12yR8Fg1pRv5uwmg6z0OfpuPfiEnuMyOogPmGPtty
	 AdAa07fXxHP69oDD9Fp7Hdv8hOCP+B03PUnRAkLQ=
X-QQ-mid: zesmtpsz4t1780574610tb7f59c05
X-QQ-Originating-IP: XGao/hgIYMDEWKq8wNOgeLlCI3YyVgRTcKh858Y4tQw=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 20:03:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6098904183643236574
EX-QQ-RecipientCnt: 5
From: Yingjie Gao <gaoyingjie@uniontech.com>
To: linux-xfs@vger.kernel.org
Cc: cem@kernel.org,
	djwong@kernel.org,
	Yingjie Gao <gaoyingjie@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] xfs: fix exchmaps reservation limit check
Date: Thu,  4 Jun 2026 20:03:17 +0800
Message-Id: <20260604120317.930273-2-gaoyingjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260604120317.930273-1-gaoyingjie@uniontech.com>
References: <20260604120317.930273-1-gaoyingjie@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MpzYvQLGddWR8DeuEzpwGWw30dg71Z7DY36urENAZOCJyR8XI0vG4iG9
	aBw4GZY109pHZSJbAV15ZXy1oH5/nOzLnm6hu9iYFYaKzayDIgxixTj+9/b6+uX6n13mNqA
	rJEuLifjf+3LBoBfws4XRpnWecylcEsEBK5Y+e+JZVs9MbhvHj7ENtDmh9xvyg58AXBdPBS
	j/dljWdYoLQGVemFRGA8zafgOP6AuSoqWIYFHsiX4ONd3IGx8HCj7vJL0ZzMMBkXEPVDk3I
	o28DHSz9fB1MeXKGaF8Ex4aVN63ooO6+Zs8eqvm0Uz4gWc5Ax+unAGbquhE84KH7fk2IGWA
	ZfNwRe7hjkAtGrqU5AKHwQ8+YydQofA+Hr6H8FKKy0BCnjzy9kdK1BFPTXdfvWMn3THKAS4
	XH5CdtX9oDFjyFOPfteyoqPsNOEI9fR3E2TSXJguNJZQZM4EUOCdYejsmuTG+ll4IQ/Qox3
	cW5fkzGDeqshILJm6hAi6uWgVaMR4aSagZlyWcSOkkJsrxh3KULE9FxUoDySni7JixsxLsP
	qeSYfflh8Rb5dwk12MP9z0AInzhk+q9ADUtAXcKhr74djt7PrZrZLULPPmaAQ0d52j4GgDl
	aDkNr4B51bDZvywQ7aLXEQ15WuF968LJH7IutBuPN7ZY+GfStuIUE/zPTsVCmAEaSP54p0J
	EYg0TU2GTX1+6PlGr8pMQWBLGmfmfutG7t291BJSa8OoQiKu5KMUg3OWe00Kx6nDaLekOdb
	2XbOHo8duIhm5B8C2/jy1LtK/IjkNN1t/wtmfyEkkq6IhX3fe9cAwKvVtQ/aARbN5jQe50h
	gX6BMUYGncvfae2l+OId+4wDn+GmorO5qYCuTXNksGOsu/FA3SKjCQKmDeywX6jc2JTHsQo
	YAcmXgEkdeh1PPeIyewZKMD1S99+24WeNcfCDZao8Ogkt4NHftIUw1KkNlhMl8E/rlgmKq5
	EXhS8VmHeCkGFH1Xeh29r8ypp/0aaKRckdy/7cYO/xqbk+i8PFlFLZWq4HmnYa7yAZOAWWL
	hPZ7GPCj4L3+qCsfVVJJq33mTq15PKyqEA+n2Y+jP4zVtdXG/tU7Csf+FTc9C3kdZL/patV
	F8Ur2FvbNicG4FgOw++JDajtQ9yUeTYRws9Rarf5lywCg9cRe3KD6iaZyjE0EcjuA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260471-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:djwong@kernel.org,m:gaoyingjie@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gaoyingjie@uniontech.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaoyingjie@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim,uniontech.com:from_mime,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0F3B63FBD1

xfs_exchmaps_estimate_overhead() adds the bmbt and rmapbt
overhead to a local resblks variable, but the final UINT_MAX
check still tests req->resblks.  That is the reservation value
from before the overhead was added.

The computed value is stored back in req->resblks and later passed
to xfs_trans_alloc(), whose block reservation argument is unsigned
int.  Check the computed reservation so the existing limit applies
to the value that will be used.

Fixes: 966ceafc7a43 ("xfs: create deferred log items for file mapping exchanges")
Cc: <stable@vger.kernel.org> # v6.10
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
---
 fs/xfs/libxfs/xfs_exchmaps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 5d28f4eac527..541e33f33167 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -711,7 +711,7 @@ xfs_exchmaps_estimate_overhead(
 		return -ENOSPC;
 
 	/* Can't actually reserve more than UINT_MAX blocks. */
-	if (req->resblks > UINT_MAX)
+	if (resblks > UINT_MAX)
 		return -ENOSPC;
 
 	req->resblks = resblks;
-- 
2.20.1



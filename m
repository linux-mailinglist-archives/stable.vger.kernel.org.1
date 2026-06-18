Return-Path: <stable+bounces-266981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KEsjKftoM2o1AgYAu9opvQ
	(envelope-from <stable+bounces-266981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:41:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E769D5AC
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:41:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=km9wEf8X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266981-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266981-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DACF7301F7B3
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 03:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925F30F523;
	Thu, 18 Jun 2026 03:41:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A12EA151
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:41:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754074; cv=none; b=GYkjKbO744apWzcJp1E3hQXQHhK2lptmtc0W1LzaQYL0dHqtcvRi7ehYRxkXFoD5A73qxdozpPUzfGDXS0h0jCyStdSR5dB75DgT7OIaSlZEeRn4Hhx/ZTwAr96MMeQ0iz0e4+E0Bv7pn0nN5jkoAI2GE0Ebwvq6itCKyV5gDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754074; c=relaxed/simple;
	bh=fLsq97/BGCyzzS2m73aGOVu4opLXQ8uaKueGxwCiIHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BlmZp4t6gKovbcZAFYukXowVV8GVo/COyONSJ+FDeC9IQDuznlvwyw8xrlIUUArq+U5QJLUThMOnvZJkKB0XQtBZm9bRibFPRn9z5kpFSfvDi10lwa5BBjurxDvsADfu7nuropS85wInjLmTeH4QqhqMDb39QA3BmhhwP3zC/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=km9wEf8X; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754044;
	bh=CEUiOwwzVKGdfDsZSCyJdpDXQ6zMJK5mTH5dI8f+kCM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=km9wEf8Xfosdpj3AAgY3Qmo9dp7nIucmIA6lPsgsE5x9tYNBAM/HgtUe4IMGnOB0y
	 B5tSNqYFvr9jYhRspXI2/2qe/QS3eV4SGC8QlvLAL3CmGkpijT/W8G0zGCeB3wxfkP
	 fdJv9tJYfhxQn9d4Uv8zsMqit4P+Qho41auDv/xY=
X-QQ-mid: zesmtpsz8t1781754038t7a064297
X-QQ-Originating-IP: YM6rGjxPQUmIwengeyDA3EUh9j6VUsjBu+tRV9s6S3E=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:40:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17446448977059131167
EX-QQ-RecipientCnt: 4
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.1.y 0/3] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 11:40:34 +0800
Message-Id: <20260618034034.1525175-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Na0AtHk21uUlvnER75r4zzxxEpm1jLYwcxu5hbDjaDSRfeohUXfrKRmO
	I4EBAvvGO777tDfdWn2bHnjmoGUACI1idyBkVbenD8v39Tnuvjs1z3npQi+80w7qDSHtFbp
	0QWoaaViLV3jO1938E9ZL4YGLi4T+OjvB9BuJ183QdbXkXO8CQF87AmJSUfV2MoZLUtpF2m
	jOP5IwIAVX++xVLfMS18pgORQtdETXOLoBMCZtT5ReDdigDvIF3DTQzceywd3cTiU2UPuAN
	M6f2XALhwAW1tQvZlajcOgPrN/krZLIOXLQGBDZTtndlyAVICbXMlM5DLTevEf4E/wOKEM9
	aLpY5JJGQem1nhMSNCknBjn2XF7jiHLuORvxBlThqNnytxG7DfF9FhbqJMkafWmuaGZZW/1
	/oM0nofl6tjQfBI847ACLxKkbPmuNoDd7zX33lrkcGnmZIn7ZWchssjrVzT5LwpkY6ybnxc
	7+Rl4Z8DMHzXeK6dtvuUCBOwzp9ZYuLsuTVrx0GUSGTfYzdVuAMieXCEnM433XcKp+zuWP4
	SDQC8rdWiD6x+OLX/D9+jEB7nad167DwefV1iWsIfyJbJjKiNIUbS0GkBK5WsPu2ECtTyTk
	Ql7J695RfJ1mnmhdoksUKtUynD5bnESzaUsFLhAmXVGLTOm5WXHbAckQPrk+VlxOHpCp6O0
	Wf8phE8pPUEzWLJF3a+hYMWM5qjOai9LNnwOQh6nJeevXSg16U62iSAq+WUdcTQ084uy3XH
	p9BxS5heeolIUZDuHty76xaDi2h+a2rDVEfR51iAu/rL+mj30pHhj3TUt7POgHaRM0D4kQp
	iN6DcHNqdwbL5FICbWEaDaW8Dfp3wXSjo0Gfnr3G+/I6OMo91UgsHT/LUM9EBPm6P50jhus
	1ejl9+kebH7MdgjiiEdjQvTPWdGy+z7uK2MZvv1nD4oUgCx38wYkgUgGOmpEAvClnTdw3EL
	sFNPYQzpTR5upHecFwnSpAr/BD9x0sKHRW5WMJKBiuEBj7IgbDzUkZ3QH6hNMWlYEHTXx4b
	2KgoXhz3BjJ5YYEmyAbrMakrYqYWZNois872IwyI1zo5bTLY+1ClVA3apERV6vqETZ68G6I
	w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266981-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:guanwentao@uniontech.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 206E769D5AC

Fixes CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption

Link: https://lore.kernel.org/all/2026061625-CVE-2026-46331-47be@gregkh/

Pedro Tammela (2):
  net/sched: act_pedit: check static offsets a priori
  net/sched: act_pedit: rate limit datapath messages

Rajat Gupta (1):
  net/sched: fix pedit partial COW leading to page cache corruption

 include/net/tc_act/tc_pedit.h |  1 -
 net/sched/act_pedit.c         | 99 +++++++++++++++++++----------------
 2 files changed, 55 insertions(+), 45 deletions(-)

-- 
2.30.2



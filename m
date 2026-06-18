Return-Path: <stable+bounces-266992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZzdZKrx1M2qcCAYAu9opvQ
	(envelope-from <stable+bounces-266992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 06:36:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1C769D815
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 06:36:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="LVgJC/4v";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266992-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266992-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A485430099B3
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E962E62D9;
	Thu, 18 Jun 2026 04:36:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3BA3603D3
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:36:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757368; cv=none; b=MYxx+h2bTi7MOKdIqGVLbfZ/80MMoOz3BdnruRhXuAEv+tghru64w+kQtj//AmLkyDx98Euk0l43HLgbBBQ+MTUQ8Bu+cumNIyyW1H4ABIcS076hz8IOSRstoUTYNzC35gTHgjPd9lxoq8dHls5Owst1cO2aOZf2sDaBAlgJgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757368; c=relaxed/simple;
	bh=9QlSxoGmZtR631g7z7C5a/t59jVTNAnbvBGpmXn89W4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iQG09F3AT6SDL+CfqBW7LCwCNqvyiTg9p6D5+8aSKAu6drGaXUneEn6dcAk2InHRGXMbvWUYAfyS+qcWfbQdrI9sAKxWyl+yp2QPpFUSDhrpJ+VccA8xfl3gOf3jwLz/CZOF5/1fFfKP0bscueTYv4WUhu35K4jbt/JuJtumsQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LVgJC/4v; arc=none smtp.client-ip=18.132.163.193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757351;
	bh=Cfw3Vcxe+FUvPdu/30c7yWY2vLdOK8SrPjvkZJEWPpw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LVgJC/4v9N5/CSsS+TIoHfxqpFXYiQfoVd4lxJbXJ+mytwDxUy+z8Q2Je159nLnpA
	 B4HSRj82SVoc/95SMFpL4OnOPXpzvxpY1hY7wmoN+7uIEOnufIiYCtKe8XJ1kltEt1
	 CQPRzjOjOtZMtPDg89zyF6zIUEyJe6S7kwDF9j90=
X-QQ-mid: zesmtpsz6t1781757346t09e8b93b
X-QQ-Originating-IP: oEh9yQHTChCX+W5ppguwiY+la6J0Y6veaA2+NEPBj/c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:35:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16430821010796026882
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.10.y 0/8] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 12:35:31 +0800
Message-Id: <20260618043539.1557035-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: OP9EQm+x2Jsk+JjsD9diDlov9t1BN8W0xW9JbcXZHQUBqbr5QsmN/L1J
	u3VvKzgtI9tViVrJU/FHe+HpEN8+aoDSgKfBZZNJm5VlmY9YOQOji6EaLSlyWlwYefOrg/7
	OO7UPDSBfSI0m9LJ57B5RkAmf1ZsAkpLtxUV+nxatbJvJVqK2uhBcsscXrHlC8qSUrfJYfY
	ojuwwbmu+vY6HU7MgXX7Uoo6TWUpemdQm3JjQ/F64ldLLkRfDyWtEEZKMy1OUSmeOt+7vAZ
	K9g23Fl/Z7BkNZ9mySWUM9UpMVA0T/7nzlpHR2VYWE6yhvZsdDwLnSnCCeZmX7UOCoVyLuX
	XigGTiDtM9Ols+/acrgLgIPgqSGXhCsbjzxy4ngtpvBmXJdbEmcLUjnFehEomeMHrFCb/S5
	fIwwa/BqQPMEUmZex78CDUJ5WYs4/MbtH7E4aSZMbqCWb7E3NRD84wefwXQDU69o2lph5Ax
	eF0s7k8+YJVqBL0Y5RPkiKlDhJqO9JMO4M0DrzG1T0g+ull4K1jcY5oOH4SR8oA1X9ch+Vf
	R8RpbHbj0qBPojY1AUlVlHFqD2JNcE15hwNbcPDxt8WDyHvJqSqUZpSsoqIIrBA1Ag93RhZ
	y6B88sg7qZpcsv/ZsNurLZ705lwq9NXHBUWc3arLY0IQMtaE4DvuaaJ4SH0u9p7Xh9eLQ7/
	//Ch0qFi7FqFsbsBAjY8N4rVOguX8l1R92IBCw+FhQTWDNV54wFAFPdP0xjN+X288ltjvJY
	vSRWu+bz4Co4AMNS9X42JdSewTjOedrcgQh34gKdy8y8LGLqMd3stBQ+gBjDqIx8tE22BkE
	tDc/wEzOpM22U5vZn4/aZgTtNUd6gyFZ4TgKbU2yMx/O3w3Jy8IG4vAsdbhn4ObbnJMZQGa
	BrP15OQTMUFuFEyglihxleNaCKA/kgOQMospRH17FVw5srcWQIHp/dePszLvsYlR/gJaVA7
	Qws0uA44z1amU4nlnKgJqaKB6EY/3N/oXgkDI9HRXBSXm8bEotYmxEoukvdsEO+hHEEEtSU
	CW7407CFqb6ZR9Er5cwnLseKAxoPRZ+B11ikk72dqUUK/krU2P9VtIB8miFl+v6gy5esdLi
	ugp6HyjOyz/yAaRq01we5fs9RKy9Qxoy2YHJTv0kisIGd+cJDzcwxInWbxiPh3IYqIH67lU
	HrMB7m/ikUhC9C2u9guNRFu/gA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,mojatatu.com,kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266992-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:stable@vger.kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C1C769D815

Fixes CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption

Link: https://lore.kernel.org/all/2026061625-CVE-2026-46331-47be@gregkh/

Pedro Tammela (7):
  net/sched: act_pedit: use NLA_POLICY for parsing 'ex' keys
  net/sched: transition act_pedit to rcu and percpu stats
  net/sched: simplify tcf_pedit_act
  net/sched: act_pedit: remove extra check for key type
  net/sched: act_pedit: check static offsets a priori
  net/sched: act_pedit: rate limit datapath messages
  net/sched: act_pedit: free pedit keys on bail from offset check

Rajat Gupta (1):
  net/sched: fix pedit partial COW leading to page cache corruption

 include/net/tc_act/tc_pedit.h |  80 ++++++--
 net/sched/act_pedit.c         | 336 ++++++++++++++++++----------------
 2 files changed, 241 insertions(+), 175 deletions(-)

-- 
2.30.2



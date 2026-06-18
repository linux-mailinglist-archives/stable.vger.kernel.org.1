Return-Path: <stable+bounces-267024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xVnbBCGlM2p/EgYAu9opvQ
	(envelope-from <stable+bounces-267024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:58:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9F569E463
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:58:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=IFfq906A;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267024-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267024-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A53B3078654
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BC3C942B;
	Thu, 18 Jun 2026 07:54:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82373BE632
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:54:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769255; cv=none; b=huTzlKFEAA8KuMVb/RsJAZWPdMPtKQF4kRxkDXVWACs9QWgbYMyq0SnqWhQIKZPNsWFvMZIn5+fh7NnqlLzzScu5TBHkbPbfUjp4bCjAglDgTHPxiJGu0hZ9oQSjnY86KMlLU46Nih67n6LrHB0DB3qC0mJ7BiYzL2i3ji1hZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769255; c=relaxed/simple;
	bh=6F2y4ZlnikioPGfFgow1EAUbDVX1Vi20GywbO9xZg78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rW4pvPAidw06bJYibTxu4dnM2tWZ4eCkjBAgQeDN36wDhCeFLWHaPJAoC56GNqLWNtBX3+x8ki9ZkLkJFuUjdJwlygiDgA9jcyh0G4RLZW+h5f8+0tLt5WgmSsIBftH4S0zNhIlBICnQR0q0J/+cZ1Fbq62TzHQw933LX9rz220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IFfq906A; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769238;
	bh=ixWQbR4S6QArwZ5JRb4bfQjRjzBfXulvNFGHfy9xabE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IFfq906A+pdTO+Rs90zm8avfaPms1+QP2WSlUy8SaoFHLsis3slH4HezVjY0SCzLS
	 L/fW5/OiMibCjSjDJE84CPPHekvf71A6C+yaOy/DIH/oY2lJenOZYmZlsuvLem+/SC
	 l7UpL46Cs8UUgvw2BY4v1v/HNgXz3ii+0trjJoVI=
X-QQ-mid: esmtpgz14t1781769232t02de522d
X-QQ-Originating-IP: HJex80uI03DNawBJvCM4DRvZd71fzObs217Ybdljol4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:53:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12883385946568431589
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
Subject: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 15:53:34 +0800
Message-Id: <20260618075342.1599593-1-guanwentao@uniontech.com>
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
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NGfP4g+rgS8GRrY/kxHeIVjTW9Wo5a9kdwmAQEg+Yb1OMoKo8poAFpUx
	7Ue56oX9jakMsOBrPur/XvAfjIN1cMFUJYdWBIcEp+pq4dcpgbUhxZMSprK9NlmPB5QToVi
	9kSGJJvQk/7RDIHIYAIAiAff7ZP4SLpCP/8CjURTJdXIEZ6pMaYiENnWbOwetlJ+Rf0RNvb
	rPMMj4GH9qaoIU+4MQJTYUCf08yTP7zzWwwCRGxlSrFj6h7/VvJXE4oN0LVnHgoxO+5hS58
	x0jZ04os9mdlSA+bSSPdXQFgGHehd6qjD29g5roMAtN8hbF3QWXdTB321BqDrVtchtFYS6Y
	LkGwlNMrMALrSgVBVeK+HqSoIF65JFxizkl4Y0Sk2kekPbrxX+YpmQq5/lS2Qp33GGp4gyp
	75fZ8cJru23IfpMvEu0Mh/ypQOxzndySBB2Uuk7Jz6Zhf+AzpSZKdliXmgKoAqILhw5BdY+
	LW4pyQiZmO0teZTAO+s/3d6hykWCudJdGSGqRpEvNjmANy5aga/AJjleLpTB+Fq0BnO3R9f
	+WMXQJ7tJmbEkhwZqGPuTAfFVCQ6LngF/9D0HLNT8HIHqgdgWB6sSGXA7nuM697FHZ/+dhN
	izvKHVuGvYuLmQV1AP0t4kROgQvvBmL1hOKCY+avaEjmsQwf4FumcvKrqjWp31kPY6CF9vQ
	2CYrntd9MaH1Y7ojd3qRNrh9dFQ6ZxqpdvkaI/wXGiaonC/eqJ2AF7v5Il2kWcYmghp2Wnk
	WysA3/EPqGSLAoIhR3jBWbD2BSQjg4y7T2NcxS8QplclqU2hUcEUzEdNFvKmvIHvmkGV3L+
	IZ8yu3et0ytovHnRUqi9rZB8r9i3JF68hBySQajzdMAlKlm645XeRomRyIX42RWbztlq6+D
	vKVct4C0eg4gaMrYDdU5BrHEG7hZIl2/8KIYA4Ou+Pskx45SEemGv1l7fZisPaRM4hi3sKP
	sqaxJ/hrASS4hgKPA4g1tgbBQtPIfKoYsSK6DprWYHCbYGThC/ghxDUZYxfvl/S0Bh+RSOV
	wkEZfZj3rbifExRzOqB4KkmzVU+j9Wq2SXGnt4HhfvA/PKadHm7c5IjUZwZbo9JaO/eCDXB
	kO7cs1LD9b3FsJCm1MIsUMo8uuSimIifwKurgnXNN2JpYi4mBME/e8=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,mojatatu.com,kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267024-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E9F569E463

Fixes CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption

Link: https://lore.kernel.org/all/2026061625-CVE-2026-46331-47be@gregkh/

changelog v2:
    Add ("net/sched: act_pedit: Parse L3 Header for L4 offset") commit.
v1 Link: https://lore.kernel.org/stable/20260618043539.1557035-1-guanwentao@uniontech.com/T/#ma9ef6d260833405f60ae88a1686e967b1416d80c

Max Tottenham (1):
  net/sched: act_pedit: Parse L3 Header for L4 offset

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
 net/sched/act_pedit.c         | 360 +++++++++++++++++++---------------
 2 files changed, 272 insertions(+), 168 deletions(-)

-- 
2.30.2



Return-Path: <stable+bounces-269286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qRu3AYrCPmooLQkAu9opvQ
	(envelope-from <stable+bounces-269286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:18:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DABA6CFAB7
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:18:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=KZBi+T9q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269286-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269286-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD4F301AA69
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A6D2F12AC;
	Fri, 26 Jun 2026 18:18:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6837C103
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:18:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497926; cv=none; b=JOewsiYljnWDCskYWs5DzB6/l03OcEwXFMj/k2J9kZEa7tkehj58CMQ5vTq+fM0+OTXsFo/L05sfqOZ9FOzxtWgGE2Tfi0ig7pC7rmHMKwmLyHzl7jIugLmV7qsXMy0twTzPnDOZ8GRMWXSX+UoWZoIQ2Klas5OOgXKqv0ZBl1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497926; c=relaxed/simple;
	bh=QowSFNfCYx5Ftp+LI0jN/Bv7vPZ2XG3v2JoahBRmOjg=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=DqoRpJ1CNhghz9/TaIz1G3MtW1Hivm4rQQIaij09iwg0XolziV1FbwEVLsA9dwez2GU2LCrCunbSMGReXI8Y35u/1EWzv80Jffy/zNXDg1IfATzO5SF1+l1BTkMGQlqXsPpuDkLM9y98MEopOKh6LIfSl0ZAmUs+xbfnWsT48qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KZBi+T9q; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497893;
	bh=QowSFNfCYx5Ftp+LI0jN/Bv7vPZ2XG3v2JoahBRmOjg=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=KZBi+T9qpGHYLlVggP8rt91Xat8izZAXO8pkJL2zRfnVFrUiFCGSB3sKJ0FDNQI7g
	 1t6/uoAaz9q8Ab2O+G2d1KMefdyjxmJ/Bd3VW/nt9zGuqG2arxPVd0QZG2btAS4vYA
	 D+J1ApluNuPeI/FRvOHdvhhZLmGVD3moCMDnJXBo=
EX-QQ-RecipientCnt: 16
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqSRfaFU9LsvuzaFpktXSE2ZDVS4QMAo5TQ=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: BZwvYuQNq/ymqLI/pLcNhWLa7WHgGmA6Ra02nvP6nmf+M772JZ9moEolgNRZyVrfo51dlUG2YNzq5IMc4GL1EQ==
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1782497886t543a85f7
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>
Cc: "=?utf-8?B?U2FzaGEgTGV2aW4=?=" <sashal@kernel.org>, "=?utf-8?B?MjA0NWdlbWluaQ==?=" <2045gemini@gmail.com>, "=?utf-8?B?ZGNhcmF0dGk=?=" <dcaratti@redhat.com>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>, "=?utf-8?B?amhz?=" <jhs@mojatatu.com>, "=?utf-8?B?a2VlbmFuYXQyMDAw?=" <keenanat2000@gmail.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cmFqYXQuZ3VwdGE=?=" <rajat.gupta@oss.qualcomm.com>, "=?utf-8?B?cm9sbGtpbmd6emM=?=" <rollkingzzc@gmail.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?dG9rZQ==?=" <toke@redhat.com>, "=?utf-8?B?dmljdG9y?=" <victor@mojatatu.com>, "=?utf-8?B?eWltaW5ncWlhbjU5MQ==?=" <yimingqian591@gmail.com>, "=?utf-8?B?UGVkcm8gVGFtbWVsYQ==?=" <pctammela@mojatatu.com>, "=?utf-8?B?U2ltb24gSG9ybWFu?=" <simon.horman@corigine.com>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 27 Jun 2026 02:18:06 +0800
X-Priority: 3
Message-ID: <tencent_05DAD3F87C24BAA969462990@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260625054005.0011.act-pedit-510@kernel.org>
	<stable-reply-item001-act-pedit-510-20260626@kernel.org>
In-Reply-To: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
X-QQ-ReplyHash: 411366597
X-BIZMAIL-ID: 13047240062566200871
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 27 Jun 2026 02:18:07 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MczAcLGAPQL2v3B8046FKnModlQBkY/Ckb4dmFM9vZMzk6oQSkBPQ4Ye
	U+hRVVdy3tsBX6hS3mnJV9sSqqmF7j9nqsxVqPFsdE8UD965U3OLPwObs9E11qHA+K0qWUR
	9v5a/pBfSDc9+r4cD6oY6OAjwbuO3pAZm33InVjoPZu5F1ATOkBF3xWO3zx/h2BXeyV5Aan
	y53YFnswN02jAK2ad9oBi+ypye4Fq5YWU0P48PiiqAK5qnMnpcKheg0NISClLVrvmDLGSqY
	PusfzdkbOvL1jY5px0rGmEJeeyWITnNYJYi3dbP03IC/EvZadZG9Xflbz4Mv+j+4o+P+PPm
	rj/f5NaiAOgMyAl+xGL8tgpt/6IXtNEckUMnHvzYRYE7NN2kyopo/Hf8rcmr0qs4no6Ikvj
	+0WEcyJxUq7UENc5kcw7rcK8WMV2S8GWgY36w9biLirj9D6B4dQAjk0GiRV6hIfHZxGvjcG
	eAWNgm5gH+SQBN4DTk3l+u1pasYF2hLuu3TyNoWrl3HmdLE4hrSz1D9hEPSVqKmlOzf4MvV
	ECD687umgkEOprB05JtpjVKRuVtth6RrHc+bFvf2R/xQqp7Y6Skx9tg+odFeCaSfWck6S4Q
	WqV4ugC4CPVsigLcY/T40hyBlvBJzKIYPWYkFymqcJO3cRRatfJihOwZ50xEjitM988RrRA
	WHsGLUNgxbdV2LxFqrKtXgR/6OtCuu2PILH/ycI4n0zw1VlH19qQGS56Gpccph7nCd3A7C9
	LIecO9PQWYGdH3Sa1kSsoT3r+yBrkpO8rDDJKgaKwFfgloG4CAHXDKHnuocO/ADh8vPSVIr
	cEjptvfFX0pgord5lyN9xmPQu+MgHn8TO7PJHYmLhfNFGfO26S3Z8zfwANW7Hn67MIl34uK
	Yf71/Csut9ogpWFqi/aBSGIbmKPVjPQw2X+cmOqR0sk7eMGpw0B4xSql3u2m4/bJXRDETk7
	0z6yhiXp2UFUAe1TwQmP+/MlK/1+9okgQFQ0BRPjZt1PSzy2zubd7ZtGwiQYgI0d+T0zZ58
	kGwx6QnbgUfBQlI4pw0enGWwy1vOYtAA2dw+mcZHEh80Hu/DL35zjVhnm3e/kepOigbVvoI
	DsKEYwY8U2BCAZCDFjz2p0MbNi9zYH1CEt84FPRMPPajXBUwjapklGxYZI1tLNYbA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	TO_EXCESS_BASE64(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:gregkh@linuxfoundation.org,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:stable@vger.kernel.org,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,m:pctammela@mojatatu.com,m:simon.horman@corigine.com,m:davem@davemloft.net,s:lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269286-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com,linuxfoundation.org,mojatatu.com,oss.qualcomm.com,vger.kernel.org,corigine.com,davemloft.net];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_EXCESS_BASE64(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:from_mime,vger.kernel.org:from_smtp,qq.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4DABA6CFAB7

PiBwbHMgYWRkIDEwLzkgYmFja3BvcnQgKG5ldC9zY2hlZDogYWN0X3BlZGl0OiBmaXggYWN0
aW9uIGJpbmQgbG9naWMpDQoNCj4gVGhhbmtzIFdlbnRhby4gVGhlIGlubGluZS1wYXN0ZWQg
YmFja3BvcnQgZ290IG1hbmdsZWQgYnkgbWFpbCByZWZsb3cgKHRoZQ0KPiBAQCBodW5rIGNv
dW50cyBubyBsb25nZXIgbWF0Y2ggdGhlIGJvZHkpLCBzbyBpdCdzIG5vdCBnaXQtYW0nYWJs
ZSwgYW5kIGENCj4gcGxhaW4gY2hlcnJ5LXBpY2sgb2YgZTllNDIyOTJlYTc2IGRvZXNuJ3Qg
YXBwbHkgb24gdG9wIG9mIHRoZSBxdWV1ZWQgdjINCj4gc2VyaWVzLiBDb3VsZCB5b3UgcmVz
ZW5kIGl0IGFzIGEgc3RhbmRhbG9uZSBbUEFUQ0ggNS4xMC55XSB2aWENCj4gZ2l0IHNlbmQt
ZW1haWw/DQpUaGFua3MsIEkgc2VuZCB0aGUgd2hvbGUgc2VyaWVzLCB5b3UgY2FuIHBpY2sg
dGhlIDEwLzEwIG9uIHRoZSB0b3AuDQoNCkJScw0KV2VudGFvIEd1YW4=



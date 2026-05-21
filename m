Return-Path: <stable+bounces-253594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EErNCqwtD2oiHgYAu9opvQ
	(envelope-from <stable+bounces-253594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:07:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB85A8E20
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5397D33C1E1B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C936F90B;
	Thu, 21 May 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ORgdaWlo"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288C367288;
	Thu, 21 May 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375835; cv=none; b=g1qFMUOSN1xOnzdbfqCoWr02j61ukGbzbsi5dVBAiIG2koUrNxpMOMctnktPms3t80E/mFMd2fkcHGq8J+5FvS8pZpjftp2PDut8pcJR2ERjf1e+QsxecqMubHyfxzHDms4y3MocRpTQuK5omkKGhwOpuymDvbLPpq00QM5XXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375835; c=relaxed/simple;
	bh=mtrJ2+QfzcBV2SCpOJKn0Clwg1mIA+jhMdK3YoUPH6k=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=jMdYNhhbbRsgOM6zauQRmdPjBP4nDlgM2/60t/hLQCYMWCl/wBxKINAv/eho5PWdXKM1zGZmSmg3OOz8cXEjZMs6RK3JojvustwSEbYl27wNQ2phCTAE3ZsIghLuCcfe+XcsuycDgL/l7GljhsxVvbxpaIuCf/Ag+Vn7f72rshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ORgdaWlo; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779375789;
	bh=mtrJ2+QfzcBV2SCpOJKn0Clwg1mIA+jhMdK3YoUPH6k=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=ORgdaWlo1AYq5jmO5B1ysGzXgHZvLjIcSj9Nt1VtE1QyMIrpdh/eRyqQf148ju8q/
	 3hGLGlaM8t/Q5ks1jelmZmHjEX2Vmz796zP8PaW2CcdH1WRn6k+e9XrXC/D1Z4QM4h
	 A7+sc8WLG0PzTOfy68R+0TuxGmloMH9l6+hR1DVE=
EX-QQ-RecipientCnt: 6
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-FEAT: D4aqtcRDiqQ2HEROFLO9v3DCQ3Sq6tnVe+sZ9ERKDec=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: eBBh0Dqc3GYlaVLVKiI9Nna+gXWQUqWNEIJg3aWdrpU=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1779375782ta795df72
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?b25ldWt1bQ==?=" <oneukum@suse.com>, "=?utf-8?B?Y2FydnNkcml2ZXI=?=" <carvsdriver@gmail.com>, "=?utf-8?B?bGludXgtdXNi?=" <linux-usb@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH RFC] USB: cdc-acm: Fix bit overlap and move quirk definitions to header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 21 May 2026 23:03:02 +0800
X-Priority: 3
Message-ID: <tencent_59BCDC255EB2B97F0CAB385D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260506093213.1473262-1-guanwentao@uniontech.com>
	<2026052144-unwritten-washing-df27@gregkh>
In-Reply-To: <2026052144-unwritten-washing-df27@gregkh>
X-QQ-ReplyHash: 1602198676
X-BIZMAIL-ID: 15815736409936065866
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 21 May 2026 23:03:03 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MyeHZuBXrvHmpxCL4pXmBFAxZBsEXrWoY//dII0HEb9ycqBF371PoILI
	TjfIe25CsOr3Xa/umt8xslSrN28xDH+IOyDJgPpoESqsYzwmZbh4mb4a/l/YQqqnokLvmDx
	sKIe2uTsojL6+WS7A0zmU4AF4rv+vwl+4881tjgo3Jp0eYMxkEWPv2utJuEu1iXakkNQK+o
	RA3GnO49W6CoeiIVeKW5h1smUpqO8A+plET/aAwzU9aALUUd0TfYa18+zrWiSeVKKezgFao
	sBwjdrroknouMR4+C83HMFrb+K7nFi+Oq8QZO6CzIOmcazZPnNyU2QyPf8yaNsqA9SzrXpO
	T4UgTI4ST24hMq8XRG1wIDWk0AKKi6j1/0s2YhPUpZwE8liqz8h/JQyBgpjlnX98GDhAr3+
	AhERs4e+O86i3CvvyuUqYwh255Az/jNJ76dUnMWu6QXPINZqP2bRyx1iRfNvS39aNnI/zot
	K4EK/Co1PySIe0BkQ/mjziSruPDI34lI45heBiSuRcGPKQ4rUqqAJO2Ypygpp1BFwmSmP20
	ZHxWl51idxfsF4YIS7WkX5SRWbGszVuQuCN9yDmWJ0gmX3ROvzAKkNCqP0uB6kDEACI0HSm
	0rjo9iWhRjBT9D5LJBN4TnH2CIN+jy9k4FAE8hr3G4VLUB0OZTcr7j04ECsypvEHcXiEU2X
	Lp/BsgosOfSIDINn5/IOEKJbCkyUy7MOm2GNnqJ6yRuSz7s8HW1wwS6ruJMKVhw5J3OVRvb
	edsLChEl7O2QMYfYe2KkNLXYLJnaAexYT4mToiv5ypEtosBZvnNOLVITeklW+foILGzjmtF
	Z7c0AGFNStokh/9FXN7aaf2MT57vMfZzU4mYmAf2frCSSg2DZyv/3gBsvbiuHeG5E3LFhNq
	h1M4Pah8xbcZk3vtCzGDbNGyREuAJzD0IRpywkgnffpm74luWH6z2e1iaCKptF7nKFtry+i
	Jl9xpN/SlCOdOLokG7/rDgVeN/aXqkJ+16D7vyUy39olqZ/QPOO46d4Cw9U61QB7nzjHFjv
	KVbHjIb+1LfTFMEPu0dJvRR1yfOKjpuOFVrO1T9T7QYa6wlfb8Lxg3R+sD/Po3oiKOdNIBv
	qyfYwU47RdlgPSL7XsYNX0=
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [2.44 / 15.00];
	CC_EXCESS_BASE64(1.50)[];
	TO_EXCESS_BASE64(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253594-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_EXCESS_BASE64(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5DEB85A8E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBXZWQsIE1heSAwNiwgMjAyNiBhdCAwNTozMjoxM1BNICswODAwLCBXZW50YW8gR3Vh
biB3cm90ZToNCj4gPiBUaGUgVkVORE9SX0NMQVNTX0RBVEFfSUZBQ0UgYW5kIEFMV0FZU19Q
T0xMX0NUUkwgcXVpcmsgZmxhZ3MgYWRkZWQgaW4NCj4gPiBjb21taXQgZjU4NzUyZWJjYjM1
ICgiVVNCOiBjZGMtYWNtOiBBZGQgcXVpcmtzIGZvciBZb2dhIEJvb2sgOSAxNElBSDEwDQo+
ID4gSU5HRU5JQyB0b3VjaHNjcmVlbiIpIHdlcmUgcGxhY2VkIGluc2lkZSB0aGUgYWNtX2N0
cmxfbXNnKCkgZnVuY3Rpb24NCj4gPiByYXRoZXIgdGhhbiBpbiB0aGUgaGVhZGVyIHdpdGgg
dGhlIG90aGVyIHF1aXJrIGZsYWdzLiAgVGhlbiwgdGhlaXINCj4gPiB2YWx1ZXMgKEJJVCg5
KSBhbmQgQklUKDEwKSkgY29sbGlkZWQgd2l0aCBOT19VTklPTl8xMiB3aGljaCBpcyBhbHJl
YWR5DQo+ID4gQklUKDkpLg0KPiA+DQo+ID4gTW92ZSB0aGUgZGVmaW5pdGlvbnMgdG8gZHJp
dmVycy91c2IvY2xhc3MvY2RjLWFjbS5oIHdoZXJlIHRoZXkgYmVsb25nDQo+ID4gYW5kIHNo
aWZ0IHRoZW0gdG8gQklUKDEwKSBhbmQgQklUKDExKSB0byBhdm9pZCB0aGUgb3ZlcmxhcC4N
Cj4gPg0KPiA+IEZpeGVzOiBmNTg3NTJlYmNiMzUgKCJVU0I6IGNkYy1hY206IEFkZCBxdWly
a3MgZm9yIFlvZ2EgQm9vayA5IDE0SUFIMTAgSU5HRU5JQyB0b3VjaHNjcmVlbiIpDQo+ID4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4NCj4gV2h5IGlzIHRoaXMgbmVlZGVkIGZv
ciBzdGFibGU/ICBXaGF0IGJ1ZyBkb2VzIHRoaXMgImZpeCI/DQpJIHNlZSB0aGF0IHRoZXJl
IGlzIGEgYnVnIHRoYXQgTk9fVU5JT05fMTIgYW5kIFZFTkRPUl9DTEFTU19EQVRBX0lGQUNF
IHVzZSBzYW1lIGJpdC4NCg0KQlJzDQpXZW50YW8gR3Vhbg==



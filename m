Return-Path: <stable+bounces-267479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zmnmNJZoNmp3/QYAu9opvQ
	(envelope-from <stable+bounces-267479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 12:16:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D56A8BA9
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 12:16:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=hEcr3ZnC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267479-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267479-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E23C30138B1
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F78327BFB;
	Sat, 20 Jun 2026 10:16:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com [101.71.155.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758C292B2E
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 10:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781950609; cv=none; b=qjoTMZVBxmtIK4hj1r1NjbfUk5huQtoBVpOEnZrTGHVmq3XflchxbR1LzhEIfnENywifdWqEoM19MSuCETU8/xuFXBr9jonuxg40zSsWBqEdlSLPAO3bmIRHUNbHUX7wLv6q0DBaqBMTeseLfIvvr3s9rI2b/AHvMdk45Zld7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781950609; c=relaxed/simple;
	bh=jKdUFOxSFfw2CIXMaNErLvEKlvwiKYMIWgbfx+3spL4=;
	h=Content-Type:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:From:Date; b=WJndtoKWHw5srr6ilBkYWnSzKVr0qh0yRRua/+gMpOYKaKh1UBkNDUINMbOgft/hneivwmUNwmtpApNXEhTLGQ1O+U3KfuPe4srvVMSjVFTtjrgZb82pmRBwvEXNoeYKE+/w9pkIT/bzpzbuOuyrlIqYGL0NpPw3SanR/fKQQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hEcr3ZnC; arc=none smtp.client-ip=101.71.155.67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AGUAvgD7KqAX5vkMllTuJarw.3.1781949676685.Hmail.220255722@seu.edu.cn>
To: David Laight  <david.laight.linux@gmail.com>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>, netdev <netdev@vger.kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Oleksandr Mazur <oleksandr.mazur@plvision.eu>, 
	Andrii Savka <andrii.savka@plvision.eu>, 
	Vadym Kochan <vadym.kochan@plvision.eu>, 
	Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>, stable <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBuZXRdIG5ldDogbWFydmVsbDogcHJlc3RlcmE6IHVzZSB1bmFsaWduZWQgYWNjZXNzb3JzIGZvciBEU0EgdGFn?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com Sirius_WEB_WIN_1.64.1
In-Reply-To: <20260620104750.5270a11c@pumpkin>
References: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn> <20260620104750.5270a11c@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 220255722@seu.edu.cn( [223.112.146.162] ) by ajax-webmail ( [127.0.0.1] ) ; Sat, 20 Jun 2026 18:01:16 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Sat, 20 Jun 2026 18:01:16 +0800 (GMT+08:00)
X-HM-Tid: 0a9ee4735fdd02f2kunm2404b49df170
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMTUS6Y2fHkyPT6dc03QDwVaZPGiA09TnwhbhTj
	hLfuFZO94YXwX6xgvkjGVFFRKj5HlnR/0mP2qfaD/1op6Ml5grsg0dkSS+RAAMENcdXCRYIETeNg
	LD+KDgT/C0CF3MmlBs8v3Zl6+ZI2MBtOc/JNE=
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEtCVhlMGENOSBhIS0tMHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVU
	pLSEpOT0xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hEcr3ZnCWF18P65lRyf9OSWyUuCoSmyqXFiwp1pxx+EupSiG9sOXBgQioecYRkVJx6uG6NixUbEPDBEPGO2RMWmK56NpELwr732CUCl8HxHECEiKQzRLCWt2NW7v4PPWh7xhcK4Tsq1HOkcbZnjBQKJMi9Z+WxQvfXnuYMIhtao=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=jKdUFOxSFfw2CIXMaNErLvEKlvwiKYMIWgbfx+3spL4=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:taras.chornyi@plvision.eu,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oleksandr.mazur@plvision.eu,m:andrii.savka@plvision.eu,m:vadym.kochan@plvision.eu,m:volodymyr.mytnyk@plvision.eu,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267479-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 260D56A8BA9

T24gU2F0LCAyMCBKdW4gMjAyNiAxNzo0Nzo1MCArMDgwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOgom
Z3Q7IFN0b3Agc2VuZGluZyB0aGVzZSAnZml4ZXMnIHVubGVzcyB5b3UgY2FuIGRvIHByb3BlciBh
bmFseXNpcy4KJmd0OyBza2IgZGF0YSBpcyBndWFyYW50ZWVkIHRvIGJlIGFsaWduZWQgc28gdGhh
dCB0aGVzZSByZWFkcyAoYW5kIG9uZXMgb2YKJmd0OyB0aGUgSVAvVENQL1VEUCBoZWFkZXJzKSBh
cmUgYWxpZ25lZC4KCllvdSBhcmUgcmlnaHQuIEkgdHJlYXRlZCB0aGUgRFNBIHRhZyBidWZmZXIg
YXMgYSBnZW5lcmljIGJ5dGUgYnVmZmVyIGFuZApkaWQgbm90IGFjY291bnQgZm9yIHRoZSBza2Ig
ZGF0YSBhbGlnbm1lbnQgZ3VhcmFudGVlcyBpbiB0aGlzIHBhdGguCgpQbGVhc2UgZHJvcCB0aGlz
IHBhdGNoLiBJIHdpbGwgcmUtY2hlY2sgdGhlIHJlbWFpbmluZyByZXBvcnRzIGFnYWluc3QKdGhl
IHJlbGV2YW50IHN1YnN5c3RlbSBhbGlnbm1lbnQgY29udHJhY3RzIGJlZm9yZSBzZW5kaW5nIGFu
eXRoaW5nIGVsc2UuCgpwdy1ib3Q6IGNoYW5nZXMtcmVxdWVzdGVkCgpUaGFua3MsClJ1bnl1


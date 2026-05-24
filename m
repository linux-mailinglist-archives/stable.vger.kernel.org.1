Return-Path: <stable+bounces-254040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN2wKoEdE2oE7wYAu9opvQ
	(envelope-from <stable+bounces-254040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A465C2FC9
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23BB230015B3
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF1305678;
	Sun, 24 May 2026 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cU2HgEdN"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D114C6C
	for <stable@vger.kernel.org>; Sun, 24 May 2026 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637625; cv=none; b=hwCU0SUW4E441bGnLc7HdPW7ppqP8lfcjaA5CaCAqWw4/6coewBnu5gVWzO2Q08nFG/5uy2KnkdMdBTOFwZiOYlh2RFVtV0iAOdIOhLvNKdK4pob0VHVsbou+A2A3IptWPsLKU1Fjs7WSL2W+xDjwrQ04sJS3hLvHwwtZiRswis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637625; c=relaxed/simple;
	bh=0yOhw0h4JuSeAmyQvlmS9GVBFu2A8Cfh5j5Roystqhk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=NpP4p+OuUl2ewBndSvmiiiUNOL3BvWbFIRAg0UNtuTBk1UNyYQh8X5xO2e0RUVoc7L7eS5HR6hYVMZeFOnLNLO3Y8i4h44IzVX/8hSbp+LsYE/2O1Yl3jBp8hm4RTf/b6vo3j3gMJui3mGsKJCT0lUVC0UfCEH7GR9hbdf0n8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cU2HgEdN; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779637540;
	bh=0yOhw0h4JuSeAmyQvlmS9GVBFu2A8Cfh5j5Roystqhk=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=cU2HgEdNwCse/8UhbGSkUu2WC6T4ZB4IRyr7gQUA4ydrMlVoMMKlpakJ/XjUxx6Y+
	 fZNlN50B7Xb3uhWgmXm9lX3pJDvMNwh4b/OE3p2OFrP6UJ07fzNYN+pCoRE2kv/U7T
	 0ff2I4lOtMGL5XBjUK8ve6/YzhHTcXkiCgnAF6BU=
EX-QQ-RecipientCnt: 5
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqTsBAZj3BNqi+E7MGSirmitosRUhGyHACY=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: FP/OuB1dvl4iTlQ+qad7Z1djwjbMNXkO7f25do2hvw4EjNKpKtYU4WtrQq0DYEkfsrIdKaCXl0ePkY4UlA1A+A==
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1779637534td4f6fe3a
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?QmVuIEh1dGNoaW5ncw==?=" <benh@debian.org>, "=?utf-8?B?R3JlZyBLSA==?=" <gregkh@linuxfoundation.org>
Cc: "=?utf-8?B?aW12NGJlbA==?=" <imv4bel@gmail.com>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6] net: skbuff: propagate shared-frag marker through frag-transfer helpers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sun, 24 May 2026 23:45:33 +0800
X-Priority: 3
Message-ID: <tencent_17B7D10213AC0C5446E7E248@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <ahFmF_XkUzOHBMnC@decadent.org.uk>
	<20260523161843.1413146-1-guanwentao@uniontech.com>
	<f3814b420017094d314e76306cc433202b97865c.camel@debian.org>
In-Reply-To: <f3814b420017094d314e76306cc433202b97865c.camel@debian.org>
X-QQ-ReplyHash: 418521804
X-BIZMAIL-ID: 12605047168225204416
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sun, 24 May 2026 23:45:35 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MVxUJtUPrfeCZDY7vCwlgkc6RE2+JqhSW//AlEtsanYfrn4YZIgg7nVK
	A7L71+hboo53+4pRy/as9R/bU8gLCmmEgd93EENCZIgr5jXxOfoH0mazJuIUuvgLWQIRzKW
	lSFJT11t7b0AYe9Fnxpc72K9BtOEns7RKXwwIlf5yF3rBagv/iiK/Jqgr8SSF8xOFmOuOLA
	K9WYoHfWVCMT3XxD5R1GdpuKAxlSARhD4R/6PH1/cQokYdhkGnpahVO823cSa7anPaTCHsm
	BivyAwqH3A+gVcaR044PbYxYa8TqHepz1S+QhRvVrcILEpZGk/9rbVZxYG1kg5PtUq7zs0G
	vSAYK7LPtb3ap9s4Hmf7uPKK3DMJXNa+U6rnKbHIyIaWOR9AzNkRqA2+8dbV2jcfqT6qUzZ
	R1yqHEycT+HhCZ/e0IgNbGPlrtz0CA3AvBCzqIUTUgEUCLaj5D342OKFjHktp57e+s2zx+5
	uPATgjD9C3fMzDSIvESkWbbSQjL7NPQlB3MPSEpHxh+7b/cRjtIGFYGeToE3yeSVntGepgy
	+Yc7cK2oUeTifJXvPuAgUdUcRcDrh1gSoGPUBYMNxMOUcl5J38PkRWWdGMV+YTTRsjWSkgq
	TapXaJyUKHUy2/zKIn/1xqQ2MngVuGyuBErUffcNDhrFfoLwbtMJXs2NagFUefgthXdgsmv
	PxbKeBwiiIyKvoIxKSnfyWjDzeiE5EoP2KZUSWIqJp74+Cn0Z1/YnQWMGHIWwj/ZM+mZEwg
	Rv2AoCHD6FeBhvk28eSAUoIcjjcu5Vqr7JFh1u3MU3B8TqAbUCnQ6AeWsuydJFvDHE1BSw1
	GbffRLILcjEy5e2gaXxwV64omlkECFQGEaf7qc42f6ysVnHeKd3iuUIyfeDwsyAo470ZkPZ
	IGVQLg6q4CHGFwd+x02DELz870iRb7ou1CUAVy+F/OywGOCsw/GhpfiW4E1ZimyIzemOdxQ
	F1N+TDh7Ti+CQFW+AiiAJgDIa2zgMx8A4AvENQoVOskT3pKnNY+4L9edKnnLwJ3Smg1dom/
	1WYWoyDeKJfSjSs9NdourftPeqCRdWburoOIVnY23lWb0F+82Clnyfp1HXmEw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [2.44 / 15.00];
	TO_EXCESS_BASE64(1.50)[];
	CC_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-254040-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	FROM_EXCESS_BASE64(0.00)[];
	NEURAL_SPAM(0.00)[0.394];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,uniontech.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A2A465C2FC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBTdW4sIDIwMjYtMDUtMjQgYXQgMDA6MTggKzA4MDAsIFdlbnRhbyBHdWFuIHdyb3Rl
Og0KPiA+IEhlbGxvLA0KPiA+DQo+ID4gV2h5IG5vdCBhcHBseQ0KPiA+IGNvbW1pdCA4OTI4
NzU2ZDUzZDUgKCJuZXQ6IG1vdmUgc2tiX2dyb19yZWNlaXZlX2xpc3QgZnJvbSB1ZHAgdG8g
Y29yZSIpLCBzbw0KPiA+IGNvbW1pdCA0OGY2YTUzNTZhMzMgKCJuZXQ6IHNrYnVmZjogcHJv
cGFnYXRlIHNoYXJlZC1mcmFnIG1hcmtlciB0aHJvdWdoIGZyYWctdHJhbnNmZXIgaGVscGVy
cyIpDQo+ID4gd2lsbCBjbGVhbiBhcHBseSBpbnN0ZWFkIG9mIGNoYW5nZSBpdC4NCj4gDQo+
IE9oLCB5ZXMgdGhhdCBhbHNvIHdvcmtzLiAgSSBkaWRuJ3Qgbm90aWNlIHRoYXQgdGhlIGZp
cnN0IGNvbW1pdCB3b3VsZA0KPiBhcHBseSBjbGVhbmx5IGhlcmUuDQoNCkkgZm9yZ290IGNj
IHN0YWJsZSBtYWlsbGlzdCB3aGVuIGNvcHkgbWFpbCBhZGRyZXNzLCBsZXQgbWUgY2Mgbm93
Lg0KDQpCUnMNCldlbnRhbyBHdWFu



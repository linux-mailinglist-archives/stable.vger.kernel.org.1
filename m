Return-Path: <stable+bounces-230595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJLNIx04xmm7HgUAu9opvQ
	(envelope-from <stable+bounces-230595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:56:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB3340A85
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41C42300D6B4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B73C7DE8;
	Fri, 27 Mar 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="I3SwD6rH"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A23BE62B
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774598080; cv=none; b=oYMWk0d9sD8jqRmkkM/zrmVTGtGZ5YYIoyxPvR2DsknWXXekOPYO6JgARUVY2JGxxD9NuWjeNPlCyPz7FkldicrvR03eHJesbqvDdiBA3JMqloNN9qPFliFJYSHqDfV3Op8pvUM81K33U3gzsCNLA0fXaeRbDzzKFhDljhfZ/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774598080; c=relaxed/simple;
	bh=QKoij/UHiladQPESXJyemd48Dww0EegD39OySnyWzpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALbWFAaFsMqDINgTxsBQG2vEPi0//3dImmgLdMCi58ZZ+5ZrwpcB85PKmsBq8H3tcH4ljPqLZZtdB/GiuxKPQHs6YUeQObbld1mdmEX6cOnrEHmynDcxqgXzHW6i7KtOJOuyFyTRX8Zve7gtTMjGGMYzAVA+6cibJaga8PhtlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=I3SwD6rH; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202603270744191895210ef30002076e
        for <stable@vger.kernel.org>;
        Fri, 27 Mar 2026 08:44:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QKoij/UHiladQPESXJyemd48Dww0EegD39OySnyWzpY=;
 b=I3SwD6rHZcWkmTh/XeYhjtnf9b8O6+K0tlI5sBGHYfv+TiUM8Z/cuyl94x+K9J1K2fV7EL
 A/qIJevINCZsStACtlFP6Ukk6w2pTfcenmTuvKmgs+31eP7BpDRbwVhkp40TiDmJf2nBidhb
 fgqdNVNjZOdQbC/LzwYDcTrAMO1WMt1U/vX8Ncu9nSD+tzIwTruxmw88g1qiHgAXiwoWUJ8H
 OGHrnl8Zq1ksiauMoNLTffqw60omF4AP8EBCQqJNaHpvevRElG9T03x0JqnAUk3V7mRUUe9L
 BcF/M50rkHgk0rnRCHPodiMuQ7O8erpTcTFg5Be40VX+MaOxjOIeTfNg==;
Message-ID: <480f889c1744132f39983178fbad90ad11e081ed.camel@siemens.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes =?ISO-8859-1?Q?~50=B5s?= noise spikes on isolated PREEMPT_RT cores
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Crystal Wood <crwood@redhat.com>, "Ionut Nechita (Wind River)"
	 <ionut.nechita@windriver.com>, namcao@linutronix.de, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, frederic@kernel.org, 
	vschneid@redhat.com, gregkh@linuxfoundation.org,
 chris.friesen@windriver.com, 	viorel-catalin.rapiteanu@windriver.com,
 iulian.mocanu@windriver.com, 	jan.kiszka@siemens.com
Date: Fri, 27 Mar 2026 08:44:18 +0100
In-Reply-To: <af22ac4288e36ff879fa8993790c11973f6af45d.camel@redhat.com>
References: <20260326140058.272854-1-ionut.nechita@windriver.com>
	 <af22ac4288e36ff879fa8993790c11973f6af45d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230595-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:dkim,siemens.com:mid]
X-Rspamd-Queue-Id: EFBB3340A85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTI2IGF0IDEzOjEyIC0wNTAwLCBDcnlzdGFsIFdvb2Qgd3JvdGU6Cj4g
T24gVGh1LCAyMDI2LTAzLTI2IGF0IDE2OjAwICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToKPiA+IEhpLAo+ID4gCj4gPiBJJ20gcmVwb3J0aW5nIGEgcmVncmVzc2lvbiBp
bnRyb2R1Y2VkIGJ5IGNvbW1pdCAwYzQzMDk0ZjhjYzkKPiA+ICgiZXZlbnRwb2xsOiBSZXBsYWNl
IHJ3bG9jayB3aXRoIHNwaW5sb2NrIiksIGJhY2twb3J0ZWQgdG8gc3RhYmxlIDYuMTIueS4KPiA+
IAo+ID4gT24gYSBQUkVFTVBUX1JUIHN5c3RlbSB3aXRoIG5vaHpfZnVsbCBpc29sYXRlZCBjb3Jl
cywgdGhpcyBjb21taXQgY2F1c2VzCj4gPiBzaWduaWZpY2FudCBvc25vaXNlIGRlZ3JhZGF0aW9u
IG9uIHRoZSBpc29sYXRlZCBDUFVzLgo+ID4gCj4gPiBTZXR1cDoKPiA+IMKgwqAgLSBLZXJuZWw6
IDYuMTIuNzggd2l0aCBQUkVFTVBUX1JUCj4gPiDCoMKgIC0gSGFyZHdhcmU6IHg4Nl82NCwgZHVh
bC1zb2NrZXQgKENQVXMgMC02MykKPiA+IMKgwqAgLSBCb290IHBhcmFtczogbm9oel9mdWxsPTEt
MTYsMzMtNDggaXNvbGNwdXM9bm9oeixkb21haW4sbWFuYWdlZF9pcnEsMS0xNiwzMy00OAo+ID4g
wqDCoMKgwqAgcmN1X25vY2JzPTEtMzEsMzMtNjMga3RocmVhZF9jcHVzPTAsMzIgaXJxYWZmaW5p
dHk9MTctMzEsNDktNjMKPiA+IMKgwqAgLSBUb29sOiBvc25vaXNlIHRyYWNlciAoLi9vc25vaXNl
IC1jIDEtMTYsMzMtNDgpCj4gCj4gSXMgU01UIGRpc2FibGVkPwo+IAo+IAo+ID4gV2l0aCBjb21t
aXQgYXBwbGllZCAoc3BpbmxvY2ssIGtlcm5lbCA2LjEyLjc4LXZhbmlsbGEtMCk6Cj4gPiAKPiA+
IMKgwqAgQ1BVwqDCoMKgIFJVTlRJTUXCoMKgIE1BWF9OT0lTRcKgwqAgQVZBSUwlwqDCoMKgwqDC
oCBOT0lTRcKgIE5NScKgwqAgSVJRwqDCoCBTSVJRwqAgVGhyZWFkCj4gPiDCoMKgIFswMDFdwqDC
oCA5NTAwMDDCoMKgwqDCoMKgwqAgNTAxNjPCoMKgIDk0LjcxOSXCoMKgwqDCoMKgwqDCoCAxNMKg
wqDCoCAwwqDCoCA2ODY0wqDCoMKgwqAgMMKgwqDCoCA1OTIyCj4gPiDCoMKgIFswMDRdwqDCoCA5
NTAwMDDCoMKgwqDCoMKgwqAgNTAyOTTCoMKgIDk0LjcwNSXCoMKgwqDCoMKgwqDCoCAxNMKgwqDC
oCAwwqDCoCA2ODY0wqDCoMKgwqAgMMKgwqDCoCA1OTIwCj4gPiDCoMKgIFswMDddwqDCoCA5NTAw
MDDCoMKgwqDCoMKgwqAgNDk3ODLCoMKgIDk0Ljc1OSXCoMKgwqDCoMKgwqDCoCAxNMKgwqDCoCAw
wqDCoCA2ODY0wqDCoMKgwqAgMcKgwqDCoCA1OTIxCj4gPiDCoMKgIFswMzNdwqDCoCA5NTAwMDDC
oMKgwqDCoMKgwqAgNDk1MjjCoMKgIDk0Ljc4NiXCoMKgwqDCoMKgwqDCoCAxNcKgwqDCoCAwwqDC
oCA2ODY0wqDCoMKgwqAgMsKgwqDCoCA1OTIyCj4gPiDCoMKgIFswMTZdwqDCoCA5NTAwMDDCoMKg
wqDCoMKgwqAgNDg1NTHCoMKgIDk0Ljg4OSXCoMKgwqDCoMKgwqDCoCAyMMKgwqDCoCAwwqDCoCA2
ODYzwqDCoMKgIDE5wqDCoMKgIDU5NDIKPiA+IMKgwqAgWzAwOF3CoMKgIDk1MDAwMMKgwqDCoMKg
wqDCoCA0NDM0M8KgwqAgOTUuMzMyJcKgwqDCoMKgwqDCoMKgIDE0wqDCoMKgIDDCoMKgIDY4NjTC
oMKgwqDCoCAwwqDCoMKgIDU5MjUKPiA+IAo+ID4gV2l0aCBjb21taXQgcmV2ZXJ0ZWQgKHJ3bG9j
ayByZXN0b3JlZCwga2VybmVsIDYuMTIuNzgtdmFuaWxsYS0xKToKPiA+IAo+ID4gwqDCoCBDUFXC
oMKgwqAgUlVOVElNRcKgwqAgTUFYX05PSVNFwqDCoCBBVkFJTCXCoMKgwqDCoMKgIE5PSVNFwqAg
Tk1JwqDCoCBJUlHCoMKgIFNJUlHCoCBUaHJlYWQKPiA+IMKgwqAgWzAwMV3CoMKgIDk1MDAwMMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgIDEwMC4wMDAlwqDCoMKgwqDCoMKgIDDCoMKgwqAgMMKg
wqDCoMKgwqAgNsKgwqDCoMKgIDDCoMKgwqDCoMKgwqAgMAo+ID4gwqDCoCBbMDA0XcKgwqAgOTUw
MDAwwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqAgMTAwLjAwMCXCoMKgwqDCoMKgwqAgMMKgwqDC
oCAwwqDCoMKgwqDCoCA0wqDCoMKgwqAgMMKgwqDCoMKgwqDCoCAwCj4gPiDCoMKgIFswMDddwqDC
oCA5NTAwMDDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoCAxMDAuMDAwJcKgwqDCoMKgwqDCoCAw
wqDCoMKgIDDCoMKgwqDCoMKgIDTCoMKgwqDCoCAwwqDCoMKgwqDCoMKgIDAKPiA+IMKgwqAgWzAz
M13CoMKgIDk1MDAwMMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgIDEwMC4wMDAlwqDCoMKgwqDC
oMKgIDDCoMKgwqAgMMKgwqDCoMKgwqAgNMKgwqDCoMKgIDDCoMKgwqDCoMKgwqAgMAo+ID4gwqDC
oCBbMDE2XcKgwqAgOTUwMDAwwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqAgMTAwLjAwMCXCoMKg
wqDCoMKgwqAgMMKgwqDCoCAwwqDCoMKgwqDCoCA1wqDCoMKgwqAgMMKgwqDCoMKgwqDCoCAwCj4g
PiDCoMKgIFswMDhdwqDCoCA5NTAwMDDCoMKgwqDCoMKgwqDCoMKgwqDCoCA3wqDCoMKgIDk5Ljk5
OSXCoMKgwqDCoMKgwqAgN8KgwqDCoCAwwqDCoMKgwqDCoCA1wqDCoMKgwqAgMMKgwqDCoMKgwqDC
oCAwCj4gPiAKPiA+IFN1bW1hcnkgYWNyb3NzIGFsbCBpc29sYXRlZCBjb3JlcyAoMzIgQ1BVcyk6
Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgV2l0aCBzcGlubG9ja8KgwqDCoMKgwqDCoCBXaXRoIHJ3bG9jayAocmV2ZXJ0ZWQpCj4g
PiDCoMKgIE1BWCBub2lzZSAobnMpOsKgwqDCoMKgwqDCoMKgwqAgNDQsMzQzIC0gNTEsODY5wqDC
oMKgwqAgMCAtIDEwCj4gPiDCoMKgIElSUSBjb3VudC9zYW1wbGU6wqDCoMKgwqDCoMKgIH42LDY1
MCAtIDYsODcwwqDCoMKgwqDCoCAzIC0gNwo+ID4gwqDCoCBUaHJlYWQgbm9pc2Uvc2FtcGxlOsKg
wqDCoCB+NSw3MDAgLSA1LDk0MMKgwqDCoMKgwqAgMCAtIDEKPiA+IMKgwqAgQ1BVIGF2YWlsYWJp
bGl0eTrCoMKgwqDCoMKgwqAgOTQuNSUgLSA5NS4zJcKgwqDCoMKgwqDCoCB+MTAwJQo+ID4gCj4g
PiBUaGUgcmVncmVzc2lvbiBpcyByb3VnaGx5IDMgb3JkZXJzIG9mIG1hZ25pdHVkZSBpbiBub2lz
ZSBvbiBpc29sYXRlZAo+ID4gY29yZXMuIFRoZSB0ZXN0IHdhcyBydW4gb3ZlciBtYW55IGNvbnNl
Y3V0aXZlIHNhbXBsZXMgYW5kIHRoZSBwYXR0ZXJuCj4gPiBpcyBjb25zaXN0ZW50OiB3aXRoIHRo
ZSBzcGlubG9jaywgZXZlcnkgaXNvbGF0ZWQgY29yZSBzZWVzIHRob3VzYW5kcwo+ID4gb2YgSVJR
cyBhbmQgfjUwwrVzIG9mIG5vaXNlIHBlciA5NTBtcyBzYW1wbGUgd2luZG93LiBXaXRoIHRoZSBy
d2xvY2ssCj4gPiB0aGUgY29yZXMgYXJlIGVzc2VudGlhbGx5IHNpbGVudC4KPiA+IAo+ID4gTm90
ZSB0aGF0IENQVSAwMTYgb2NjYXNpb25hbGx5IHNob3dzIFNJUlEgbm9pc2UgKHNvZnRpcnEpIHdp
dGggYm90aAo+ID4ga2VybmVscywgd2hpY2ggaXMgYSBzZXBhcmF0ZSBrbm93biBpc3N1ZSB3aXRo
IHRoZSB0aWNrIG9uIHRoZSBmaXJzdAo+ID4gbm9oel9mdWxsIENQVS4gVGhlIGV2ZW50cG9sbCBy
ZWdyZXNzaW9uIGlzIHRoZSBkb21pbmFudCBub2lzZSBzb3VyY2UuCj4gPiAKPiA+IE15IHVuZGVy
c3RhbmRpbmcgb2YgdGhlIHJvb3QgY2F1c2U6IHRoZSBvcmlnaW5hbCByd2xvY2sgYWxsb3dlZAo+
ID4gZXBfcG9sbF9jYWxsYmFjaygpIChwcm9kdWNlciBzaWRlLCBydW5uaW5nIGZyb20gSVJRIGNv
bnRleHQgb24gYW55IENQVSkKPiA+IHRvIHVzZSByZWFkX2xvY2ssIHdoaWNoIGRvZXMgbm90IGNh
dXNlIGNyb3NzLUNQVSBjb250ZW50aW9uIG9uIGlzb2xhdGVkCj4gPiBjb3JlcyB3aGVuIG5vIGxv
Y2FsIGVwb2xsIGFjdGl2aXR5IGV4aXN0cy4gV2l0aCB0aGUgc3BpbmxvY2sgY29udmVyc2lvbiwK
PiA+IG9uIFBSRUVNUFRfUlQgc3BpbmxvY2tfdCBiZWNvbWVzIGFuIHJ0X211dGV4LiBUaGlzIG1l
YW5zIHRoYXQgZXZlbiBpZgo+ID4gdGhlIGlzb2xhdGVkIGNvcmUgaXMgbm90IGludm9sdmVkIGlu
IGFueSBlcG9sbCBhY3Rpdml0eSwgdGhlIGxvY2sncwo+ID4gY2FjaGVsaW5lIGJvdW5jaW5nIGFu
ZCBwb3RlbnRpYWwgUEktYm9vc3RlZCB3YWtldXBzIGZyb20gaG91c2VrZWVwaW5nCj4gPiBDUFVz
IGNhbiBpbmplY3Qgbm9pc2UgaW50byB0aGUgaXNvbGF0ZWQgY29yZXMgdmlhIElQSSBvciBjYWNo
ZQo+ID4gaW52YWxpZGF0aW9uIHRyYWZmaWMuCj4gCj4gVGhhdCBzb3VuZHMgbGlrZSBhIGdlbmVy
YWwgaXNvbGF0aW9uIHByb2JsZW0uLi4gaXQncyBub3QgYSBidWcgZm9yIG5vbi0KPiBpc29sYXRl
ZCBDUFVzIHRvIGJvdW5jZSBjYWNoZWxpbmVzIG9yIHNlbmQgSVBJcyB0byBlYWNoIG90aGVyLgo+
IAo+IFdoZXRoZXIgaXQncyBJUElzIG9yIG5vdCwgb3Nub2lzZSBpcyBzaG93aW5nIElSUXMgb24g
dGhlIGlzb2xhdGVkIENQVXMsCj4gc28gSSdkIGxvb2sgaW50byB3aGljaCBJUlFzIGFuZCB3aHku
wqAgRXZlbiB3aXRoIHRoZSBwYXRjaCByZXZlcnRlZCwKPiB0aGVyZSBhcmUgc29tZSBJUlFzIG9u
IHRoZSBpc29sYXRlZCBDUFVzLgo+IAo+ID4gCj4gPiBUaGUgY29tbWl0IG1lc3NhZ2UgYWNrbm93
bGVkZ2VzIHRoZSB0aHJvdWdocHV0IHJlZ3Jlc3Npb24gYnV0IGFyZ3Vlcwo+ID4gcmVhbCB3b3Jr
bG9hZHMgd29uJ3Qgbm90aWNlLiBIb3dldmVyLCBmb3IgUlQvbGF0ZW5jeS1zZW5zaXRpdmUKPiA+
IGRlcGxveW1lbnRzIHdpdGggQ1BVIGlzb2xhdGlvbiwgdGhlIGltcGFjdCBpcyBzZXZlcmUgYW5k
IG1lYXN1cmFibGUKPiA+IGV2ZW4gd2l0aCB6ZXJvIGxvY2FsIGVwb2xsIHVzYWdlLgo+ID4gCj4g
PiBJIGJlbGlldmUgdGhpcyBuZWVkcyBlaXRoZXI6Cj4gPiDCoMKgIGEpIEEgcmV2ZXJ0IG9mIHRo
ZSBiYWNrcG9ydCBmb3Igc3RhYmxlIFJUIHRyZWVzLCBvcgo+IAo+IEV2ZW4gaWYgdGhlIHBhdGNo
IHdlcmVuJ3QgdHJ5aW5nIHRvIGFkZHJlc3MgYW4gUlQgaXNzdWUgaW4gdGhlIGZpcnN0Cj4gcGxh
Y2UsIHRoaXMgd291bGQganVzdCBiZSBhIGJhbmRhaWQgcmF0aGVyIHRoYW4gYSByZWFsIHNvbHV0
aW9uLgoKQSByZXZlcnQgYWxvbmUgaXMgbm90IGFuIG9wdGlvbiBhcyBpdCB3b3VsZCBicmluZyBi
YWNrIFsxXSBhbmQgWzJdIGZvcgphbGwgTFRTIHJlbGVhc2VzIHRoYXQgZGlkIG5vdCByZWNlaXZl
IFszXS4gSWYgbXkgbWVtb3J5IGlzIGNvcnJlY3Qgb25seQo2LjE4IGhhcyBpdC4KClRoZSByZXN1
bHQgd2FzIGEgc3lzdGVtIGxvY2t1cCBlYXNpbHkgdHJpZ2dlcmVkIGJ5IHVzaW5nIHRoZSBlcG9s
bAppbnRlcmZhY2UuCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcnQtdXNlcnMv
MjAyMTA4MjUxMzI3NTQuR0E4OTU2NzVAbG90aHJpbmdlbi8KWzJdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LXJ0LXVzZXJzL3hoc21odHRxdm5hbGwubW9nbmV0QHZzY2huZWlkLnJlbW90
ZS5jc2IvClszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA4MjkwODExMjAuODA2
LTEtemlxaWFubHVAYnl0ZWRhbmNlLmNvbS8KCgpGbG9yaWFuCg==



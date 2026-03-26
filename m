Return-Path: <stable+bounces-230409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNDwDjGVxGnH0gQAu9opvQ
	(envelope-from <stable+bounces-230409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:08:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9770B32E3AB
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 03:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5B603096D67
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B574926A1AF;
	Thu, 26 Mar 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vONfgzRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774541FD4;
	Thu, 26 Mar 2026 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490761; cv=none; b=bpvxE+fw6vw3HuCvmGwhmUpPwT2SsA1qfXVcZX7bpLD+KGBGswy9ThZmTsSZ0WZyos1WDq6aDSk/nRI0tuBoS4LgcoH/QhKGNsW1rB5R7+FpAfXfHXm/spd70QW8bv5A0WFBKJPFQX4+1yE+fE7Ih37hy0AlwqGrQhmMQiDLL20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490761; c=relaxed/simple;
	bh=djRFWfCMMNrOx6Y0jvpNZi/HPTTP3rQYbvySdlEuahc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=La6/iRgxZfVFDyqfhs409U1/kFH9yDzk/TtU4EfPftboqocEJHo+j1hFc6K0Aljw7rd11xahZpdBCcOceFQma4LWyrd53+D+JFy02+WIliAv0ftGxswLY0oIUSECCOMqZ2QzeRbAIaKa0BgFT4Ex+Brwujjyghqjqpf9dVkXtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vONfgzRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22DCC4CEF7;
	Thu, 26 Mar 2026 02:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774490761;
	bh=djRFWfCMMNrOx6Y0jvpNZi/HPTTP3rQYbvySdlEuahc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vONfgzRZLoQ3qug8Mg+U1M+IkI9xjG2BWZFe1XOwfv/P4Sb94Ry1qtoiSTtzlOfpN
	 1Wo7Eri7ehyC7KQQDxUK9J1muoJMa9VbkDfLaQgae1DGQE/AOHu5vXKtiRAx6Ml5sv
	 x83QHyx4t2jFuZ2z7Rgn6NbOQMF3EbeWNFhYvp+sbVmi8bEtzUvWzF2T+RZyVsQNbP
	 PN9T8UI3PifBZxjkcYOKO5ouwequWmQXPuXWJu/foisjQx8ulJ5sKjr3byXdsIS64w
	 S17+M5obihuY4js93eImcWtnhkAiUh0PEoe9ukFGS3uZ2Hpln44tOLMkhnD3mNuTVd
	 pt2ZMr/VxRkNA==
Message-ID: <156c7e58-df60-44ca-8c26-78ccab2c1647@kernel.org>
Date: Wed, 25 Mar 2026 21:05:59 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18.19 -- amdgpu bug and a new warning
To: Cal Peake <cp@absolutedigital.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
 jslaby@suse.cz, Alex Deucher <alexander.deucher@amd.com>
References: <2026031914-send-embezzle-1648@gregkh>
 <1df33732-8d66-d669-84a8-259f1b7f3278@absolutedigital.net>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <1df33732-8d66-d669-84a8-259f1b7f3278@absolutedigital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230409-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bind-device.sh:url]
X-Rspamd-Queue-Id: 9770B32E3AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCk9uIDMvMjUvMjYgMTg6MjMsIENhbCBQZWFrZSB3cm90ZToNCj4gW1NvbWUgcGVvcGxl
IHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20g
Y3BAYWJzb2x1dGVkaWdpdGFsLm5ldC4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0
IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0K
PiBIaSwNCj4gDQo+IEEgY29tbWl0IGluIDYuMTguMTkgaGFzIGludHJvZHVjZWQgYSBidWcg
YW5kIGEgbmV3IHdhcm5pbmcgd2hlbiBkb2luZw0KPiBhbWRncHUgZHJpdmVyIHJlLWJpbmRp
bmcuIEluIGFkZGl0aW9uIHRvIHRoZSBidWcsIHRoZSBsYXN0IGxpbmUgb2YgdGhlDQo+IG91
dHB1dCBiZWxvdyBpcyBhIG5ldyB3YXJuaW5nIHJlOiB0aGUgdGhlcm1hbCBhbGVydA0KPiAN
Cj4gVGhpcyBidWcgZG9lc24ndCBzZWVtIHRvIGNhdXNlIGFueSBzaG93LXN0b3BwaW5nIHBy
b2JsZW1zLCBidXQgaXQgaXMgYSBidWcNCj4gYW5kIGl0IHBlcnNpc3RzIGludG8gNi4xOC4y
MC4NCj4gDQo+IEkgY2FuIGRvIGEgYmlzZWN0IGlmIG5lZWRlZCwgYnV0IEknbSBob3Bpbmcg
b25lIG9mIG91ciBBTUQgZ3V5cyBjYW4gbW9yZQ0KPiBxdWlja2x5IHNwb3Qgd2hhdCdzIGdv
aW5nIG9uIDopDQoNCkFyZSB5b3Ugc2F5aW5nIGl0IGlzIGZyb20gNi4xOC4xOCB0byA2LjE4
LjE5IGl0IHdhcyBpbnRyb2R1Y2VkPyAgTm90aGluZyANCmltbWVkaWF0ZWx5IGp1bXBzIG91
dCB0byBtZS4gIFNvIEkgd291bGQgc2F5IGJpc2VjdCBwbGVhc2UuDQoNCj4gDQo+IA0KPiAg
ICBhbWRncHUgMDAwMDoxNDowMC4wOiBhbWRncHU6IGFtZGdwdTogZmluaXNoaW5nIGRldmlj
ZS4NCj4gICAgLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ICAgIFdB
Uk5JTkc6IENQVTogMSBQSUQ6IDI3NzMgYXQgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2lycS5jOjYzOSBhbWRncHVfaXJxX3B1dCsweGE0LzB4YzAgW2FtZGdwdV0NCj4g
ICAgTW9kdWxlcyBsaW5rZWQgaW46IGlwdGFibGVfbmF0IG5mX25hdCBpcHRfUkVKRUNUIG5m
X3JlamVjdF9pcHY0IHh0X211bHRpcG9ydCB4dF9MT0cgbmZfbG9nX3N5c2xvZyB4dF9zdGF0
ZSB4dF9jb25udHJhY2sgbmZfY29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2IG5mX2RlZnJhZ19p
cHY0IHh0X3RjcHVkcCBpcHRhYmxlX2ZpbHRlciBpcF90YWJsZXMgeF90YWJsZXMgYnJpZGdl
IHN0cCBsbGMgaXB2NiBuY3Q2Nzc1IHR1biBzZyBwY3Nwa3IgbmN0Njc3NV9jb3JlIG5jdDY2
ODMgaHdtb25fdmlkIGVkYWNfbWNlX2FtZCB1YXMgdXNiX3N0b3JhZ2Ugb25ib2FyZF91c2Jf
ZGV2IGpveWRldiBoaWRfZ2VuZXJpYyB1c2JoaWQgaGlkIGFtZGdwdSB0cG1fY3JiIGFtZHhj
cCBkcm1fcGFuZWxfYmFja2xpZ2h0X3F1aXJrcyBncHVfc2NoZWQgZHJtX2J1ZGR5IGRybV90
dG1faGVscGVyIHNuZF9oZGFfY29kZWNfYWxjODgyIHNuZF9oZGFfY29kZWNfcmVhbHRla19s
aWIgdHRtIGRybV9leGVjIGludGVsX3JhcGxfbXNyIGFtZF9hdGwgc25kX2hkYV9jb2RlY19n
ZW5lcmljIGRybV9zdWJhbGxvY19oZWxwZXIgZHJtX2NsaWVudF9saWIgaW50ZWxfcmFwbF9j
b21tb24gc25kX2hkYV9jb2RlY19hdGloZG1pIHNuZF9oZGFfY29kZWNfaGRtaSBkcm1fZGlz
cGxheV9oZWxwZXIgY2VjIHNuZF9oZGFfaW50ZWwgcmNfY29yZSBzbmRfaGRhX2NvZGVjIGt2
bV9hbWQgc25kX2hkYV9jb3JlIGRybV9rbXNfaGVscGVyIGVlMTAwNCB3bWlfYm1vZiByODE2
OSBzbmRfaW50ZWxfZHNwY2ZnIHJlYWx0ZWsgc25kX2ludGVsX3Nkd19hY3BpIG1kaW9fZGV2
cmVzIGt2bSBzbmRfaHdkZXAgZHJtIG9mX21kaW8gc25kX3BjbSBhZ3BnYXJ0IHBvbHl2YWxf
Y2xtdWxuaSBpMmNfZGVzaWdud2FyZV9wY2kgZml4ZWRfcGh5IGdoYXNoX2NsbXVsbmlfaW50
ZWwgc25kX3RpbWVyIGkyY19hbGdvX2JpdCBpMmNfcGlpeDQgZndub2RlX21kaW8gaTJjX2Rl
c2lnbndhcmVfY29yZSByYXBsIQ0KPiAgICB2aWRlbyBpMmNfc21idXMgaTJjX2NjZ3hfdWNz
aSBzbmQNCj4gICAgIGxpYnBoeSB4aGNpX3BjaSBtZmRfY29yZSBzb3VuZGNvcmUgY2NwIGsx
MHRlbXAgaTJjX2NvcmUgbWRpb19idXMgaWdjIHhoY2lfaGNkIHdtaSBncGlvX2FtZHB0IHRw
bV90aXMgZ3Bpb19nZW5lcmljIHRwbV90aXNfY29yZSBldmRldiBsb29wIGRtX3NuYXBzaG90
IGRtX2J1ZmlvIHZmaW9fcGNpIHZmaW9fcGNpX2NvcmUgdmZpb19pb21tdV90eXBlMSB2Zmlv
IGlvbW11ZmQgaXJxYnlwYXNzDQo+ICAgIENQVTogMSBVSUQ6IDAgUElEOiAyNzczIENvbW06
IGJpbmQtZGV2aWNlLnNoIE5vdCB0YWludGVkIDYuMTguMjAgIzEgUFJFRU1QVChsYXp5KQ0K
PiAgICBIYXJkd2FyZSBuYW1lOiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uIFRvIEJlIEZpbGxl
ZCBCeSBPLkUuTS4vQjU1MCBUYWljaGksIEJJT1MgUDIuMDAgMDgvMDUvMjAyMQ0KPiAgICBS
SVA6IDAwMTA6YW1kZ3B1X2lycV9wdXQrMHhhNC8weGMwIFthbWRncHVdDQo+ICAgIENvZGU6
IGVhIDQ4IDhkIDE0IDkwIDhiIDEyIDg1IGQyIDc1IGFlIDViIGI4IGVhIGZmIGZmIGZmIDVk
IDQxIDVjIGU5IGE4IGM5IGUxIGQxIDg5IGVhIDQ4IDg5IGRlIDRjIDg5IGU3IDViIDVkIDQx
IDVjIGU5IDljIGZkIGZmIGZmIDwwZj4gMGIgYjggZWEgZmYgZmYgZmYgZWIgYTggYjggZmUg
ZmYgZmYgZmYgZWIgYTEgOTAgNjYgNjYgMmUgMGYgMWYNCj4gICAgUlNQOiAwMDE4OmZmZmZj
ZjRhODc3N2ZjZTAgRUZMQUdTOiAwMDAxMDI0Ng0KPiAgICBSQVg6IGZmZmY4YzYzNDIzM2E5
MDggUkJYOiBmZmZmOGM2MzQ1NTY0MDA4IFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KPiAgICBS
RFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiBmZmZmOGM2MzQ1NTY0MDA4IFJESTogZmZmZjhj
NjM0ODkwMDAwMA0KPiAgICBSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiAwMDAwMDAwMDAw
MDAwMDAxIFIwOTogZmZmZjhjNjM0NTU2NDhlNA0KPiAgICBSMTA6IGZmZmZmZmZmYzE0OTM1
ZDAgUjExOiBmZmZmOGM2Mzc1ZGQ4NDcwIFIxMjogZmZmZjhjNjM0ODkwMDAwMA0KPiAgICBS
MTM6IGZmZmY4YzYzNDU1NjQwMDAgUjE0OiBmZmZmOGM2MzQ4OTAwMDAwIFIxNTogMDAwMDAw
MDAwMDAwMDAwMA0KPiAgICBGUzogIDAwMDA3ZjA1NDkxMTk3NDAoMDAwMCkgR1M6ZmZmZjhj
ODI2OGMyODAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+ICAgIENTOiAgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCj4gICAgQ1IyOiAw
MDAwMDAwMDJkM2ZhODEwIENSMzogMDAwMDAwMDI4MmFhOTAwMCBDUjQ6IDAwMDAwMDAwMDBm
NTBlZjANCj4gICAgUEtSVTogNTU1NTU1NTQNCj4gICAgQ2FsbCBUcmFjZToNCj4gICAgIDxU
QVNLPg0KPiAgICAgc211X3NtY19od19jbGVhbnVwKzB4NjEvMHg0OTAgW2FtZGdwdV0NCj4g
ICAgIHNtdV9od19maW5pKzB4ZWYvMHgxODAgW2FtZGdwdV0NCj4gICAgIGFtZGdwdV9pcF9i
bG9ja19od19maW5pKzB4MzcvMHg0MSBbYW1kZ3B1XQ0KPiAgICAgYW1kZ3B1X2RldmljZV9m
aW5pX2h3KzB4MjBkLzB4Mjg0IFthbWRncHVdDQo+ICAgICBhbWRncHVfcGNpX3JlbW92ZSsw
eDQ4LzB4ODAgW2FtZGdwdV0NCj4gICAgIHBjaV9kZXZpY2VfcmVtb3ZlKzB4NDYvMHhiMA0K
PiAgICAgZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFsKzB4MTlhLzB4MjAwDQo+ICAg
ICB1bmJpbmRfc3RvcmUrMHhhMC8weGIwDQo+ICAgICBrZXJuZnNfZm9wX3dyaXRlX2l0ZXIr
MHgxNDkvMHgyMDANCj4gICAgIHZmc193cml0ZSsweDI1OS8weDRiMA0KPiAgICAga3N5c193
cml0ZSsweDZmLzB4ZTANCj4gICAgIGRvX3N5c2NhbGxfNjQrMHg0Yy8weDExMzANCj4gICAg
IGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCj4gICAgUklQOiAw
MDMzOjB4N2YwNTQ4ZTk4YmZhDQo+ICAgIENvZGU6IGI4IDA0IDAwIDAwIDAwIDQ4IDhiIDE1
IGVjIDcxIDE2IDAwIDY0IDg5IDAyIDQ4IGM3IGMyIGZmIGZmIGZmIGZmIDQ4IDgzIGM0IDE4
IDQ4IDg5IGQwIGMzIDY2IDkwIDQ5IDg5IGNhIDQ4IDhiIDQ0IDI0IDIwIDBmIDA1IDw0OD4g
NjMgZDAgM2QgMDAgZjAgZmYgZmYgNzcgMGMgNDggODkgZDAgNDggODMgYzQgMTggYzMgMGYg
MWYgNDAgMDANCj4gICAgUlNQOiAwMDJiOjAwMDA3ZmZlZWIxMmI0NzAgRUZMQUdTOiAwMDAw
MDIwMiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDAwMQ0KPiAgICBSQVg6IGZmZmZmZmZmZmZm
ZmZmZGEgUkJYOiAwMDAwN2YwNTQ5MDAxNzgwIFJDWDogMDAwMDdmMDU0OGU5OGJmYQ0KPiAg
ICBSRFg6IDAwMDAwMDAwMDAwMDAwMGQgUlNJOiAwMDAwMDAwMDJkM2ZhODEwIFJESTogMDAw
MDAwMDAwMDAwMDAwMQ0KPiAgICBSQlA6IDAwMDAwMDAwMDAwMDAwMGQgUjA4OiAwMDAwMDAw
MDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMA0KPiAgICBSMTA6IDAwMDAwMDAwMDAw
MDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjAyIFIxMjogMDAwMDAwMDAwMDAwMDAwZA0KPiAg
ICBSMTM6IDAwMDAwMDAwMmQzZmE4MTAgUjE0OiAwMDAwMDAwMDJkM2ZhODEwIFIxNTogMDAw
MDAwMDAwMDAwMDAwMA0KPiAgICAgPC9UQVNLPg0KPiAgICAtLS1bIGVuZCB0cmFjZSAwMDAw
MDAwMDAwMDAwMDAwIF0tLS0NCj4gICAgYW1kZ3B1IDAwMDA6MTQ6MDAuMDogYW1kZ3B1OiBG
YWlsIHRvIGRpc2FibGUgdGhlcm1hbCBhbGVydCENCj4gDQo+IA0KPiAtLQ0KPiBDYWwgUGVh
a2UNCg0K


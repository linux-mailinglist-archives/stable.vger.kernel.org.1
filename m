Return-Path: <stable+bounces-245064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD2aFq7QAGoMNAEAu9opvQ
	(envelope-from <stable+bounces-245064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:38:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9927505B47
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C243D30028B7
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9623115AF;
	Sun, 10 May 2026 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="Cz7gubaa"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18926B75B
	for <stable@vger.kernel.org>; Sun, 10 May 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438313; cv=none; b=AoOcvotvG+3PZ2eqUEmElFALGawSn6eU4HxRFZeGefp2ela1P5GUYgSjccBB/ECZc9OvU4kFnlWcp3jMnTdY0/SS/Nov57+NoOC23l4dbKxrxJebYMhkTde9BmtCj+sKJYQ/6URY6miBCEG3I3l+V1AnD74BXTenmggaDcbLhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438313; c=relaxed/simple;
	bh=CLudo1YRKMBVw5Bo9CvGEw6JhLrH8tpxi8SrlkZsPNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gpudco4GDhvr/fbhLWxgdqBvKJYUBSP8ChxuR01qwRAtaI2hEtnjWTbucSxIbFe4RTFTBibvXWAsoHnQsPEklyBMw3WHliuc9I018VSnbv3s8CXZS5D9r2X+1G/dZN/tfjHO9qQNQ3tklI2yzfrXsLqUYYEpxGwI+YoF/bYIoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=Cz7gubaa; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=8093; t=1778438269;
	x=1779043069; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	02=3A100=3A8400=3A1127=3A8b22=3A4c38=3A4ad1]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v26.0.2b)=20=0D=0A=09with=20ESMTPSA=20id=20md500100526081
	7.msg=3B=20Sun,=2010=20May=202026=2014=3A37=3A47=20-0400|Message
	-ID:=20<379c4dcb-11ac-43fc-a539-6cb5de9eef3a@auristor.com>|Date:
	=20Sun,=2010=20May=202026=2014=3A38=3A26=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20Back
	port=20RXRPC=20for=206.1.y=20from=206.2|To:=20Wentao=20Guan=20<g
	uanwentao@uniontech.com>|Cc:=20dhowells@redhat.com,=20gregkh@lin
	uxfoundation.org,=20horms@kernel.org,=0D=0A=20kuba@kernel.org,=2
	0linux-afs@lists.infradead.org,=20marc.dionne@auristor.com,=0D=0
	A=20sashal@kernel.org,=20stable@kernel.org,=20stable@vger.kernel
	.org|References:=20<b42ca28c-b276-4850-8e46-807ab8f45fa8@auristo
	r.com>=0D=0A=20<20260510182646.267145-1-guanwentao@uniontech.com
	>|Content-Language:=20en-US|From:=20Jeffrey=20E=20Altman=20<jalt
	man@auristor.com>|Organization:=20AuriStor,=20Inc.|Disposition-N
	otification-To:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|
	In-Reply-To:=20<20260510182646.267145-1-guanwentao@uniontech.com
	>|Content-Type:=20multipart/signed=3B=20protocol=3D"application/
	pkcs7-signature"=3B=20micalg=3Dsha-256=3B=20boundary=3D"--------
	----ms010901060605050805030706"; bh=CLudo1YRKMBVw5Bo9CvGEw6JhLrH
	8tpxi8SrlkZsPNs=; b=Cz7gubaaPibbyqfTBj98uUFuk3RS004JS+bKavizmXF9
	7k8pRZeQ8vuLVoOIzPsm47ddbnS5HHPIlWjt1+Ng2lCPgW1Ioq9RrtuWJwRkCLk2
	mTRrxcCWRmF7XgwaZ8DAq05/tKrCjBIOEkwxlIBwolzLOR3mNISP3Su0xW0VRgw=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 14:37:49 -0400
Received: from [IPV6:2603:7002:100:8400:1127:8b22:4c38:4ad1] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2b) 
	with ESMTPSA id md5001005260817.msg; Sun, 10 May 2026 14:37:47 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 14:37:47 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:1127:8b22:4c38:4ad1
X-MDHelo: [IPV6:2603:7002:100:8400:1127:8b22:4c38:4ad1]
X-MDArrival-Date: Sun, 10 May 2026 14:37:47 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1590908687=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <379c4dcb-11ac-43fc-a539-6cb5de9eef3a@auristor.com>
Date: Sun, 10 May 2026 14:38:26 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backport RXRPC for 6.1.y from 6.2
To: Wentao Guan <guanwentao@uniontech.com>
Cc: dhowells@redhat.com, gregkh@linuxfoundation.org, horms@kernel.org,
 kuba@kernel.org, linux-afs@lists.infradead.org, marc.dionne@auristor.com,
 sashal@kernel.org, stable@kernel.org, stable@vger.kernel.org
References: <b42ca28c-b276-4850-8e46-807ab8f45fa8@auristor.com>
 <20260510182646.267145-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20260510182646.267145-1-guanwentao@uniontech.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010901060605050805030706"
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: E9927505B47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[];
	TAGGED_FROM(0.00)[bounces-245064-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,auristor.com:mid,auristor.com:dkim]
X-Rspamd-Action: no action

--------------ms010901060605050805030706
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8xMC8yMDI2IDI6MjYgUE0sIFdlbnRhbyBHdWFuIHdyb3RlOg0KPj4gSSBjYW5ub3Qg
ZWFzaWx5IGNoZWNrIGJ1dCBpdCBkb2Vzbid0IGxvb2sgbGlrZSA2LjEuMTc5IGlzIHZ1bG5l
cmFibGUgdG8NCj4gNi4xLjE3OS0+IHNlZW0gNi4xLjE3Mg0KPj4gQ1ZFLTIwMjYtNDM1MDAu
DQo+IEZZSSwgdG8gcmVwcm9kdWNlIGl0LCBqdXN0IHJ1bmluZyBhIFBPQyB3aXRoIENPTkZJ
R19BRl9SWFJQQyArIENPTkZJR19SWEtBRCwNCj4gaSBhbSBzdXJlIHdpdGhvdXQgQ09ORklH
X1JYS0FEIGl0IGlzIG5vdCBhZmZlY3RlZCBpbiB2Ni4xLjE3MiB3aXRoIG15IHRlc3QuDQo+
IFBPQzogaHR0cHM6Ly9naXRodWIuY29tL1Y0YmVsL2RpcnR5ZnJhZy9ibG9iL21hc3Rlci9l
eHAuYw0KPiAocnVuIGl0IHdpdGggJy0tZm9yY2UtcnhycGMnIG9yIHJlbW92ZSBDT05GSUdf
SU5FVF9FU1ApDQoNClJYUlBDIGFuZCBSWEtBRCB3b3VsZCBiZSByZXF1aXJlZCB0byByZXBy
b2R1Y2UuwqAgwqBUaGUgUE9DIGRvZXMgbm90IA0KYXR0ZW1wdCB0byB0cnkNCnRoZSBSWFJQ
QyBjYXNlIGlmIHRoZSBFU1AgY2FzZSBzdWNjZWVkcy7CoCBTbyB0aGUgRVNQIGNhc2UgbXVz
dCBiZSANCnBhdGNoZWQgZmlyc3Qgb3INCmRpc2FibGVkLg0KDQo+PiBQbGVhc2UgY2hlY2su
DQo+IEkgd2lsbCByZWNoZWNrIGl0LCBpIGRvIG1hbnkgdGVzdHMgdGhlc2UgZGF5cyBzbyBJ
IGFtIDEwMCUgc3VyZSBub3csDQo+IGkgd2lsbCByZXBseSB3aGVuIGkgZmluaXNoIG15IHRl
c3RzIHdpdGggNi4xLjE3Mi4NCj4NCj4+IFBsZWFzZSBjaGVjay4NCj4gSSBhbSBzdXJlIHRo
YXQgc29tZSA1LjEwIG9yIDYuMSB2ZXJzaW9uIGFyZSB2dWxuZXJhYmxlIHdpdGggb3VyIHRl
c3RzLg0KPg0KPiBCUnMNCj4gV2VudGFvIEd1YW4NCkJhY2sgcG9ydGluZyBtYW55IHllYXJz
IG9mIFJYUlBDIGZlYXR1cmUgY2hhbmdlcyB0byBmaXggdGhpcyANCnZ1bG5lcmFiaWxpdHkg
aWYgcHJlc2VudA0KZmVlbHMgbGlrZSB0aGUgd3JvbmcgdGhpbmcgdG8gZG8uwqAgwqBJZiB0
aGUgdnVsbmVyYWJpbGl0eSBpcyBwcmVzZW50LCB3ZSANCmNhbiB0cnkgdG8gZmluZCBhDQoN
CmJyYW5jaCBzcGVjaWZpYyBmaXguDQoNCkplZmZyZXkgQWx0bWFuDQoNCg0K

--------------ms010901060605050805030706
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DTAwggY0MIIEHKADAgECAhBAAZimBAJ19t4m6OTgn3OxMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTE0
MB4XDTI1MDgxNDAwMzg1N1oXDTI3MTEwMTAwMzc1N1owgcwxKDAmBgNVBAUTH0EwMTQxMEMw
MDAwMDE5OEE2MDQwMjY3MDAxMEYyNjIxGTAXBgNVBGETEE5UUlVTK05ZLTM1ODIyMzcxFTAT
BgNVBAoTDEF1cmlTdG9yIEluYzEZMBcGA1UEAxMQSmVmZnJleSBFIEFsdG1hbjEPMA0GA1UE
BBMGQWx0bWFuMRAwDgYDVQQqEwdKZWZmcmV5MSMwIQYJKoZIhvcNAQkBFhRqYWx0bWFuQGF1
cmlzdG9yLmNvbTELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
AQDKtXD1tqgXxlJvgI10FM0ZvyWukq2IeXgVhbgOk4k4PbRk1TvrGB04QatXac9soW7yHv6R
hoovQ+URaXBEpBYxOE8Tsx+XfKZNkGbWj9bEdWgi8HPb33rf8eKFuhjx1QEv/YtD7lGIp7Rh
KWC5kBfvyut8o3XJmJF0hCR1m663wsttrn89dwZczLU4JUjbTF0ukM0DbDk55ItDB4dXnW/u
RfhrVuemMvbDily+etLCWsuJjtrjRBCQ805eYRHq5LonX3oNLdXituSHXLKvq+uChgFN/veD
HKpeBnBWmoNtOQnV8fsq5NCz/WswIACeZj+xGmZsWx7fyuzee78ZePfBAgMBAAGjggGhMIIB
nTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIE8DCBhAYIKwYBBQUHAQEEeDB2MDAGCCsG
AQUFBzABhiRodHRwOi8vY29tbWVyY2lhbC5vY3NwLmlkZW50cnVzdC5jb20wQgYIKwYBBQUH
MAKGNmh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY2VydHMvdHJ1c3RpZGNhYTE0
LnA3YzAfBgNVHSMEGDAWgBTC1ESZoHHPSFa+DI5oOFynt/dFvDAjBgNVHSAEHDAaMAkGB2eB
DAEFAwIwDQYLYIZIAYb5LwAGAgEwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL3ZhbGlkYXRp
b24uaWRlbnRydXN0LmNvbS9jcmwvdHJ1c3RpZGNhYTE0LmNybDAfBgNVHREEGDAWgRRqYWx0
bWFuQGF1cmlzdG9yLmNvbTAdBgNVHQ4EFgQUY4JHedU4owyskKPvw4gOjSyBJZUwKQYDVR0l
BCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMMMA0GCSqGSIb3DQEBCwUAA4IC
AQCeOjCscMFctL6UG8WBsFMIOHc7MpbrX7EIvO34SGVKhrbqS1RTIBQiVVWnQ4VI6qVw/n9d
adUv4o1/F23s0uXE8/lGJAGn51kkw1xHU+0PGODOTWvAQOiPhSmaXG5xM4BgleroGggumd8f
HRSKFK7DIdWcMMNbS6LpMAOUfXYzNBvcHbAcjJMHQ7N8pNXdEQDB9c6yIw4paVD6XDE5VFhL
df6749jGqSWXpyTMjXzrPMaDyxKiNOtsUrdT/fh8+Xx84nGpwiV9PA9/cGSAPcAc/qMBgPb4
Qj9met/RUvCHPWr68Zlirgx48W/7TTZFhXKZg3U+zCj4ASOfLJ6WT4PPoM+eLHbB402WNMFk
QDmWBH4bMqUcbQWxarMxdQ/jHKTsJIkvg+rTCbWbDm7hgJbnPEZrJEghy69Opa9+F1HB90AQ
mb41N1PLZytu8pCGBJufyqjzNU0eyWkHJCwHDLFhoCENk/vujFCmsJUSh7a6ZMPSXf3PR4TP
Kkcgs9JBT0dyPGHEfC/Lp9ZHTGSO6zswK1BddBufYi3xqHNBO/s7ft6gpNvht7oKUhVcjM7E
mQCA6t2ok44PNfeG8rJZxiDv04IruCbzLFwkPczWS5uCIuP3PWCfVtMnUPDamMVWAr4Ui/s6
fy3TZbPUAPDjFRi7zpkFIKHlCS/HIHNR6Gr1lzCCBvQwggTcoAMCAQICEEABif/SaQvad8Lp
1U2SCE0wDQYJKoZIhvcNAQELBQAwSjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEnMCUGA1UEAxMeSWRlblRydXN0IENvbW1lcmNpYWwgUm9vdCBDQSAxMB4XDTIzMDgxNjE5
Mjg0NloXDTMzMDgxMjE5Mjg0NVowOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVz
dDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
AoICAQDoqfW8senk2X/L7Viky0ZgZYnwlxqsE/vDQWARa1i7gZ0wRJ7ZOWIbjYDccsGFBhCb
8VLx1dershozyPcOizZ1LxAhstZhpz8KvKc4bHhu1+6ZJftmrDyAELLRu1gkPS0BvongGBin
xoTNo0XwafmS67jFRtYHe2VQSLvy0t9xRUsgdEeYgCUAnKO5eRVQMmBBNhnsTFtO5FzNmNKn
uw/TDcBbOpGrQ1FSCuOZTHw3njDtZGqiRXSruX3MCpV190CefwryeGLXCsawSz2wMQZkqtjY
V9Au73Zrqg1yDVj9KGKoRnJ8cUcg1Inxs/+Bo3xcM43y2h10yDrSWFTfvPSQhUJwYKHCYJSV
QLFbeH9vxFJeLlewivaKQMGEg8PpnjevzDu8PVVzr9gkWcLubhztussqdAPF+dvyXIYJb/7l
6idZkS4NeHAsrAtcv+UF+SGzSS5F28s376Kx35LUaJeOW4hQOjSj/118F9cyYAd2WlgGdBda
K2PSvH7aANZQfyEhNNMzk2GP83pHXXeXy+09LkTcIlgXr2rrXepxP+WBp+Ihu4Jh5uZWQkpG
UUNqKSjxIpUJ6sDIIgGIqSY/uBFSp2ff+4OLLS3Z+XQ9gBu1Szd3kQ8PrGXAI5DXayXjM9Yp
psHld3OojXhoOsLdCji+be0mAgvbNa6AaSJcT7RF3QIDAQABo4IB5DCCAeAwEgYDVR0TAQH/
BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkGCCsGAQUFBwEBBH0wezAwBggrBgEFBQcw
AYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEcGCCsGAQUFBzAChjto
dHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL3Jvb3RzL2NvbW1lcmNpYWxyb290Y2Ex
LnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C5yZUyI42djBfBgNVHSAEWDBWMFQGBFUd
IAAwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUuaWRlbnRydXN0LmNvbS9jZXJ0aWZp
Y2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwSgYDVR0fBEMwQTA/oD2gO4Y5aHR0cDovL3Zh
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
--------------ms010901060605050805030706--



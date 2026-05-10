Return-Path: <stable+bounces-245062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2RwMDZ3IAGqvMgEAu9opvQ
	(envelope-from <stable+bounces-245062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:04:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B86650586D
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DB073008087
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB7B279917;
	Sun, 10 May 2026 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="t4zn2xU1"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3B81732
	for <stable@vger.kernel.org>; Sun, 10 May 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436246; cv=none; b=e8e+3gXoRO9AusdtYGljZjVCzdyY6c9uVTAEX/R8CY8v+tXzOLnCecy8tfgwKx6WmU2FValuP4YUuhwyFSO1xKovfqL0LTd5yJWziTU3989HMMStfCYVLMj/QGeAjoRDwAnli8zPlpHTcpdYHcK47aMjpCbuXDIiQew8CqeUC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436246; c=relaxed/simple;
	bh=M27WxcygSXre2JDmi/gLdcEosaPqLkbWYT+onri6w6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTQ7WOHQSEXhG+kKCU+zWykys6YUwFgbA6KNTp2x/J/BOarqckPcJahg3S5AuyYfTpsNPOueVX/DeV/imTdJA4v2jexWc9MB5CyFbSUtJVDcpWmCfpdNFVleKQcyu1J752MB0rROqPocYlKYHXVXA5KnZh0KDO1IqGE4NjCmfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=t4zn2xU1; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=8287; t=1778436201;
	x=1779041001; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	02=3A100=3A8400=3A8595=3Ac601=3Aade8=3A99ed]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v26.0.2b)=20=0D=0A=09with=20ESMTPSA=20id=20md500100526078
	0.msg=3B=20Sun,=2010=20May=202026=2014=3A03=3A21=20-0400|Message
	-ID:=20<b42ca28c-b276-4850-8e46-807ab8f45fa8@auristor.com>|Date:
	=20Sun,=2010=20May=202026=2014=3A04=3A01=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20Back
	port=20RXRPC=20for=206.1.y=20from=206.2|To:=20Wentao=20Guan=20<g
	uanwentao@uniontech.com>|Cc:=20dhowells@redhat.com,=20gregkh@lin
	uxfoundation.org,=20horms@kernel.org,=0D=0A=20kuba@kernel.org,=2
	0linux-afs@lists.infradead.org,=20marc.dionne@auristor.com,=0D=0
	A=20sashal@kernel.org,=20stable@kernel.org,=20stable@vger.kernel
	.org|References:=20<ab79de29-afc4-43b2-b12b-9c0bef976aa1@auristo
	r.com>=0D=0A=20<20260510174102.264374-1-guanwentao@uniontech.com
	>|Content-Language:=20en-US|From:=20Jeffrey=20E=20Altman=20<jalt
	man@auristor.com>|Organization:=20AuriStor,=20Inc.|Disposition-N
	otification-To:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|
	In-Reply-To:=20<20260510174102.264374-1-guanwentao@uniontech.com
	>|Content-Type:=20multipart/signed=3B=20protocol=3D"application/
	pkcs7-signature"=3B=20micalg=3Dsha-256=3B=20boundary=3D"--------
	----ms070903070202060301030109"; bh=M27WxcygSXre2JDmi/gLdcEosaPq
	LkbWYT+onri6w6o=; b=t4zn2xU1UoqWNZa5Jixs9rN/OXKjwZ/USaT00j8iTj92
	03qXKaImuoiL4ulvPP8vfa7VVnmv4WQ++jBNcS+PAfzKAPw2ESyUSUQJPOlAVMq4
	gtDObZZesmXVigEvyTnDDhXsG32B9MmvqYTHyByHEBQ1Pt84TI2MkWwGSl7KZFc=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 14:03:21 -0400
Received: from [IPV6:2603:7002:100:8400:8595:c601:ade8:99ed] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2b) 
	with ESMTPSA id md5001005260780.msg; Sun, 10 May 2026 14:03:21 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 14:03:21 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:8595:c601:ade8:99ed
X-MDHelo: [IPV6:2603:7002:100:8400:8595:c601:ade8:99ed]
X-MDArrival-Date: Sun, 10 May 2026 14:03:21 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1590908687=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <b42ca28c-b276-4850-8e46-807ab8f45fa8@auristor.com>
Date: Sun, 10 May 2026 14:04:01 -0400
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
References: <ab79de29-afc4-43b2-b12b-9c0bef976aa1@auristor.com>
 <20260510174102.264374-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20260510174102.264374-1-guanwentao@uniontech.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070903070202060301030109"
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: 8B86650586D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[];
	TAGGED_FROM(0.00)[bounces-245062-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--------------ms070903070202060301030109
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8xMC8yMDI2IDE6NDEgUE0sIFdlbnRhbyBHdWFuIHdyb3RlOg0KPj4gQXJlIHlvdSBh
c3NvY2lhdGVkIHdpdGggYSBMaW51eCBkaXN0cmlidXRpb24gd2hpY2ggc2hpcHMgNi4xLnkg
c3RhYmxlPw0KPiBXZSBzaGlwZWQgNi4xIGtlcm5lbCBwYXN0LCBhbmQgd2UgYXJlIHByZXBh
cmluZyB0aGUgZml4IGZvciBpdC4NCj4NCj4gQlJzDQo+IFdlbnRhbyBHdWFuDQoNCldlbnRh
bywNCg0KSGF2ZSB5b3UgY29uZmlybWVkIHRoYXQgNi4xLjE3OSBpcyB2dWxuZXJhYmxlIHRv
IHRoZSBleHBsb2l0PyBXaGVuIA0KcHJvY2Vzc2luZw0KYSBEQVRBIHBhY2tldCBhIG5ldyB1
bnNoYXJlZCBza2IgaXMgYWxsb2NhdGVkIGZvciB0aGUgaW5jb21pbmcgcGFja2V0DQp3aGVu
ZXZlciBkZWNyeXB0aW9uIGlzIHJlcXVpcmVkLg0KDQogwqAgwqAgwqAgwqAgLyogVW5zaGFy
ZSB0aGUgcGFja2V0IHNvIHRoYXQgaXQgY2FuIGJlIG1vZGlmaWVkIGZvciBpbi1wbGFjZQ0K
IMKgIMKgIMKgIMKgIMKgKiBkZWNyeXB0aW9uLg0KIMKgIMKgIMKgIMKgIMKgKi8NCiDCoCDC
oCDCoCDCoCBpZiAoc3AtPmhkci5zZWN1cml0eUluZGV4ICE9IDApIHsNCiDCoCDCoCDCoCDC
oCDCoCDCoCBzdHJ1Y3Qgc2tfYnVmZiAqbnNrYiA9IHNrYl91bnNoYXJlKHNrYiwgR0ZQX0FU
T01JQyk7DQogwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFuc2tiKSB7DQogwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcnhycGNfZWF0ZW5fc2tiKHNrYiwgcnhycGNfc2tiX3Vuc2hhcmVkX25v
bWVtKTsNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIG91dDsNCiDCoCDCoCDCoCDC
oCDCoCDCoCB9DQoNCiDCoCDCoCDCoCDCoCDCoCDCoCBpZiAobnNrYiAhPSBza2IpIHsNCiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByeHJwY19lYXRlbl9za2Ioc2tiLCByeHJwY19za2Jf
cmVjZWl2ZWQpOw0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNrYiA9IG5za2I7DQogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcnhycGNfbmV3X3NrYihza2IsIHJ4cnBjX3NrYl91bnNo
YXJlZCk7DQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3AgPSByeHJwY19za2Ioc2tiKTsN
CiDCoCDCoCDCoCDCoCDCoCDCoCB9DQogwqAgwqAgwqAgwqAgfQ0KDQpJIGNhbm5vdCBlYXNp
bHkgY2hlY2sgYnV0IGl0IGRvZXNuJ3QgbG9vayBsaWtlIDYuMS4xNzkgaXMgdnVsbmVyYWJs
ZSB0byANCkNWRS0yMDI2LTQzNTAwLg0KDQpQbGVhc2UgY2hlY2suDQoNClRoYW5rIHlvdS4N
Cg0KSmVmZnJleSBBbHRtYW4NCg0KDQo=

--------------ms070903070202060301030109
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
--------------ms070903070202060301030109--



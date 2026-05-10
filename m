Return-Path: <stable+bounces-245059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M6TD4+/AGoCMQEAu9opvQ
	(envelope-from <stable+bounces-245059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:25:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51682505675
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED9FE3008D17
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449F3B388B;
	Sun, 10 May 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="OW9sG+l5"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532D364055
	for <stable@vger.kernel.org>; Sun, 10 May 2026 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433931; cv=none; b=rH+4Q7RdJkTh6PYEmp36yH6duEK+Lp/ypAaGY2D41dQOBjqm+4WR/ahWXGg+3/2h7h/yR1SczYezAEpIiiBO2YMyBRrc+sWJ68ab+cI9gfvCO2Q/n0h8qDpWS25ecb3+/p6pyngjlJ57JFL6IMbfiC9VD7gccN64SGaleZKWSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433931; c=relaxed/simple;
	bh=o7deXco93hmARwp6B5jgqxasWXgprK+ZJez3b13vFAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rtbm9436MOPwikRHZw0ZYsWEYWz3x3iSePn+KfnkCT3TMjkpU0gKPObgZY2uAzn791qRlbrdeeqWLobwwLPzuRxyFBTpGM20nxLjdwoNr3+HMP8CMSz4EfxKWgUjwpgOGpoovsWahbwh7oaBRvPOqrutkYj81xvxGWzzlckAEBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=OW9sG+l5; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=8111; t=1778433880;
	x=1779038680; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	02=3A100=3A8400=3A8595=3Ac601=3Aade8=3A99ed]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v26.0.2b)=20=0D=0A=09with=20ESMTPSA=20id=20md500100526075
	5.msg=3B=20Sun,=2010=20May=202026=2013=3A24=3A39=20-0400|Message
	-ID:=20<ab79de29-afc4-43b2-b12b-9c0bef976aa1@auristor.com>|Date:
	=20Sun,=2010=20May=202026=2013=3A25=3A22=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20Back
	port=20RXRPC=20for=206.1.y=20from=206.2|To:=20Wentao=20Guan=20<g
	uanwentao@uniontech.com>,=20gregkh@linuxfoundation.org|Cc:=20dho
	wells@redhat.com,=20horms@kernel.org,=20kuba@kernel.org,=0D=0A=2
	0linux-afs@lists.infradead.org,=20marc.dionne@auristor.com,=20sa
	shal@kernel.org,=0D=0A=20stable@kernel.org,=20stable@vger.kernel
	.org|References:=20<2026051040-primary-anyway-9a79@gregkh>=0D=0A
	=20<20260510163636.260801-1-guanwentao@uniontech.com>|Content-La
	nguage:=20en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@auristor
	.com>|Organization:=20AuriStor,=20Inc.|Disposition-Notification-
	To:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|In-Reply-To:
	=20<20260510163636.260801-1-guanwentao@uniontech.com>|Content-Ty
	pe:=20multipart/signed=3B=20protocol=3D"application/pkcs7-signat
	ure"=3B=20micalg=3Dsha-256=3B=20boundary=3D"------------ms050307
	030303010201010900"; bh=o7deXco93hmARwp6B5jgqxasWXgprK+ZJez3b13v
	FAs=; b=OW9sG+l5aKCepv6Fkd/vT69cLcRZfaFn9Y9BTqH8gE1qLXR9lU0hdmmw
	Id45WSNOCaM6X+04p6Tww1IhRfANYa1E5mVbgI/Po8dplSGogkuNjwHL1uGCAYSt
	HBl7O7K4y3KbJ1QaUUDD6+l7juwkhukfhYutEgS67Ppa/FjrX94=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 13:24:40 -0400
Received: from [IPV6:2603:7002:100:8400:8595:c601:ade8:99ed] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v26.0.2b) 
	with ESMTPSA id md5001005260755.msg; Sun, 10 May 2026 13:24:39 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 13:24:39 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7002:100:8400:8595:c601:ade8:99ed
X-MDHelo: [IPV6:2603:7002:100:8400:8595:c601:ade8:99ed]
X-MDArrival-Date: Sun, 10 May 2026 13:24:39 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1590908687=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <ab79de29-afc4-43b2-b12b-9c0bef976aa1@auristor.com>
Date: Sun, 10 May 2026 13:25:22 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backport RXRPC for 6.1.y from 6.2
To: Wentao Guan <guanwentao@uniontech.com>, gregkh@linuxfoundation.org
Cc: dhowells@redhat.com, horms@kernel.org, kuba@kernel.org,
 linux-afs@lists.infradead.org, marc.dionne@auristor.com, sashal@kernel.org,
 stable@kernel.org, stable@vger.kernel.org
References: <2026051040-primary-anyway-9a79@gregkh>
 <20260510163636.260801-1-guanwentao@uniontech.com>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20260510163636.260801-1-guanwentao@uniontech.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050307030303010201010900"
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: 51682505675
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SIGNED_SMIME(-2.00)[];
	HEADER_FORGED_MDN(2.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245059-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--------------ms050307030303010201010900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNS8xMC8yMDI2IDEyOjM2IFBNLCBXZW50YW8gR3VhbiB3cm90ZToNCj4+IFdoeSBpcyB0
aGlzIG5lZWRlZD8gIElmIHlvdSB3YW50IHRoaXMsIHBsZWFzZSBwcm92aWRlIGEgd29ya2lu
ZyBzZXQgb2YNCj4+IHBhdGNoZXMgcHJvcGVybHkgc3VibWl0dGVkLCBhbG9uZyB3aXRoIHRo
ZSByZWFzb25pbmcgd2h5IHlvdSBqdXN0IGRvbid0DQo+PiBtb3ZlIHRvIGEgbmV3ZXIga2Vy
bmVsIHZlcnNpb24uICBBbmQgZG8geW91IHJlYWxseSB1c2UgdGhlIEFGUw0KPj4gZmlsZXN5
c3RlbSBpbiBhIDYuMS55IGtlcm5lbCB0cmVlPyAgSWYgc28sIHdoeT8NCj4gRllJLCB0aGVy
ZSBhcmUgYnVnZml4ZXMgc3VjaCBhcyAoInJ4cnBjOiBGaXggY29ubi1sZXZlbCBwYWNrZXQg
aGFuZGxpbmcgdG8gdW5zaGFyZSBSRVNQT05TRSBwYWNrZXRzIikNCj4gYWZmZWN0IHRoZSA2
LjEueSBrZXJuZWwsIGFuZCB0aGUgZmluYWwgZ29hbCBpcyBjbGVhbiBhcHBseSBmaXhlcyBm
b3IgQ1ZFLTIwMjYtNDM1MDAgc3VjaCBhcw0KPiAoInJ4cnBjOiBBbHNvIHVuc2hhcmUgREFU
QS9SRVNQT05TRSBwYWNrZXRzIHdoZW4gcGFnZWQgZnJhZ3MgYXJlIHByZXNlbnQiKSBpbiBt
YWlsbGlzdC4NCj4NCj4+IG1vdmUgdG8gYSBuZXdlciBrZXJuZWwgdmVyc2lvbi4gIEFuZCBk
byB5b3UgcmVhbGx5IHVzZSB0aGUgQUZTDQo+PiBmaWxlc3lzdGVtIGluIGEgNi4xLnkga2Vy
bmVsIHRyZWU/ICBJZiBzbywgd2h5Pw0KPiBOTywganVzdCBhZmZlY3RlZCBieSBjb21waWxl
ZCBrZXJuZWwgd2hpY2ggZW5hYmxlZCB0aGUgY29uZmlnOigsDQo+IHdlIGFyZSBwcmVwYXJp
bmcgZml4IHN1Y2ggYXMgZGlzYWJsZSBBRlMgYW5kIEFGX1JYUlBDIG9yIGZpeCBpdC4uLg0K
Pg0KPiBCUnMNCj4gV2VudGFvIEd1YW4NCg0KV2VudGFvLA0KDQpBcmUgeW91IGFzc29jaWF0
ZWQgd2l0aCBhIExpbnV4IGRpc3RyaWJ1dGlvbiB3aGljaCBzaGlwcyA2LjEueSBzdGFibGU/
DQoNCk9yIGFyZSB5b3UgYnVpbGRpbmcgdGhlIGtlcm5lbCBmb3IgbG9jYWwgdXNlPw0KDQpH
cmVnLA0KDQpJIGJlbGlldmUgRGViaWFuIEJvb2t3b3JtIHNoaXBzIDYuMS55IGtlcm5lbHMg
d2l0aCBSWFJQQyBjb21waWxlZCBhbmQgDQpwYWNrYWdlZC4NCg0KSmVmZnJleSBBbHRtYW4N
Cg0K

--------------ms050307030303010201010900
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
--------------ms050307030303010201010900--



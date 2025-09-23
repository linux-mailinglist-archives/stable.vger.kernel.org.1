Return-Path: <stable+bounces-181551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2811B97886
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 22:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC719C6E5E
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C5275AFA;
	Tue, 23 Sep 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="Kg5ulvWr"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90230B513
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660828; cv=none; b=OJxGX/fNkWliaSQ658AeurT/hooDwhQUj/doyyRzGcczBjNUGgec2/SpsugmoyaW9oHFcTJDXCDI+7Vyg+coKoQguURcF0h2BrFqfZje2JHu55oxK+LcAdhi9IhLIn+ctDj+k5NDUhlL4YVAVh8Clb5NUh9/2w2wX8+SZYTOMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660828; c=relaxed/simple;
	bh=QYOZVgrsduzZ5/h6y+DcaWYWli9WFO6f+CLtwD+4xLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9pmIbctrwB948s6rUDlRuEY8zwEQacjHR8nV3VtxNDL1XNCchjHeMUo/uMLYSacAN5qHB/Se9D2P1psMJShSLE3bYD+3FE4JwbTMB2bARo35pzPcqihbOMKmeP6ynfM3ybVNjdKlI2B4pq+MgsBl6Tw7wYUa8DpXsvPGrPQWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=Kg5ulvWr; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=8349; t=1758660561;
	x=1759265361; i=jaltman@auristor.com; q=dns/txt; h=Message-ID:
	Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	Content-Language:From:Organization:Disposition-Notification-To:
	In-Reply-To:Content-Type; z=Received:=20from=20[IPV6=3A2603=3A70
	00=3A73c=3Abb00=3Ac157=3A3e4e=3A44c0=3Af29d]=20by=20auristor.com
	=20(IPv6=3A2001=3A470=3A1f07=3Af77=3Affff=3A=3A312)=20(MDaemon=2
	0PRO=20v25.5.1a)=20=0D=0A=09with=20ESMTPSA=20id=20md500100500258
	2.msg=3B=20Tue,=2023=20Sep=202025=2016=3A49=3A21=20-0400|Message
	-ID:=20<5d9b7822-5ab2-4f35-858d-669d6365ecd5@auristor.com>|Date:
	=20Tue,=2023=20Sep=202025=2016=3A49=3A40=20-0400|MIME-Version:=2
	01.0|User-Agent:=20Mozilla=20Thunderbird|Subject:=20Re=3A=20[PAT
	CH]=20afs=3A=20Fix=20potential=20null=20pointer=20dereference=20
	in=0D=0A=20afs_put_server|To:=20Zhen=20Ni=20<zhen.ni@easystack.c
	n>,=20dhowells@redhat.com,=0D=0A=20marc.dionne@auristor.com|Cc:=
	20linux-afs@lists.infradead.org,=20stable@vger.kernel.org|Refere
	nces:=20<20250923075104.1141803-1-zhen.ni@easystack.cn>|Content-
	Language:=20en-US|From:=20Jeffrey=20E=20Altman=20<jaltman@aurist
	or.com>|Organization:=20AuriStor,=20Inc.|Disposition-Notificatio
	n-To:=20Jeffrey=20E=20Altman=20<jaltman@auristor.com>|In-Reply-T
	o:=20<20250923075104.1141803-1-zhen.ni@easystack.cn>|Content-Typ
	e:=20multipart/signed=3B=20protocol=3D"application/pkcs7-signatu
	re"=3B=20micalg=3Dsha-256=3B=20boundary=3D"------------ms0604090
	30907020803030309"; bh=QYOZVgrsduzZ5/h6y+DcaWYWli9WFO6f+CLtwD+4x
	LI=; b=Kg5ulvWrLs5yihVq+acKxOl/uqSxx3JhxKdxbES1/xMQCFn3LMHJ/cMSc
	ocaAlmFkoeOaAmc9X1Q0o/d9hnxg++aqERC74/J4g+NyGUeEbUyj7P2Sl2lEO2o8
	yYj3+llapVHW63W/xIMh+9/d2MmLi374Phi3rnmcC2t0PwaWdQ=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Tue, 23 Sep 2025 16:49:21 -0400
Received: from [IPV6:2603:7000:73c:bb00:c157:3e4e:44c0:f29d] by auristor.com (IPv6:2001:470:1f07:f77:ffff::312) (MDaemon PRO v25.5.1a) 
	with ESMTPSA id md5001005002582.msg; Tue, 23 Sep 2025 16:49:21 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Tue, 23 Sep 2025 16:49:21 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:c157:3e4e:44c0:f29d
X-MDHelo: [IPV6:2603:7000:73c:bb00:c157:3e4e:44c0:f29d]
X-MDArrival-Date: Tue, 23 Sep 2025 16:49:21 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1361cde01b=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <5d9b7822-5ab2-4f35-858d-669d6365ecd5@auristor.com>
Date: Tue, 23 Sep 2025 16:49:40 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] afs: Fix potential null pointer dereference in
 afs_put_server
To: Zhen Ni <zhen.ni@easystack.cn>, dhowells@redhat.com,
 marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org, stable@vger.kernel.org
References: <20250923075104.1141803-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Jeffrey E Altman <jaltman@auristor.com>
Organization: AuriStor, Inc.
Disposition-Notification-To: Jeffrey E Altman <jaltman@auristor.com>
In-Reply-To: <20250923075104.1141803-1-zhen.ni@easystack.cn>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms060409030907020803030309"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms060409030907020803030309
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS8yMy8yMDI1IDM6NTEgQU0sIFpoZW4gTmkgd3JvdGU6DQo+IGFmc19wdXRfc2VydmVy
KCkgYWNjZXNzZWQgc2VydmVyLT5kZWJ1Z19pZCBiZWZvcmUgdGhlIE5VTEwgY2hlY2ssIHdo
aWNoDQo+IGNvdWxkIGxlYWQgdG8gYSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UuIE1vdmUg
dGhlIGRlYnVnX2lkIGFzc2lnbm1lbnQsDQo+IGVuc3VyaW5nIHdlIG5ldmVyIGRlcmVmZXJl
bmNlIGEgTlVMTCBzZXJ2ZXIgcG9pbnRlci4NCj4NCj4gRml4ZXM6IDI3NTdhNGRjMTg0OSAo
ImFmczogRml4IGFjY2VzcyBhZnRlciBkZWMgaW4gcHV0IGZ1bmN0aW9ucyIpDQo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFpoZW4gTmkgPHpoZW4u
bmlAZWFzeXN0YWNrLmNuPg0KPiAtLS0NCj4gICBmcy9hZnMvc2VydmVyLmMgfCAzICsrLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4N
Cj4gZGlmZiAtLWdpdCBhL2ZzL2Fmcy9zZXJ2ZXIuYyBiL2ZzL2Fmcy9zZXJ2ZXIuYw0KPiBp
bmRleCBhOTc1NjJmODMxZWIuLmM0NDI4ZWJkZGIxZCAxMDA2NDQNCj4gLS0tIGEvZnMvYWZz
L3NlcnZlci5jDQo+ICsrKyBiL2ZzL2Fmcy9zZXJ2ZXIuYw0KPiBAQCAtMzMxLDEzICszMzEs
MTQgQEAgc3RydWN0IGFmc19zZXJ2ZXIgKmFmc191c2Vfc2VydmVyKHN0cnVjdCBhZnNfc2Vy
dmVyICpzZXJ2ZXIsIGJvb2wgYWN0aXZhdGUsDQo+ICAgdm9pZCBhZnNfcHV0X3NlcnZlcihz
dHJ1Y3QgYWZzX25ldCAqbmV0LCBzdHJ1Y3QgYWZzX3NlcnZlciAqc2VydmVyLA0KPiAgIAkJ
ICAgIGVudW0gYWZzX3NlcnZlcl90cmFjZSByZWFzb24pDQo+ICAgew0KPiAtCXVuc2lnbmVk
IGludCBhLCBkZWJ1Z19pZCA9IHNlcnZlci0+ZGVidWdfaWQ7DQo+ICsJdW5zaWduZWQgaW50
IGEsIGRlYnVnX2lkOw0KPiAgIAlib29sIHplcm87DQo+ICAgCWludCByOw0KPiAgIA0KPiAg
IAlpZiAoIXNlcnZlcikNCj4gICAJCXJldHVybjsNCj4gICANCj4gKwlkZWJ1Z19pZCA9IHNl
cnZlci0+ZGVidWdfaWQ7DQo+ICAgCWEgPSBhdG9taWNfcmVhZCgmc2VydmVyLT5hY3RpdmUp
Ow0KPiAgIAl6ZXJvID0gX19yZWZjb3VudF9kZWNfYW5kX3Rlc3QoJnNlcnZlci0+cmVmLCAm
cik7DQo+ICAgCXRyYWNlX2Fmc19zZXJ2ZXIoZGVidWdfaWQsIHIgLSAxLCBhLCByZWFzb24p
Ow0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogSmVmZnJleSBBbHRtYW4gPGphbHRt
YW5AYXVyaXN0b3IuY29tPg0KDQoNCg==

--------------ms060409030907020803030309
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
--------------ms060409030907020803030309--



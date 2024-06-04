Return-Path: <stable+bounces-47939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78F8FB85A
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1A8B2D697
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688FA1487C6;
	Tue,  4 Jun 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="vVi27sCh"
X-Original-To: stable@vger.kernel.org
Received: from sequoia-grove.ad.secure-endpoints.com (sequoia-grove.ad.secure-endpoints.com [208.125.0.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6F148305
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516221; cv=none; b=eoo1tPvezZU9jn06q7Myw1wdCqxqwEaDAboVP77i9arbPiRYwyFMoDbdULLYN6DSYqTBUkb4GJOjqMz5aube56dAcmFSmHRW0EwpflmETKSYC9+2DFsR+MqVYIPuZQplDsGCSZGTLLgfY6XQjNflSo+IT87CxC8mgFuhv/768+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516221; c=relaxed/simple;
	bh=eTS3qggKfNXIcZS3HhPFTZ3CZLn2MtRFMbTLGi23A9o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=T24mjUvQXhQBTumqQ2a8zOOjqSlBHMdC7MN0omsK4myAmwbV7JICg9y0tRRfZ4o4y6Ct+XhqpmgAAuCCyAiKThE/6tLS7apqvegRT4B7upQOpCqpziJ59D+VEI8M+caR5viFmrFJoxlWZVbNd+sTeM9nvYzBoScrsIEjH94NoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=vVi27sCh; arc=none smtp.client-ip=208.125.0.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
	d=auristor.com; s=MDaemon; r=y; t=1717516211; x=1718121011;
	i=jaltman@auristor.com; q=dns/txt; h=Message-ID:Date:
	MIME-Version:User-Agent:From:Subject:To:Content-Language:Cc:
	Organization:Content-Type; bh=eTS3qggKfNXIcZS3HhPFTZ3CZLn2MtRFMb
	TLGi23A9o=; b=vVi27sCh55c4GugIpFpOM1+yDU4D4S8/bMtZte3hysYLJaU/+9
	sweIRb5yG0XQV7X8TeKn31QTB65hhPf5ZdU+HziPkSv0foNxQ/A5li8yiQI2jRKE
	4/ox3Qgi1OlFdtH9ejWurJCl1LReMBkx4ODzfJqxR1sXpw6Qb5pf26dRw=
X-MDAV-Result: clean
X-MDAV-Processed: sequoia-grove.ad.secure-endpoints.com, Tue, 04 Jun 2024 11:50:11 -0400
Received: from [IPV6:2603:7000:73c:bb00:c087:9c97:5161:1e05] by auristor.com (IPv6:2001:470:1f07:f77:28d9:68fb:855d:c2a5) (MDaemon PRO v24.0.0) 
	with ESMTPSA id md5001003966242.msg; Tue, 04 Jun 2024 11:50:10 -0400
X-Spam-Processed: sequoia-grove.ad.secure-endpoints.com, Tue, 04 Jun 2024 11:50:10 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 2603:7000:73c:bb00:c087:9c97:5161:1e05
X-MDHelo: [IPV6:2603:7000:73c:bb00:c087:9c97:5161:1e05]
X-MDArrival-Date: Tue, 04 Jun 2024 11:50:10 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=18857024df=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Message-ID: <2f3691b1-4f19-4a21-b235-a46ae54b8424@auristor.com>
Date: Tue, 4 Jun 2024 11:50:06 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeffrey E Altman <jaltman@auristor.com>
Subject: Backport request: commit 29be9100aca2915fab54b5693309bc42956542e5
 ("afs: Don't cross .backup mountpoint from backup volume")
To: linux-stable <stable@vger.kernel.org>
Content-Language: en-US
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Organization: AuriStor, Inc.
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000009010305020908030208"
X-MDCFSigsAdded: auristor.com

This is a cryptographically signed message in MIME format.

--------------ms000009010305020908030208
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGxlYXNlIGJhY2twb3J0IHRvIHRoZSBmb2xsb3dpbmcgcGF0Y2ggd2hpY2ggd2FzIG1lcmdl
ZCB1cHN0cmVhbS4NCg0KSXQgc2hvdWxkIGFwcGx5IHRvIGxpbnV4LTUuNC55IGFuZCBsYXRl
ci4NCg0KY29tbWl0IDI5YmU5MTAwYWNhMjkxNWZhYjU0YjU2OTMzMDliYzQyOTU2NTQyZTUN
CkF1dGhvcjogTWFyYyBEaW9ubmUgPG1hcmMuZGlvbm5lQGF1cmlzdG9yLmNvbT4xDQpEYXRl
OsKgwqAgRnJpIE1heSAyNCAxNzoxNzo1NSAyMDI0ICswMTAwDQoNCiDCoMKgwqAgYWZzOiBE
b24ndCBjcm9zcyAuYmFja3VwIG1vdW50cG9pbnQgZnJvbSBiYWNrdXAgdm9sdW1lDQoNCiDC
oMKgwqAgRG9uJ3QgY3Jvc3MgYSBtb3VudHBvaW50IHRoYXQgZXhwbGljaXRseSBzcGVjaWZp
ZXMgYSBiYWNrdXAgdm9sdW1lDQogwqDCoMKgICh0YXJnZXQgaXMgPHZvbD4uYmFja3VwKSB3
aGVuIHN0YXJ0aW5nIGZyb20gYSBiYWNrdXAgdm9sdW1lLg0KDQogwqDCoMKgIEl0IGl0IG5v
dCB1bmNvbW1vbiB0byBtb3VudCBhIHZvbHVtZSdzIGJhY2t1cCBkaXJlY3RseSBpbiB0aGUg
dm9sdW1lDQogwqDCoMKgIGl0c2VsZi7CoCBUaGlzIGNhbiBjYXVzZSB0b29scyB0aGF0IGFy
ZSBub3QgcGF5aW5nIGF0dGVudGlvbiB0byBnZXQNCiDCoMKgwqAgaW50byBhIGxvb3AgbW91
bnRpbmcgdGhlIHZvbHVtZSBvbnRvIGl0c2VsZiBhcyB0aGV5IGF0dGVtcHQgdG8NCiDCoMKg
wqAgdHJhdmVyc2UgdGhlIHRyZWUsIGxlYWRpbmcgdG8gYSB2YXJpZXR5IG9mIHByb2JsZW1z
Lg0KDQogwqDCoMKgIFRoaXMgZG9lc24ndCBwcmV2ZW50IHRoZSBnZW5lcmFsIGNhc2Ugb2Yg
bG9vcHMgaW4gYSBzZXF1ZW5jZSBvZg0KIMKgwqDCoCBtb3VudHBvaW50cywgYnV0IGFkZHJl
c3NlcyBhIGNvbW1vbiBzcGVjaWFsIGNhc2UgaW4gdGhlIHNhbWUgd2F5DQogwqDCoMKgIGFz
IG90aGVyIGFmcyBjbGllbnRzLg0KDQogwqDCoMKgIFJlcG9ydGVkLWJ5OiBKYW4gSGVucmlr
IFN5bHZlc3RlciA8amFuLmhlbnJpay5zeWx2ZXN0ZXJAdW5pLWhhbWJ1cmcuZGU+DQogwqDC
oMKgIExpbms6IA0KaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4
LWFmcy8yMDI0LU1heS8wMDg0NTQuaHRtbA0KIMKgwqDCoCBSZXBvcnRlZC1ieTogTWFya3Vz
IFN1dmFudG8gPG1hcmt1cy5zdXZhbnRvQGdtYWlsLmNvbT4NCiDCoMKgwqAgTGluazogDQpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtYWZzLzIwMjQtRmVi
cnVhcnkvMDA4MDc0Lmh0bWwNCiDCoMKgwqAgU2lnbmVkLW9mZi1ieTogTWFyYyBEaW9ubmUg
PG1hcmMuZGlvbm5lQGF1cmlzdG9yLmNvbT4NCiDCoMKgwqAgU2lnbmVkLW9mZi1ieTogRGF2
aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4NCiDCoMKgwqAgTGluazogDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzc2ODc2MC4xNzE2NTY3NDc1QHdhcnRob2cucHJvY3lv
bi5vcmcudWsNCiDCoMKgwqAgUmV2aWV3ZWQtYnk6IEplZmZyZXkgQWx0bWFuIDxqYWx0bWFu
QGF1cmlzdG9yLmNvbT4NCiDCoMKgwqAgY2M6IGxpbnV4LWFmc0BsaXN0cy5pbmZyYWRlYWQu
b3JnDQogwqDCoMKgIFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVy
QGtlcm5lbC5vcmc+DQoNClRoYW5rIHlvdS4NCg0KSmVmZnJleSBBbHRtYW4NCg0KDQoNCg==


--------------ms000009010305020908030208
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DHEwggXSMIIEuqADAgECAhBAAYJpmi/rPn/F0fJyDlzMMA0GCSqGSIb3DQEBCwUAMDoxCzAJ
BgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEz
MB4XDTIyMDgwNDE2MDQ0OFoXDTI1MTAzMTE2MDM0OFowcDEvMC0GCgmSJomT8ixkAQETH0Ew
MTQxMEQwMDAwMDE4MjY5OUEyRkQyMDAwMjMzQ0QxGTAXBgNVBAMTEEplZmZyZXkgRSBBbHRt
YW4xFTATBgNVBAoTDEF1cmlTdG9yIEluYzELMAkGA1UEBhMCVVMwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQCkC7PKBBZnQqDKPtZPMLAy77zo2DPvwtGnd1hNjPvbXrpGxUb3
xHZRtv179LHKAOcsY2jIctzieMxf82OMyhpBziMPsFAG/ukihBMFj3/xEeZVso3K27pSAyyN
fO/wJ0rX7G+ges22Dd7goZul8rPaTJBIxbZDuaykJMGpNq4PQ8VPcnYZx+6b+nJwJJoJ46kI
EEfNh3UKvB/vM0qtxS690iAdgmQIhTl+qfXq4IxWB6b+3NeQxgR6KLU4P7v88/tvJTpxIKkg
9xj89ruzeThyRFd2DSe3vfdnq9+g4qJSHRXyTft6W3Lkp7UWTM4kMqOcc4VSRdufVKBQNXjG
IcnhAgMBAAGjggKcMIICmDAOBgNVHQ8BAf8EBAMCBPAwgYQGCCsGAQUFBwEBBHgwdjAwBggr
BgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVudHJ1c3QuY29tMEIGCCsGAQUF
BzAChjZodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NlcnRzL3RydXN0aWRjYWEx
My5wN2MwHwYDVR0jBBgwFoAULbfeG1l+KpguzeHUG+PFEBJe6RQwCQYDVR0TBAIwADCCASsG
A1UdIASCASIwggEeMIIBGgYLYIZIAYb5LwAGAgEwggEJMEoGCCsGAQUFBwIBFj5odHRwczov
L3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRpZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRt
bDCBugYIKwYBBQUHAgIwga0MgapUaGlzIFRydXN0SUQgQ2VydGlmaWNhdGUgaGFzIGJlZW4g
aXNzdWVkIGluIGFjY29yZGFuY2Ugd2l0aCBJZGVuVHJ1c3QncyBUcnVzdElEIENlcnRpZmlj
YXRlIFBvbGljeSBmb3VuZCBhdCBodHRwczovL3NlY3VyZS5pZGVudHJ1c3QuY29tL2NlcnRp
ZmljYXRlcy9wb2xpY3kvdHMvaW5kZXguaHRtbDBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8v
dmFsaWRhdGlvbi5pZGVudHJ1c3QuY29tL2NybC90cnVzdGlkY2FhMTMuY3JsMB8GA1UdEQQY
MBaBFGphbHRtYW5AYXVyaXN0b3IuY29tMB0GA1UdDgQWBBQB+nzqgljLocLTsiUn2yWqEc2s
gjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAJwV
eycprp8Ox1npiTyfwc5QaVaqtoe8Dcg2JXZc0h4DmYGW2rRLHp8YL43snEV93rPJVk6B2v4c
WLeQfaMrnyNeEuvHx/2CT44cdLtaEk5zyqo3GYJYlLcRVz6EcSGHv1qPXgDT0xB/25etwGYq
utYF4Chkxu4KzIpq90eDMw5ajkexw+8ARQz4N5+d6NRbmMCovd7wTGi8th/BZvz8hgKUiUJo
Qle4wDxrdXdnIhCP7g87InXKefWgZBF4VX21t2+hkc04qrhIJlHrocPG9mRSnnk2WpsY0MXt
a8ivbVKtfpY7uSNDZSKTDi1izEFH5oeQdYRkgIGb319a7FjslV8wggaXMIIEf6ADAgECAhBA
AXA7OrqBjMk8rp4OuNQSMA0GCSqGSIb3DQEBCwUAMEoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxJzAlBgNVBAMTHklkZW5UcnVzdCBDb21tZXJjaWFsIFJvb3QgQ0EgMTAe
Fw0yMDAyMTIyMTA3NDlaFw0zMDAyMTIyMTA3NDlaMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQK
EwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTEzMIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAu6sUO01SDD99PM+QdZkNxKxJNt0NgQE+Zt6ixaNP0JKSjTd+SG5L
wqxBWjnOgI/3dlwgtSNeN77AgSs+rA4bK4GJ75cUZZANUXRKw/et8pf9Qn6iqgB63OdHxBN/
15KbM3HR+PyiHXQoUVIevCKW8nnlWnnZabT1FejOhRRKVUg5HACGOTfnCOONrlxlg+m1Vjgn
o1uNqNuLM/jkD1z6phNZ/G9IfZGI0ppHX5AA/bViWceX248VmefNhSR14ADZJtlAAWOi2un0
3bqrBPHA9nDyXxI8rgWLfUP5rDy8jx2hEItg95+ORF5wfkGUq787HBjspE86CcaduLka/Bk2
VwIDAQABo4IChzCCAoMwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwgYkG
CCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2NzcC5pZGVu
dHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3QuY29t
L3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djCCASQGA1UdIASCARswggEXMIIBEwYEVR0gADCCAQkwSgYIKwYBBQUHAgEWPmh0
dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20vY2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRl
eC5odG1sMIG6BggrBgEFBQcCAjCBrQyBqlRoaXMgVHJ1c3RJRCBDZXJ0aWZpY2F0ZSBoYXMg
YmVlbiBpc3N1ZWQgaW4gYWNjb3JkYW5jZSB3aXRoIElkZW5UcnVzdCdzIFRydXN0SUQgQ2Vy
dGlmaWNhdGUgUG9saWN5IGZvdW5kIGF0IGh0dHBzOi8vc2VjdXJlLmlkZW50cnVzdC5jb20v
Y2VydGlmaWNhdGVzL3BvbGljeS90cy9pbmRleC5odG1sMEoGA1UdHwRDMEEwP6A9oDuGOWh0
dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY3JsL2NvbW1lcmNpYWxyb290Y2ExLmNy
bDAdBgNVHQ4EFgQULbfeG1l+KpguzeHUG+PFEBJe6RQwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4ICAQB/7BKcygLX6Nl4a03cDHt7TLdPxCzFvDF2
bkVYCFTRX47UfeomF1gBPFDee3H/IPlLRmuTPoNt0qjdpfQzmDWN95jUXLdLPRToNxyaoB5s
0hOhcV6H08u3FHACBif55i0DTDzVSaBv0AZ9h1XeuGx4Fih1Vm3Xxz24GBqqVudvPRLyMJ7u
6hvBqTIKJ53uCs3dyQLZT9DXnp+kJv8y7ZSAY+QVrI/dysT8avtn8d7k7azNBkfnbRq+0e88
QoBnel6u+fpwbd5NLRHywXeH+phbzULCa+bLPRMqJaW2lbhvSWrMHRDy3/d8HvgnLCBFK2s4
Spns4YCN4xVcbqlGWzgolHCKUH39vpcsDo1ymZFrJ8QR6ihIn8FmJ5oKwAnnd/G6ADXFC9bu
db9+532phSAXOZrrecIQn+vtP366PC+aClAPsIIDJDsotS5z4X2JUFsNIuEgXGqhiKE7SuZb
rFG9sdcLprSlJN7TsRDc0W2b9nqwD+rj/5MN0C+eKwha+8ydv0+qzTyxPP90KRgaegGowC4d
UsZyTk2n4Z3MuAHX5nAZL/Vh/SyDj/ajorV44yqZBzQ3ChKhXbfUSwe2xMmygA2Z5DRwMRJn
p/BscizYdNk2WXJMTnH+wVLN8sLEwEtQR4eTLoFmQvrK2AMBS9kW5sBkMzINt/ZbbcZ3F+eA
MDGCAxQwggMQAgEBME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUG
A1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwDQYJYIZIAWUDBAIBBQCg
ggGXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYwNDE1
NTAwNlowLwYJKoZIhvcNAQkEMSIEICL/KHOSzn3Nh14QOeDxWuiKUc4gi/+PwqKnYwlwsDLr
MF0GCSsGAQQBgjcQBDFQME4wOjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEX
MBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTMCEEABgmmaL+s+f8XR8nIOXMwwXwYLKoZIhvcNAQkQ
AgsxUKBOMDoxCzAJBgNVBAYTAlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRy
dXN0SUQgQ0EgQTEzAhBAAYJpmi/rPn/F0fJyDlzMMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAWXA+
bR0YfQnMoqQea0LpLNf5zd3Toe5COoPJmWJFR7ISpD/RRncwu1PnHA4BiEoGuzyV5GkAAEip
4W36UX1qAyi7mT2L3+0ENqHKOaKuLA3EMf2xI4rQi7V4yYbTjFnoS2IMYIfJSfrKQlLbu8or
i/P+hpSw3Qjcg5/rDvGaDXiifQeX9PMfCSMn5iT75kk17/HU/ZXWtSOdZtIA3E4P/7Wt+Crb
fSQVKQapfGY3apHPDV7uyxvDyyOgzGT+UGyoNDDOTf0oel+tXYPUvQDgHOOgwe0tJb6nm7CU
rMEs0mCe/YX16zj8xS/Di0zH/bapWc5bA/Buo9bruhYO47+5gAAAAAAAAA==
--------------ms000009010305020908030208--



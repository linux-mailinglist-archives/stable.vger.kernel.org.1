Return-Path: <stable+bounces-245072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J/VIJ3vAGqGOgEAu9opvQ
	(envelope-from <stable+bounces-245072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:50:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB65065BF
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5866C3001A73
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F93043CE;
	Sun, 10 May 2026 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b="c6k8arbw"
X-Original-To: stable@vger.kernel.org
Received: from monticello.secure-endpoints.com (monticello.secure-endpoints.com [208.125.0.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF54629A9E9
	for <stable@vger.kernel.org>; Sun, 10 May 2026 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.125.0.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446230; cv=none; b=oF8OhkA9OBAKrZYh8G2hWZ69Kut7UEh4Rq1klbalUG1J87uL/uHxqWf+oy6HHBSpqG77WDFk8MyHLtB7rDUReLR1F3Op0Fq4csSU9XrvHQdMYXinFbCaZDdZcXFIBV7IxkTYAyUzKiOdt2UFFk2isubaH0kWiSpOJDa6oF1nTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446230; c=relaxed/simple;
	bh=jxG/pcnlY6qAn1xeNiE3WFJFwffgCo5ebHQPXE0TCtU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nV6nkZzXWa8GSyg0qknzXJvPa+/4IkWuyrEo9wo70cq2pIEcAH4GVDZ9+J1djkCL2AeVJp0OFOLVFgvzgrrY7M/dOT9ACjv2rfIXqA4E6juIw0Iuprf/8ghEPu1Rpqtd/66KCXCk96H8YHTOquoh8TiDUYKbsUkNy+KO2mZecQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=auristor.com; dkim=pass (1024-bit key) header.d=auristor.com header.i=jaltman@auristor.com header.b=c6k8arbw; arc=none smtp.client-ip=208.125.0.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auristor.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=auristor.com; s=MDaemon; r=y; l=7161; t=1778446185;
	x=1779050985; i=jaltman@auristor.com; q=dns/txt; h=Content-Type:
	Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	Content-Transfer-Encoding:Message-Id:References:To; z=Received:=
	20from=20smtpclient.apple=20([23.162.8.100])=20by=20auristor.com
	=20(208.125.0.237)=20(MDaemon=20PRO=20v26.0.2b)=20=0D=0A=09with=
	20ESMTPSA=20id=20md5001005260991.msg=3B=20Sun,=2010=20May=202026
	=2016=3A49=3A44=20-0400|Content-Type:=20multipart/signed=3B=0D=0
	A=09boundary=3D"Apple-Mail=3D_6209B801-2933-43DF-8A0E-3AE7F89458
	B1"=3B=0D=0A=09protocol=3D"application/pkcs7-signature"=3B=0D=0A
	=09micalg=3Dsha-256|Mime-Version:=201.0=20(Mac=20OS=20X=20Mail=2
	016.0=20\(3826.700.81.1.6\))|Subject:=20Re=3A=20Backport=20RXRPC
	=20for=206.1.y=20from=206.2|From:=20Jeffrey=20Altman=20<jaltman@
	auristor.com>|In-Reply-To:=20<20260510202156.273826-1-guanwentao
	@uniontech.com>|Date:=20Sun,=2010=20May=202026=2016=3A50=3A10=20
	-0400|Cc:=20David=20Howells=20<dhowells@redhat.com>,=0D=0A=20gre
	gkh@linuxfoundation.org,=0D=0A=20horms@kernel.org,=0D=0A=20kuba@
	kernel.org,=0D=0A=20linux-afs@lists.infradead.org,=0D=0A=20marc.
	dionne@auristor.com,=0D=0A=20sashal@kernel.org,=0D=0A=20stable@k
	ernel.org,=0D=0A=20stable@vger.kernel.org|Content-Transfer-Encod
	ing:=20quoted-printable|Message-Id:=20<DA1B1E18-0F4E-4399-84AE-7
	5EFD88713DE@auristor.com>|References:=20<379c4dcb-11ac-43fc-a539
	-6cb5de9eef3a@auristor.com>=0D=0A=20<20260510202156.273826-1-gua
	nwentao@uniontech.com>|To:=20Wentao=20Guan=20<guanwentao@unionte
	ch.com>; bh=ubYa1lL31u+rNQZy3m5jKFoAviyVuSqn9LgQvN0tU2M=; b=c6k8
	arbwV/JLpWtxqwXbghMCtoKXNtwF+obAtUHPXYCdIQAautYqZXN4m23zzSxNVOAF
	Ygqt1XD436wWkLKsQDebbnw0SfGO7LYfeiVahSIghqK60Vkhp7PuHLXwCi+C5rVs
	/+k+FIBSFuuwkfSSSoO0cxbTuqTQ8JpkL+/N6Qc=
X-MDAV-Result: clean
X-MDAV-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 16:49:45 -0400
Received: from smtpclient.apple ([23.162.8.100]) by auristor.com (208.125.0.237) (MDaemon PRO v26.0.2b) 
	with ESMTPSA id md5001005260991.msg; Sun, 10 May 2026 16:49:44 -0400
X-Spam-Processed: monticello.secure-endpoints.com, Sun, 10 May 2026 16:49:44 -0400
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 23.162.8.100
X-MDHelo: smtpclient.apple
X-MDArrival-Date: Sun, 10 May 2026 16:49:44 -0400
X-MDOrigin-Country: US, NA
X-Authenticated-Sender: jaltman@auristor.com
X-Return-Path: prvs=1590908687=jaltman@auristor.com
X-Envelope-From: jaltman@auristor.com
X-MDaemon-Deliver-To: stable@vger.kernel.org
Content-Type: multipart/signed;
	boundary="Apple-Mail=_6209B801-2933-43DF-8A0E-3AE7F89458B1";
	protocol="application/pkcs7-signature";
	micalg=sha-256
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.6\))
Subject: Re: Backport RXRPC for 6.1.y from 6.2
From: Jeffrey Altman <jaltman@auristor.com>
In-Reply-To: <20260510202156.273826-1-guanwentao@uniontech.com>
Date: Sun, 10 May 2026 16:50:10 -0400
Cc: David Howells <dhowells@redhat.com>,
 gregkh@linuxfoundation.org,
 horms@kernel.org,
 kuba@kernel.org,
 linux-afs@lists.infradead.org,
 marc.dionne@auristor.com,
 sashal@kernel.org,
 stable@kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA1B1E18-0F4E-4399-84AE-75EFD88713DE@auristor.com>
References: <379c4dcb-11ac-43fc-a539-6cb5de9eef3a@auristor.com>
 <20260510202156.273826-1-guanwentao@uniontech.com>
To: Wentao Guan <guanwentao@uniontech.com>
X-Mailer: Apple Mail (2.3826.700.81.1.6)
X-MDCFSigsAdded: auristor.com
X-Rspamd-Queue-Id: 57EB65065BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auristor.com,quarantine];
	R_DKIM_ALLOW(-0.20)[auristor.com:s=MDaemon];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245072-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_X_AS(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[auristor.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaltman@auristor.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

--Apple-Mail=_6209B801-2933-43DF-8A0E-3AE7F89458B1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On May 10, 2026, at 4:21=E2=80=AFPM, Wentao Guan =
<guanwentao@uniontech.com> wrote:
>=20
>> Back porting many years of RXRPC feature changes to fix this=20
>> vulnerability if present
>> feels like the wrong thing to do.   If the vulnerability is present, =
we
> I confirmed v6.1.70 is vulnerable with the poc, v6.1.172 not ok, I am =
doing
> some bisects to figure out which version vulnerable or just fix poc.
> FYI,[PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when =
paged frags are present
> ... Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than =
skb_cow_data()")
> is in v5.3-rc7...:(, so it will affect 5.10.y 5.15.y 6.1.y than =
someone says >6.5 ver:(.
>> can try to find a
>=20
>> branch specific fix.
> I am glad to see it:).=20
>=20
> BRs
> Wentao Guan

v6.1.171 contains 5d55c7336f8032d434adcc5fab987ccc93a44aec
("xfrm: esp: avoid in-place decrypt on shared skb frags=E2=80=9D) which =
prevents the esp4/esp6 variant.

If the POC fails with v6.1.171 then the RXRPC path is not vulnerable.

Thank you for your continued testing.

Jeffrey Altman


--Apple-Mail=_6209B801-2933-43DF-8A0E-3AE7F89458B1
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDTAw
ggY0MIIEHKADAgECAhBAAZimBAJ19t4m6OTgn3OxMA0GCSqGSIb3DQEBCwUAMDoxCzAJBgNVBAYT
AlVTMRIwEAYDVQQKEwlJZGVuVHJ1c3QxFzAVBgNVBAMTDlRydXN0SUQgQ0EgQTE0MB4XDTI1MDgx
NDAwMzg1N1oXDTI3MTEwMTAwMzc1N1owgcwxKDAmBgNVBAUTH0EwMTQxMEMwMDAwMDE5OEE2MDQw
MjY3MDAxMEYyNjIxGTAXBgNVBGETEE5UUlVTK05ZLTM1ODIyMzcxFTATBgNVBAoTDEF1cmlTdG9y
IEluYzEZMBcGA1UEAxMQSmVmZnJleSBFIEFsdG1hbjEPMA0GA1UEBBMGQWx0bWFuMRAwDgYDVQQq
EwdKZWZmcmV5MSMwIQYJKoZIhvcNAQkBFhRqYWx0bWFuQGF1cmlzdG9yLmNvbTELMAkGA1UEBhMC
VVMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDKtXD1tqgXxlJvgI10FM0ZvyWukq2I
eXgVhbgOk4k4PbRk1TvrGB04QatXac9soW7yHv6RhoovQ+URaXBEpBYxOE8Tsx+XfKZNkGbWj9bE
dWgi8HPb33rf8eKFuhjx1QEv/YtD7lGIp7RhKWC5kBfvyut8o3XJmJF0hCR1m663wsttrn89dwZc
zLU4JUjbTF0ukM0DbDk55ItDB4dXnW/uRfhrVuemMvbDily+etLCWsuJjtrjRBCQ805eYRHq5Lon
X3oNLdXituSHXLKvq+uChgFN/veDHKpeBnBWmoNtOQnV8fsq5NCz/WswIACeZj+xGmZsWx7fyuze
e78ZePfBAgMBAAGjggGhMIIBnTAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQEAwIE8DCBhAYIKwYB
BQUHAQEEeDB2MDAGCCsGAQUFBzABhiRodHRwOi8vY29tbWVyY2lhbC5vY3NwLmlkZW50cnVzdC5j
b20wQgYIKwYBBQUHMAKGNmh0dHA6Ly92YWxpZGF0aW9uLmlkZW50cnVzdC5jb20vY2VydHMvdHJ1
c3RpZGNhYTE0LnA3YzAfBgNVHSMEGDAWgBTC1ESZoHHPSFa+DI5oOFynt/dFvDAjBgNVHSAEHDAa
MAkGB2eBDAEFAwIwDQYLYIZIAYb5LwAGAgEwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL3ZhbGlk
YXRpb24uaWRlbnRydXN0LmNvbS9jcmwvdHJ1c3RpZGNhYTE0LmNybDAfBgNVHREEGDAWgRRqYWx0
bWFuQGF1cmlzdG9yLmNvbTAdBgNVHQ4EFgQUY4JHedU4owyskKPvw4gOjSyBJZUwKQYDVR0lBCIw
IAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3CgMMMA0GCSqGSIb3DQEBCwUAA4ICAQCeOjCs
cMFctL6UG8WBsFMIOHc7MpbrX7EIvO34SGVKhrbqS1RTIBQiVVWnQ4VI6qVw/n9dadUv4o1/F23s
0uXE8/lGJAGn51kkw1xHU+0PGODOTWvAQOiPhSmaXG5xM4BgleroGggumd8fHRSKFK7DIdWcMMNb
S6LpMAOUfXYzNBvcHbAcjJMHQ7N8pNXdEQDB9c6yIw4paVD6XDE5VFhLdf6749jGqSWXpyTMjXzr
PMaDyxKiNOtsUrdT/fh8+Xx84nGpwiV9PA9/cGSAPcAc/qMBgPb4Qj9met/RUvCHPWr68Zlirgx4
8W/7TTZFhXKZg3U+zCj4ASOfLJ6WT4PPoM+eLHbB402WNMFkQDmWBH4bMqUcbQWxarMxdQ/jHKTs
JIkvg+rTCbWbDm7hgJbnPEZrJEghy69Opa9+F1HB90AQmb41N1PLZytu8pCGBJufyqjzNU0eyWkH
JCwHDLFhoCENk/vujFCmsJUSh7a6ZMPSXf3PR4TPKkcgs9JBT0dyPGHEfC/Lp9ZHTGSO6zswK1Bd
dBufYi3xqHNBO/s7ft6gpNvht7oKUhVcjM7EmQCA6t2ok44PNfeG8rJZxiDv04IruCbzLFwkPczW
S5uCIuP3PWCfVtMnUPDamMVWAr4Ui/s6fy3TZbPUAPDjFRi7zpkFIKHlCS/HIHNR6Gr1lzCCBvQw
ggTcoAMCAQICEEABif/SaQvad8Lp1U2SCE0wDQYJKoZIhvcNAQELBQAwSjELMAkGA1UEBhMCVVMx
EjAQBgNVBAoTCUlkZW5UcnVzdDEnMCUGA1UEAxMeSWRlblRydXN0IENvbW1lcmNpYWwgUm9vdCBD
QSAxMB4XDTIzMDgxNjE5Mjg0NloXDTMzMDgxMjE5Mjg0NVowOjELMAkGA1UEBhMCVVMxEjAQBgNV
BAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBBMTQwggIiMA0GCSqGSIb3DQEBAQUA
A4ICDwAwggIKAoICAQDoqfW8senk2X/L7Viky0ZgZYnwlxqsE/vDQWARa1i7gZ0wRJ7ZOWIbjYDc
csGFBhCb8VLx1dershozyPcOizZ1LxAhstZhpz8KvKc4bHhu1+6ZJftmrDyAELLRu1gkPS0Bvong
GBinxoTNo0XwafmS67jFRtYHe2VQSLvy0t9xRUsgdEeYgCUAnKO5eRVQMmBBNhnsTFtO5FzNmNKn
uw/TDcBbOpGrQ1FSCuOZTHw3njDtZGqiRXSruX3MCpV190CefwryeGLXCsawSz2wMQZkqtjYV9Au
73Zrqg1yDVj9KGKoRnJ8cUcg1Inxs/+Bo3xcM43y2h10yDrSWFTfvPSQhUJwYKHCYJSVQLFbeH9v
xFJeLlewivaKQMGEg8PpnjevzDu8PVVzr9gkWcLubhztussqdAPF+dvyXIYJb/7l6idZkS4NeHAs
rAtcv+UF+SGzSS5F28s376Kx35LUaJeOW4hQOjSj/118F9cyYAd2WlgGdBdaK2PSvH7aANZQfyEh
NNMzk2GP83pHXXeXy+09LkTcIlgXr2rrXepxP+WBp+Ihu4Jh5uZWQkpGUUNqKSjxIpUJ6sDIIgGI
qSY/uBFSp2ff+4OLLS3Z+XQ9gBu1Szd3kQ8PrGXAI5DXayXjM9YppsHld3OojXhoOsLdCji+be0m
AgvbNa6AaSJcT7RF3QIDAQABo4IB5DCCAeAwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8E
BAMCAYYwgYkGCCsGAQUFBwEBBH0wezAwBggrBgEFBQcwAYYkaHR0cDovL2NvbW1lcmNpYWwub2Nz
cC5pZGVudHJ1c3QuY29tMEcGCCsGAQUFBzAChjtodHRwOi8vdmFsaWRhdGlvbi5pZGVudHJ1c3Qu
Y29tL3Jvb3RzL2NvbW1lcmNpYWxyb290Y2ExLnA3YzAfBgNVHSMEGDAWgBTtRBnA0/AGi+6ke75C
5yZUyI42djBfBgNVHSAEWDBWMFQGBFUdIAAwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9zZWN1cmUu
aWRlbnRydXN0LmNvbS9jZXJ0aWZpY2F0ZXMvcG9saWN5L3RzL2luZGV4Lmh0bWwwSgYDVR0fBEMw
QTA/oD2gO4Y5aHR0cDovL3ZhbGlkYXRpb24uaWRlbnRydXN0LmNvbS9jcmwvY29tbWVyY2lhbHJv
b3RjYTEuY3JsMB0GA1UdDgQWBBTC1ESZoHHPSFa+DI5oOFynt/dFvDBBBgNVHSUEOjA4BggrBgEF
BQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwwGCisGAQQBgjcUAgIGCisGAQQBgjcKAwQwDQYJKoZI
hvcNAQELBQADggIBAJXyFF1baV3jUq5o3Q5FIysADRg5knGSFzcliSyYTBd5YZ4FYFZSDxrQ25J8
7EFzq8q9a1lQxNwcj2R3IFNfx5QWU6EApuGwiOgX9igx3EAJuOa8JnSoLUI5zKflmNqTVHSz3b94
UQy/MF+s8+OwbM8+FscUY0CxXRlOEETsW6MFXfliOSIEnQFmm5NraqzYHecXC8DJF6yTxbu1+101
T66oqkp9+EAvU+SXgSIcHDpNxAmbm6XcSQFwEZLOLSctCVeZzLsvCE1Ozr5hvEAstYh07Qm/FtuZ
+M540l2qSydFaI4yD7uH6/SsjQAARQXYzezBauwR8YOTS7PUDWejFUpHzPy4q2JdYdU2jYTst4G7
gW0+y6EQyXIiSEEaKePUrnIiRImK6ySZXDTB7A+td6giMATY61GcJUS9kdCHZ4brFJiLBg9az11c
15e5SbS2bCNAMOIK6NwakjsWmh2jX+C6LJX37ehqQT0GVekYT4nGMBH89MiQ1kFnIQcIWTagA/Qq
FHMhHFlUH5mWyby/6alKXu0ZeODdBRR/Tn39K6awTCVSbQH8P+KbF5kMky9b7IFzJI/fwxr/ZVoE
KCj0aoicm2TTsXgqRUI7MgiLU6hE5ersxFh5yM2IBc8za+kvkB7SeXPhzloFqmayuM2QfrqjsX1F
0CopS11iOE4QVaJmMYICpjCCAqICAQEwTjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRy
dXN0MRcwFQYDVQQDEw5UcnVzdElEIENBIEExNAIQQAGYpgQCdfbeJujk4J9zsTANBglghkgBZQME
AgEFAKCCASkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNTEw
MjA1MDExWjAvBgkqhkiG9w0BCQQxIgQgFxbh3PrmBK6E7egDzuCwhYMPLmaOwTAn2+pse3/qad4w
XQYJKwYBBAGCNxAEMVAwTjA6MQswCQYDVQQGEwJVUzESMBAGA1UEChMJSWRlblRydXN0MRcwFQYD
VQQDEw5UcnVzdElEIENBIEExNAIQQAGYpgQCdfbeJujk4J9zsTBfBgsqhkiG9w0BCRACCzFQoE4w
OjELMAkGA1UEBhMCVVMxEjAQBgNVBAoTCUlkZW5UcnVzdDEXMBUGA1UEAxMOVHJ1c3RJRCBDQSBB
MTQCEEABmKYEAnX23ibo5OCfc7EwDQYJKoZIhvcNAQELBQAEggEASCjr98H1rsAP++AbxJ2vSLJV
MPIl5Wypcd9x3VEjB64pLnNdjHogx4icJBy2u97bLrTRrZ+G+qGr5EdEaMg42DYFR7/Sf6NbChrU
rjgGkfjycicXMad09gBtllLCh4x0INt9Bb6qpWROEcNGEXmIjmcmG5rA2NeyGs5yztQDuAk2rMbK
kfwQIn0CCPvcAcB0oBrEzmvwHv5Twy2TKqO34ZPmPb/sEsxsrQ1rpnMRCVoqG61PkaCoVIqdpl7P
6zgEjDEz2GnM+C9PUnZG08pWrbE951A2J5u2aM+5dkyYL4aiKn0hIJno6Sbu7eQudwTZctuW4MNV
e6us3GgCDSGs2QAAAAAAAA==
--Apple-Mail=_6209B801-2933-43DF-8A0E-3AE7F89458B1--



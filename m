Return-Path: <stable+bounces-114217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6070FA2BED7
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6564316474C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D12343A5;
	Fri,  7 Feb 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QJ4Ywlhj"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2111D5AB7;
	Fri,  7 Feb 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919457; cv=none; b=YdsYn9768ewqjOYDLsix9uw/8Nnqz8iWjhOFx+MRSCZIesDj5jvTKZK6EAM9xXJaLh84BvrIQoB8EM+SJNrrDXXJ0kzoId8qjhftLhw/f8F0uT7I2bgxZeGoBTYXnVLelXttvH28nAcTUjgq/wz425wJf0cbUk263HKq2krVM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919457; c=relaxed/simple;
	bh=AcErauE77c/NUDzovh3m9nYQGCAsEDs10l8p9ijIruc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArZ4bWSzBwKWCcZSlRqfn6Z+m/k0d9aodHhFRqB5GOX21c/eQvg0M2uyMmWJ7gb+pkmCcAVWg2CzrQBQ9uxNEuIwCudjgxTa6SrcRgSlOGt5huNeHuFPl30NKfpMX8+j47W1zg8Sv5Baj9JlQv0HsTwUy0/GhefAD6mT0Zw105s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QJ4Ywlhj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZBtQA2O4D/avJ28iBefQJ/ZbHjQxVdNVZmMhfozuULo=; b=QJ4YwlhjerRVtpiwZ2/bbVOBhR
	0a0IGrMk6UpeACbbQH5gjer3mVatAGfZgANE1xkzFLLNBU40CTqSIPJQ8M/YEP+lETappnbgd17iZ
	1wHHQhaslZs8p4nl2PBJFjs1MiCJVkLjLROXwTaIYfv0Px6l1QGu5phKO5YAz+ufA0oJBRUnFBm+I
	D1XKSrQ8rkqzFn7xkCgOyIF5BC7r20i+spNSAMwb5RaF+Hv1zzSz1S+lH4+LRFvnYNuX98H3kVvgN
	t0G/Xv0PuAORydjcKyfQaE5gyoz4IoivR0wqdNKv8nx6L/rDgnBmyY8rdaaE9zi6l0IZbvF3XewhH
	HNF2Ix9A==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tgKNn-00000007XT4-3Sz5;
	Fri, 07 Feb 2025 09:10:44 +0000
Message-ID: <34d961bf2f40f054dd79cf7d8cf81a3eefd00a59.camel@infradead.org>
Subject: Re: [PATCH net-next 0/4] ptp: vmclock: bugfixes and cleanups for
 error handling
From: David Woodhouse <dwmw2@infradead.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Date: Fri, 07 Feb 2025 09:10:42 +0000
In-Reply-To: <e16551dd-3a84-49ba-b875-c11f77239984@intel.com>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
	 <e16551dd-3a84-49ba-b875-c11f77239984@intel.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-Nk9DwTqCr7e5zhHAokbK"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-Nk9DwTqCr7e5zhHAokbK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-02-07 at 08:13 +0100, Mateusz Polchlopek wrote:
>=20
>=20
> On 2/6/2025 6:45 PM, Thomas Wei=C3=9Fschuh wrote:
> > Some error handling issues I noticed while looking at the code.
> >=20
> > Only compile-tested.
> >=20
> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > ---
> > Thomas Wei=C3=9Fschuh (4):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptp: vmclock: Set driver data befo=
re its usage
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptp: vmclock: Don't unregister mis=
c device if it was not registered
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptp: vmclock: Clean up miscdev and=
 ptp clock through devres
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptp: vmclock: Remove goto-based cl=
eanup logic
> >=20
> > =C2=A0 drivers/ptp/ptp_vmclock.c | 46 ++++++++++++++++++++-------------=
-------------
> > =C2=A0 1 file changed, 20 insertions(+), 26 deletions(-)
> > ---
> > base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> > change-id: 20250206-vmclock-probe-57cbcb770925
> >=20
> > Best regards,
>=20
> As those all are fixes and cleanups then I think it should be tagged to
> net not net-next.

Agreed. Thanks, Thomas. For all four:

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

I'm about to post a fifth which adds a .owner to vmclock_miscdev_fops.

Tested with the existing '-device vmclock' support in QEMU, plus this
hack to actually expose a PTP clock to the guest (which we haven't
worked out how to do *properly* from the timekeeping subsystem of a
Linux host yet; qv).

--- a/hw/acpi/vmclock.c
+++ b/hw/acpi/vmclock.c
@@ -151,6 +151,18 @@ static void vmclock_realize(DeviceState *dev,
Error **errp)
=20
     qemu_register_reset(vmclock_handle_reset, vms);
=20
+	vms->clk->time_type =3D VMCLOCK_TIME_TAI;
+    vms->clk->flags =3D VMCLOCK_FLAG_TAI_OFFSET_VALID;
+    vms->clk->tai_offset_sec =3D -3600;
+    vms->clk->clock_status =3D VMCLOCK_STATUS_SYNCHRONIZED;
+    vms->clk->counter_value =3D 0;
+    vms->clk->counter_id =3D VMCLOCK_COUNTER_X86_TSC;
+    vms->clk->time_sec =3D 1704067200;
+    vms->clk->time_frac_sec =3D 0x8000000000000000ULL;
+    vms->clk->counter_period_frac_sec =3D 0x1a6e39b3e0ULL;
+    vms->clk->counter_period_shift =3D 4;
+    //vms->clk->counter_period_frac_sec =3D 0x1934c67f9b2ce6ULL;
+
     vmclock_update_guest(vms);
 }
=20


--=-Nk9DwTqCr7e5zhHAokbK
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCD9Aw
ggSOMIIDdqADAgECAhAOmiw0ECVD4cWj5DqVrT9PMA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yNDAxMzAwMDAwMDBaFw0zMTEx
MDkyMzU5NTlaMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYDVQQDExdWZXJv
a2V5IFNlY3VyZSBFbWFpbCBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMjvgLKj
jfhCFqxYyRiW8g3cNFAvltDbK5AzcOaR7yVzVGadr4YcCVxjKrEJOgi7WEOH8rUgCNB5cTD8N/Et
GfZI+LGqSv0YtNa54T9D1AWJy08ZKkWvfGGIXN9UFAPMJ6OLLH/UUEgFa+7KlrEvMUupDFGnnR06
aDJAwtycb8yXtILj+TvfhLFhafxroXrflspavejQkEiHjNjtHnwbZ+o43g0/yxjwnarGI3kgcak7
nnI9/8Lqpq79tLHYwLajotwLiGTB71AGN5xK+tzB+D4eN9lXayrjcszgbOv2ZCgzExQUAIt98mre
8EggKs9mwtEuKAhYBIP/0K6WsoMnQCcCAwEAAaOCAVwwggFYMBIGA1UdEwEB/wQIMAYBAf8CAQAw
HQYDVR0OBBYEFIlICOogTndrhuWByNfhjWSEf/xwMB8GA1UdIwQYMBaAFEXroq/0ksuCMS1Ri6en
IZ3zbcgPMA4GA1UdDwEB/wQEAwIBhjAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIweQYI
KwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RD
QS5jcnQwRQYDVR0fBD4wPDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0
QXNzdXJlZElEUm9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQELBQADggEB
ACiagCqvNVxOfSd0uYfJMiZsOEBXAKIR/kpqRp2YCfrP4Tz7fJogYN4fxNAw7iy/bPZcvpVCfe/H
/CCcp3alXL0I8M/rnEnRlv8ItY4MEF+2T/MkdXI3u1vHy3ua8SxBM8eT9LBQokHZxGUX51cE0kwa
uEOZ+PonVIOnMjuLp29kcNOVnzf8DGKiek+cT51FvGRjV6LbaxXOm2P47/aiaXrDD5O0RF5SiPo6
xD1/ClkCETyyEAE5LRJlXtx288R598koyFcwCSXijeVcRvBB1cNOLEbg7RMSw1AGq14fNe2cH1HG
W7xyduY/ydQt6gv5r21mDOQ5SaZSWC/ZRfLDuEYwggWbMIIEg6ADAgECAhAH5JEPagNRXYDiRPdl
c1vgMA0GCSqGSIb3DQEBCwUAMEExCzAJBgNVBAYTAkFVMRAwDgYDVQQKEwdWZXJva2V5MSAwHgYD
VQQDExdWZXJva2V5IFNlY3VyZSBFbWFpbCBHMjAeFw0yNDEyMzAwMDAwMDBaFw0yODAxMDQyMzU5
NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqGSIb3DQEBAQUAA4IC
DwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZeYAS/SRV6zmfXlXaZ
sNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2zkC9S7/yHDYnqegqt
w4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qGpgFdZEk2/c//ZvUN
i12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41vav1RhZJzYan4a1gU0
kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0cvnO8FM6PTqsnSbcc
0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PWPU6zfQTOMZ9uLQRR
ci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXtREF5lLXxp+CJ6KKS
blPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQrlR0gO3lBzuyPPArV
hvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7IqaAovAX0d+f1YjbmC
VsAwjhLmveFjNwIDAQABo4IBsDCCAawwHwYDVR0jBBgwFoAUiUgI6iBOd2uG5YHI1+GNZIR//HAw
HQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3bXcyQGluZnJhZGVh
ZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEBMA4GA1UdDwEB/wQE
AwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwewYDVR0fBHQwcjA3oDWgM4YxaHR0
cDovL2NybDMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDA3oDWgM4YxaHR0
cDovL2NybDQuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNybDB2BggrBgEFBQcB
AQRqMGgwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBABggrBgEFBQcwAoY0
aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL1Zlcm9rZXlTZWN1cmVFbWFpbEcyLmNydDANBgkq
hkiG9w0BAQsFAAOCAQEAQXc4FPiPLRnTDvmOABEzkIumojfZAe5SlnuQoeFUfi+LsWCKiB8Uextv
iBAvboKhLuN6eG/NC6WOzOCppn4mkQxRkOdLNThwMHW0d19jrZFEKtEG/epZ/hw/DdScTuZ2m7im
8ppItAT6GXD3aPhXkXnJpC/zTs85uNSQR64cEcBFjjoQDuSsTeJ5DAWf8EMyhMuD8pcbqx5kRvyt
JPsWBQzv1Dsdv2LDPLNd/JUKhHSgr7nbUr4+aAP2PHTXGcEBh8lTeYea9p4d5k969pe0OHYMV5aL
xERqTagmSetuIwolkAuBCzA9vulg8Y49Nz2zrpUGfKGOD0FMqenYxdJHgDCCBZswggSDoAMCAQIC
EAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQELBQAwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoT
B1Zlcm9rZXkxIDAeBgNVBAMTF1Zlcm9rZXkgU2VjdXJlIEVtYWlsIEcyMB4XDTI0MTIzMDAwMDAw
MFoXDTI4MDEwNDIzNTk1OVowHjEcMBoGA1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJ
KoZIhvcNAQEBBQADggIPADCCAgoCggIBANqWLse95HW2F7FhfH9bugyT/danKmmXrbMnz5GZNAfj
Jl5gBL9JFXrOZ9eVdpmw04Tp6aDxZctFLoEDvSWKi367Q7Sg+ci+fH4KwwfQ8Pi0IpIKx2n5emEg
nbOQL1Lv/IcNiep6Cq3DiyaSpSp/RZf+CAfUNySHS8eWmhLU6jGpSD6hxTpYKye7PmrmvMWwfGEP
WoamAV1kSTb9z/9m9Q2LXa89aKmTxNwnAfD3Ohn9mtU3JukwILRMewn9QRXK7KzM+01h5hkCE4nj
W9q/VGFknNhqfhrWBTSQoE9CSVylASGrjzCgS7XmKy/BaH3/7mOOHQv5g1o3Qj/+cdKnpT0I5Qb1
nRy+c7wUzo9OqydJtxzSP4ZyHA4dELto/a3m/ay1XHcpum1pgTOLgxAfGb/T4dCkwRUstSKLMmpL
g9Y9TrN9BM4xn24tBFFyL5znGG0wQGzOVAM68RBzIQb6Fz758fjsr4yZnPbVsU1+gHEs/puNHrG0
9e1EQXmUtfGn4InoopJuU8p5VGD9S3Ikd4UoBlc7xl5yjtNlQxUeYrRlnUSmdlucCEoTX1n4UmtA
9CuVHSA7eUHO7I88CtWG9bGOU7tLgOZoSEvNqtaL/N7sQbBZK4jZ4Rr/zNTQg1SwYjjLB7u96lDP
sipoCi8BfR35/ViNuYJWwDCOEua94WM3AgMBAAGjggGwMIIBrDAfBgNVHSMEGDAWgBSJSAjqIE53
a4blgcjX4Y1khH/8cDAdBgNVHQ4EFgQUXGIam3Bs59Y60yTmWgfDu6pZQ6cwMAYDVR0RBCkwJ4ET
ZHdtdzJAaW5mcmFkZWFkLm9yZ4EQZGF2aWRAd29vZGhvdS5zZTAUBgNVHSAEDTALMAkGB2eBDAEF
AQEwDgYDVR0PAQH/BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDB7BgNVHR8E
dDByMDegNaAzhjFodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMDegNaAzhjFodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVtYWlsRzIu
Y3JsMHYGCCsGAQUFBwEBBGowaDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEAGCCsGAQUFBzAChjRodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vVmVyb2tleVNlY3VyZUVt
YWlsRzIuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQBBdzgU+I8tGdMO+Y4AETOQi6aiN9kB7lKWe5Ch
4VR+L4uxYIqIHxR7G2+IEC9ugqEu43p4b80LpY7M4KmmfiaRDFGQ50s1OHAwdbR3X2OtkUQq0Qb9
6ln+HD8N1JxO5nabuKbymki0BPoZcPdo+FeRecmkL/NOzzm41JBHrhwRwEWOOhAO5KxN4nkMBZ/w
QzKEy4PylxurHmRG/K0k+xYFDO/UOx2/YsM8s138lQqEdKCvudtSvj5oA/Y8dNcZwQGHyVN5h5r2
nh3mT3r2l7Q4dgxXlovERGpNqCZJ624jCiWQC4ELMD2+6WDxjj03PbOulQZ8oY4PQUyp6djF0keA
MYIDuzCCA7cCAQEwVTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMX
VmVyb2tleSBTZWN1cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJYIZIAWUDBAIBBQCg
ggE3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNzA5MTA0
MlowLwYJKoZIhvcNAQkEMSIEIFfDnRG7XtkOQvar8z9UqJXHTW59yS1/O7jqBFF9Su8rMGQGCSsG
AQQBgjcQBDFXMFUwQTELMAkGA1UEBhMCQVUxEDAOBgNVBAoTB1Zlcm9rZXkxIDAeBgNVBAMTF1Zl
cm9rZXkgU2VjdXJlIEVtYWlsIEcyAhAH5JEPagNRXYDiRPdlc1vgMGYGCyqGSIb3DQEJEAILMVeg
VTBBMQswCQYDVQQGEwJBVTEQMA4GA1UEChMHVmVyb2tleTEgMB4GA1UEAxMXVmVyb2tleSBTZWN1
cmUgRW1haWwgRzICEAfkkQ9qA1FdgOJE92VzW+AwDQYJKoZIhvcNAQEBBQAEggIATJ9h2drXecc5
CH+tX8fcX+r+sFTDykLymnLHpa2HHESvwEaawPwgaVYVKcIWlYw5E5aSwMdE0F/TYmvnr9rUUDI0
qkVlqukxLecc5M2T1sYnRSAtAYLkwSPVgLpdDxqeejYAaZmWdS3roI9N80U9BOuVRUFgm7RSkerE
yrMgL4X3mdeiKRLQkklKHTV34g0fYq7eFajEypx74uHLrL3CxKzObgj4Wgw6+Vvl3fTaH+1kxHbT
gQ6NuSDrpBEKgXnlZhnaz6HFGnOHwk58eCh/3k6vzBn7dnFR9x9cCC9FEoFv1zD06Tjz5TFhtreg
m6/tbmr3HnnQ/uCky7gZo1gqivdLU1ZR0Azt25tUw/TKhpCAGLYpklqtuUIx6HKRUmwGYPjbbBpG
FQ2A/aT6FBruRznCCLypFvP7/AB+thIMu9qwXf38kDrdaqIa4m2+iScek08BWNFq8qRMr5kulkP4
5KYqXiiOzr7041RmoWdRXJqszo15Yi4tOVo238d2PZ0FM0aLP8v2+KCyt33X5uCsxIHHhnJctKVb
DLjTGB+nCDuD51F4B4QAuudUAEWVIahCiwAF5HdKXLmYujgEwmxMIPZ5eHaoPdW+JRVGJTmXU0w0
RtIkxmhFXzBWU+w/shp5UNXwDttDYJJ7itzMZUWMyZt476ZFk2YpULvdU8XLcOcAAAAAAAA=


--=-Nk9DwTqCr7e5zhHAokbK--


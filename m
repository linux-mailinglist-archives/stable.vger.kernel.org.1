Return-Path: <stable+bounces-47693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9498D48E1
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 11:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBDF1C21A1F
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FA6F31E;
	Thu, 30 May 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Sjh4oJJb"
X-Original-To: stable@vger.kernel.org
Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B818396D
	for <stable@vger.kernel.org>; Thu, 30 May 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062450; cv=none; b=CMHGB8RLM0wC2N8wqwkV8Sb6Xcy/CokTsRsL2ED0fgnmRF2owedcbMHkL/tVt4jHhFhj7rNG4lQ5fS0oFUSyjv1H0t5nbxvQSPj48nZHw5YmBWfB4+Dp/BsRHedWID62Lw3sjggpTYK5/b8NfJYOkOwPgJ3NVNDDrRKb8RnE/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062450; c=relaxed/simple;
	bh=zaJgSfvI0azBFtm9r4HnerKfqShtXSa3/nNqm7Ayh0w=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=oZYDVJAxlfcM268eP9KwSVtogLi5Vscnv4dN9oIqFMryF33x4Mi236ljjl+1HDSyDQezZDe6lUDb+W2yXTxKwXbnyuzEXMIJZbOwUMrYzBb3BRveSO4GUuh4u+uxe7UpkmpZMCyf1Xe+3PoOpXSN+dtk1nVrAm8SIt51LfoJiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Sjh4oJJb; arc=none smtp.client-ip=66.163.190.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717062448; bh=99Wbwt3iIUDHwlI2i8ogTR9lHYzsNNirl8ROR3Ruz94=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=Sjh4oJJbCy+ERRdY0XoRZKQPw1yh4ajic8GtzicGmAyHGwvgVzEbxXU80T0SfOoapGXhqY/BtQGi+5Y7xEQE+ULUueWOnbja1Iul9t7v02h6HTJxlw++E6r/B+GkezMl3wlqWaB0guowC5dhg/WvALzURZSdy0Rezz08daAYweLzovDAF6id8qgv0GwlUqoljO5EHKM5OmUbGRWzgrhXUtUmh9KUG3IjWELBTsphUI59YdEzBu0PY06c3ImUXnVDQT17CGu6Px3vbff7L40gH0Y+caKoGUrRti6oLqsq1Z4f/H9387qSjIrlunaOTMabrC6gS+pYkmMgKeo20aYnkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717062448; bh=cmybnij2h4ZS8l67R7im7eYAg3qTfW9ru6hd7Dwjf6e=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=C70utZ5Vdk8oBSxfRmKO2QpnSjPsWqVOI6KC2OOfv4r0c3K3B+3EJ8V4Aj5bI4YE75k9354TvikjegEzn8dBTn95BWHLEI4BFY7SStmdfpiCjBU2hl9IhK/OBse/zq0mnbSIkMJrASwTKGcOVL9MkM7bP87B2GKZw8OivhTiZMGp0G4xiWsOSFSH5sRxJeG3uIZcyvNcgDDUQH7VoV3JwY9iQyw6yHSvXj8mayWysJWC19Iprn8KV0mjrUrUffx/m2qA5Hd8MbFa3VF+AkGAck1IuuUg4OBswm8NHQhzkutiRac6f81PVnbkGR9u5FzlI4dsnN5Gd3FRBG/mGKPY8g==
X-YMail-OSG: myegYewVM1l8G0yO2wvDtRNxyyqHqub3eoV2oTV3TG2ioxOC8yWLydhhuBICRNN
 tEoytFrWR5h0yJSuIZC9LWED9gOcMc0N5m.ukGwiu._X0ER6hBHfDXxJxXVPNTk8Ww0PCAO3v5aO
 S2O_cNK1rPtghukb9rznaSa0zBohbsWG5haxwscDjAspWyC8QdS0xFZb6hh1OYse3ieAPdGOAP2H
 Xy1LzXtBix8A1wNMes9fcisFETuGf_lTgTr1dQmq07Eq8XKjn_ceKZMEHe8G7w3Jn7uJEm8grgs2
 AlzZlVytsev4kxrRagPPSwJHN1shse9jGmHRCrhGz3oYnx1vQHs71MgG3w.Z8YhUeDuFCJFgXj37
 xcl69CPPZiwtzeWmrDLaql8BnWtzv5aEFir_2zu5iYwLEMsxIx6K1F6GKEsaIgMzupwPYmKlpwGJ
 PtQx7oGe6eJq0kpC7v13KgupLUO5m49o2BUczd9DI_z3GJTYmLJ1La1dWMds7EPt5KGLxrHuBznG
 X4bq.je0ODtasUrafKLCnvn4855KCp1Eu5EybMzyIkWfHVCZwz5aX6ctuS0i5sVToWuSocwxQRaJ
 51lc6xL1JSCqZrI9Bqla4hCad4wQnaXz0jfx6dHgaDwqAtMz3_wt16ofczJeRE3KUxpem6acji.m
 zgyXMtdRzvyMd1F_sLKs5O4AlkUNwT8OB9Kjkq2E7N3ZMAkKNylR7_mVNKeM18PnWcpVPIOhXwn1
 TCal33_aZOli7c2YIxQEvD8gWVrJHA3MOlBJPd_Pb7aS8TdgY.9qV43t9gIfbuYwvmx9DvJ7rnNk
 9ftqAOlILz6MHovLOxqULdV2bPHrfZHVtGA6k3_pQ_3mnr3T0a.W5_u3TyZX8GFnxBhHp30qp8mo
 Ce_6QQI.L5zyxsPBEskqX41fEh1219rkUoOqSCua4qHZP12OzifYGmQVefc40Pnoa5SnDZZWdqoH
 ICFE7O9MSExnpTsUYhfG5sBILj9r5trZRfVpXD2KPMB9tDBx5RiwIdwn5gqUPXXR4EYXCcJ7jZYt
 GyASroGXVC8tg9T.J2MKo76C01NE8rtfXYqGel.nOZSr8mehWjt3zqk4mfKZptrvllPY00PNTgkb
 Bbe1U5aqQ5EeO.8ZdpZxNMLngqIDQEBzP_xsuVE3fk1.qmlop30jqS9eIXtSVW8oB2Ha0LogN9Xi
 h9eiOF1bwc0yDoWn3EZ8T0yWvEmesyVCK0G5AIgthqWnYXa8FZh0Ht6Wmo0seKwySRZaiN6KM_Rt
 VE4Bya91IKtzN5JPDVRDBOfmlIyy0d263f.VyG8tmJWGzSO_VYuK9b2ho4ZDLQC6mEANxykHjPoS
 3huBqdxL1.wC_Hda9JxMQ9Eisk12ZeUyirKHMX71CVmn5uvydYaLer0WLDZWpCDVfOkI8bSJaIea
 ceALCUr2JUQqcQRwGo0vvr4qbltlZT1reBfGsa38073Nb1kOVx5pUrU1f7kFxJ0mWHK6QJror5RN
 L2S0cKxQuWoqIcHh.GP8bFop_wawTya1vQxpfjX8Ry6zq4hTVFbtAOZsXygWFGAEqJa.ob5rbcUO
 TWvvpVOG_LeBgEkrHfe2rY9KJMWlhpv.atreaPZUNgx.RrSak_aiLn6ptwVqB3FHZ709KaB5lDKx
 dNqzUuddFatDo3m_ijdO0C5G3H2wDq2Va0w50NJ568rXMXTiVRaRtLN2kmNdHzSin8Md54ykuo78
 fO9xfomBrXCp1Kt6DOqA3VwD6VTOT5OfQPfPDsWjOH13h82RozG.FCVOdQS6nJ76z2hK6esljOhs
 _dvh4PT0EFEFSivQUdEKtn8BHXN0SX0CEir.NadNKsv8zM1aGqiKxXR9S1V4yOOaGrp8gqsPMrti
 Kjh2O1ZfnbHDlBYKtzBcKArJ_iayGIHjguWPVusaCUm0ZZBzUDYX6eigmRhRUYe0TiJNFDtaR0x8
 U_.9AfiJPGn4FI4YH5M2ZTPJIeARakKGRXWRnrpK0lp8Zfxbp8H9HYaohzhOOT1wWDihMVLg7h_3
 g4xYsLYnNbl42jjkJUTZdXxC1JO0W7ONJjteh__w6ZOE1tlXAct0E.OnhvMjcdLm_.BLMEAk.pHF
 36QFw44Md9ENT.iUXqsqeKbKhwVFI..VT5S2ybUzp3MPAfHHdweRI.FJ7Ey8FWRiUFqvbXFx0tzp
 4B0OrUdB4gioxzdqLVJeePzctwgwMh9hZJdvttfCXtuA.v1Sa3PgarEZmeFpi6jHJHLNxGaIzTGc
 tBq4-
X-Sonic-MF: <mh3marefat@yahoo.com>
X-Sonic-ID: 2b5d0c64-9f24-4a14-852e-32a0a2782e91
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 May 2024 09:47:28 +0000
Date: Thu, 30 May 2024 09:37:18 +0000 (UTC)
From: Mohammad Hosain <mh3marefat@yahoo.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <321337111.6017022.1717061838476@mail.yahoo.com>
Subject: AM5 big performance reduction with CSM boot mode and Wi-Fi
 disabled.
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <321337111.6017022.1717061838476.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.22356 YMailNorrin

Hello
There is a big performance bug (only affecting games performance) on Linux (not reproducible on Windows) with AM5 boards (at least for my MSI MAG b650 Tomahawk) if these BIOS settings are used:
CSM -> Enabled
Wi-Fi -> Disabled (or set to Bluetooth only)
This does not happen even on Win 7... (I've only tested DX12 games) and does not happen if UEFI mode is chosen. I've tested with many different BIOS versions all showing the same result.
I have tried troubleshooting with MSI with some benchmarks posted (https://forum-en.msi.com/index.php?threads/b650-tomahawk-bios-bug-disabling-wi-fi-massively-reduces-system-performance.396910/) and after a week we realized this only happens on Linux (tested on Arch/Fedora/Ubuntu with 6.8 and 6.9 kernels for the first two).
Please investigate. 
Thank you


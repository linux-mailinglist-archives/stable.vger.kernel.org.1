Return-Path: <stable+bounces-93505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC59CDBEA
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47BA51F22775
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319E41990A2;
	Fri, 15 Nov 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kumkeo.de header.i=@kumkeo.de header.b="oq2lVa+0"
X-Original-To: stable@vger.kernel.org
Received: from mgw400.mail.berlinercloud.net (mgw400.mail.berlinercloud.net [194.29.227.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251B1922DD
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.29.227.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664409; cv=none; b=eXuKfMPNZfbYnAcv7g+SplHUZSJ1QkP4jZDQRDHSWqD8dfk64M14rGADDIqKVKM8xAANkYT1i3cdY4I+RzjCGy+poF9ddpwkdNemkB8yln5+YdJedlM2/Xk+MNF9pgGCikFuN46IbkiPG5fTCQTIvH9LdrsxCJG911Na2aYGA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664409; c=relaxed/simple;
	bh=WyrUnwwMNJv+VBLzYfoEVxbHuzftnq/8ueop4XIaKFk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AkUfB9VOrce8FbH8LQsmcdOEjlGKWhcOo4Pj1J4WN/a8N0KS39eZxIKBXEEvUBVWnapH7Iu1T3PRlJx4zHsVUGvILz8Ca3YX+sauRw2pZnaPO6Z3/taBYylQ40fTf4YdFQ56ydifauhYO4RpHBY8pUQ9FmQWedr+yX3iiQRss1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kumkeo.de; spf=pass smtp.mailfrom=kumkeo.de; dkim=pass (2048-bit key) header.d=kumkeo.de header.i=@kumkeo.de header.b=oq2lVa+0; arc=none smtp.client-ip=194.29.227.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kumkeo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kumkeo.de
X-TM-AS-ERS: 172.18.2.115-127.9.0.1
X-TM-AS-SMTP: 1.0 bWd3MzUwLm1haWwuYmVybGluZXJjbG91ZC5uZXQ= dWxyaWNoLnRlaWNoZ
	XJ0QGt1bWtlby5kZQ==
X-DDEI-TLS-USAGE: Used
Received: from mgw350.mail.berlinercloud.net (unknown [172.18.2.115])
	by mgw400.mail.berlinercloud.net (Postfix) with ESMTPS;
	Fri, 15 Nov 2024 10:47:34 +0100 (CET)
X-DDEI-TLS-USAGE: Used
Received: from mail.kumkeo.de (unknown [172.18.2.1])
	by mgw350.mail.berlinercloud.net (Postfix) with ESMTPS;
	Fri, 15 Nov 2024 10:47:34 +0100 (CET)
Received: from kumex2.kumkeo.de (172.18.20.16) by kumex2.kumkeo.de
 (172.18.20.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Nov
 2024 10:47:30 +0100
Received: from kumex2.kumkeo.de ([fe80::6572:2554:d711:1795]) by
 kumex2.kumkeo.de ([fe80::6572:2554:d711:1795%2]) with mapi id 15.01.2507.039;
 Fri, 15 Nov 2024 10:47:30 +0100
From: Ulrich Teichert <ulrich.teichert@kumkeo.de>
To: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>, Jiri Kosina <jkosina@suse.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Baumann <alexander.baumann@kumkeo.de>, Henry Baum
	<henry.baum@kumkeo.de>
Subject: [REGRESSION]: pbuilder random crashes on 6.1.y x86 with ARM64
 compiles
Thread-Topic: [REGRESSION]: pbuilder random crashes on 6.1.y x86 with ARM64
 compiles
Thread-Index: AQHbNz2/t8ZTYrl/GkG1Qz2lCV6hIQ==
Date: Fri, 15 Nov 2024 09:47:30 +0000
Message-ID: <18f34d636390454180240e6a61af9217@kumkeo.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: SMEX-14.0.0.3197-9.1.2019-28798.005
x-tm-as-result: No-10--7.542900-8.000000
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tm-snts-smtp: 42A7DAE5305B475D492D737B0D52F6D52EB86B313FC5BD1DC594B972769135BD2000:9
x-c2processedorg: c2164c60-77f9-4731-9233-294e5719f64e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DDEI-PROCESSED-RESULT: Safe
X-TMASE-Version: DDEI-5.1-9.1.1004-28798.005
X-TMASE-Result: 10--5.779700-10.000000
X-TMASE-MatchedRID: 04igWNgqdfBQf63o0X9KOd5x7RpGJf1aZR+OFNkbtdpVW5LVJV/so4Yy
	Eh9KWRq6GLad2bDwTZ2ewdPqajLo2xLmJd2F/yFuYPyK201ebhuhHrZE2+S869+tinHBPzXWohE
	Inkej0s9r8dzB1o5IO/jn9iKwHLeiMX9mM1cyCSNFwYcRXRYHEFr2hZxjCLzqjAAjpU/ygGRGst
	FPUJjSW/2t4ZhXODYO4b6XIVAPOikesEq1FYBLYYHfzWJnn0eo/jYKd9VlUo7Le/vEwLULpGmd1
	p2wVSdNmRmPU/MN3sN3cnF3YaUL1LT5k413CvlTHWRJEfGP5nluj2qdTD3bR2A+B6CBXAIWKZQ/
	22HSWdX9znQvyXYsHHm5thCb8AlNJp5gOc2mMBSdVNZaI2n6/3607foZgOWypoygB1fuSQ2yqFL
	My/lZpvQ+BCBYf5A6aFfmuk1zbRA47hQZQP+hqSzXb0IlnEHiELbqrOgWzycKPFr2HsSNRy01/i
	Bn2qTGE9FZa5rDtE524MJQ24Vw7KNfMEt6ct/sdAU6ju3vtgh9LQinZ4QefPKK1/oD8TJz+ZL5o
	+vRV7yzaNHaMrC6TbXwHj/AmsmG3QfwsVk0UbtuRXh7bFKB7kybbv0Y6FZHT0Jp4CZ84GTN8R1B
	SXT+a+xR7gQJRqDqSwwcGKLTYEc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: e2f75728-f974-40a6-a544-50a2e249f960-0-0-200-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kumkeo.de;
	s=bcsel2403; t=1731664055; x=1732096055;
	bh=WyrUnwwMNJv+VBLzYfoEVxbHuzftnq/8ueop4XIaKFk=; l=7194;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	b=oq2lVa+07reT9LosJBR3OseDFN2kRIdTCBSJb3HqLSVU/HwBULjkZ+YxL8b7EdrFN
	 BUFblA5Zepe+ofknb3i6b0FRefRuhMgLewFuIT2swwr4t1JAZ02w+taql49I7Q+tAk
	 r1c9fSUVDf1pB/i4EoWkLD8WlAMdNUJCgtVNY62UWU7X3HO2gsQq+Ijc+q2a46TB6/
	 V7z6XkDnlZ28wFQYU3HMIep+Ed5D/rj0fj7QbzEbb4xX1awv/u9nAoOruG0ISQFALt
	 bsUI/jjhD2Wz+EZFXkgziS19iWWM3OPxIiGILojLuoIOM5nfG7xc0MMlagu46A7ZVF
	 +9LerfBwgxuCg==

SGksDQoNCnRoZXJlIHNlZW1zIHRvIGJlIGEgc3VidGxlIHJlZ3Jlc3Npb24gd2l0aCA2LjEueSBr
ZXJuZWxzLiBJIGhhZCByYW5kb20gY3Jhc2hlcyB3aXRoIHBidWlsZGVyDQpydW5uaW5nIG9uIDY0
Yml0IHg4NiAoSW50ZWwgSFcsIGJ1dCBoYXBwZW5zIGFsc28gaW5zaWRlIFZNcykgYWZ0ZXIgRGVi
aWFuIHN0YWJsZSB1c2VkDQo2LjEuMTE1LiBPbiB0aGUgZmlyc3QgZ2xhbmNlLCB0aGlzIGxvb2tz
IGxpa2UgdGhlIHVzdWFsIEdDQyBzZWcgZmF1bHQgY3Jhc2ggYmVjYXVzZSBvZiBmYXVsdHkgaGFy
ZHdhcmU6DQoNCi4uLg0KRU5BQkxFX1RSRl9GT1JfTlM9MCAtREVOQ1JZUFRfQkwzMT0wIC1ERU5D
UllQVF9CTDMyPTAgLURFUlJBVEFfU1BFQ1VMQVRJVkVfQVQ9MCAtREVSUk9SDQpfREVQUkVDQVRF
RD0wIC1ERkFVTFRfSU5KRUNUSU9OX1NVUFBPUlQ9MCAtREdJQ1YyX0cwX0ZPUl9FTDM9MSAtREhB
TkRMRV9FQV9FTDNfRklSU1Q9MA0KLURIV19BU1NJU1RFRF9DT0hFUkVOQ1k9MCAtRExPR19MRVZF
TD00MCAtRE1FQVNVUkVEX0JPT1Q9MCAtRE5SX09GX0ZXX0JBTktTPTIgLUROUl9PRl9JDQpNQUdF
U19JTl9GV19CQU5LPTEgLUROU19USU1FUl9TV0lUQ0g9MCAtRFBMMDExX0dFTkVSSUNfVUFSVD0w
IC1EUExBVF96eW5xbXAgLURQUk9HUkFNTUENCkJMRV9SRVNFVF9BRERSRVNTPTEgLURQU0FfRldV
X1NVUFBPUlQ9MCAtRFBTQ0lfRVhURU5ERURfU1RBVEVfSUQ9MSAtRFJBU19FWFRFTlNJT049MCAt
RA0KUkFTX1RSQVBfTE9XRVJfRUxfRVJSX0FDQ0VTUz0wIC1EUkVDTEFJTV9JTklUX0NPREU9MCAt
RFJFU0VUX1RPX0JMMzE9MSAtRFNERUlfSU5fRkNPTkY9DQowIC1EU0VDX0lOVF9ERVNDX0lOX0ZD
T05GPTAgLURTRVBBUkFURV9DT0RFX0FORF9ST0RBVEE9MSAtRFNFUEFSQVRFX05PQklUU19SRUdJ
T049MCAtRFMNClBEX25vbmUgLURTUElOX09OX0JMMV9FWElUPTAgLURTUE1EX1NQTV9BVF9TRUwy
PTEgLURTUE1fTU09MCAtRFRSTkdfU1VQUE9SVD0wIC1EVFJVU1RFRA0KX0JPQVJEX0JPT1Q9MCAt
RFVTRV9DT0hFUkVOVF9NRU09MSAtRFVTRV9ERUJVR0ZTPTAgLURVU0VfUk9NTElCPTAgLURVU0Vf
U1A4MDRfVElNRVI9MCAtDQpEVVNFX1NQSU5MT0NLX0NBUz0wIC1EVVNFX1RCQlJfREVGUz0xIC1E
V0FSTUJPT1RfRU5BQkxFX0RDQUNIRV9FQVJMWT0xIC1JaW5jbHVkZSAtSWluY2wNCnVkZS9hcmNo
L2FhcmNoNjQgLUlpbmNsdWRlL2xpYi9jcHVzL2FhcmNoNjQgLUlpbmNsdWRlL2xpYi9lbDNfcnVu
dGltZS9hYXJjaDY0IC1JaW5jbHVkZQ0KL3BsYXQvYXJtL2NvbW1vbi8gLUlpbmNsdWRlL3BsYXQv
YXJtL2NvbW1vbi9hYXJjaDY0LyAtSXBsYXQveGlsaW54L2NvbW1vbi9pbmNsdWRlLyAtSXBsYXQv
eGlsaW54L2NvbW1vbi9pcGlfbWFpbGJveF9zZXJ2aWNlLyAtSXBsYXQveGlsaW54L3p5bnFtcC9p
bmNsdWRlLyAtSXBsYXQveGlsaW54L3p5bnFtcC9wbV9zZXJ2aWNlLyAgIC1JaW5jbHVkZS9saWIv
bGliZmR0IC1JaW5jbHVkZS9saWIvbGliYyAtSWluY2x1ZGUvbGliL2xpYmMvYWFyY2g2NCAgIC1u
b3N0ZGluYyAtV2Vycm9yIC1XYWxsIC1XbWlzc2luZy1pbmNsdWRlLWRpcnMgLVd1bnVzZWQgLVdk
aXNhYmxlZC1vcHRpbWl6YXRpb24gLVd2bGEgLVdzaGFkb3cgLVduby11bnVzZWQtcGFyYW1ldGVy
IC1XcmVkdW5kYW50LWRlY2xzIC1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgLVdtYXliZS11bmlu
aXRpYWxpemVkIC1XcGFja2VkLWJpdGZpZWxkLWNvbXBhdCAtV3NoaWZ0LW92ZXJmbG93PTIgLVds
b2dpY2FsLW9wIC1Xbm8tZXJyb3I9ZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnMgLVduby1lcnJvcj1j
cHAgLW1hcmNoPWFybXY4LWEgLW1nZW5lcmFsLXJlZ3Mtb25seSAtbXN0cmljdC1hbGlnbiAtbWJy
YW5jaC1wcm90ZWN0aW9uPW5vbmUgLWZmdW5jdGlvbi1zZWN0aW9ucyAtZmRhdGEtc2VjdGlvbnMg
LWZmcmVlc3RhbmRpbmcgLWZuby1idWlsdGluIC1mbm8tY29tbW9uIC1PcyAtc3RkPWdudTk5IC1m
bm8tUElFIC1mbm8tc3RhY2stcHJvdGVjdG9yICAtZm5vLWp1bXAtdGFibGVzIC1ESU1BR0VfQVRf
RUwzIC1ESU1BR0VfQkwzMSAgLVdwLC1NRCwvYnVpbGQvYXJtLXRydXN0ZWQtZmlybXdhcmUta2st
Mi42LTIwMjItMi1ray9idWlsZC96eW5xbXAvcmVsZWFzZS9ibDMxL3BsYXRfcHNjaS5kIC1NVCAv
YnVpbGQvYXJtLXRydXN0ZWQtZmlybXdhcmUta2stMi42LTIwMjItMi1ray9idWlsZC96eW5xbXAv
cmVsZWFzZS9ibDMxL3BsYXRfcHNjaS5vIC1NUCAtYyBwbGF0L3hpbGlueC96eW5xbXAvcGxhdF9w
c2NpLmMgLW8gL2J1aWxkL2FybS10cnVzdGVkLWZpcm13YXJlLWtrLTIuNi0yMDIyLTIta2svYnVp
bGQvenlucW1wL3JlbGVhc2UvYmwzMS9wbGF0X3BzY2kubw0KbWFrZVsyXTogKioqIFtNYWtlZmls
ZToxMjUxOiAvYnVpbGQvYXJtLXRydXN0ZWQtZmlybXdhcmUta2stMi42LTIwMjItMi1ray9idWls
ZC96eW5xbXAvcmVsZWFzZS9ibDMxL3BsYXRfcHNjaS5vXSBTZWdtZW50YXRpb24gZmF1bHQNCm1h
a2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQouLi4NCg0KKFRoYXQn
cyBhIHBidWlsZGVyIGJ1aWxkIG9mIHRoZSBBUk0gdHJ1c3RlZCBmaXJtd2FyZSwgYnV0IGl0IGNy
YXNoZXMgd2l0aCBhbnkgb3RoZXIgQVJNNjQgYXBwbGljYXRpb24gYnVpbGQNCndpdGggcGJ1aWxk
ZXIgc29vbmVyIG9yIGxhdGVyIC0gYnV0IE5PVCBvbiB0aGUgZmlyc3Qgb3Igc2Vjb25kIHJ1biwg
dXN1YWxseSBhZnRlciB0aGUgdGhpcmQgb3IgZmlmdGggcnVuKQ0KDQpIb3dldmVyLCB0aGUgY3Jh
c2hlcyB3ZXJlIGdvaW5nIGF3YXkgYWdhaW4gd2hlbiBJIHN3aXRjaGVkIGJhY2sgdG8gNi4xLjEx
MiAodGhlIHByZXZpb3VzIGRlYmlhbiBzdGFibGUga2VybmVsKS4NCkkndmUgZ2l0IGJpc2VjdGVk
IGl0IGRvd24gdG8gdGhpcyBjb21taXQ6DQoNCmIwY2RlODY3YjgwYTVlODFmY2JjMDM4M2UxMzhm
NTg0NWYyMDA1ZWUgaXMgdGhlIGZpcnN0IGJhZCBjb21taXQNCmNvbW1pdCBiMGNkZTg2N2I4MGE1
ZTgxZmNiYzAzODNlMTM4ZjU4NDVmMjAwNWVlDQpBdXRob3I6IEtlZXMgQ29vayA8a2Vlc2Nvb2tA
Y2hyb21pdW0ub3JnPg0KRGF0ZTogICBGcmkgRmViIDE2IDIyOjI1OjQzIDIwMjQgLTA4MDANCiAg
ICB4ODY6IEluY3JlYXNlIGJyayByYW5kb21uZXNzIGVudHJvcHkgZm9yIDY0LWJpdCBzeXN0ZW1z
DQogICAgWyBVcHN0cmVhbSBjb21taXQgNDRjNzY4MjVkNmVlZmVlOWViN2NlMDZjMzhlMWE2NjMy
YWM3ZWI3ZCBdDQogICAgSW4gY29tbWl0IGMxZDE3MWEwMDI5NCAoIng4NjogcmFuZG9taXplIGJy
ayIpLCBhcmNoX3JhbmRvbWl6ZV9icmsoKSB3YXMNCiAgICBkZWZpbmVkIHRvIHVzZSBhIDMyTUIg
cmFuZ2UgKDEzIGJpdHMgb2YgZW50cm9weSksIGJ1dCB3YXMgbmV2ZXIgaW5jcmVhc2VkDQogICAg
d2hlbiBtb3ZpbmcgdG8gNjQtYml0LiBUaGUgZGVmYXVsdCBhcmNoX3JhbmRvbWl6ZV9icmsoKSB1
c2VzIDMyTUIgZm9yDQogICAgMzItYml0IHRhc2tzLCBhbmQgMUdCICgxOCBiaXRzIG9mIGVudHJv
cHkpIGZvciA2NC1iaXQgdGFza3MuDQogICAgVXBkYXRlIHg4Nl82NCB0byBtYXRjaCB0aGUgZW50
cm9weSB1c2VkIGJ5IGFybTY0IGFuZCBvdGhlciA2NC1iaXQNCiAgICBhcmNoaXRlY3R1cmVzLg0K
ICAgIFJlcG9ydGVkLWJ5OiB5MHVuOW4xMzJAZ21haWwuY29tDQogICAgU2lnbmVkLW9mZi1ieTog
S2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQogICAgU2lnbmVkLW9mZi1ieTogVGhv
bWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQogICAgQWNrZWQtYnk6IEppcmkgS29z
aW5hIDxqa29zaW5hQHN1c2UuY29tPg0KICAgIENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtaGFyZGVuaW5nL0NBKzJFS1RWTHZjOGhEWmMrMllod211cz1kek9VRzVFNGdWN2F5
Q2J1ME1QSlRaeldrd0BtYWlsLmdtYWlsLmNvbS8NCiAgICBMaW5rOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjQwMjE3MDYyNTQ1LjE2MzE2NjgtMS1rZWVzY29va0BjaHJvbWl1bS5vcmcN
CiAgICBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+DQoNCklm
IEkgcmV2ZXJ0IHRoYXQgY29tbWl0LCBsaWtlOg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpp
bmRleCBhY2M4MzczOGJmNWIuLjI3OWI1ZTliZTgwZiAxMDA2NDQNCkBAIC05OTEsMTAgKzk5MSw3
IEBAIHVuc2lnbmVkIGxvbmcgYXJjaF9hbGlnbl9zdGFjayh1bnNpZ25lZCBsb25nIHNwKQ0KDQog
dW5zaWduZWQgbG9uZyBhcmNoX3JhbmRvbWl6ZV9icmsoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQog
ew0KLWlmIChtbWFwX2lzX2lhMzIoKSkNCi1yZXR1cm4gcmFuZG9taXplX3BhZ2UobW0tPmJyaywg
U1pfMzJNKTsNCi0NCi1yZXR1cm4gcmFuZG9taXplX3BhZ2UobW0tPmJyaywgU1pfMUcpOw0KK3Jl
dHVybiByYW5kb21pemVfcGFnZShtbS0+YnJrLCAweDAyMDAwMDAwKTsNCiB9DQoNCiAvKg0KDQpX
aXRoIHRoYXQgcmV2ZXJ0LCBJIGNhbiBydW4gcGJ1aWxkZXIgdG8gY29tcGlsZSBBUk02NCBidWls
ZHMgYWxsIGRheSBhbmQgaXQgbmV2ZXIgY3Jhc2hlcy4gSSBoYXZlIG5vIGlkZWEgd2h5DQp0aGF0
IGNoYW5nZSBicm9rZSBwYnVpbGRlciwgbWF5YmUgaXQncyBzb21ldGhpbmcgcmVsYXRlZCB0byB0
aGUgd2F5IHFlbXUgaXMgdXNlZCBpbnNpZGUgdGhlIEFSTTY0IGNocm9vdA0KZW52aXJvbm1lbnQs
IGJ1dCBpbiBteSBvcGluaW9uIGl0J3MgYSBrZXJuZWwgcmVncmVzc2lvbiwNCg0KVElBLA0KVWxp
DQoNCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4gLyBLaW5kIHJlZ2FyZHMNCg0KRGlwbC4tSW5m
b3JtLiBVbHJpY2ggVGVpY2hlcnQNClNlbmlvciBTb2Z0d2FyZSBEZXZlbG9wZXINCg0Ka3Vta2Vv
IEdtYkgNCkhlaWRlbmthbXBzd2VnIDgyYQ0KMjAwOTcgSGFtYnVyZw0KR2VybWFueQ0KDQpUOiAr
NDkgNDAgMjg0Njc2MS0wDQpGOiArNDkgNDAgMjg0Njc2MS05OQ0KDQp1bHJpY2gudGVpY2hlcnRA
a3Vta2VvLmRlDQp3d3cua3Vta2VvLmRlDQoNCkFtdHNnZXJpY2h0IEhhbWJ1cmcgLyBIYW1idXJn
IERpc3RyaWN0IENvdXJ0LCBIUkIgMTA4NTU4DQpHZXNjaMOkZnRzZsO8aHJlciAvIE1hbmFnaW5n
IERpcmVjdG9yOiBEaXBsLi1JbmcuIEJlcm5kIFNhZ2VyOyBEaXBsLi1JbmcuIFN2ZW4gVGFubmVi
ZXJnZXIsIE1CQQ0K


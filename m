Return-Path: <stable+bounces-109326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6935AA1489A
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 04:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D341882BA2
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 03:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75B1F5618;
	Fri, 17 Jan 2025 03:48:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5C7DA73;
	Fri, 17 Jan 2025 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085724; cv=none; b=Knv0GQuJJYsBWRSF0BDhTozv5KpJYC79YDRb4r3UvDPsTkfnLB1ZuezdHiSBfl22ab6SLLTvRjeJ2XumGCaV1P/7x9j64eELnR1WTKwbBtElusP9k4peNxc5TEkSFgXYWyeg3vwQcD+nN/ki3yk337f84aAeyE1uiUB5tHK3tLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085724; c=relaxed/simple;
	bh=4MiAb6QxbOvA+cPXbC6xMN2PwiwOqndVGxqsiCn9wj0=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=KzL18KBFKg518zKrBPs2g8N5DVEkIUyCmXyYJdkuwMycQ2s/3fQpW7N4hODrmt1/ANFYI1SevvivPmh3O4R+S/ekXi3hzT7TvsDiOSHj3DRzU9ujIFRhB2xnYrYWj+WZY+Ecl9G7Obi4J5URy8q/NtTcArvPKOE2Qj3/gk2dbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ef51c65cd48511efa216b1d71e6e1362-20250117
X-CID-CACHE: Type:Local,Time:202501171143+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:cd89cb29-2049-4d19-b669-a2061d0daa6f,IP:0,U
	RL:0,TC:-7,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-12
X-CID-META: VersionHash:6493067,CLOUDID:94dea84876536e31486c3b5af1465fae,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102,TC:1,Content:0|52,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ef51c65cd48511efa216b1d71e6e1362-20250117
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1256760243; Fri, 17 Jan 2025 11:48:38 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id F3CAAB80758A;
	Fri, 17 Jan 2025 11:48:37 +0800 (CST)
Received: by node2.com.cn (NSMail, from userid 0)
	id D054EB80758A; Fri, 17 Jan 2025 11:48:37 +0800 (CST)
From: =?UTF-8?B?546L5a6H6ZSL?= <wangyufeng@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSB0b29sczogZml4ZWQgY29tcGlsZSB0b29scy92aXJ0aW8gZXJyb3IgIl9fdXNlciIgcmVkZWZpbmVkIFstV2Vycm9yXQ==?=
To: 	=?UTF-8?B?SGFvIEdl?= <hao.ge@linux.dev>,
	=?UTF-8?B?R3JlZyBLSA==?= <gregkh@linuxfoundation.org>,
Cc: 	=?UTF-8?B?S2VlcyBDb29r?= <kees@kernel.org>,
	=?UTF-8?B?QW5kcmV3IE1vcnRvbg==?= <akpm@linux-foundation.org>,
	=?UTF-8?B?TmF0aGFuIENoYW5jZWxsb3I=?= <nathan@kernel.org>,
	=?UTF-8?B?SmFrdWIgS2ljaW5za2k=?= <kuba@kernel.org>,
	=?UTF-8?B?UGV0ciBQYXZsdQ==?= <petr.pavlu@suse.com>,
	=?UTF-8?B?WWFmYW5nIFNoYW8=?= <laoar.shao@gmail.com>,
	=?UTF-8?B?SmFuIEhlbmRyaWsgRmFycg==?= <kernel@jfarr.cc>,
	=?UTF-8?B?VG9ueSBBbWJhcmRhcg==?= <tony.ambardar@gmail.com>,
	=?UTF-8?B?QWxleGFuZGVyIFBvdGFwZW5rbw==?= <glider@google.com>,
	=?UTF-8?B?VXJvcyBCaXpqYWs=?= <ubizjak@gmail.com>,
	=?UTF-8?B?U2h1bnN1a2UgTWll?= <mie@igel.co.jp>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?c3RhYmxl?= <stable@vger.kernel.org>,
Date: Fri, 17 Jan 2025 11:48:37 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <142wvsydrkj-142y5qrstec@nsmail7.0.0--kylin--1>
References: 0e5ab96b-2a2a-4e64-b0e0-2fdf6ce39810@linux.dev
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Fri, 17 Jan 2025 11:48:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-1749mqx5cd2-174awoqke6v
X-ns-mid: webmail-6789d315-16yt432r
X-ope-from: <wangyufeng@kylinos.cn>

This message is in MIME format.

--nsmail-1749mqx5cd2-174awoqke6v
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+eWVzLCBpdCdzIGEgb3RoZXIgZ29vZCB3YXksIGl0J3MgdGhlIG1pbmlt
dW0gbW9kaWZ5IHRvIGZpeCBpdC48L3A+CjxwPmJ1dCBpIHRoaW5rIGl0J3Mg
bm90IGdjYyByZWFzb24gbWF5YmUuIGkgdXBkYXRlIG15IGdjYyB0byAxNC4y
LjAgdmVyc2lvbiwgd2hlbiBsYWNrIG9mIGxpbnV4L3Vzci9pbmNsdWRlL2xp
bnV4L3Zob3N0X3R5cGVzLmggZmlsZSwgdGhlICJfX3VzZXIgcmVkZWZpbmUi
IC1XZXJyb3Igd2lsbCBkaXNhcHBlYXLjgII8YnI+PGJyPjxicj48YnI+PGJy
Pjxicj4tLS0tPC9wPgo8ZGl2IGlkPSJjczJjX21haWxfc2lnYXR1cmUiPjwv
ZGl2Pgo8cD4mbmJzcDs8L3A+CjxkaXYgaWQ9InJlIiBzdHlsZT0ibWFyZ2lu
LWxlZnQ6IDAuNWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVtOyBib3JkZXItbGVm
dDogMXB4IHNvbGlkIGdyZWVuOyI+PGJyPjxicj48YnI+CjxkaXYgc3R5bGU9
ImJhY2tncm91bmQtY29sb3I6ICNmNWY3ZmE7Ij48c3Ryb25nPuS4u+OAgOmi
mO+8mjwvc3Ryb25nPjxzcGFuIGlkPSJzdWJqZWN0Ij5SZTogW1BBVENIXSB0
b29sczogZml4ZWQgY29tcGlsZSB0b29scy92aXJ0aW8gZXJyb3IgIl9fdXNl
ciIgcmVkZWZpbmVkIFstV2Vycm9yXTwvc3Bhbj4gPGJyPjxzdHJvbmc+5pel
44CA5pyf77yaPC9zdHJvbmc+PHNwYW4gaWQ9ImRhdGUiPjIwMjUtMDEtMTMg
MTA6MzQ8L3NwYW4+IDxicj48c3Ryb25nPuWPkeS7tuS6uu+8mjwvc3Ryb25n
PjxzcGFuIGlkPSJmcm9tIj5IYW8gR2U8L3NwYW4+IDxicj48c3Ryb25nPuaU
tuS7tuS6uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJ0byIgc3R5bGU9IndvcmQt
YnJlYWs6IGJyZWFrLWFsbDsiPkdyZWcgS0g7546L5a6H6ZSLOzwvc3Bhbj48
L2Rpdj4KPGJyPgo8ZGl2IGlkPSJjb250ZW50Ij4KPGRpdiBjbGFzcz0idmll
d2VyX3BhcnQiIHN0eWxlPSJwb3NpdGlvbjogcmVsYXRpdmU7Ij4KPGRpdj5I
aSBHcmVnIGFuZCBZdWZlbmc8YnI+PGJyPjxicj5PbiAyMDI1LzEvOSAxNzox
NCwgR3JlZyBLSCB3cm90ZTo8YnI+Jmd0OyBPbiBUaHUsIEphbiAwOSwgMjAy
NSBhdCAwNDo0Mzo0MVBNICswODAwLCBZdWZlbmcgV2FuZyB3cm90ZTo8YnI+
Jmd0OyZndDsgd2UgdXNlIC1XZXJyb3Igbm93LCBhbmQgd2FybmluZ3MgYnJl
YWsgdGhlIGJ1aWxkIHNvIGxldCdzIGZpeGVkIGl0Ljxicj4mZ3Q7Jmd0Ozxi
cj4mZ3Q7Jmd0OyBmcm9tIHZpcnRpb190ZXN0LmM6MTc6PGJyPiZndDsmZ3Q7
IC4vbGludXgvLi4vLi4vLi4vaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBl
cy5oOjQ4OiBlcnJvcjogIl9fdXNlciIgcmVkZWZpbmVkIFstV2Vycm9yXTxi
cj4mZ3Q7Jmd0OyA0OCB8ICMgZGVmaW5lIF9fdXNlciBCVEZfVFlQRV9UQUco
dXNlcik8YnI+Jmd0OyZndDsgfDxicj4mZ3Q7Jmd0OyBJbiBmaWxlIGluY2x1
ZGVkIGZyb20gLi4vLi4vdXNyL2luY2x1ZGUvbGludXgvc3RhdC5oOjUsPGJy
PiZndDsmZ3Q7IGZyb20gL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUv
Yml0cy9zdGF0eC5oOjMxLDxicj4mZ3Q7Jmd0OyBmcm9tIC91c3IvaW5jbHVk
ZS94ODZfNjQtbGludXgtZ251L3N5cy9zdGF0Lmg6NDY1LDxicj4mZ3Q7Jmd0
OyBmcm9tIHZpcnRpb190ZXN0LmM6MTI6PGJyPiZndDsmZ3Q7IC4uL2luY2x1
ZGUvbGludXgvdHlwZXMuaDo1Njogbm90ZTogdGhpcyBpcyB0aGUgbG9jYXRp
b24gb2YgdGhlIHByZXZpb3VzIGRlZmluaXRpb248YnI+Jmd0OyZndDsgNTYg
fCAjZGVmaW5lIF9fdXNlcjxicj4mZ3Q7Jmd0Ozxicj4mZ3Q7Jmd0OyBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZzxicj4mZ3Q7Jmd0Ozxicj4mZ3Q7Jmd0
OyBTaWduZWQtb2ZmLWJ5OiBZdWZlbmcgV2FuZyA8YnI+Jmd0OyZndDsgLS0t
PGJyPiZndDsmZ3Q7IGluY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCB8
IDEgKzxicj4mZ3Q7Jmd0OyAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
Kyk8YnI+Jmd0OyZndDs8YnI+Jmd0OyZndDsgZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCBiL2luY2x1ZGUvbGludXgvY29t
cGlsZXJfdHlwZXMuaDxicj4mZ3Q7Jmd0OyBpbmRleCA1ZDY1NDQ1NDU2NTgu
LjMzMTZlNTYxNDBkNiAxMDA2NDQ8YnI+Jmd0OyZndDsgLS0tIGEvaW5jbHVk
ZS9saW51eC9jb21waWxlcl90eXBlcy5oPGJyPiZndDsmZ3Q7ICsrKyBiL2lu
Y2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaDxicj4mZ3Q7Jmd0OyBAQCAt
NTQsNiArNTQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19jaGtfaW9fcHRy
KGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqcHRyKSB7IH08YnI+Jmd0
OyZndDsgIyBpZmRlZiBTVFJVQ1RMRUFLX1BMVUdJTjxicj4mZ3Q7Jmd0OyAj
IGRlZmluZSBfX3VzZXIgX19hdHRyaWJ1dGVfXygodXNlcikpPGJyPiZndDsm
Z3Q7ICMgZWxzZTxicj4mZ3Q7Jmd0OyArIyB1bmRlZiBfX3VzZXI8YnI+Jmd0
OyZndDsgIyBkZWZpbmUgX191c2VyIEJURl9UWVBFX1RBRyh1c2VyKTxicj4m
Z3Q7Jmd0OyAjIGVuZGlmPGJyPiZndDsmZ3Q7ICMgZGVmaW5lIF9faW9tZW08
YnI+Jmd0OyZndDsgLS0gPGJyPiZndDsmZ3Q7IDIuMzQuMTxicj4mZ3Q7IFdo
YXQgY29tbWl0IGRvZXMgdGhpcyBmaXg/IFdoeSBpcyB0aGlzIHN1ZGRlbmx5
IHNob3dpbmcgdXAgbm93Pzxicj4mZ3Q7PGJyPiZndDsgdGhhbmtzLDxicj4m
Z3Q7PGJyPiZndDsgZ3JlZyBrLWg8YnI+PGJyPjxicj5UaGlzIG1heSBiZSBh
biBpc3N1ZSBjYXVzZWQgYnkgYW4gdXBncmFkZSBpbiB0aGUgR0NDIHZlcnNp
b24uPGJyPjxicj5Vc2luZyBHQ0MgdmVyc2lvbiA5LjMuMCwgaXQgY2FuIGhh
cHBpbHkgcGFzcyB0aGUgYnVpbGQgcHJvY2Vzcy48YnI+PGJyPkhvd2V2ZXIs
IHdoZW4gdXNpbmcgR0NDIHZlcnNpb24gMTIuMy4xLCBpc3N1ZXMgYXJpc2Uu
PGJyPjxicj5UaGUgaW5pdGlhbCBidWlsZCBlcnJvciBzdGFjayBpcyBhcyBm
b2xsb3dzOjxicj48YnI+Y2MgLWcgLU8yIC1XZXJyb3IgLVduby1tYXliZS11
bmluaXRpYWxpemVkIC1XYWxsIC1JLiAtSS4uL2luY2x1ZGUvIC1JIDxicj4u
Li4vLi4vdXNyL2luY2x1ZGUvIC1Xbm8tcG9pbnRlci1zaWduIC1mbm8tc3Ry
aWN0LW92ZXJmbG93IDxicj4tZm5vLXN0cmljdC1hbGlhc2luZyAtZm5vLWNv
bW1vbiAtTU1EIC1VX0ZPUlRJRllfU09VUkNFIC1pbmNsdWRlIDxicj4uLi4v
Li4vaW5jbHVkZS9saW51eC9rY29uZmlnLmggLW1mdW5jdGlvbi1yZXR1cm49
dGh1bmsgPGJyPi1mY2YtcHJvdGVjdGlvbj1ub25lIC1taW5kaXJlY3QtYnJh
bmNoLXJlZ2lzdGVyIC1wdGhyZWFkJm5ic3A7Jm5ic3A7IC1jIC1vIDxicj52
aXJ0aW9fdGVzdC5vIHZpcnRpb190ZXN0LmM8YnI+SW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIC4vbGludXgvY29tcGlsZXIuaDo1LDxicj4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZnJvbSAu
L2xpbnV4L2tlcm5lbC5oOjEyLDxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZnJvbSAuL2xpbnV4L3Nj
YXR0ZXJsaXN0Lmg6NCw8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGZyb20gLi9saW51eC92aXJ0aW8u
aDo0LDxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgZnJvbSAuL2xpbnV4L3ZpcnRpb19jb25maWcuaDo1
LDxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgZnJvbSAuLi8uLi91c3IvaW5jbHVkZS9saW51eC92aG9z
dF90eXBlcy5oOjE0LDxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZnJvbSAuLi8uLi91c3IvaW5jbHVk
ZS9saW51eC92aG9zdC5oOjE0LDxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZnJvbSB2aXJ0aW9fdGVz
dC5jOjE3Ojxicj4uLi9saW51eC8uLi8uLi8uLi9pbmNsdWRlL2xpbnV4L2Nv
bXBpbGVyX3R5cGVzLmg6NTc6IGVycm9yOiAiX191c2VyIiA8YnI+cmVkZWZp
bmVkIFstV2Vycm9yXTxicj48YnI+Jm5ic3A7Jm5ic3A7IDU3IHwgIyZuYnNw
OyBkZWZpbmUgX191c2VyJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7IEJURl9UWVBFX1RBRyh1c2VyKTxicj4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsgfDxicj5JbiBmaWxlIGluY2x1ZGVkIGZy
b20gLi4vLi4vdXNyL2luY2x1ZGUvbGludXgvc3RhdC5oOjUsPGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBmcm9tIC91c3IvaW5jbHVkZS9iaXRzL3N0YXR4Lmg6MzEsPGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBmcm9tIC91c3IvaW5jbHVkZS9zeXMvc3RhdC5oOjQ2NSw8YnI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
IGZyb20gdmlydGlvX3Rlc3QuYzoxMjo8YnI+PGJyPi4uLi9pbmNsdWRlL2xp
bnV4L3R5cGVzLmg6NTY6IG5vdGU6IHRoaXMgaXMgdGhlIGxvY2F0aW9uIG9m
IHRoZSBwcmV2aW91cyA8YnI+ZGVmaW5pdGlvbjxicj48YnI+Jm5ic3A7Jm5i
c3A7IDU2IHwgI2RlZmluZSBfX3VzZXI8YnI+PGJyPkl0IHNob3VsZCBoYXZl
IGZpcnN0IGVuY291bnRlcmVkIHRoZSBmb2xsb3dpbmcgI2lmbmRlZjxicj48
YnI+aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTIuNS9z
b3VyY2UvdG9vbHMvaW5jbHVkZS9saW51eC90eXBlcy4uaCNMNTI8YnI+PGJy
PlNvIEkgdGhpbmsgdGhlJm5ic3A7IG1vZGlmaWNhdGlvbiBzaG91bGQgYmUg
YXMgZm9sbG93cyhBZGp1c3QgdGhlIHBvc2l0aW9uIG9mIDxicj50aGUgaGVh
ZGVyIGZpbGUpLDxicj48YnI+V2hhdCBkbyB5b3UgdGhpbms/PGJyPjxicj48
YnI+ZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpby9saW51eC92aXJ0aW9fY29u
ZmlnLmggPGJyPmIvdG9vbHMvdmlydGlvL2xpbnV4L3ZpcnRpb19jb25maWcu
aDxicj5pbmRleCA0MmE1NjRmMjJmMmQuLjNkMzIyMTFkMmQyMyAxMDA2NDQ8
YnI+LS0tIGEvdG9vbHMvdmlydGlvL2xpbnV4L3ZpcnRpb19jb25maWcuaDxi
cj4rKysgYi90b29scy92aXJ0aW8vbGludXgvdmlydGlvX2NvbmZpZy5oPGJy
PkBAIC0xLDggKzEsOCBAQDxicj4mbmJzcDsvKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMCAqLzxicj4mbmJzcDsjaWZuZGVmIExJTlVYX1ZJ
UlRJT19DT05GSUdfSDxicj4mbmJzcDsjZGVmaW5lIExJTlVYX1ZJUlRJT19D
T05GSUdfSDxicj4tI2luY2x1ZGUgPGJyPiZuYnNwOyNpbmNsdWRlIDxicj4r
I2luY2x1ZGUgPGJyPiZuYnNwOyNpbmNsdWRlIDxicj48YnI+Jm5ic3A7c3Ry
dWN0IHZpcnRpb19jb25maWdfb3BzIHs8YnI+ZGlmZiAtLWdpdCBhL3Rvb2xz
L3ZpcnRpby92aXJ0aW9fdGVzdC5jIGIvdG9vbHMvdmlydGlvL3ZpcnRpb190
ZXN0LmM8YnI+aW5kZXggMDI4ZjU0ZTY4NTRhLi44Y2JlNjMyZTk4YjAgMTAw
NjQ0PGJyPi0tLSBhL3Rvb2xzL3ZpcnRpby92aXJ0aW9fdGVzdC5jPGJyPisr
KyBiL3Rvb2xzL3ZpcnRpby92aXJ0aW9fdGVzdC5jPGJyPkBAIC05LDEzICs5
LDEzIEBAPGJyPiZuYnNwOyNpbmNsdWRlIDxicj4mbmJzcDsjaW5jbHVkZSA8
YnI+Jm5ic3A7I2luY2x1ZGUgPGJyPisjaW5jbHVkZSA8YnI+Jm5ic3A7I2lu
Y2x1ZGUgPGJyPiZuYnNwOyNpbmNsdWRlIDxicj4mbmJzcDsjaW5jbHVkZSA8
YnI+Jm5ic3A7I2luY2x1ZGUgPGJyPiZuYnNwOyNpbmNsdWRlIDxicj4mbmJz
cDsjaW5jbHVkZSA8YnI+LSNpbmNsdWRlIDxicj4mbmJzcDsjaW5jbHVkZSA8
YnI+Jm5ic3A7I2luY2x1ZGUgIi4uLy4uL2RyaXZlcnMvdmhvc3QvdGVzdC5o
Ijxicj48YnI+VGhhbmtzPGJyPjxicj5CZXN0IFJlZ2FyZHM8YnI+PGJyPkhh
bzxicj48YnI+PC9kaXY+CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+

--nsmail-1749mqx5cd2-174awoqke6v--


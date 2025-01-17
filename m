Return-Path: <stable+bounces-109325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D8A14893
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 04:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D641E3A5135
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 03:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B701F63D3;
	Fri, 17 Jan 2025 03:43:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0919049B;
	Fri, 17 Jan 2025 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737085426; cv=none; b=ESDfVGyE4TDHZzUhtOcclXxo0d5L3+sccfsTxVX/JbStJ9cZ63gHaY2iotDpDMJkeGkfpiIxLdlBZwIH2l8IghkIUuz9LaitKj0IpTfJQAKPm9vFCefHolrYikusB/u+xHCMILuQLDqwXlg8J0wm3F/3Dtwmv3qGQvTm3w5eAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737085426; c=relaxed/simple;
	bh=1h4n9YUnyTgOiv1u/49sA8L+wmydfrcDmnlWmrk9KSs=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=KXcu9zgiMKQi6AVVt6Y1NPLgJi0p/JQGkkR+emfd69twiwoes9/dQaqUKdBby+GtO3UmtHH7AuC5t2RWnysEAuz7PMOkAZq/oESrMI2W1zUvJWZzshIYfkZzmCteGWi9oxN+kxZN1c8uuAH7/XGjXijyB+r4i+WOQVm9gq6dolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 35c76354d48511efa216b1d71e6e1362-20250117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1851d71d-3d96-47ab-90a7-a00e30e93198,IP:0,U
	RL:0,TC:-7,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-12
X-CID-META: VersionHash:6493067,CLOUDID:94dea84876536e31486c3b5af1465fae,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102,TC:1,Content:0|52,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 35c76354d48511efa216b1d71e6e1362-20250117
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <wangyufeng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 839458787; Fri, 17 Jan 2025 11:43:26 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id B5549B80758A;
	Fri, 17 Jan 2025 11:43:26 +0800 (CST)
Received: by node2.com.cn (NSMail, from userid 0)
	id A3DEFB80758A; Fri, 17 Jan 2025 11:43:26 +0800 (CST)
From: =?UTF-8?B?546L5a6H6ZSL?= <wangyufeng@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSB0b29sczogZml4ZWQgY29tcGlsZSB0b29scy92aXJ0aW8gZXJyb3IgIl9fdXNlciIgcmVkZWZpbmVkIFstV2Vycm9yXQ==?=
To: 	=?UTF-8?B?R3JlZyBLSA==?= <gregkh@linuxfoundation.org>,
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
Date: Fri, 17 Jan 2025 11:43:25 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <2mdx9n9jyjn-2mdyjl2z0dg@nsmail7.0.0--kylin--1>
References: 2025010943-chess-affluent-1bb5@gregkh
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Fri, 17 Jan 2025 11:43:25 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-2pjbhodzbmu-2pjcrm7edgn
X-ns-mid: webmail-6789d1dd-2pdajzgw
X-ope-from: <wangyufeng@kylinos.cn>

This message is in MIME format.

--nsmail-2pjbhodzbmu-2pjcrm7edgn
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+dGhlIGNvbW1pdCBqdXN0IGZpeGUgY29tcGlsZSBlcnJvciBpbiBrZXJu
ZWwvdG9vbHMgZGlyZWN0b3J5IHJ1bm5pbmcgIm1ha2UgdmlydGlvIiw8L3A+
CjxwPjxicj5pdCdzIGhhcmQgdG8gZmluZCBvdXQgdGhlIHdoZW4sIGJ1dCBp
IHdpbGwgdHJ5IHRvIGZpbmQgaXQgb3V0Ljxicj48YnI+PGJyPjxicj48YnI+
LS0tLTwvcD4KPGRpdiBpZD0iY3MyY19tYWlsX3NpZ2F0dXJlIj48L2Rpdj4K
PHA+Jm5ic3A7PC9wPgo8ZGl2IGlkPSJyZSIgc3R5bGU9Im1hcmdpbi1sZWZ0
OiAwLjVlbTsgcGFkZGluZy1sZWZ0OiAwLjVlbTsgYm9yZGVyLWxlZnQ6IDFw
eCBzb2xpZCBncmVlbjsiPjxicj48YnI+PGJyPgo8ZGl2IHN0eWxlPSJiYWNr
Z3JvdW5kLWNvbG9yOiAjZjVmN2ZhOyI+PHN0cm9uZz7kuLvjgIDpopjvvJo8
L3N0cm9uZz48c3BhbiBpZD0ic3ViamVjdCI+UmU6IFtQQVRDSF0gdG9vbHM6
IGZpeGVkIGNvbXBpbGUgdG9vbHMvdmlydGlvIGVycm9yICJfX3VzZXIiIHJl
ZGVmaW5lZCBbLVdlcnJvcl08L3NwYW4+IDxicj48c3Ryb25nPuaXpeOAgOac
n++8mjwvc3Ryb25nPjxzcGFuIGlkPSJkYXRlIj4yMDI1LTAxLTA5IDE3OjE0
PC9zcGFuPiA8YnI+PHN0cm9uZz7lj5Hku7bkurrvvJo8L3N0cm9uZz48c3Bh
biBpZD0iZnJvbSI+R3JlZyBLSDwvc3Bhbj4gPGJyPjxzdHJvbmc+5pS25Lu2
5Lq677yaPC9zdHJvbmc+PHNwYW4gaWQ9InRvIiBzdHlsZT0id29yZC1icmVh
azogYnJlYWstYWxsOyI+546L5a6H6ZSLOzwvc3Bhbj48L2Rpdj4KPGJyPgo8
ZGl2IGlkPSJjb250ZW50Ij4KPGRpdiBjbGFzcz0idmlld2VyX3BhcnQiIHN0
eWxlPSJwb3NpdGlvbjogcmVsYXRpdmU7Ij4KPGRpdj5PbiBUaHUsIEphbiAw
OSwgMjAyNSBhdCAwNDo0Mzo0MVBNICswODAwLCBZdWZlbmcgV2FuZyB3cm90
ZTo8YnI+Jmd0OyB3ZSB1c2UgLVdlcnJvciBub3csIGFuZCB3YXJuaW5ncyBi
cmVhayB0aGUgYnVpbGQgc28gbGV0J3MgZml4ZWQgaXQuPGJyPiZndDsgPGJy
PiZndDsgZnJvbSB2aXJ0aW9fdGVzdC5jOjE3Ojxicj4mZ3Q7IC4vbGludXgv
Li4vLi4vLi4vaW5jbHVkZS9saW51eC9jb21waWxlcl90eXBlcy5oOjQ4OiBl
cnJvcjogIl9fdXNlciIgcmVkZWZpbmVkIFstV2Vycm9yXTxicj4mZ3Q7IDQ4
IHwgIyBkZWZpbmUgX191c2VyIEJURl9UWVBFX1RBRyh1c2VyKTxicj4mZ3Q7
IHw8YnI+Jmd0OyBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vLi4vdXNyL2lu
Y2x1ZGUvbGludXgvc3RhdC5oOjUsPGJyPiZndDsgZnJvbSAvdXNyL2luY2x1
ZGUveDg2XzY0LWxpbnV4LWdudS9iaXRzL3N0YXR4Lmg6MzEsPGJyPiZndDsg
ZnJvbSAvdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudS9zeXMvc3RhdC5o
OjQ2NSw8YnI+Jmd0OyBmcm9tIHZpcnRpb190ZXN0LmM6MTI6PGJyPiZndDsg
Li4vaW5jbHVkZS9saW51eC90eXBlcy5oOjU2OiBub3RlOiB0aGlzIGlzIHRo
ZSBsb2NhdGlvbiBvZiB0aGUgcHJldmlvdXMgZGVmaW5pdGlvbjxicj4mZ3Q7
IDU2IHwgI2RlZmluZSBfX3VzZXI8YnI+Jmd0OyA8YnI+Jmd0OyBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZzxicj4mZ3Q7IDxicj4mZ3Q7IFNpZ25lZC1v
ZmYtYnk6IFl1ZmVuZyBXYW5nIDxicj4mZ3Q7IC0tLTxicj4mZ3Q7IGluY2x1
ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaCB8IDEgKzxicj4mZ3Q7IDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKTxicj4mZ3Q7IDxicj4mZ3Q7IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmggYi9p
bmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmg8YnI+Jmd0OyBpbmRleCA1
ZDY1NDQ1NDU2NTguLjMzMTZlNTYxNDBkNiAxMDA2NDQ8YnI+Jmd0OyAtLS0g
YS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmg8YnI+Jmd0OyArKysg
Yi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyX3R5cGVzLmg8YnI+Jmd0OyBAQCAt
NTQsNiArNTQsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19jaGtfaW9fcHRy
KGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqcHRyKSB7IH08YnI+Jmd0
OyAjIGlmZGVmIFNUUlVDVExFQUtfUExVR0lOPGJyPiZndDsgIyBkZWZpbmUg
X191c2VyIF9fYXR0cmlidXRlX18oKHVzZXIpKTxicj4mZ3Q7ICMgZWxzZTxi
cj4mZ3Q7ICsjIHVuZGVmIF9fdXNlcjxicj4mZ3Q7ICMgZGVmaW5lIF9fdXNl
ciBCVEZfVFlQRV9UQUcodXNlcik8YnI+Jmd0OyAjIGVuZGlmPGJyPiZndDsg
IyBkZWZpbmUgX19pb21lbTxicj4mZ3Q7IC0tIDxicj4mZ3Q7IDIuMzQuMTxi
cj48YnI+V2hhdCBjb21taXQgZG9lcyB0aGlzIGZpeD8gV2h5IGlzIHRoaXMg
c3VkZGVubHkgc2hvd2luZyB1cCBub3c/PGJyPjxicj50aGFua3MsPGJyPjxi
cj5ncmVnIGstaDwvZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvZGl2Pg==

--nsmail-2pjbhodzbmu-2pjcrm7edgn--


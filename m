Return-Path: <stable+bounces-180865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41610B8EA21
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B2B7A4ABA
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22449659;
	Mon, 22 Sep 2025 00:50:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBA82EB10
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502207; cv=none; b=g0LFfnUlj5j6Go8JJKBiES3gcBRwFiT9VnAml4kkZi3C3wnEjEkBs+tTCAmToYAWYzGkel1lR23yH/3GJF7r5gzo/9pI5dbFWmyJayQO23wWeN/rZOjoXCTwByg5AmRXakoEUpkJTlHrZowu+Dftr/LstEHneRk7NM0sybQ7O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502207; c=relaxed/simple;
	bh=dfOjHd92qFVxhXcfKi+jz3DvM2VpBo023wV+c6K7R9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aYac8So/8SG7y+l1EwvtAXWmqM7h1/cMotmbZfbMz799gHyzX0/2jACzjjVUUQKsAEcx5mwcCeFpUS+EloBwy9iVZkANai55Ot31lVjP4rH6YBp+esvP1EV8Zg8Ys3KqNQV4LEg4GvGBTr3ym/obv6OTFZDh+zTy0NZFn1daLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8AxztIyndBoVAINAA--.27687S3;
	Mon, 22 Sep 2025 08:49:54 +0800 (CST)
Received: from chenhuacai$loongson.cn ( [223.64.68.198] ) by
 ajax-webmail-front1 (Coremail) ; Mon, 22 Sep 2025 08:49:52 +0800
 (GMT+08:00)
Date: Mon, 22 Sep 2025 08:49:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: cuitao@kylinos.cn, stable@vger.kernel.org, chenhuacai@kernel.org
Subject: Re: Re: WTF: patch "[PATCH] LoongArch: Replace sprintf() with
 sysfs_emit()" was seriously submitted to be applied to the 6.16-stable
 tree?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2025 www.mailtech.cn loongson
In-Reply-To: <2025092104-stubbly-nimble-b45f@gregkh>
References: <2025092101-lushly-steering-6b45@gregkh>
 <2025092104-stubbly-nimble-b45f@gregkh>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: O1QcPWZvb3Rlcl90eHQ9MjMwNTo2MTg=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4e587b43.187e2.1996ee604c2.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qMiowJAxgcIwndBonmWkAA--.14881W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQEMBmjPk6cEAwABsf
X-Coremail-Antispam: 1Uk129KBj93XoW7ZryftrWrCrW8Kr4rCF1ktFc_yoW8Kw4xpa
	4fAa43KF4kJr1DCw1qka12grWYqa97GF13WFs5Gry8Cas8uFnagFyxZ34xWFyktryrGFy0
	qrs7Kr9xtFW8G3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUdYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAa7VCE64xvF2IEb7IF0Fy264xvF2IEb7IF0Fy264
	kE64k0F2IE7I0Y6sxI4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2
	zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7V
	C2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xv
	F2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1l6VACY4xI67k04243AbIYCTnIWIevJa73UjIFyTuY
	vjxUeNtxUUUUU

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiR3JlZyBLSCIgPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPgo+IOWPkemAgeaXtumXtDoyMDI1LTA5LTIxIDIwOjI2OjI3
ICjmmJ/mnJ/ml6UpCj4g5pS25Lu25Lq6OiBjdWl0YW9Aa3lsaW5vcy5jbiwgY2hlbmh1YWNhaUBs
b29uZ3Nvbi5jbgo+IOaKhOmAgTogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IOS4u+mimDogUmU6
IFdURjogcGF0Y2ggIltQQVRDSF0gTG9vbmdBcmNoOiBSZXBsYWNlIHNwcmludGYoKSB3aXRoIHN5
c2ZzX2VtaXQoKSIgd2FzIHNlcmlvdXNseSBzdWJtaXR0ZWQgdG8gYmUgYXBwbGllZCB0byB0aGUg
Ni4xNi1zdGFibGUgdHJlZT8KPiAKPiBPbiBTdW4sIFNlcCAyMSwgMjAyNSBhdCAwMjoyNDowMVBN
ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToKPiA+IFRoZSBwYXRjaCBi
ZWxvdyB3YXMgc3VibWl0dGVkIHRvIGJlIGFwcGxpZWQgdG8gdGhlIDYuMTYtc3RhYmxlIHRyZWUu
Cj4gPiAKPiA+IEkgZmFpbCB0byBzZWUgaG93IHRoaXMgcGF0Y2ggbWVldHMgdGhlIHN0YWJsZSBr
ZXJuZWwgcnVsZXMgYXMgZm91bmQgYXQKPiA+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFibGUt
a2VybmVsLXJ1bGVzLnJzdC4KPiA+IAo+ID4gSSBjb3VsZCBiZSB0b3RhbGx5IHdyb25nLCBhbmQg
aWYgc28sIHBsZWFzZSByZXNwb25kIHRvIAo+ID4gPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+IGFu
ZCBsZXQgbWUga25vdyB3aHkgdGhpcyBwYXRjaCBzaG91bGQgYmUKPiA+IGFwcGxpZWQuICBPdGhl
cndpc2UsIGl0IGlzIG5vdyBkcm9wcGVkIGZyb20gbXkgcGF0Y2ggcXVldWVzLCBuZXZlciB0byBi
ZQo+ID4gc2VlbiBhZ2Fpbi4KPiA+IAo+ID4gdGhhbmtzLAo+ID4gCj4gPiBncmVnIGstaAo+ID4g
Cj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0gb3JpZ2luYWwgY29tbWl0IGluIExpbnVzJ3MgdHJlZSAt
LS0tLS0tLS0tLS0tLS0tLS0KPiA+IAo+ID4gPkZyb20gZDZkNjlmMGVkZGU2M2I1NTMzNDVkNGVm
YWNlYjdkYWVkODlmZTA0YyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKPiA+IEZyb206IFRhbyBD
dWkgPGN1aXRhb0BreWxpbm9zLmNuPgo+ID4gRGF0ZTogVGh1LCAxOCBTZXAgMjAyNSAxOTo0NDow
NCArMDgwMAo+ID4gU3ViamVjdDogW1BBVENIXSBMb29uZ0FyY2g6IFJlcGxhY2Ugc3ByaW50Zigp
IHdpdGggc3lzZnNfZW1pdCgpCj4gPiAKPiA+IEFzIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMv
c3lzZnMucnN0IHN1Z2dlc3RlZCwgc2hvdygpIHNob3VsZCBvbmx5IHVzZQo+ID4gc3lzZnNfZW1p
dCgpIG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZhbHVlIHRvIGJlIHJl
dHVybmVkCj4gPiB0byB1c2VyIHNwYWNlLgo+ID4gCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBp
bnRlbmRlZC4KPiA+IAo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IFNpZ25lZC1v
ZmYtYnk6IFRhbyBDdWkgPGN1aXRhb0BreWxpbm9zLmNuPgo+ID4gU2lnbmVkLW9mZi1ieTogSHVh
Y2FpIENoZW4gPGNoZW5odWFjYWlAbG9vbmdzb24uY24+Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS9h
cmNoL2xvb25nYXJjaC9rZXJuZWwvZW52LmMgYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwvZW52LmMK
PiA+IGluZGV4IGJlMzA5YTcxZjIwNC4uMjNiZDVhZTIyMTJjIDEwMDY0NAo+ID4gLS0tIGEvYXJj
aC9sb29uZ2FyY2gva2VybmVsL2Vudi5jCj4gPiArKysgYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwv
ZW52LmMKPiA+IEBAIC04Niw3ICs4Niw3IEBAIGxhdGVfaW5pdGNhbGwoZmR0X2NwdV9jbGtfaW5p
dCk7Cj4gPiAgc3RhdGljIHNzaXplX3QgYm9hcmRpbmZvX3Nob3coc3RydWN0IGtvYmplY3QgKmtv
YmosCj4gPiAgCQkJICAgICAgc3RydWN0IGtvYmpfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYp
Cj4gPiAgewo+ID4gLQlyZXR1cm4gc3ByaW50ZihidWYsCj4gPiArCXJldHVybiBzeXNmc19lbWl0
KGJ1ZiwKPiA+ICAJCSJCSU9TIEluZm9ybWF0aW9uXG4iCj4gPiAgCQkiVmVuZG9yXHRcdFx0OiAl
c1xuIgo+ID4gIAkJIlZlcnNpb25cdFx0XHQ6ICVzXG4iCj4gCj4gQWxzbywgdGhpcyBzaG91bGQg
Tk9UIGJlIGEgc3lzZnMgZmlsZS4gIHN5c2ZzIGZpbGVzIGFyZSAib25lIHZhbHVlIHBlcgo+IGZp
bGUiLCB0aGlzIHNob3VsZCBiZSBtdWx0aXBsZSBkaWZmZXJlbnQgc3lzZnMgZmlsZS4gIFBsZWFz
ZSBmaXggdGhhdAo+IHVwLgpIaSwgQ3VpdGFvLAoKUGxlYXNlIGRvdWJsZSBjaGVjayB3aGV0aGVy
IHlvdXIgY29kZSBpcyBjb3JyZWN0LCB0aGFua3MuCgpIdWFjYWkKCj4gCj4gdGhhbmtzLAo+IAo+
IGdyZWcgay1oCg0KDQrmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInpvpnoiq/kuK3np5HnmoTl
lYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJfl
h7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLl
vI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHl
pI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7blj4rlhbbpmYTku7bkuK3nmoTkv6Hmga/jgILlpoLm
npzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xl
j5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bjgIIgDQpUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNo
bWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBMb29uZ3NvbiBUZWNo
bm9sb2d5ICwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkg
d2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQg
dG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uIG9yIGRpc3NlbWlu
YXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlz
IHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRl
IGl0LiANCg0KDQo=



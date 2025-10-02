Return-Path: <stable+bounces-183068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D4BB4482
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D7618986A3
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE49B175D53;
	Thu,  2 Oct 2025 15:13:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9112F184540;
	Thu,  2 Oct 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418019; cv=none; b=XTn4o3LGTI636tKMf//QeBrE+IZk86Tr4Rn2K7mgpiCjXhn/U+1CksZfkyYQhb3+8nlocQ6n0izEiu1cRr/q+KDqFosnuScsijGfy07WLfUr61vy7HjRcY3Za7zhPznQv17/y1WeSLFZt37V+V6JTPwuVDlvJbO3cYi9XIPE1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418019; c=relaxed/simple;
	bh=jnUqkVtqQGG0j0LpBUpBlQXjHhI5qCp0g6JRW363Af8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=VZbISVUs+wARbcPbZaQHAbU7k4tOR5OEicfsv1qiOaIAwIpN+8qc10lCfw7b+HVPsan9TXOlPTFfuFYVD5gxuAxvwIAch1qZ7vCiuUjz3tyZDx2+pRlT0y1HOFIBAR+zjezcY2m2eJcSxjlOfMkk7/n46j5fJZTJTQBnMo5qWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [49.73.248.151])
	by gateway (Coremail) with SMTP id _____8AxB9GUlt5oWrYRAA--.37482S3;
	Thu, 02 Oct 2025 23:13:24 +0800 (CST)
Received: from chenhuacai$loongson.cn ( [49.73.248.151] ) by
 ajax-webmail-front1 (Coremail) ; Thu, 2 Oct 2025 23:13:22 +0800 (GMT+08:00)
Date: Thu, 2 Oct 2025 23:13:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: gregkh@linuxfoundation.org, ojeda@kernel.org, wangrui@loongson.cn,
	yangtiezhu@loongson.cn, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Re: Patch "LoongArch: Handle jump tables options for RUST" has
 been added to the 6.16-stable tree
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2025 www.mailtech.cn loongson
In-Reply-To: <CANiq72kEzOa60EhLQ2YnBOD6bsAHc7qA9v9-MP2FtxMa04Q5PQ@mail.gmail.com>
References: <2025092127-sprint-unwomanly-fc76@gregkh>
 <CANiq72kEzOa60EhLQ2YnBOD6bsAHc7qA9v9-MP2FtxMa04Q5PQ@mail.gmail.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: CKU+YWZvb3Rlcl90eHQ9MTQyMDo2MTg=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3495c3d8.1bf35.199a57c2d8f.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qMiowJBxI+SSlt5o1czHAA--.16708W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQECBmjcwqkItAADsk
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4rZryfurW8ZFW5Aw17twc_yoW8XFW8pF
	9rKa9FgFs8Jr48Ww17KayI9FyYqrZ7G3yxKrn8G34qkr98Zr1YqrWxZrWfuFWqyr95Gw4j
	yws29wn7KFWkAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACY4xI67k04243AV
	AKzVAKj4xxM4xvF2IEb7IF0Fy26I8I3I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCEFcxC
	0VAYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IU8ahF3UUUUU==

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiTWlndWVsIE9qZWRhIiA8
bWlndWVsLm9qZWRhLnNhbmRvbmlzQGdtYWlsLmNvbT4KPiDlj5HpgIHml7bpl7Q6MjAyNS0xMC0w
MiAwMTozOToyNSAo5pif5pyf5ZubKQo+IOaUtuS7tuS6ujogZ3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmcKPiDmioTpgIE6IGNoZW5odWFjYWlAbG9vbmdzb24uY24sIG9qZWRhQGtlcm5lbC5vcmcs
IHdhbmdydWlAbG9vbmdzb24uY24sIHlhbmd0aWV6aHVAbG9vbmdzb24uY24sIHN0YWJsZS1jb21t
aXRzQHZnZXIua2VybmVsLm9yZywgc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IOS4u+mimDogUmU6
IFBhdGNoICJMb29uZ0FyY2g6IEhhbmRsZSBqdW1wIHRhYmxlcyBvcHRpb25zIGZvciBSVVNUIiBo
YXMgYmVlbiBhZGRlZCB0byB0aGUgNi4xNi1zdGFibGUgdHJlZQo+IAo+IE9uIFN1biwgU2VwIDIx
LCAyMDI1IGF0IDM6MDXigK9QTSA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+
ID4KPiA+IFRoaXMgaXMgYSBub3RlIHRvIGxldCB5b3Uga25vdyB0aGF0IEkndmUganVzdCBhZGRl
ZCB0aGUgcGF0Y2ggdGl0bGVkCj4gPgo+ID4gICAgIExvb25nQXJjaDogSGFuZGxlIGp1bXAgdGFi
bGVzIG9wdGlvbnMgZm9yIFJVU1QKPiA+Cj4gPiB0byB0aGUgNi4xNi1zdGFibGUgdHJlZSB3aGlj
aCBjYW4gYmUgZm91bmQgYXQ6Cj4gPiAgICAgaHR0cDovL3d3dy5rZXJuZWwub3JnL2dpdC8/cD1s
aW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9zdGFibGUtcXVldWUuZ2l0O2E9c3VtbWFyeQo+IAo+IC4u
Lgo+IAo+ID4gY29tbWl0IDc0ZjgyOTVjNmZiODQzNmJlYzk5OTViYWY2YmE0NjMxNTFiNmZiNjgg
dXBzdHJlYW0uCj4gCj4gSHVhY2FpIGV0IGFsLjogSSB3b25kZXIgaWYgd2UgY291bGQgZ2V0IHRo
aXMgb25lIGludG8gNi4xMi55PwpJIGFncmVlIHdpdGggeW91LCBpdCBpcyBiZXR0ZXIgdG8gYmFj
a3BvcnQgdG8gNi4xMi55LiBCdXQgaXQgbmVlZHMKIkxvb25nQXJjaDogTWFrZSBMVE8gY2FzZSBp
bmRlcGVuZGVudCBpbiBNYWtlZmlsZSIgYXMgaXRzIGRlcGVuZGVuY3ksCmFuZCBuZWVkICJMb29u
Z0FyY2g6IEZpeCBidWlsZCBlcnJvciBmb3IgTFRPIHdpdGggTExWTS0xOCIgYXMgYSBmdXJ0aGVy
CmZpeC4KCkh1YWNhaQoKPiAKPiBNYXliZSBubyBvbmUgYWN0dWFsbHkgY2FyZXMgaW4gcHJhY3Rp
Y2UsIHNvIHBsZWFzZSBmZWVsIGZyZWUgdG8gaWdub3JlCj4gaXQsIGJ1dCBpdCBpcyB0aGUgb25s
eSBgb2JqdG9vbGAgd2FybmluZyAoYSBsb3Qgb2YgaW5zdGFuY2VzLCBidXQganVzdAo+IHRoYXQg
a2luZCBmcm9tIGEgcXVpY2sgbG9vaykgSSBoYXZlIGluIG15IExvb25nQXJjaCBSdXN0IGJ1aWxk
cyBJIGhhdmUKPiBpbiA2LjEyLnksIGFuZCBpdCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUgaXQgY2xl
YW4uCj4gCj4gVGhhbmtzIQo+IAo+IENoZWVycywKPiBNaWd1ZWwKDQoNCuacrOmCruS7tuWPiuWF
tumZhOS7tuWQq+aciem+meiKr+S4reenkeeahOWVhuS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6
juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeat
ouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6
juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuaIluaVo+WPke+8ieacrOmCruS7tuWP
iuWFtumZhOS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuacrOmCruS7tu+8jOivt+aC
qOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuOA
giANClRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBp
bmZvcm1hdGlvbiBmcm9tIExvb25nc29uIFRlY2hub2xvZ3kgLCB3aGljaCBpcyBpbnRlbmRlZCBv
bmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92
ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5
IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9z
dXJlLCByZXByb2R1Y3Rpb24gb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFu
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUg
dGhpcyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9y
IGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQuIA0KDQoNCg==



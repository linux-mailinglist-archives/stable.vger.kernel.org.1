Return-Path: <stable+bounces-181665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455EDB9CFC4
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 03:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C24382C97
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 01:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235A2DCF78;
	Thu, 25 Sep 2025 01:12:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222DE78F3A
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762760; cv=none; b=ZFslZMJLw2OUTviFmt3JZkP3WOS9UTX8B+aiCns4rMaoVBWcDWtZkGat7kf+wJJSbtEbffNJe+EhZ4rZ1UF2yq9lcP1GF2ciaC/C6WyIAkItI8ISL+MnKYeUTjaV8rtYA43c96cmHjTcHe72zxJdv+HGnB0XRR049u+JJ+htVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762760; c=relaxed/simple;
	bh=66JPYFEqNXCGQ+7v373TUbAV7BOdfl/J06T7IuWTc4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=qzOGdCS8GtTIFAteSsYvZB0mSZ9OK3NFdXrbzoAdEHznvMSA2hkU90XdlKQoSTXw0DaVqWx6GasHYRWfKOg6MZpBuRD3wiRGzPkSvsgbGNjkIdSGSpfp57Z9nvrn4gjAe8pxugUckn1Kk12C229hZW+50QHkhu7VJ/UKPgEemJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8AxidEBl9Ro7FkOAA--.30865S3;
	Thu, 25 Sep 2025 09:12:33 +0800 (CST)
Received: from chenhuacai$loongson.cn ( [223.64.68.198] ) by
 ajax-webmail-front1 (Coremail) ; Thu, 25 Sep 2025 09:12:32 +0800
 (GMT+08:00)
Date: Thu, 25 Sep 2025 09:12:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To: gregkh@linuxfoundation.org
Cc: cuitao@kylinos.cn, maobibo@loongson.cn, stable@vger.kernel.org
Subject: Re: WTF: patch "[PATCH] LoongArch: KVM: Remove unused returns and
 semicolons" was seriously submitted to be applied to the 6.16-stable tree?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2025 www.mailtech.cn loongson
In-Reply-To: <2025092117-veto-napping-489f@gregkh>
References: <2025092117-veto-napping-489f@gregkh>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: 8dEslGZvb3Rlcl90eHQ9MTk1NDo2MTg=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <479ab56b.19696.1997e6ddb2d.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qMiowJCx78MAl9RoEPetAA--.15421W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQEQBmjTiCgSxQACsY
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw15uF48Zw1kuFyrAF17XFc_yoW8urWrp3
	ZxAwnxKa1UWrn7AwnrA3409FWkZa97CrnxKFZ8tFyku3Z8uw1rJFyfX3y8WF98tFyrGa47
	XrsrKryqkF48J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4xvF2IEb7IF0F
	y264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr1l6VAC
	Y4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvjxU2vtCDUUUU

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZwo+IOWPkemAgeaXtumXtDoyMDI1LTA5LTIxIDIwOjI0OjE3ICjmmJ/mnJ/ml6Up
Cj4g5pS25Lu25Lq6OiBjdWl0YW9Aa3lsaW5vcy5jbiwgY2hlbmh1YWNhaUBsb29uZ3Nvbi5jbiwg
bWFvYmlib0Bsb29uZ3Nvbi5jbgo+IOaKhOmAgTogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IOS4
u+mimDogV1RGOiBwYXRjaCAiW1BBVENIXSBMb29uZ0FyY2g6IEtWTTogUmVtb3ZlIHVudXNlZCBy
ZXR1cm5zIGFuZCBzZW1pY29sb25zIiB3YXMgc2VyaW91c2x5IHN1Ym1pdHRlZCB0byBiZSBhcHBs
aWVkIHRvIHRoZSA2LjE2LXN0YWJsZSB0cmVlPwo+IAo+IFRoZSBwYXRjaCBiZWxvdyB3YXMgc3Vi
bWl0dGVkIHRvIGJlIGFwcGxpZWQgdG8gdGhlIDYuMTYtc3RhYmxlIHRyZWUuCj4gCj4gSSBmYWls
IHRvIHNlZSBob3cgdGhpcyBwYXRjaCBtZWV0cyB0aGUgc3RhYmxlIGtlcm5lbCBydWxlcyBhcyBm
b3VuZCBhdAo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLnJzdC4K
SSdtIHNvcnJ5LCBtYXliZSBJIHdhcyB3cm9uZy4gSSB0aG91Z2h0IGZpeCBjb2Rpbmcgc3R5bGUg
aXMgYWxzbyBhIHR5cGUgb2YgZml4LgoKSHVhY2FpCgo+IAo+IEkgY291bGQgYmUgdG90YWxseSB3
cm9uZywgYW5kIGlmIHNvLCBwbGVhc2UgcmVzcG9uZCB0byAKPiA8c3RhYmxlQHZnZXIua2VybmVs
Lm9yZz4gYW5kIGxldCBtZSBrbm93IHdoeSB0aGlzIHBhdGNoIHNob3VsZCBiZQo+IGFwcGxpZWQu
ICBPdGhlcndpc2UsIGl0IGlzIG5vdyBkcm9wcGVkIGZyb20gbXkgcGF0Y2ggcXVldWVzLCBuZXZl
ciB0byBiZQo+IHNlZW4gYWdhaW4uCj4gCj4gdGhhbmtzLAo+IAo+IGdyZWcgay1oCj4gCj4gLS0t
LS0tLS0tLS0tLS0tLS0tIG9yaWdpbmFsIGNvbW1pdCBpbiBMaW51cydzIHRyZWUgLS0tLS0tLS0t
LS0tLS0tLS0tCj4gCj4gRnJvbSAwOTFiMjlkNTNmZTY0NTc4MWM1YzFmNDA1YmM5ZmNkNTBjZTU3
OTJiIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQo+IEZyb206IFRhbyBDdWkgPGN1aXRhb0BreWxp
bm9zLmNuPgo+IERhdGU6IFRodSwgMTggU2VwIDIwMjUgMTk6NDQ6MjIgKzA4MDAKPiBTdWJqZWN0
OiBbUEFUQ0hdIExvb25nQXJjaDogS1ZNOiBSZW1vdmUgdW51c2VkIHJldHVybnMgYW5kIHNlbWlj
b2xvbnMKPiAKPiBUaGUgZGVmYXVsdCBicmFuY2ggaGFzIGFscmVhZHkgaGFuZGxlZCBhbGwgdW5k
ZWZpbmVkIGNhc2VzLCBzbyB0aGUgZmluYWwKPiByZXR1cm4gc3RhdGVtZW50IGlzIHJlZHVuZGFu
dC4gUmVkdW5kYW50IHNlbWljb2xvbnMgYXJlIHJlbW92ZWQsIHRvby4KPiAKPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwo+IFJldmlld2VkLWJ5OiBCaWJvIE1hbyA8bWFvYmlib0Bsb29uZ3Nv
bi5jbj4KPiBTaWduZWQtb2ZmLWJ5OiBUYW8gQ3VpIDxjdWl0YW9Aa3lsaW5vcy5jbj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNhaUBsb29uZ3Nvbi5jbj4KPiAKPiBkaWZm
IC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gva3ZtL2V4aXQuYyBiL2FyY2gvbG9vbmdhcmNoL2t2bS9l
eGl0LmMKPiBpbmRleCAyY2U0MWY5M2IyYTQuLjZjOWM3ZGU3MjI2YiAxMDA2NDQKPiAtLS0gYS9h
cmNoL2xvb25nYXJjaC9rdm0vZXhpdC5jCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gva3ZtL2V4aXQu
Ywo+IEBAIC03NzgsMTAgKzc3OCw4IEBAIHN0YXRpYyBsb25nIGt2bV9zYXZlX25vdGlmeShzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUpCj4gIAkJcmV0dXJuIDA7Cj4gIAlkZWZhdWx0Ogo+ICAJCXJldHVy
biBLVk1fSENBTExfSU5WQUxJRF9DT0RFOwo+IC0JfTsKPiAtCj4gLQlyZXR1cm4gS1ZNX0hDQUxM
X0lOVkFMSURfQ09ERTsKPiAtfTsKPiArCX0KPiArfQo+ICAKPiAgLyoKPiAgICoga3ZtX2hhbmRs
ZV9sc3hfZGlzYWJsZWQoKSAtIEd1ZXN0IHVzZWQgTFNYIHdoaWxlIGRpc2FibGVkIGluIHJvb3Qu
Cg0KDQrmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInpvpnoiq/kuK3np5HnmoTllYbkuJrnp5jl
r4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrk
urrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjv
vIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbmiJbm
laPlj5HvvInmnKzpgq7ku7blj4rlhbbpmYTku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnm
lLbmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrl
ubbliKDpmaTmnKzpgq7ku7bjgIIgDQpUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29u
dGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBMb29uZ3NvbiBUZWNobm9sb2d5ICwg
d2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRk
cmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5l
ZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFs
IG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uIG9yIGRpc3NlbWluYXRpb24pIGJ5
IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0
ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0LiANCg0K
DQo=



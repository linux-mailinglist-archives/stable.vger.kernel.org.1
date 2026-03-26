Return-Path: <stable+bounces-230402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZWVFBBqIxGnB0AQAu9opvQ
	(envelope-from <stable+bounces-230402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:12:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56932DC5B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F103B3034646
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47B2E2663;
	Thu, 26 Mar 2026 01:12:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399F20C012;
	Thu, 26 Mar 2026 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774487571; cv=none; b=mFGgXfMq9rR+jDMP1fXpBlG0ngIoeJwS7x//vymPFSjqYhVGV/tgYXP/VlXSIsdR/Gdcn6kK6b3wN8GevaxN0M+UBLXa52IAxcw710/0TYCrrE+z3kgLoUrwQDFMvpbjSC6G2JmkvTCbX+Kq5c5pGAVzLv3100vsmtL6mmOtsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774487571; c=relaxed/simple;
	bh=mSNQB/kyfeHjvhCQ1N6GTP8BpN+Ju2famxd6FScXTUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DRxU4+9DFPS3/77wf0lD9BDcdFrjqPPROg2nUWfJOOypLw6ZwVe29FkCxwwmwIAT0HBFn/FrzjXH2cX86nxMAhkfy1H+awrJ0NP5+Dq9i1P7O1W3e/EzBvocLR5rka9i8STPx4IUOYHdZAUXsfpsHKOedJkmr9SRFYoCC2N8zCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.17])
	by gateway (Coremail) with SMTP id _____8Bx36sJiMRpk8QeAA--.28946S3;
	Thu, 26 Mar 2026 09:12:41 +0800 (CST)
Received: from chenhuacai$loongson.cn ( [223.64.68.17] ) by
 ajax-webmail-front1 (Coremail) ; Thu, 26 Mar 2026 09:12:22 +0800
 (GMT+08:00)
Date: Thu, 26 Mar 2026 09:12:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To: "Miguel Ojeda" <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org,
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com,
	hargar@microsoft.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, linux@roeck-us.net,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
	shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
	"Tianyang Zhang" <zhangtianyang@loongson.cn>
Subject: Re: Re: [PATCH 6.12 000/460] 6.12.78-rc1 review
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250609(354f7833) Copyright (c) 2002-2026 www.mailtech.cn loongson
In-Reply-To: <20260325000600.57287-1-ojeda@kernel.org>
References: <20260323134526.647552166@linuxfoundation.org>
 <20260325000600.57287-1-ojeda@kernel.org>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: CfmPV2Zvb3Rlcl90eHQ9MjM0ODo2MTg=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7f616aa1.4eda2.19d27b31b8c.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qMiowJDxKOD2h8Rp5oZdAA--.15631W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAgESBmnDeSQV0QABsl
X-Coremail-Antispam: 1Uk129KBj93XoW7KF15KF4kAr1xCF48ur43twc_yoW5JFWfpF
	W7Gr4DWa10qwn7Can7u34j9FyUX3Z5CasIgrs5G3s5uF98ur1jqrn7ZFZ8uFn8KryvgF1j
	vFnrXas2ga45J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUA529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUQIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwCY1x0262kKe7AKxVW8
	ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxV
	WUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UMVCEFcxC0V
	AYjxAxZFUvcSsGvfC2KfnxnUUI43ZEXa7IUehiSJUUUUU==
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230402-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@loongson.cn,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,loongson.cn];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A56932DC5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGksIEdyZWcsIFNhc2hhLAoKCj4gLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQo+IOWPkeS7tuS6ujog
Ik1pZ3VlbCBPamVkYSIgPG9qZWRhQGtlcm5lbC5vcmc+Cj4g5Y+R6YCB5pe26Ze0OjIwMjYtMDMt
MjUgMDg6MDY6MDAgKOaYn+acn+S4iSkKPiDmlLbku7bkuro6IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnCj4g5oqE6YCBOiBhY2hpbGxAYWNoaWxsLm9yZywgYWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZywgYnJvb25pZUBrZXJuZWwub3JnLCBjb25vckBrZXJuZWwub3JnLCBmLmZhaW5lbGxpQGdt
YWlsLmNvbSwgaGFyZ2FyQG1pY3Jvc29mdC5jb20sIGpvbmF0aGFuaEBudmlkaWEuY29tLCBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBsaW51eEByb2Vjay11cy5uZXQsIGxrZnQtdHJpYWdl
QGxpc3RzLmxpbmFyby5vcmcsIHBhdGNoZXNAa2VybmVsY2kub3JnLCBwYXRjaGVzQGxpc3RzLmxp
bnV4LmRldiwgcGF2ZWxAbmFibGFkZXYuY29tLCByd2Fyc293QGdteC5kZSwgc2h1YWhAa2VybmVs
Lm9yZywgc3JAc2xhZGV3YXRraW5zLmNvbSwgc3RhYmxlQHZnZXIua2VybmVsLm9yZywgc3VkaXBt
Lm11a2hlcmplZUBnbWFpbC5jb20sIHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnLCAiTWln
dWVsIE9qZWRhIiA8b2plZGFAa2VybmVsLm9yZz4sICJIdWFjYWkgQ2hlbiIgPGNoZW5odWFjYWlA
bG9vbmdzb24uY24+LCAiVGlhbnlhbmcgWmhhbmciIDx6aGFuZ3RpYW55YW5nQGxvb25nc29uLmNu
Pgo+IOS4u+mimDogUmU6IFtQQVRDSCA2LjEyIDAwMC80NjBdIDYuMTIuNzgtcmMxIHJldmlldwo+
IAo+IE9uIE1vbiwgMjMgTWFyIDIwMjYgMTQ6Mzk6NTYgKzAxMDAgR3JlZyBLcm9haC1IYXJ0bWFu
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gPgo+ID4gVGhpcyBpcyB0aGUg
c3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcgY3ljbGUgZm9yIHRoZSA2LjEyLjc4IHJlbGVhc2Uu
Cj4gPiBUaGVyZSBhcmUgNDYwIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMsIGFsbCB3aWxsIGJlIHBv
c3RlZCBhcyBhIHJlc3BvbnNlCj4gPiB0byB0aGlzIG9uZS4gIElmIGFueW9uZSBoYXMgYW55IGlz
c3VlcyB3aXRoIHRoZXNlIGJlaW5nIGFwcGxpZWQsIHBsZWFzZQo+ID4gbGV0IG1lIGtub3cuCj4g
Pgo+ID4gUmVzcG9uc2VzIHNob3VsZCBiZSBtYWRlIGJ5IFdlZCwgMjUgTWFyIDIwMjYgMTM6NDQ6
MzMgKzAwMDAuCj4gPiBBbnl0aGluZyByZWNlaXZlZCBhZnRlciB0aGF0IHRpbWUgbWlnaHQgYmUg
dG9vIGxhdGUuCj4gCj4gQm9vdC10ZXN0ZWQgdW5kZXIgUUVNVSBmb3IgUnVzdCB4ODZfNjQsIGFy
bTY0IGFuZCByaXNjdjY0OyBidWlsdC10ZXN0ZWQKPiBmb3IgbG9vbmdhcmNoNjQ6Cj4gCj4gVGVz
dGVkLWJ5OiBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5vcmc+Cj4gCj4gbG9vbmdhcmNoNjQg
ZmFpbGVkIHRvIGJ1aWxkIGZvciBtZToKPiAKPiAgICAgYXJjaC9sb29uZ2FyY2gva2VybmVsL21h
Y2hpbmVfa2V4ZWMuYzoxMzk6MTM6IGVycm9yOiBzdGF0aWMgZGVjbGFyYXRpb24gb2YgJ21hY2hp
bmVfa2V4ZWNfbWFza19pbnRlcnJ1cHRzJyBmb2xsb3dzIG5vbi1zdGF0aWMgZGVjbGFyYXRpb24K
PiAgICAgICAxMzkgfCBzdGF0aWMgdm9pZCBtYWNoaW5lX2tleGVjX21hc2tfaW50ZXJydXB0cyh2
b2lkKQo+ICAgICAgICAgICB8ICAgICAgICAgICAgIF4KPiAgICAgLi9pbmNsdWRlL2xpbnV4L2ly
cS5oOjY5ODoxMzogbm90ZTogcHJldmlvdXMgZGVjbGFyYXRpb24gaXMgaGVyZQo+ICAgICAgIDY5
OCB8IGV4dGVybiB2b2lkIG1hY2hpbmVfa2V4ZWNfbWFza19pbnRlcnJ1cHRzKHZvaWQpOwo+ICAg
ICAgICAgICB8ICAgICAgICAgICAgIF4KPiAKPiBUaGUgYHN0YXRpYyB2b2lkIG1hY2hpbmVfa2V4
ZWNfbWFza19pbnRlcnJ1cHRzKHZvaWQpYCBmb3IgbG9vbmdhcmNoNjQKPiB3YXMgbm90IHJlbW92
ZWQgYmVjYXVzZSBpdCB3YXMgYWRqdXN0ZWQgaW46Cj4gCj4gICA0MjliZjNmMDRjMjQgKCJMb29u
Z0FyY2g6IEFkZCBtYWNoaW5lX2tleGVjX21hc2tfaW50ZXJydXB0cygpIGltcGxlbWVudGF0aW9u
IikKWWVzLCA0MjliZjNmMDRjMjQgKCJMb29uZ0FyY2g6IEFkZCBtYWNoaW5lX2tleGVjX21hc2tf
aW50ZXJydXB0cygpIGltcGxlbWVudGF0aW9uIikKc2hvdWxkIGJlIHJldmVydGVkIGZvciB0aGlz
IHZlcnNpb24uIEJ1dCB3aHkgeW91IGlnbm9yZSBNaWd1ZWwncyByZXBvcnQ/CgpIdWFjYWkKCj4g
Cj4gd2hpY2ggaXMgb25seSBpbiA2LjEyLgo+IAo+IENjOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1YWNh
aUBsb29uZ3Nvbi5jbj4KPiBDYzogVGlhbnlhbmcgWmhhbmcgPHpoYW5ndGlhbnlhbmdAbG9vbmdz
b24uY24+Cj4gCj4gSSBob3BlIHRoYXQgaGVscHMhCj4gCj4gQ2hlZXJzLAo+IE1pZ3VlbAoNCg0K
5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ6b6Z6Iqv5Lit56eR55qE5ZWG5Lia56eY5a+G5L+h
5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW
576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So77yI5YyF
5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi25oiW5pWj5Y+R
77yJ5pys6YKu5Lu25Y+K5YW26ZmE5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25pys
6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig
6Zmk5pys6YKu5Lu244CCIA0KVGhpcyBlbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4g
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gTG9vbmdzb24gVGVjaG5vbG9neSAsIHdoaWNo
IGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3Mg
aXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVy
ZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBw
YXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJz
b25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJ
ZiB5b3UgcmVjZWl2ZSB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5k
ZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdC4gDQoNCg0K



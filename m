Return-Path: <stable+bounces-106245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F729FE23B
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 04:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FE9161D0B
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 03:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979ED13CA81;
	Mon, 30 Dec 2024 03:27:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476E1F957
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735529255; cv=none; b=KX3aP2VryOtFtU7ke5WSV6W2Cd4JVpJJzp11kQ70K76fIYci4UK9TVVVpNwCL4HlGHS8q/f0wI0Ivg1FkXf0G/Zdc3oxbCpiWRX3ZOHONk8yWtGp70AiTChdN0HtqCVPABelb7ROM1m9emjOTJ1fnXi+qR+YfAaXn90SCwuV0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735529255; c=relaxed/simple;
	bh=7ghPPqj+lYqFrPIs/mLFzNBTu8aqTRS2fIy9inPKJj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ff2mya4vL4pulJo13cMjN8LFKit6mW7VD6eT17VfUi0s8sGfqBnszPw+RRxZ1nv+H9DxOPwwGutcABOlEK0bDuysLy0fKOpdSL0D6Il36ylAdDcsRnH2xtA3AtUqyKCYsj83vKBGslbub6Dy5/cv7ohy5Kksa0pJFTP9QdCQ1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.63])
	by gateway (Coremail) with SMTP id _____8CxPuMhE3JnLa1bAA--.48201S3;
	Mon, 30 Dec 2024 11:27:29 +0800 (CST)
Received: from zhoubinbin$loongson.cn ( [223.64.68.63] ) by
 ajax-webmail-front1 (Coremail) ; Mon, 30 Dec 2024 11:27:28 +0800
 (GMT+08:00)
Date: Mon, 30 Dec 2024 11:27:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5ZGo5b2s5b2s?= <zhoubinbin@loongson.cn>
To: "Sasha Levin" <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Dan Carpenter" <dan.carpenter@linaro.org>,
	"Vinod Koul" <vkoul@kernel.org>
Subject: Re: Re: [PATCH 6.12.y] dmaengine: loongson2-apb: Change GENMASK to
 GENMASK_ULL
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240729(6d2960c6) Copyright (c) 2002-2024 www.mailtech.cn loongson
In-Reply-To: <Z3IRGGQ0iqya5jnA@lappy>
References: <2024122721-badge-research-e542@gregkh>
 <20241230013919.1086511-1-zhoubinbin@loongson.cn> <Z3IRGGQ0iqya5jnA@lappy>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: nlpx9mZvb3Rlcl90eHQ9MTc0Nzo2MTg=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3eea8e9e.167b7.194159ab5e0.Coremail.zhoubinbin@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qMiowMBxD8YgE3JnNGMNAA--.2561W
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEHCGdx0MMDdAACs-
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWxJFy3WFy8Ww13Xr4xAFc_yoW8Zr17pr
	y3Gw1qkr1UtryUC3s5G342vFy5J3sxJrZrWFsxtr1rAF98Z3Wvq34fZrWfWF42kryF9ryj
	q397Xr1jkayUJacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUQYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1lnx0E6VACY4xI67k04243AVACY4xI67k04243AVAKzVAKj4xI6x02cVCv0x
	Wle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACY4xI67k04243AVAKzVAK
	j4xxM4xvF2IEb7IF0Fy26I8I3I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCEFcxC0VAYjx
	AxZFUvcSsGvfC2KfnxnUUI43ZEXa7IUUiID5UUUUU==

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiU2FzaGEgTGV2aW4iIDxz
YXNoYWxAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6MjAyNC0xMi0zMCAxMToxODo0OCAo5pif
5pyf5LiAKQo+IOaUtuS7tuS6ujogIkJpbmJpbiBaaG91IiA8emhvdWJpbmJpbkBsb29uZ3Nvbi5j
bj4KPiDmioTpgIE6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcsICJEYW4gQ2FycGVudGVyIiA8ZGFu
LmNhcnBlbnRlckBsaW5hcm8ub3JnPiwgIlZpbm9kIEtvdWwiIDx2a291bEBrZXJuZWwub3JnPgo+
IOS4u+mimDogUmU6IFtQQVRDSCA2LjEyLnldIGRtYWVuZ2luZTogbG9vbmdzb24yLWFwYjogQ2hh
bmdlIEdFTk1BU0sgdG8gR0VOTUFTS19VTEwKPiAKPiBPbiBNb24sIERlYyAzMCwgMjAyNCBhdCAw
OTozOToxOUFNICswODAwLCBCaW5iaW4gWmhvdSB3cm90ZToKPiA+Rml4IHRoZSBmb2xsb3dpbmcg
c21hdGNoIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6Cj4gPgo+ID5kcml2ZXJzL2RtYS9sb29uZ3Nv
bjItYXBiLWRtYS5jOjE4OSBsczJ4X2RtYV93cml0ZV9jbWQoKQo+ID53YXJuOiB3YXMgZXhwZWN0
aW5nIGEgNjQgYml0IHZhbHVlIGluc3RlYWQgb2YgJ34oKCgwKSkgKyAoKCh+KCgwKSkpIC0gKCgo
MSkpIDw8ICgwKSkgKyAxKSAmICh+KCgwKSkgPj4gKCg4ICogNCkgLSAxIC0gKDQpKSkpKScKPiA+
Cj4gPlRoZSBHRU5NQVNLIG1hY3JvIHVzZWQgInVuc2lnbmVkIGxvbmciLCB3aGljaCBjYXVzZWQg
YnVpbGQgaXNzdWVzIHdoZW4KPiA+dXNpbmcgYSAzMi1iaXQgdG9vbGNoYWluIGJlY2F1c2UgaXQg
d291bGQgdHJ5IHRvIGFjY2VzcyBiaXRzID4gMzEuIFRoaXMKPiA+cGF0Y2ggc3dpdGNoZXMgR0VO
TUFTSyB0byBHRU5NQVNLX1VMTCwgd2hpY2ggdXNlcyAidW5zaWduZWQgbG9uZyBsb25nIi4KPiA+
Cj4gPkZpeGVzOiA3MWU3ZDNjYjZlNTUgKCJkbWFlbmdpbmU6IGxzMngtYXBiOiBOZXcgZHJpdmVy
IGZvciB0aGUgTG9vbmdzb24gTFMyWCBBUEIgRE1BIGNvbnRyb2xsZXIiKQo+ID5SZXBvcnRlZC1i
eTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPgo+ID5DbG9zZXM6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84N2NkYzAyNS03MjQ2LTQ1NDgtODVjYS0zZDM2ZmRj
MmJlMmRAc3RhbmxleS5tb3VudGFpbi8KPiA+U2lnbmVkLW9mZi1ieTogQmluYmluIFpob3UgPHpo
b3ViaW5iaW5AbG9vbmdzb24uY24+Cj4gPkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyNDEwMjgwOTM0MTMuMTE0NTgyMC0xLXpob3ViaW5iaW5AbG9vbmdzb24uY24KPiA+U2lnbmVk
LW9mZi1ieTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4KPiA+KGNoZXJyeSBwaWNrZWQg
ZnJvbSBjb21taXQgNGI2NWQ1MzIyZTFkODk5NGFjZmRiOWI4NjdhYTAwYmRiMzBkMTc3YikKPiAK
PiBJJ2xsIHF1ZXVlIGl0IHVwLCBidXQgcGxlYXNlIHJlYWQKPiBodHRwczovL3d3dy5rZXJuZWwu
b3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N0YWJsZS1rZXJuZWwtcnVsZXMuaHRtbCNvcHRp
b24tMwo+IAoKSGkgU2FzaGE6CgpUaGFua3MgZm9yIHRoZSBoZWFkcyB1cC4KSSBhcG9sb2dpemUg
Zm9yIG15IGlycmVndWxhcml0eSwgYWx0aG91Z2ggdGhpcyBpcyB0aGUgZmlyc3QgdGltZSBJJ3Zl
IHN1Ym1pdHRlZCBhIHBhdGNoIHRvIHN0YWJsZSB0cmVlLgpBbmQgSSB3aWxsIHJlYWQgdGhlIGRv
Y3VtZW50YXRpb24gYWJvdXQgdGhpcyBwYXJ0IGNhcmVmdWxseS4KClRoYW5rcy4KQmluYmluCj4g
LS0gCj4gVGhhbmtzLAo+IFNhc2hhCg0KDQrmnKzpgq7ku7blj4rlhbbpmYTku7blkKvmnInpvpno
iq/kuK3np5HnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLl
nLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrk
u6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIbl
nLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7ku7blj4rlhbbpmYTku7bkuK3nmoTk
v6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbp
gq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bjgIIgDQpUaGlzIGVtYWlsIGFu
ZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBM
b29uZ3NvbiBUZWNobm9sb2d5ICwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNv
biBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhl
IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQg
bm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9u
IG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVj
aXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZW1haWwgaW4gZXJy
b3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVs
eSBhbmQgZGVsZXRlIGl0LiANCg0KDQo=



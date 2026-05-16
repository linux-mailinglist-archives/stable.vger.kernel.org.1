Return-Path: <stable+bounces-248960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fj9KHPLB2pRJAMAu9opvQ
	(envelope-from <stable+bounces-248960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 03:42:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4818B559CD1
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B83F301CCC5
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277725A2B5;
	Sat, 16 May 2026 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ma7eL60e"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCEC405C53;
	Sat, 16 May 2026 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778895718; cv=none; b=NzVrXNlLIL1yGnE01W18aVpNqW5OIwTfRg+5xEWXPC0Eqtpo1tL8qOB2Ay/LnlBTJxRXheMVYxtrPvbbRfrPfykk6jMhtg4QSHoGnr/y1OK3cxV1lr/3VOP20Q109KPvdfPX6nCFH6pp9tF9oYKkyBdwM7kqrfZyToiiWh6tcFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778895718; c=relaxed/simple;
	bh=KDi9SfdqS9I9PezTeXpSpUOwHBibeB5jFFYuVLSujiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=XYd46I7VFu+PeLKETbhCsYNfLdgqyeLEBUtPl1uBoj+5WoTELpCHR4Lz7r+U77Zis7tLDlbE/u1DEeDjjbjCBIl5kb6U85Uc+2naSEbC6dk8WCQ8XYYqun7z2t2w+nIeDQMAp5Vn6qMFMDVq62FLuJ43xeqVrFnkcci2am9DMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ma7eL60e; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=KDi9SfdqS9I9PezTeXpSpUOwHBibeB5jFFYuVLSujiw=; b=m
	a7eL60eqFWO5mlRIlFW+tK2ei3X2OLDQT8q628VEXhS+I5+RRK+6w+KUSHg08P6k
	CUXCFi9XWEXQRZU98XjVpZTVOifJl1V3oj6vCtjwa3bt5y3b8J1OKO85yFUxBzFx
	71cD0zxRXah3wma/x49PCqnfnQ98t6UKfrsVGdVKz8=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-106 (Coremail) ; Sat, 16 May 2026 09:41:18 +0800
 (CST)
Date: Sat, 16 May 2026 09:41:18 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: pmenzel@molgen.mpg.de, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, greg@kroah.com, stable@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:Re: [PATCH v4] Bluetooth: hci_uart: fix UAF in
 hci_uart_tty_close()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
References: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
 <20260515140548.393865-1-w15303746062@163.com>
 <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
X-NTES-SC: AL_Qu2cCvSSuk4s7iebbekfmU0Qguw9Xcq5uPkj34FWN5t8jCDp6AkFeXhTAFnX++eoFB6+mRKZdCV3+PhceaBDXJgs7rlVqWod9PqHg2h4PmBuwQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <485d0dd5.660.19e2e71ed1e.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgD3n2o_ywdqrQ6kAA--.196W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAB9eQmoHyz9qZgAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Queue-Id: 4818B559CD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248960-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

CkhpIEx1aXosCgpUaGFuayB5b3UgZm9yIGNoZWNraW5nIGl0IHdpdGggU2FzaGlrby4KCgpBdCAy
MDI2LTA1LTE2IDAwOjA4OjA1LCAiTHVpeiBBdWd1c3RvIHZvbiBEZW50eiIgPGx1aXouZGVudHpA
Z21haWwuY29tPiB3cm90ZToKPkhpLAo+Cj5PbiBGcmksIE1heSAxNSwgMjAyNiBhdCAxMDowNuKA
r0FNIDx3MTUzMDM3NDYwNjJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IEZyb206IE1pbmd5dSBXYW5n
IDwyNTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KPj4KPj4gQSBVc2UtQWZ0ZXItRnJlZSAo
VUFGKSB2dWxuZXJhYmlsaXR5IGFuZCBhIHN1YnNlcXVlbnQga2VybmVsIHBhbmljIHdlcmUKPj4g
b2JzZXJ2ZWQgaW4gaGNpX3VhcnRfd3JpdGVfd29yaygpIGR1ZSB0byBhIHJhY2UgY29uZGl0aW9u
IGJldHdlZW4gdGhlCj4+IGluaXRpYWxpemF0aW9uIG9mIHRoZSBIQ0kgVUFSVCBsaW5lIGRpc2Np
cGxpbmUgYW5kIGNvbmN1cnJlbnQgVFRZIGhhbmd1cC4KPj4KPj4gVGhpcyBpc3N1ZSB3YXMgdHJp
Z2dlcmVkIGJ5IG91ciBjdXN0b20gZGV2aWNlIGVtdWxhdGlvbiBhbmQgZnV6emluZwo+PiBmcmFt
ZXdvcmsgKERldkdlbikgb24gdGhlIHY2LjE4IGtlcm5lbC4gRHVlIHRvIHRoZSBoaWdobHkgdGlt
aW5nLWRlcGVuZGVudAo+PiBuYXR1cmUgb2YgdGhpcyByYWNlIGNvbmRpdGlvbiAocmVxdWlyaW5n
IGEgcHJlY2lzZSBpbnRlcmxlYXZpbmcgb2YKPj4gVElPQ1ZIQU5HVVAgYW5kIHByb3RvY29sIHNl
dHVwKSwgU3l6a2FsbGVyIGZhaWxlZCB0byBleHRyYWN0IGEgcmVsaWFibGUKPj4gc3RhbmRhbG9u
ZSBDIHJlcHJvZHVjZXIgKHJlcHJvZHVjZXIgaXMgdG9vIHVucmVsaWFibGU6IDAuMDApLgo+Pgo+
PiBUaGUgY3Jhc2ggdHJhY2UgaXMgYXMgZm9sbG93czoKPj4gICBPREVCVUc6IGZyZWUgYWN0aXZl
IChhY3RpdmUgc3RhdGUgMCkgb2JqZWN0OiBmZmZmODg4MDQwMjRlODcwIG9iamVjdCB0eXBlOiB3
b3JrX3N0cnVjdCBoaW50OiBoY2lfdWFydF93cml0ZV93b3JrKzB4MC8weDk0MAo+PiAgIFdBUk5J
Tkc6IENQVTogMCBQSUQ6IDMzODI3MyBhdCBsaWIvZGVidWdvYmplY3RzLmM6NjEyIGRlYnVnX3By
aW50X29iamVjdCsweDFhMi8weDJiMAo+PiAgIC4uLgo+PiAgIENhbGwgVHJhY2U6Cj4+ICAgIDxU
QVNLPgo+PiAgICBkZWJ1Z19jaGVja19ub19vYmpfZnJlZWQrMHgzZWMvMHg1MjAKPj4gICAga2Zy
ZWUrMHgzZjAvMHg2YzAKPj4gICAgaGNpX3VhcnRfdHR5X2Nsb3NlKzB4MTI3LzB4MmEwCj4+ICAg
IHR0eV9sZGlzY19jbG9zZSsweDExMy8weDFhMAo+PiAgICB0dHlfbGRpc2Nfa2lsbCsweDhlLzB4
MTUwCj4+ICAgIHR0eV9sZGlzY19oYW5ndXArMHgzYzEvMHg3MzAKPj4gICAgX190dHlfaGFuZ3Vw
LnBhcnQuMCsweDNmZC8weDhhMAo+PiAgICB0dHlfaW9jdGwrMHgxMjBmLzB4MTY5MAo+PiAgICBf
X3g2NF9zeXNfaW9jdGwrMHgxOGYvMHgyMTAKPj4gICAgZG9fc3lzY2FsbF82NCsweGNiLzB4ZmEw
Cj4+ICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YKPj4gICAgPC9U
QVNLPgo+Pgo+PiBUaGUgaXNzdWUgYXJpc2VzIGJlY2F1c2UgdGhlIHdvcmtxdWV1ZXMgKGluaXRf
cmVhZHkgYW5kIHdyaXRlX3dvcmspIGFyZQo+PiBvbmx5IGZsdXNoZWQvY2FuY2VsbGVkIGlmIHRo
ZSBIQ0lfVUFSVF9QUk9UT19SRUFEWSBmbGFnIGlzIHNldC4gSG93ZXZlciwKPj4gZHVyaW5nIHRo
ZSBwcm90b2NvbCBpbml0aWFsaXphdGlvbiBwaGFzZSAoSENJX1VBUlRfUFJPVE9fSU5JVCksIHRo
ZQo+PiB1bmRlcmx5aW5nIHByb3RvY29sIG1heSBzY2hlZHVsZSB3b3JrLiBJZiBhIGhhbmd1cCBv
Y2N1cnMgYmVmb3JlIHRoZSBzZXR1cAo+PiBjb21wbGV0ZXMgYW5kIHRoZSBSRUFEWSBmbGFnIGlz
IHNldCwgaGNpX3VhcnRfdHR5X2Nsb3NlKCkgc2tpcHMgdGhlCj4+IHRlYXJkb3duIG9mIHRoZXNl
IHdvcmtxdWV1ZXMgYW5kIHByb2NlZWRzIHRvIGZyZWUgdGhlIGBodWAgc3RydWN0LiBXaGVuCj4+
IHRoZSBzY2hlZHVsZWQgd29yayBleGVjdXRlcyBsYXRlciwgaXQgYmxpbmRseSBkZXJlZmVyZW5j
ZXMgdGhlIGZyZWVkIGBodWAKPj4gc3RydWN0Lgo+Pgo+PiBGaXggdGhpcyBieSBtb3ZpbmcgdGhl
IHdvcmtxdWV1ZSB0ZWFyZG93biBvdXRzaWRlIHRoZSBIQ0lfVUFSVF9QUk9UT19SRUFEWQo+PiBj
aGVjay4gRnVydGhlcm1vcmUsIHVzZSBkaXNhYmxlX3dvcmtfc3luYygpIGluc3RlYWQgb2YgY2Fu
Y2VsX3dvcmtfc3luYygpCj4+IHRvIHVuY29uZGl0aW9uYWxseSBkaXNhYmxlIHRoZSB3b3Jrcy4g
VGhpcyBlbnN1cmVzIHRoYXQgYW55IHBlbmRpbmcgd29ya3MKPj4gYXJlIGNhbmNlbGxlZCBhbmQg
bm8gbmV3IHN1Ym1pc3Npb25zIGNhbiBvY2N1ciBiZWZvcmUgdGhlIGhjaV91YXJ0Cj4+IHN0cnVj
dHVyZSBpcyBmcmVlZC4gTm90ZSB0aGF0IGh1LT5pbml0X3JlYWR5IGFuZCBodS0+d3JpdGVfd29y
ayBhcmUKPj4gaW5pdGlhbGl6ZWQgaW4gaGNpX3VhcnRfdHR5X29wZW4oKSwgc28gaXQgaXMgYWx3
YXlzIHNhZmUgdG8gY2FsbAo+PiBkaXNhYmxlX3dvcmtfc3luYygpIG9uIHRoZW0gaW4gaGNpX3Vh
cnRfdHR5X2Nsb3NlKCksIGV2ZW4gaWYgdGhlIHByb3RvY29sCj4+IHdhcyBuZXZlciBmdWxseSBh
dHRhY2hlZC4KPj4KPj4gRml4ZXM6IDNiNzk5MjU0Y2Y2ZiAoIkJsdWV0b290aDogaGNpX3VhcnQ6
IENhbmNlbCBpbml0IHdvcmsgYmVmb3JlIHVucmVnaXN0ZXJpbmciKQo+PiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdA
c3R1LnhpZGlhbi5lZHUuY24+Cj4+IC0tLQo+PiBDaGFuZ2VzIGluIHY0Ogo+PiAtIEFkb3B0ZWQg
THVpeidzIHN1Z2dlc3Rpb24gdG8gdXNlIGRpc2FibGVfd29ya19zeW5jKCkgaW5zdGVhZCBvZgo+
PiAgIGNhbmNlbF93b3JrX3N5bmMoKSB0byBwcmV2ZW50IG5ldyB3b3JrIHN1Ym1pc3Npb25zIGR1
cmluZyB0ZWFyZG93bi4KPj4KPj4gQ2hhbmdlcyBpbiB2MzoKPj4gLSBBZGRlZCAnQ2M6IHN0YWJs
ZScgdGFnIGFzIHJlcXVlc3RlZCBieSB0aGUgc3RhYmxlIGJvdC4KPj4KPj4gQ2hhbmdlcyBpbiB2
MjoKPj4gLSBBZGRlZCBLQVNBTi9PREVCVUcgY3Jhc2ggdHJhY2UuCj4+Cj4+ICBkcml2ZXJzL2Js
dWV0b290aC9oY2lfbGRpc2MuYyB8IDEyICsrKysrKysrKy0tLQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2hjaV9sZGlzYy5jIGIvZHJpdmVycy9ibHVldG9vdGgvaGNpX2xkaXNjLmMK
Pj4gaW5kZXggMjc1ZWE4NjViYzI5Li4zMzNjMWUxNTAzZTggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvYmx1ZXRvb3RoL2hjaV9sZGlzYy5jCj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2hjaV9s
ZGlzYy5jCj4+IEBAIC01NDQsMTQgKzU0NCwyMCBAQCBzdGF0aWMgdm9pZCBoY2lfdWFydF90dHlf
Y2xvc2Uoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSkKPj4gICAgICAgICBpZiAoaGRldikKPj4gICAg
ICAgICAgICAgICAgIGhjaV91YXJ0X2Nsb3NlKGhkZXYpOwo+Pgo+PiArICAgICAgIC8qCj4+ICsg
ICAgICAgICogRGlzYWJsZSB3b3JrcXVldWVzIHVuY29uZGl0aW9uYWxseSBiZWZvcmUgZnJlZWlu
ZyB0aGUgaHUKPj4gKyAgICAgICAgKiBzdHJ1Y3QsIGFzIHRoZXkgbWlnaHQgYmUgYWN0aXZlIGR1
cmluZyB0aGUgUFJPVE9fSU5JVCBwaGFzZS4KPj4gKyAgICAgICAgKiBVc2luZyBkaXNhYmxlX3dv
cmtfc3luYygpIGluc3RlYWQgb2YgY2FuY2VsX3dvcmtfc3luYygpCj4+ICsgICAgICAgICogZW5z
dXJlcyBubyBuZXcgc3VibWlzc2lvbnMgY2FuIG9jY3VyLgo+PiArICAgICAgICAqLwo+PiArICAg
ICAgIGRpc2FibGVfd29ya19zeW5jKCZodS0+aW5pdF9yZWFkeSk7Cj4+ICsgICAgICAgZGlzYWJs
ZV93b3JrX3N5bmMoJmh1LT53cml0ZV93b3JrKTsKPgo+TG9va3MgbGlrZSBzYXNoaWtvIGhhcyBh
IHByb2JsZW0gd2l0aCB0aGVzZSBiZWluZyBhZnRlciBoY2lfdWFydF9jbG9zZToKCkkgc2VlIHRo
ZSBpc3N1ZSBub3cuIFBsYWNpbmcgYGRpc2FibGVfd29ya19zeW5jKClgIGFmdGVyIGBoY2lfdWFy
dF9jbG9zZSgpYApjb3VsZCBzdGlsbCBsZWF2ZSBhIHRpbnkgd2luZG93IHdoZXJlIHRoZSB3b3Jr
cXVldWVzIG1pZ2h0IHJhY2Ugd2l0aCB0aGUgCnRlYXJkb3duIG9mIHRoZSBgaGRldmAgc3RydWN0
dXJlLiAKClRoZSBzYWZlc3QgYW5kIG1vc3QgbG9naWNhbCBhcHByb2FjaCBpcyB0byBwdWxsIHRo
ZSBgZGlzYWJsZV93b3JrX3N5bmMoKWAKY2FsbHMgdG8gdGhlIHZlcnkgdG9wIG9mIGBoY2lfdWFy
dF90dHlfY2xvc2UoKWAsIGJlZm9yZSBgaGNpX3VhcnRfY2xvc2UoKWAgCm9yIGFueSBvdGhlciB0
ZWFyZG93biBsb2dpYyBiZWdpbnMuIFRoaXMgd2lsbCBjb21wbGV0ZWx5IGNob2tlIG9mZiBhbnkg
CmFzeW5jaHJvbm91cyBvcGVyYXRpb25zIGJlZm9yZSB3ZSB0b3VjaCB0aGUgY29ubmVjdGlvbiBz
dGF0ZSBvciBoYXJkd2FyZS4KCkkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoIGFuZCBzZW5kIG91dCB2
NSBpbW1lZGlhdGVseS4KCj4KPmh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDUx
NTE0MDU0OC4zOTM4NjUtMS13MTUzMDM3NDYwNjIlNDAxNjMuY29tCj4KPj4gICAgICAgICBpZiAo
dGVzdF9iaXQoSENJX1VBUlRfUFJPVE9fUkVBRFksICZodS0+ZmxhZ3MpKSB7Cj4+ICAgICAgICAg
ICAgICAgICBwZXJjcHVfZG93bl93cml0ZSgmaHUtPnByb3RvX2xvY2spOwo+PiAgICAgICAgICAg
ICAgICAgY2xlYXJfYml0KEhDSV9VQVJUX1BST1RPX1JFQURZLCAmaHUtPmZsYWdzKTsKPj4gICAg
ICAgICAgICAgICAgIHBlcmNwdV91cF93cml0ZSgmaHUtPnByb3RvX2xvY2spOwo+Pgo+PiAtICAg
ICAgICAgICAgICAgY2FuY2VsX3dvcmtfc3luYygmaHUtPmluaXRfcmVhZHkpOwo+PiAtICAgICAg
ICAgICAgICAgY2FuY2VsX3dvcmtfc3luYygmaHUtPndyaXRlX3dvcmspOwo+PiAtCj4+ICAgICAg
ICAgICAgICAgICBpZiAoaGRldikgewo+PiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodGVz
dF9iaXQoSENJX1VBUlRfUkVHSVNURVJFRCwgJmh1LT5mbGFncykpCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaGNpX3VucmVnaXN0ZXJfZGV2KGhkZXYpOwo+PiAtLQo+PiAyLjM0
LjEKPj4KPgo+Cj4tLSAKPkx1aXogQXVndXN0byB2b24gRGVudHoKCkJlc3QgcmVnYXJkcywKTWlu
Z3l1Cg==


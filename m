Return-Path: <stable+bounces-260633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NJPmNxpwImoGXQEAu9opvQ
	(envelope-from <stable+bounces-260633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 08:43:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F866459C2
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 08:43:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="f DFAxgq";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260633-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260633-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 008BB3018280
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECF406299;
	Fri,  5 Jun 2026 06:42:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7040149E;
	Fri,  5 Jun 2026 06:42:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641751; cv=none; b=Q8cT3ViVsnYKhh5OHvhAzI9fYg8qDzvftaDSX9eyYPDtcZKsQ6zjOQtMfQVeM4ccbFnf74cXoJOPq4m1wbnByftVK90/YqwXAyK5Y3ymnf1g0sA9KbjN8It1uR2MUTjzwMgo3TAaEWHQhGgyMFpcy3FexPP4Ep/HG+KFW/WVkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641751; c=relaxed/simple;
	bh=ZiFtKQZZSzaa6La/dIlsHqg4rVW+JmWCuMSQ5VwN9HU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Jm2JSn1h5NrGr7jXeBd7LmlYHKKYI2rQxVtNOU61CDM6ALX4XmzvjDButtIwgqpweLH2tvWNLJ6358jqi9OKOAEEk/JULUhKUFO6RxP0cORWYpzyVfeCB99P8acIL/sV9t3tBSODBzJ5r93f5jzpRurjCB6rDv0OFIDM8AY7SDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fDFAxgqZ; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ZiFtKQZZSzaa6La/dIlsHqg4rVW+JmWCuMSQ5VwN9HU=; b=f
	DFAxgqZHY/kfSehR3hoVmCDc7zg91YBtJTjZryLn4RrQYnSxeLAoin2r3RxiGxhS
	xoVfgzI1u/q9BoONAXk5j58A1qzRc0CJsLMcjlmt9/bxm9ddzanxWIAFfH1FtKBH
	xgRNI+arPfH3uN0PGwAnSvgx7wpnhIPhsgUuqeNjXk=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Fri, 5 Jun 2026 14:41:26 +0800 (CST)
Date: Fri, 5 Jun 2026 14:41:26 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:[PATCH v2] drm/vblank: Reject 0-period timers to prevent hrtimer
 storm
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260523025447.581709-1-w15303746062@163.com>
References: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
 <20260523025447.581709-1-w15303746062@163.com>
X-NTES-SC: AL_Qu2TAvqfvk4j4CWfbOkfmU0Qguw9Xcq5uPkj34FWN5t8jDrp5QodX0JFHVfbys6/Dy2ItRqsex1+1f9nQoZgZZ0Jt3we5vz6boNvjzdYaiQPEw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <33239270.5344.19e9683e439.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cSgvCgDXf0yWbyJqdkoDAA--.27889W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xYkCGoib5bOVQAA3v
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:zack.rusin@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:25181214217@stu.xidian.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260633-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,xidian.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40F866459C2

CkhpIE1hYXJ0ZW4sIE1heGltZSwgVGhvbWFzLCBhbmQgYWxsLAoKQSBnZW50bGUgcGluZyBvbiB0
aGlzIHYyIHBhdGNoLgoKSXQgaGFzIGJlZW4gYWJvdXQgdHdvIHdlZWtzIHNpbmNlIHN1Ym1pc3Np
b24uIEFzIGEgcXVpY2sgcmVtaW5kZXIsIHRoaXMgdjIgCmFkZHJlc3NlcyB0aGUgcHJldmlvdXMg
ZmVlZGJhY2sgYnkgbW92aW5nIHRoZSB6ZXJvLXBlcmlvZCB2YWxpZGF0aW9uIApkaXJlY3RseSBp
bnRvIHRoZSBEUk0gY29yZSAoYGRybV92YmxhbmsuY2ApLiBUaGlzIHByb3RlY3RzIGFsbCB2aXJ0
dWFsIApkcml2ZXJzIHJlbHlpbmcgb24gdGhlIHNvZnR3YXJlIHZibGFuayB0aW1lciBmcm9tIHRo
ZSBocnRpbWVyIHN0b3JtIERvUy4gCkl0IGFsc28gZHJvcHMgdGhlIFdBUk5fT05fT05DRSgpIHRv
IHByZXZlbnQgdW5wcml2aWxlZ2VkIHVzZXJzcGFjZSBmcm9tIAp0cmlnZ2VyaW5nIHBhbmljcy4K
CkNvdWxkIGFueW9uZSBwbGVhc2UgdGFrZSBhIGxvb2sgd2hlbiB5b3UgaGF2ZSBhIG1vbWVudCwg
b3IgbGV0IG1lIGtub3cgCmlmIGFueSBmdXJ0aGVyIGFkanVzdG1lbnRzIGFyZSBuZWVkZWQ/CgpC
ZXN0IHJlZ2FyZHMsCk1pbmd5dQoKQXQgMjAyNi0wNS0yMyAxMDo1NDo0NywgdzE1MzAzNzQ2MDYy
QDE2My5jb20gd3JvdGU6Cj5Gcm9tOiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlh
bi5lZHUuY24+Cj4KPkZ1enplcnMgbGlrZSBTeXprYWxsZXIgY2FuIHN1Ym1pdCBleHRyZW1lbHkg
bWFsaWNpb3VzIGRpc3BsYXkgbW9kZXMKPnRocm91Z2ggRFJNX0lPQ1RMX01PREVfU0VUQ1JUQy4g
SWYgdXNlcnNwYWNlIHBhc3NlcyBhIG1vZGUgd2l0aCBhCj5tYXNzaXZlIHBpeGVsIGNsb2NrIChj
cnRjX2Nsb2NrKSBhbmQgc21hbGwgcmVzb2x1dGlvbiAoaHRvdGFsL3Z0b3RhbCksCj50aGUgaW50
ZWdlciBkaXZpc2lvbiBpbiBkcm1fY2FsY190aW1lc3RhbXBpbmdfY29uc3RhbnRzKCkgdHJ1bmNh
dGVzCj50aGUgcmVzdWx0aW5nIGZyYW1lIGR1cmF0aW9uICh2YmxhbmstPmZyYW1lZHVyX25zKSB0
byAwLgo+Cj5XaGVuIHZpcnR1YWwgZGlzcGxheSBkcml2ZXJzIChzdWNoIGFzIHZtd2dmeCBvciB2
a21zKSByZWx5IG9uIHRoZSBEUk0KPmNvcmUncyBzb2Z0d2FyZSB2Ymxhbmsgc2ltdWxhdGlvbiwg
ZHJtX2NydGNfdmJsYW5rX3N0YXJ0X3RpbWVyKCkgaXMKPmNhbGxlZC4gSXQgYmxpbmRseSBjb252
ZXJ0cyB0aGlzIDAtbnMgZnJhbWVkdXJfbnMgaW50byBhIGt0aW1lIGludGVydmFsCj5hbmQgc3Rh
cnRzIHRoZSBocnRpbWVyLiBBbiBocnRpbWVyIHdpdGggYSAwLXBlcmlvZCBmaXJlcyBpbnN0YW50
bHkgYW5kCj5jb250aW51b3VzbHkuIFNpbmNlIGhydGltZXJfZm9yd2FyZF9ub3coKSBjYW5ub3Qg
YWR2YW5jZSB0aW1lIGZvciBhCj4wLXBlcmlvZCwgdGhlIENQVSBnZXRzIGxvY2tlZCBpbiBhbiBp
bmZpbml0ZSBoYXJkLUlSUSBsb29wLCBzdGFydmluZwo+dGhlIHN5c3RlbSBhbmQgY2F1c2luZyBt
YXNzaXZlIFJDVSBzdGFsbHMuCj4KPkZpeCB0aGlzIERvUyB2dWxuZXJhYmlsaXR5IGJ5IGFkZGlu
ZyBhIGRlZmVuc2l2ZSBzYW5pdHkgY2hlY2sgaW4KPmRybV9jcnRjX3ZibGFua19zdGFydF90aW1l
cigpIHRvIHJlamVjdCBhIDAtbnMgZnJhbWUgZHVyYXRpb24sIGFsbG93aW5nCj50aGUgRFJNIGNv
cmUgdG8gZ3JhY2VmdWxseSByZWplY3QgdGhlIG1hbGljaW91cyBtb2RlLgo+Cj5TaWduZWQtb2Zm
LWJ5OiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+Cj4tLS0KPkNo
YW5nZXMgaW4gdjI6Cj4tIE1vdmVkIHRoZSBkZWZlbnNpdmUgY2hlY2sgZnJvbSB2bXdnZnggdG8g
ZHJtX3ZibGFuay5jLiBUaGUgdGltZXIKPiAgbG9naWMgd2FzIHJlZmFjdG9yZWQgaW50byB0aGUg
RFJNIGNvcmUsIHNvIHBsYWNpbmcgdGhlIGNoZWNrIGhlcmUKPiAgcHJvdGVjdHMgYWxsIGRyaXZl
cnMgcmVseWluZyBvbiB0aGUgY29yZSBzb2Z0d2FyZSB2YmxhbmsgdGltZXIuCj4tIERyb3BwZWQg
V0FSTl9PTl9PTkNFKCkgdG8gcHJldmVudCB1bnByaXZpbGVnZWQgdXNlcnNwYWNlIGZyb20gZWFz
aWx5Cj4gIHRyaWdnZXJpbmcga2VybmVsIHBhbmljcyBvbiBzeXN0ZW1zIHdpdGggcGFuaWNfb25f
d2FybiBlbmFibGVkLgo+Cj4gZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYyB8IDEwICsrKysr
KysrKysKPiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Cj5kaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2RybV92YmxhbmsuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5r
LmMKPmluZGV4IGY5MGZiMmQxM2U0Mi4uYjM4ZDBiMzBhNjUxIDEwMDY0NAo+LS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2RybV92YmxhbmsuYwo+KysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV92Ymxhbmsu
Ywo+QEAgLTIyNDEsNiArMjI0MSwxNiBAQCBpbnQgZHJtX2NydGNfdmJsYW5rX3N0YXJ0X3RpbWVy
KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPiAKPiAJZHJtX2NhbGNfdGltZXN0YW1waW5nX2NvbnN0
YW50cyhjcnRjLCAmY3J0Yy0+bW9kZSk7Cj4gCj4rCS8qCj4rCSAqIERFRkVOU0lWRSBDSEVDSzoK
PisJICogZHJtX2NhbGNfdGltZXN0YW1waW5nX2NvbnN0YW50cygpIHRydW5jYXRlcyBmcmFtZWR1
cl9ucyB0byAwIGlmCj4rCSAqIHVzZXJzcGFjZSBwcm92aWRlcyBhIG1hbGljaW91cyBtb2RlIHdp
dGggYSBodWdlIGNydGNfY2xvY2sgYW5kCj4rCSAqIHNtYWxsIGh0b3RhbC92dG90YWwuIFByZXZl
bnQgYW4gaW5maW5pdGUgaGFyZC1JUlEgbG9vcCBmcm9tIGEKPisJICogMC1wZXJpb2QgaHJ0aW1l
ciBieSByZWplY3Rpbmcgc3VjaCBtb2Rlcy4KPisJICovCj4rCWlmICh1bmxpa2VseSh2Ymxhbmst
PmZyYW1lZHVyX25zID09IDApKQo+KwkJcmV0dXJuIC1FSU5WQUw7Cj4rCj4gCXNwaW5fbG9ja19p
cnFzYXZlKCZ2dGltZXItPmludGVydmFsX2xvY2ssIGZsYWdzKTsKPiAJdnRpbWVyLT5pbnRlcnZh
bCA9IG5zX3RvX2t0aW1lKHZibGFuay0+ZnJhbWVkdXJfbnMpOwo+IAlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZ2dGltZXItPmludGVydmFsX2xvY2ssIGZsYWdzKTsKPi0tIAo+Mi4zNC4xCg==


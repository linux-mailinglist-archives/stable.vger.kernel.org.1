Return-Path: <stable+bounces-268312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1X+IOjwPGrzuggAu9opvQ
	(envelope-from <stable+bounces-268312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:12:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5426C41C0
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:12:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.it header.s=amazoncorp2 header.b=JdqxJYsp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268312-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268312-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D8D930207DB
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF0737CD47;
	Thu, 25 Jun 2026 09:11:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98A35AC00;
	Thu, 25 Jun 2026 09:11:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378665; cv=none; b=U6SL9s6//kv2ejL+mIOiWanGAN+qb/wRTd6hU5j9IVBMxz189t8hTjw/VlQw3vImgsWB2pnQW8PXYNC1Fpoqsk2nKBiyXlnIHC6US4vkOwgg0bpjCpfXxyUGD+/QN6T30hrI6oJ84RsEPSJqzVhb9uPvjD4Hu9TtjytZ3iZnY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378665; c=relaxed/simple;
	bh=oE928MWpjpguJbmMgOw+gSkPCYeo6lVM91/zGpnGPn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sykvUcdDmsAtfNdG8CecFfLiqQRO3496DNNazPuWRSzwDThnqZC/thHqDntvimc/nQIrWSkefPr2OqAAZW+GxXyex3N7+AVS0YEw+5bOKUkuEpjriHCzuNXAu1+gnA2aFmxv5SA9N/YaWyedzNOOBBP2KHheNesyHY8rhreC/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it; spf=pass smtp.mailfrom=amazon.it; dkim=pass (2048-bit key) header.d=amazon.it header.i=@amazon.it header.b=JdqxJYsp; arc=none smtp.client-ip=52.26.1.71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1782378664; x=1813914664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oE928MWpjpguJbmMgOw+gSkPCYeo6lVM91/zGpnGPn4=;
  b=JdqxJYspKNXeA1OD4UdLrFwIBaqNtaBf7KkMRp8E9VqonFQ7wqPf/JJz
   Kff+Qv1HBYXzV98dbH29J1Nwce7rszoB/Z767H8Uif1rkKChD4MlMZSNt
   qS5KLiW8ZlppQWuuDHl5N8BQY1T3KQ/O0Yo8pgCD++zTibTIAt/0P3cOw
   3yRBYeYR9cVVT20hG9rDTHmAdYMRfseViMBGQygNNFnQ75cI/ESSO+kLk
   la/FDDawATRAJdcNR/uy+xtPDrosVl1nDpuSyL2RAStDXSRFotu63KQWj
   3K8l4pKciYEKc8i06t51sYp2vFuzOjynxMtbw1kWIOd7pS8trYAg7U92j
   g==;
X-CSE-ConnectionGUID: BHvSDaCTQDGldW/+GkcQGw==
X-CSE-MsgGUID: T6GC85OPQZqEzuE/bVyVkw==
X-IronPort-AV: E=Sophos;i="6.24,224,1774310400"; 
   d="scan'208";a="22495960"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 09:11:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:9509]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.116:2525] with esmtp (Farcaster)
 id 53b71abc-ee40-4912-bc3d-4b91185244a3; Thu, 25 Jun 2026 09:10:59 +0000 (UTC)
X-Farcaster-Flow-ID: 53b71abc-ee40-4912-bc3d-4b91185244a3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 09:10:59 +0000
Received: from cdd-dev.amazon.com (172.22.139.101) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 25 Jun 2026 09:10:58 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <hch@infradead.org>, <ritesh.list@gmail.com>
CC: <abuehaze@amazon.com>, <akpm@linux-foundation.org>, <alisaidi@amazon.com>,
	<blakgeof@amazon.com>, <brauner@kernel.org>, <david@kernel.org>,
	<dipietro.salvatore@gmail.com>, <dipiets@amazon.it>, <djwong@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>, <ljs@kernel.org>,
	<mhocko@suse.com>, <rppt@kernel.org>, <stable@vger.kernel.org>,
	<vbabka@kernel.org>, <vbabka@suse.com>, <willy@infradead.org>
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
Date: Thu, 25 Jun 2026 09:10:37 +0000
Message-ID: <20260625091039.24501-1-dipiets@amazon.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ajvc7fSDngyx0X5j@infradead.org>
References: <ajvc7fSDngyx0X5j@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.56 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.it:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.it,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.it:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-268312-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:ritesh.list@gmail.com,m:abuehaze@amazon.com,m:akpm@linux-foundation.org,m:alisaidi@amazon.com,m:blakgeof@amazon.com,m:brauner@kernel.org,m:david@kernel.org,m:dipietro.salvatore@gmail.com,m:dipiets@amazon.it,m:djwong@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-xfs@vger.kernel.org,m:ljs@kernel.org,m:mhocko@suse.com,m:rppt@kernel.org,m:stable@vger.kernel.org,m:vbabka@kernel.org,m:vbabka@suse.com,m:willy@infradead.org,m:riteshlist@gmail.com,m:dipietrosalvatore@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amazon.it:dkim,amazon.it:mid,amazon.it:from_mime,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[amazon.it:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,linux-foundation.org,kernel.org,gmail.com,amazon.it,vger.kernel.org,kvack.org,suse.com,infradead.org];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B5426C41C0

T24gV2VkLCBKdW4gMjQsIDIwMjYgYXQgMTI6MjE6MDBQTSArMDAwMCwgUml0ZXNoIEhhcmphbmkg
d3JvdGU6Cj4gU29ycnkgYWJvdXQgdGhlIGRlbGF5LiBJIGRpZCBicmluZyB0aGlzIHRvcGljIHVw
IGluIG9uZSBvZiBvdXIgaW50ZXJuYWwKPiBleHQ0IGNvbW11bml0eSBjYWxscy4gQW5kIHRvIHNo
YXJlIHNvbWUgY29udGV4dCwgTU0gY29tbXVuaXR5IHRoaW5rcyB3ZQo+IG5lZWQgYSBiZXR0ZXIg
bG9uZyB0ZXJtIGZpeCBmb3IgdGhpcyBwcm9ibGVtIHJhdGhlciB0aGFuIHBhdGNoaW5nIGNhbGwK
PiBzaXRlcyBhbmQvb3IgcGxheWluZyB0cmlja3MgbGlrZSAtIAoKVGhhbmtzIFJpdGVzaCBmb3Ig
dGhlIHVwZGF0ZSBhbmQgZm9yIGJyaW5naW5nIHRoaXMgdG8gdGhlIHdpZGVyIE1NIGNvbW11bml0
eS4gCkkgY29tcGxldGVseSB1bmRlcnN0YW5kIHRoYXQgdGhlIE1NIGNvbW11bml0eSBpcyBsb29r
aW5nIGZvciBhIHByb3BlciBsb25nLXRlcm0KZml4IHJhdGhlciB0aGFuIHNwZWNpZmljIHBhdGNo
aW5nLgoKCk9uIFdlZCwgSnVuIDI0LCAyMDI2IGF0IDEzOjM0OjAwUE0gKzAwMDAsIENocmlzdG9w
aCBIZWxsd2lnIHdyb3RlOgo+IERvIHlvdSBoYXZlIG9pbnRlcnMgdG8gdGhlIHBhdGNoZXMgZm9y
IGVhY2ggYXBwcm9hY2ggYWJvdmU/CgpZZXMg4oCUIGFsbCB0aGUgcGF0Y2hlcyBpbiB0aGUgcmVz
dWx0IHRhYmxlIGFyZSBzaGFyZWQgd2l0aGluIHRoaXMgdGhyZWFkOgoKdjEgKG9yaWdpbmFsLCBp
b21hcCBjYWxsZXIpOiBUaGUgb3JpZ2luYWwgUEFUQ0ggMS8xIGluIHRoaXMgc2VyaWVzClJpdGVz
aCdzIHN1Z2dlc3Rpb24gKG1tL2ZpbGVtYXAuYyk6IFNoYXJlZCBpbiBSaXRlc2gncyByZXBseSBv
biBNYXkgM3JkIFsxXQpNYXR0aGV3J3Mgc3VnZ2VzdGlvbiAobW0vZmlsZW1hcC5jKTogU2hhcmVk
IGluIE1hdHRoZXcncyByZXBseSBvbiBBcHJpbCA0dGggWzJdCmtjb21wYWN0ZCBiYWNrZ3JvdW5k
IChtbS9wYWdlX2FsbG9jLmMpOiBTaGFyZWQgaW4gbXkgcmVwbHkgb24gTWF5IDZ0aCBbM10KClsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MDMxOTM1MzUuOTk3MC0xLWRpcGll
dHNAYW1hem9uLml0L1QvI204YzNkYTFjOWZiOWU5YzY2ZDRlOGIxODQ5ZGU4MjRiMGVjZjM3Zjll
ClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MDMxOTM1MzUuOTk3MC0xLWRp
cGlldHNAYW1hem9uLml0L1QvI200YjkwY2YyODBmZjBlZmNmMTc4ZGZkOGQwNjhmMWRlM2IyNjJl
MjhhClszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA0MDMxOTM1MzUuOTk3MC0x
LWRpcGlldHNAYW1hem9uLml0L1QvI20yMjk3NzM1NTUzNWE0NTk5MDg0YTUxMTA0YTRkZjgwNmQ0
OWM1M2QxCgotLQpTYWx2YXRvcmUKCgoKQU1BWk9OIERFVkVMT1BNRU5UIENFTlRFUiBJVEFMWSBT
UkwsIHZpYWxlIE1vbnRlIEdyYXBwYSAzLzUsIDIwMTI0IE1pbGFubywgSXRhbGlhLCBSZWdpc3Ry
byBkZWxsZSBJbXByZXNlIGRpIE1pbGFubyBNb256YSBCcmlhbnphIExvZGkgUkVBIG4uIDI1MDQ4
NTksIENhcGl0YWxlIFNvY2lhbGU6IDEwLjAwMCBFVVIgaS52LiwgQ29kLiBGaXNjLiBlIFAuSVZB
IDEwMTAwMDUwOTYxLCBTb2NpZXRhIGNvbiBTb2NpbyBVbmljbwoKCg==



Return-Path: <stable+bounces-268091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OfyFEiyQO2oWZwgAu9opvQ
	(envelope-from <stable+bounces-268091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:07:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C86BC6A9
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.it header.s=amazoncorp2 header.b=AFZeauHM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268091-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268091-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51A2130059B6
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99779388396;
	Wed, 24 Jun 2026 08:07:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A526CE1E;
	Wed, 24 Jun 2026 08:07:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288423; cv=none; b=YpC5dN9qgGcdQ31MeYJaexjjbLESdTlTAtUpGbFrOUz9+WiNi3z+8qA41GTXlECpG0YFdkareSzk0T4O7TacTwnidFtWJjqX56FBssOO89pUTSb2IGwH1Q523AtMAPI1mPYJuE3/mIDngJTG++TuMvhsp740Lp+BFJYNDzA1nYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288423; c=relaxed/simple;
	bh=nZR15EF6KouS6szTO561diYicLRjtT7IE5fQB79fYCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uP9AfrpEap95fXXfC3lyzYCrPPTBUExgzCi4AgAXzDdJcc5ZBXAXDVd9woEH+6mYmB9Yff0xlSVy3S5j9G4xk9YKLxlg0I7Vh8ggL67GC3hKTaXZaADMJd4s4MUoP5kZfb1ZIab4GMZpHJtB6IVKcbAsvUzPVbnJ+kUJ1UgIyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.it; spf=pass smtp.mailfrom=amazon.it; dkim=pass (2048-bit key) header.d=amazon.it header.i=@amazon.it header.b=AFZeauHM; arc=none smtp.client-ip=52.13.214.179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.it; i=@amazon.it; q=dns/txt; s=amazoncorp2;
  t=1782288422; x=1813824422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZR15EF6KouS6szTO561diYicLRjtT7IE5fQB79fYCw=;
  b=AFZeauHMQQdzx7o+oK6ez0BahfDbARuQEML+7Fue45Wmqkue1YfJWKbb
   /eu7uM5pd0CIwH1CqIDKBDjQ3L73O9Hc2pDiMAkq/3Sqd/5yYPlai2kWV
   EczoTN5co/0ZUsGLEiA0JbA7vcDUh/K9Ohqfu7XyHb62OcmwlLsbOMebf
   mRC6rpSkqrday4ljPT84JKLF/e3Mwe9L4r4OGaVE/ZeukdQija8thOI3F
   tlmBSgtrjVUAkt2jHBfk4WsvLS9xmPtIoALBcwVC+2DHoSzkt88Sxa8Xy
   d1T0eVkXj/M5UfVe2eFSCoie0fJhyqkrxNkx6dtNcotKraGWTH9KnVzNm
   A==;
X-CSE-ConnectionGUID: g3+X2/sKSTujZO2OAIqXeg==
X-CSE-MsgGUID: PQkeQQT1QfWH330JRhKmtQ==
X-IronPort-AV: E=Sophos;i="6.24,222,1774310400"; 
   d="scan'208";a="22374892"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 08:06:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:20384]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.192:2525] with esmtp (Farcaster)
 id d632f5d8-b7fb-42c8-a271-d3c8ef86dcf4; Wed, 24 Jun 2026 08:06:58 +0000 (UTC)
X-Farcaster-Flow-ID: d632f5d8-b7fb-42c8-a271-d3c8ef86dcf4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 24 Jun 2026 08:06:58 +0000
Received: from cdd-dev.amazon.com (172.22.139.101) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Wed, 24 Jun 2026 08:06:57 +0000
From: Salvatore Dipietro <dipiets@amazon.it>
To: <ritesh.list@gmail.com>, <willy@infradead.org>
CC: <dipiets@amazon.it>, <abuehaze@amazon.com>, <akpm@linux-foundation.org>,
	<alisaidi@amazon.com>, <blakgeof@amazon.com>, <brauner@kernel.org>,
	<dipietro.salvatore@gmail.com>, <djwong@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>, <stable@vger.kernel.org>,
	<vbabka@suse.com>
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
Date: Wed, 24 Jun 2026 08:06:36 +0000
Message-ID: <20260624080639.17100-1-dipiets@amazon.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527162412.19922-1-dipiets@amazon.it>
References: <20260527162412.19922-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	TAGGED_FROM(0.00)[bounces-268091-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ritesh.list@gmail.com,m:willy@infradead.org,m:dipiets@amazon.it,m:abuehaze@amazon.com,m:akpm@linux-foundation.org,m:alisaidi@amazon.com,m:blakgeof@amazon.com,m:brauner@kernel.org,m:dipietro.salvatore@gmail.com,m:djwong@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-xfs@vger.kernel.org,m:stable@vger.kernel.org,m:vbabka@suse.com,m:riteshlist@gmail.com,m:dipietrosalvatore@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazon.it:dkim,amazon.it:mid,amazon.it:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[amazon.it:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipiets@amazon.it,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amazon.it,amazon.com,linux-foundation.org,kernel.org,gmail.com,vger.kernel.org,kvack.org,suse.com];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D68C86BC6A9

CkhpIFJpdGVzaCwgTWF0dGhldywKCkkgd2FudGVkIHRvIGtpbmRseSBmb2xsb3cgdXAgb24gbXkg
c3VtbWFyeSBmcm9tIE1heSAyN3RoIHJlZ2FyZGluZyB0aGUgYmVzdCBwYXRoIApmb3J3YXJkIGZv
ciB0aGlzIHBhdGNoLgoKVG8gcmVjYXAsIHdlIGJlbmNobWFya2VkIGFsbCBwcm9wb3NlZCB2YXJp
YXRpb25zIGFuZCBzaGFyZWQgdGhlIHJlc3VsdHM6Cgp8IFBhdGNoICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IENoYW5nZSBMb2NhdGlvbiAgICAgICAgfCBBdmcgVFBTICAgIHwgJSB2cyBCYXNl
bGluZSB8CnwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18LS0tLS0tLS0tLS0tfDotLS0tLS0tLS0tLS0tOnwKfCBCYXNlbGluZSAobm8gcGF0
Y2gpICAgICAgICAgICAgfCDigJQgICAgICAgICAgICAgICAgICAgICAgfCAxMDEsOTc5Ljc1IHwg
ICAgICAg4oCUICAgICAgIHwKfCB2MSAob3JpZ2luYWwsIGlvbWFwIGNhbGxlcikgICAgfCBmcy9p
b21hcC9idWZmZXJlZC1pby5jIHwgMTQxLDE5NC4yMCB8ICAgICszOC40NSUgICAgfAp8IFJpdGVz
aCdzIHN1Z2dlc3Rpb24gICAgICAgICAgICB8IG1tL2ZpbGVtYXAuYyAgICAgICAgICAgfCAxMzks
MjAwLjYxIHwgICAgKzM2LjUwJSAgICB8CnwgTWF0dGhldydzIHN1Z2dlc3Rpb24gICAgICAgICAg
IHwgbW0vZmlsZW1hcC5jICAgICAgICAgICB8IDE0Myw4NjMuODIgfCAgICArNDEuMDclICAgIHwK
fCBrY29tcGFjdGQgYmFja2dyb3VuZCAgICAgICAgICAgfCBtbS9wYWdlX2FsbG9jLmMgICAgICAg
IHwgMTM0LDI3OC40NyB8ICAgICszMS42NyUgICAgfAoKSSdkIHJlYWxseSBhcHByZWNpYXRlIGFu
eSBndWlkYW5jZSBvbiB3aGljaCBkaXJlY3Rpb24gd291bGQgYmUgYWNjZXB0YWJsZSBmb3IgYSB2
MyDigJQgCndoZXRoZXIgdGhhdCdzIHRoZSBwYWdlIGFsbG9jYXRvciBhcHByb2FjaCAoa2NvbXBh
Y3RkIGJhY2tncm91bmQpLCBvbmUgb2YgdGhlIGZpbGVtYXAuYwpmaXhlcywgb3Igc29tZXRoaW5n
IGVsc2UgZW50aXJlbHkuCgpJJ20gaGFwcHkgdG8gdGVzdCBhbnkgYWRkaXRpb25hbCB2YXJpYXRp
b25zIG9yIGRpcmVjdGlvbiB0byBtb3ZlIHRoaXMgZm9yd2FyZAoKLS0KU2FsdmF0b3JlCgoKCgoK
QU1BWk9OIERFVkVMT1BNRU5UIENFTlRFUiBJVEFMWSBTUkwsIHZpYWxlIE1vbnRlIEdyYXBwYSAz
LzUsIDIwMTI0IE1pbGFubywgSXRhbGlhLCBSZWdpc3RybyBkZWxsZSBJbXByZXNlIGRpIE1pbGFu
byBNb256YSBCcmlhbnphIExvZGkgUkVBIG4uIDI1MDQ4NTksIENhcGl0YWxlIFNvY2lhbGU6IDEw
LjAwMCBFVVIgaS52LiwgQ29kLiBGaXNjLiBlIFAuSVZBIDEwMTAwMDUwOTYxLCBTb2NpZXRhIGNv
biBTb2NpbyBVbmljbwoKCg==



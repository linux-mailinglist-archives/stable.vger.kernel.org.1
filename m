Return-Path: <stable+bounces-240181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIrpKHqM52m89wEAu9opvQ
	(envelope-from <stable+bounces-240181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:40:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FA43C32D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B07D3087BB0
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD03D9021;
	Tue, 21 Apr 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="cJMg/IOA"
X-Original-To: stable@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFA3A4F58;
	Tue, 21 Apr 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782039; cv=none; b=dlwIzk0Ed/kAdC6Hl+tuy9HbeaRi15ypG1owptmqoCBXq6W0pcEGEqmWPZuHoTaMDvZYPrMznE/43snaOQvXipuD8Tw+6CRYUirLyFoPlkEkffd1QMce1OQhI/9Ptmi2py52zK8gKbOKx8Go2yqcWuML4TdTCEE1BmlloG0Ijf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782039; c=relaxed/simple;
	bh=ArMpXotcTeEwyqUdj8I1RO41SIFb1S0fVagj1cHmjlc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKAUCVrCulXa5MPoBSIpGfk/hI93af21+SXvbPB8ogZGQf3edM04KPsOYr6TGVoq+H8utdLNvC7YkUlhmGzf5Olp/XNglVYv4TK/tk4aNJjVecxSCpWblqou3AQtVdgsuOhH6e2VdcqilipX3v1dLGRNSKYrwFimFbuaj2uhu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=cJMg/IOA; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1776782038; x=1808318038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ArMpXotcTeEwyqUdj8I1RO41SIFb1S0fVagj1cHmjlc=;
  b=cJMg/IOAQTtN6XGOEGk+Sa35GIE+TMbfjTuvwt9ouBLEem1Cq42MPx/C
   JUbW1s1C5IH4oZUiVE5AbCKvVYFm2t6gvQ0VKt9MJmkAEMMwlIuJwEJ+i
   7HJY6wmUdLO/eIoJg+ZV76vP8eXH00M3Ubqf1NUOOR3xSHH25t6abP66C
   Y=;
X-CSE-ConnectionGUID: +FeV1V4KQSyIe2LMbQyvdg==
X-CSE-MsgGUID: A+6UxzbISeGE7osJaVQCWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="90661278"
X-IronPort-AV: E=Sophos;i="6.23,191,1770591600"; 
   d="scan'208";a="90661278"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 16:32:46 +0200
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Apr
 2026 16:32:46 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Apr
 2026 16:32:45 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Tue, 21 Apr 2026 16:32:45 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC: <p.yadav@ti.com>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: RE: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
Thread-Topic: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
Thread-Index: AQHczn5R2lmDsActuEKo+AhMPfaN4bXpmZig
Date: Tue, 21 Apr 2026 14:32:45 +0000
Message-ID: <308e7510718f46169d9465658f2c385a@infineon.com>
References: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
In-Reply-To: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240181-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Takahiro.Kuwano@infineon.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infineon.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 008FA43C32D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBTYXNoaWtvIG5vdGljZWQgYW4gb3V0LW9mLWJvdW5kcyByZWFkIFsxXS4NCj4gDQo+IEluIHNw
aV9ub3JfcGFyYW1zX3Nob3coKSwgdGhlIHNub3JfZl9uYW1lcyBhcnJheSBpcyBwYXNzZWQgdG8N
Cj4gc3BpX25vcl9wcmludF9mbGFncygpIHVzaW5nIHNpemVvZihzbm9yX2ZfbmFtZXMpLg0KPiAN
Cj4gU2luY2Ugc25vcl9mX25hbWVzIGlzIGFuIGFycmF5IG9mIHBvaW50ZXJzLCBzaXplb2YoKSBy
ZXR1cm5zIHRoZSB0b3RhbA0KPiBudW1iZXIgb2YgYnl0ZXMgb2NjdXBpZWQgYnkgdGhlIHBvaW50
ZXJzDQo+ICAgICAgICAgKGVsZW1lbnRfY291bnQgKiBzaXplb2Yodm9pZCAqKSkNCj4gcmF0aGVy
IHRoYW4gdGhlIGVsZW1lbnQgY291bnQgaXRzZWxmLiBPbiA2NC1iaXQgc3lzdGVtcywgdGhpcyBt
YWtlcyB0aGUNCj4gcGFzc2VkIGxlbmd0aCA4eCBsYXJnZXIgdGhhbiBpbnRlbmRlZC4NCj4gDQo+
IEluc2lkZSBzcGlfbm9yX3ByaW50X2ZsYWdzKCksIHRoZSAnbmFtZXNfbGVuJyBhcmd1bWVudCBp
cyB1c2VkIHRvDQo+IGJvdW5kcy1jaGVjayB0aGUgJ25hbWVzJyBhcnJheSBhY2Nlc3MuIEFuIG91
dC1vZi1ib3VuZHMgcmVhZCBvY2N1cnMNCj4gaWYgYSBmbGFnIGJpdCBpcyBzZXQgdGhhdCBleGNl
ZWRzIHRoZSBhcnJheSdzIGFjdHVhbCBlbGVtZW50IGNvdW50DQo+IGJ1dCBpcyB3aXRoaW4gdGhl
IGluZmxhdGVkIGJ5dGUtc2l6ZSBjb3VudC4NCj4gDQo+IENvcnJlY3QgdGhpcyBieSB1c2luZyBB
UlJBWV9TSVpFKCkgdG8gcGFzcyB0aGUgYWN0dWFsIG51bWJlciBvZg0KPiBzdHJpbmcgcG9pbnRl
cnMgaW4gdGhlIGFycmF5Lg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gRml4
ZXM6IDAyNTdiZTc5ZmM0YSAoIm10ZDogc3BpLW5vcjogZXhwb3NlIGludGVybmFsIHBhcmFtZXRl
cnMgdmlhIGRlYnVnZnMiKQ0KPiBDbG9zZXM6IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNl
dC8yMDI2MDQxNy1kaWUtZXJhc2UtZml4LXYyLTEtNzNiYjcwMDRlYmFkJTQwaW5maW5lb24uY29t
IFsxXQ0KPiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQGxpbmFy
by5vcmc+DQoNClJldmlld2VkLWJ5OiBUYWthaGlybyBLdXdhbm8gPHRha2FoaXJvLmt1d2Fub0Bp
bmZpbmVvbi5jb20+DQoNCg==


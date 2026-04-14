Return-Path: <stable+bounces-237778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LbrD9sU3mlBmwkAu9opvQ
	(envelope-from <stable+bounces-237778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:20:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB193F8930
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6359C3073126
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16553CBE69;
	Tue, 14 Apr 2026 10:10:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515093CAE68;
	Tue, 14 Apr 2026 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161443; cv=none; b=gZ43jFpv0k3fGBqyfIf7BaGhp8grKZG+XHLfBqRm7V4aCYLDl6FOz9+xRc7EgV7/Lmb71QGmLaEg9ubgvyYjn8p9jqODAvBndfNR8h2uZrV8K3IkLYvyaByENMyxLLfvY9NPiCWinRlZUDMA+i0CittK+oB65fpmJVgXHfkEYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161443; c=relaxed/simple;
	bh=Kk7T+FkKHIOi+4pRlKGzD6/8/SkcHXSuIRN5QmdONiE=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:In-Reply-To:
	 References:Date:Message-ID; b=HWCKqgzzXSOgTDBj9Qgm9SSvkeuhzKYFKXS99KZJCM98N6RoqhhLSGUod5WTvqdb68lqej2bO62P7CzthO6SoW0omRXUTue76wZRLXakl5hvrc1VCXmvszveLxOAge9gQbCDTngxd+192OAaLCHJ0YbpESW1fO8vBzPslS7Dsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: fM2QS/KOTJ+j9jDQCXh28A==
X-CSE-MsgGUID: hON/ukQ3Rz+5HmNWww8/zw==
X-IronPort-AV: E=Sophos;i="6.23,179,1770566400"; 
   d="scan'208";a="172777150"
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Ziqing Chen <chenziqing@xiaomi.com>
To: Takashi Iwai <tiwai@suse.com>
CC: Jaroslav Kysela <perex@perex.cz>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
In-Reply-To: <20260414090542.151447-1-chenziqing@xiaomi.com>
References: <20260414090542.151447-1-chenziqing@xiaomi.com>
Date: Tue, 14 Apr 2026 18:10:12 +0800
Message-ID: <177616141245.165602.4944737214352244015@xiaomi.com>
X-ClientProxiedBy: BJ-MBX13.mioffice.cn (10.237.8.133) To BJ-MBX03.mioffice.cn
 (10.237.8.123)
X-Spamd-Result: default: False [0.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-237778-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenziqing@xiaomi.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xiaomi.com:mid]
X-Rspamd-Queue-Id: AAB193F8930
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAxNSBBcHIgMjAyNiwgVGFrYXNoaSBJd2FpIHdyb3RlOg0KPiBIYXZpbmcgYSB6ZXJv
IGJ1Zl9sZW4gY2hlY2sgaXMgZ29vZCwgcGVyIHNlLCBidXQgaXQgZG9lc24ndCBoYXZlIHRvIGJl
DQo+IGF0IHRoaXMgbGF0ZSBwbGFjZS4gIEl0IGNhbiBiZSBjaGVja2VkIGF0IHRoZSB2ZXJ5IGJl
Z2lubmluZyBldmVuDQo+IGJlZm9yZSB0aGUgYWxsb2NhdGlvbiAod2hlcmUgd2UgaGF2ZSBhbHJl
YWR5IGFuIHVwcGVyIGJvdW5kIGNoZWNrKSwNCj4gaW5zdGVhZC4NCg0KVGhhbmtzIGZvciB0aGUg
cmV2aWV3Lg0KDQpUaGUgY3Jhc2ggSSBoaXQgaXMgbm90IGNhdXNlZCBieSBidWZfbGVuIGJlaW5n
IHplcm8gYXQgZW50cnkgLS0gaXQNCm9jY3VycyB3aGVuIGJ1Zl9sZW4gaXMgZGVjcmVtZW50ZWQg
dG8gemVybyAqZHVyaW5nKiB0aGUgbG9vcCBhZnRlcg0Kc3VjY2Vzc2Z1bGx5IHBhcnNpbmcgZWFy
bGllciBpdGVtcy4gRm9yIGV4YW1wbGUsIGEgdXNlcnNwYWNlIGNhbGxlcg0KY2FuIGNyYWZ0IGFu
IGlvY3RsIHBheWxvYWQgd2hlcmUgYnVmX2xlbiBpcyBqdXN0IGxhcmdlIGVub3VnaCBmb3INCnRo
ZSBmaXJzdCBOLTEgbmFtZXMgYnV0IGxlYXZlcyBleGFjdGx5IHplcm8gYnl0ZXMgZm9yIHRoZSBO
dGggaXRlbS4NCg0KQW4gZWFybHkgY2hlY2sgKGJ1Zl9sZW4gPT0gMCBiZWZvcmUgYWxsb2NhdGlv
bikgd291bGQgY2F0Y2ggdGhlDQpkZWdlbmVyYXRlIGNhc2Ugd2hlcmUgdGhlIGNhbGxlciBwYXNz
ZXMgYSB6ZXJvLWxlbmd0aCBidWZmZXIsIHdoaWNoDQppcyBhIGdvb2QgaWRlYSBvbiBpdHMgb3du
LCBidXQgaXQgd291bGQgbm90IHByZXZlbnQgdGhlIG1pZC1sb29wDQpleGhhdXN0aW9uIHRoYXQg
dHJpZ2dlcnMgdGhlIEZPUlRJRllfU09VUkNFIHBhbmljLg0KDQpUaGUgaXNzdWUgd2FzIG9yaWdp
bmFsbHkgY2F1Z2h0IGR1cmluZyBmdXp6IHRlc3RpbmcgdmlhIGlvY3RsIG9uIGFuDQphcm02NCAo
TVQ2OTkzKSBkZXZpY2Ugd2l0aCBDT05GSUdfRk9SVElGWV9TT1VSQ0UgYW5kIENsYW5nLiBXZSBo
YXZlDQpub3QgYmVlbiBhYmxlIHRvIHJlcHJvZHVjZSBpdCBzaW5jZSwgd2hpY2ggaXMgY29uc2lz
dGVudCB3aXRoIGl0DQpkZXBlbmRpbmcgb24gQ2xhbmcncyBfX2J1aWx0aW5fZHluYW1pY19vYmpl
Y3Rfc2l6ZSgpIGhldXJpc3RpYyBmb3INCnRoZSBsb29wLWluY3JlbWVudGVkIHBvaW50ZXIgLS0g
dGhlIGV2YWx1YXRpb24gY2FuIHZhcnkgYWNyb3NzDQpjb21waWxlciB2ZXJzaW9ucyBhbmQgb3B0
aW1pemF0aW9uIGxldmVscy4NCg0KSGVyZSBpcyB0aGUgY3Jhc2ggc3RhY2sgZnJvbSB0aGUgb3Jp
Z2luYWwgaGl0Og0KDQogIFVuZXhwZWN0ZWQga2VybmVsIEJSSyBleGNlcHRpb24gYXQgRUwxDQog
IEludGVybmFsIGVycm9yOiBCUksgaGFuZGxlcjogMDAwMDAwMDBmMjAwMDAwMSAxIFBSRUVNUFQg
U01QDQogIHBjIDogc25kX2N0bF9lbGVtX2luaXRfZW51bV9uYW1lcysweDI0NC8weDI0Yw0KICBs
ciA6IHNuZF9jdGxfZWxlbV9pbml0X2VudW1fbmFtZXMrMHgyNDQvMHgyNGMNCiAgQ2FsbCB0cmFj
ZToNCiAgIHNuZF9jdGxfZWxlbV9pbml0X2VudW1fbmFtZXMrMHgyNDQvMHgyNGMNCiAgIHNuZF9j
dGxfZWxlbV9hZGQrMHg0YmMvMHg3YjANCiAgIHNuZF9jdGxfZWxlbV9hZGRfdXNlcisweDEyOC8w
eDI2Yw0KICAgc25kX2N0bF9pb2N0bCsweDlhNC8weDFhNjgNCiAgIF9fYXJtNjRfc3lzX2lvY3Rs
KzB4MTEwLzB4MThjDQogICBpbnZva2Vfc3lzY2FsbCsweDljLzB4MjEwDQogICBlbDBfc3ZjX2Nv
bW1vbisweGU0LzB4MWIwDQogICBkb19lbDBfc3ZjKzB4MzQvMHg0NA0KICAgZWwwX3N2YysweDM4
LzB4ODQNCiAgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4NzAvMHhiYw0KDQpUaGUgQlJLIGlzIGZy
b20gdGhlIGZvcnRpZmllZCBzdHJubGVuKCkgLS0gd2hlbiBDbGFuZyBsb3NlcyB0cmFjayBvZg0K
dGhlIGR5bmFtaWMgb2JqZWN0IHNpemUgZm9yIHRoZSByZXBlYXRlZGx5IGluY3JlbWVudGVkIHBv
aW50ZXIgcA0KaW5zaWRlIHRoZSBsb29wLCBfX2J1aWx0aW5fZHluYW1pY19vYmplY3Rfc2l6ZSgp
IGV2YWx1YXRlcyB0byAwLA0KY2F1c2luZyB0aGUgRk9SVElGWSBjaGVjayB0byBmaXJlIGJlZm9y
ZSBzdHJubGVuKCkgZXZlbiByZXR1cm5zLg0KDQpXb3VsZCB5b3UgcHJlZmVyIGEgdjIgdGhhdCBh
ZGRzIGJvdGggY2hlY2tzIC0tIGEgYnVmX2xlbiA9PSAwIGd1YXJkDQphdCB0aGUgZnVuY3Rpb24g
ZW50cnkgKG5leHQgdG8gdGhlIGV4aXN0aW5nIHVwcGVyIGJvdW5kIGNoZWNrKSBhbmQNCnRoZSBs
b29wLWxldmVsIGd1YXJkPyBPciBkbyB5b3UgdGhpbmsgdGhlIGxvb3AgY2hlY2sgYWxvbmUgaXMN
CnN1ZmZpY2llbnQ/DQoNClRoYW5rcywNClppcWluZw0KIy8qKioqKirmnKzpgq7ku7blj4rlhbbp
mYTku7blkKvmnInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHn
u5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXl
hbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jm
iJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTk
v6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53m
iJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwg
YW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9t
IFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkg
d2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQg
dG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1p
bmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBp
cyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxl
dGUgaXQhKioqKioqLyMNCg==


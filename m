Return-Path: <stable+bounces-274061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i9+UOfuNVWoYqAAAu9opvQ
	(envelope-from <stable+bounces-274061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE677500A4
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HnFJqAjg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274061-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274061-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E21C300C3A4
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996D35E1BD;
	Tue, 14 Jul 2026 01:16:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734A2DFF3F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991795; cv=none; b=QtbhKhQeJBPcZjsgn3FCJP5LUVFpLTFlMG/3K8geQ6EeRiJyFwOAFtiGtQr3hRV7RZfLW+7aqyp+7af0dVq/HqTGpr4tG7SBqYvAqxk+ci9X3GZV0+dh0USp5aWJQpwr27zbih412uYD7ORaYZYvkg0DX7jDaGbJIPGgWMZZe18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991795; c=relaxed/simple;
	bh=5JaK1plpC9siDLY4lGLmnQsYdx6ZiuNZ+yWRzZmmtRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urnSm5RUKAyziXRZV6DUybPpW0yWo+/Q9TaC5wwlOgcnodlBSBVDQIZP5uD0/KAvWZ7VnIII8sVzwkg38yGfygSChDLzFP40RAcx/HGxQALmLqkrDOsEXWCPXGGmbtxMPGpOKJZUZGnolFCkc0B5EjMRevPkYnbN9INJqPtSbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnFJqAjg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123C61F00A3F;
	Tue, 14 Jul 2026 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991793;
	bh=dHg9O/Ue4RAV92TH6sFgbjrwAqfXYfNm+P14DU6a0p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HnFJqAjg0yfo57ZNjpGd+QRsOZOqt7wu84jLQF1im0aHUBHYXcwe/VEBGzDHwhhyW
	 bWrEGS6W+w8TQwiL1jsHsgMPLOo4WWunE6pYEksAryIA5NAmYCgTJaV8t752e9oPRF
	 WX2qIk+AmMNkMVVgu82pK7Pu6a8nlHruj6HdWrVC+H7roCOvydgbgH7ur6WMNzg/00
	 jnXR0O/ydaHBozi2/W+jthdrz2UgugN/3vL9atArJBpMbQLZd1GH/b20xwsFFpZJHp
	 TeuaV/2hxhN+tKc8/EqKKxvhQa1wPMp8mJrsUusfXWfHdZPkPmpxAL8JMrKJAePFB6
	 SwQcbrX4P3cDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] bitops: make BYTES_TO_BITS() treewide-available
Date: Mon, 13 Jul 2026 21:16:30 -0400
Message-ID: <20260714011631.2188967-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071349-oppose-radiantly-81a4@gregkh>
References: <2026071349-oppose-radiantly-81a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,gmail.com,davemloft.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-274061-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:aleksander.lobakin@intel.com,m:andriy.shevchenko@linux.intel.com,m:przemyslaw.kitszel@intel.com,m:yury.norov@gmail.com,m:davem@davemloft.net,m:sashal@kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CE677500A4

From: Alexander Lobakin <aleksander.lobakin@intel.com>

[ Upstream commit 7d8296b250f2eed73f1758607926d4d258dea5d4 ]

Avoid open-coding that simple expression each time by moving
BYTES_TO_BITS() from the probes code to <linux/bitops.h> to export
it to the rest of the kernel.
Simplify the macro while at it. `BITS_PER_LONG / sizeof(long)` always
equals to %BITS_PER_BYTE, regardless of the target architecture.
Do the same for the tools ecosystem as well (incl. its version of
bitops.h). The previous implementation had its implicit type of long,
while the new one is int, so adjust the format literal accordingly in
the perf code.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 55052184ac90 ("iio: common: st_sensors: honour channel endianness in read_axis_data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bitops.h         | 2 ++
 kernel/trace/trace_probe.c     | 2 --
 tools/include/linux/bitops.h   | 2 ++
 tools/perf/util/probe-finder.c | 4 +---
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index f7f5a783da2aa8..e0cd09eb91cdca 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -21,6 +21,8 @@
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
+#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4491f11183c6ec..185eeeec204c9f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -534,8 +534,6 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 	return ret;
 }
 
-#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
-
 /* Bitfield type needs to be parsed into a fetch function */
 static int __parse_bitfield_probe_arg(const char *bf,
 				      const struct fetch_type *t,
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index f18683b95ea673..bc6600466e7b26 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -20,6 +20,8 @@
 #define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
 #define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
+#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
+
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
 extern unsigned int __sw_hweight32(unsigned int w);
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 3c13597d0a0db7..dcd64d71e08105 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -304,8 +304,6 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	return ret2;
 }
 
-#define BYTES_TO_BITS(nb)	((nb) * BITS_PER_LONG / sizeof(long))
-
 static int convert_variable_type(Dwarf_Die *vr_die,
 				 struct probe_trace_arg *tvar,
 				 const char *cast, bool user_access)
@@ -335,7 +333,7 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 		total = dwarf_bytesize(vr_die);
 		if (boffs < 0 || total < 0)
 			return -ENOENT;
-		ret = snprintf(buf, 16, "b%d@%d/%zd", bsize, boffs,
+		ret = snprintf(buf, 16, "b%d@%d/%d", bsize, boffs,
 				BYTES_TO_BITS(total));
 		goto formatted;
 	}
-- 
2.53.0



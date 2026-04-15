Return-Path: <stable+bounces-238117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBudJKOF32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:33:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA940447B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3027830160FA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8892ECEB9;
	Wed, 15 Apr 2026 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IActRP8x"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3484594A
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256349; cv=none; b=X1oC5drcoy1zofKMLLTo1njm4I7hosc8NesFRxUofn3+R1OXV2JqcevDYuCQipjPpBlmf1wSPu0BhrWCmIpiNyW23difJgpjQYU+D+zFlxgIZBk7sW9SnLc8kqc5qIwS6OnMjy/q73u1ROyOY5vsWnUB5IZmq3tpxcKlPDy57zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256349; c=relaxed/simple;
	bh=V5rhUICHKrtVS+VjsbYW9zZmMYRMee5pEQyn/IO+H4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re6NcfW1rELB4j2QQZlHi+2Oov4oILrf6UBJBbJTWhTkvJhCWUfwRkr8XLHuL4gkXOC1dV+zvKSjOiuwOzH1th0PogVqSEW4KTkcCM1ANpDhMXYK1f/YtgRtcN6291EigfyAjaAdLG29s5NQ9HX7CEBBIh0kIm84Bc9P8RfRAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IActRP8x; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50b2b289925so55166741cf.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256347; x=1776861147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4tBTeu6/viYuFA/jm9+9NVpLFwhjRRaKWPLY9i5P/o=;
        b=IActRP8xapeA8cJ3JS9dfgHRRssqS44VtHYGLuz6Hlb+3pkCkBG9ratwxAXBa1OPJ2
         G+7+7qA9oZ7TvDqmCGnC/H+htSYWrNo5U7xQGaHAGQNmFp0Bdp13P08mna7v9FpjWifj
         gOAfdP9vrJoR/Fkvo9NZS4VOcsf6Uz9fbYuo6fhbNr3GFXxZEYF+PTKraG161LS+WUBv
         tadv/SxNfVate93ppjIlfJYfqkFVT1y/H+2ceqH9pu2hEY09sd/jHH2aQxMMEoF8ibCi
         L5LMS4WHZmvFZGoi/W5tlZwJk4S1EixWr+VWHUortmEpkBCTwyLjXQIhaKuNnE929M2l
         73vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256347; x=1776861147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4tBTeu6/viYuFA/jm9+9NVpLFwhjRRaKWPLY9i5P/o=;
        b=kt4o4BLeK/56SRacka2bi9Dn3inCfryJBZjchOrGMmsYhrKeoSICNXn07PTXvvK2jW
         +GbQVYtY3zvYhZxvvWwscZSlQgDSfRpgpXWOPK1VAm6LloR4o7FYEfZB+yvhcRwKcBaf
         Nyq3L9W42ulyeg9w+O8qbw9+KxXGLdSFEEzHGaHgFEwfzqguFEKS+MtDzMTO4oMjki6d
         2ykcN5wospqvyDzImZPSqHs+x+kErWQPNtEHbIPRrF90ebDK4kYtHu6GwtpOJPgHnUnF
         Fj3AH9edlLWxWr28j59zysnXEsVIY0ODRTdKEXB3TDgXubMQ334Ip0pu7AkvR+f1+lKn
         /F+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Dc4jypcZdTVZX2E2TsaB88MfIekW6ZiQz1a54D8bUcKoTEjAQYi7DK/GNlm1y5e4tEeSeazs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9KuHiqEqxN/dhxkGtySZhhpRoYu3QaxFR8a5b6IYW2j4tjkY
	h4izUdJH9KDJqNJowI0j5DBYZeyZm1NtZOkMW2xYlnfTiwklImj4MXaL
X-Gm-Gg: AeBDiesw/ttQCsUWH2Cm7E8LLk5pd5Fj6cSV9P/Gko7IwqJXuVtPdmg/23n8srI8x11
	HdHDNX5zmUmUS3B3+vyHm2clAIZn6Fv270xPhiAN+unmkJdZzxvqGBTM1q1S5CPdRnWSJuGJHzu
	ZCMr0EbeCnsGmzb3WicP03dovqnPCL7Y/AHKlBeS+GkQZEHa1VdB+WsIk/ZqM+tUB36eHBw0PmO
	qpeXqWO4pskt2tgZajxBTo+xgq04XKoVtst+zdRN9NZHlVT0T8Grol1S6vOK3CXjQANcOvcOsQN
	HJCyboYsnaCDMXpK4HvXX5Io7DVmngskHcUG1byncLsN0Azpke8a3SUgLS1i5tzfB1AlP1jwuNp
	gllge66XgP9DRcUdAwbNQLEG/6Clyc7/q60VFFswP+09v7YslUPE2A4M/pBV0JmWL7M7TUyZVgs
	BwmXkyJaRuN40MrCCldZbTUuQJPM9L5UaGZm6mnagfzEw8F3e7CFKVSWSLKtBXnC/pu+E3fdt29
	EBi8q5mgmEiHN9dWNGotmrTlAeMqxGcUWjNtrNl+DBX6kH55Q/0VlIvZr956x0e
X-Received: by 2002:a05:622a:6694:b0:50d:41fa:80fe with SMTP id d75a77b69052e-50dd5bd98c4mr217424231cf.53.1776256347106;
        Wed, 15 Apr 2026 05:32:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm11747771cf.16.2026.04.15.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:32:26 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-usb@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] thunderbolt: property: reject u32 wrap in tb_property_entry_valid()
Date: Wed, 15 Apr 2026 08:32:17 -0400
Message-ID: <20260415123221.225149-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415123221.225149-1-michael.bommarito@gmail.com>
References: <20260415032335.2826412-1-michael.bommarito@gmail.com> <20260415045246.GR3552@black.igk.intel.com>
 <20260415123221.225149-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238117-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0EAA940447B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

entry->value is u32 and entry->length is u16; the sum is performed in
u32 and wraps.  A malicious XDomain peer can pick
value = 0xFFFFFF00, length = 0x100 so the sum 0x100000000 wraps to 0
and passes the > block_len check.  tb_property_parse() then passes
entry->value to parse_dwdata() as a dword offset into the property
block, reading attacker-directed memory far past the allocation.

For TEXT-typed entries with the "deviceid" or "vendorid" keys this
lands in xd->device_name / xd->vendor_name and is readable back via
the per-XDomain device_name / vendor_name sysfs attributes; the leak
is NUL-bounded (kstrdup() stops at the first zero byte) and
untargeted (the attacker picks a delta, not an absolute address).
DATA-typed entries are parsed into property->value.data but not
generically surfaced to userspace.

Use check_add_overflow() so a wrapped sum is rejected.

Fixes: e69b6c02b4c3 ("thunderbolt: Add functions for parsing and creating XDomain property blocks")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Assisted-by: Codex:gpt-5-4
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/thunderbolt/property.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 50cbfc92fe65..f5ee8f531300 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uuid.h>
@@ -52,13 +53,16 @@ static inline void format_dwdata(void *dst, const void *src, size_t dwords)
 static bool tb_property_entry_valid(const struct tb_property_entry *entry,
 				  size_t block_len)
 {
+	u32 end;
+
 	switch (entry->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 	case TB_PROPERTY_TYPE_DATA:
 	case TB_PROPERTY_TYPE_TEXT:
 		if (entry->length > block_len)
 			return false;
-		if (entry->value + entry->length > block_len)
+		if (check_add_overflow(entry->value, (u32)entry->length, &end) ||
+		    end > block_len)
 			return false;
 		break;
 
-- 
2.53.0



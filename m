Return-Path: <stable+bounces-245085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJyaMBcSAWq4QQEAu9opvQ
	(envelope-from <stable+bounces-245085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:17:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD44506C8A
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 01:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 045F63021EBD
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC1A3ACA6A;
	Sun, 10 May 2026 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQUksigC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D62D5C83
	for <stable@vger.kernel.org>; Sun, 10 May 2026 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778455039; cv=none; b=ehBbSko19SthsEhAjjvWjIu9jmJHI7GHPBTSgIioRiIZjwoiskGu+eVYDc2uWOENE7kRQHpyx+olDOp9VxiEBk8o/TK0rsJV6Tj5iza1H8hk9doonBwqUQskuYJooQCK6TOGA8WhSRpIhz1LdAB+3riNSfw0UFPY4wlm7WaLeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778455039; c=relaxed/simple;
	bh=YZII72Oick9IeAiiaT/UnCAg+UD6smbLqUSA0eLyeIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czv9RvpMK8HKDCybIWOJuTLZdqCeVA+U32xI13F6afBteuX1WHSt9uSmMhBWOSKIPu8xVvqB1ZBFLRGu0EX/N+Fio6v6khM80oC+U+m/ZtX15q4xLX0LGSkodaBYKS1XbX9cOyVbcNvixuqGJgwZ3mqy4phyZv/1tCodPDX/Abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQUksigC; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so37382776d6.2
        for <stable@vger.kernel.org>; Sun, 10 May 2026 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778455036; x=1779059836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5zjnDrUiSkYFu0TKawgtoTzPZ8uHjh+BGUiMJGyQLk=;
        b=OQUksigCEJ8SKvHMEQitSXdRtuM1VQkvtBZTZE5KtHS6gnfPEqyH5z1JZZj4xJkRAL
         VioUvrblo1UxzQ/OzclGdPJOCuNKALGPxzh0ewV71ZcPNQyNYHyUL7YtRcCfBODAIwWg
         9TilibBEP0rJAk0s8MPWA4QlUO0Y2ndpO+7kYOc1uxk1J8P6qoYnYoECl5uQZAecCwlh
         4mbcJnRpeKqHuGNyPOqVKjhcqHPE/AjFi/Z0aw4Cbo+HQqFsuO4yBSL8TWdNqBpn0VwT
         0p29C4j4+WcaVvZPxVK2AhzS7p8fek2b7D+uOuZ41DhMFbBqCmX/FedoFsCiQS2D/9BA
         wq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778455036; x=1779059836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5zjnDrUiSkYFu0TKawgtoTzPZ8uHjh+BGUiMJGyQLk=;
        b=Cvz0D7yDBhJmYv4EX+10dDid4c3cfNhyKRIo8w+m0C4oBetfFpC+eqcGs5hq3w8d1Q
         CIC/BUZN8ODMFq5vhfYzpBr37dpTXWPsGNakDAzSHZgq0VZMSrXeMyUYWabeSTv2k/U4
         GebCESLLxoSy3fKa6/TLBnQPQXH2xhuumabayNm5G0YsjVWB6xW3lI0KNIN9ISZPUBGl
         9RGpCfIjbeCpu0u0xQgEUwEA+dVx7iDfHN2D563AzBF/7jIJDDeCFxwUG/jfU1JWjqTE
         S60wQj7sApaG7Gub+c1VFOGYiAGHeE5ccUNBBE98cUVpO7dk2DT1IomYNdtsTAYt0ltX
         bsRw==
X-Forwarded-Encrypted: i=1; AFNElJ9dgROAHjUZha05NWVa+9F3ChL+dTJmNM7MnGGAGiExAlnZjE3BxlhpycXOMo0OhH0qRJWSAbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZxADDc6pMRt5LBvsdacrEbFZy2dwEmLBU8wnH/qylmnVoPZg
	PIe3fDTOFMiBZI8W/VBDNiKdPTwnuzHG+eBu325RmM/Vt8nFeKQHRtlK
X-Gm-Gg: Acq92OH+6y9tJAmNJ1kjh3DBlarDrjVaPhXn5tgIB5lndWWRstdhLdtcwZb4tflc0BB
	kIaYYBtzK6g6XGW4e8MgLW2tEyEp8Qk8f8eFH9OZ7czbvli2+/ofMshL7Lmekr7FHQN0oZuqcfQ
	lNs3Tx/oQORZPD/Wp2bKzh/qthhz/yOdC537+wj/7w/BVBQr++AzIlxoJgq7HCIIVE6fX9allIN
	0psFFZLg9tc139ZA8dBoZqwwwGoeIVUqCQaYPd2FXIjVaEGnOh3y+0gSmVsoi5HZDWt1XVeMNed
	gh4XXbwIkwNP0hWdxHwi5yL+X5WyMr30kK0YfeDpwfW/JOqhlMhT0IOKGEuvtfOGWcdBYKN9JsP
	oO8tQoC6DpAqCLA+UzvIxTETY6xODNHJ8WyKit9BfVsmr+0pIdplLv9+9osEjBsYYe4w6mIksw1
	8O+Sl9tRvzKxM5+btJD+K9ft1W4aaiKb3j/dfdOyueCY78qdjQYbosA1gkwug/nVot8fnb/ls3G
	+I0gPUJaHD4FC4TXTcZhDfw7vdQfWpsahCXrbg3H8PcWkH9jg2AMw==
X-Received: by 2002:ac8:700e:0:b0:510:1b61:d103 with SMTP id d75a77b69052e-5148e95028bmr124590681cf.36.1778455035680;
        Sun, 10 May 2026 16:17:15 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e830ddfsm75015031cf.27.2026.05.10.16.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 16:17:15 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	linux-usb@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 0/4] thunderbolt: harden XDomain property parser
Date: Sun, 10 May 2026 19:16:55 -0400
Message-ID: <cover.v4.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777817011.git.michael.bommarito@gmail.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com> <cover.1777817011.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1DD44506C8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245085-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,intel.com,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Style cleanups only on top of v3.  Andy's three nits on 1/4, 2/4,
3/4 are applied; Mika's request to drop the duplicated on-wire
entry struct in 4/4 is applied.  No behavioural change to any
patch; the bug analysis and the gating in patches 1-3 are
unchanged.

Three independent memory-safety defects in drivers/thunderbolt/property.c
are reachable when an untrusted Thunderbolt/USB4 XDomain peer responds
to a PROPERTIES_REQUEST during host-to-host discovery.  The peer
supplies up to TB_XDP_PROPERTIES_MAX_LENGTH (500) dwords of attacker-
controlled property block which the local host passes to
tb_property_parse_dir() as part of the control-plane exchange that
runs before any tunnels are set up.

Patches 1-3 are one bug per patch: u32 overflow in
tb_property_entry_valid(), short-dir_len OOB+underflow in
__tb_property_parse_dir(), and unbounded recursion in the same.
Patch 4 is three KUnit regression cases exercising all three.

All three defects are OOB-read or DoS at worst.  No controlled OOB
write is reachable through the parser; parse_dwdata()'s destination
is a freshly kcalloc'd buffer sized by entry->length.

Operators who do not need XDomain host-to-host discovery can disable
the path entirely with thunderbolt.xdomain=0 on the kernel command
line.

Reproduced on v7.0-rc7 + CONFIG_KASAN=y + CONFIG_USB4_KUNIT_TEST=y
via the KUnit suite in patch 4.  Pre-fix on a v7.0-rc7 + patch 4
kernel: u32_wrap fails with a KASAN use-after-free trace in
__tb_property_parse_dir() (the parser reads ~16 GiB past the
block); recursion fails with KASAN + an Oops on RIP=0 as the
parser exhausts its guard page.  dir_len_underflow returns NULL
on pre-fix because the downstream content_len = dir_len - 4
underflow makes the entry walk bail at tb_property_entry_valid();
the UUID kmemdup over-read is silent here because KASAN-Generic's
slab redzones do not flag a 4-byte over-read into the
kmalloc-chunk tail.  Treat dir_len_underflow as the post-fix
invariant pin; u32_wrap and recursion are the active pre-fix
detectors.

Post-fix (all four patches): all three pass cleanly with KASAN
active.

Changes since v3
----------------

Cosmetic (per v3 review):

  - Patch 1/4 (Andy Shevchenko): drop the redundant (u32) cast on
    entry->length in check_add_overflow().  __builtin_add_overflow
    handles mixed width via implicit promotion; the cast was noise.

  - Patch 2/4 (Andy Shevchenko): insert a blank line between the
    !dir error return and the new INIT_LIST_HEAD(&dir->properties).

  - Patch 3/4 (Andy Shevchenko): keep the four-argument
    tb_property_parse(block, block_len, &entries[i], depth) on a
    single line (>80 col) instead of wrapping the trailing argument.

  - Patch 4/4 (Mika Westerberg): drop the private
    struct tb_test_property_entry overlay.  Populate the crafted
    blocks by writing u32 dwords directly, matching the existing
    root_directory[] style used elsewhere in this file.  Each test's
    kunit_kzalloc is right-sized to the dwords needed to actually
    exercise the bug (0x102 for u32_wrap, 10 for recursion, 7 for
    dir_len_underflow); the 500-dword allocation v3 used has been
    dropped.

    u32_wrap retains length=0x100 / value=0xffffff00 from v3 so
    the entry's length field clears the "entry->length > block_len"
    gate (block_len = 0x102 dwords) and the wrap check is what
    actually fires.  recursion uses length=8 (was 16 in v3) so the
    smaller block can hold both the parent UUID kmemdup and the
    single child entry that drives the recursion.  All three
    pre-fix scenarios are still observable: u32_wrap page-faults
    on the KASAN shadow lookup for the wild OOB offset, recursion
    trips a KASAN out-of-bounds report in __unwind_start as the
    per-task kernel stack is consumed, dir_len_underflow trips
    KASAN slab-out-of-bounds in kmemdup_noprof.  Post-fix all
    three pass.

Changes since v2
----------------

Material:

  - Patch 2/4: move "dir_len < 4" reject before the UUID kmemdup
    in the non-root parse path.  v2 placed it after, so a crafted
    entry with dir_offset near end of block and dir_len in 0..3
    OOB-read up to 4 dwords past the block before the reject ran
    (dir_offset=497, dir_len=3, block_len=500 reads
    block[497..501]).  Both that OOB and the original
    content_len = dir_len - 4 underflow now hit the same gate.

  - Patch 4/4: tighten dir_len_underflow's buffer (7 dwords,
    kmalloc-32) and reposition the entry (e->value=4) to focus the
    UUID kmemdup on the chunk tail.  KASAN-Generic does not flag
    the 4-byte over-read into the tail, so the test remains a
    post-fix invariant pin (documented above); v2's wider buffer
    obscured even the post-fix-pin shape.

  - Patches 1/4, 2/4, 3/4: fix Fixes: SHA.  v2 used e69b6c02b4c3
    ("net: Add support for networking over Thunderbolt cable"),
    the wrong commit.  Correct is cdae7c07e3e3 ("thunderbolt: Add
    support for XDomain properties").

Cosmetic (per v2 review):

  - Lowercase 0xffffff00 in 1/4 and 4/4 commit messages, and 4/4
    code + comments.
  - Patch 4/4: use TB_PROPERTY_TYPE_DATA / TB_PROPERTY_TYPE_DIRECTORY
    constants from <linux/thunderbolt.h> instead of bare 0x64 / 0x44.
    (v4 reverts to bare hex in the u32 dword that packs (type <<
    24), since the type byte is now part of a packed dword literal;
    each dword carries a `/* type=... */` comment.)
  - Patch 4/4: convert all multi-line block comments to put the
    opening "/*" on its own line per the thunderbolt subsystem's
    coding style.


Michael Bommarito (4):
  thunderbolt: property: reject u32 wrap in tb_property_entry_valid()
  thunderbolt: property: reject dir_len < 4 to prevent size_t underflow
  thunderbolt: property: cap recursion depth in
    __tb_property_parse_dir()
  thunderbolt: test: add KUnit regression tests for XDomain property
    parser

 drivers/thunderbolt/property.c |  32 ++++++---
 drivers/thunderbolt/test.c     | 126 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+), 9 deletions(-)

--
2.53.0



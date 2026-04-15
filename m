Return-Path: <stable+bounces-238018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BBON9AE32khNwAAu9opvQ
	(envelope-from <stable+bounces-238018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:24:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E172D3FFF35
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B30A83025F5A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C7318BB8;
	Wed, 15 Apr 2026 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIkdewDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37330F548
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223433; cv=none; b=f4a7pG7xqNl3RsJlifQFGHABKjTYUkA6ySDDr9VKks8gpZHkT7UiDOxXpZydfZ2OnxH7/Zxcyqm8ctuq6CqkMXij1B0akp3c3KBjhY6lvWXDNegvPdLpNKkM05csCiN4y02Q7C2OOZM9wG068dwRTxMPf+Og14iPoxXP+dZxtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223433; c=relaxed/simple;
	bh=Vz3WhsWUS63jciNs28uqN9yT83yyNPX4LywYZ6shuy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QGC8rmxRFTLi/m8ZKN2+U+j2x//EVECxb1cpH+GQa+1fvbRp9b38WepfxV38QaEwGuqE1wAD7wbP/2QHth+KZx3Dc37L3FroP5j2CEGaqm37BZMbJNMooKih/ohDu4TNsJt7sQZTmIriDB3Dc+IRGlQhrQEiPQoShoa/hiqZYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIkdewDg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50baf2df711so50762651cf.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776223431; x=1776828231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZJOkDm/b8XgD3fyVXH1XMDOb8pSizuWNRtrW3NsE7w=;
        b=mIkdewDg4Dei54zwgvC6+hUJ4Mkz10LJa/XlZbamI4akKpHjdavcsOO9PHsL9paLpJ
         v2cmkUjEXrS8arj+wWEXLux5klmHv+IUIjWCdDynA2hma015esOa3VC+EFc1eOvaChkm
         ZLldf09Hzf3iUkq7pRLa6JmCK4IL20t/phOTM/dJWeGTEgFZqHv9lrIXqLEYfm3Yv3GL
         LQbXt+mWE4HndVSWthzQO5wZIUqt8ccWUhewsVnIZ+tusOadh4bGWJhKatQUmObNMadq
         o2+JPNo9pN5JQnlV/T0tTUsYip8Q5YS2BGAumetI94BPwIb/Vp0wpe2LUragBgJ4WU+I
         1ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223431; x=1776828231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZJOkDm/b8XgD3fyVXH1XMDOb8pSizuWNRtrW3NsE7w=;
        b=Q8Jsrj/42kVH2GQgz8Dvt5zIAT8RlAM3btHxQt8o9IkBBeyCT0xRZRjO7yBkoTB80W
         xAeFbHwILfEJsQ+yv8SvDzZ2nVMOHX8sJhehrtOtyC4tEEwLHfdULMbhkWatX3SRAP/v
         3wMFnftw9Ajxp3iGZWBu+oU8tXrnpHWwcW3kpENP3Ja3mOs6ZXQtbEoidVcCr3nKyeT9
         OgN7lVwab4bPGOhqxZDJOlfOik+/RQ9EvAbGKph1K0zNsQUnD6f5A/x+6RlA6iStf5sI
         wlm8g22P0AqNghnNVDIEcn096bleYPyiEcgz/3BPD9vJxwC1l6AhpalaDgjPZD83v9DE
         K4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ9iHxyptJg56tF/lGxNec6LpQWFhLZdVCBfiw3oLhUTprrhCmpvCGcl1nWmpYHwXShUTsBhJIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHcxBpAVrQbQa2jDlZ/bJ0BrM55tn+JGwGfw67kSyDRCifnOn
	GktQt0/3whoIpHdFrE11V9XHLnxDJl26+S6gmpywTQZUN5HAk28rrDs+
X-Gm-Gg: AeBDieu4VMiQzLmBkjFxwbeGKZ8npPKauY5607dIEEXOq53LQQzF6zGgTvUlcwBZHNX
	dgcGQply8EejfLYJRyYmw4qglht7pW1kw8QnTSU4JElF23J5/jp+IH7HPFYp8T1ggGYh5bTsXAe
	t5xQhwzkxExDeR1liKBOGmgw0M6Hf0qRPk9no+EKnxJnDGzJavWhyVYWYwH4rerMeyS/0E3DxwI
	/wbwo+aPKUfzfz0tcUrIsI9SsdBC/hvPhAdKvL3ToQuoawUr8D7UUPWZSlns8lRcPaE3mX4EC4n
	MjSIB3No9Eg3M6hYpsahOhNPjtzp4af/UOUNGPcQl/z7+wlywSNLf12GGCFvcvYx66Fqxrq3zoi
	Om3EcWUUFUu7wxfVothyfLCTXje2JG8IWmfV26Zuq/DPJHaLPjQ+vSQli0VlmUa3/YQ10NnhI9X
	Z1D1e6bioWizzhzb/yZDKssfxrIGbVBS/Q4rzkH+jklGUPnANAUbITmJXsy4KlO/2pX6DVMU9JK
	tdfofN0FHuaCtmrjUXks+TO/MoSw4I=
X-Received: by 2002:a05:622a:11c5:b0:50d:882e:c5ae with SMTP id d75a77b69052e-50dd5bab443mr301509201cf.44.1776223430579;
        Tue, 14 Apr 2026 20:23:50 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b012b23sm3713071cf.30.2026.04.14.20.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:23:50 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-usb@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] thunderbolt: harden XDomain property parser
Date: Tue, 14 Apr 2026 23:23:33 -0400
Message-ID: <20260415032335.2826412-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238018-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E172D3FFF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

Three independent memory-safety defects in drivers/thunderbolt/
property.c, each reproduced on v7.0-rc7 with CONFIG_KASAN=y
under qemu + KUnit.  Pre-fix, crafted XDomain property blocks
oops the kernel inside __tb_property_parse_dir with CR2 in the
KASAN shadow region.  Post-fix, the three KUnit cases in patch
2/2 pass cleanly.  

The defects are reachable when any untrusted Thunderbolt/USB4
XDomain peer responds to a PROPERTIES_REQUEST during host-to-host
discovery.  The peer delivers up to TB_XDP_PROPERTIES_MAX_LENGTH
(500) dwords of property block which the local host parses before
any PCIe tunnel is authorized.  The specific parser sites here
have been sitting here since the original 2017 XDomain support;
the file has had three prior NULL-check fixes in 2019
(106204b56f60, e4dfdd5804cc, 6183d5a51866), none of which touch
the bounds / arithmetic / recursion sites addressed here.

Worst case situation is either small OOB reads or DoS for
someone with physical access.

Defects
-------

A. u32 overflow in tb_property_entry_valid() (property.c:61).
   entry->value (u32) + entry->length (u16->u32) is performed in
   u32 and wraps.  With block_len = 500 an attacker picks
   value = 0xFFFFFF00, length = 0x100; the u32 sum 0x100000000
   wraps to 0, passing the > block_len check.  The subsequent
   parse_dwdata() at :132/:143 reads entry->length*4 bytes from
   block + entry->value (pointer arithmetic promoted to size_t,
   ~16 GiB past the allocation) into a freshly kcalloc'd
   destination.

   Exfil path: TB_PROPERTY_TYPE_TEXT on the "deviceid" or
   "vendorid" keys has its value.text copied into xd->device_name
   / xd->vendor_name via kstrdup() (xdomain.c:1157-1162), which
   are read back via the per-XDomain device_name and vendor_name
   sysfs attribute show() functions (xdomain.c:1730, 1763).
   kstrdup stops at the first NUL byte, so the usable leak is a
   NUL-bounded prefix of attacker-directed kernel memory.  This
   is not an RCE or arbitrary-write primitive; it is an
   OOB-read / info-leak class, untargeted (the attacker does not
   know block's KASLR/slab placement) and bounded by per-read NUL
   termination.  Fix: check_add_overflow() on value + length.

B. Unbounded recursion in __tb_property_parse_dir().
   DIRECTORY entries are parsed recursively with no depth counter;
   a peer that crafts a back-reference chain drives the parser
   until the 16 KiB kernel stack is exhausted and the guard page
   fires (pre-authentication remote DoS).  Fix: bound recursion
   to TB_PROPERTY_MAX_DEPTH = 8.

C. size_t underflow on dir_len - 4 (property.c:184).
   dir_len arrives as size_t sourced from entry->length (u16) on
   the non-root path; length < 4 underflows to ~SIZE_MAX,
   nentries = SIZE_MAX/4, loop walks entries past the block.
   OOB read + potential kernel oops.  Fix: reject dir_len < 4 on
   the non-root path.

Additional hardening: move INIT_LIST_HEAD(&dir->properties) to
immediately after dir allocation so every error-return path that
calls tb_property_free_dir() sees a walkable empty list rather
than the zero-initialized NULL next/prev that would oops
list_for_each_entry_safe().  This also closes a pre-existing
latent bug in the dir->uuid kmemdup-failure path at
property.c:180.

No controlled OOB-write is reachable through the parser;
parse_dwdata's destination is a freshly kcalloc'd buffer sized by
entry->length.

Attacker model
--------------

Malicious Thunderbolt/USB4 XDomain peer (cable, dock, in-line
inspector, adjacent host).  Discovery fires during link training;
PCIe tunnel authorization (the thunderbolt/.../authorized sysfs
gate) does not guard the control-plane PROPERTIES_REQUEST /
RESPONSE path.  Host IOMMU does not mitigate because the data
arrives as a control-plane payload the driver willingly copies
into its own buffer before parsing.  No user interaction beyond
the link-up event.

Reproduction
------------

Patch 2/2 adds three KUnit regression tests
(tb_test_property_parse_u32_wrap / _recursion /
_dir_len_underflow) to drivers/thunderbolt/test.c.  Tested
end-to-end on v7.0-rc7 + CONFIG_USB4_KUNIT_TEST=y + CONFIG_KASAN=y
under tools/testing/kunit/kunit.py run --arch=x86_64:

Pre-fix, each test oopses inside __tb_property_parse_dir:

  Oops: SMP KASAN PTI
  RIP: __tb_property_parse_dir+0x3ce
  CR2: 0xffffed108045eb80     # KASAN shadow region
  Code: ... 48 c1 ea 03 <0f b6 0c 2a>    # KASAN shadow byte load
  R8:  0x100                  # crafted entry->length
  [FAILED] tb_test_property_parse_u32_wrap
  [FAILED] tb_test_property_parse_recursion
  [FAILED] tb_test_property_parse_dir_len_underflow

Post-fix:

  [PASSED] tb_test_property_parse_u32_wrap
  [PASSED] tb_test_property_parse_recursion
  [PASSED] tb_test_property_parse_dir_len_underflow

Full run command:

  ./tools/testing/kunit/kunit.py run --arch=x86_64 \
    --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_NVMEM=y \
    --kconfig_add CONFIG_USB4=y --kconfig_add CONFIG_USB4_KUNIT_TEST=y \
    --kconfig_add CONFIG_KASAN=y 'thunderbolt.tb_test_property_parse_*'

Series
------

  [PATCH 1/2] thunderbolt: property: harden XDomain property
    parser against crafted peer
  [PATCH 2/2] thunderbolt: test: add KUnit regression tests for
    XDomain property parser

Patches apply to v7.0-rc7 (commit a8ee600e7aff).

Thanks,
Michael

Michael Bommarito (2):
  thunderbolt: property: harden XDomain property parser against crafted
    peer
  thunderbolt: test: add KUnit regression tests for XDomain property
    parser

 drivers/thunderbolt/property.c |  67 ++++++++++++++---
 drivers/thunderbolt/test.c     | 127 +++++++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+), 9 deletions(-)

--
2.53.0


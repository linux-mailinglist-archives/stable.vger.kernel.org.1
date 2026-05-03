Return-Path: <stable+bounces-242790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIHbFZBY92mEgQIAu9opvQ
	(envelope-from <stable+bounces-242790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:15:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB134B5F95
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC32E300F97F
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA73CCFC2;
	Sun,  3 May 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOIkYowp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654B3CCA03
	for <stable@vger.kernel.org>; Sun,  3 May 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777817732; cv=none; b=i5eRjvktHbbAChB+c6QHj0qYyJ1CjF4yuprvIXTulJWKKOkxbMbHVzrkREaAGM8rggb8z0ZHo5YDVllHhgqiIFtLKpuwgw2te1Ergq1PRVYH4EmLsun5D46nSYfquyOaUs53ijAaAuqFV1uxcUX3XBobJurzsLqDopHs+2GgCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777817732; c=relaxed/simple;
	bh=/3d3YUB84LBvSg8RhpQQfhKFPCfmZHQblYjmVcQdYRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1rimYOLYGW0l2GBifup3frRLxnQyALS7d0apDMmN9g9/MIAgkwDc0f9lZljuuQ8RlIiWdkUGrN51aJVMpLW9gAIUexBMPWFlnYeXKFjm1pvaINhbf6f1PLxCaoNXz//klaNdTGTRQWWhGA5zJ/erGR1EpBt9u8h68E4lLtlqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOIkYowp; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d933da14f0so358285885a.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777817730; x=1778422530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPYl+D5Z/0OwSvKuu86ylxC+ZLb/TAcjdwtykkm9EUA=;
        b=rOIkYowpOoO7Jc3pacQKgnoZRJpVMZesXCTv7xuRmBtGD6z5TCroZvtBC7llf8OL6R
         cVKXTwkyoDHnXL/lg5GnMtaeYLfSPJpurBqnI7sZt1eNvWK3qCeannswuNKsB+rTAXNY
         tFFkB/oDfqe/G+0zAXlMWGzfq3IM9N3FCSHCTYTa5Tt9utoXhfTjq0bkvp63aLjH19dX
         1izhf4+Vd4KRbEsDBzhiT+Kw9nY9ifFbefK0vz6knVzJkSif91vCzVOF5z1tpfDcu7jF
         /JEcXULktTIaAiDv4YnVgyzm3FnNDs6ezY05BpTgQtwH5wOtGyYV0OeFQi1+XNUZSj0n
         IQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777817730; x=1778422530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPYl+D5Z/0OwSvKuu86ylxC+ZLb/TAcjdwtykkm9EUA=;
        b=lTMRSHN05Oph9NOg5vXWTaao+HAsAL0v/hmnvm3y6UXWX6u3QOag2fXpq2CJeh7+xn
         KFezXqY2HVsNFi7IDvtkNd31gl5ZzmNE+LZj2Ljh80RbuZguOcnr5kYpdiLqQFXvAej2
         jqk2JDSoX5bfjqpb2skv4efLfCGOIyubXJbQrqEl2/FXD0v8jHjD3NMAAMfmJj5u2ZbW
         +h6P0qM3NVoqLApNo2iH0IniMCMJTC+CIe25P7pB/MN6Jy/z/S8E5EBMPyz/Lp16gqCL
         oMS2ak1r37cNbnnn8HgIGWbwKgmhl+RM6BEnrYdPis2wFY18fL6049Bnhtc2y5zHl66X
         VXZA==
X-Forwarded-Encrypted: i=1; AFNElJ9f7JBzSgQMzYi1/+TLVaQEqoH7NmxJB23vD8fx1zJI8RNAzAn628oF2WKxTIWEu6KS3JFQP6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSM/i8aeTWy5KEFS9HgRiIPVdGo68xyctcmk+hRbV8raGW6Rm
	6oSDVSsmbZyeKH5IkvXmcFu+XPIHKyFT6ePUPu3IR7PqlnfJeTb0uiav
X-Gm-Gg: AeBDievceNqe8vHjXJNHhDXCVLvUqL5UJoRQfMjCSC5+z/dszZO35GlIQ7zO2GfQRZI
	6nn6TmA6UY/ztK3OXYR9T6FL0aMn04FKjxIsAqBzKYaGEeJT1VBJWh/wMOKE5iRSbL1huz/kBmZ
	CpuXuP0KPHXNsUMvBqXzWJGVi9jcfxZ1YVOeo08rQTovNy4DQ97wPdY1BhmFGMVucN9E06ZzGeL
	AgeuHY1WYkewpydk8rdPAJcWFfgEhSVoZRn+SFJP8AlBn1rx/6Zkd979fY/UYpmrcvqSTgGkL5y
	nXVjWv17RfiQlSJYvUS4NEcZoLJehi7for0UnasJwXW29QCOAKZc6PKfa3IT7/k/4yG6/AGKuGI
	KP+NTSxhUKO9/qj1GdSHeKGSVYw10+b5BxRuDEuwP4ghxMDQvc/zD2wxSnnzIe1/17LQqce+eWh
	s1OfbL9VBDhw+d001UFN53tJKUHCJvMUaXeySWPCOv3gOsD2wuSUPi+8pr0XBidX7TLxz7jH9VL
	XhZR83mmwBMNQt8CMeQ7q21NXTO3Do=
X-Received: by 2002:a05:620a:400a:b0:8ee:21b3:2eb5 with SMTP id af79cd13be357-8fd155f2302mr958377685a.6.1777817727083;
        Sun, 03 May 2026 07:15:27 -0700 (PDT)
Received: from server1 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938e0b9sm766261985a.9.2026.05.03.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 07:15:26 -0700 (PDT)
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
Subject: [PATCH v3 0/4] thunderbolt: harden XDomain property parser
Date: Sun,  3 May 2026 10:15:04 -0400
Message-ID: <cover.1777817011.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415123221.225149-1-michael.bommarito@gmail.com>
References: <20260415123221.225149-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BFB134B5F95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242790-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.990];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Caught a few more cases, so this addresses both your cosmetic asks
on v2 and the more material changes noted in each patch below.

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
  - Patch 4/4: hoist the on-wire entry layout into a single shared
    struct tb_test_property_entry instead of re-declaring an
    anonymous struct in each of the three tests.
  - Patch 4/4: use TB_PROPERTY_TYPE_DATA / TB_PROPERTY_TYPE_DIRECTORY
    constants from <linux/thunderbolt.h> instead of bare 0x64 / 0x44.
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

 drivers/thunderbolt/property.c |  32 +++++---
 drivers/thunderbolt/test.c     | 132 +++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 9 deletions(-)

-- 
2.53.0



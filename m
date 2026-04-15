Return-Path: <stable+bounces-238116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BMyOIOF32nSUgAAu9opvQ
	(envelope-from <stable+bounces-238116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:33:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ADA404463
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 14:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1593130398BA
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1CF271450;
	Wed, 15 Apr 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi4AtZaV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87CA15E5DC
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256348; cv=none; b=gdh8D0V1+Mtm1bmDfE21pWvY/MFGeHEkEo3gZ9xwRee/jb0uHPmttZv+3Rceae+2WcbQBoICgXXqt0fOW1auEiYnXhgBQ1izBZNmW/SUrngfqy7FZjseSnm3ItMGTWyRv3MvUfPYWKc/51tjTwruRlGzg0//bZSE73OkGugqBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256348; c=relaxed/simple;
	bh=L+xsxHrXAd35lGAgHddprcPWn/tYSpJPrub3gdZDu1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5rKxqrN8HAVILUl/SmFAD/Sj5qwV98a5xOJvn4vyK14HrEeNMJttfMCPVjyToZ8drnEGj10Qk3YFtIrrpELZ3UOOr10MY/UALuoblbg1kAV+9TtxTaXoaCwOlNssQdgYlUkCiO9uIsA57s7BIlhwH2cDq4qf71+kA7v3hECdGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi4AtZaV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a7bbe9d0so53370631cf.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776256346; x=1776861146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LJSfe5bA18PuRNQ4vEdjYdjvvytdLBpr7gkBDWoXT8=;
        b=Mi4AtZaVLM/U1/jBNCjFltSzRfJW5r3qrTNXd5hA5MzzKyIrwQqb1lNQAs0B2omgHI
         eGOkC56x71NhzgxjcPJYPecWmp8ixk4J1b8ZwAverv6mqJxjkjN46lIaQZXQgYo1XfGM
         seJKHGwxz/NJbtauHyizwlbWpeg11s2R8d5KJJ2+i+2EMzYMQUwSvYsCvGg/QS3Z5r7h
         L1ChcRsEvalSoju6L0uHGY/IooHCh9WJWMyICiHiBEVDpwCt6BENdE5y12L79yEsI67E
         XWM1xgTHYUERUM3lwWABbRFeEj0F5LFG+3/sfo4k56BXNgMNoWMaizUsk0O0XRQfFteR
         331A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776256346; x=1776861146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LJSfe5bA18PuRNQ4vEdjYdjvvytdLBpr7gkBDWoXT8=;
        b=ki0zDvKEFlAzx9qOyu6GdM2N7JI2nE6UZGM2j+dMV+x7gVgQHrmcMnVh3qmA6bjLPQ
         VCJz36R/L8x2KueBbtOEhbU8NNEFiHNKb5BNfnO4hy3Iivqh7loP6rQZiveI5bEkLuk2
         q412yYIub2KayghfLTXbL70N8Z9TkD1hs9IghhlFvEaJyFiF9BRKP9nQmi2RWvcKJJ7Q
         SgmCfy2RF0W1k0LeRcety5aqn0G5T/FNE4rz1iV6SwdZztzdfOKUtEZQy/1rlUQ5WYA3
         Md5rCVYtFHeTK3zbcuxGD6o9srmvqomu/gyfySG6Ac0IuCrsyCBptso7uYmuaWP/OW8z
         D3xA==
X-Forwarded-Encrypted: i=1; AFNElJ9spPK/XguHUkTv4QQDY/1seIkvbqYaKc5vOWsE2mOB87G23Wz/JRVPvOvR2ZWwl+IKaNbb7fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcw5E0RkwJuQAwPbyjkdrj3zngnw0+JhZ4hsYD+E4abIC5gZ/w
	4wNtn+0oODkMU0uG7oGRWBikJyyAto28dOtiEVfQwbQGE2Fxz6azf+6H
X-Gm-Gg: AeBDiesT7/WNWPKj+8Raks9EviAF7tXqeCaMCV8tAzcgwdQPjUKo8MblNInzSQegpqy
	m6ZfxOBLSrDNiahOaPCS1k2OaQlXBMS0cZeBnKFkggMiveKa31QuIHwORqfGCUZ0O9I4QN1RfGJ
	Wp1Pcyu0Jks188bqvpKp0Rlaygnfsm/l27uLRtVG1cAPGkjzM0l0xaaQXlWkguFQ9+IKKCIU3Ei
	kp+9edi7P4LkGATrKf4qR/WI5XGXRdmYJrs5OaZ7obK3Fkv+kIgewRC9PYRstuae7w3IrsPTbAM
	q3A8cSfelOUDjQwdieI6w4MpGFVf8ef+jr8y8V1CtBIKjkVMoz8F16Hbzbd+yddPEmZXJnZAHhr
	0HYLnHiR4y0lF94pPh4i9KO43tTZOvb0mD4yXlqGE/TkPOnNe4N61wvFkTwGyYI532fvIM7pFY2
	lKGJuDEI+n09Wqkt+aicVnK9wvkcYKwtYpQCvEmHovDSzeg4jUl9ABBsRt9HG+WvgCOZ4BjPfpx
	qTxIUzFdXrzFTg1R1aXYkh1/5Q9inLa2TcGWBe6zJdZ1Ksecn9M4big/n3GCgJh
X-Received: by 2002:a05:622a:1b12:b0:50d:7f60:621f with SMTP id d75a77b69052e-50dd5b7b590mr309198651cf.29.1776256345909;
        Wed, 15 Apr 2026 05:32:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm11747771cf.16.2026.04.15.05.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 05:32:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-usb@vger.kernel.org,
	Mika Westerberg <westeri@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] thunderbolt: harden XDomain property parser
Date: Wed, 15 Apr 2026 08:32:16 -0400
Message-ID: <20260415123221.225149-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415032335.2826412-1-michael.bommarito@gmail.com>
References: <20260415032335.2826412-1-michael.bommarito@gmail.com> <20260415045246.GR3552@black.igk.intel.com>
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
	TAGGED_FROM(0.00)[bounces-238116-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 49ADA404463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three independent memory-safety defects in drivers/thunderbolt/property.c
are reachable when an untrusted Thunderbolt/USB4 XDomain peer responds
to a PROPERTIES_REQUEST during host-to-host discovery.  The peer
supplies up to TB_XDP_PROPERTIES_MAX_LENGTH (500) dwords of attacker-
controlled property block which the local host passes to
tb_property_parse_dir() as part of the control-plane exchange that
runs before any tunnels are set up.

Patches 1-3 are one bug per patch: u32 overflow in
tb_property_entry_valid(), size_t underflow on dir_len < 4 in
__tb_property_parse_dir(), and unbounded recursion in the same.
Patch 4 is three KUnit regression cases exercising all three.
Let me know if you want me to pair the KUnit cases with each
patch instead.

My assessment is that all three defects are OOB-read or DoS
at worst.  No controlled OOB write is reachable through the
parser; parse_dwdata()'s destination is a freshly kcalloc'd
buffer sized by entry->length.

As Mika noted, operators who do not need XDomain
host-to-host discovery can disable the path entirely with
thunderbolt.xdomain=0 on the kernel command line.

Reproduced on v7.0-rc7 + CONFIG_KASAN=y + CONFIG_USB4_KUNIT_TEST=y
via the KUnit suite in patch 4.  Pre-fix, each case oopses inside
__tb_property_parse_dir (KASAN shadow-memory fault for u32-wrap,
stack-guard trip for recursion, OOB read past block for dir_len
underflow).  Post-fix, all three pass without issue.

Changes since v1
----------------

v1 -> v2, addressing Mika's review (msgid
20260415045246.GR3552@black.igk.intel.com):

  - Split the single property.c hardening patch into three, one per
    bug, ordered smallest-diff-first (u32 wrap, then dir_len
    underflow, then recursion cap).  [Mika]
  - Removed the incorrect "PCIe tunnel authorization" framing from
    the commit messages and cover letter.  XDomain discovery runs
    before any tunnel is set up; the path is not PCIe-specific.
    [Mika]
  - Added an explicit operator mitigation note
    (thunderbolt.xdomain=0).  [Mika]
  - Trimmed the commit messages: dropped the per-file prior-fix
    enumeration (Kangjie Lu 2019 series, Alan Borzeszkowski 2025
    cleanup) and the lei / Patchwork / westeri-tree scoop-check
    provenance notes; that content is available via git log -p and
    does not belong in the commit message.  [Mika]
  - Dropped the long inline block comments above check_add_overflow(),
    the TB_PROPERTY_MAX_DEPTH check, the INIT_LIST_HEAD reorder, and
    the dir_len < 4 reject; the code is self-explanatory given the
    commit message.  [Mika]
  - Reworded the recursion DoS description away from "remote" (this
    is a peer-triggered DoS reachable from any adjacent XDomain peer
    over the Thunderbolt/USB4 bus, not network-reachable).
  - KUnit patch unchanged in content; commit message adjusted to say
    "sibling commits" rather than "parent commit" now that the series
    has multiple parent fixes.

Michael Bommarito (4):
  thunderbolt: property: reject u32 wrap in tb_property_entry_valid()
  thunderbolt: property: reject dir_len < 4 to prevent size_t underflow
  thunderbolt: property: cap recursion depth in
    __tb_property_parse_dir()
  thunderbolt: test: add KUnit regression tests for XDomain property
    parser

 drivers/thunderbolt/property.c |  32 ++++++---
 drivers/thunderbolt/test.c     | 127 +++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 9 deletions(-)

--
2.53.0



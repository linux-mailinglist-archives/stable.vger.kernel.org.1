Return-Path: <stable+bounces-247731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDsuKu8SB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:34:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287654FA76
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C136C3131B79
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844D47D95C;
	Fri, 15 May 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blEoZXIX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3747DF96
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847148; cv=none; b=aoKhpPghf96gmHGKvSMIyCWxN11D2gLQN0V1g78XLJir82+Q3ZE88O1Ks5vZGq0O5pj9eHU3aeJNO1jX/1D9AIGtVFwfD097gxMnIYXc8PLdDPHuNAFqF+4Zjv22IisTpRzVJBzcIh6s2aEAWb/bjl2wTCBIIW50rQ+PRVie6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847148; c=relaxed/simple;
	bh=uc5kYuZZA9RiIxZC9rriOznMCqyKaWn7EEznJQhHSjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meQf0doxDJuxCf+3lavhBooSZeEbV5r62ONVHNMP3u5eGp5R80x1+k+cbnO44fe8sxvKFq72wMayFiq0tKPuMFejuA0MrNTrOgHEvm+mirsDaxZwdNCmYWv7eOnhnnOfhkXvvikbj6Q9DzzH8gXzqxAo8LBc3RW3fC8t27sXJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blEoZXIX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50fb4a7d704so68929751cf.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847145; x=1779451945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PY0lSVyvkzmzc7fN9FKWi5wDFGTOHaJFrAdLdvHe3WY=;
        b=blEoZXIXaWenDIzkHYQwJtvR1sKbI8h4W33fTG9fHiE1L8zN/17ITG2k/alBpLSuF1
         uB1akGUQ2w8GcdbFpD1hFvVMDW5BBCKFmvQj2865KHfI6ETstK3RVvYNIN5MdwQXVhZG
         DSp4UtJ+nA8/gqDEM3mv1hCfKspQSEGx8tWQG1IKXlUE5enkLF6PU6BwmzPt9Bwh4uvR
         kfylEIDnIJRdZOcthtcv7iunfVrulOMtfPijO8eZnzX2tDpC+hBj/fCc21E+3eZPwyxi
         kH5sRB6G8I+myaTorhL+1alPNzJHoO8NnLd+MkhKT94MhfHSEaZIbX2XXtUxpz2SFm0q
         Jy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847145; x=1779451945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY0lSVyvkzmzc7fN9FKWi5wDFGTOHaJFrAdLdvHe3WY=;
        b=pM45G4U1LnGxvpq3OvKgi4DJAzkUleqnBr+kOEXVVgRMkxo8U3OuY2Wqm/nyoDjYe9
         qx5AvIEJA/sVGI0ZiU1qi4j0+gVXwhbU0Rznaykl4cZE9ILBCijW0Yx1kbKgiBN9iSQ9
         puzEatqeCrJYG7qUSzNmkZ+cRB8sS55z36yNHHaU0B0Fpar41i8yXbl18oMJelwame1y
         hHldYoOGK9+eCgOHBSRbz57DV0j5b9XS03teugbNmgrKpwnnDWi7q+HNGHg3SxdIVVRH
         2oiCRiyaH60n7YVQVTm13KTKilJ+MeEC14isU/DRoXKF3kqbDjzfGhspq1cGqE1Q4gha
         jIgw==
X-Forwarded-Encrypted: i=1; AFNElJ+4vb6Exd4k/p7qAkA/DFZ9mQNW1oqL0Czff4P+X9egE8vL3VkAHAi1NGDoihM8xArA441Vw7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVoMsYwUp2WdWtaBKEzLOG1RNQ7cOt8Pj4tDpr1y7l4S7tIye
	bql/3rx5m1aDVGsu5FmiWqKEoyuiMnvXruXygn9flasuUBnutezM3IvSsuaB/oQ4
X-Gm-Gg: Acq92OGbdbj04mZhnPTfDyYCtOuYA9X54LNtX+AwAskzAFSDAeKPQpYfQhNZUBLQDoz
	mC9RPqR7sNswurk4kKJfCe/dC2bRBEb4SM2Swr84Ndnnu+4tPTZh9xhvT5Cjto7qj2kLke8jTCg
	o04uMSoqcu/0/p2hOvtMre8vjG2+ZVYQr9ImX1nx1kFtAsuv6kwIRnFikwxLrj+1ugZlOleXYWO
	St7FuHWjp3pEEDZO7+B+eYhGss/BNOD880f7TWq7x2gXRHbIuzSVMctPii6KFNXtCHZzKpli4Y/
	bYZ/mTDCb4jyqgJszexraCiCCCtw2SSpKg2uoZr3Ngmq20S6Yuf8anT+MFHz21jvS6ocZbPiThc
	pBkM6kNCGB61IkrIIzY5C684JCzqMB18eKlYH5AZg4qUEoAlZ86jGP0mMhoWyuLcG9hR0xp1FwX
	9nNU+V6Y6YQWiptbmaVBjdslubT7TuxEpNlHTVFnj664Bw7U1eM1hyKUJfUSjqtYNFsC+WJ1zzV
	JkP6zwO6qZoQiE/eUcgpXqV0bXXOoTTw9ueXZiQwB6T93KjudO8Yw==
X-Received: by 2002:a05:622a:4108:b0:50e:5cc3:6f42 with SMTP id d75a77b69052e-5165a27a8acmr46595211cf.59.1778847144385;
        Fri, 15 May 2026 05:12:24 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45534491cf.3.2026.05.15.05.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:12:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/4] wifi: iwlwifi: harden netdetect resume-path parsing against firmware-controlled inputs (mvm + mld)
Date: Fri, 15 May 2026 08:10:56 -0400
Message-ID: <20260515121100.649334-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6287654FA76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247731-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Four defensive bound-check additions on the WoWLAN net-detect
resume path in iwlwifi, validating firmware-controlled response
lengths and bitmap-bit positions at the host/firmware trust
boundary. Two patches each in the mvm and mld op-modes; both
op-modes are live in current kernels (mvm drives 7000-series
through pre-BE200 hardware; mld drives Wi-Fi 7 / BE200+ when
CONFIG_IWLMLD is enabled).

The series is in the same shape as the recently fixed sibling
commit 744fabc338e8 ("wifi: iwlwifi: mvm: fix potential
out-of-bounds read in iwl_mvm_nd_match_info_handler()"), which
landed in stable on 2026-04-11. Well-behaved firmware should not
trigger any of these, but the host parser should not depend on
that.

Patches 1 + 3: length-tail guard on the firmware response.
iwl_mvm_netdetect_query_results() and
iwl_mld_netdetect_match_info_handler() validate only the fixed
header size of the response/notification, then memcpy the flex-
array tail unconditionally. A response of exactly query_len /
sizeof(*notif) bytes passes the guard and the memcpy reads
matches_len / NETDETECT_QUERY_BUF_LEN bytes of adjacent slab
content. KASAN reports the slab-out-of-bounds READ "0 bytes to
the right of the allocated 24-byte region" in the kmalloc-32
cache. Same fix shape as the sibling.

Patches 2 + 4: clamp the channel-iteration upper bound against
the netdetect channels-table length. iwl_mvm_query_set_freqs()
and iwl_mld_set_netdetect_info() iterate the per-match
matching_channels[] bitmap and index a channels[] pointer table
by bit position, without bounding the bit positions against
the table length. The pre-existing caller-side guards compare
popcount to table length, not bit position to table length. The
mvm path iterates over the full 0..55 bit range; the mld path
is accidentally bounded to 0..6 by a bits-vs-bytes confusion
(for_each_set_bit() takes bits, but the call passes sizeof(...)
which is 7 bytes). Both can index past the channels[] allocation
when the user's net-detect configuration has fewer channels than
the relevant bound. The wild-pointer dereference of
channels[j]->center_freq inside the resume work-queue then page-
faults the kernel; a KUnit harness exercising the mvm shape
panics with

  Kernel panic - not syncing: Segfault with no mm

and the mld shape panics identically when n_channels < 7. The
mld fix folds the bits-vs-bytes correction together with the
clamp because applying only the bits-correction without the
clamp would widen the OOB exposure from j < 7 to j < 56.

All four bugs require the firmware to produce inputs outside the
implied driver contract: a short response (patches 1, 3), or
matching_channels[] bits set at positions outside the channels-
table bound (patches 2, 4). Well-behaved firmware should not do
either. The patches add defensive validation at a trust boundary;
they are not a claim that current Intel firmware misbehaves.

Reproducer: self-contained KUnit suite that lifts all four buggy
code paths into standalone harnesses (no firmware or hardware
dependency, ~10s on UML). Patched-shape subtests pass cleanly
under the proposed fixes (test_patched_rejects_short,
test_patched_accepts_full, test_set_freqs_patched_clamps,
test_mld_match_info_patched_rejects_short,
test_mld_set_freqs_patched_clamps).

All four patches build clean under x86_64 allmodconfig with no
new warnings; checkpatch --strict reports 0/0/0 on each.

Michael Bommarito (4):
  wifi: iwlwifi: mvm: include matches_len in scan-offload-query length
    check
  wifi: iwlwifi: mvm: clamp set_freqs iteration to n_nd_channels
  wifi: iwlwifi: mld: include matches tail in match-info length check
  wifi: iwlwifi: mld: clamp netdetect channel iteration to n_channels

 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 20 +++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 10 +++++++---
 2 files changed, 22 insertions(+), 8 deletions(-)

--
2.53.0



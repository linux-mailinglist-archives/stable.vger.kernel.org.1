Return-Path: <stable+bounces-219139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJMnBphknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E25C1910B6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3FA304CE9D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F629992A;
	Wed, 25 Feb 2026 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZpZGEvMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39A22B5AD
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988105; cv=none; b=bsFefANmHyrU9WNcVqiMMCPwxGyhY4OTPd58o0giA1Ipspfou/slwlVDtKqHaCKinlmqgwrjMtvcgPS9EiZLbl9wJFlJPHXSbTojeKbDB4ILtdNpqfm2jlZShtOF9GOWqJqVDTxdqMZ+iweCEMhJtHEVLw2gjbYrGZ8m9AyJ2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988105; c=relaxed/simple;
	bh=PLcq2XfGK8enrQXuhWQFRZKlWB3Le6L7ftaCYdrFU7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UiqnZcqE5J/2haE0u8oaHPg43GAOB5hYUO+dtzn+L2kop2bW5gT5rw2X/75x7tAY6zMLOKfOGtbbATdW9lnfz873tOuAxMo5ovu/yjFVfGsqPTInqBEXgnM2grB8wsJoQt5t3Q1+zwJ908XYXOxPR6+lAZNSEGdf2rsDjN8cqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZpZGEvMk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso46595125e9.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988102; x=1772592902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuAA4LL0UTtbYiDJhfwXYWHeF9YJmDkn9xDPdMSh39A=;
        b=ZpZGEvMkU6M2tRHbVWUKao2KoZ/CfFTG6LXorSjEUi5qlyj1yoSX41Ap9UBO1f8x6o
         2ohAW7+ayYQZcfHF2lgQk9Ld7vbCaVK/HzsDjZeIDAwsE4B8oYu7LR6CwAIDwH7MdFqE
         ZMmNpRh8DKTsu/Q8/ExZ/O3wqRl6Snyh6yQQvZhu/nny5qrbvyeSK567RrV07Q2red4i
         XFV9fNDVvVrxmx/AJXMBhdEtHsgfba1gwlMI6Oqrn6QlQvlTs4LpnC4OlEGg4x0G7HhI
         qqDOp69v8CB/zwvSfLuPWL0UXluzlFDK+1TwwpgcqU3uUkGz5CWD8V3ezPbS7i3qhFA/
         6GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988102; x=1772592902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuAA4LL0UTtbYiDJhfwXYWHeF9YJmDkn9xDPdMSh39A=;
        b=ena52EZ4dcDXrlnUK8SyVpBN8zeHLzhIjitqskE9LndZS5pXZdt0VRNzGUonxDVs4i
         rt++RLLDqY+0q1N2/+nhtFIHc4f/Y+lpA7oN/l8R2wzcgb8EtwMc28NfREBALCKGiGvf
         zS1nBZCcqJqwhDOSnF5etAHDycWCletOc/W9itRo3zXG7rDoWpPBJrctrgHYOIRjazlF
         Rr7CQZfllQW3lOp9vO7poQJRDx7BSJhxWPG/KwcRIcHW0toiFf8hs05TXhdkzxYFR79I
         Fo6NKeBwhVWIS2LV8iN1O+vZjT2A6lJZP3qYhtYu6wPA9NjMLZXViQobR+D/VpFqU4kU
         7kng==
X-Gm-Message-State: AOJu0YxTCwqwHuTSRqImPMOZwLflFF8zu3gnXVWxer8BVfD4uHKIbKmj
	FvTG//2NRD+fMtTmh+1UIvFMq68LThcqKOtvHF6Zb/7craT9AgyZsDSYYQcsgGpmoaeqKNzDriy
	TxYTw
X-Gm-Gg: ATEYQzwkud+m+B9WhIDI+N1MURySWBXZfbhmyFthvIW1iAPArTrCwtcEhZ54wa2SNH0
	gS/4XBP++zN9GEWWDjXWIYI6vfen7AEewandQFuGz3YdlppcREIKySbbqSOFEdqUZty0lt1CD2H
	ObzS1qSVQdBNqW5CqFd5l690I6Pl5gxBpxXs2Hj3SqJvBdHbFrAJgynXbojm7nDVWtLeK0Eivjp
	DBGQpMggE9mdgMxUfAm6eKRDMU4bNSZ4pA2XT7hppIq+E0sngdOCtlJ0vpwjmrZRhh32bCX11sR
	a1TkkvDkEKlG6QNl36YPmIWMCHH/xcR2SCRttoEXQU07bVStJ67nJfkSOuw/SSpwUZJRU9J7dBa
	aYt/X+EWjRvk7aK4sj/+QuEyR03Y5D4ui4nLqFAgNgufPqivxn3BZOQmX9I2ewh+Qd51vhrHlDK
	UB9j9Li39T8073518cs/iS6q52Ng==
X-Received: by 2002:a05:600c:c4a5:b0:483:7783:5382 with SMTP id 5b1f17b1804b1-483a95e6b64mr217224605e9.27.1771988102287;
        Tue, 24 Feb 2026 18:55:02 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75027b0asm126568115ad.67.2026.02.24.18.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:01 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 00/11] Backport selftest for "bpf: Check skb->transport_header is set in bpf_skb_check_mtu"
Date: Wed, 25 Feb 2026 10:54:38 +0800
Message-ID: <20260225025454.17398-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219139-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 6E25C1910B6
X-Rspamd-Action: no action

This patchset backport the corresponding BPF selftests for commit
d946f3c98328 ("bpf: Check skb->transport_header is set in
bpf_skb_check_mtu"), which has already been included since 6.12.63.

The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
additionally depends on network namespace support for BPF selftests
added by Bastien, otherwise the MTU in root networking namespace will be
set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
Marlière for figuring out the dependency. Details below.

The follow commits are backported:
 1. f52403b6bfea "selftests/bpf: Add traffic monitor functions."
 2. f5281aacec85 "selftests/bpf: Add the traffic monitor option to test_progs."
 3. 1e115a58be0f "selftests/bpf: netns_new() and netns_free() helpers."
 4. 52a5b8a30fa8 "selftests/bpf: Monitor traffic for tc_redirect."
 5. b407b52b1850 "selftests/bpf: Monitor traffic for sockmap_listen."
 6. 69354085975a "selftests/bpf: Monitor traffic for select_reuseport."
 7. 5772c3458bb8 "selftests/bpf: use simply-expanded variables for libpcap flags"
 8. 4a06c5251ae3 "selftests/bpf: ns_current_pid_tgid: Rename the test function"
 9. c047e0e0e435 "selftests/bpf: Optionally open a dedicated namespace to run test in it"
10. 207cd7578ad1 "selftests/bpf: tc_links/tc_opts: Unserialize tests"
11. 6cc73f35406c "selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set"

Patch 1-6 adds the infrastructure required for creating network
namespace when running BPF selftests. Patch 7 is a follow-up fix for
patch 1. Patch 8-10 adds network namespace support for BPF selftests.
Patch 11 is the BPF selftests for commit d946f3c98328 ("bpf: Check
skb->transport_header is set in bpf_skb_check_mtu").

Bastien Curutchet (eBPF Foundation) (3):
  selftests/bpf: ns_current_pid_tgid: Rename the test function
  selftests/bpf: Optionally open a dedicated namespace to run test in it
  selftests/bpf: tc_links/tc_opts: Unserialize tests

Eduard Zingerman (1):
  selftests/bpf: use simply-expanded variables for libpcap flags

Kui-Feng Lee (6):
  selftests/bpf: Add traffic monitor functions.
  selftests/bpf: Add the traffic monitor option to test_progs.
  selftests/bpf: netns_new() and netns_free() helpers.
  selftests/bpf: Monitor traffic for tc_redirect.
  selftests/bpf: Monitor traffic for sockmap_listen.
  selftests/bpf: Monitor traffic for select_reuseport.

Martin KaFai Lau (1):
  selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when
    transport_header is not set

 tools/testing/selftests/bpf/Makefile          |   5 +
 tools/testing/selftests/bpf/network_helpers.c | 500 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  21 +
 .../selftests/bpf/prog_tests/check_mtu.c      |  23 +-
 .../bpf/prog_tests/ns_current_pid_tgid.c      |   2 +-
 .../bpf/prog_tests/select_reuseport.c         |  37 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   8 +
 .../selftests/bpf/prog_tests/tc_links.c       |  28 +-
 .../selftests/bpf/prog_tests/tc_opts.c        |  40 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    |  29 +-
 .../selftests/bpf/progs/test_check_mtu.c      |  12 +
 tools/testing/selftests/bpf/test_progs.c      | 192 ++++++-
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 13 files changed, 809 insertions(+), 94 deletions(-)

-- 
2.53.0



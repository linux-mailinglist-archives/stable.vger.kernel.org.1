Return-Path: <stable+bounces-217873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON6HFlFWnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9B4183290
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB057303F7E2
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1FF29AB05;
	Tue, 24 Feb 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EmEMcbkg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DD284894
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918700; cv=none; b=CSsKbjxMvQENWB8q2d2ziaU9UKksSDzCyePg4aBzw+PZl92fr6GA3ikvfpIRo7c+0y/gHVbsqZdGWeqwDyy/wZGxlTBGQ3kRJTAFV8O0M5bAsqg5NXPxXwCExwwn7O28sGbe6wZhAb9/BynnxSDmX+VxH0rDJA8snRb0vugxqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918700; c=relaxed/simple;
	bh=c80BZUeOrvNCau5Gjzy01IEJXZFG8jdjRWidDaFbY+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5kHK/TZ29w308NEipXFRtgnik8UXSI8OxQyzVf6omAz1qlSRYakA57zcAf8lLIjsUiGDd3SjZhaGbYIPJhvneW6m3+svGreUGEW5sMMfILDJWjPd/IYBMxBIO2IEbRfPgwsnnXFy4ifyN2Q7a3wjU6H7zoP32at0L4jIMdmnQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EmEMcbkg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439857ec679so283608f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771918697; x=1772523497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWSiAHzaz855dMNym3e1+X7kVBjSKnhaUs37zNVRoiE=;
        b=EmEMcbkgVls3X8NvcKZGNYAA3H229h5XOBADu5pDhjeQls47YzxmmYwwmD5qVNZpux
         Y/W+xiithz+yXazVTuN52FkiO9TvihEGQoVCuyRRvxqcPU/Sj5qb+Qc73qPZgnNbXR3d
         utZKRRgHOCY/dW6AWtH2m67rHIGA0q/+qbT/MVN4vPz3WK2tHF+0RZruwkvVLGYI+jok
         5wYoileNxX2Hd1pWS5XhvijP45bSbf96FLkb7dlolbVTr8KB7/9VlQB8h0GgWcW4HAyM
         Y8XewXctEzN/4h2OAyeMm0ql30ZMFjmjr8RRiAXVWdVHv2KnL1YRvfcvsWsQCcziN90X
         BLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918697; x=1772523497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWSiAHzaz855dMNym3e1+X7kVBjSKnhaUs37zNVRoiE=;
        b=rlnC/uB05FW69qSjvq8h7W5+egYiRIeWWiFAyfz1BMULYfPMLmj+d0OGSwI0e2AfRw
         pnpaIsb9Yk6xP55ibsC3u2A0161tm8LIDl0L80ApfHGVfLfaPkDtFS154JuPx2HaIEln
         6QAYVtEFuWXfwfZlKEYnrq+X6Web4xsMGEm24RM3wAC3Sm+DZIRT6fBStjEWkJ1TywJe
         bnJs4Oro3QVjUy4O1Wa76Wsc+xrejDp+cRr+HQhP19CzLk+RyZXlg3BOeWkgMeQK2meH
         wf+OOKQRoVURf3BEMl0HFTw1WRu6mYbY1cGqgaCu6rVhayNo+VIeqE/wKZTPYJw3n/OE
         LyCw==
X-Gm-Message-State: AOJu0YzTY5UM1o6dvViDkfOdjITLUd0gY3fGgs9bpt3MpQt1op6IVViK
	ZGifWk48uwFPtYsSlJXum5RJEji+AbRkBgEQ8z1r5RG4q83ibJQ6vFKxRsBqqVaTzAfbb09OjIi
	t0ySt
X-Gm-Gg: AZuq6aJeXmAIrcqQNZr4wnYHOZUJ4N2nviQNypPmSK4MdtNhK5zZubAeqBFAHRiwYiB
	tWtuo4c9AtOdI572YSNBDqgCXj5E3POw7K/6ZYq8X4RqotCMJXiS1PRTzyV5PUatxU+9AsTp/O4
	KzO9m/w+ynD6SjDxmGz2bHXWi9yAfofttURebMZBoFEwjDNvDYiDAcAkPxp5beAoMq2EoouEWEj
	Cl0xRkSGwPoSlz0DwC0XUfw9oLlnT3woN93FPm5mBCyAk8HqUeO6YgES++xNIZitmkRfweAHZxl
	c7n4ZS7gpHA0rOirMX2ufsf5OTkPtY85Zjq5gqSy1reTSU0IMwGEgCFZN//xFWvQlg/bGS9eA0B
	HiK7PDFKfSx3iJZxnQS5evlO590KCgXaqv7yYoG9N1OvqNF7Au5hiBsaWiMvTzn1vuBMYGIDLM3
	9TPxSIOU2hx4mMRHe+7CKPvkJRKQ==
X-Received: by 2002:a05:600c:a00b:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-483a9635bf6mr177209455e9.27.1771918697324;
        Mon, 23 Feb 2026 23:38:17 -0800 (PST)
Received: from localhost ([2401:e180:8d81:8882:61cd:2a32:531e:d806])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af701c7bsm9070622a91.1.2026.02.23.23.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 23:38:16 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 0/5] Backport selftest for "bpf: Check skb->transport_header is set in bpf_skb_check_mtu"
Date: Tue, 24 Feb 2026 15:38:01 +0800
Message-ID: <20260224073810.85945-1-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217873-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE9B4183290
X-Rspamd-Action: no action

This patchset backport the corresponding BPF selftests for commit
d946f3c98328 ("bpf: Check skb->transport_header is set in
bpf_skb_check_mtu"), which has already been included since 6.12.63.

The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
additionally depends on network namespace support for BPF selftests
added by Bastien, otherwise the MTU in root networking namespace will be
set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
Marlière for figuring out the dependency.

Bastien Curutchet (eBPF Foundation) (4):
  selftests/bpf: ns_current_pid_tgid: Rename the test function
  selftests/bpf: Optionally open a dedicated namespace to run test in it
  selftests/bpf: tc_links/tc_opts: Unserialize tests
  selftests/bpf: ns_current_pid_tgid: Use test_progs's ns_ feature

Martin KaFai Lau (1):
  selftests/bpf: Test bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when
    transport_header is not set

 .../selftests/bpf/prog_tests/check_mtu.c      | 23 ++++++++-
 .../bpf/prog_tests/ns_current_pid_tgid.c      | 49 +++++++------------
 .../selftests/bpf/prog_tests/tc_links.c       | 28 +++++------
 .../selftests/bpf/prog_tests/tc_opts.c        | 40 +++++++--------
 .../selftests/bpf/progs/test_check_mtu.c      | 12 +++++
 tools/testing/selftests/bpf/test_progs.c      | 12 +++++
 6 files changed, 98 insertions(+), 66 deletions(-)

-- 
2.53.0



Return-Path: <stable+bounces-210684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2G4PMZ9YcGlvXQAAu9opvQ
	(envelope-from <stable+bounces-210684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:39:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D0511C9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C47434E0B51
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7B3A0B20;
	Wed, 21 Jan 2026 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CycryOc4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FF35BDC9
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970393; cv=none; b=TdLJZZlvEzXwAQNygzi/y1pldVrR/3eeskdAeNe8JtwHoYlULUVeBqLwhy7chgS89PSmpBQO6VviU8hyXfUILYMcxgoBII1JrXlSlqrCCECfAcYjL1lmzU/ZPHHSLXRAQxWCS/aiV0Sn6YRBPuHHYxgukoKTyvZAeKj+9Cate9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970393; c=relaxed/simple;
	bh=4BEG5W/oLQV4P3kxNOuYuzdXOELqCIXgtQaTI+MU+9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjLATT8PcOccNVkeoB1NHveFQqZMM4yEfaRxbU8ZeECaOqWzTQm1tBSitQ358Waoe/UijRY1cKknK6dfbzJW19shGyaUHVHENYtq9Pof2oh5c4y+NI7FXia/5tIwP1ePz9uNAPsi/KeZjAWkUqdMxlJ/WW+YGJiE4zPWHNdeFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CycryOc4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so35752205e9.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 20:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768970388; x=1769575188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xZCzl/JmuvHLMvKR/eoJ1U6DGED8kB+/3A0CYf/f6k=;
        b=CycryOc4Eni48223HFf1hAyBWOCz6QbdDh/+NEOonhY2zVdDREKlcPXSLOta245ulJ
         MwDw2JRy2RyPmiyMqbQZe03rMbCvLEDrXnl8NMAuSN01E3W8SCKMLHAxP9XYqawdTuX6
         L5qj+842dBzZlJB3oHfBm0hS/mMmYXvSArPY60QH/hZQnZwHy6HMHPuFiBWcnErXrlIG
         HxrhpW710V7VGWEG/asq4KSPU2DevPBGoqcjMTqjc9xER6jHKSqOxhdh5hGH19MBuOsX
         xisZ1L3EsE+yQ8og4M/ay4ZQr0yQt4p2tVe0VkAj/aTfhQiCY7XyF6BRnRkKShALwXiP
         39UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970388; x=1769575188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xZCzl/JmuvHLMvKR/eoJ1U6DGED8kB+/3A0CYf/f6k=;
        b=UjtQiqA6a/RSwDjk+HNuNG6EMLPMDtdiB0BuxCvpBqRxsuWrwLWXqYgh6GUfq61rxv
         UOLg1EuB5SXVgGNM3K6VyJgQcbtNvNgTnyM+ufaShEqCNkH50C08zm5kdDtUxi/rrs7G
         KohqSexJQBWBl4yZN02XTlnPGGp1DSGmhd0kgNEwQCejX0WAT4MDRDUPXvce+qyNdPm2
         GCXV4ukrU9XiT6uOW9AqFqg8ZJLelB8jz5oRa91sdSkbm1BHBroqLT2nKNK8RVDQIOsC
         TFzBqyEhO8W9K7383m71RJ3mM0gwxVRwtqjMX1k+tBjWDeBRu2C1d3VQgPys3tf20GEs
         Yokg==
X-Gm-Message-State: AOJu0Yw4i0HKQpc5sCxg0gG5B08SMsyIzlmWeFjb2nUmnpDN6ZlOYTPh
	e5v2isqLkImNoi3gbUKIwFKFQIfN42s2ZUW7zGxJ3jT2/B96VYu+JT2W8O5xwJl1GEKAmHsgrzS
	WD0zi
X-Gm-Gg: AZuq6aISS396F3mV9W/gdd5cO++bdNBMpQ+ZPmGq+MnSGb3wDBJbYj2ns6hRAcILOKf
	vz7GiIz4NcpXbRlCB++Aw9jqn5pypjQrar6rtAHHj4rjE0OdeqqS21i4tYUlcPsSV4kJlAjQMOC
	v/nYhbkWJl6l+7Lj6RTB6ky0pU4ewuA7uyURwjB2i+09XQcdAYk0B1r0oeAZXb2xdT4fCUdba0A
	xzpKo04EyD8lDfWCYB+t7jOw5XoQp6D7afMjUiv8iwfRpaYaOnKazjnYBaLA16oaYIOXmDM+ASq
	rVz2tg8TH1eqofhCRCMpkyeOZJDKobnHXTM4L+wUQ87mrDRT1v7VrF60zirO/EMnaxJT5fEATis
	E2oxwNS+eKEk+Ry6A+/tPlBQpTqhMhd2JzmiUzdn4gW7gSkUu7oCOkslBeJCYs9CTWfIgNFnnT/
	FbmU+v4UPsFIVlDw==
X-Received: by 2002:a05:600c:6388:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-4803e713cc2mr57635195e9.0.1768970388092;
        Tue, 20 Jan 2026 20:39:48 -0800 (PST)
Received: from localhost ([2401:e180:8d80:2a2e:c146:9b66:e2fa:21e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bdc65sm13671465b3a.21.2026.01.20.20.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:39:47 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 6.6 0/2] bpf: Reject narrower access to pointer ctx fields
Date: Wed, 21 Jan 2026 12:39:14 +0800
Message-ID: <20260121043939.22629-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210684-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3D9D0511C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series backports two commits from v6.17:
- e09299225d5b ("bpf: Reject narrower access to pointer
 ctx fields") to fix the narrow access problem
- ba578b87fe2b ("selftests/bpf: Test invalid narrower ctx load") for the
  correspond BPF selftest

BPF selftests are verified to pass with the commits applied on top of
both 6.12[1] and 6.6[2].

1: https://github.com/shunghsiyu/libbpf/actions/runs/21196504628/job/60973453546
2: https://github.com/shunghsiyu/libbpf/actions/runs/21196504628/job/60973453533

Paul Chaignon (2):
  bpf: Reject narrower access to pointer ctx fields
  selftests/bpf: Test invalid narrower ctx load

 kernel/bpf/cgroup.c                           |  8 +++---
 net/core/filter.c                             | 20 +++++++--------
 .../selftests/bpf/progs/verifier_ctx.c        | 25 +++++++++++++++++++
 3 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.52.0



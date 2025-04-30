Return-Path: <stable+bounces-139107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EAAA4513
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54DC7B1262
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2DC20E33D;
	Wed, 30 Apr 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EhJ8JusI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216C7FBA2
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001205; cv=none; b=buT6xRCApz1aU8br4mQbkvT5Ww0VRnJWfHzXPOfc77jCEmFslQf++2v101144kHOSC5VgantwI8CBJkpUxfKdOgrYiix7UP6W/wKje4D+oJQx/xuK0Wq/tFPnC3qXLCs8FSCDWcLcI+gKzYxjKIM+fliKkvbzCGqSypQ8aW+jwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001205; c=relaxed/simple;
	bh=x5cex8OEhKjynPCXybXhspUm000CJy50QYYqrkodzfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMrO+OTCIUN2Iec4tDn1RuExkJAWFAulIiEBlDdwYgQtg1ajIxrluoLdsK5brHR+0LpWK3pUWg7FzBwLZ36d500MMyBQ5ZXrhpjt59OCh0bwBs7/Y8WGDoXEIGNRW6KdiIeixc8yXMv9I2QzTxiIouk25+Ge4wz6or3C5lEc2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EhJ8JusI; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-abec8b750ebso1132558266b.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001200; x=1746606000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HVgxhxknoibgANF/QIRf+Z1vpPV1k+p5YFrJ6jcJK4=;
        b=EhJ8JusIu6/t05x2WYouRj7GT381LzF9eoPiMwgGIuUbhn1RtYYPPfGqI2D2B+zidY
         r0wmpJGwBBi/amYSOGmsTa0e7SJNL7pJMUp5LrfKnkGR9JMeC/FAx8BhM/bcLWYo/ksW
         AeVvXDD7QyxciTsviXKm5iLgu1jtAL4izrADZiU9mvdZmGs5X6s/fk5o+YAF16gvQc4G
         5mjobCNeA1uex9UzL1PxrddubtCCh58kK4+ShtYDlJj8iiQGdzz5/TYgXZnhDCUc7EuA
         TvLZV/dfZVmX8jBAS7A36YGK8AywUwWysfmM2TPsJdHczW3g76DA94ZZfuTW6HnuiO83
         09PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001200; x=1746606000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HVgxhxknoibgANF/QIRf+Z1vpPV1k+p5YFrJ6jcJK4=;
        b=HHeMCLcVgOlbcyuzVfo1lmFkDQhvVCW0o82SZqObryKt9uKFteA3IZvresZl5o5eo1
         wTzyMcFpxz2xujqiiouauYy+eMofMsAzoikFiLhYW1PgFRgjOZXXtwW364Ppxa8LDpZc
         keRaDZ2oHPo9P1IrAKlW1yAYrmlnDzeZ27JeKY32IcRiHdfDMd+2gNNA0a82I8AhtIKi
         lmlcvBUFR4g2rvhm8LcqzGNfvYfPDzQW2gpOmt9n7mDUmwWkX67R8+EAW7Sidmgf80Ip
         YnBd4EMTPjH8aJd5m78c7ns5biNkAn3NBqn2hYKahunUU12NOzeQqudxynLBeZ9THYbW
         JcXw==
X-Gm-Message-State: AOJu0Yx01TzY2yg+kPRn+YpAdV970Qt+G/t30BZNviItmthT/sF2Ecis
	aNKh+zfIbTDlt6VjzLRO1DFJQzX5JoGmvG6h8vs21q2HdZgQ6gu7iHC+K8SQo7Obwl5RVbBH0P8
	eaBr0OQ==
X-Gm-Gg: ASbGncvW0ldvRpUfLzTgaQH5cvtcWiLsRm2XeMrNQqShzXHVhyf8IQXec7aUxFYPfBl
	8wYtB6Mhw94HwQ0q7Tmy1bI6/SuwQQpxNHgDg9906IZOwreFq8bMARtnyVmfBu4UxqCXNmRkUpD
	WAAmpzHOFc/U7D1e3qKNblalmLV/8LCVGVruBedwzz6F5ZKZOROvVR2jThNiCksoJoNP21BcNbd
	bWK0rwZOP8LcIoLqpUeBKZaBStTCussgKG+lN7/7HeavpdwE5cDoFHuyH+axAtw/GzMjDFyTOlC
	8AMjEilQjZE0r/Odh4kG/RdlubuvI5JmL9G5nofW8Uw=
X-Google-Smtp-Source: AGHT+IGtNZT5EOiWsVa2kp6pCXjHjf35FIPpaYrmKVB0OONNV9X72PXvE3BsrSmtTJwx86eHJzToyQ==
X-Received: by 2002:a17:907:7b9f:b0:ace:3732:8a86 with SMTP id a640c23a62f3a-acedc6f0955mr234238066b.41.1746001200617;
        Wed, 30 Apr 2025 01:20:00 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b15fadea8d8sm10193730a12.64.2025.04.30.01.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:00 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 00/10] bpf: track changes_pkt_data property for global functions
Date: Wed, 30 Apr 2025 16:19:42 +0800
Message-ID: <20250430081955.49927-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the bypassing of invalid packet pointer check in 6.6 by backporting
the entire "bpf: track changes_pkt_data property for global functions"
series[1], along with the follow up, "bpf: fix NPE when computing
changes_pkt_data of program w/o subprograms" series[2]; both from
Eduard.

I had ran the BPF selftests after backporting, confirmed that newly
added BPF selftests passes, and that no new failure observed in BPF
selftests (dummy_st_ops, ns_current_pid_tgid, test_bpf_ma, and
test_bpffs are failing even without this patchset applied). See [3] for
the full log.

  #50/1    changes_pkt_data_freplace/changes_pkt_data_with_changes_pkt_data:OK
  #50/2    changes_pkt_data_freplace/changes_pkt_data_with_does_not_change_pkt_data:OK
  #50/3    changes_pkt_data_freplace/does_not_change_pkt_data_with_changes_pkt_data:OK
  #50/4    changes_pkt_data_freplace/does_not_change_pkt_data_with_does_not_change_pkt_data:OK
  #50/5    changes_pkt_data_freplace/main_changes_with_changes_pkt_data:OK
  #50/6    changes_pkt_data_freplace/main_changes_with_does_not_change_pkt_data:OK
  #50/7    changes_pkt_data_freplace/main_does_not_change_with_changes_pkt_data:OK
  #50/8    changes_pkt_data_freplace/main_does_not_change_with_does_not_change_pkt_data:OK
  #395/57  verifier_sock/invalidate_pkt_pointers_from_global_func:OK
  #395/58  verifier_sock/invalidate_pkt_pointers_by_tail_call:OK

1: https://lore.kernel.org/all/20241210041100.1898468-1-eddyz87@gmail.com/
2: https://lore.kernel.org/all/20241212070711.427443-1-eddyz87@gmail.com/
3: https://github.com/shunghsiyu/libbpf/actions/runs/14747347842/job/41397104180

Eduard Zingerman (10):
  bpf: add find_containing_subprog() utility function
  bpf: refactor bpf_helper_changes_pkt_data to use helper number
  bpf: track changes_pkt_data property for global functions
  selftests/bpf: test for changing packet data from global functions
  bpf: check changes_pkt_data property for extension programs
  selftests/bpf: freplace tests for tracking of changes_packet_data
  bpf: consider that tail calls invalidate packet pointers
  selftests/bpf: validate that tail call invalidates packet pointers
  bpf: fix null dereference when computing changes_pkt_data of prog w/o
    subprogs
  selftests/bpf: extend changes_pkt_data with cases w/o subprograms

 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/filter.h                        |   2 +-
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/verifier.c                         |  81 +++++++++++--
 net/core/filter.c                             |  63 +++++------
 .../bpf/prog_tests/changes_pkt_data.c         | 107 ++++++++++++++++++
 .../selftests/bpf/progs/changes_pkt_data.c    |  39 +++++++
 .../bpf/progs/changes_pkt_data_freplace.c     |  18 +++
 .../selftests/bpf/progs/verifier_sock.c       |  56 +++++++++
 10 files changed, 324 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c

-- 
2.49.0



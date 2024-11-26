Return-Path: <stable+bounces-95496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B99D9255
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81AA7B232D4
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126951898FC;
	Tue, 26 Nov 2024 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KxNyoyT8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE94539A
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605713; cv=none; b=LHYTLVz1LhMCr8iDJkNIcAbDFr6AOt3mgjO8fZ0srI0+rJ6U+kbJsgzMDZvN4VK2ZD3BBNBtN78RGAyuXuMJZ1mb0bnA6jV0XQPmXABUVk3BgMAAUcomGotn1bVj+wEVG3QulJSdK9xww5Tf8tI8mNPwcnpzpNnI5OL6zE1fcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605713; c=relaxed/simple;
	bh=AvKLNw8jpR9rYd/kDfcgvtQYnov070BODrkzheIC/bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=af5Ax/Y24mDKXrGoOstII3GnRC0bSGhUsft/1F/P0h0oBL83oaCxtQBNngFvJNLXNLtDOZX4XlU7wXWxR44RIp9XI7JKROEsqWQyUYYdN2RryE/GXsourMFKcXdQvcx0DlvoPUyg74XpQKIC1bz6SW0xCWKhes42kf789fV1+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KxNyoyT8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da209492cso6671282e87.3
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605710; x=1733210510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KmM04WfnqeKK0N2itHHw42JcgfqZsgcXII/ZGWwumRw=;
        b=KxNyoyT8BbhQf55Y0w40ztqYdqvK++Tdv7Eu0pR+KquSLXIPaNkSarGYXKhRGY7SeQ
         2NRJk9KTpLOXAzjfv+T85ulyf9Wx/xrP59gy+c16eIajwfkpKjRlMP1SwuY4998zfyGH
         K6Vim3+k+7DgYpCTHNq+KiwmTk/cRm8GzNdoQ6XtPyxmKYdKLEiFuTs+4PiJmj7Idgoj
         VpHjUF9nNWtost7t1J/yovysNgyKRrRa0G2i2onNRW251EWzmSjzbvi00via/fpfS2/4
         r9CktF655IUt6GyM8hr/nufCKgmfeE47GVYfmTfcDT90fCmNp3+LbmOYmtcb9FDU3xl8
         gr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605710; x=1733210510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KmM04WfnqeKK0N2itHHw42JcgfqZsgcXII/ZGWwumRw=;
        b=uGAiXZBnUjexfQyVlhxZp3/RXmy8GRUnTsHwh682UGbRgGku/k5BVO4JXFoBsa3p3S
         INVdF9PdCQ2mCEcXZie0CKfTKKSXXV6xW738Q7q2/PtFsYViOThzlrd07k+gfQV4SKC/
         gzJAsBDpCSKr+7rzek7ZFJMIuAJLkjRdebEDVjttBw67l9M9EHMvD5+Rom8glGAfgjhU
         3gQcEpBiFs/EbnuB7kB2GqcqedZFFEJ8a9AsxDgjfqqcPUuetllh/LbeE4NKRO+FbMqy
         QGissDdi5yiIzOMex3KpFS1cLpW6Za/kb8ogUiFz+jVh1KbsqThc3ULInYQJ7TIWsgdD
         ryew==
X-Gm-Message-State: AOJu0YxUP6m8hV6pe6pl6HWxi7KavpaUd2OKFSTuOG+x9v/QOOus/kb3
	+HqbWkd1rTUQi/C6b1ZTG8zfw5JPbRXiyPpPFHGJ8VbSxYOICiLyLrgzXpZsPmwIZ8AyjbNB0qh
	2hX3FiLyN
X-Gm-Gg: ASbGncv5co7VbecTewciZoLFBMFUtVVd1jpipFoPb2Rp3o57zDBJs3+eGpFG+JvhbVu
	CKuKOfkVzAZJWUCj8EJ085Bmws93ywOtxObPkdHdLBdOzOhC7LpUf5r3r75Tbdv5ZM1aM67ZsLH
	lgigMuQnTugpx5F2yXNHwPyK0Lk1SpVR4gmGg8i4HXVsBDrAXD6VxidRoFxAdnHlTAteUxFQSk2
	L8nVDih413JFp61nQesaLT/bd6tcYsaX/Cn80n/11GjgIgzNrM=
X-Google-Smtp-Source: AGHT+IFUPM8E1zn4jekY4pwWf6xn7BL/jp4NVpGwQS6QsVJKNsh2kpdsGHC1bbXhq0a9eK4r4PbZ8g==
X-Received: by 2002:a05:6512:b81:b0:539:fc45:a292 with SMTP id 2adb3069b0e04-53dd39a4b25mr8292765e87.43.1732605709719;
        Mon, 25 Nov 2024 23:21:49 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de477e65sm7648317b3a.53.2024.11.25.23.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:21:49 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hou Tao <houtao1@huawei.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH stable 6.6 0/8] Fix BPF selftests compilation error
Date: Tue, 26 Nov 2024 15:21:22 +0800
Message-ID: <20241126072137.823699-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the BPF selftests in fails to compile (with
tools/testing/selftests/bpf/vmtest.sh) due to use of test helpers that
were not backported, namely:
- netlink_helpers.h
- __xlated()

The 1st patch in the series adds netlink_helpers.h, and the 8th patch in
the series adds the __xlated() helper. Patch 2-7 are pulled as context
for the __xlated() helper.

Cupertino Miranda (1):
  selftests/bpf: Support checks against a regular expression

Daniel Borkmann (1):
  selftests/bpf: Add netlink helper library

Eduard Zingerman (5):
  selftests/bpf: extract utility function for BPF disassembly
  selftests/bpf: print correct offset for pseudo calls in disasm_insn()
  selftests/bpf: no need to track next_match_pos in struct test_loader
  selftests/bpf: extract test_loader->expect_msgs as a data structure
  selftests/bpf: allow checking xlated programs in verifier_* tests

Hou Tao (1):
  selftests/bpf: Factor out get_xlated_program() helper

 tools/testing/selftests/bpf/Makefile          |  20 +-
 tools/testing/selftests/bpf/disasm_helpers.c  |  69 ++++
 tools/testing/selftests/bpf/disasm_helpers.h  |  12 +
 tools/testing/selftests/bpf/netlink_helpers.c | 358 ++++++++++++++++++
 tools/testing/selftests/bpf/netlink_helpers.h |  46 +++
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 118 +-----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  16 +-
 tools/testing/selftests/bpf/test_loader.c     | 235 +++++++++---
 tools/testing/selftests/bpf/test_progs.h      |   1 -
 tools/testing/selftests/bpf/test_verifier.c   |  47 +--
 tools/testing/selftests/bpf/testing_helpers.c |  43 +++
 tools/testing/selftests/bpf/testing_helpers.h |   6 +
 12 files changed, 759 insertions(+), 212 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h

-- 
2.47.0



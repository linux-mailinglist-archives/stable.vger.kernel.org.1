Return-Path: <stable+bounces-27415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C86878BFA
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 01:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33892823DE
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFBB64F;
	Tue, 12 Mar 2024 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJbMKc28"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037ED63A
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204292; cv=none; b=pxUZ5UJeY4CQzst+Cx5whEXcUpXwwUFu//X0V/CVu99mAN+cEdo030OzZjH2BgyA9IDp8sMqHL6SeYtExfaNb0JYbEBiTiIGfriukomv0o9Ggp+5B6qxcWEKTkuUAKFgCfgyN97Qr/CLyVm5Fv91WoH0p2e+4BnRuZRjcrKR6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204292; c=relaxed/simple;
	bh=NXE41EotV/guo7Mq3jidKA7lnb3rj6JD5yfoJbdST6o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=upzY6AlyNcbW8RRomJBQO92sQFoOhAvwCsyuaai461V9bzHy/sZ+jAKVPgHlQdVg+yWQRJ4i0MdBtU2kJ7g7M+M1gKuW8imm9S6QC/+j2p8hJFNfCzx6Vw735tnnG9/ZC+LDpuTLiFFVMlYCEKrqMsRezSPUTY5Mwjl/Rxkcx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJbMKc28; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609fb151752so81046467b3.2
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 17:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710204290; x=1710809090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ytk5awsqNWDngFImR5DjBj5lVmmQL/4tEhdgeOClN04=;
        b=PJbMKc28jIhfqr+Xrw1fNfp/meB1HUbHir4UF57sZfzpf6QGA5Gt8YMHwsXE2JoKLw
         OaqztpqkDYXe+n/qQWR9L1aKb1hRS+TdJBQYypFMYxTtJOu37wUrjFNApAfFvic+/Myc
         cqmSvWKloqXdjc4oHhAnhZclEpPEMtrzopyVvUKjvb/5ZDDQ/C80XiXLfLfduT7thEtl
         KzocstrCXBYliAMRr1J156XHBcKb6ci4RvKCiYV8JNDxD1rkto+CXeAPH12Z/g8FaUtf
         58Va6qc1nj8iWMESr43mQ1aM5ws5IBATI2Q/EIKzfkE4ID0O5RRin2lSUIIpNAqhZ9IE
         u6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710204290; x=1710809090;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ytk5awsqNWDngFImR5DjBj5lVmmQL/4tEhdgeOClN04=;
        b=CmM+zp1Io0U7mLFzeJPO6csK1g+vZSH4dHqOBuMQxWURpTB55VjxfT9YWsZk0kn60C
         2No4MDBfCYmRy39KqJWkJITh7nIFiHakCEILHUDnFhSFJs9WgcAjWws2b0g/gtCRzMTo
         jj5ISLdaMatRdfimIEc1Wr1h5flD3hf//W6V6Om4z2ANkSxvJSHl8dksEBt0rBwpdlDz
         9tUfyaP1RLUM8vdo/w8Dj6OmQeSspN5QTW/B2heZ8/1fD28tG3U/bM4YJZyunLGr5Osx
         LvGxKgHm2GSBdp7sxc8yitOUj12EUUh1jY7CueROChWQs7H1iD0osHa386SmRXa8pI7z
         dtCg==
X-Gm-Message-State: AOJu0Yx1h8krRd3RPUrvPmI2pziGsxM5LyA1PEDjO0VWn/myr0nZ5/qi
	xQj5rvs0VacWVaag+smIe+rxXCVcj4plqBBxnuc4MlwgJQFDOqP1I4JfA/1irIgtYCMBgppbKe1
	uvWWkRULlDdAl8/H4SSm9YoPk3tiEi31SmeP4pvPs+3ER9nWBOVHXjzjeMLV2r1xFJT/dErSnfy
	rpQdogMQzz0EJSNZlbKCo6KugK01GAeEvxgI6Em8kJF9xvH2ffq8PZSZ77fw==
X-Google-Smtp-Source: AGHT+IE2VQZuIQNaA23Zw0mWtEZtCDo1f2twaAn7thT0CJImZC4vy4YACZ42l/PEFhkxVDqoEcpNpldKndRLD+oIRA==
X-Received: from rkolchmeyer.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:7f04])
 (user=rkolchmeyer job=sendgmr) by 2002:a0d:d6c8:0:b0:60a:1544:85f3 with SMTP
 id y191-20020a0dd6c8000000b0060a154485f3mr2175029ywd.10.1710204289795; Mon,
 11 Mar 2024 17:44:49 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:44:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <cover.1710203361.git.rkolchmeyer@google.com>
Subject: [PATCH v5.10 0/2] v5.10 backports for CVE-2023-52447
From: Robert Kolchmeyer <rkolchmeyer@google.com>
To: stable@vger.kernel.org
Cc: Robert Kolchmeyer <rkolchmeyer@google.com>, Hou Tao <houtao1@huawei.com>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

This patch series includes backports for the changes that fix CVE-2023-52447.

The changes were applied cleanly from my 5.15 backport, viewable at
https://lore.kernel.org/stable/cover.1710187165.git.rkolchmeyer@google.com/T/#t.
The notes in that patch set largely apply here.

The only note I have for 5.10 is that the test cases with sleepable BPF
programs in commit 1624918be84a ("selftests/bpf: Add test cases for inner map")
do not seem to be compatible with the 5.10 kernel. But the situation with the
other test cases matches the observations I shared in the 5.15 patch set.

Thanks,
-Robert


Hou Tao (1):
  bpf: Defer the free of inner map when necessary

Paul E. McKenney (1):
  rcu-tasks: Provide rcu_trace_implies_rcu_gp()

 include/linux/bpf.h      |  7 ++++++-
 include/linux/rcupdate.h | 12 ++++++++++++
 kernel/bpf/map_in_map.c  | 11 ++++++++---
 kernel/bpf/syscall.c     | 26 ++++++++++++++++++++++++--
 kernel/rcu/tasks.h       |  2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog



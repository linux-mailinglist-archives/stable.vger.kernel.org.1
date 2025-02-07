Return-Path: <stable+bounces-114280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04670A2CA5F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BA8188BD0C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E06F19B5B4;
	Fri,  7 Feb 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhZI3FJN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0D619597F
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949832; cv=none; b=UJfPpbw0z1JbJfRKpsuhdsMGKxvF9uGhkG0kVn4z86w82odlOaCx/LhVhC+RPOXVXjpLOUcJzuqvj1CcYlIifsmL14zEmh4DiQwv+VwZfwR93GiVhoqWFGGfYe2tevzTXsCke3Z2L2bRH6C7Rpxj5BudlbMbYbVSmHnz45IOtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949832; c=relaxed/simple;
	bh=OdZ2j/mLxygcWAEKtWlEYhzC/i1upjUV9DGpzo8eQBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cachPHsPLiCZUgw7LuIf5fShHI/uBEZ2s43GRYsKWmD/A4Rjsz5O+socqJvsP3EWCcaGauoJrgwC3vMsLf6aK9Gv0SipFwdOvwUeYs3ONuo8+M6W36iRzaRYLijyOKeyDycPZAT1ygNsKpjK/fiRsyA/iRBZ3c3OTshQ/LxNt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhZI3FJN; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21670dce0a7so56568785ad.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949829; x=1739554629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=69aSYiYz4rC3MNvWkJB5R0ZDCNXj2mkqgwKLrb/OWfk=;
        b=EhZI3FJNKO+6VtfpMiR+bEHcS5e7oQQEy5gw9cLATbxM6Kgka5jxhpMnOrAJXUVGLF
         wf4Uk10HH3cwjz+EaQ9DQJvzkIXGGTxyv1721TKvSfTh6dZyb3cWJ+CIyyYoJzODf4nq
         WNGhTjH26pFYnenpGZDNBM2V86Vly7lBRn0duvVCjVkHHQ6qTkrXZF6YxVgpKbvTK22y
         0bwpDm13WEgOEfdv9g0L7ncEZ8qWklOxD1Pw+fl3hgZSulQxdJOK+maQaPkyEe9lGbia
         Jax+QVIm6tS/xwF3SfuooGfBmR/m2ZONuNU2FCW0jWKVTMkGgJdJ5w+VoT45X9F5OiWw
         g4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949829; x=1739554629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69aSYiYz4rC3MNvWkJB5R0ZDCNXj2mkqgwKLrb/OWfk=;
        b=CeN5wsTtHEdn9TXLDfs7X+xyB+sb6By1wWI5GaqWmGzhVTV/hYmjLv8hKp905vdb/q
         jKGVNi3QYcy3rwuW/hAf+RhOsFjlOtPzO0UsPTXODgOB0j4wpH+wjyvVR6UIIdcli+N7
         whRdZmjuDtGnM/Xzy6ZgIKza8chXsfyW3VudI4tCsF8QVbJuiJAEUUv5tgKKRQLCuS4H
         wG7mhMWnIjwVoi0Uwwf8/vpTY2TZ/TykFVu5x+gMQiX5VVlHEfskNOPeW3tJvivEP06r
         JwiakGTXMNZmFY85k2VqxJq7J9AAWUDBEo9GJLM+IR7d3S7KuDmLPiVs+u6+fNs0VCkE
         pq2w==
X-Gm-Message-State: AOJu0YyzyeFgvfy5JNT8Mb1dH9Oxcm6eTMwwFJJeV19RkSy0XRVjF5Cj
	JzbQXLzGqDTkLn4+5TcUhhi1DTzHHl1NhKDbv7XJDlX8ARnXba71xoNXDSG6uw==
X-Gm-Gg: ASbGncvIyV9R6nvepKwgt7UC4BO3ShtMmBwJ+XasTw1beEONcZSuPy/8CJk20GRjpuv
	IhVQxGtaCkAilAJc8y75akiUbN7wO9Zi5qcWiE2fJ/FjfRavwe1OhtG1ZA5Iub04aF0w/MbSagi
	xXo9e/C3SHLpoGMa8O4pbgR0umLKbAze+xMFADV44Hy4j8hmQiNkHDOmsEQFSEtdIn42pJR/ny+
	nNesGzXftvZwl9Gw7P+E0kHildAmCYFVV4oegW+1+7mp6jhjDHW54ODxvRxcjrHRv9rTk9vfQXV
	25F+5hzkRXWE9R/FRjJtvgArdQ0dN1G2
X-Google-Smtp-Source: AGHT+IGonhI9nIlu+/VA27O4CeZW+WjCwr3TnYODmnDCyT3OwKigaZvazlVLIl7973Y+JTZ2seLtUQ==
X-Received: by 2002:a17:903:1c4:b0:21f:baa:80c1 with SMTP id d9443c01a7336-21f4e80a0eamr68713055ad.53.1738949829427;
        Fri, 07 Feb 2025 09:37:09 -0800 (PST)
Received: from kotori-linux-laptop.lan ([116.232.67.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dbaasm33134055ad.144.2025.02.07.09.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:37:09 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: stable@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH 6.1 5.15 5.10 5.4 0/3] Backport ASIX AX99100 support
Date: Sat,  8 Feb 2025 01:36:56 +0800
Message-ID: <20250207173659.579555-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset backports ASIX AX99100 pcie serial/parallel port
controller support to linux 6.1 5.15 5.10 5.4. It just add a device ID,
no functional changes included.

The commit 3029ad913353("can: ems_pci: move ASIX AX99100 ids to
pci_ids.h") was renamed to "PCI: add ASIX AX99100 ids to pci_ids.h",
and changes in drivers/net/can/sja1000/ems_pci.c were dropped as the
ems_pci change are only relevant for linux 6.3 and later.

Tomita Moeko (3):
  PCI: add ASIX AX99100 ids to pci_ids.h
  serial: 8250_pci: add support for ASIX AX99100
  parport_pc: add support for ASIX AX99100

 drivers/parport/parport_pc.c       |  5 +++++
 drivers/tty/serial/8250/8250_pci.c | 10 ++++++++++
 include/linux/pci_ids.h            |  4 ++++
 3 files changed, 19 insertions(+)

-- 
2.47.2



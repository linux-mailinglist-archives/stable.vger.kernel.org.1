Return-Path: <stable+bounces-10539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714C882B6C9
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3CB28733A
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438258138;
	Thu, 11 Jan 2024 21:44:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368458203
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T9yqd55xhz9sJ3;
	Thu, 11 Jan 2024 22:44:29 +0100 (CET)
From: Markus Boehme <markubo@amazon.com>
To: stable@vger.kernel.org
Cc: Markus Boehme <markubo@amazon.com>
Subject: [PATCH 5.15 0/2] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Thu, 11 Jan 2024 22:43:52 +0100
Message-Id: <20240111214354.369299-1-markubo@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gwiazsothgtcu7mnkfujqbmihu8i3bxx
X-MBO-RS-ID: 1623eefb967b1b7a761

This backports the fix to the kprobe_events interface allowing to create
kprobes on symbols defined in loadable modules again. The backport is
simpler than ones for later kernels, since the backport of the commit
introducing the bug already brought along much of the code needed to fix
it.

Andrii Nakryiko (1):
  tracing/kprobes: Fix symbol counting logic by looking at modules as
    well

Jiri Olsa (1):
  kallsyms: Make module_kallsyms_on_each_symbol generally available

 include/linux/module.h      | 9 +++++++++
 kernel/module.c             | 2 --
 kernel/trace/trace_kprobe.c | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.40.1



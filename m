Return-Path: <stable+bounces-20397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D9858F3F
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 13:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259CA1C216C3
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCFC6A02A;
	Sat, 17 Feb 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XQ+A/Cm5"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3869E1D
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172023; cv=none; b=i9ej8GDo9NLphapTOaW1G3JcUTKu8gU0RdfPgal4ngA2riKXY6H1baBEuc0HPjj1k6ykpgEHk5DNweOqsE354FgrKwEWmC23Br3UqNk+k9ezoZVogc959RpJawUynKTDrpFK6YJ1nGHQknfkXGbRXsjv/T4l9u799fqHxXEwjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172023; c=relaxed/simple;
	bh=sbpQfcyWZ+JnhtmI1ipIs5Ou0Z6I01hcW+8adsty9pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AnQ6cCieF+H+UGzjves9a0OCHEIP8VAuHBzLS4geiR6vxb8swWYiA3aolD2e+f8wxw/mreoKwmrXxdbAvQNW8lrVw6gqZ2Fffvn5oQvzfLCMTWmTyfNpyd5T8rxGMUfC6GRM71zVC7/SKgcyMPBoGlNGJEItbH8PTLiBa9vCJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XQ+A/Cm5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wltbhY+yB2cBjtAC/f5ptuX1Mr4WFttCztDJmnxT6q4=; b=XQ+A/Cm5CQ8N/gpb6LhxPwedSt
	FoXCt5NuH9K4SAKbjYV/a5jzyw1pCG6iTq74pb9KeN6NopIalKtixjcHnzCoRK6oX9g/XmpsZ4nvx
	qGgbXgDFrUSzFx0aITCy3mEx3IiGxXhOhVQyoKxr0tEebYVDBXBha1+wOVRSKqh0E3Rc8XZ17qrc6
	V+BenHm06F9cFv/aZSZzDLJ/YcEN91o/IkVqroK4iudW+UG3CvnxJ23xBuUsUhV9CgxXk1NT47GaB
	i9lWVCsER3x5yVp3kO7TgLBGX44iaIx438GQL1q+TpgKWzbHbjzf+i8qKCNdXI9gGheKGR5lZ6vaA
	k5Uev+pw==;
Received: from 179-125-79-204-dinamico.pombonet.net.br ([179.125.79.204] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rbJZQ-000joD-OB; Sat, 17 Feb 2024 13:13:29 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: cascardo@igalia.com,
	jolsa@kernel.org,
	daniel@iogearbox.net,
	yhs@fb.com
Subject: [PATCH 5.15,6.1] Fixup preempt imbalance with bpf_trace_printk
Date: Sat, 17 Feb 2024 09:13:14 -0300
Message-Id: <20240217121321.2045993-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bpf_trace_printk is called without any args in a second depth level,
it will enable preemption without disabling it.

These patch series fix this for 5.15 and 6.1. The fix was introduced in
6.3, so later kernels already have it. And 5.10 and earlier did not have
the code that disabled preemption, so they are fine in that regard.

This was tested by attaching a bpf program doing a non-0 arguments
trace_printk at sys_enter and a 0 arguments snprintf at local_timer_entry.

Dave Marchevsky (1):
  bpf: Merge printk and seq_printf VARARG max macros

Jiri Olsa (3):
  bpf: Add struct for bin_args arg in bpf_bprintf_prepare
  bpf: Do cleanup in bpf_bprintf_cleanup only when needed
  bpf: Remove trace_printk_lock

 include/linux/bpf.h      | 14 ++++++--
 kernel/bpf/helpers.c     | 71 ++++++++++++++++++++++------------------
 kernel/bpf/verifier.c    |  3 +-
 kernel/trace/bpf_trace.c | 39 ++++++++++------------
 4 files changed, 72 insertions(+), 55 deletions(-)

-- 
2.34.1



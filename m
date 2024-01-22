Return-Path: <stable+bounces-13952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03F0837EF1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D375F1C287A1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A6604C9;
	Tue, 23 Jan 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdtC15vU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB060274;
	Tue, 23 Jan 2024 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970840; cv=none; b=Y83kYMnSsuSf5uWvnmR43jeeEZ9ufk2p1Myxx5+X1vxiZqrKFOk89o0xrqrlGXEG4T3cmgiFXGI+funftNsa+SOWlcmwKEhx8FeXiG7oonoKuOAx00N5PTAFkZzQnaOMwpHSy7+alxBvZnoSfqv2eOXznsvMvcf+GmKyZPWplTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970840; c=relaxed/simple;
	bh=xJftf8uC3FtjOh/a64h3E1lwmJL3yaz7xDABHJXm5ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CenO8/VHuF01T2r4sOpjypXe4ShYk2+3w2Kr13AJmZsjdK7WfAJ0igSJw+4oFVoX2fe2Bm5vpFc+RQJnIGH700uWhnbnix/UeEEGZQ3/iSsdA3xiHU9EUA7it9RsZgTlEwmeNn0WCdGg1vXRuP1vuuAJgvQQFY5Evp0IsgqTiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdtC15vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CB0C43390;
	Tue, 23 Jan 2024 00:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970839;
	bh=xJftf8uC3FtjOh/a64h3E1lwmJL3yaz7xDABHJXm5ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdtC15vUA2qgM1SaSOIFj9iOn8oh0lMK6UnDhMX5mEO6Rixx4IufAZFfZ2J2GNjnz
	 23MncJwUMVWDwM175+5Dsvv8Qm/63pTOel/shEamsURli0YgfdCmhFTYuzBUPmexwx
	 5jbkJr802hPlehC6PSDhwuj73urMGauFyrEhN068=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 028/286] ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI
Date: Mon, 22 Jan 2024 15:55:34 -0800
Message-ID: <20240122235733.100356614@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit 712292308af2265cd9b126aedfa987f10f452a33 ]

As the ring buffer recording requires cmpxchg() to work, if the
architecture does not support cmpxchg in NMI, then do not do any recording
within an NMI.

Link: https://lore.kernel.org/linux-trace-kernel/20231213175403.6fc18540@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5abe88091803..041b91c2ba10 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3444,6 +3444,12 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
+	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
+	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	    (unlikely(in_nmi()))) {
+		return NULL;
+	}
+
 	rb_start_commit(cpu_buffer);
 	/* The commit page can not change after this */
 
-- 
2.43.0





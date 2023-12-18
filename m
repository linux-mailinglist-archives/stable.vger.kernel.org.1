Return-Path: <stable+bounces-7241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058D7817192
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0DE1C242EA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFBC1D13D;
	Mon, 18 Dec 2023 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lx3WrA3C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE04A1D14B;
	Mon, 18 Dec 2023 13:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407F8C433C7;
	Mon, 18 Dec 2023 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907939;
	bh=H0kSUVIuYXQ3OyDTc0K3CqC0CJOV2R1amVpcJqMcwQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lx3WrA3C72Z71b/U/JSsj3hoGXDab95HkdmTPBXnO0i+WYQe2Do5y380oKlOYJSSF
	 0RkrWqxI1JwgNP3PiLFFlu/1MEqtr1OwqaB19dlZX1vTC5ccvT0WDoOTaKvuxQ8AFS
	 cet6yWm36SlnRwStILqSCJpJtKrUi+0/ojfij/Ys=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 102/106] ring-buffer: Have rb_time_cmpxchg() set the msb counter too
Date: Mon, 18 Dec 2023 14:51:56 +0100
Message-ID: <20231218135059.419964503@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 0aa0e5289cfe984a8a9fdd79ccf46ccf080151f7 upstream.

The rb_time_cmpxchg() on 32-bit architectures requires setting three
32-bit words to represent the 64-bit timestamp, with some salt for
synchronization. Those are: msb, top, and bottom

The issue is, the rb_time_cmpxchg() did not properly salt the msb portion,
and the msb that was written was stale.

Link: https://lore.kernel.org/linux-trace-kernel/20231215084114.20899342@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: f03f2abce4f39 ("ring-buffer: Have 32 bit time stamps use all 64 bits")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -727,10 +727,12 @@ static int rb_time_cmpxchg(rb_time_t *t,
 	 cnt2 = cnt + 1;
 
 	 rb_time_split(val, &top, &bottom, &msb);
+	 msb = rb_time_val_cnt(msb, cnt);
 	 top = rb_time_val_cnt(top, cnt);
 	 bottom = rb_time_val_cnt(bottom, cnt);
 
 	 rb_time_split(set, &top2, &bottom2, &msb2);
+	 msb2 = rb_time_val_cnt(msb2, cnt);
 	 top2 = rb_time_val_cnt(top2, cnt2);
 	 bottom2 = rb_time_val_cnt(bottom2, cnt2);
 




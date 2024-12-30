Return-Path: <stable+bounces-106574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A4B9FEA78
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 20:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046963A2B81
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5AE199235;
	Mon, 30 Dec 2024 19:48:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7D22339;
	Mon, 30 Dec 2024 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735588135; cv=none; b=a8elZAUA9yPAvUPHpNK8+5Fqdthubh/rcHDH8TkjTI5DUwhrheUhiVm4u1qPTZQ8bhyVr7llgp2LTVlrzqs72axjIHM/EPpV6uNoRhHAmDlEvCHRyY4jcY152hVMd0lUKWCnVsCTYnGC3jlUS86Ahm77U/PMSJnbPXq6yTJAE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735588135; c=relaxed/simple;
	bh=BqNrskxIb8SvW2lLYiMrpwgJ4V5FMxmmQrN/z+2DYjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bc9YXYJKSJVRPF/DNuvdVRHsKj5CVPurwlf4F2TtErGm1JUuRxnW4fJ8Nkq442nqbY09hS7pUwrBC8ZAfUL3FPe5z+1XfzjJ6gNPOX4aKsJKGSs0fmBjgOpPoYDzJygF0p+Z/jZIl40c/8E93u9rdPWAYlfQ0esaHMFlq3WH+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898EAC4CED0;
	Mon, 30 Dec 2024 19:48:53 +0000 (UTC)
Date: Mon, 30 Dec 2024 14:50:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REGRESSION][BISECTED] Re: 6.12.7 stable new error: event
 xe_bo_move has unsafe dereference of argument 4
Message-ID: <20241230145002.3cc11717@gandalf.local.home>
In-Reply-To: <20241230141329.5f698715@batman.local.home>
References: <2e9332ab19c44918dbaacecd8c039fb0bbe6e1db.camel@sapience.com>
	<9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com>
	<20241230141329.5f698715@batman.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 14:13:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I guess the "fix" would be to have the check code ignore pointer to
> arrays, assuming they are "ok".

Can you try this patch?

-- Steve

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1545cc8b49d0..770e7ed91716 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -364,6 +364,18 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 		s = r + 1;
 	} while (s < e);
 
+	/*
+	 * Check for arrays. If the argument has: foo[REC->val]
+	 * then it is very likely that foo is an array of strings
+	 * that are safe to use.
+	 */
+	r = strstr(s, "[");
+	if (r && r < e) {
+		r = strstr(r, "REC->");
+		if (r && r < e)
+			return true;
+	}
+
 	/*
 	 * If there's any strings in the argument consider this arg OK as it
 	 * could be: REC->field ? "foo" : "bar" and we don't want to get into


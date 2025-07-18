Return-Path: <stable+bounces-163357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA0B0A0D3
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81381C42A9D
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4162BCF47;
	Fri, 18 Jul 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ySj7+q5o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ikBbKC7O"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01629B218;
	Fri, 18 Jul 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835224; cv=none; b=VvKjXI2BVsBWJZ780zgpD76QdrR4zygWtxddUHtPCFRviNeh4Bi9AwI/Z8X8hsRZz++690nADntCSrpKYsK+RQ7LXgn9pF9EGitZ9FVtjfRzFODwjqhcFVLBEFcY4zgfo101NOiwTiu7hpdv9U98pnPCbaffDCqV+ITXaDu6g98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835224; c=relaxed/simple;
	bh=EfctGBqA+tFsqy1MQgf/QW8ed9cdtao3pVhWdvVteAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMRDlLI5B0C43//a6l2WcQv4i47FxQAiDocEBJe+WAm40OrRh2F3aCemhzRWS8gxGrHBJejb+eN97pceBrUoR/6r5TQdPTWeHiB3YNebRm3rsa8H+ACEetE4ylS+nI496Ar7rz7F+WBkURM9qVh0AtXd2o71qKQ7xoYmMstaGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ySj7+q5o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ikBbKC7O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 12:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752835219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDMVrdweoF/EUIrbyPjq3jBCHKVn3HSx2l+SgvFzmxQ=;
	b=ySj7+q5ow5+w92BYYOB2ovSU4z0PU2DZ20fHF1fAgSnBLoj7qbPWlWXo8/O/QoKrPaEJdj
	NjRYz1nat+RUFP6Cj1wDKO9LHzeusqkqmh0jrQMso4PI95dwonefBsDOF20+ni3wShxLgg
	Z5FdOdjSdj2U8+d5BtfYQUxjYLwLQZRQeGDfMShbnQbkIxpz8v6NWWIWMxIX+RH73/7qhf
	CMXDUnQtj0KJsCXpeZ+Qrq5bJHyfH+5vUunJUctYSUmm+Cgv10hvpbIDSJHOznRPlCQg/F
	4cjwv0qpEwe/KfXwdl8BLtcoKXN+mjt+D9ddaYRGvid7y3D+AuY/zNw2MUXIxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752835219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDMVrdweoF/EUIrbyPjq3jBCHKVn3HSx2l+SgvFzmxQ=;
	b=ikBbKC7OOeVaD8woVi3vZXQH7tbu4GqgUCWyWXVQF05wLLF1e9ujZB1g/AZfF2OLWbUPNZ
	jY/lWNj6vio0XwBw==
From: Nam Cao <namcao@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rv: Ensure containers are registered first
Message-ID: <20250718104018.lyupqBnR@linutronix.de>
References: <20250718091850.2057864-1-namcao@linutronix.de>
 <2025071835-enjoying-darn-f5d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071835-enjoying-darn-f5d8@gregkh>

On Fri, Jul 18, 2025 at 12:27:14PM +0200, Greg KH wrote:
> On Fri, Jul 18, 2025 at 11:18:50AM +0200, Nam Cao wrote:
> > If rv_register_monitor() is called with a non-NULL parent pointer (i.e. by
> > monitors inside a container), it is expected that the parent (a.k.a
> > container) is already registered.
> > 
> > The containers seem to always be registered first. I suspect because of the
> > order in Makefile. But nothing guarantees this.
> 
> Yes, linking order matters, and it does guarantee this.  We rely on
> linking order in the kernel in many places.

Hmm, I thought this is just how the linker happens to behave, but not a
guarantee.

Let's discard this patch then.

Nam


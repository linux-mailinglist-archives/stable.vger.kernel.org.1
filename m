Return-Path: <stable+bounces-144214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73CAB5C1B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE93A3BE2D7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4328C2CE;
	Tue, 13 May 2025 18:14:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853081A23AD;
	Tue, 13 May 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747160084; cv=none; b=Qpkmwcl7Ruci6RiCk8odR9OS/rJgUgSPrV89DyZyAiWFhEWx16qtd2zyvlyKwWlpY3fKAjJ/E/YeTBxrST0gf652YgvUYrJHsGD4PfJZWeXWKMflbzxhNQK34meThSKh2PepIYINFJuxrv0c6yQ8oN9gxHMFZi1sEhujAo/+/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747160084; c=relaxed/simple;
	bh=LlA+yEuJwjZNZehu9oR0nMH3roEgv2G7r66Vz+hLWBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiKl5M+XyPxsNjMTeRAExcaApsOEX/x2rycfYjVnokeFxWbwcFxa7DXfggpIRZWj/9r9/3TCjJnD4ndQWRYEoglKiDkAf+4AXJEub2cT297uzyd2nUPfgMLSk8xgRad5mPjiC2la0G6IFmgY6p5eI80AmvH6L4LSZyUW5cui5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5797CC4CEE4;
	Tue, 13 May 2025 18:14:42 +0000 (UTC)
Date: Tue, 13 May 2025 14:15:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250513141507.7ae74183@gandalf.local.home>
In-Reply-To: <20250513025839.495755-1-ebiggers@kernel.org>
References: <20250513025839.495755-1-ebiggers@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 19:58:39 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Fix several build errors when CONFIG_MODULES=n, including the following:
> 
> ../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
>   195 |         for (int i = 0; i < mod->its_num_pages; i++) {
> 
> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

I just hit this build failure while running tests on patches that are on
top of tip/master.

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


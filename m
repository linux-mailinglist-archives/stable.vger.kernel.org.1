Return-Path: <stable+bounces-191530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC5C16532
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BE23A62A0
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815C134B419;
	Tue, 28 Oct 2025 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEIaoCXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B4723EABC;
	Tue, 28 Oct 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673741; cv=none; b=k/euvLZuKl+o5rg0+K7NDTjNqaf5lI1mI0P9gFckU2n4HVrlCLj1yLgl77Ada4SiOAXo36qtNSroW4A0FWpB2stcS4vR/UQLyozEA6iqzu3IFG5U9kdVBmA5GzPllaHXLfhBT3x3Hkfn6YD7AkhDCKtyAJfNvv3QoIiZ8aYhvH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673741; c=relaxed/simple;
	bh=6pz2yi2RcqVpOEdgeXYO4hJHfgrxHP9zLxBXkUOeJWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXrTr6I4MXT4Bp6G9eybrxKxkIlIJKK6A8wBqqcimjQ4W4nt8wmZDHkS0rm5dPIX6uuFfQBgah6H0WSevVx6cCnPZ68kO9Er2F365Xy2TtBmd7/nE5F1H3nJ5duZaL4LvWU46I5Kb/ImsG5uIur3QkjNbL71zmlX69yBgiY7rLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEIaoCXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87927C4CEE7;
	Tue, 28 Oct 2025 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761673739;
	bh=6pz2yi2RcqVpOEdgeXYO4hJHfgrxHP9zLxBXkUOeJWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEIaoCXM+Va/CjYOtpFN4cM+w7jP6i4lKN5sfnixGTEVYd/cyZGc4e4hkNq/2mo/O
	 rDSAurh+mlhZ4xk3Le+CjVVWAd59FdmNPGzrpLK+4Po49n/7Qb+Lo0D8IZX3+TyhkM
	 BTybS4jEIx3avEVp+AEyUfprOECob52ariPlmK1WpmwzGU2O2CGsqcf9TxuU4/FZCf
	 XLPdH8EkIorIDu71WY4lNUsIHqLdhkjGRduXuy00FnoClhaf1QPpNVRWSCRwtKo8ql
	 AWx2SAgwpiGGQAPbe2I1QEdOAsOId9UTsJJEg6ngBM+SaGtue5tppENFIqQgHRcTeu
	 7cDTh9LkJ3pRA==
Date: Tue, 28 Oct 2025 13:48:58 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Vladimir Riabchun <ferr.lambarginio@gmail.com>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.1] ftrace: Fix softlockup in
 ftrace_module_enable
Message-ID: <aQECCjH3rMiUSj-f@laps>
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-385-sashal@kernel.org>
 <20251025152545.534cb450@batman.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251025152545.534cb450@batman.local.home>

On Sat, Oct 25, 2025 at 03:25:45PM -0400, Steven Rostedt wrote:
>On Sat, 25 Oct 2025 12:00:16 -0400
>Sasha Levin <sashal@kernel.org> wrote:
>
>> - The change inserts `cond_resched()` inside the inner iteration over
>>   every ftrace record (`kernel/trace/ftrace.c:7538`). That loop holds
>>   the ftrace mutex and, for each record, invokes heavy helpers like
>>   `test_for_valid_rec()` which in turn calls `kallsyms_lookup()`
>>   (`kernel/trace/ftrace.c:4289`). On huge modules (e.g. amdgpu) this can
>>   run for tens of milliseconds with preemption disabled, triggering the
>
>It got the "preemption disabled" wrong. Well maybe when running
>PREEMPT_NONE it is, but the description doesn't imply that.

Thanks for the review! I've been trying a new LLM for part of this series, and
it seems to underperform the one I was previously using.

-- 
Thanks,
Sasha


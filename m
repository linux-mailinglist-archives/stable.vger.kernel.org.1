Return-Path: <stable+bounces-179075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7CB4ADB4
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 14:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E4172064
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC57322767;
	Tue,  9 Sep 2025 12:04:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7812FF679
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419479; cv=none; b=gDrkqVV/8MKIqwE1Sl+/AF6LsNo79VLNPSHzHUQr2BxEwdbQhF1oiso5fTlpkoLM8QrmunefFJikE8nx8rspzNJFOUgKKOESMS4AROQ1nM5ErnKfYQm5LBqLIajtPV0j2hmpVoSJLm5foI9lgPKTa6NKO/2bpddt63Ii+OfUbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419479; c=relaxed/simple;
	bh=KgsAb4NxrALmbompHqpXbboMITyx05x9hO3+CceDcR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rALJNk/DqMB37KGH0MWg8ejkowIPM0IXR3DYkYlkv1ahCuKDQNyLuJcvJ/ZaQ9pKhAEKqbZNpFP9F32qQajm6MxEGaO48g8poGbZzAblU9PtPQabegIUQeAt0G/IkQRnQ+MI2w6SutPkI5t6RlPQUkTgUtQC/6Tt3qJi6zcTofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDBEE1424;
	Tue,  9 Sep 2025 05:04:28 -0700 (PDT)
Received: from [10.1.26.104] (e132430.arm.com [10.1.26.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9CDE3F66E;
	Tue,  9 Sep 2025 05:04:35 -0700 (PDT)
Message-ID: <c49ae320-b73e-42b3-b41a-4f71560a6431@arm.com>
Date: Tue, 9 Sep 2025 13:04:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] tracing: Do not add length to print format in
 synthetic events
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <2025041706-ambiance-zen-5f4e@gregkh>
 <20250907222532.932220-1-sashal@kernel.org>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250907222532.932220-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 07-09-2025 23:25, Sasha Levin wrote:
>   1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 385e9fbbfbe7c..c2817d0c05b69 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -383,13 +383,11 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
>   				str_field = (char *)entry + data_offset;
>   
>   				trace_seq_printf(s, print_fmt, se->fields[i]->name,
> -						 STR_VAR_LEN_MAX,
>   						 str_field,
>   						 i == se->n_fields - 1 ? "" : " ");
>   				n_u64++;
>   			} else {
>   				trace_seq_printf(s, print_fmt, se->fields[i]->name,
> -						 STR_VAR_LEN_MAX,
>   						 (char *)&entry->fields[n_u64],
>   						 i == se->n_fields - 1 ? "" : " ");
>   				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);

This looks consistent to me with that patch:
[PATCH v2] tracing: Fix synth event printk format for str fields

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..f71e49cd35b0 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -305,7 +305,7 @@ static const char *synth_field_fmt(char *type)
         else if (strcmp(type, "gfp_t") == 0)
                 fmt = "%x";
         else if (synth_field_is_string(type))
-               fmt = "%.*s";
+               fmt = "%s";
         else if (synth_field_is_stack(type))
                 fmt = "%s";
  
I only tested the trace.dat route when writing it, thanks for catching this case.


Cheers,

Douglas



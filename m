Return-Path: <stable+bounces-235962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IS4C3+u3GnfVAkAu9opvQ
	(envelope-from <stable+bounces-235962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE803E95D8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B821A3020EE1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2E3AD53F;
	Mon, 13 Apr 2026 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="59OnR8mh";
	dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="ZimjZvxp"
X-Original-To: stable@vger.kernel.org
Received: from mail.srv.csmantle.top (mail.srv.csmantle.top [77.93.157.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06203ACF18;
	Mon, 13 Apr 2026 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.157.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070185; cv=none; b=n4L2gJwvtfjeX0WPMNIGYmninAovSnEJYVzUGDS+VrWWyQu3bKfRvSBz0/sc75Srkhsyyuu0P8t5jTjkskxBwetslZSpppUt0icsYcZoQbajybOyG3UguslR+BI88sPv3z3tkaJrzAbOrfFKEF9DDURBFlLUQdDLnTXYDu39Adg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070185; c=relaxed/simple;
	bh=bdMEH6BffjYxwN/uwZveM6rAFybUgLDXqVkJob6/B/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8Sm0nTnhlVTi1wkcb3x8AUK1pxS6QzKYAO9N6DOUvkaOFUaMGcbCx3KYDZKvYvInmBgcVN5hAvWpgIOfMBN6WU1juXi1B2envEuLjJVV90DojwHgjmp9TZj2M3NVlWalkfaoh0J491ZnPVReZP7IYAbUWq+9FclSnEyTuWe1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=csmantle.top; dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=59OnR8mh; dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=ZimjZvxp; arc=none smtp.client-ip=77.93.157.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csmantle.top
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-ed25519; h=BIMI-Selector:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:In-Reply-To:
	References:BIMI-Selector; bh=6OrlQu4O57XEr1X3XLOvXNQM3/Z2iT8i6M9UMgn5zyc=;
	t=1776070183; x=1776674983; b=59OnR8mhatYWey7D+KYQTQsB8vvpeAdPwqYms0ooeuu32Lc
	wV63Jw7Z82GFtqKxUPyS0Xu6tpPjLrOVZJyuyBg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-rsa3072; h=BIMI-Selector:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:In-Reply-To:
	References:BIMI-Selector; bh=6OrlQu4O57XEr1X3XLOvXNQM3/Z2iT8i6M9UMgn5zyc=;
	t=1776070183; x=1776674983; b=ZimjZvxph+fbSdCj3U8j264HQ2GU+KfMq1j0vmnuvpUleg2
	aYh3gALBIGqjqzXpRGMB3qP+bWTP/gSktdfixrqh2amHJJmJ3OwnbYghdaN3rdGl/L3WSgbqBObjh
	98XnI2Q2Fr7Ey0Os9QcUuk/Bzw4eH8Zt9npzK/mkj3kddgs59M/xBjEkheXXwLR0rJl5MvqnylzvV
	JxD9moZaasCA2GsNZL3U9C3TMU1EjuNy2Ifc3TCRl7XvmzfumHTSZEGsoZCbKHxZj6wviuV6XTX/i
	DZ5E5ZJcL1bVqn8LY2bQasjdnblBXoRIeugM0y9MIzNb+oPW5vuoLBAuECZw4LfqvXNiIGTS6Xv0L
	/CjKwhXo5vWXfSeSfZrDmjpdHeeWFxuhy/EziePczxG+6401mW1kU98yXEsumuzYS0MVuews3q/nU
	F9Yb83CwUpFrN8KUqdvPjqejkSyjrWQPjVbYqmuIFxofmmqpiJgTuQxuXc17elZgOWcsldacDyjnI
	Mys;
Received: from [47.76.78.191] (helo=[172.16.23.20])
	by mail.srv.csmantle.top with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <rong.bao@csmantle.top>)
	id 1wCCz7-00000000cn8-1TS6;
	Mon, 13 Apr 2026 16:49:33 +0800
Message-ID: <0160f8e5-56f5-4024-8e4f-a72c4ab19f97@csmantle.top>
Date: Mon, 13 Apr 2026 16:49:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] perf annotate: Use jump__delete when freeing LoongArch
 jumps
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org,
 WANG Rui <wangrui@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
 loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260412062828.1734637-1-rong.bao@csmantle.top>
 <CAAhV-H4NHEo_JnnDYkWAYdTwiNuyVGNYymyOLL89ZxQVrqRjuA@mail.gmail.com>
Content-Language: en-US
From: Rong Bao <rong.bao@csmantle.top>
In-Reply-To: <CAAhV-H4NHEo_JnnDYkWAYdTwiNuyVGNYymyOLL89ZxQVrqRjuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rcpt-Check: Accepted by authentication
X-42: Don't panic! 
BIMI-Selector: v=BIMI1; s=me
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[csmantle.top,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[csmantle.top:s=self-ed25519,csmantle.top:s=self-rsa3072];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235962-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[csmantle.top:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rong.bao@csmantle.top,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,csmantle.top:dkim,csmantle.top:email,csmantle.top:mid]
X-Rspamd-Queue-Id: 9BE803E95D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Huacai,

On 2026-04-13 16:33, Huacai Chen wrote:
> Hi, Rong,
> 
> On Sun, Apr 12, 2026 at 2:28 PM Rong Bao <rong.bao@csmantle.top> wrote:
>> [...]
>> This patch adds the missing free() specialization in loongarch_jump_ops,
>> which prevents disasm_line__free() from invoking the default cleanup
>> function.
>>
>> Fixes: 4ca0d340ce206 ("perf annotate: Fix instruction association and parsing for LoongArch")
> The original code works well, you are really fixing fb7fd2a14a503b9a
> ("perf annotate: Move raw_comment and raw_func_start fields out of
> 'struct ins_operands'").

Thanks, I'll fix the reference in v2.

> And LTS branches (6.12, 6.18) need different fixes because the code
> has been restructed.

I locally have a version based on the linux-6.19.y branch. Would you 
mind providing me some pointers to the standard approach to submitting 
this rebased version? I'm new to the process.
>> [...]
>> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
>> index a6e478caf61a9..6b7fef3bbc42f 100644
>> --- a/tools/perf/util/disasm.h
>> +++ b/tools/perf/util/disasm.h
>> @@ -158,6 +158,7 @@ int call__scnprintf(const struct ins *ins, char *bf, size_t size,
>>                      struct ins_operands *ops, int max_ins_name);
>>   int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
>>                      struct ins_operands *ops, int max_ins_name);
>> +void jump__delete(struct ins_operands *ops);
> Don't put it among ***_scnprintf(), put it before ins__raw_scnprintf()
> or after mov__scnprintf(), and add a blank line.

Sure. This will be fixed in v2.

> 
> Huacai
> 
>> [...]

-- 
Regards,
Rong Bao


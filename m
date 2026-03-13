Return-Path: <stable+bounces-225268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EgkDtDSs2l5bQAAu9opvQ
	(envelope-from <stable+bounces-225268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:03:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E35280254
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFD9430518EA
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F79387377;
	Fri, 13 Mar 2026 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGQJzoRQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GemXhqYN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CB388E4B;
	Fri, 13 Mar 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773392573; cv=none; b=n58lR2cmOaRUsH75Zbsy6MOemznPYKYOU1AXE56VIhHF4YhGks5J3jXeOxvUVozvmiLl1TVvY2q6NiXcGIex2fDFqLGqPG1B+mic3RAzfF8imVil3tYYq/OexHKu+ZqSHTUJXbRtW1KW8yWcZJq18t0Y29W6QG3joFIliHDNxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773392573; c=relaxed/simple;
	bh=OGM4EBqnJKJK+8L3o2t7yW0p3EbFYRGIOVy2+mBvoDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdhSc1ifTLGsznuKAP3AuKQQxZ0nUqkd+OnUWd2/y6/8QDFpoZfiH7sxFvi4XTs/qU36ylnQMWjRAcuoXtQyKKRGF4uQ/8kiW3i2zYykAED6RsDgjK+YqF4eDfrdMGmpZW2c6KVdX/8oMPC0QsQ7hnKwAQQ2UFoVR+8aQDuZ3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGQJzoRQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GemXhqYN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Mar 2026 10:02:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773392570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDsx7+o6ET1T9lEaarJoduRn33Cm29uhzlwRxM8Y890=;
	b=gGQJzoRQ2uGkWjFYLIVJcQG2h++KjcZErawdS1vf1/u77pz3dt5ZGnuW5dMvWcUaF/X61R
	9sGHILSUY/pf/Bth050YQ3gP9lUSeQSCXNERs24QtoYkGbGXGcoxevaWkzI0NNIY6jffHO
	BmPu0FvocWBXsC5HVzUdqLTdmbc8hBxeu5wzb28c/ZQZZRSGcgWygTbVP891EOlnxkphwB
	eO4j6rTaKpHAtIN+Gqy32A79j1qD4wHAQsEJratKRkbQXojyPdMMbRUiNcMhe1J4TifEJa
	ojb7whcdKm962AZMxAVJV4pAHUC6VObNudLE+JeifbJ8LIR2VCgZ4dWYwJ2aBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773392570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDsx7+o6ET1T9lEaarJoduRn33Cm29uhzlwRxM8Y890=;
	b=GemXhqYNBQ7Ow9Dwmowa9DEwiFqtOKiTZhLEoww2b/wSgUYfXOTGNAKJfGweJWsEKveiYv
	3R6Cu4tP0er/TqCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests/hid: fix compilation when bpf_wq and
 hid_device are not exported
Message-ID: <20260313095731-682bbab2-5861-4aea-bc83-420492400c19@linutronix.de>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
 <20260313-wip-bpf-fixes-v1-1-74b860315060@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313-wip-bpf-fixes-v1-1-74b860315060@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225268-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid]
X-Rspamd-Queue-Id: 66E35280254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 08:40:24AM +0100, Benjamin Tissoires wrote:
> This can happen in situations when CONFIG_HID_SUPPORT is set to no, or
> some complex situations where struct bpf_wq is not exported.
> 
> So do the usual dance of hiding them before including vmlinux.h, and
> then redefining them and make use of CO-RE to have the correct offsets.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
> Cc: stable@vger.kernel.org

'Fixes' missing? Also for patch 2 in the series.

> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

(Some nits below, feel free to ignore them)

> ---
>  tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> index 80ab60905865..2c6ec907dd05 100644
> --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> @@ -8,9 +8,11 @@
>  /* "undefine" structs and enums in vmlinux.h, because we "override" them below */
>  #define hid_bpf_ctx hid_bpf_ctx___not_used
>  #define hid_bpf_ops hid_bpf_ops___not_used
> +#define hid_device hid_device___not_used
>  #define hid_report_type hid_report_type___not_used
>  #define hid_class_request hid_class_request___not_used
>  #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> +#define bpf_wq bpf_wq___not_used

'bpf' would sort before 'hid' alphabetically.

>  #define HID_INPUT_REPORT         HID_INPUT_REPORT___not_used
>  #define HID_OUTPUT_REPORT        HID_OUTPUT_REPORT___not_used
>  #define HID_FEATURE_REPORT       HID_FEATURE_REPORT___not_used
> @@ -29,9 +31,11 @@
>  
>  #undef hid_bpf_ctx
>  #undef hid_bpf_ops
> +#undef hid_device
>  #undef hid_report_type
>  #undef hid_class_request
>  #undef hid_bpf_attach_flags
> +#undef bpf_wq
>  #undef HID_INPUT_REPORT
>  #undef HID_OUTPUT_REPORT
>  #undef HID_FEATURE_REPORT
> @@ -55,6 +59,14 @@ enum hid_report_type {
>  	HID_REPORT_TYPES,
>  };
>  
> +struct hid_device {
> +	unsigned int id;
> +} __attribute__((preserve_access_index));
> +
> +struct bpf_wq {
> +	__u64 __opaque[2];
> +};

The fields are never used, would a forward-declaration be sufficient?

struct bpf_wq;

Then you could also avoid the #define dance for that struct.

> +
>  struct hid_bpf_ctx {
>  	struct hid_device *hid;
>  	__u32 allocated_size;
> 
> -- 
> 2.52.0
> 


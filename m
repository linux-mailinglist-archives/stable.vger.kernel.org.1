Return-Path: <stable+bounces-242412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDhSKEec9GloCwIAu9opvQ
	(envelope-from <stable+bounces-242412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:27:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E82534AC612
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970D3301DAF9
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1D73A255D;
	Fri,  1 May 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+ik0Clu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3A39FCC8
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638226; cv=none; b=NSATfzIuBJyKW43pX1MSfmldHnuvHPUiQW9fKqTOhKo4CE/9Hh4l+1/0SSCEtSzvwiTBYG/n3K6abIsQ/yO96L4b9TW+g+Urshh1tDlziXfUWN6OM01cP/aKl3RfPRT/45c4eVn9LvpoAwMQAe1Ndun4WHBDuZCOJ9bxdG21fMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638226; c=relaxed/simple;
	bh=hG1+nTYFaVMeBN3UfDamEXK/Fu0XaXrJJh/rhgkXCuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huirBr0y6w5Vbn0WOj//Fyj3T165s85LFimHlgSgPMfBpM+FD9/8uctlqaSx1v4gULPuQZy04abjJ47knZLL+Oz9H2dzwe+cMdhf4ShY+XeapOfMHeylrMae9g7zLtShNDKxXWlgVzIvmVgoW9EOrxmJpbzLqobYf6IfrPMsktA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+ik0Clu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48374014a77so21879055e9.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777638224; x=1778243024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG1+nTYFaVMeBN3UfDamEXK/Fu0XaXrJJh/rhgkXCuU=;
        b=F+ik0CluLpFSJtAndiyesuImbqllnRpEN6xqrVzpzxHZPjGATMPrrxKDH9gPHEpgIv
         WebNVMJfAI2ZMTRzS+cgnftNLRuD41Kjx33oHzrX5nSsi9wNFH5LFaJWfITLf1rIeiSu
         VBQhV2gPncFMqIP9IUkI/kvnzYyqJpZ/EzSP/ZiVgabg96Gvu2Mui8QLwKgEfY9y38Wy
         F81rumDONf1IWtTXgZV5suU3a1QkSPxFLeRt7S6eKvm5kM+WX6YUFW7UsxvpGXgL242K
         aIhz74Vxdp+hJWeIJEeZj1OCIEYTpr3j9YPhcr1qz1/7PizBKW9kz7jr3wI0gyspbVIj
         afew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638224; x=1778243024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hG1+nTYFaVMeBN3UfDamEXK/Fu0XaXrJJh/rhgkXCuU=;
        b=Oay3EDgBR3lHg0cUMuo9/vGHx5Qbne2l66AS/Q9ezIVFP8lnXhHNGTROkfwBdvQ909
         faS3abpmR8JuTn+5bG0dGdHckMcl6hRQjk09Iu5NxI4Wkqvjr7uUy9zG7T2WsbaZGU28
         ii7vTiHhSuQZsYtNtgh0phOAnoFZoTZx85M9KgLsX7waYo9azLv4Rezo9PazdI4njEey
         43slvh/ONIARgxqZgIgPF4rkFSlITqR3NKdIZGKoxdbYFKby+gNISHxsyZOAEBxgOKOH
         hS/o2s9KDdezfXyRiPrlZRwqoThpR0Y7FzFBelQANZjjGELWfCS6uLpA6fU5EMrq0Sb9
         msJA==
X-Forwarded-Encrypted: i=1; AFNElJ/U3MwfBR7XqIFMiCg4Ef5rE2lOlhQ/Qe6rz7RZyrHl+rz7EsWj/DE1+CBazCBb8VVdmc0dbxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJvI71E1Q0bRN4LtLxzPztmqh+dT+7fR/Q0aSrrhqe2g7a6v/
	+SL8qiZCMExnH76nr1s6qvjqm9S7MUbdIrXjv4/1JVa1b/3cYoDyKYm6lC17Gs1RRMg=
X-Gm-Gg: AeBDievQ0UmOzmHzVtigX+7uJ5jJOXdkw96Jfly06znbg93aF1bYl6rYXwgEBylpX6N
	zrZABuOGlf3LRZibKBd5yEqDYP/2VvJX/Pw44pFZzUNHcn35bKhQT+8HU00cCZAz4rMoWAJ3neV
	SCYGtA9Id9GNVKbpa9WF/LavWwB6bsPjrbuG/H54CX4TXiP0i9vjSQgMhaNMlcsbkT6TwsONM1c
	0o5fqytX1a0oN90A0/hQGD1SSiwnqGh7ES7b4l5qEqnBkx+h0mo4/ednlO1+JXOIwlHET2vwZuB
	BPez7M+75AHbnDMe1eudfAc3CfJd8rXAhblvXPOTMgRASHkCDROzE9YXcZ/Cbx+XBPhaFm9d/Pw
	fPxYTas/pR4W+bvcK1J4o4SjcRDfb6JKjfF61gw9Ncrrb1NARp2BMPKh2HV4pW6Ju3Z0hZteKcZ
	vvBQbhrD1D2YxXMmDxkW3zXH5CgxLK7K3GqnSQNIYoXoc=
X-Received: by 2002:a05:600c:4f47:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-48a8eb61e38mr44018115e9.2.1777638223881;
        Fri, 01 May 2026 05:23:43 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a986aab44sm4869155f8f.29.2026.05.01.05.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 05:23:43 -0700 (PDT)
Message-ID: <00f82e4b-4e1e-495d-b0bf-b6e4563cfee6@linaro.org>
Date: Fri, 1 May 2026 15:23:40 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] firmware: samsung: acpm: Validate SRAM shared
 memory and queue pointers
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org
References: <20260429-acpm-fixes-sashiko-reports-v3-0-47cf74ab09ad@linaro.org>
 <20260429-acpm-fixes-sashiko-reports-v3-4-47cf74ab09ad@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260429-acpm-fixes-sashiko-reports-v3-4-47cf74ab09ad@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E82534AC612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242412-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi everyone,

After further review, I've decided to drop this specific SRAM validation
patch from the upcoming v4 series. I had the typical band-aid vs. the
surgery dilemma.

While the intention was to protect against compromised firmware
providing out-of-bounds offsets, implementing this in the probe() path
turns out to be an incomplete band-aid. I identified two firmware quirks
that complicate static validation during initialization:

1) Some channels seem to use absolute physical DRAM addresses instead of
SRAM offsets. Mapping these against the SRAM ioremap triggers a fatal
page fault if we don't explicitly fence them off.

2) Some channels are purely doorbells (mlen == 0). acpm_do_xfer() and
acpm_get_rx() functions currently assume all channels have payloads and
sequence numbers, meaning these channels will break at runtime if we let
them pass probe.

Trying to silently disable or bypass these unsupported configurations
during probe() makes the code brittle and creates a false sense of
security regarding bounds checking.

I think the proper architectural fix is to introduce a formal
acpm_request_channel() API. This will allow the driver to validate
parameters at probe time, mark the unsupported channels and gracefully
return -EOPNOTSUPP to client drivers, rather than hacking workarounds
into the probe and runtime paths.

I'll leave the broader SRAM boundary validation for a future patch
series.

Thanks,
ta


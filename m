Return-Path: <stable+bounces-254100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEU3Nor5E2puHwcAu9opvQ
	(envelope-from <stable+bounces-254100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 09:26:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC2F5C71A7
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 09:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39ABA302204A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D183D1A8E;
	Mon, 25 May 2026 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MC6MKfQK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942C26E6F3
	for <stable@vger.kernel.org>; Mon, 25 May 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693829; cv=none; b=tM+jIcHXux7vEeAmqjJ9CwmLpWZoDDy/QpNBE7QtgJDXRATz1cwNnkbIMI6sRhaF8BwjCgEN1m58qesFe14CKn0zPROl/Rduxikn1BIG6/0zv3vbPIT6lrKZICabSAmPq3d9aUg6G96dMNAR4BJcv4wzMmlvhEeByxQaM7YgJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693829; c=relaxed/simple;
	bh=/I6DuQjJrsoUlY9F1+GIOyDSOhReuOcNfTPAOcdh/LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbWA+qWAQ7oht1iLaJyxzbO27wr/Wk6oTEUtwzz1+b0HvMlxet6TzIfeP0vJe18H0ies4YDaL1WlgPE/e7sdJEu441wxPSuic+Ifu8MFExV0wsc3c1rSIwYuRZxuK9PuSdb1ByAfwpqfFh2H1CtxCav3gSgeapnqk/MXl+w/fOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MC6MKfQK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7645adbdso5933813f8f.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779693826; x=1780298626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/oKgspdXMIsoQuyBhv4V3z/r/gtDk0V0FyCighFRfYc=;
        b=MC6MKfQKDjbWCWwDN6KK3pITqnyXZ4a/5ggmf2YOpuCObXz890BwdwOrXMy7VZ8kn0
         xvZixyQHyoiVGRCkTLMWgKXVM2U6tyUMf8O+wTAoiaGy+Q0s/VOEDtoHiO6BGWQB6+0q
         6MNokqpWGa+Bixjl5ZxHtpdj0bCfiqSfl6eeLWnHM/KwMfEqWh0zCkqUD0wJ/JgULZl3
         W3S8P4PW0pWYiMvC3LIclxBYSgZExXqltlultgjLElKVbvyhDID+1fTaKlBDA9fTJqU1
         CBqN8nfn3e0F8IKRiBnvrl1YhZPUYWrbnDSR6CeWgkD4SC3CBW+oF3AAe7887BiBNDxR
         /VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693826; x=1780298626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oKgspdXMIsoQuyBhv4V3z/r/gtDk0V0FyCighFRfYc=;
        b=CIKRcxmbxgzNJnwWaYNvfs6OpZcgEcrGHTClygW4hbWMKGnu5YOpjVebLEKbju8TXO
         9sadkaKCB0+CjKZxpQXQfRiM+oR0vvlpbZdQKgY2LuxiMNoXDSvq1PllS14SmkGVUOXx
         XF5kXLziuuG+1XLcgvRqcpb8xI2WfJEcA3pf5Xz2drVKe8GzqM0mol0oeBv+WFjfQFbr
         U3r5VNwPUF6sgo6hhe9XCjT0d4u2X6xMW3dg2+f9F6grx0wnDbjnQBgFgg9O0RogqBiz
         owyCXdA3YSWAn5K5fkVkJPzwpTjMhqzDIbYfyHK4nSh8SGu1cfnE4jFxvmigetssyn/u
         QGiw==
X-Forwarded-Encrypted: i=1; AFNElJ/6zjw2ls351U9m0F67TZyKhVU5LKUOEncTHlBwqDD7UGz1ShE628Dd9jKqZxgaHZzB0Imvdys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfiJxZ0K+YHAGn0qXBy/2NTB0J8Zn0hEGFDIHzefnv1OxUTEmx
	nDj7LYSs4me5Oze5LT/HbmiPL2SZQShiFVqphlazC1QMbb12cki6MVVQpyWW8Bm0wX0=
X-Gm-Gg: Acq92OGmcgLCHZLW0+Zo4fysPmPjrwxIn4q4R12Y8N17UHmMUAsJEkzUiIdD+ZoVNvj
	X+/oM01tbuuJ10TC0U88ZJQjTTjwsv8LXVg9C/fvumA7/ONUsrSJCU0KPXw4NUwZ7DuSzoylbO9
	Lmjwn3pfFZ0lpmTB38E1kAcJsEwoAynD1ziL9nDJvi9GiAHPc6L50OurIiM90mzxBPoFJWBfGuI
	flvaIQk4eYuCqrnMP9wm/cDW/6/UeX/6lp+UQt7FfdnFOkXMjCvnZCE/96mrJjiNKU+74+91mhl
	Gi6jsYLnmaWD617yUWfWzd3umRrA6EVzTyYII8UYwlV1cD8gLRECrHPQCmb/tg85yrCbRDmKp0U
	87UOuYfkzM/z9lrfzLMo60BrPMvVvtDLhtcuqz3YtmDvjPTMR/4X0urYhIpLaAyVoom5v1IrfiF
	ZeXGnDJasQvm/V/vhviFn/TlQh3oCYrIFti5SQjmTBx7HSL0WoD9d1aSIXxT4jydAVSD1/k7fTi
	sf9wi7Nz/bFlmplQzHfVRIDuXshFUihnMbzhiX4/p5Ve/LzYAFLXd08YQjA6PFl3eCMVqUfBtCe
	hVE2
X-Received: by 2002:a05:6000:2384:b0:45e:8526:7dc8 with SMTP id ffacd0b85a97d-45eb39e1ea2mr22077567f8f.25.1779693826624;
        Mon, 25 May 2026 00:23:46 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm25062109f8f.35.2026.05.25.00.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:23:46 -0700 (PDT)
Message-ID: <dc0c1bff-2d1a-4863-a22b-29d14a73361e@suse.com>
Date: Mon, 25 May 2026 09:23:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] params: bound array element output to the caller's
 page buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Daniel Gomez <da.gomez@samsung.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
 <20260507082103.94473-1-pengpeng@iscas.ac.cn>
 <5bfa28de-9d37-45c2-8c0f-e93b36119910@suse.com>
 <20260521022854.38938-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521022854.38938-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[samsung.com,google.com,kernel.org,atomlin.com,yandex.ru,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254100-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 3DC2F5C71A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/21/26 4:28 AM, Pengpeng Hou wrote:
> Hi Petr,
> 
> You're right, that changelog bullet was misleading.
> 
> v1 already broke out of the loop once off reached PAGE_SIZE - 1, so it
> would not enter another iteration with no remaining byte in the caller's
> page buffer.
> 
> The v2 change was narrower: after the element getter returns, it clamps
> the number of bytes to copy and only rewrites the previous '\n' separator
> when that clamped length is non-zero. That avoids turning the previous
> separator into ',' when the next element contributes no visible bytes
> after clamping, or if a getter returns 0.

The updated code in v2 looks as follows:

	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
		p.arg = arr->elem + arr->elemsize * i;
		check_kparam_locked(p.mod);
		ret = arr->ops->get(elem_buf, &p);
		if (ret < 0)
			goto out;
		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
		if (!ret)
			break;
		/* Replace the previous element's trailing newline with a comma. */
		if (i)
			buffer[off - 1] = ',';
		memcpy(buffer + off, elem_buf, ret);
		off += ret;
		if (off == PAGE_SIZE - 1)
			break;
	}

The clamping is done by:

ret = min(ret, (int)(PAGE_SIZE - 1 - off));

My understanding is that the expression '(int)(PAGE_SIZE - 1 - off)'
cannot return 0 because otherwise the loop would have already broken out
in the previous iteration due to the final check
'if (off == PAGE_SIZE - 1)'.

The input ret value to the min() calculation comes from the
arr->ops->get() call. The kernel_param_ops::get() API requires the
resulting string to be terminated by '\n', so on success the call should
never return 0. Even if it does and we want to make param_array_get()
tighter, I believe it should be treated as an error rather than silently
returning success from this function.

-- 
Thanks,
Petr


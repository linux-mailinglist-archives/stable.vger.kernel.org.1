Return-Path: <stable+bounces-244023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG6pKsi0+WnUAwMAu9opvQ
	(envelope-from <stable+bounces-244023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DF4C95A3
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C058230A36C5
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC203CAE7F;
	Tue,  5 May 2026 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FiR73vwA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228C3BE642
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972119; cv=none; b=GovksAWQSGcHFTqjTcg3gOp8BQrzZN077dG0YGRuc9N6DeNAoSZSqpO+OQs5A7JI76LGdbictOyh7OhDll4CKN+Jmfx3KOZPIWaIbtT8vV/rMIa+cQPZFWRT/1fQcs3GGbAWxiCasm+liQ/WBLtfD5g3kfk/NehKMU5eVE9jJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972119; c=relaxed/simple;
	bh=FKzoJS1xv1NkqT8U1fhWihrr6JTRLOABJ/Ea5KN2gZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9TbWanfghVsL/YprnLitIc96OYoZR+KNxF4tWdgD4buC6vUBtOFOX8unQLbVfEsQpZCncKeL4szsBvkq8hnAmxQh6dBiUM43PZl8TnVGX0JwkZYNLnVe/IMix8PzdCbfYKJ5w6ksv2ZK6SMQE3R/9UVkztG2+6k245eG++6edk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FiR73vwA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so56304165e9.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777972117; x=1778576917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihcJvzwC+8AULKyZCgiM5obJV6JYUPrBu2+E81aaeFo=;
        b=FiR73vwAaoLLcXtTG4pFDLkk1gTC1TWgvGm+RLof+CX59FhhVfu/3BRnXRLUsgsuAk
         e6cLPQH9z2YOQkScSPKQOdQKWDWs2rVXWtSYjS5mJavpCL97bptUEQd1EXjOIEOHrOdv
         ZbcgsCP0MXGQWX90asigBZUIXkGYCt4GB5eeJQ6xCbc/XGSxdPxw3ayC8qyXLgSfDloi
         fZS2hKGEywEXE83NQhxIJhLDJOtIJzKmjzhN9R8o49TtPMj5t1Pa8VeQfZaDIU5X1zGl
         JiZT8x8SwOwevmZfnVRQDZnd8+iVhw/T7W01/C/1S1yJPrGs25AKqw3Un7pdxP8bwiQr
         c08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972117; x=1778576917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihcJvzwC+8AULKyZCgiM5obJV6JYUPrBu2+E81aaeFo=;
        b=ML6j3FaCjLDy/IFeVO+zKnT5xfqrDZJ0K3F5Vkm4WZvtJw29va66u+OWK1s9qWDXoS
         RnlQefAtoEABYmOCGz8iybgT5LIGLvdYAgQJERBid5shhly+YWmRnLdk0OB124Gl6xZW
         5/XJyufjeMipAavrN+mXhvA+3EVXy0+Nwnp/WFiYGh2hOXOL2yNfmYglFF3Fuy8UFViz
         m62exoAGopsHWbgUi2HlVT3A9XfSyW3+C1A0Z6qdrgnRej+QI6cl1RtvxHJIMu8AgSwb
         7EPblAGvLCNsCyaVEpSyVoII68mJlXHFMh5kCwVdkkLp0dg2lHSxHC4jMoiPMyW6nYaP
         j0xA==
X-Forwarded-Encrypted: i=1; AFNElJ8XjlaJy+F6nU6Nxr3XKzChFY+00wz+OP8dEdogXD+ziw6QPPgT9Gvsj4E1CvoA3TfZGQ1+ICY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqJhNGiTRGN/fiyGd3Yty3rYco3DbjZlaXS7Vm7R/9hQE+UvI
	RqJChTIrR/t0YJWFbirkdY4yoALhiOFxOCZbjbyIBcq0hSwvMtoZyr514apMsnAAyrJueDPOcLJ
	89C05Kgk=
X-Gm-Gg: AeBDies3TBm0eZIhGsd+8lmBgzE0rwOa9ibfzFr7dBsg3gIoTNNYF+ZJu2B2JIBXTko
	ojbU0Yb9aORDDPcnSTghSDiB5zci3+SFnDNse6Eqvuz/cOmasbn2wVo06AfC4XTMIsFKGBoDLhi
	nfzeNSO2U9jRatFMbfKTBOb+gGogELrK0i9VIwblYYIkwqaqVu5tFVjoct1fwhne4BUAZh88x/T
	ZHpReSCuFjxe4pC4CxIKDzC9uh+Rl93uDFZ7XG37WLu1JT0Jh/rB4W35l38iC9ED7MA2zLvgwCM
	Al//A4GhkD0TQLLHrGdRJ/LQhGKIazG1XH50qDllKKIzqLbP3GCAHPo+1QBNoFldeHV2GD1dies
	/sjzfQOhCvx79fxN0RHptnczyg/g/ihRLrqRfgbqjQUltXBLpPVKDyd2r14EU6Degby2rhAl9td
	cqAuuj4D8F00UlFUoWN2wvrPY51Z/D+adD4/2Bp6vZrLmRiWW3xidD66I=
X-Received: by 2002:a05:600c:35c6:b0:48a:93d2:609b with SMTP id 5b1f17b1804b1-48a9867a95bmr248370985e9.28.1777972116959;
        Tue, 05 May 2026 02:08:36 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d177029a7sm18348415e9.6.2026.05.05.02.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:08:36 -0700 (PDT)
Message-ID: <0a499707-c666-4f37-9f54-cbd439ea74df@suse.com>
Date: Tue, 5 May 2026 11:08:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: bound array element output to the caller's page
 buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Daniel Gomez <da.gomez@samsung.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4C4DF4C95A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_CC(0.00)[samsung.com,google.com,kernel.org,atomlin.com,yandex.ru,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244023-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:email]

On 4/17/26 9:50 AM, Pengpeng Hou wrote:
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.
> 
> Fixes: 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than get and set fns directly")

I'm not sure how this commit is relevant. It looks to me the issue was
introduced pre-Git by "[PATCH] module parameter array fixes":

https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=206a70f22b5fc94e58a7e75f1d4bce1215c24ad7

> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

As mentioned in my previous reply, I think it would be good to look into
making kernel_param_ops::get() take a size argument as well. However,
this patch looks reasonable to me as a minimal fix. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr


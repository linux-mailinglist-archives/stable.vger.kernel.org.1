Return-Path: <stable+bounces-249776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NRdEXhqDWqHxAUAu9opvQ
	(envelope-from <stable+bounces-249776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:02:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A356D5894DE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AD59304E400
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6236494F;
	Wed, 20 May 2026 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7ih3YVH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8F376A13
	for <stable@vger.kernel.org>; Wed, 20 May 2026 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263677; cv=none; b=lJqWEGUwXzGvaftW0RP1m6C97fsvvUmWuRP7503rdAErZoxk5cotz/qOmsAtXtIjWFp6F9algjT7tT6BiESM3spvMhpWrFNKOmIu4F9QvR/j0BfOdA1Rnq3IiO0zsE+Wbo1QU0Ig9iduRORVhqWqr0PPl+xjxK8rL6AWkEm+B1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263677; c=relaxed/simple;
	bh=qAh1VLAJGnsgqquDAhS+FfRurgPmqKRM0FABdJ7PnCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVtAbhMQ6EedM/xIbwy0V4gJSRfWYOt4Sbl3So9mi9e703L+p73V6+pMGn4TQgYOL+XUM2HglskT+PcV1WIWt0rS/SHLIuA10rMIxZubHYbQFugI0j/DkRR1ZVJYz6SaYy05MgkvnOJuaZQEc8ttkSl6+OLaQV+lV4DWi4ViGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7ih3YVH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8413ac3d82fso204992b3a.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779263673; x=1779868473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jw4GyRnL2M4P8CKjQW6uXBwJzV1CCa+rVhOUr7kFD7M=;
        b=E7ih3YVHa7B8ZfaTjL0NNSj6GH7Rr8JPLGsMlpakqHtWB5Rxvrp+2dn7pAhxIREw/3
         6QKJKBB4G528T5ayx/budGVPJyFLCvSVKTi4Ki8iEFogiBAYukt9VGYYhja5O2ikA9Fx
         CaAlZup5iB/W9hy6Oc9yltkPVQSBMbdIBnimJBh5JHA2rzaiLErUOwQSMoh/DWt7g4S3
         Vh7eurzStHO6LrgHLGhavdUA9QO00jjbjeGgjRAhT8xRikbHVucSUITGltzoWlaFgMlu
         cjGfldmKNhMwBvwJlrEOa9MA2KivM5YiILgyoexJCUzcxQsqOgqWIQfnXzBfQBx944A4
         ewig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263673; x=1779868473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jw4GyRnL2M4P8CKjQW6uXBwJzV1CCa+rVhOUr7kFD7M=;
        b=aLdUvqyDvK0WxqLGYFrAjhlwO7ss180Q0Ua3Dc2+o9Qm27GfyZB300NBlgpedl3kQ9
         ImnK0eaIugsXtOFJ6rPREnE/NS7StwQcQJ18dZ/NGlLyzviOG+6eEQJ/YHFEDVR1RZ2L
         qNp92SVpyLaid2F9H6+cdD48mTMiRHA/PpdYwN/QINUbDgBpBiXh0epdyx8ryfpYN9Ez
         UyMw3xvCr7VoAhYfmUUWf3uX1oRJYbNV/QGIjEdW+BEQnKFV/bN1NQo504S68YhXm2yn
         RHD6rhdSxtqa4HvINf3HwUR3S8WOn1znVuNHC68nX5vKu4sOvfhwd6PzvZfMTSrMFjg0
         lmHg==
X-Forwarded-Encrypted: i=1; AFNElJ9VtKaEpbRHPI8oORLn7yKAAfsMziVbVpp6d/NnyW3nZPqPXSFh4icAf38j9thOchYZCtg/XtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEjbCPDekYVAc5MV7XiLIlxA8A9A2xzDsfYe0KYlp2RFVHSBA
	rG5OpZa3BJAFkXInLMhMPZnPdH7fqaqdY7R5ciYM6mGX9feC/6lAEv6EYWLtrmXlCHVAQCyjV0R
	ZWRAA
X-Gm-Gg: Acq92OHzdIwpVU50nTfmOeID7WfqB6rOAiWCM3FIMYt7ZV4bU8O0VgZBxAcU9+/PZnb
	FuUGLB5NGRY7CpQgV20uQTIf0QFEgMoP7/uJMThBkR0Tu3PRS5mq3ezvwIlja8HlJykGiTD4C5o
	hSXmlkiiqlowiBxJJZABM1KZMK8+SR/Iau4+AOCAZEE9xTf647N7W8J+N92AOMZ3FjaGlx/lvKi
	BdjjhOKVSrsN216SNcbCu4JDmDuhn+IryF18XFtUbOjgKldKEItn+9krEmQ7hHFa9qMiUmmRAY7
	QhvkwaJbmenWTaU/WeV/5q8vz0Xn5Kza94uadWMbPX93pE0YJKhj8APt58850roqLahlepxxTzF
	jnRUEP+YRS6bFX4a2O6X3djYEhD2L9d/xhvuTKOExZEz3n6pZqXwKp2nXLrJOO+PCyrOkBs9lvv
	17NSWY4quu7EC66pgrO83xhDU=
X-Received: by 2002:a05:6a00:299a:b0:82f:6e9:d1ba with SMTP id d2e1a72fcca58-83f33df4581mr24179421b3a.37.1779263673292;
        Wed, 20 May 2026 00:54:33 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f63bb986dsm9950186b3a.48.2026.05.20.00.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:54:32 -0700 (PDT)
Date: Wed, 20 May 2026 13:24:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jcalligeros99@gmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] OPP: of: Fix potential memory leak in
 opp_parse_supplies()
Message-ID: <lr5bp3ndh535rwmfx4p7toyclzhibn22m4e6s2zg7527lhegwf@cnwfq26flerm>
References: <20260511064213.33638-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511064213.33638-1-nihaal@cse.iitm.ac.in>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249776-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim,iitm.ac.in:email]
X-Rspamd-Queue-Id: A356D5894DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 11-05-26, 12:12, Abdun Nihaal wrote:
> The memory allocated for microvolt, microamp and microwatt is not freed
> in one of the paths in opp_parse_supplies() which returns directly.
> Fix that by adding a goto to the error unwind ladder.
> 
> Fixes: 2eedf62e66c2 ("OPP: decouple dt properties in opp_parse_supplies()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/opp/of.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh


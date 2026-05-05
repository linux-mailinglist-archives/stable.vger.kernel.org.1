Return-Path: <stable+bounces-243965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIw6EjJ7+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:08:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E064C6B87
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21633028364
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B613BED19;
	Tue,  5 May 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IV8VDwjn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5433B3BF5
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957649; cv=none; b=MefTLcD2ELx9OPIHD6JQNJ/W+CEyg1SRRjC4n1XiN7+zpXz5vFe5IiALnHlOxkHubH4kaN1fSX8LnHR/YNjytNeM4HDxW50u6RvkJMNDch363gAapAtGVW/oTDILlt0OcAlmITRunKpgvsmisaBboG5lhurjF001rtiZrPhb/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957649; c=relaxed/simple;
	bh=XCLbQaX5H0q4NgbXR5hov/vTvjqu4THP1s6uQDct1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArRbw9sm9XGy7TNTI8dVxb5GMp+jAOeRLVXQU7oXL865XhUFcdKpYbAwY+0t1sWz7iLRYD++sSAscff+UrZ+vdZO0Bjz9V+G6XjGW/NcPcE2+AT+6Yv9udTwrzyXARD4tQIH4oce0l4qdchOPEarTZZBBykA19GTSH2CYYlq1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IV8VDwjn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c822652f82aso1037794a12.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777957646; x=1778562446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H2vQvv4FtjvUNTqA39aikDyJ0rYrZTr9y6osRy+CkrA=;
        b=IV8VDwjnu4Bt28L6QERQESMwo708Ke8a3JWp1ygRXygoSCrzHoD0COGJYg4ObE5SXx
         hgL9wqbe6lInYRDis5GiOJYOm6tPLM2mV6xoDux9ucvOBfEsGX7ni7cF7QAh3N0FiZP9
         Lho/AbULskQh6SRmYO2KJSdY13Gf22jhKUpSFor81+D7skT6E45BRSrB23bBd0KX+04Y
         kTlTLq9fozKptyCLUAXYbUCPJrT1uHImVBQ5pjP/PDvjCiPoLqV4bV4C8Y0g2gZJ3LzJ
         L7LbKugHOUFAA9EE4kvjq3qQRnq80CkNCyusaKv1etd+fJEM7hircIg13MMolCLLcW/0
         ZW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957646; x=1778562446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2vQvv4FtjvUNTqA39aikDyJ0rYrZTr9y6osRy+CkrA=;
        b=mmVtKES/B3oLXlRbqtAyul2vN4tKsd7DIekDzI/hKCiruljV+MlGceoxoXQ4SsTUxJ
         tC1f8jVmW6D0aGv73gw+sQAZ4uC+fcLpmYWv/+FcwdRNUUeItjGnN10RekE3VsLwsb15
         nKVabhzpdmWCiznS14+AFCYPT/6rBCIbMIaIIQ1wEUqj6iOujc19Mqci69/6hC0gHUlF
         6szL5buNk7RUsrhVbY/gWuccfy5dkHDtq0scNe0mvYZXuA3yDgJcBpF/jCvagBmtIJE2
         NW2pQJMyQLchj9XQ6HA6sz80IR0u9xThfx3i6a+VGTzAoTNhoWWd3UmKZQr+0llGZ0gf
         Dezw==
X-Forwarded-Encrypted: i=1; AFNElJ/gpnGi5SZzrLBm1+WDdAsL58mRccWihwb89P66JGyK8hFN2QlTFyXiqiWMPlwU6U/7vRSOv9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2oXxx0YAHps8lOa/AgZ2Sqtk58ln4iFChX/8XXT4KEab5JirD
	s1C1pBeLKCdPmhNhtqqB4kg7AhsZ8IDiFYPi811Xizx805t7aoTzAV06/lhgNl0GBjM=
X-Gm-Gg: AeBDieuDad+6AcIRJQjIxTdDS0umbT3T+YOj7CWZQbaE86f/bQgEPaCvQYQVrq7ek3y
	ffmNAq47VEbJNbBF5/fl/e/E6p5dKmQfb6WOxM6oUfiy8yORCmX0hOzMNtSNhjm7NHXjvQmLpwP
	78O651yVNncNapaX0IHZhkIt9+T8pMNZZUVAPqmNLwSpgR2vq6qyj4Axf5P058OFZCphlxwRBax
	5nyo78a/9S/8DAccultqZRop/cyHH4U4rHQuVYcQdRRZ7PPnkcsjPOiN8K5ow4APLUAP6NArr0V
	Jv/oQgxNhJm4dtzIkCzZwbLRzWjJxlmnC9sRFsZc3PdfhpNJRJVs48SM0XOcfVP7u+c00lzjKpQ
	82XlAb2iRty9MXsdmEhCAcgg+ioEzDyeODWWC7HdFHLf90eVIUIIB+qgcAwUOWyKllBmScLG7UU
	5AdKTMazNPW5Hr9y37wBbvkzcXT4OsDGNq8g==
X-Received: by 2002:a05:6a21:6d95:b0:39b:dc44:eceb with SMTP id adf61e73a8af0-3a7f1c85643mr13796001637.42.1777957646203;
        Mon, 04 May 2026 22:07:26 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f0efsm11251801a12.18.2026.05.04.22.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:07:25 -0700 (PDT)
Date: Tue, 5 May 2026 10:37:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free
Message-ID: <5xk7uk6jhpcdsrryi4agn4apcjdbzzkntz5ie3x4675kxeuur7@22ue7vhgq6i3>
References: <20260501190005.504962-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501190005.504962-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: A2E064C6B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243965-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qcom_cpufreq.data:url,linaro.org:dkim]

On 02-05-26, 03:00, Guangshuo Li wrote:
> qcom_cpufreq.data is allocated with devm_kzalloc() in probe() as an
> array of per-domain data. qcom_cpufreq_hw_cpu_init() stores a pointer to
> one element of this array in policy->driver_data.
> 
> qcom_cpufreq_hw_cpu_exit() currently calls kfree() on policy->driver_data.
> This is not valid because the memory is devm-managed. For the first
> domain, this can free the devm-managed allocation while the devres entry
> is still active, leading to a possible double free when the platform
> device is later detached. For other domains, the pointer may refer to an
> element inside the array rather than the allocation base.
> 
> Remove the kfree(data) call and let devres release qcom_cpufreq.data.
> 
> This issue was found by a static analysis tool I am developing.
> 
> Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 1 -
>  1 file changed, 1 deletion(-)

Applied. Thanks.

-- 
viresh


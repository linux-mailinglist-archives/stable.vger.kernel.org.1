Return-Path: <stable+bounces-206351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3DDD03215
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5CFD30019C4
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75AE4D2AED;
	Thu,  8 Jan 2026 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="eZX9Gh7+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDA4CB3B3
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879581; cv=none; b=QD98A4SQMIEitxcV9Zx5gI9oYNfWE86OT3sXeADn4D5KUGFRxWPjyIr4SX7ng/lE92ta80gQ8vj3rHv8FCQebmEgv+LhCULVi2Tuu4F0GXbBW4ygyZz/R9PPIbSceUPgO7OFlcE6J/dkgYOBRmEuSUTk/nrhoZkjXJP8wGjaYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879581; c=relaxed/simple;
	bh=UNMSDhsW/egOUAldbBDtMDmEjuNG0Edocj6N0SSmz0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUjSfzjJWZ4J/8ZKQRtpw3+Il2QXNSzwOiG+xePjs1q/s/N/BM6l8j8ojNokBNUhHmyO9ASoQC5drM3hRswvHfksnYBBmwdeBWPr5xEMl1EgaVv7N/4fUf+StyGFxCLYi0OS/DSf0ok5ptnVpKH2W2It706mrVWKeB0vUZu6Mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=eZX9Gh7+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a2bff5f774so8615775ad.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 05:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1767879579; x=1768484379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GHhYdpR7V8zZlwM3eTsC01NbGzT6JFmZY6i1ixPREY=;
        b=eZX9Gh7+w49FSF81vkrr7tXNcDn+NuL0jmoBQy1YNQMZj06KWJrjsbV1uTW1e9ok9V
         3zbYw/Zi7YED9rRrojIL3bRumUhGnddxSME/T2uxKhnb8dbBU+zoY1QyGyJi5Q2jjKZX
         sS5IQg2o//395/WGItwiN11awlVCpvq1f3W25RUqy7veuSnYp6+nZT2tGrzPndw9rQ9c
         oRHFYhrJaGg9DFOF9aw5LhOxOLWN1VxXbvSFmlwo88eimDy2Hm+yoivnwQi9nr8JtlQO
         UCFZIyuta64SL0zdw5pH9Rn6mpL7PGrYHHtPFIzW0R1Xpn81zpGHN9Go8KcpnWQV8zf5
         R1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879579; x=1768484379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GHhYdpR7V8zZlwM3eTsC01NbGzT6JFmZY6i1ixPREY=;
        b=nXdMshrh4Zwex7mZ3voW7nvjn/QyYqM7HsTH1OOUBWWlYJvqdf69lOhVj9qhuICF5I
         f/a8ULQF5bc1yCDtTZu+8SLN9fd2WJWi2HE8UvnNiDbaRGJRucquU1k27/GTC2tETs67
         lAyeoBE0WF43H1h+B5W7yUmVGT81C9hCzmZhyeZL111Dgrybtkvxyyo2myKDK1kK7a2R
         XQqvmsoIlUWbhmkAst5WHAWjUDaWuLRJgQLRy2DfEScFjv2d8zFsO5/wsUDDjahQhcTa
         fRd60aHufVSbT+I78G05646c+YW/NS8zs3xV9kenNtZ3yLAxZEj03UB4houETD0P+XUF
         1IhA==
X-Forwarded-Encrypted: i=1; AJvYcCUFm+6S8iwPbq9+INgqRt+tbZ77GaLD+0qhI1zrxeVKjjBYWx1Vk1MJNrpD52fGE6KuV9bh7Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06N/VWnEyUdLH2+Ryc4cleC3BD5N0KAFyH8wWpGfwilzAxpO0
	Bm+Nd9uDDR0d6+hM3owpKjhJxXEhD14bTRloOXCG2P5GUC2GhrHa9wXWqMYzGXQIYpw=
X-Gm-Gg: AY/fxX4Q7hu7Dr1wiBW1ullqBmyfAQ2QhpMwd1S0taL1EBOqjoTSCjtOGJGThsjHVHV
	uXb/YRiKIa7BBRiycjzb+6a/0P1wMFZ+B5X59cmHSWtZ72GRQEPioJLzl22NHT6UASN8pAKxejp
	rez/UhHak/lmwNIlYXg+p7VOitGdUSEWhpvq97IMlZQhWyq/0eEy0obipxBhL4yPbu4peBooAD+
	rG9Wc9dNF998kpAHbaqaaWH4mh4L9gejDnRJhwBMDLU7SfohgLqx2L9ije4+4Wln+pv2X3oLNyy
	gvu5LbUfrqZcbgJInKmcUyYFIGFyWc09O5gyoCjYcHQA1IQG06hihLyw3bRw4TMzNn2laIZIUKq
	KNnXfDScziqvMgxiDDgE+eK8jN2E6FREii1EZu3MbIhw8Eh9pdwqOT46msZwCHMr5dxSi0/aP9i
	wn8HhrfepPz/c1
X-Google-Smtp-Source: AGHT+IFY5CMv9JNbTut+rJZkqAvSsXhd9YTo4o2zYmRo3eELWLHqTa8Gz4ZgjeXAHX7j+60ZKHIcsA==
X-Received: by 2002:a17:903:4b24:b0:295:745a:800a with SMTP id d9443c01a7336-2a3ee42589amr43889185ad.2.1767879579058;
        Thu, 08 Jan 2026 05:39:39 -0800 (PST)
Received: from [10.0.0.178] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c47390sm80110855ad.25.2026.01.08.05.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 05:39:38 -0800 (PST)
Message-ID: <65110c51-1f47-4382-ac92-518c7f157a06@shenghaoyang.info>
Date: Thu, 8 Jan 2026 21:39:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/gud: fix NULL fb and crtc dereferences on USB
 disconnect
To: Thomas Zimmermann <tzimmermann@suse.de>, Ruben Wauters
 <rubenru09@aol.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251231055039.44266-1-me@shenghaoyang.info>
 <28c39f1979452b24ddde4de97e60ca721334eb49.camel@aol.com>
 <938b5e8e-b849-4d12-8ee2-98312094fc1e@shenghaoyang.info>
 <571d40f4d3150e61dfb5d2beccdf5c40f3b5be2c.camel@aol.com>
 <c6324a66-5886-4fbb-ba7b-fc7782c0f790@suse.de>
 <229b5608222595bc69e7ca86509086a14501b2f7.camel@aol.com>
 <8929ff0f-c2e0-49e6-a0ce-c4b0dcebae99@suse.de>
Content-Language: en-US
From: Shenghao Yang <me@shenghaoyang.info>
In-Reply-To: <8929ff0f-c2e0-49e6-a0ce-c4b0dcebae99@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ruben, Thomas,

On 7/1/26 23:56, Thomas Zimmermann wrote:

> 
> No worries, DRM semantics can be murky. This is one of the cases that is impossible to know unless you came across a patch like this one.
> 
> Best regards
> Thomas
> 
>>> I think the patch is fine and IIRC we have similar logic in other drivers.
>> Reviewed-by: Ruben Wauters <rubenru09@aol.com>
>>
>> I believe Shenghao mentioned another oops that is present? if so it may
>> be best to submit that in a separate patch rather than a v2 of this
>> one.
>>
>> Ruben


Thanks both! I'll split the patch for the second oops.

Shenghao


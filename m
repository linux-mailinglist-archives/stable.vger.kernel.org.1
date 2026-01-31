Return-Path: <stable+bounces-212947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BrSI0UnfmmLWAIAu9opvQ
	(envelope-from <stable+bounces-212947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:01:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9198C2DDD
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B44302D5D0
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53057335073;
	Sat, 31 Jan 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ovZxhndc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A702D3231
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769875261; cv=none; b=XAxPXQTRZOdVsAseMriyn9IsTArJq2kcxgZq9ZPbmFwaeraDoRvGEyI6fVKSSlCpnAfhIeCfUAPLoE1luLXXEyDcO1ICfzwuHyq8irlXCGH7T+SaMekp59SuaLQBBch5o9zZWQrAOyr7eiMscdyb8SrmiEufkCjTj7StzCUHEao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769875261; c=relaxed/simple;
	bh=yejpOMXPzkPs1BTMWVwwoFRdN1K7aZPHm5sr49+HsXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lI6ikivTdmB4HJYr4U+cTFLkOBNlZ+S8vRgalJwI8e7oMrhjQqHyPnS+/gXkIbaMCR91XPvE6k+aG5GSgr4iWISSH3PJBt4iQShgZ9mfzChIlfhaCrkJ/N3FjSZjAafUZs3j5cFN3uMkRtqTeusoejzdkZ1apoQOcxRaTf4aAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ovZxhndc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so530897266b.1
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769875258; x=1770480058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJLogjaQIREWDYxPFSLJELLqjbCy21hgcIev5TDCa9s=;
        b=ovZxhndcN0ayhxIif4/KUa8P2F95O9ZGJ09txMKVJ4wWnIUfzXDyxKsa+69VpHTokC
         S8j3b1TnNjCNcH+4q6rXMtHrUp4KO4xWOA5xyzv9+fkZIJyXkYl5HNir6CO9JRUqlwDR
         V0eRHRL0uk0hMODh5+dIpysOlw84RJshLxVGKmBzZnxryI2pUF+cAZsMj0cz98otbm0F
         aFD1+f2sY5Uf9TWoYpHlmPLWqCJ+T24z7CzxAPPydA6ITIx8FHxPnElJYWnQ8UlnCaD5
         lJQ9Gw6k023beQcg6K1Gonk6ZMjA1qAWrFb9LdEAafSKqgnCRIePd5vXQCD0arzBuXBh
         4gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769875258; x=1770480058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJLogjaQIREWDYxPFSLJELLqjbCy21hgcIev5TDCa9s=;
        b=fPTmQ4+9MTIJL44JUg3BrhHx9z4Gx4x7aBmndjs76C/2+Hui8Q7Ia7QCOKbF/hsc1L
         n5mFVtcMHoW6VgT6BFwk58lxfyc7W8Vij6FgMK8wjaXoG5nrFzePuBhoCjC2Uummx7LG
         ISo3xyZUxdOtPNHN4VbPzYhuJ7ds0wyeDYDul54jSmgvDElaRZmTdmW8zJxMo39UZzzG
         8wkSa/2xSRpx5NxYBjy1pKcMCKlAKWMY8pPwvNoXfohyPWW4k8trZempekWOCh7kbE5U
         4XSrqcBhBB8nZq1z276iZcnOukNpDyGZyByxhbXypSVqjqGR54kdu85O6ulAWXkDUGeK
         fDOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv6dcVk8PjOdhLCz0MJ0sIIKJnGy4VWGd1yq83Q2tjRYjoHt14nOLbfAetSC4FSBzm4dTwsDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqP7I3RkWDAk/e0G7OBa420ZYiRzoMrKE/lm2yC8n77DnOAuo
	ABdEIwDl2PyRnOpB5LrOkBBiVTHDf6JLFBVc2VkPeAxDoRKDVkpCa4gMWhWW+ZgdZZA=
X-Gm-Gg: AZuq6aJVyhQ/5Dg3z+mnPzFzfArEtJO9Cqj4HxYD6owwBvaYBvNTYJTmeckgL6dOVUr
	MDmwkj7j0f8arIEv5EAOpWz9wrlSwkCWaELGdVdxPTah5wYjYp1mgafflR6RS7EWECtw7pWih27
	XbWx7WbT5mk8wzVASSVdOsawLC3OJzqz9QLHnxp6/9gTZMwfpH0a9TTuTRj/KLzqAcFZh75YMIj
	931QX01TFqR2RY3uIr61I8jM7u9YL9cuOlkNqCzg5fS2Mgx1yzOw4o02uGKPoFRVfitelV5IijV
	CH3Xt8Jso7wxX/FKuNrfznL+Z0JjeNTGeKjXFZNxoL1bLUbagbC3BIWC3jnd7KJuzP9/NVjI/fk
	Pyf8Qp9kGmV9jEQiwr2KopVKp5fm9t0ypA0qQEZ9kDfXl7esgaEAi7SzUF+YjvSWHZRKBe7KTa6
	unFh4W3xIye203wA7gJFb07CEzyaQN
X-Received: by 2002:a17:907:96a5:b0:b88:5bd7:63b0 with SMTP id a640c23a62f3a-b8dff5af70amr373554666b.11.1769875257922;
        Sat, 31 Jan 2026 08:00:57 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf183f2bsm587629966b.32.2026.01.31.08.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 08:00:57 -0800 (PST)
Message-ID: <a7d42750-276a-4348-802e-30cfa4ad3a81@tuxon.dev>
Date: Sat, 31 Jan 2026 18:00:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/19] nvmem: microchip-otpc: Fix swapped 'sleep' and
 'timeout' parameters
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 stable@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260120143759.904013-1-ada@thorsis.com>
 <20260120154502.1280938-1-ada@thorsis.com>
 <20260120154502.1280938-5-ada@thorsis.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260120154502.1280938-5-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-212947-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[thorsis.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:email,tuxon.dev:dkim,tuxon.dev:mid]
X-Rspamd-Queue-Id: A9198C2DDD
X-Rspamd-Action: no action



On 1/20/26 17:44, Alexander Dahl wrote:
> Makes no sense to have a timeout shorter than the sleep time, it would
> run into timeout right after the first sleep already.
> While at it, use a more specific macro instead of the generic one, which
> does exactly the same, but needs less parameters.
> 
> Fixes: 98830350d3fc ("nvmem: microchip-otpc: add support")
> Cc:stable@vger.kernel.org
> Signed-off-by: Alexander Dahl<ada@thorsis.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>


Return-Path: <stable+bounces-227838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KActHF39v2lZCgQAu9opvQ
	(envelope-from <stable+bounces-227838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:31:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6EC2E9AD4
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B7753011BFB
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49D363C47;
	Sun, 22 Mar 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eJKoAS44"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D45A363C6B
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189781; cv=none; b=d5uRVIP6I/D+9EB8RLrjFbBEPZtAXMsrSPan8XA4H1x/lyLTJER1STUL6dCH3i8+F26XGmAvXE3xoWNh8sGcXZA4xmwmsgi4Pl+CDYEez6J/X4xo8bGJJy18d7hlq7D6rDnwJ8FaCK9klS5fKg//QO/rh2yQ2zEgVClVRqEU5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189781; c=relaxed/simple;
	bh=DHiLsipr4skFAI+dJq2lPNkENskIRoxGBtjbvilllQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHfUy1pLAKDuxryi2Ag/hiCVGIfPtrU+v8cqJY0r60VC17TFiDxpdWHnqLuuDJKAjVadPe/DBEVjC+FXy5JnSOhGPF1IHc9aKCHj7bL+7Tcyt7QBHEYWahBy2NFzaFHwKwUDQ+hdA60dsio7D40lFOYKUxdlRai4BiBkFaFZ4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eJKoAS44; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-46708149af2so2021721b6e.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774189778; x=1774794578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj7ZP+p/L2RJvrz7ry3hoB/fyFvBi0CD/xL/gfPc3sw=;
        b=eJKoAS44s/4R1MiBBfNxH7IW1vC5PV/uGmFgPJqqx6X6wX2aB0VogrrLKaUj5Usc8A
         BKHtDYO4HGN7+dEikHy/vrid/RMPCHz+0TMPRMBhAKwL941vSHKChWhqCclp9P+xvFMC
         YTI21LLuHjEewtKU3lSJjC1GGqi+re+r6oA1ePHKFzea3zGOSNfI/aFrXRRs/m91HqBU
         GanHBwuBsP+uS/K3wiU2RtZb7J6LEH2C01eSUNza/U+iQDB1ubJJCkiRCPL7lRNOwx4s
         uDrmhH/6QlVY1hrCQPphPwvDNtQGljM6w+hamrvHDxN/M/Ar7kBmjm3W8/7WkhuUdvzK
         3C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189778; x=1774794578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lj7ZP+p/L2RJvrz7ry3hoB/fyFvBi0CD/xL/gfPc3sw=;
        b=ivAiwiHTbBu94iFiUnzKHvgG1VkZXQMiLhgHr3zJAW23T3t/a7jAy8evNwqsPXJEbv
         9z9NJeaihJP0mWsagLGekXJbHH0EuwEpvdW90XIFhXVVAHVe5HVB/N/aUejjoZKkJJdd
         dgacMoY5h/4FBNtGcy4mhqV50A7vUz0+oAE7/9spjd8VRfphJYFMSNRj7jYVE7BU53kO
         d7cI87krGFnIdf8ayxvzsSy7okQbROYGA/JV7eA+bs9TZrpnZL45HncMoUCyT1KxGjtl
         gJoJboepCJ75jviT15TIVtDgz9jjSREG1SC/CSgCYI/gsw1TWOsNlZgK2Ilwj8bG42zW
         xdXA==
X-Forwarded-Encrypted: i=1; AJvYcCU/G7LnvzoLDCAYv8B46mnaQRnncE+zdWMeHrJVvx5303OgVLi2sqacG++774DbKTJYyECNKCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrL8ZdE0CAVeYpw52T9N2BNoDgb9YBmQI5ukAXnpUySFBYGRv/
	IFJFxjcCAxAUC6pj6p0AfsQ/9sGtPQZmoUE0QwtFIx0PuWZmYc/K9uz8k27ywpAITxHGPlRqpJe
	vaehx4X8=
X-Gm-Gg: ATEYQzyq6nAv1RSJXQpVUesdPLWefpCnJ6CAAERERem/fqXsikE6VSZPyektCa7CziF
	7JPflUA0yR4QxW1inSsEtzjGz3Eli4ymiaEMCDMHokgZl84SqufUPeDA/+WpzhoZ3FsNgMOKd2+
	zj1iOwt2OPT4dWcrhIkwT0VBSWhqKHwM9F4vOGENL3V44+m1qF6+735g6RjZUvu+m1HyQc2KuGm
	uTY1yQ3LPAfU2C8LncQtKiWeamtnQGk1OhPDgBv+HRN1gUQXb4Vk+GIqUXz9jZbmtPyIiO9x3rz
	kGg0NeEJPPU/a+k8BUbtoH8dtb5kVvxGVNHHVusIPmRLT8IC4znIatqW2fTzRXlwOtaLJKLG6pz
	PWLWEGgj983+syBDBx9e6gPEl+NIuTWF/xsQsaEP+gciM+dEzJe6sZKrjXK9bwgwpO2y4PbdKfQ
	Ug4wwJLjPBHjUGdTl66nRZTLzyN/7Xs2NkuLijEU2hHk4H7qeUtCxPsF5JcbxErebnDi5vy0tOD
	FwNLJLqKw==
X-Received: by 2002:a05:6808:22a8:b0:467:de0e:feb6 with SMTP id 5614622812f47-467e5d23aa7mr5512040b6e.11.1774189777965;
        Sun, 22 Mar 2026 07:29:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7ecc226sm5318041b6e.11.2026.03.22.07.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 07:29:36 -0700 (PDT)
Message-ID: <19ffae4b-1a53-4d5b-b641-7b429ff0199f@kernel.dk>
Date: Sun, 22 Mar 2026 08:29:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bcache: fix cached_dev.sb_bio use-after-free and crash
To: colyli@fnnas.com, axboe@kernel.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 Mingzhe Zou <mingzhe.zou@easystack.cn>, stable@vger.kernel.org
References: <20260322134102.480107-1-colyli@fnnas.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260322134102.480107-1-colyli@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-227838-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim,fnnas.com:email]
X-Rspamd-Queue-Id: CB6EC2E9AD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/22/26 7:41 AM, colyli@fnnas.com wrote:
> Change log,
> v2, fix emiail address type to stable kerenl.

Thankfully no typos in v2...

-- 
Jens Axboe


Return-Path: <stable+bounces-222463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JrfDUc7pGlnawUAu9opvQ
	(envelope-from <stable+bounces-222463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:12:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5E1CFCE5
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 14:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3871B301CFFB
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89A832AAA0;
	Sun,  1 Mar 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GHMM1UNv"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F626329378
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370731; cv=none; b=uhhDGYqQktoyFrPnAEHy0bwl+EuyG/wCw1cfq7+U9n3soiMtDHn0enksRzxouqMSggXGj68LJcz7ztHn8b+eZdXnfZTyzUYvow9kHJEcl8AC07ikD8n6IkoMTfi5ylbGvpRPiGzHgfVI3+lfNPkPJ7In70URuuNArPID94haYPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370731; c=relaxed/simple;
	bh=MlVygYZYrbscJdDC8HuuuKLYr9scb7+Jq+Fj+Bx62KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fc5P9CwYvjljN4cchX6XX3JpkP0C2bQLZhJ2D/DcKe22AwXjGFxgBhJ7VZcAouZY7USln60tG7yUboAXF7Kj0ecNHgvvWM1pUr9GLRupuPMh3UXtYNCfnRgr845uN7Gm1Dn7nOXqyQ4V15t4ewjAh5vGlukfhkihwu6WMbLTH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GHMM1UNv; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463d81452abso2167497b6e.0
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 05:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772370729; x=1772975529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCvJOMmu2bMgbLp7gSD/8r+xSOB5QJ5BacoeTPG17rI=;
        b=GHMM1UNv9Y1fX+GT8DFK3hWOs9aeyUNLO6hKLq01p59O/ecf1eFrh2gW3bggDiICb3
         DrdEgwGq6/UqKhtOrL6JJojC2rkt/pGQzBAoJvw5zFcKMOhTSDHL96VgOAXUIL1hUvqm
         S9y8oPKhCbFm2kuLfLO3C9uL3KAgFPWsrB0dngKC/0vDVWdcMRdcaxSUu4+zoRHFhCgp
         70vASeNAnQu0huOuLE4ruKB0vE3MDYy71SwDH3Kh5I6wQ9nB0+pxsDF0VX3bRxs4Cpyy
         WEOfh92y2hFIMrP5ig/SdhCeToX3VNo/wHrTLQ/0kjmWqiHJJnDsk7ak5W0Zx3RD4uAZ
         qw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772370729; x=1772975529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kCvJOMmu2bMgbLp7gSD/8r+xSOB5QJ5BacoeTPG17rI=;
        b=gtpLccxqvOrhyMr8Vz7MdRZImlmYn/SvcENO4gu86MEvnjtqi7jOcpoDqYSu0z170m
         XqSOXlxe6g9S7EfekwwXp26Y67jVXhGwe0Puiwy9TBM2eydokSA7Wlt+bFF+fvhJeISf
         Rnhw3/Zlb9c1s/JNVwkKIEdsbOIwGUKgkH4tKtG5ASVIqEUCSEPE0n4vYLL0cmSo8mz8
         FPXxTHgfAaOT+OtyhLWLYGlz8AXxuMabst+bB7jL9CZUbd/JGmxhTANGAbYHWOM25X7I
         JNL/NNcM6byaLJrN1lab6eiuTa6GZW/kM5Hest8Q3Meyq+pPsNl0tb53aMLSdu3jzvv/
         nZHg==
X-Forwarded-Encrypted: i=1; AJvYcCUn0WjhXtigqot0vWfFFGZsIxe2m+doZIGgPX/PcOS39w59LI+28UxZ78f87QRGYYFBVNg+98w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKfkmkRzrFekPEF47nOIRyF0SCpMIdaIlI60+naYivTjVevZ9
	8Mqfz1SkpQKe0tdKd+Gujo4sbvVqM+/ikWppwCMOmd/d31sd9MdBzzxhfetMdJcYaYM=
X-Gm-Gg: ATEYQzy46HQqV3pkykZOb6Qm6Wy8p7oAjsFzvuAQkHLU9cBCGpYZ1JSgerw/e7pdzhn
	246HWkqOTK2/VypzwALVGXvlNwIDZBHAiAdYgclTtnvfzGK4/orsZoRI6Et9kqC6v5piy8bQ7Vi
	OODQb1Ju7zGoSoMbo0dDf2gC65ABg6iHD7lGCwymNHmMa5ev/V1yRa5TOhf1KlXsON43mJSM8f7
	HjI73teQ7iu66Ni7mcB15HXqLWq/mBEwY/JxXIMNqn89Zl0J0o8BLOOSqJiTBJtGMcM/8C3ICkD
	QOensCxoggQfmq5HvNdknINu/VMW+IrVu5bxu5BQMq1XHfH3hUg9xsIRv1YpxAKRunnhAGUW8Yr
	ZUTzOMQhnt2xni9np+e9ue0ry3KCgWwXHVH11USf2PiqEzXPWj4OpVt9xekR4TOiOmJ7WDt/bXn
	vnqq82b0gfDnkL91pvnp2jaOyago/7/EE0bp8z/XpjRMoNWp40bzuJbv+6dHzvWqnvBNyrUR92d
	IshxiXIUg==
X-Received: by 2002:a54:468f:0:b0:45c:916b:ef9d with SMTP id 5614622812f47-464bec22928mr4190060b6e.9.1772370729194;
        Sun, 01 Mar 2026 05:12:09 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb59b66fsm5691144b6e.10.2026.03.01.05.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 05:12:08 -0800 (PST)
Message-ID: <05974693-8995-4001-a8ab-51835488bf4d@kernel.dk>
Date: Sun, 1 Mar 2026 06:12:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "io_uring/filetable: clamp alloc_hint to the
 configured alloc range" failed to apply to 6.12-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: io-uring@vger.kernel.org
References: <20260301012807.1685821-1-sashal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260301012807.1685821-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-222463-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Queue-Id: C6D5E1CFCE5
X-Rspamd-Action: no action

On 2/28/26 6:28 PM, Sasha Levin wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Same as last one, picks cleanly into current 6.12-stable branch.

-- 
Jens Axboe



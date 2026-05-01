Return-Path: <stable+bounces-242549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHpdO4Mv9WlaJQIAu9opvQ
	(envelope-from <stable+bounces-242549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:56:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5C4B01D7
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5456300FFBB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C637CD2B;
	Fri,  1 May 2026 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="NBBKfG0O"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8583036A030
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777676158; cv=none; b=PG0QaNUpruoXXBLT8kurisAThpH6IaCUoaEog5WAv1YHgFznJovvZxXasSxV9r/OjMxcRtsEwg7HuplE6dTUyylepwcoIsD9QkP9XYTdMB4wLYH8Pi0z/bYHkdWm3YGyOhOM4t95MchIAOArMceKtm1CgccWuC62K7Jgpk1y3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777676158; c=relaxed/simple;
	bh=Y5VZ8P13n27vfxj4mzevVdNouWSoeA4ah4EGtop6iVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N27ROLJTQFfnRilo2n2t7NJze9QmoLsb1GqDUpLYSb50X/W7XwVJ2RVXbP01cdALtlwl8TZY6xB/gmtUGBTEdVUTIi4V2TDlNIBWvGVhpLNVf1UkvwpLyaW2YgKzdM7xJfzrznFnGuabKEs1tqrjZuXkQO26F5r8Kl+KLeGFrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NBBKfG0O; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479d68a9062so1282739b6e.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777676155; x=1778280955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXPqeAPzzXvPq2f4I9I5gjHJ+abRxZrFUtm0T7puCUE=;
        b=NBBKfG0ONJ6fAVx5csFbMiybL89UZ1XxyplZpDCFnLKtczIG2f4c0NiwtzE0lKInmo
         cvz09flN8cFKe/CthBN/LHII6JxopHgzZ3tPdUhffF90+VGX8/RiZa6ewb3JGE87fVz/
         Beuaz+tLHxRFNNTHikrPngiVMYfQzmcYLVWG9MGE2zuA7BncmWw35tiF28f22MHQjqTJ
         HZHBP9VxwUtnM4fNvS8LbOeDK40KUhOtbgjaNTCS/fmEaxHaqYD0x46qMPJONVgaOJc9
         T4mdQfvAMzoF5xX4v4JUet8O4Ucb5pEzs8JS7wvgIwRUIzFgHI40ZeDmXRkKAVM7cWpX
         1QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777676155; x=1778280955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXPqeAPzzXvPq2f4I9I5gjHJ+abRxZrFUtm0T7puCUE=;
        b=F02CBZq52zdT2/zi6R1G6nclWQIQT9sq4KcsJCBL6ehJpmdlIxkBU06TZWZ7XmORpd
         3Hi0vVSEDqn7I256KuWkbK8jbW5YZo1I5vAFn7d7eYRxXtu2PTq0yD71/VvvSa70sbKt
         BxnmAsLRs9fW3aESN97giX8fnBkgpYfTFEg338vbZVy3cF8t0yHz1MbSLJba5j6TdHsP
         Paon8G17w2U/O22fYyHnlN2sv8O9h4PMYBEy6ZMlWx22pTbJmdsn2oFCVDj5zC0fqr2u
         MhIdtBnf8ONXuOzOCanvzRUXKNh8N+ifRW7ymFjqwfMpM7kVGnvepFOi9z59bBuGXCKz
         hnyA==
X-Forwarded-Encrypted: i=1; AFNElJ80T+IS+UH4yA80TG1VqAunUqwa9mUSRiQoq3yAzZHaoWKFhGSs9/+TU8HLO5NEeU8OA6lK4CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2d30vO3z21wDRGAd+rI30R5wCym31750Od4uGWoWZPllqzpU
	aLMwtZpSkXArLfUKvm7dyw05zxHLEHYGsUAJCupmnJv3w4tsJUoY0LfQSOPzy8+e7/GDNQ44HBA
	+/Szg
X-Gm-Gg: AeBDieueRoYUPbKi/QteeLTNUzqar1u0Rveq2AkqLNvlychC1B8ogbVixm0zRZhTNmX
	3zvoTT6AaYtmSY/YQuAv2kQVafXCKFd5DH5PVHzCPD8ObKfs4hRbzWY4KeBkQXU0qhWjIJVUWc1
	4RkOcmG48TyYUtBZg+mRpCGVdM63C3DEkVWZfS36soQK/fD+YB17Ho4kHpHd7mZSRQESCHhso+4
	LnzU5Gypg6EgiGRooT+kShjEb9mfbrDetAQt2yS0Amcm/XIdzNxIZ1dIRs/6hHW3ONtFymzKuQf
	nZ2arbuMTIoowEFkR2yoPu5JGLz6/wHbJ1XKleHomrfLboq8UDJ36M5G9Y4dypN/whciQzcb04C
	30vkXvxsrM6LuPBeGYJN8sadFRQLkvshFfQwNbxW/GIbrByr77jdIM2/1hYHJczoZkMrGdYFw0g
	8fRV1BgX58zhpYlRuMhaYrC21cUJ37k8sDZq69upND2JklAiS3bYxWg9yyGNAO+OhTr16ckpgIW
	KVWsNoNiPmRyTpEywlN
X-Received: by 2002:a05:6808:2217:b0:479:fa21:adfe with SMTP id 5614622812f47-47c88fcc194mr879368b6e.6.1777676155577;
        Fri, 01 May 2026 15:55:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca7a5e75sm2900431a34.2.2026.05.01.15.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 15:55:55 -0700 (PDT)
Message-ID: <3fcf1bf1-23fb-4e01-ac3d-6ec6fb86da08@kernel.dk>
Date: Fri, 1 May 2026 16:55:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] io_uring/poll: fix multishot recv missing EOF on
 wakeup race
To: Kai Aizen <kai.aizen.dev@gmail.com>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, io-uring@vger.kernel.org
References: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B6A5C4B01D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242549-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

First of all, I'm fine backporting these. But:

> CVE: CVE-2026-23473

How on earth is this a CVE?! That's bogus. Yes it violates application
expectations, it'll wait on a CQE it won't get, potentially. But this is
the only side effect. That is NOT a CVE. Greg, please retract that.

-- 
Jens Axboe


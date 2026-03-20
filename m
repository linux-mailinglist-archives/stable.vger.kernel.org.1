Return-Path: <stable+bounces-227601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMDKC32PvWnY+wIAu9opvQ
	(envelope-from <stable+bounces-227601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:18:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A602DF49A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3313D325BB33
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6996D3E4C74;
	Fri, 20 Mar 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y70hLfem"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544013E316E
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030251; cv=none; b=Yg863qAQcb/+w3GG52Nyl6HSlp7xzT6IZmJiwhULFSRhKZ++aJ6cuxr04sSjUSUkLnieN0pELPmAPaLsQkFnoAcMcKJig/viM1erAKZlJ3IBIRf5qWhft5s9erb6ZD04+Bz43SjDLTNqNuAsQfI8DH1158tIfFjjqGcMC8yUzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030251; c=relaxed/simple;
	bh=T9TRw8azsC2dkN8S6OQ9oK0905uGUUk7yIae6zYJS9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dx8A5H/CbFvZYDorUYZhTyVRYhM2HYm79nG7+fkikqws8Nmxg6gK1jk69Mvm2V4bS854itRTiZ0v/3TXa0kpWx8J4uS9aFo+QVttJFaTyypABa8ckQMSnt8O6ppZhqGiNGRq9g9LR9lEYaahaWbuPHwz85yCCelBlyucie8Ig1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Y70hLfem; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-67c250805ccso294301eaf.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774030245; x=1774635045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqqGlS332zgaNQIaiPZ3yWS9ehIzcAej3ll4NV1SBD8=;
        b=Y70hLfemAEmcXsfHNon9tg1ig3ye/DWNprKH4LBoKwtn3ZRssUyphbFhx/QtSGR2aX
         07MsFQ16+3/CjxxFeZi1Vs1tct5OagJWMsyUMzMTikqW0mApIIpZ5x6m0SE5IKXR0f8o
         3Jt6UhptYEleWXt5+57CbpdV2okz9NLykmCYw9UAmtkPQJHN/IA8qQqrHd7xLe3BN+CS
         b7dEOfKKpM7/nsHFClaopTm8Qu+ZduZ3nWG114C4TOUaMFK1KtnQ6/EGlzd/xoZGErd7
         ZkPUeA1iIwU4g+Cl2Sk1+xqouHg5aoXjdY22DRu9RU2XjV4AJljGEfabxEPPf1DGPNAc
         kZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030245; x=1774635045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqqGlS332zgaNQIaiPZ3yWS9ehIzcAej3ll4NV1SBD8=;
        b=oHAHiI8K5RMmkc1Q3R0B26/5+1NScHY21otYZWEHTsMarMOrUpyhiXDL1swC/Pb+E1
         IkcYA0EIxQ4IhCD1LWxFE7Zqd0c9jfwiKldyF8q3KJ4uWUWNpHyBggJiImWtktNqfua/
         f1VsSGlJdH166ZzMjzOksH2KE2LfTnMSDN5LHvdgTIdaJONqmFLLZHkFSfS1PJ539TkR
         3y6755/eWL4ADBxQUb+ikipo5w2axK/1kek+ClOaKgP5jzUGX6L8chwpDLC9XjyktKx7
         xizqf1j2FKk1I8W+h1C/5PkY6RLcgkcxnrd3UZOuZD6TdUkSD0hr3YeiYbVQik1Kom6B
         BwAw==
X-Gm-Message-State: AOJu0YzyBS81SAjZR602wgueFjnXHmWKNgWbGh0y8ZCOrP52MevpG/mq
	LWvabzUMpm6VaV9sdtaCCCNWttPCPdcNdFtsm0NVk3plGOx2qNa/xg0dUDw+Iqn+clo=
X-Gm-Gg: ATEYQzxMwcTUtnOFNtYKkL1WYrkoASJQy82VPa7iUofHmGP5fC4whE3nh8ebsAZvJL9
	PJD2gHa8TPSGZ59C0u5pRyljyZ2894r8Ods64d7HLaADiqV3Vud6NKLBdVTAtyO5VfhlO3viFHx
	YEeZ+hE+Ow2f6XCxJ0fPdTrBIcgFIa6SuYM60tJ5QsZ30agLzhupP+m/9XpA8K+yVvaijaf6K0a
	3HQ+nuzJaB3Y3jSF0Vx95HBebTGqNnsNVd6rXWRqDCu432ttkgownUnST6+tOLuye7qYt0xUXg4
	k9scCQ746TSCGORe2qqLvohUvC1ae/Yu4JS6wu52L8Lo4s9ayfPB6JNjgr0MIJBVHlr7BLuuWAm
	BKBTq+ElHv+fIdDDiJLZnO1zprfkCrr4VoszPPjXdZg98YZG8wzBU2Rb6p7x4AJgnwPp55E0Wa2
	H4Smf8TnrtER0HYod/RH5HvYactS3hlxI+IMLuneum3GF9dHlTv9Uz3iulvMCiuGTJcTwtk3KeK
	XqKPRFVXFGVGVymX3g=
X-Received: by 2002:a05:6820:2291:b0:67b:dc7d:8148 with SMTP id 006d021491bc7-67c22fe0b13mr2639399eaf.62.1774030244891;
        Fri, 20 Mar 2026 11:10:44 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d63aa9sm2559149fac.10.2026.03.20.11.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:10:44 -0700 (PDT)
Message-ID: <376a35ee-6a9d-47ef-b4f2-d1e6af5f830d@kernel.dk>
Date: Fri, 20 Mar 2026 12:10:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: fix multishot recv missing
 EOF on wakeup race" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, francis@malagauche.com
Cc: stable@vger.kernel.org
References: <2026032057-septic-boogeyman-daef@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026032057-septic-boogeyman-daef@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227601-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 89A602DF49A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/20/26 11:33 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Since this only triggers after the AF_UNIX inq addition in 6.17,
we can drop it for 6.1/6/12. I should've done a better job with
the Fixes tag.

-- 
Jens Axboe



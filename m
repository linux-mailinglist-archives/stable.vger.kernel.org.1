Return-Path: <stable+bounces-171619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDEB2ACA4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3501778E0
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED333253F11;
	Mon, 18 Aug 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nHdLBnj4"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C021C166
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530487; cv=none; b=hd3JEME7BWQ3lo3x+Dt3nvwOGOq86J72Et1bVoO5bALlBCQfNlGtdpUMoP2G8Q9K6r7g23hv5FLoHWvGscEO92HcXhmrTgvunKNeWzdFPrP8JKmXRc3o9XWwV4+JcAr+BPgKnHxtXIX2fo5d8lT61YDsK5QSBej5xLIBkjqRRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530487; c=relaxed/simple;
	bh=chnjCnUulJVXJeofNVEbCWcnHv2U3R93Uqor7BM8Upo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVnWcN/gpoDeUlFwguWJ/P22qLyof05wa89RXU23IU37bmdWuCWxa0AVwYO2u/DmP9M+5qLoZf2zh/JvWMWhgoikYHdSoZ82gxHvsyU2+Txb4YRANxpFNFZTqStqy0usQv2338lN+TpI6AAy1qKYMHktTVqrg5oX5gUD5I3qS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nHdLBnj4; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-435de937578so2188283b6e.0
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755530484; x=1756135284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnpAge3MeO+sxXs3j5vEy0JWYcKuYAO5R3PYGJvwXv8=;
        b=nHdLBnj4d1wqJ1htsEClv50ikD3sYirSBCfd3FWfP9QI1qPSCgLdEDBspYPi2zreHo
         ahxg/l+vPHI7t19uboLv1tvhQRIfSVNTRE46bjhofYEX9/ggDbgG/FZzYznAUoqyDuTB
         54zv1fk2uBrjAfi5LNXSDxu1vEo3LCE1YjKQhaTjZy32x4hGwgQtrbPtUOqpc8Ip9EAu
         OIJJP+WqEHQ3ui4PU2kBgR6HqHAcu4u+f8jh1hxr3bv1GzXIZGmelvZj949FCmjW/j27
         xkjorYRIAAjI7D4N7evkxjxD7w6O5ffslJpkUdkd0GfuZp6wITqVFaaVZuH3y25nSWc4
         LqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530484; x=1756135284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnpAge3MeO+sxXs3j5vEy0JWYcKuYAO5R3PYGJvwXv8=;
        b=U6dgnbaNVPA88dGs5oWlOLiyWN2hCijEokyTvHW/RVpTo6VbNNJrN1TupISZ0zNioB
         l9j9W9envt+NrNOVkKv38UhHCeK8zS5gpCa5r/nQzFRGsxhSwY/xS6c4OPaWFvJpRKpb
         gsLWyIg5kXUpYuXSUvWC5dojsemcb0DJhu+nKgjkGk2YgtGuTN2vSzwtoIMuS3x0GuD/
         AwU5J72ijvlAV09TJM+xFyABapK+ExIhaIDJk0pTSjt09EbLl/dZQJzKvX5Dh2YbKZNC
         Dk3H7r5ylQdJGqGd/1hY/ertorDnE6RmlV7I6l6da8lRVllwQPyVKuO6hciVjDq+/1Yn
         aTMg==
X-Gm-Message-State: AOJu0YzRYpp9xoXdrwKVJVdVWmw1MzlVji9fnZ8+zX7uLNKimx91Hplo
	8tGhX2Q0S4Va2vUyVYx8BLbSBSXiaO+kWRSsAxYZuXUKPBbcar35R5Wsw2h4TRs5R4U=
X-Gm-Gg: ASbGnctAZ2aAsqGcCe70PyRrdkUgve6jKolrW0LzJQPs7GVo2bsF6vN276pS1Vq/sNH
	Ah3WYKCQds99r+4f0QI0bMJ1gvvKN8D/3LKYxRxgjxrwhs7saWoMe58btQ7py03/ORnLIr5QcyK
	4h7ZDzEIyEKFRBkPDbZWGktNx/ab2+aAJ4raDqYe/vpsQSrNk0G5rhRxfk5S4NpCY2XVkFHxYNE
	vPS4/u4t4J2b3+dSQJFkBo3X6ornqxZFFTPro/nY/gTP9iPE7i7lgkYt3EvAbhVsy08xHyRTubP
	+5ggWJBhKjJr9A6VjLAHnOBKW24vZsj3lQYzolWQdG9w+lFlB0BH5si1PFGNnd4okRHzBpVHtHl
	lNZ+jMZtqnYqksxFxqduUQVTHvKXF1A==
X-Google-Smtp-Source: AGHT+IE7Dk8fBBTfe3q979ovlDCK4Bkl75RIl/DwLMq+2yFBqWbBdeXefa8WYswRHb49PnKjRs5Ieg==
X-Received: by 2002:a05:6808:d52:b0:434:82b:f10e with SMTP id 5614622812f47-435ec486741mr8356364b6e.22.1755530483840;
        Mon, 18 Aug 2025 08:21:23 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f68eesm2578183173.77.2025.08.18.08.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:21:23 -0700 (PDT)
Message-ID: <e27afbbb-7d13-4381-963b-8dbd1e2d06bf@kernel.dk>
Date: Mon, 18 Aug 2025 09:21:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/zcrx: account area memory" failed
 to apply to 6.15-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com
Cc: stable@vger.kernel.org
References: <2025081527-unflawed-matrimony-2057@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025081527-unflawed-matrimony-2057@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 262ab205180d2ba3ab6110899a4dbe439c51dfaa
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081527-unflawed-matrimony-2057@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Pavel, you fixing this one up and sending it in?

-- 
Jens Axboe



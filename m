Return-Path: <stable+bounces-121672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7013A58EB3
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 09:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E96D3AA849
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9207E22424E;
	Mon, 10 Mar 2025 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1A1HJhu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E322423C;
	Mon, 10 Mar 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597018; cv=none; b=qAIB9hCergRjGR2cwXJ51y8MMKarrSkhaXvTDRwny0PbpSYeGTldEudPAJX5bJdKR9Yvpb+x1N3nVFQBa21HcYMn7Raplo3vlNkdS1jYhoSAWZGStNO24p2eqv+Smooa+UxnMIuFYAax+4nFE6OUByRkVpz/jO3fSUmoZOm7uH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597018; c=relaxed/simple;
	bh=CQKIFIxFqZxWZ1lt/LkcFUZi6FOfsAzOvk94m3KE0RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrMUwHAGWA3dDzWGv68YpVj8lAqXx9LQpP+64IpW2yhAhoAlAfGFUCkbRUDk9ufpb5rlq/pm/4UNzRbEiB5ZuWzT4OLm4sW7CMh/+55s2UomEFBLOPO/pf+CzxcNPbdn77YmxTqdrsndeWaSmqW5O2zKj6E9BEfSWBiLFJ24+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1A1HJhu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22403c99457so7334465ad.3;
        Mon, 10 Mar 2025 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741597016; x=1742201816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQKIFIxFqZxWZ1lt/LkcFUZi6FOfsAzOvk94m3KE0RQ=;
        b=A1A1HJhuy/x1ONVRt8nUQ4GmL/3G+dfyN0IuKJ/FXNyRvlSVyfM0U0FE5UScN3Blb3
         nE5GI1ALBejloYxL7nOq3uvRFaH0CbeZuhi2onFco8faSMpvHZSTyrdhpX2Y9xlq34HP
         GzJiJ+fO9TTKMIazUq7lYfdfXZJaCXmQQfO8L3xBQXCfa+5kabm9Yzk4Ev6b8aUxBe3+
         Fgi8w256ur966PfgUF9Ptqmix50NqoISbIRlUUyp0O3KpkJJsVmWhdSc3Mb6FWSiQgQH
         i1NuDl6UOejVl3j1eemeCpZsZJO32ivvLeShd8kpAm2fZv+gY6g6VSRr6qwnE4hJmk4S
         OxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741597016; x=1742201816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQKIFIxFqZxWZ1lt/LkcFUZi6FOfsAzOvk94m3KE0RQ=;
        b=c41Zb8P5oZQVAh5jMS84k1E8csTrMzdpkw82qjoLyUy5emNgcBVJslhAVI6li4J34c
         YRaWSlgI504VcbYsFzJnQrEr9IgAB+yYE2Cb3XRPH1U2gd5UH9W2QULLCar0LMh+VQnZ
         zwmKT/1Fs9iGWc0q52JtCSTZUHs3JVXjL5ae9sq4OD9Z6nsJag6p4iSApX4//Pcvax6h
         EulziZdjwFBnDcyNHoNhkF/JdIMrALkpmzdPFW++nLcqa4MfOCKJhZBYKuVZK2udV3BY
         eibO+F3V8iE1jBqcth+Bs3CUCllfGQfRC8nEdqhLNh6/HblZSOzYlB+yHmcGjETvNNrR
         RrLw==
X-Forwarded-Encrypted: i=1; AJvYcCU4CDCRYFs/qoxkBi1Z7gwcZM1W0manf1AfyiAKuvJVmK+iRle1MJItGgCP2w4EVDvqK+tVzPlPlYymT1k=@vger.kernel.org, AJvYcCUnP1MwyBAR2jF8gkalNG5U/A1XKMR1REs2UKZv172LId2Gcs/39wvYco7mkkAcppPqdL30/jQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwS57P2tCkm+7FV3/IFojCtPyQ8kesP8QuhcBFDotznaqWlm85i
	IJHl6q+C527OOkk7iShTTN2raLkraoEY/OggVPWxW6KwhqET+C2j
X-Gm-Gg: ASbGncuCubK7tn0WlO2wdgRh40jKx8LflGduftoGra/OW7jEBr8rwD7Ds/SQ9r8IZjL
	XOG8lpOI5AQb3PszXQBHSEyJw5iK1eWjelPOgt05fIquq+ixae1Rf3ahfrw5hlFiPUL364/quG0
	iUAOvQlVBi8VHJodgAs3aYq1MXdvOlQSdTfdhfXGe48Q8twc49NCvLsuebU1xI+gNJaTzMuOFmp
	cG7+86UTbslTm23UQXgFBsauvLY/rk/HIsmuXSrDwx0NY0WN4+SxlQZj5jRrqpR8JzsYCmHfqLW
	PIMEb3PWmgw9t6fKcO8s/KiZD0sbRB+dq8RDqCRfPaLKq120V0wGzsvmn2QO6A==
X-Google-Smtp-Source: AGHT+IHOYlux707LNP93d+bS2pkNRs9Np76eJc3iG7AywtGvurj6ZI1INVjMT2KGGZ9W0oMAHn41GA==
X-Received: by 2002:a05:6a00:4fc7:b0:736:3222:c392 with SMTP id d2e1a72fcca58-736becb1adfmr5050059b3a.2.1741597016096;
        Mon, 10 Mar 2025 01:56:56 -0700 (PDT)
Received: from localhost.localdomain ([182.148.13.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b2da32c6sm5712350b3a.149.2025.03.10.01.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:56:55 -0700 (PDT)
From: Qianyi Liu <liuqianyi125@gmail.com>
To: phasta@mailbox.org
Cc: airlied@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	dakr@kernel.org,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	liuqianyi125@gmail.com,
	maarten.lankhorst@linux.intel.com,
	matthew.brost@intel.com,
	mripard@kernel.org,
	phasta@kernel.org,
	stable@vger.kernel.org,
	tzimmermann@suse.de
Subject: [PATCH V3] drm/sched: Fix fence reference count leak
Date: Mon, 10 Mar 2025 16:56:48 +0800
Message-Id: <20250310085648.3800601-1-liuqianyi125@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <99a18daf596ca384d38e561675cf3e13a9ed3161.camel@mailbox.org>
References: <99a18daf596ca384d38e561675cf3e13a9ed3161.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> The last_scheduled fence leaked when an entity was being killed and
>> adding its callback failed.
>>
>> Decrement the reference count of prev when dma_fence_add_callback()
>> fails, ensuring proper balance.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and fini")
>> Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
>
>> From: qianyi liu <liuqianyi125@gmail.com>
>>
>> The last_scheduled fence leaked when an entity was being killed and
>> adding its callback failed.
>>
>> Decrement the reference count of prev when dma_fence_add_callback()
>> fails, ensuring proper balance.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and
>> fini")
>> Signed-off-by: qianyi liu <liuqianyi125@gmail.com>
>
> @Matt: since you in principle agreed with this patch, could you give it
> an official RB?
>
> I could then take it [but will probably rephrase some nits in the
> commit message]

Hello,

This patch was submitted a while back but hasn't seen any updates—just a kindly
ping.

Best regards.
QianYi.


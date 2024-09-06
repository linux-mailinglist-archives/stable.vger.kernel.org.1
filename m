Return-Path: <stable+bounces-73792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0596F5ED
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F0B281441
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2D91CF299;
	Fri,  6 Sep 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YYFe78Sk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3A41CE712
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630881; cv=none; b=YsPgtU1B6i8R8oBRZAiWJPiC+LvMQhFgISM+FuyuvTmEaLoO3wtgdz0aF5JlcPhbC5er0g6I4EoDUYT5o6RuRwZqMfsmpRiEuhpfESVX4Tz3dia20PEzuq+IlwkbFZVwzGvhpVtxdk0/juw4jtaMCqvz0ivD5RsVjw3AB4juu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630881; c=relaxed/simple;
	bh=ZsGwDCIN+lDkAH0gWM1wJTTqQhaU7HhvybspK0VLThU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I+esN+vkYg86UVh4SlrQp8eMN9fEw3Q9fDfN41niDHEhWNVhEz6APWMKWBIPEc6lsYXBRhTooyvoreZwAK0gZSz+NioDU9aDoSblTPcGz/14uu9RiaRHGFxqiGocsMaxMyx3B4oaGByBjYEe50hxwIWFuSRYv+BxAN35Bgw5ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YYFe78Sk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso1536345a91.3
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725630879; x=1726235679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqYsgnZduSGZisr5s+mTNUF2F6DJ5arsb6t0aHDlSwU=;
        b=YYFe78SkxEujY4PqzLLJfKnmIaiRmwRhpNwySzfM+CHuCz9kjlCcG++OgqZs3fYbhz
         MuI9eCWnJYHpZYUHXnq44e7jFSue9PZxEVaqwMeZwlDro+eY5HcT4y6SFG2Em2N+9jNd
         sLC6RqTq+WZlwMS5dcon+KeLb6DrAcSZrF3C2vdMeG/MLzwyVdd0TJt8wJvYUS/EPJTt
         RD6qVXd9n5fx7f7ZTPXcNh74ScZo6DYK+rOesftYwkf2A5rmptPMkfNfvXQW1qYnlP0G
         57AuaC6QkgTF7Os79DqrWxLXgESAJXrZoNODZFuigsbIlf3+NuhiGHQcJgoM+D4LEjIP
         be4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630879; x=1726235679;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqYsgnZduSGZisr5s+mTNUF2F6DJ5arsb6t0aHDlSwU=;
        b=nQYwrYn/cvTENiTW2RWcctMX/DbfaFPO0LpaVjELILNywZYagsWeJlozr5uhLckK4Y
         8F2FldktAwADQqTzInt9+3RN4K/Z222Mn9ndne2Xs7ZtrdQo47DzZWcX8Xr4nXb5isT3
         FD+3dFd37HrXVizgMfS6Hw6KycyZexsP2zd0mcSA49ZTInNNSUay40IFMOJEVuvWyqpa
         KGtpr15ixRBHcFvb3c0uVIPldDWQM8de+7oiOj3l8CdwMWmcy0vvWW1myCiF9ppmkAul
         WklYAtCkO2V/lwRw5P7uE5eQXtGHn1Tl6fIUjmzBgg2yX2qYWtpfNoiuRgg7F9mM4i/f
         u91Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqmPmDHDOu00Wy7BqPR8yOZzAwHx9OmBXp5JNem2cVEFaCHyORV4uN6vVQC6EJWJ39w8advAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6GjPd9wtzjVaVzpokmZ6N0WBG/v9WtkGMcZW1Qhee+enyp134
	gHMqfRRMhbBVkmklBcE2Xq54ccs5A6TO+doNEjeb/aGjT6xowUIktgD5ocxiXCo=
X-Google-Smtp-Source: AGHT+IEz3x1d08wxVHCd6TlcJdggI5Bp33DTbD+8QG/YjoVqsrYJ6hQirWBBgpD+XKiiMM8NyQhzVw==
X-Received: by 2002:a17:90a:8c0e:b0:2d8:8d62:a0b with SMTP id 98e67ed59e1d1-2dad5131fa3mr3245141a91.23.1725630879052;
        Fri, 06 Sep 2024 06:54:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe47a6sm1595151a91.4.2024.09.06.06.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:54:38 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
 cgroups@vger.kernel.org, dqminh@cloudflare.com, longman@redhat.com, 
 adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com, 
 stable@vger.kernel.org
In-Reply-To: <20240906134433.433083-1-felix.moessbauer@siemens.com>
References: <20240906134433.433083-1-felix.moessbauer@siemens.com>
Subject: Re: [PATCH 1/1] io_uring/sqpoll: inherit cpumask of creating
 process
Message-Id: <172563087777.168448.6960752734044926743.b4-ty@kernel.dk>
Date: Fri, 06 Sep 2024 07:54:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 06 Sep 2024 15:44:33 +0200, Felix Moessbauer wrote:
> The submit queue polling threads are "kernel" threads that are started
> from the userland. In case the userland task is part of a cgroup with
> the cpuset controller enabled, the poller should also stay within that
> cpuset. This also holds, as the poller belongs to the same cgroup as
> the task that started it.
> 
> With the current implementation, a process can "break out" of the
> defined cpuset by creating sq pollers consuming CPU time on other CPUs,
> which is especially problematic for realtime applications.
> 
> [...]

Applied, thanks!

[1/1] io_uring/sqpoll: inherit cpumask of creating process
      commit: d369fdf0908a8a026a8a4b8729d2a193b75fd2d6

Best regards,
-- 
Jens Axboe





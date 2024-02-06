Return-Path: <stable+bounces-19001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B784BB41
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0794B22C65
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740F517F5;
	Tue,  6 Feb 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KRQFwn5k"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703634C6B
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237866; cv=none; b=H3T1qAG5Eh+3rieiAHTzuGlqsaloIxuenaMiHRaZNqyG6nFL2QvD38FSUd0r5W2zdrlyP46i+hPvD/ddeT+KAwBdSdqJj93ZPerGZTqPMVAWPNU9kZ26VeaQxRVozljX7XXPPNEkE4AZtrTSaW1lL4KcXGQLoWBYd98dwzz0PMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237866; c=relaxed/simple;
	bh=Ci5gwbrSM7cmnUZjQU3RB0yI/1+Eq7LqAgTZ83suCgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CRh641DAFZO0jsRQSWBi5bZidpGDJRnMSbLRG6yfD0BRNlcZ4g1kl15UHe/W+vAJOEI/kt3Km1EyCGzPUdtsw5xJNQ86LXSu0h0gPtnfzkw7ch7tnsnGcDKIkaKPdedi8lS2xy5mp/e3nX8+ZcGe0ZFOHpNa1Fq4MzlbyP3HrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KRQFwn5k; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bff8f21b74so59265139f.0
        for <stable@vger.kernel.org>; Tue, 06 Feb 2024 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707237863; x=1707842663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQcEl2yXnIh9XZWtfFgTdh1YAJ2nWzHZ9qOn3KNYSqE=;
        b=KRQFwn5k22dhb3NV0WTSWzkkrlUMs1IJPp9U/18DFuLTAZfK9VfDYX6XEtYhD2jD1v
         2nuVBUjghNwSIHv8rbbA7JjQPNYE8dJNtNrqIWqNV3XjY44KxKKoPLpVW++AYoANwBVn
         IBmMDMFpPvyVQYSEQbmIdgFaNjs5TuuybzqWO59JHOWObWr6i8PAPuYBgqCFtTG2tOdn
         QS5JAWa77rlrgBcn3GJuZwcsazo1IXF/YwgcbDXm7YcKl+2+46ONDsZcv1cf7VP30i4j
         r+6xz/9rHUUYehcjQh4T7MCk+vMHS/t1QRzSY0MbNm7h4ylYt3hckL69HjEMIiE3B69P
         0qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237863; x=1707842663;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQcEl2yXnIh9XZWtfFgTdh1YAJ2nWzHZ9qOn3KNYSqE=;
        b=DJh3XtvKZ8CQif/0QXqqCKBPIAL9axljL6gKwV4T5fyoJ9xJ+rRIXinIzdGVgttLgR
         BYM4nW1jMejziYd7s5yVDMdemeXkIX8QscasqkHuK9ihlW1Hh3wOQVWArYeauSuCImWK
         aQ3uHoOPqqfjgM7dMppNQKgKbrB8dV2raaGj4kFXqVVDTEagZbBD2RSw3VWJzsLaJ3BB
         q9O4NcFPLlggyxgl81LKjF74LH0LSDEUnxY9WmRJchZXXGApDJ1/Pl8lzbWzH2n79mxH
         XuCpsrpFw6ks7C6I7lHsKICrNg9odXEx6JCI0BZfmTj1lY4fsZpW2Q5zkRHVPBvJEOl9
         QugA==
X-Forwarded-Encrypted: i=1; AJvYcCWlXrp4CC8/e4QUyozOBKjUdWhbYs83b4HjlOCpzy/R9LqaYl8AwEDzErWhbvKYXdyQn/uzxFgTtoVlbk7QdS+OyyTIPNq9
X-Gm-Message-State: AOJu0YyxLvcIJHn61EVt/P66ngz1e9pdcAv4kw6mpmkeMC5QftF+osuh
	Vrtzqb07eHGICUJ33w2AEOmuQEAyQQ4H5Hy1BDKncWpl2Sd+/cGR6lwe7OZPSp+Tx8gOKg71/lH
	rebg=
X-Google-Smtp-Source: AGHT+IHZcEs7aDBPkKePRyf15PFF2B8+VP6+6XCTuENUCVBVzCXkDyrXenAcuFqRY39ol7B/hYJTww==
X-Received: by 2002:a92:c248:0:b0:363:b624:6304 with SMTP id k8-20020a92c248000000b00363b6246304mr3743736ilo.0.1707237863190;
        Tue, 06 Feb 2024 08:44:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbAW8t4ckd3AZqia0sjMAtxuucZtqgd9p1TKGWqFHopEeROfOeib5LPZvgU5noh22po3h7Z3oSEhEDoSDr8ba7eM0U0+C8KnplV2tM64wikCdkKojirvUn4us=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bq9-20020a056e02238900b00363a91effdbsm164701ilb.76.2024.02.06.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:44:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
In-Reply-To: <20240123175826.21452-1-jack@suse.cz>
References: <20240123175826.21452-1-jack@suse.cz>
Subject: Re: [PATCH] blk-wbt: Fix detection of dirty-throttled tasks
Message-Id: <170723786248.650796.10431002551375769170.b4-ty@kernel.dk>
Date: Tue, 06 Feb 2024 09:44:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 23 Jan 2024 18:58:26 +0100, Jan Kara wrote:
> The detection of dirty-throttled tasks in blk-wbt has been subtly broken
> since its beginning in 2016. Namely if we are doing cgroup writeback and
> the throttled task is not in the root cgroup, balance_dirty_pages() will
> set dirty_sleep for the non-root bdi_writeback structure. However
> blk-wbt checks dirty_sleep only in the root cgroup bdi_writeback
> structure. Thus detection of recently throttled tasks is not working in
> this case (we noticed this when we switched to cgroup v2 and suddently
> writeback was slow).
> 
> [...]

Applied, thanks!

[1/1] blk-wbt: Fix detection of dirty-throttled tasks
      commit: f814bdda774c183b0cc15ec8f3b6e7c6f4527ba5

Best regards,
-- 
Jens Axboe





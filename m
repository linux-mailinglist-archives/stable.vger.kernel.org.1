Return-Path: <stable+bounces-132776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F2DA8A79D
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6001901DAC
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03330242913;
	Tue, 15 Apr 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hQM8uGmf"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B823536C
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744564; cv=none; b=AcjwK1XqHj8Rm+L+6CQECqIWJKT91C5LJSR8r+1nhfnkXhW7kd+gOZ3zDAJdjHr+jjrdhQODmYSKpY1KEqWaCICBFPneArupFFgXMwwtb/F+RnAb/pqDP9/pjBPNP0d5mjsrfIRE7MecPU769ErHrxsWR7NCPx8NVFoIW3ctKPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744564; c=relaxed/simple;
	bh=9LhhQK7SYYoB04N4KaGT0jYG3IqgAZMjCvvz8yGafZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pqceIKhScwpxtIr1HvHjPoKSlbR6XWWmdIJ7pzk36SGUDTIetTs8WMTWMYW6t6vzCxEkLV2euR5Lo0e/P+Y5ex6+BCFyAj1N4A7KD6gbsJJO5Zy7R1Kczm2YvHfcOkXUt2/HhXjMjGh3lIhU9jOYfIXjDp4dxCSQkXElqZtGhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hQM8uGmf; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d8020ba858so17415775ab.0
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744744560; x=1745349360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asgUBCNF1/3nLCqRhE9iKUJT9+CZgW2jKMxY6rpof5I=;
        b=hQM8uGmfyz4swHbASYgN+i4lx/0vQUFmxTVp9Xhtx5IkAKkj/ND1pauID0cwBnZLkB
         jGVHvwX76whYhJ8NKHlIg1yYYq0N+f9X1zu2uxkvWMYTGE5m+jkIL++iFUzcAcLBl+2x
         7xQksbzZpbJllk23ktXAJJaq06GcqMTxAyG+FeOz+hxfsm8+4r5KJOjUtDtgzqCyM4Hh
         g0BsrtMxmE/fOgTXrO9EhVCH8nMHZAy5zBqq4KHKQvs8qHClK/Sg/5pYS4aJIdqZiRZ6
         +69iBbcThAo3u9qbh/DIHZEdYdYHcyJeUVUXMvF5P0F+uDGPnxyXIn97C2rCHhKgg1VE
         qyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744744560; x=1745349360;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asgUBCNF1/3nLCqRhE9iKUJT9+CZgW2jKMxY6rpof5I=;
        b=tw9cKreojHtAY8F9v1FgF6m3UineuicZcjHk4J+8dxQw0A9cNHTVCDIkG1REi/99cv
         DwzVyLf/FT84Uwql5zp2/2iUlXqHTrXIOi8vtd/9AH56rcyudiNwPJJV05stCcaSeGQV
         yVLs8Nj08Kq6/rzFj+jH3aTDKQzr1dMfR5H1JjKDpXc+LrIC0boiP3Luz1+o9HHJ/HuP
         QGwVhDJ2dHUgG/irtrOrb5JLhhXPBun0BWSx9E+Y0kJUYU/FHUusEujQddI6fNJEAi+w
         4yUoxXTDM2Uz5dImRgL8xIJmkKHzyDfCCR0VXdCsbIyHx0CqOpzm0F42iz4Ejy/el/69
         MzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXI1E5yonXV86x2zXR2foA6HGBoXbnMhcUIiwqHImn6umf257cnJJ0wYacRW5cHARUwvw2a+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXSfPXUzeQ8iCyQJqxhTbb2FPV9nh6PFEZdDW0gEpzjdeVzLB
	jnpeWt2aBstszutHv3l9iKW8ttvuqkseF624E7ATxvjqp0HQ2gfTHysxvpLDaiwG7FrUjnTQwo9
	T
X-Gm-Gg: ASbGnctchhgjAi9yO1pmcMv+NTWsmGqJrNl7X24KNItiC3r+O/BeDTkjzz51xA07V/6
	SLlSJpdZsEEM/XFE20w2pcwAaptHf2h5i9xkqnCsbek/TZZP5r2ovnic2xjwfe4mo2yZJIKjrsc
	2GE4iIr1neHH1v6khsTAQJ+rFKgsVU46PxU+gh3OMYxy5TMKlPcE84Q52doCJRsJpcLNcv23TXT
	Yaxz490vImsCxUlWZQhAR3JptyFkUOewTtNoUQjdQZS2R+bte28Aakfy1h449Kc9gx8Mr5cbhyN
	M5+OkSwgJrq1Ylyfflk6GPMgxH8Oy/X20PV8n7pCkWY=
X-Google-Smtp-Source: AGHT+IFJPt64kBMbP+3d+i4X9X/L5HM104ENBBE+s5Z3gjU9DWZ68WPXVZk2YmxhXWiQnU/bD44xZQ==
X-Received: by 2002:a05:6e02:339e:b0:3d6:d145:3002 with SMTP id e9e14a558f8ab-3d8125a9e0amr7085535ab.20.1744744559647;
        Tue, 15 Apr 2025 12:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d80b6b0392sm4898535ab.63.2025.04.15.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:15:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Martijn Coenen <maco@android.com>, Alyssa Ross <hi@alyssa.is>, 
 Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>, 
 Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250415-loop-uevent-changed-v3-1-60ff69ac6088@linutronix.de>
References: <20250415-loop-uevent-changed-v3-1-60ff69ac6088@linutronix.de>
Subject: Re: [PATCH v3] loop: LOOP_SET_FD: send uevents for partitions
Message-Id: <174474455866.197229.13564340998714651621.b4-ty@kernel.dk>
Date: Tue, 15 Apr 2025 13:15:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 15 Apr 2025 16:55:06 +0200, Thomas Weißschuh wrote:
> Remove the suppression of the uevents before scanning for partitions.
> The partitions inherit their suppression settings from their parent device,
> which lead to the uevents being dropped.
> 
> This is similar to the same changes for LOOP_CONFIGURE done in
> commit bb430b694226 ("loop: LOOP_CONFIGURE: send uevents for partitions").
> 
> [...]

Applied, thanks!

[1/1] loop: LOOP_SET_FD: send uevents for partitions
      commit: 0dba7a05b9e47d8b546399117b0ddf2426dc6042

Best regards,
-- 
Jens Axboe





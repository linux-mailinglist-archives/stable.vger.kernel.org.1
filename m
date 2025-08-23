Return-Path: <stable+bounces-172526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF38EB325BF
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 02:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85631CE0588
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956015E8B;
	Sat, 23 Aug 2025 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOj1DAcY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D42F37
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908535; cv=none; b=iEomlCb2mHE6dY2NUYDBnanoYFvo9FbPfleTChdmyiRY0Y4ThLXwVhawYSjk5N0z3+6UIu1u29gSqHqXrKbkbsjnORhRm9+ejkO8wXIly4nTr970aDUllVc3aOAk9y2zhg2DaENjc62fWCziY2nyTmtSK6rHajmKNcNUGVjRJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908535; c=relaxed/simple;
	bh=gGE5KmQoDbr4rO3mGEwTnDCGiVKhEha5+3aDG7iVuEw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TpFf4MITDgA9FZaT6yuqjR2VkeQsxQQ0yaogMHELePdDHq1RWRaKXvhLNgL/O7LPtSN+MHURnVMJ/JyAwx+bMptrxNQAEmD0Bviwb6YQKtX6zny2HUkKtfXff5B91/U8whIy4WgywGbTdOuNbsb5n+lCtVfy5vYfbcJFAMA20sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOj1DAcY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-246013de800so68805ad.0
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755908533; x=1756513333; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGE5KmQoDbr4rO3mGEwTnDCGiVKhEha5+3aDG7iVuEw=;
        b=FOj1DAcYwhUbCCDC0n/uan20dwjIYB08xayMuBhULw/RSxW0HPzNw7n7csv5to0ZOD
         G6XAQWjvAFPxzFyLvzAuX91APHEN4b+B5wHyWCprh+u1ReYaQ7KeQcljs8z38a39258+
         EzQvn5zJ+rWfUGD3Rh/s+lEmBt9TRySSFhK+3VdNOI+BJm1ocGDwDWTL8g4oef/QsfvV
         QjJPbp4XPmhL961KbTBhGp+MtxhBn11ukILLhjIJboIeK1JiHWEng6JFGoTmc2ljI3vb
         8lwjYRz2SST2EGOE4KbXEP+zYlaOljacYmqcrIgzrj9e5x4bTWJXQE94kWXk6qX81lul
         4tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908533; x=1756513333;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGE5KmQoDbr4rO3mGEwTnDCGiVKhEha5+3aDG7iVuEw=;
        b=OsrVdqTEH3QM1eBdcoGZz/d6BDZORyBzAFlmJ8zCpRkqDsW2mF0MsJkU5QSxS2Zcri
         WNnve1V+cZ9Vm0njlXF26AQGAwEm1aa3YGLr7hywL5fmvyyyRfXVnAjVUJRAliJ4tfPD
         6jQzmZyHd5Sj6aOPJwwGtI+y6b5tMFWIBtkVJjj24iOYZSR07f6XC4HYD/ZzFHggtcZR
         S1z8EVmYKcz/wYCpQ82tKYieDejFepAbAxjLvlwdTTOOM6W1E3UyKn3C/Oy/zDZzJp5v
         Gudrh88G5F7yDBV8bltXXdEnDwM9DjhZQSET0F2sywHAw4QX+Rnn2Y6FrHWArH7sQroG
         8FQw==
X-Gm-Message-State: AOJu0YwbJY4p6VQnMbYGeDBKroImXpjru9YhI/s8YyGLiDftVXPrNguL
	y7VbpbkgvLAMHkxxHahUHrTMAc37Bjl8xqC2qkwsSrvvRf6Z9S3OOZEFMkIGflG+Yu9GF7QePHz
	w1dAIHQ==
X-Gm-Gg: ASbGnctgE+pveKJF5Pdjvl6vIyCNPOUdY3TbO0itZQgMDZzHrNHkQjhp1cz1t3/dJTe
	8CUK7cp0aKe6nokP6dwJP5bFs2KactXjSNRdFtlF806KZ3blHBa2hIe7geoYliftc+FYcOM//6u
	4NcQ/4SKOySnRyOHX1hMGiLorEYfiuKJsA39lklxG6Q1fSzJ/nLUMziDO9vabsntM/TRy0lUVW8
	QEA3/2MIr6eNheHA2+YWVj7rGBnYJK/UY/6RvN+fiIEJNJMuFpTVtP+DJFXaz0N1zKVE7gmiYXE
	kB1Q6FJAa3GX3vmKODsMHTWj9i7Rp4Ko6zAuMJ06M3YRUhCSfVsedez4Ak2k0iYmNHnrt4D1X9o
	4I9FiQDTsHocINOwV8hfe1JEsAPRSJom6jNHAKrTZTKTXSkjfAYNul08vZOz2Aib9NSba86NjPo
	0=
X-Google-Smtp-Source: AGHT+IFTP4ho17qEdomAPvbNovCOU/J8Y57clsIJUxhqGG8ZNQgFMy7ogqUt+aPb1wssVf8Fowoj1g==
X-Received: by 2002:a17:902:c408:b0:240:a4b5:fe0d with SMTP id d9443c01a7336-2466f9e2d9emr1802925ad.6.1755908532919;
        Fri, 22 Aug 2025 17:22:12 -0700 (PDT)
Received: from google.com (57.23.105.34.bc.googleusercontent.com. [34.105.23.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704025ef80sm973410b3a.108.2025.08.22.17.22.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 17:22:12 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:22:08 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: stable@vger.kernel.org
Subject: Backport "scsi: core: Fix command pass through retry regression" to
 linux-6.12.y
Message-ID: <aKkJsOJMKzOT-kqu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please backport commit 8604f633f5937 ("scsi: core: Fix command
pass through retry regression") to linux-6.12.y. The patch fixes
a performance regression for many SCSI devices. Without the fix,
SCSI layer needlessly retries pass through commands that completed
successfully.

Thank you!
Igor


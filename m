Return-Path: <stable+bounces-77062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6EF984F79
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 02:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595B21F244CC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 00:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544EE610B;
	Wed, 25 Sep 2024 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b9dI6Exf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58F4A35
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224646; cv=none; b=rJgWRarZwb8SsAgvuKkTHErWC04CQccO8166A3dGDVGttopRVeABLfQO94u6mgED58+IpnqDLmm7+ILjJ7AfD1aKwfnMbM0OZd7mTiofvM1yXWbEDX/Aycn+xIiAhzZk7brinvjUWVTX8Pn2zizMqzwuYCVBrG5G4lvAJxMZFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224646; c=relaxed/simple;
	bh=Ne4vSr3cvYtPVxEhHNFux7VOXieBzrt1kuOruhtxSL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmFtf/B9PVPVw2x5P9L31wDCRzmE8sQ9j4fy2m+2ng1Pz5jz/0xDKy6qg7NCszfB/c8w+ihvF5XgXcE7cy2KCg5dgPgIXX+uRagCOCt7uFW/+SDq2g7prrvc+QjV1nBq5Ndg1WOlot/uZe1fTNuU4nrveHkE5susHvmrqlKYgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b9dI6Exf; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso3872995a12.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 17:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727224644; x=1727829444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qi+Ew/rpwQdNekWtvCMQfio8DRksEPNbxq/gVYTc9Bc=;
        b=b9dI6ExfYHghZcb+6aNMSYMdVeecGzHlQ7pF5VDSD4FfPpELvS2C/+XGVYPQbGijtM
         tORy73aiMoCF4X66byl96MkEzenZg/Pu3YCNZm6CgXFkjXzPL4ors4dXgQxC7gqkYY12
         SahDw2Gwx2h07VUSn3plqGYpJwTRw2mhTxDTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727224644; x=1727829444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qi+Ew/rpwQdNekWtvCMQfio8DRksEPNbxq/gVYTc9Bc=;
        b=aBX1pjTY8pqyzdOhYw7shak4pCLTylJ6f+gktM7D2E3j197dkDcGvD7/5qforkswAI
         J6URt8jv6FQlNYMOWtPbNsyW42APcpNvWKtVwG6Qz1q4KBcAiiUACFMyQVBaq8RnNpAO
         oxS8FYZjUr/kaJf8ee17+us7FFDftNw7t/+PfC1XcR7FWViEwVe94dBg7+zdLgKwGX5N
         jh9iliWqH2FVVFAdkK0mVW87uYnMFpKAvHqLj7UwoOskbj1/f3457g9yLUAUa6uxNEhw
         c88vleQc3afshL1mKWXLxfG9yNzahzEbHD9DIeWSoiZcvbQO7XZrGW6xERS/VLVgVwdD
         K8aQ==
X-Forwarded-Encrypted: i=1; AJvYcCULgCDSiASxL19FSGoYJ+QmxwAlMYql1RgZI9DsJHtJfScUdFJZzKoDETPS5wg57jqfEOnbiNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHMZZUF35IXHeXd5/YKwvghIUb9R5ZXCkBUZP/kpUPvi/1BFSo
	uFiIHAp4Fs15oPKatD9m5n+J5br5A66Y/61LKnPEI0Gz7YEviU7XymKbGHScUQ==
X-Google-Smtp-Source: AGHT+IGHpbtyH6wG5q8wpr8glm0LmNDVojnlHAVCXzzabVBkw4UaRXRI6IpMn0gx/0I09JmQAN/eSw==
X-Received: by 2002:a17:90a:cb97:b0:2d3:d398:3c1e with SMTP id 98e67ed59e1d1-2e06afd7775mr1014848a91.36.1727224644075;
        Tue, 24 Sep 2024 17:37:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:234f:c061:7929:9747])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e058a0899fsm1409293a91.0.2024.09.24.17.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 17:37:23 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:37:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chris Li <chrisl@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] zram: don't free statically defined names
Message-ID: <20240925003718.GA11458@google.com>
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com>
 <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
 <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
 <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com>

On (24/09/24 11:29), Chris Li wrote:
> On Tue, Sep 24, 2024 at 8:56 AM Chris Li <chrisl@kernel.org> wrote:
[..]
> Given the merge window is closing. I suggest just reverting this
> change. As it is the fix also causing regression in the swap stress
> test for me. It is possible that is my test setup issue, but reverting
> sounds the safe bet.

The patch in question is just a kfree() call that is only executed
during zram reset and that fixes tiny memory leaks when zram is
configured with alternative (re-compression) streams.  I cannot
imagine how that can have any impact on runtime, that makes no
sense to me, I'm not sure that revert is justified here.


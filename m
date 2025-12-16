Return-Path: <stable+bounces-202717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B18CC47A1
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0AB1307A20C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C2B2727FA;
	Tue, 16 Dec 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="X+T5Tftl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49630274B23
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903886; cv=none; b=ZrOqcG2SM4Xd4HScal+nRg4T8+Npuj2kFfVBWhymvjSl4n1ZHvMzHoSh9TaJouXaY+qufqSY2U88QTWMHDkmaKMCZuRBHs99sMafmPgdsCAQ8OgbXXq4tPaSPJc98JAtaPLyb3FfYU4NNtnx99PgJdddVl8lU5dwY62Js/8/saw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903886; c=relaxed/simple;
	bh=6EAWakK9hGEZFnjMpke9BtV0raNAkYiS4u+8cjGBWPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqDls8V4PgDag6zqzpC80XcmBiMI4G3G9uDaKCLuzfAY882pZpNVzWjkHMXD8jWyPj5tscJYPwLN9TG/pozDdyDOc9K2862MR7psqMS0eb+iJ7yE25wqYekzOuXo7RFAJ/iQb2XOsLxb7bKRFuy1aDsaP+t0WNjNhrfbwKIMdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=X+T5Tftl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so2902957a12.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765903884; x=1766508684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXFLxPfMdRy0hynFOSJMIIvcmXhnhbLzVRVWvbqAVjc=;
        b=X+T5TftlnEjvGa93IK15swV4cOXaY78jbz1MfrpYi68J0TyYlEhdEUuEHZK7p/c3jJ
         yJyBHfver1tTJgMsxmmsZM/YTQECGj+K+hFB9t0+hZjJhuvNvwNESawcS6hGsMtKB6cq
         ab8E4BeoPhPaS8JRVdtqUcPNoO/TjtM0ALVSXtwtG+WcekmSv3LLaFYTP79aV+0EbvO/
         Gpr9R3a57/22UxnrHw2CLfNzvOOSAAfW9FoU+WW9ulyFndoWMvOhFZQEgTKjObsIe6HX
         QIbLsvUSEfS83arQi6ufsR8HHu+LDylTJgpnAlAbBph9AWD01LSzq+YGPK0pmD/iEdQg
         2/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765903884; x=1766508684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXFLxPfMdRy0hynFOSJMIIvcmXhnhbLzVRVWvbqAVjc=;
        b=g8y/FpNY9yladQfKs0g02HxwBNto+hebMXAI/y87borcaYvgSTq8BCYT11ajF3nfp5
         gOy3sCZa8B6JUzijLLVonuZTZeGhZuZcW+TcJLc6XpQxmIji54g9Hc/6YOBOIW1v1Lv7
         P4UBhAOpcVbCcwEUqs/IRGGj5I8I78VFKrtjDZWi1jrgWEBr7UaWFQ90zcy033d346zc
         v+pljQJ+L4fzSr/ZcLuPz1JZG6QDtuTweP/YYPcUKkdtBPNvDOtw35O8j5glNUf8772w
         kPhGyEfJuCf9olE+BAfHov2+yLQm0zxsV2u9V3zB6Tx3/vU6GDBwyMmP8NlptMQw+mUT
         dDQw==
X-Gm-Message-State: AOJu0YxrBqnh5Xs1gGIwbPrU+S5XuDL2iuJt6veRnfC1bdFuWuKV5lui
	Cqx6GvqAthnCVbUUaAhLMfKaFS7NwzMrtSfdLa9OXoWS0sgF+I7QATBHF/3SeiA7Zw==
X-Gm-Gg: AY/fxX7eznGDWhHj0u3ZfsaIyYipmxPUuHfAzKRUrVUt72dmfxwS9qYGfEuxNiEG9RD
	+7y7G6JoKSLXy0xWeRaqfV+mNVaUDuQxO+C5TvQoKL6StMssHl0bXqH9GZGS18yW3+cdSBFXZd9
	VbSPVV7zXezKn86/4W4j+8K+Qggyw/VJDRSOjUby21R2JVHIUXexM/8MHKUrXmJYYF/q8Cjxrh7
	CoQ37VqYtvdYO6sdlo/lpSwREG08sP2OZIs53YKD/wOJoY9EOZ6s5AZqwAbwN+JRsrZ9+nq/nS4
	7GTkbTgNfAHGeyJzWGQ+RzeMk7UlPiswvvUPFi5SFpjTyHd7YLxSck0CNnJDXhwLqg5u/ykXsrx
	8vWZs51SY83mF/NsXXefcDY+LL3ulev0o0WT42oaEgyvbp2Jlw5OAI7LleSOPFj0VJAgTttwu9e
	8bkMhiP9NQqn/OsMbLys0r7wsLPtnTbkk9
X-Google-Smtp-Source: AGHT+IEi4jiQdLnZmUxhb2opMxb7EKOqLnq+4SA7fRFnDdACEZ44RjFv4wK+1gwMTFXSt5R/mFB3yw==
X-Received: by 2002:a05:693c:838d:20b0:2ae:55f2:ad57 with SMTP id 5a478bee46e88-2ae55f2ae09mr893197eec.29.1765903884437;
        Tue, 16 Dec 2025 08:51:24 -0800 (PST)
Received: from gmail.com (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f446460c8sm18015041c88.10.2025.12.16.08.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 08:51:24 -0800 (PST)
Date: Tue, 16 Dec 2025 09:51:22 -0700
From: Will Rosenberg <whrosenb@asu.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Oliver Rosenberg <olrose55@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.17 367/507] kernfs: fix memory leak of kernfs_iattrs in
 __kernfs_new_node
Message-ID: <aUGOCq2MaJsZ0cwp@gmail.com>
References: <20251216111345.522190956@linuxfoundation.org>
 <20251216111358.754182559@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216111358.754182559@linuxfoundation.org>

On Tue, Dec 16, 2025 at 12:13:28PM +0100, Greg Kroah-Hartman wrote:
> 6.17-stable review patch.  If anyone has any objections, please let me know.

Please see https://lkml.org/lkml/2025/12/16/1248.


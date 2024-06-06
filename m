Return-Path: <stable+bounces-48292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2018FE6B7
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C714D284320
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BA4195993;
	Thu,  6 Jun 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8bX8ORm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F961194AE3;
	Thu,  6 Jun 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677743; cv=none; b=jqkXiyfrI1N4tedoYXZ2pQ+M29MxQ7/cT1IJ1AOtXf1QC0UFP1xmPCzN0EwT7AeQNVAy8CCc5EMP6zZlSRZmz5FNIl5LiA6Mz74C69zNrzI2XW8OY1igPzt/DhxyK6UNu/fLZD+QkOmu4hYd5wzbIdOG/nyQu5NhZcF0BWzmEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677743; c=relaxed/simple;
	bh=dFzZnZ9iyZCcqm74G6Vl7NXWbslBM9hA+ouPylJm5Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI+V1VK2ZGlbrlJifb9uiFByOs5ES6AId/H0TfYjDpi8MDaVqLP7qnA+ZAOFfW8rieXscR33e/UZAC4qL4KDeHFzr6iXa60gtvHGFXjkp/6KPqKCPInwWrolCnzBaVbShwhGwYauOqbkG7F+jT3oxXtztrciQuj8OZIbpBacjSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8bX8ORm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88029C4AF0B;
	Thu,  6 Jun 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717677742;
	bh=dFzZnZ9iyZCcqm74G6Vl7NXWbslBM9hA+ouPylJm5Uo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N8bX8ORmjltoK//bJTnD5sU6YhMb8/0ahWYZs12ScVQo4CAxLmMtskN7D3FtUAXcD
	 4Nz0Yv9gh4VroLgypkOcrUCn8usFJr+fR7yZ6x/sl5heQGETy1Fc8BrEeLXJa4ZBKq
	 xA+mBMadPBWs+c4oyEGskoaemm1NSE0eNRoyWL5t8rPwV0JNiDC7e0UtQimP8fnMMn
	 B/F5MxSnBI1u8mAPK2vqAtU/FDbgrIaNWwB5ep+oWewXQHtzh9T7tN5vHcu3Y8fhYt
	 3dKCxXTUDYezP47uUueySbQOtaR34CC7IydysbbXBrZm1Qj399glRNlYpUbVLpKiIM
	 juzTyhROmSHFQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso7064691fa.0;
        Thu, 06 Jun 2024 05:42:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwF3jCegfiAOICUTxd1pz2a+GLznj5YrghQeFlCqPVcgPW6n0d/
	2sLPTt/DmtnL2M4UiWWFGNcPM3xOKVIec1kdaz5NE+Fq67pB2hNPeXKPG+s5y8CZcnccvEOH/wm
	nIvHhWceo0My4cAPv664y3PMxrRQ=
X-Google-Smtp-Source: AGHT+IHu3gM18e2W9Ialxhik4Ar6f+pu0jmzUPSkSEHcnEma9Mg6mgXlmqM7yr1wTMKpjsXsksYDuVG9VSae4CMrGqM=
X-Received: by 2002:a2e:a235:0:b0:2ea:6f43:3978 with SMTP id
 38308e7fff4ca-2eac7a09b94mr29610281fa.24.1717677740921; Thu, 06 Jun 2024
 05:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605231152.3112791-1-sashal@kernel.org>
In-Reply-To: <20240605231152.3112791-1-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Jun 2024 14:42:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>
Message-ID: <CAMj1kXHrpZzJvvi+4RaMVV5_tsEU62_EC-7MboHBbR1hTMgTcg@mail.gmail.com>
Subject: Re: Patch "arm64: fpsimd: Bring cond_yield asm macro in line with new
 rules" has been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 01:11, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     arm64: fpsimd: Bring cond_yield asm macro in line with new rules
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      arm64-fpsimd-bring-cond_yield-asm-macro-in-line-with.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>

NAK

None of these changes belong in v6.6 - please drop all of them.


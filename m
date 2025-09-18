Return-Path: <stable+bounces-180586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E2DB87050
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 23:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51E97BCFE5
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5188F2F5305;
	Thu, 18 Sep 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpGw0jGR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838F2F3C03;
	Thu, 18 Sep 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229820; cv=none; b=W4BgaaNW3Ejk6yNKJx5txuFJ1HPSOXqG43CuS6G80ApF+7qeKcJHJiHx99r60K9YU2XFMTkRm9zXQevrbHstfzDNMMsQMmmFH/uro9H9leeTdoUwSaY/H5/j6X3MvLgkSOKFNMHLeXwmWMG9lMtRuPtYUPXL1hhH21SfHVil/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229820; c=relaxed/simple;
	bh=L/0fJfUvECLEcb6+QI5nnYxmkm3fVlEfEg6i5rtgZPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3Tfd4uUfwN7Sca51S3yQcUj7CfLnUXZuKKgr6b0Q5nyvbkJARP881oI96HhEbfcmB9yY8qAw8HSeL4bs3RR0u3SNNyN0n66vfYkT28Q7mdzutGEEZqt7R2q3v/Dvaug88OOxdjJR4ANfj5A+PxUnhR8DTtt2SDVSTzEaX3GrWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpGw0jGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C3EC4CEE7;
	Thu, 18 Sep 2025 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229819;
	bh=L/0fJfUvECLEcb6+QI5nnYxmkm3fVlEfEg6i5rtgZPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpGw0jGRD9kwuFdEm1fzXk65vmgf4R+xGuDbhnIivUESJs1d1+qKqodEeD41Ukl4/
	 UllTfbSHFGPTJIaqwZiEyIQ/1fKPXOWR9I6BUA3j2XBdNS51uzI1JXx/s9wP652ymE
	 o1myDzCN1BPXTojyAYT82kWjzg5VUJHFv4RgWGs6cjJnOtK6yapWrp/wJLLNKkpBwr
	 tPuknM/4JI1jqFDDpjGvtCjCxUrRu2hzkr3OxL15JFPB8il9HTuY9UIcUJ0l9sNHv8
	 geOC0NJTlnKYBd+ETksupKw1HvUO+RtLCV2JqKbxHeA9dL6E+2eVLCfPj5tuXjg+mn
	 o3An2VAmWidBg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Fix CMN S3 DTM offset
Date: Thu, 18 Sep 2025 22:10:06 +0100
Message-Id: <175822310579.3544708.17568166573613612200.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <f1248eedc2d082c80f5299747acedc8decb94c70.1758212731.git.robin.murphy@arm.com>
References: <f1248eedc2d082c80f5299747acedc8decb94c70.1758212731.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 17:25:31 +0100, Robin Murphy wrote:
> CMN S3's DTM offset is different between r0px and r1p0, and it
> turns out this was not a error in the earlier documentation, but
> does actually exist in the design. Lovely.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix CMN S3 DTM offset
      https://git.kernel.org/will/c/b3fe1c83a56f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


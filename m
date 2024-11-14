Return-Path: <stable+bounces-93004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA39C8A47
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 13:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0500B24151
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE071FA837;
	Thu, 14 Nov 2024 12:42:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368561FA835
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588161; cv=none; b=mByVX0SwAxe649iLtZdNP/SxdBFt/yuxK4FTKQTzlfF7K9elPBIuaXbojg1PYzGTVmMxjs0X3E5hVfPrPqNlqSVfZOknRNe8xT3mx/ubM+mZztFsBDJ3Dt72JpKICJ+o48F7SggkgH/tUxxV+jgxJw1j2Mj0cYgbOphwheoPRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588161; c=relaxed/simple;
	bh=KHIsuz7Z+Oh2iKQy9jIzwS8P0koETxvnyTJEwR8sr2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKLe7I6V9/X2WlK61GjT3oQqBrR9guFd15G1VZfToHPkC6YwM/HbrovAEC644v14tRgoT6ieMIha24mkkJVVCUbz+pc7L7SKVCv0YH0Hz9UwygpNTr/G3hhl/FxKAYAp/LlNVGKpdXQKpLGO4uaAMrEbnMuV4z3gGYhwGcN88QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7468C4CECD;
	Thu, 14 Nov 2024 12:42:39 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: maz@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled
Date: Thu, 14 Nov 2024 12:42:37 +0000
Message-Id: <173158815061.1443752.2883549048176833544.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241114095332.23391-1-will@kernel.org>
References: <20241114095332.23391-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Nov 2024 09:53:32 +0000, Will Deacon wrote:
> Commit 18011eac28c7 ("arm64: tls: Avoid unconditional zeroing of
> tpidrro_el0 for native tasks") tried to optimise the context switching
> of tpidrro_el0 by eliding the clearing of the register when switching
> to a native task with kpti enabled, on the erroneous assumption that
> the kpti trampoline entry code would already have taken care of the
> write.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: tls: Fix context-switching of tpidrro_el0 when kpti is enabled
      https://git.kernel.org/arm64/c/67ab51cbdfee

-- 
Catalin



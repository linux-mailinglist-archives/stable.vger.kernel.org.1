Return-Path: <stable+bounces-208249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA3D173DA
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F77C302C871
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA37378D98;
	Tue, 13 Jan 2026 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRAjj62O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156A35C1BA;
	Tue, 13 Jan 2026 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292280; cv=none; b=YIABtmzLWq9yUxeXX/K6WNTr9RBIvvKg5xZZjUCQyP61oB/VdFiSau8CEjRbtqbrEXQjzz3mFBg3B1vGjJ/t0ZPXPCl/7iT72niYc7/nPkzjLgGeIuIt0UpDKy5HCEmZovENDLP4zfyhsay/UZeFxNCASpfhD0cFagwVWjtw7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292280; c=relaxed/simple;
	bh=hZKQhUVRzOmUIAQuGytTCJTx5cBtYB3L+1R1dsyuO5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GbTWJh9sZriVXyzrPQsCbhMTJeYpkR2dMVyjnwGcfazjEt5XuAOh4EYxxM9bzndGz/lrX+6kIh30Ebxm6ch3lCIv5sV2/FT7OM7V5h1lpx/88AKfQv48uCyonAWfsul7T+zx2bxFLnbrGglDEjU8wQfuKQH+2Q1mGBESrsswBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRAjj62O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE9C116C6;
	Tue, 13 Jan 2026 08:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768292280;
	bh=hZKQhUVRzOmUIAQuGytTCJTx5cBtYB3L+1R1dsyuO5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CRAjj62ODPQdXh+6FN2GsD6AcG2lYecH36VJewBax+dzwagHdEDZES9nLxkr7JMBO
	 teMD78Y1IJd71FTC4MbNW6WamLUhA9YnDaT6FVj/CuvHccGXU5P+zzpDzcj/VDLL+3
	 umdw3J29G00NdDrRvsjdNx+Iv0y7j+a4r74NUSkxr6iOpO0HsKTcEwLYifFxLXRW56
	 6PjuUT4oVG+obAtgppwQvQPzY9+pzd+JqhPceUzJKOMCCYAhvTpTPT99CkKZcs9iit
	 QQLCKHKRP9z0kE8uwDYDRZfrjX57uuK5b6ai9M5ftYvLouTqr4WRHkGbSOxVL48PKq
	 VgED3Eg/XYPGA==
From: Thomas Gleixner <tglx@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, stable@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v1 0/3] mm: mm_cid static initialization fixes
In-Reply-To: <20251224173358.647691-1-mathieu.desnoyers@efficios.com>
References: <20251224173358.647691-1-mathieu.desnoyers@efficios.com>
Date: Tue, 13 Jan 2026 09:17:56 +0100
Message-ID: <87a4yiexjf.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 24 2025 at 12:33, Mathieu Desnoyers wrote:
> Here are 2 fixes for missing mm_cid fields for init_mm and efi_mm static
> initialization. The renaming of cpu_bitmap to flexible_array (patch 2)
> is needed for patch 3.
>
> Those are relevant for mainline, with CC stable. They are based on
> v6.19-rc2.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Cc: linux-mm@kvack.org

Reviewed-by: Thomas Gleixner <tglx@kernel.org>


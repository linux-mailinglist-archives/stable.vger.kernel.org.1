Return-Path: <stable+bounces-144615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEACABA009
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018FF1BA4D7E
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ADD1DD877;
	Fri, 16 May 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXR7+1UJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74811C4A13;
	Fri, 16 May 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409883; cv=none; b=NBty8CCl/gsZnT3YAvZJIv+zpsIUmDNLnnvqCLyWUJxTh1cP0BcuH8wTwMapSCwBSGV5GLhesufCQ2+ofyT4HhD1wrCcLznwQ+0u5mu58Hbd6kzeiY/QpQy/+yW4E+NNhItwPN7cMAHAMiXEpIsYqNK29pVvAHlSl0WLFEWDVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409883; c=relaxed/simple;
	bh=mWfA5wFotzL7PgvhLsuhMnP0blXpL73q8Aed7VwJXjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNnzQuMf27SW4wvac0YfIZ8gTrJvO0LkpFLUb4ZyTr7nKwQNQnd0ZGWy3Sfxlo3lbZOvYOfQNmWWgqkyRa+FCMtfK9W2d2SCZBu6GBjks3silq4NVaJjRNbB7bjA5cUdOWSVXFJH+m6j5E61hl4MjD9/3aNE/SHPjVxtLZXT54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXR7+1UJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A443FC4CEED;
	Fri, 16 May 2025 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747409883;
	bh=mWfA5wFotzL7PgvhLsuhMnP0blXpL73q8Aed7VwJXjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXR7+1UJQRenyC+XQwFTOEdHhgEEiVar1Hn/5duO4TJs5Bd/gwUufTuX5FHcZtGC4
	 zGzDr7ItcG0BEdLjxtSE2nJnImE0ejnGSIFkJWDxMIby7eODAn2rydigNVxGrVjzN3
	 SOGelPJ8WIWfriWL+bIKYaN4Ak7ti+WbW3uIf+dI7kSw+4IzDFKbicg2qY9pxsahyW
	 X4c31GqKelZ3ccSzH62l4COQXLcS7IERUKlxBKxlMolYp9QCAKQ/kNypyptbCYxdCi
	 hHcuySGy4QnSsM443IDg4DWlGujuOLpKOi7U1ZJS67sxNM1DQs/O4svFlHQf/sEfc9
	 KbwZRpDJMkU+g==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Initialise cmn->cpu earlier
Date: Fri, 16 May 2025 16:37:47 +0100
Message-Id: <174740513926.2577946.7646762362706357412.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b12fccba6b5b4d2674944f59e4daad91cd63420b.1747069914.git.robin.murphy@arm.com>
References: <b12fccba6b5b4d2674944f59e4daad91cd63420b.1747069914.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 May 2025 18:11:54 +0100, Robin Murphy wrote:
> For all the complexity of handling affinity for CPU hotplug, what we've
> apparently managed to overlook is that arm_cmn_init_irqs() has in fact
> always been setting the *initial* affinity of all IRQs to CPU 0, not the
> CPU we subsequently choose for event scheduling. Oh dear.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Initialise cmn->cpu earlier
      https://git.kernel.org/will/c/597704e20106

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev


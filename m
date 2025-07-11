Return-Path: <stable+bounces-161672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1BAB021D5
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11151C80F92
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986432EE999;
	Fri, 11 Jul 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvY8zaq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A5167DB7;
	Fri, 11 Jul 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251446; cv=none; b=L09WHT/tIT3d9ZIpjxlgY9tJXmJ7Bwn7cykVmQziovTQx0Wa7NIuWbfzWctBYaSeyDIQuIunF+cth5nWtzmjCRrbi/m/z8d+YO/4pPMpm51tItwtCeY+aW/lzbJmA/+cGqgB8i+jnkAKq6zf3eM/lNgTY36Il687JyjFXtaOr7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251446; c=relaxed/simple;
	bh=RTEJVfqsliHcfLirkYxlG9p1Pmh0QT6gF3+ptlk8e6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=peLmN6/ugflftPU1Eu2rMQYxqXJi2Y63kAZMtbHx7AZX4LeXnL3he28MBUm00w5zVWz3ag/NjcIDpeiddPRKbe70UOLn7C1YXyjItR9jNgxcrcrh6/B/QyMun44l6ifu0q3WnmOKhwYRtevSQ3X5ZE90XAUwgPX1O/hS4uCWbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvY8zaq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5937C4CEED;
	Fri, 11 Jul 2025 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251446;
	bh=RTEJVfqsliHcfLirkYxlG9p1Pmh0QT6gF3+ptlk8e6Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QvY8zaq9DsENMfYjqHArKsKNyhfKiIPgl7gpGhXQm6GljFCgk9PJSSiT+N5bOnd89
	 i0v9HIhSgD8OYSIc2rSTo3jdlfGOOii+Rucy3S6/8wIXtG4jJE8s4btYyzN70hP/86
	 CDUVwFJ+BLF3IBhApXXa5noWTmiwI9Nclyb7swbakRYkBzrAbw4by3d4xHm2Il1ZWz
	 tdRBRyU7/WHl9koVVzyaMRSCrJnYMCXWNXJHc2gnJZtDEL+KsIerrLCo0CVbKKLrDe
	 N2s1p6lrd9uemDT7067swjDG+vIKiIwhDGSka2LF4I6ybFkdff2mNzNReDnKOQHTzN
	 2vxUGR4f8+5og==
From: Srinivas Kandagatla <srini@kernel.org>
To: =?utf-8?q?Steffen_B=C3=A4tz?= <steffen@innosonix.de>
Cc: stable@vger.kernel.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250708101206.70793-1-steffen@innosonix.de>
References: <20250708101206.70793-1-steffen@innosonix.de>
Subject: Re: [PATCH v4] nvmem: imx-ocotp: fix MAC address byte length
Message-Id: <175225144346.5072.8813469254272254047.b4-ty@kernel.org>
Date: Fri, 11 Jul 2025 17:30:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Tue, 08 Jul 2025 12:12:00 +0200, Steffen Bätz wrote:
> The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
> extension of the "mac-address" cell from 6 to 8 bytes due to word_size
> of 4 bytes. This led to a required byte swap of the full buffer length,
> which caused truncation of the mac-address when read.
> 
> Previously, the mac-address was incorrectly truncated from
> 70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14.
> 
> [...]

Applied, thanks!

[1/1] nvmem: imx-ocotp: fix MAC address byte length
      commit: d102a7924f4459770d1f30212d600d1f16d79f3b

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>



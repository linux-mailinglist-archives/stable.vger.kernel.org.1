Return-Path: <stable+bounces-19724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045CB8532CD
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF131F22461
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAE5733B;
	Tue, 13 Feb 2024 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqqYg8x6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4FB5732E
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833813; cv=none; b=iyLlb3DLXPSpBTK4h100aJ5TTem0HYjow9uTpQ7IG5NK8A2AzEnBC+On+fEoeeCfvMZk4L++bOux1VP78Mz/GxGWEAUEMVi+2xjjBrVAhmQ1jTbLE9C0bbXJp1ISabV2Xyyv46Q1qEmKd89JJX8n0rwUN1xboWfBbsTTjyudUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833813; c=relaxed/simple;
	bh=JjGy4cgtOMki+9z1u+IdHYNbKMQ2ke/cptmHh0GGrhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSXXcFhEZKXJub+lfJ2bY+dfe7QMs3Y182SwsGdLUiOUXtq1ojFu4ED5A+Bvo3RYqSMqqpxUW0milhY6Alkguiw9u2NIkFEGaH0mR5SqsrRnj4Ni8qyppQ3SYQXA6CJyNNq2b+pb4aGyND7uvj97/ddVm+aM02LiuMgUXj4A7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqqYg8x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3403C433C7;
	Tue, 13 Feb 2024 14:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707833812;
	bh=JjGy4cgtOMki+9z1u+IdHYNbKMQ2ke/cptmHh0GGrhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqqYg8x6y9HOBwyY+wHVedMJcXwvUsp76ENv8uViUEhfsKqkSJnXkeU5w3mYpgQXV
	 A/1pK8Ayp4GkY0SdlQrjFqgHgjF29eeK0xayJF3ZL9VWQV1RC5IslpXvr8JvnOFAs1
	 yj8ujd8tMVHomXXTNjwPQbfPUcfr5WMdHsl7wmCR+p2vxhzI5o8LP+kBRW7TKui/MP
	 QWYKO0M0ybQ73mA0PhZI+ri7oN5Z3fWE3JQWOS8vwR52zVZwuEXv9/p3OQwjfEEd4Z
	 my19bI/ySzuKS5pin3SQ4x6TPQcwBpSDmSxcAvm2zrkCpu+kuR446VwB+bMjJKccrV
	 y4AboqTzZuhjg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rZtav-00000000095-1txd;
	Tue, 13 Feb 2024 15:17:09 +0100
Date: Tue, 13 Feb 2024 15:17:09 +0100
From: Johan Hovold <johan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: johan+linaro@kernel.org, bhelgaas@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] PCI/ASPM: Fix deadlock when enabling
 ASPM" failed to apply to 6.6-stable tree
Message-ID: <Zct55VEPNGX2ThvT@hovoldconsulting.com>
References: <2024021328-stylus-ooze-f752@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021328-stylus-ooze-f752@gregkh>

On Tue, Feb 13, 2024 at 02:25:29PM +0100, Greg Kroah-Hartman wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1e560864159d002b453da42bd2c13a1805515a20
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021328-stylus-ooze-f752@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:
> 
> 1e560864159d ("PCI/ASPM: Fix deadlock when enabling ASPM")
> ac865f00af29 ("Merge tag 'pci-v6.7-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci")

It's probably not worth trying to backport this one further back than
6.7 which had the commit that introduced the issue.

If the offending commit itself is being backported then that may
possibly affect some Intel devices, but this fix would not be needed for
Qualcomm platforms before 6.7 at least.

> ------------------ original commit in Linus's tree ------------------
> 
> From 1e560864159d002b453da42bd2c13a1805515a20 Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan+linaro@kernel.org>
> Date: Tue, 30 Jan 2024 11:02:43 +0100
> Subject: [PATCH] PCI/ASPM: Fix deadlock when enabling ASPM
> 
> A last minute revert in 6.7-final introduced a potential deadlock when
> enabling ASPM during probe of Qualcomm PCIe controllers as reported by
> lockdep:

> The deadlock can easily be reproduced on machines like the Lenovo ThinkPad
> X13s by adding a delay to increase the race window during asynchronous
> probe where another thread can take a write lock.
> 
> Add a new pci_set_power_state_locked() and associated helper functions that
> can be called with the PCI bus semaphore held to avoid taking the read lock
> twice.
> 
> Link: https://lore.kernel.org/r/ZZu0qx2cmn7IwTyQ@hovoldconsulting.com
> Link: https://lore.kernel.org/r/20240130100243.11011-1-johan+linaro@kernel.org
> Fixes: f93e71aea6c6 ("Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org>	# 6.7

Johan


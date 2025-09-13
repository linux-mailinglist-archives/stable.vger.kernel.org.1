Return-Path: <stable+bounces-179427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF1B56093
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CA57A47FF
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A956F287241;
	Sat, 13 Sep 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJSJjSVw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DC27FB21
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757764135; cv=none; b=CuDZT50GCbbr5JSyUuuWkn4a+szX0pqYvPfTu6a4rg14YovewSuuq4WLGBluG7R8+1Oa9Ch37JAgy1MGWKdK7uMuqgMI+vXwglQxojk4pMqa5r1xquoo/XeI00sBI9cqVFd1gZjpBBCvylyXw5xlar/2n8AHpkZoh1wdp7lxXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757764135; c=relaxed/simple;
	bh=W6wwIaeYDdQRHXSqXiAivNOHn3P3oPwCST2cVnPmir8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTJBFjs+3qieT+ZJm5U7L0meIpu8fOkx5CX7OMOSLDnCE4nLS9GV3dKyifuhKkDea2t0lRu8HY+thmR2Co+fZ0GoiJhMqf2zVmWlimmVJgHEe+2ffkVOyhg519/tlPuGtKnxIcADpvI7sqqtN+8WZ58AFweDJ06o8WEYxvz7Fr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJSJjSVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB92C4CEEB;
	Sat, 13 Sep 2025 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757764135;
	bh=W6wwIaeYDdQRHXSqXiAivNOHn3P3oPwCST2cVnPmir8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJSJjSVw3ohGtjg656ig8RgD50X2xLXvj6GlPip829+JfxkOsPPROx6ihlHmtfE+F
	 3aZs57UeL/XHhIMrplXU6sfvMsY7bQamPbvG4OJXOdInHmp+eDakEVddGjRoW/hg6b
	 CVweSe97GSnVTGAFLqLF5cGLhOg1ZNIM7ObuocCc=
Date: Sat, 13 Sep 2025 13:48:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport rcu-tasks fix to stable kernel version 6.6.y
Message-ID: <2025091336-wildlife-grumbly-334a@gregkh>
References: <38f790d0-aae5-467f-bb1e-c7bd33ddffe7@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38f790d0-aae5-467f-bb1e-c7bd33ddffe7@linux.microsoft.com>

On Thu, Sep 11, 2025 at 01:35:33PM -0700, Tahera Fahimi wrote:
> Dear Stable Kernel Maintainers,
> 
> I am writing to request the backport of the following patches to stable kernel versions 6.6.y,
> addressing a deadlock issue in RCU Tasks related to do_exit() on preemptible systems.
> 
> Issue Description:
> The kernel may experience deadlocks due to shared locking between exit_tasks_rcu_start() and
> rcu_tasks_postscan() via synchronize_srcu(), when multiple processes exit concurrently. The problem
> manifests as stalls in the RCU tasks grace period. This issue manifest as a deadlock in WSL kernel
> which uses the stable kernel 6.6.87 (Please see the issue on https://github.com/microsoft/WSL/issues/13480)
> 
> Patches to Apply:
> Patch 1:
> 	Subject: rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
> 	Commit ID: 6b70399f9ef3809f6e308fd99dd78b072c1bd05c
> 	Justification: Introduces per-CPU lists for exiting tasks, replacing SRCU-based waits and
> 	eliminating deadlocks during concurrent exits.
> Patch 2:
> 	Subject: rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
> 	Commit ID: 1612160b91272f5b1596f499584d6064bf5be794
> 	Justification: Ensures all exiting tasks are properly gathered and synchronized, preventing
> 	missed synchronizations and further deadlocks.
> Patch 3:
> 	Subject: rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
> 	Commit ID: 0bb11a372fc8d7006b4d0f42a2882939747bdbff
> 	Justification: Periodically enables interrupts during per-CPU list traversal to maintain
> 	system responsiveness, especially when many tasks are present.
> 
> Kernel version: latest kernel version in 6.6.y branch

Now queued up, thanks.

greg k-h


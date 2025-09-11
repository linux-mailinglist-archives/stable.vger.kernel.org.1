Return-Path: <stable+bounces-179310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A73B53D30
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 22:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905A11B25D58
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02A28A731;
	Thu, 11 Sep 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K+g+U+5w"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E923F40D
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622931; cv=none; b=HhT+Xb69Fy4xOfcSEQefi9Nx3tOzsz3m1bISNwynsdhMcVk/dhWuk/7oYIUADBA5gk7+EdyGp3HR3slpbJq9YjvXInuqkspKfftoJVE0SL5duqxgFp3SmmP6+QQqSQRaJMwxklrS/qmuWmGf7wM8TjEuAygNpthytzk5XIT1nEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622931; c=relaxed/simple;
	bh=yFNSilNHL8JuECHouCrZpRSMJcwNfp6ZFDROPRhkbfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=BUjBVwt6ZrdLEskCTwp3TVTgOjbjQadIcRrPKNgcchWREht2LW880IzGLkK5b0XRfAMFzx0ikbiVTqrIb19haynqPMZbwMwyTdp+1vSfWcYT+2/jjFrUARIrT5CvmlCqb1HsR0+/3RgK8lKCq5JZvNW7X6RW+xejLafro5E333s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K+g+U+5w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.131.143.15] (unknown [167.220.82.15])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8CDEB2110801
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 13:35:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CDEB2110801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757622929;
	bh=b+5Ob1LblBDvQPzZVL9dVWH6v22GKN3EgjOSS1/Slpg=;
	h=Date:From:Subject:To:From;
	b=K+g+U+5wgUEarfzc9rRzGWPl9VOBgRjvs3H0In6yktFoKV1Kp6hdXLW9eYG+eEd7A
	 syqRsGTxX+o3g0MSpa5GfjtQZhtvdYhquRrKnaE/PSKZreaMPUFt+xQNflgNpgtNe9
	 t8O+uO8LnGNDo/SMoL24cpuFrwETQQuEuAB29eac=
Message-ID: <38f790d0-aae5-467f-bb1e-c7bd33ddffe7@linux.microsoft.com>
Date: Thu, 11 Sep 2025 13:35:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
Subject: Backport rcu-tasks fix to stable kernel version 6.6.y
To: stable@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear Stable Kernel Maintainers,

I am writing to request the backport of the following patches to stable kernel versions 6.6.y,
addressing a deadlock issue in RCU Tasks related to do_exit() on preemptible systems.

Issue Description:
The kernel may experience deadlocks due to shared locking between exit_tasks_rcu_start() and
rcu_tasks_postscan() via synchronize_srcu(), when multiple processes exit concurrently. The problem
manifests as stalls in the RCU tasks grace period. This issue manifest as a deadlock in WSL kernel
which uses the stable kernel 6.6.87 (Please see the issue on https://github.com/microsoft/WSL/issues/13480)

Patches to Apply:
Patch 1:
	Subject: rcu-tasks: Maintain lists to eliminate RCU-tasks/do_exit() deadlocks
	Commit ID: 6b70399f9ef3809f6e308fd99dd78b072c1bd05c
	Justification: Introduces per-CPU lists for exiting tasks, replacing SRCU-based waits and
	eliminating deadlocks during concurrent exits.
Patch 2:
	Subject: rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
	Commit ID: 1612160b91272f5b1596f499584d6064bf5be794
	Justification: Ensures all exiting tasks are properly gathered and synchronized, preventing
	missed synchronizations and further deadlocks.
Patch 3:
	Subject: rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
	Commit ID: 0bb11a372fc8d7006b4d0f42a2882939747bdbff
	Justification: Periodically enables interrupts during per-CPU list traversal to maintain
	system responsiveness, especially when many tasks are present.

Kernel version: latest kernel version in 6.6.y branch

Thank you for your consideration.

Best regards,
Tahera Fahimi



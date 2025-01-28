Return-Path: <stable+bounces-110931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46CA2040A
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 06:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65C418844DC
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 05:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30D176AC5;
	Tue, 28 Jan 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QjFBuzhe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991413F43A
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042510; cv=none; b=UKT+ykm6WSMIqgoiOKK6rCOBQbTGn3wvVl4+VwGz3Lmn+H4cN+yBZMPAurHo5aVPFhBa9lflobPaHedxKEfvRwg8DRPPfykb8H8mCaZf0zjFhsCYugt4cfh105X/oDKo52l/L4MErEWsugXJVQNW1svEuv80Zq8iNJRV7sGE/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042510; c=relaxed/simple;
	bh=aeRPe8YSFi4Cwz4VVzW1IX7Ahny8g1dGEuAviKr5ffg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4VoOj6OuvK3QjQxpsJaMEGAIZpTutPi1mjpUR6tA2iAiyg4iZqkT6KFvihX8RjcF98S5LMUdIX5EpJCVz4Rd41nBNOxSoCwe0H2LK9fG+qZ5sv7Z+8YUZjBUlV4lt+FsGA5AH3WiTjjXKgD70ACMT515n8AlpQcFs0KI1SWpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QjFBuzhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63D1C4CED3;
	Tue, 28 Jan 2025 05:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738042510;
	bh=aeRPe8YSFi4Cwz4VVzW1IX7Ahny8g1dGEuAviKr5ffg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjFBuzhenIqPh5xtW80CsMXghG6u0M9Nx8EjcDTYoE32EG76jAuv+ngTJOvtIg/dE
	 /mT0p7k3SDrGlp9tY3pVF6pqV6hQPvIobbwg/qwBoOtkQ+BfBtztu2ngyjbaeEGFtJ
	 K40Pp8Vn0E2lkNjtWCcCl/NIfiCzqQQxrhRbPntA=
Date: Tue, 28 Jan 2025 06:35:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6.12.y] scsi: storvsc: Ratelimit warning logs to prevent
 VM denial of service
Message-ID: <2025012856-written-jarring-4843@gregkh>
References: <20250127182955.67606-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127182955.67606-1-eahariha@linux.microsoft.com>

On Mon, Jan 27, 2025 at 06:29:54PM +0000, Easwar Hariharan wrote:
> commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
> 
> If there's a persistent error in the hypervisor, the SCSI warning for
> failed I/O can flood the kernel log and max out CPU utilization,
> preventing troubleshooting from the VM side. Ratelimit the warning so
> it doesn't DoS the VM.
> 
> Closes: https://github.com/microsoft/WSL/issues/9173
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

What about 6.13.y?




Return-Path: <stable+bounces-208173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E4D13CCB
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 16:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75C693032127
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB43364040;
	Mon, 12 Jan 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzhRKxsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41934EF1C;
	Mon, 12 Jan 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232813; cv=none; b=el1ZC39toD2GJBvxUdcaraCOh0p5yH94kX+jYhLh2csCysNY/gFOg036fblvpIkq2746fEAKbke4uW91VcDktftznBHQ/UZb2Tv7lZbfVrFMtJzk4jLeGOM6aZYR75lEMTOOIbwrmAYo0gs1J3r/Vf2GRRd+7xg7o+Nd0LKCf5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232813; c=relaxed/simple;
	bh=JEeaRryvCEJ/W41M0JBPJiMLbD1SKq+cht4PwCoyAKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsaoEU2URjJ0kGenCvE1Hvu4wMmS2OqZFIu2WqhrJvVAMYsmgToz45fkFqLNS/8kH7wa9R6E5FuTzcc+mlb0NRtpNPN4AlKprJJ5v7R+FTebB70uuAm09KdIf0mciF83kbU4112xWjKbee72aPELFJhB1XTZ3makMnYOpw0fG1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzhRKxsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4532AC19422;
	Mon, 12 Jan 2026 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232812;
	bh=JEeaRryvCEJ/W41M0JBPJiMLbD1SKq+cht4PwCoyAKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HzhRKxsRlhqCAiWzSEiMSQZQDqlq/ySiuzXFs720/BU7rqJckInmInBEy/v/VASUb
	 OLXslX69v2sY2Ij2MoVNx4oNU50PENWyQKeMdaqyUQRRjSLIG4eaQUvJ+mh9oqZDhe
	 CgjztB4su9fUU9C3oQclrEdEPird1v+rKTTKRmzIoqm2GC1ujwqAC037OLbwfOgPjr
	 usQ7e4Qvh6zHFscn+NToTXYczmv5MLX1PNBWw099YLFMv/iU/qgVgGYZMxz4xIGCT3
	 ZBEZ6DrI2P8w2wH/54nhFiSUxlvUdYCAiyKqnonZj5Xhy1SyPQpg728YyPsb1OJDe+
	 SHDtJUDUXiBdw==
Date: Mon, 12 Jan 2026 10:46:53 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Laura
 Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org,
 usamaarif642@gmail.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Message-ID: <20260112104653.301e1177@gandalf.local.home>
In-Reply-To: <74f52o5tq2nodc3otsvknrsf2rpzphtaba7lxia5u3i7322vni@giqfw3ofnnyk>
References: <20251231-annotated-v1-1-9db1c0d03062@debian.org>
	<aVwp_BJx84gXHPlD@willie-the-truck>
	<20260109145022.35da01a3@gandalf.local.home>
	<74f52o5tq2nodc3otsvknrsf2rpzphtaba7lxia5u3i7322vni@giqfw3ofnnyk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 01:42:47 -0800
Breno Leitao <leitao@debian.org> wrote:

> > OK, so by adding -DDISABLE_BRANCH_PROFILING to the Makefile configs and for
> > the files that were audited, could be opt-in?  
> 
> How to do the audit in this case? I suppose we want to disable branch
> profiling for files that have any function that would eventually call
> noinstr functions, right?

IIUC, noinstr is mostly used for the transition between user space and the
kernel (interrupts, exceptions, syscalls, etc). There shouldn't be any
random calls to noinstr functions unless it's going into user space, right?

-- Steve


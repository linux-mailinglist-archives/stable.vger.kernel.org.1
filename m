Return-Path: <stable+bounces-57996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3C926D62
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 04:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27728282A89
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8B12B82;
	Thu,  4 Jul 2024 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCFgzSWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B829746E;
	Thu,  4 Jul 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720059517; cv=none; b=tlpYESLHymoSUyGBcoCxS4udvSfskUTZcwcvXNYrisFruEx8n1IhryLRXlTcalT3oruhg8dI4XPmdoBWSRMqBQyyde1fzG29An1CJ5JHJvaE6kI4Ll2ONWS/47adPfF7p+3T2eJTfIRlKg83xbAl5PAKgW/RZLV4dtsWMrOVvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720059517; c=relaxed/simple;
	bh=bzxG6FQCK4DTM7wjB53HY0++y2BjGiKWfc9ZeGo4RZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMiAuEQ2SnWQlZLGh4hVBbR3NVAOrAkF/Y/DMLrYFPawWvNCNBjNgFajm/cD5C08Fucyi6Vbo7/+zdRt+4NY2N8KNO6GRxT8r/jF45GVLhI8au25KSRHCGH4lPp6DTJYRWP3LiaNWSz3Uw7WksIcqMDCXqSMrazvOAuK7LinPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCFgzSWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD3AC2BD10;
	Thu,  4 Jul 2024 02:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720059516;
	bh=bzxG6FQCK4DTM7wjB53HY0++y2BjGiKWfc9ZeGo4RZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jCFgzSWMImIi6srb9NugYrCifg2ICF3a660/AR9VIc9SY+/JC0+n7VbTxbWb/dlMa
	 ZGOWxZuAn7x8e0zBzCJ1WQeq0QkuNmUNq4b2kTzZ+a6d/7Nm4jI6b79tYINvj77HwS
	 0sFv3b7tISt77bxvcS5LiGipLD6O+A+y0ZGRQzPPoN58jR0wRto2wu4IHd9W76SeDP
	 zqEmMPt/FIm3r0bszMmmrj71h1ADalSqRGcxyMEcq3GUL8GnFzTSVnbPotrE3mEJJp
	 P1NrywAqtcpCsZe3+8WCNeqPBCGxpmS52bVn6gLQgEFo7kbBj507MS9JjZkEmEQZEl
	 RKkZ7gft9F3CQ==
Date: Wed, 3 Jul 2024 19:18:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Taehee Yoo <ap420073@gmail.com>, Pedro
 Tammela <pctammela@mojatatu.com>, Austin Kim <austindh.kim@gmail.com>,
 MichelleJin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 ppbuk5246@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
Message-ID: <20240703191835.2cc2606f@kernel.org>
In-Reply-To: <20240702180146.5126-2-yskelg@gmail.com>
References: <20240702180146.5126-2-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 03:01:47 +0900 Yunseong Kim wrote:
> Support backports for stable version. There are two places where null
> deref could happen before
> commit 2c92ca849fcc ("tracing/treewide: Remove second parameter of __assign_str()")
> Link: https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/
> 
> I've checked +v6.1.82 +v6.6.22 +v6.7.10, +v6.8, +6.9, this version need
> to be applied, So, I applied the patch, tested it again, and confirmed
> working fine.

You're missing the customary "[ Upstream commit <upstream commit> ]"
line, not sure Greg will pick this up.


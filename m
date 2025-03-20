Return-Path: <stable+bounces-125639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D64F9A6A4EF
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DE57A4874
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F085D21CA04;
	Thu, 20 Mar 2025 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i1iCmRPj"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA0421C9EB
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470109; cv=none; b=c8BSxHFrE87K31SQNIX3CkdQuwEwEkGLqQu3qyCWE5oyLGCRD2JwinNxCiUv2WqFZiRmAKfUlb6NeB5KQGAlNHtVVMmMYBdvATr/zHkPEyhKmSCsr4k3dQyNaT0cQw9o0N5q5aoPx5GeLp5msXcSG701F2ie+dddP2RHrlZhw4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470109; c=relaxed/simple;
	bh=T7vz6zVyLZ8Lpn3WyFzpjP+8wK0Ao+auEG5F9mLd0Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFP8QrHeqNlfLp87epN7bsWTdzE4Bg2v8Btvrwch4AeV84JDRi6eydjkLgCA0coXiEEhzT08SS00u/KzuYD2yGhzUoP4bKXVPdO10e7Slu1VfdSZpmL9z+AxSYTEKttlLSexK1mncOr96nmJ/2sfjMUXCFESzf0oTDolBKxs7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i1iCmRPj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742470105;
	bh=T7vz6zVyLZ8Lpn3WyFzpjP+8wK0Ao+auEG5F9mLd0Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1iCmRPjrTqCtCOcqJyxaCUW4HYKf5/b3wQvgcyGwlaO9zGSGCO9hqxWhnqkoyi1W
	 oogI6qPcJPeJo8AO4IiK/wV5efdWnwkFQSWPIf83YJ9Fo3JDJtEPe8dNJWM3g1Jdvb
	 zu/U19GQ665QVkhNXeGo0hDvYDcx98p0DmovZWQg+QysXXqBwrfQXGgVri+/wHFlwh
	 qH2Y4imCmj6228klajSmxlUt48TNL3a8w2ssPzU9as4L3FRirH1snrX6/5BQhepWRO
	 dQSf8M6HiQpitHLDfnsq31IbjnFvOwCGjkZ58LHtLdWGXf9Q0jnMDwCtDxAdP37Pec
	 zECOGG5jXy8kg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d88b:5c7c:6d41:68dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 95A4917E0599;
	Thu, 20 Mar 2025 12:28:25 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
To: philm@manjaro.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED unresolved symbol filp_close
Date: Thu, 20 Mar 2025 12:28:06 +0100
Message-Id: <20250320112806.332385-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On Fri, 14 Mar 2025 16:19:13 +0700, Philip Müller wrote:
> On 14/3/25 12:39, Greg Kroah-Hartman wrote:
>> Can you bisect down to the offending commit?
>> 
>> And I think I saw kernelci hit this as well, but I don't have an answer
>> for it...
>
> The same kernel compiles fine with the older toolchain. No changes were 
> made to config nor patch-set when we tried to recompile the 5.10.234 
> kernel with the newer toolchain. 5.10.235 fails similar to 5.10.234 on 
> the same toolchain.
>
> So maybe a commit is missing, which is present in either 5.4 or 5.15 series.

KernelCI is now reporting a pass on the stable-rc build (5.10.236-rc1),
though I was not able to spot exactly what fixed this.

Best,
Laura


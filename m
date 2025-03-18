Return-Path: <stable+bounces-124769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C78A66CD8
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 08:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A1819A0099
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27341EF385;
	Tue, 18 Mar 2025 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="idJSt6aL"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FB1B81C1
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284070; cv=none; b=oRhb/f4w3V7xv34nufsIVEqXNfg/y8XX3cb0k11+BJDS2f6ApgHpraGRS9F0yrCpmP3336MFxb3Eg448spBanB6vV1CL4Ver6INIFzS7AqZ+Fw9chGw5BeR5S+eJFVb71NH12UksI76W1/mxd533cpGtdXFbWKdgvDsGPKoCp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284070; c=relaxed/simple;
	bh=FyEpTVMAXHyHzYL5etlFHLqgUR6Jy8YUVW9FGFZ1aLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdZmESGrBe+V6czYB/H83mHiORuGoMajSQ6DVpTPJpOjUIfLMuUfAg+L+NFYGH8/3GE/JnHv4UwGm7n7eB+PoMuqI/yk7KOSZroqCnVAssmf4eJZHGq4ZvKwloeNKfaUEpx74nD1gYDEvz245FynVCgV6gZvP/+1Mhc9WQuOCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=idJSt6aL; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742284066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rf5qZHxtK3mCKSr6NpOLubF8ArBJB08AFgLuR4bU4a4=;
	b=idJSt6aL5RAJe0a7zDM+Ky/FAFqk8PDtJOrD9qwYXfp2wHIiLaoRkaFaAJBUQbyBuxF1jl
	t3nKzAOtAxb6dM2QJ5pnAw3RxGjfI9EPjFUlLdMPAvvOHa6cOgTjV09Nvmyqnva57ch8RN
	tA85gUndW9J8a4bZz7CcO60t4iV8Txg=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev,
	Will Deacon <will@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] KVM: arm64: Tear down vGIC on failed vCPU creation
Date: Tue, 18 Mar 2025 00:47:36 -0700
Message-Id: <174228404857.1652170.4192050516109561246.b4-ty@linux.dev>
In-Reply-To: <20250314133409.9123-1-will@kernel.org>
References: <20250314133409.9123-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 14 Mar 2025 13:34:09 +0000, Will Deacon wrote:
> If kvm_arch_vcpu_create() fails to share the vCPU page with the
> hypervisor, we propagate the error back to the ioctl but leave the
> vGIC vCPU data initialised. Note only does this leak the corresponding
> memory when the vCPU is destroyed but it can also lead to use-after-free
> if the redistributor device handling tries to walk into the vCPU.
> 
> Add the missing cleanup to kvm_arch_vcpu_create(), ensuring that the
> vGIC vCPU structures are destroyed on error.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Tear down vGIC on failed vCPU creation
      https://git.kernel.org/kvmarm/kvmarm/c/250f25367b58

--
Best,
Oliver


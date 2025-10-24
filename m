Return-Path: <stable+bounces-189244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A733C07409
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603801C281AE
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A50D22541B;
	Fri, 24 Oct 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM6yYU1E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A751DC997;
	Fri, 24 Oct 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322663; cv=none; b=iv+XYYvKQeBoLoI5qbFXDz6Y5V5zqP9BdzgSyIukgCCcm2mvk9qgj85DTyBlnGgN1Y4rn2E1sBH95qO8pUR9XLmxKsTHt0aX1bV1FbR7Z27fWBE//cRCg2DFpexcW3EcWoQZg2Dyz8lC1AHwaXs+GoJFALQwWE5GT6IT++Cf/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322663; c=relaxed/simple;
	bh=H7diD6T2VvAt22VMSasAL/ILfy7efjFZ2iYWqCWT09o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zp55nEXuEDqUzzI4ihYJmd4GB7IKmlQmWRtvKwlA/jj32uNyoFRwbQI9i39OSQBx+YNlO0Bb6VbwnPIs8t1NIHyunr9/kDuPzoEoim3JEGguoA97/PedyjrAbY0I/eamSmHdUCZ6THD2achjlkEfzla8j0fBzmivhn36tJcOp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM6yYU1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBF3C4CEF1;
	Fri, 24 Oct 2025 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761322663;
	bh=H7diD6T2VvAt22VMSasAL/ILfy7efjFZ2iYWqCWT09o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rM6yYU1E8iOOQFjtTl8Jo/klRzEi/E7UdXUyUShksymBBkz62ajzVmiwH2hDRoWe/
	 TWYb86RW7fuVBGrfSEdBmHD6wTOYzHIBK4PEd9ME/Oe7JDepUAm8DaT2GhsquVKQED
	 l2tRabtgzE2sUyr0EhTX0ibxhaurpxolrDN0TajBYVBloJpD1aRCCFC2a1I7dwwDha
	 zapx9uwQ0XTmi+JLu+M5J+Kc68ytFK4LQ/f69kv8BkqNMfjI3qV4z8TCI12Em7W0PV
	 N4ZiTfGsTeK8/EnwNOxxEqSuNDUPl7dC6xQReyPz4RctRziT9rTR2c4BNmzJKl6VmR
	 jvNAunAwOiuTg==
Message-ID: <25c97722-e05d-467c-908e-baa31e636a44@kernel.org>
Date: Fri, 24 Oct 2025 18:17:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Fix race in nouveau_sched_fini()
To: Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251024161221.196155-2-phasta@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251024161221.196155-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 6:12 PM, Philipp Stanner wrote:
> nouveau_sched_fini() uses a memory barrier before wait_event().
> wait_event(), however, is a macro which expands to a loop which might
> check the passed condition several times. The barrier would only take
> effect for the first check.
> 
> Replace the barrier with a function which takes the spinlock.
> 
> Cc: stable@vger.kernel.org # v6.8+
> Fixes: 5f03a507b29e ("drm/nouveau: implement 1:1 scheduler - entity relationship")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Acked-by: Danilo Krummrich <dakr@kernel.org>


Return-Path: <stable+bounces-135042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E5A95F21
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 09:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B424189848A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0DF238C17;
	Tue, 22 Apr 2025 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VsjrfWdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2201624DF
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306444; cv=none; b=PDywPTwrwE50wN4RoEG94wzBIsHon/R7WdY9oS1Lj+cNpARyNJCpLdcPFeAQCDv17vsgmq10q04ATyeITxyrj+cMD4dYmsjfy/p2TD0vG39WlpQYGw3+SqElxqu+nweoVhQrIqSLcpV9+oTXSaRaLfu7JyQtuvkzhYV+pwxLa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306444; c=relaxed/simple;
	bh=ENx89i/nPL5z13UFKAw1kpyDdjgNb8esMvQMZAAg8Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7dcG4yRHVmBXVt3LElipHUW5ydgm+eBMovUyuxPxZGVukiSLQr2B3m1YEf9tou8DuaKblo1FeELUYPlhDY37KtYNUx1Y8MXu/4LVAm1UtAtW9gVTVg5jAKbQP4qRDQuYdW6MD+Jy44yoNpgXSrboQmHlF7fxR0SxcF1tHUvQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VsjrfWdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA11C4CEE9;
	Tue, 22 Apr 2025 07:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745306443;
	bh=ENx89i/nPL5z13UFKAw1kpyDdjgNb8esMvQMZAAg8Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsjrfWdkWdteYKNV2LyfbAFrC+isUr6Axsr7jE6y+VOnxF52hoR98nY1IdP8T5TMs
	 O/Af46Nfs+GPTV3fJ30SyO7dMcSYPhg2TQpNPTzT112siVGxIan/+R525T0C6WPYmb
	 PdjhSHAdumbKZrc/Rr1j55Jc5lerVdSpzZVLwJaw=
Date: Tue, 22 Apr 2025 09:20:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org, kees@kernel.org
Subject: Re: [PATCH 6.14] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP
Message-ID: <2025042230-uncouple-ajar-0ee8@gregkh>
References: <2025042119-imbecile-greeter-0ce1@gregkh>
 <20250421154059.3248712-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421154059.3248712-1-nathan@kernel.org>

On Mon, Apr 21, 2025 at 08:40:59AM -0700, Nathan Chancellor wrote:
> commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.

Wrong git id :(



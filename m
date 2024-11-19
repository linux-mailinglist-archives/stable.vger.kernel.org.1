Return-Path: <stable+bounces-94051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7D9D2D86
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A098EB3D59B
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E58E1D220E;
	Tue, 19 Nov 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxZGSQzM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69F1D04A5;
	Tue, 19 Nov 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037195; cv=none; b=aCflfDykSd2g/sRos2WUTU8zB2/lYyoCq8GJFcUrKOOBfY4uhO6CbYlXVeQKcNejdE5+0MJDms0Fw3BK8CZSKg2sx8Jn9J6YpUgjpsf2I93RZCvA5AF4k7YIu3yEX1v634//TxHlGO8WP1TJyF2ZyKsiTAur2vNpeisjU/ooHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037195; c=relaxed/simple;
	bh=4FczEMCiPK8wpc3ODDtfIp947673ljSp+A5ZMU+Mb4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/ajTSYI3zrzJy7z2Iu789lz9Fwug8XouMa7i1UWJVQZ3ExUme57Kf2CQ8vAKfdwuqM6xsdoy51TcBYSPdXPfro6F13Ad+bDOyNua0D79ziUr5hnURE4S76nCYKCuquaAM9Qb56s4P3l/IDMrDZewfL/ZLa9dYD8OUrwYD0LfD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxZGSQzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6233FC4CED0;
	Tue, 19 Nov 2024 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732037193;
	bh=4FczEMCiPK8wpc3ODDtfIp947673ljSp+A5ZMU+Mb4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxZGSQzMVCI6uEHu93dplVVkrsdTohR0WxM4WtEDq7AF2Mff4O8vkVSW0/WThUo5g
	 y/ili1yUIiHysFTrFyFamiPgymnhVZCRyEdC00sU53EHw5FSGnt2DMjxaaVsarlycJ
	 6eJTKGLrg6TWLP+XdAWZAD7jNvQQZ0wcG96LJl54NZ6N+auBP5RpPRHpu0LXdDDcJQ
	 xJYo9rw6OOBgjIP7Ms2LuU+hIdPF3N+HbSyZKBt9vqKU0Gp1k13YvSWZpUgQ2HKFLR
	 y2fwh0uRchZIEC3XY+bxEYRRlBCyV+pOH5mi351oqNrpbK0ZZueekGj0kKnYm+3W7F
	 oZ+PYSOqM0DpQ==
From: Kees Cook <kees@kernel.org>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Kees Cook <kees@kernel.org>,
	nathan@kernel.org,
	ojeda@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	thorsten.blum@toblux.com,
	ardb@kernel.org,
	oliver.sang@intel.com,
	gustavoars@kernel.org,
	kent.overstreet@linux.dev,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	tavianator@tavianator.com,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang < 19.1.3
Date: Tue, 19 Nov 2024 09:26:27 -0800
Message-Id: <173203718634.3118906.4631874727014346327.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029140036.577804-2-kernel@jfarr.cc>
References: <20241029140036.577804-1-kernel@jfarr.cc> <20241029140036.577804-2-kernel@jfarr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 29 Oct 2024 15:00:36 +0100, Jan Hendrik Farr wrote:
> This patch disables __counted_by for clang versions < 19.1.3 because
> of the two issues listed below. It does this by introducing
> CONFIG_CC_HAS_COUNTED_BY.
> 
> 1. clang < 19.1.2 has a bug that can lead to __bdos returning 0:
> https://github.com/llvm/llvm-project/pull/110497
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] Compiler Attributes: disable __counted_by for clang < 19.1.3
      https://git.kernel.org/kees/c/f06e108a3dc5

Take care,

-- 
Kees Cook



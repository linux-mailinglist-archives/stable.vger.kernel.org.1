Return-Path: <stable+bounces-23594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C4862CA0
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 20:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172251F21366
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1426618E28;
	Sun, 25 Feb 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8dtAe6A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F031C02;
	Sun, 25 Feb 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708890457; cv=none; b=FMvF3o1SdxQZ6tpwPhHLHupFPqvarZxgnGjgbpLetVsDTKCjj5G2Vrv5emIbBpqeL/VZ0BoRUwv+LxtAL+auG9N3nNtNGV03V7qav6Ir+xyI8cGVO6XT/bLoQXE2z9tKIv+WDFIzGzfJzUOSHVsdnQWX5MI6Zg9WOapOuptHhss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708890457; c=relaxed/simple;
	bh=u0haz1P+/sNN5zGTJHNtVi/1bbc49F25gxabgkVm6vo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JLJXT6jw+3fDDni/1kdo/cPLkZEMa6Pq2/ro7M3k6x///ZKQrDAHm5NB4OzUQ48mYKN+wo7Vk+X4dGEhuOGuCxq0SvtFwcvxykXXJwEgK1hVPTVRPbDh1CTQfCTkWMtC7g/lse9UDcesEAp60w39gnXX+UF7mBLCczYOBpPkpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8dtAe6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC550C433C7;
	Sun, 25 Feb 2024 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708890457;
	bh=u0haz1P+/sNN5zGTJHNtVi/1bbc49F25gxabgkVm6vo=;
	h=Date:From:To:Cc:Subject:From;
	b=K8dtAe6AomyrcKlgd1jfQLy2xuWhAYD+IbbASwNiIVKWmESysEyq91t5upLoRfcm5
	 VeaDfQEIQsfZQdmaaNVlAURx3MPjzoxGiunZFcGo2BCueqk19JkW9/YPnKR/FqHAJ0
	 sYoLiKpmhhJhBtT/seblIpxNKwpzIpkuUtKvG6zO/oWb521ShwZon51FVr8sA4Q/9Q
	 ShamXlNFY1SzHD4QACH6PC1nYfIngqAsQjR+MFrXpHbdms+VJseyvPe4w77XoFawnb
	 kuY8ex5pYEU0bdm4hLAmAuDX3BEms3ld1yNTicBIVsywlMaxBPM35YfUUSzrmBRqCx
	 3VisTS9b9jsQg==
Date: Sun, 25 Feb 2024 12:47:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: David Gow <davidgow@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Erhard Furtner <erhard_f@mailbox.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Please apply 56778b49c9a2cbc32c6b0fbd3ba1a9d64192d3af to linux-6.7.y
Message-ID: <20240225194735.GA498058@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please apply commit 56778b49c9a2 ("kunit: Add a macro to wrap a deferred
action function") to the 6.7 branch, as there are reported kCFI failures
that are resolved by that change:

https://github.com/ClangBuiltLinux/linux/issues/1998

It applies cleanly for me. We may want this in earlier branches as well
but there are some conflicts that I did not have too much time to look
at, we can always wait for other reports to come in before going further
back as well.

Cheers,
Nathan


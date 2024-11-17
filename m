Return-Path: <stable+bounces-93696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7D9D047B
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 16:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490481F21BCE
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5381CCEED;
	Sun, 17 Nov 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlU8MEMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB5C2ED
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731856832; cv=none; b=btJZlnlXTbSRuCOxDhDucKraiKtHYOzd3zegedYGC87ecUaJUmXDpTUEVgkXDtubxxczIill0h43MQB2DWO1j2/Z5C2lRe4ji6GlJuRdrEx3RKnCxJWFAWD7B1/iWOO9QfTKuQLgW4RiS5arHeDQAk7QaemolVTT4BebEQiQ+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731856832; c=relaxed/simple;
	bh=B12OG5h6bckKorpZOxB+Qbne4qgwL+OiOfsXGUz1bAo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sdcD7xUJ/y28Uiw/DWzn+a88ZSkxnGaUq15j/a/rkseBVePRDRJljiChxDiv9/1VnrFutzRapUimR6dxbOTg+Fu1lAGuD6mZT8o+iMsUrB6cnfyg8MiPJESGgQtn5nS9Cx+o7Q+RKEfjt4LCzP0BtjdRYjsDnf1aGTYzbNnEhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlU8MEMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C29C4CECD;
	Sun, 17 Nov 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731856831;
	bh=B12OG5h6bckKorpZOxB+Qbne4qgwL+OiOfsXGUz1bAo=;
	h=Date:To:Cc:From:Subject:From;
	b=ZlU8MEMQA2KaDJzdEbrl6id4pLUH+lQytDAALIZ+jl/AFQNhix52QmMyXjUUEbrSa
	 4yhPyleiqdtH4hMrb3+GEXT0r8M4j5EL56OC05vBW3S3hXx7n0P7B7rcqd7T2D9z8T
	 fy+IKctNoBqynjrAFP/Rbz3+r190LKDwAURakHT78UakVAheFGLPb43hugwDDfnwax
	 31Y2vq2zBeaUMMI2Z7hO+rP+UN2pLPFs4ub3t8cKW0vCwMdj4vdlkCs3Zvrh3xZ/1d
	 vtbp4iFP+VMHb48lCY74KcKnadqzKOxHpqArko36mlwVkMYZs0y7FYTsh+5yKXkf4V
	 azibAtU8oq97A==
Message-ID: <62a02199-5213-4a6f-b2d4-7898a26344c6@kernel.org>
Date: Sun, 17 Nov 2024 09:20:29 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: james.dutton@gmail.com
From: Mario Limonciello <superm1@kernel.org>
Subject: Additional panel replay fixes for 6.11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A few more panel replay fixes have been made for issues reported on 6.11.y

commit 17e68f89132b ("drm/amd/display: Run idle optimizations at end of 
vblank handler")
commit b8d9d5fef4915 ("drm/amd/display: Change some variable name of psr")
commit bd8a957661743 ("drm/amd/display: Fix Panel Replay not update 
screen correctly")

There were tested by
Tested-By: James Courtier-Dutton <james.dutton@gmail.com>
on 6.11.8 base.

Can you please backport?

Thanks,


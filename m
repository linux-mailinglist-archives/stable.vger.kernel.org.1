Return-Path: <stable+bounces-9156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F98214E2
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD13B21064
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7BD9466;
	Mon,  1 Jan 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHcZN3Zk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AA9456
	for <stable@vger.kernel.org>; Mon,  1 Jan 2024 18:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35825C433C7;
	Mon,  1 Jan 2024 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704132704;
	bh=g3BnUiDaoBOi9TIDh5oeBCTTci0aIp+mTj+EpaJ20Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHcZN3Zkb4jDOXqtEs6tsJ7kk9hsWXRPAdo8T9+MhSXUO1hn8cg1jwII/y2Y0lr83
	 v2RnjuXRNFJljOASzp1d4q/WasS/sdKeYjplR0EM8QylpehAhV4+lhtIobNs1JOv8L
	 sQa19FI4vHVCqj7s3oPnCPFtvyBhZ8YHYCyjbAd1pcICQYPeRgym0WxcxtrjHfftv+
	 cHw4yotwy+ULVvjkQYl3oRVOD67acuY2kAuM1aKy1iEgRJmM8KC9xhoUXg7XdCQ8p9
	 DFcAteOuLh4ok2dmHgRYDRWITC9rl6CuUq/UfjwZtV3P4KSxQFh44avPygBm+y5iQH
	 AyxgkMMfjWOiw==
Date: Mon, 1 Jan 2024 13:11:42 -0500
From: Sasha Levin <sashal@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, smfrench@gmail.com
Subject: Re: [PATCH 6.6.y 00/19] ksmbd backport patches for linux-6.6.y
Message-ID: <ZZMAXlQc8uIrw5Nc@sashalap>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>

On Sun, Dec 31, 2023 at 04:19:00PM +0900, Namjae Jeon wrote:
>This patchset backport ksmbd patches between 6.6 and 6.7-rc5 kernel.
>Bug fixes were not applied well due to clean-up and new feautre patches.
>To facilitate backport, This patch-set included clean-up patches and
>new feature patches of ksmbd for stable 6.6 kernel.

I've queued up the 6.6, 6.1, and 5.15 backports. Thanks!

-- 
Thanks,
Sasha


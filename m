Return-Path: <stable+bounces-142892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E12AB0024
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D8D1C07D85
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7A280CD0;
	Thu,  8 May 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okmDCgtk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583922422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721105; cv=none; b=SxT2G4LUx6+p3AOVrKLB3nlLpmJRusO/whpJLuyEsw9jLAJ+HHaH4hVP/U6h4mlZCafdC3/Vs6j7xNDDpywDMMh2ljnvNRHazpxdGtrIH6j7aGHQOQdVaSih8NtH6G8KFtWqBbfSHEfu7NQgCbWs3keL1qImPZpUJ4nNw9gxhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721105; c=relaxed/simple;
	bh=ON9n22fPcsy6bRbrtb7T1rfgoOutSSlZA5llNn11EkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBqVZWi+950YVfQetTjPUNy0Xqxd2H1d7w0A1r0+BfH0rBp6v4o24ChUlA8JS5QFVKsZ86MVJja8OpJkPh2YglktI7G1FW0Dqx4o5QlZgvDwdpVFQ7p9OpVKlNMYNrfGN7k5uMnVnV4WsGKIDWwRcruoHN8cwhNGkMBaRtrggYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okmDCgtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF0EC4CEE7;
	Thu,  8 May 2025 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721105;
	bh=ON9n22fPcsy6bRbrtb7T1rfgoOutSSlZA5llNn11EkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okmDCgtkjx3Fft7h1oX+L1iM7HxKbzpol9etcQ5aSe6QH0fH5coXUGX9X42WfuRkJ
	 OC+EMdq8fTj5XerDgdMASR69KsGUkXcL00E/tNHH1SupVCTWPRPzNtEfbN2GMdljex
	 DSD6rMhGXO2SFFi5hWmrdj2Ry/zuVTl40h03kWm94v9dDLcpp3j4M3wEKxLqid/CKj
	 tZbjx85HJzBOdvehpwgdJufdSOdpyit6Fm+l7lf4CjjlgTnqK/Bn9REJdz+9/lAsrg
	 /u7Z6QaIIt0/ySsrto1Zp94nh5NV2CPlmYZf0/30pvRXeraMqw1XfCSegPrUny4PWI
	 zJINahs6KVWnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	superman.xpt@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.14.y] btrfs: fix the inode leak in btrfs_iget()
Date: Thu,  8 May 2025 12:18:21 -0400
Message-Id: <20250507080609-a1af134a5ce3061d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505150322.40733-1-superman.xpt@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 48c1d1bb525b1c44b8bdc8e7ec5629cb6c2b9fc4

Note: The patch differs from the upstream commit:
---
1:  48c1d1bb525b1 < -:  ------------- btrfs: fix the inode leak in btrfs_iget()
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |


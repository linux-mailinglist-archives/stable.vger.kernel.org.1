Return-Path: <stable+bounces-118496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C5A3E312
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D3716D48D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6B213E6C;
	Thu, 20 Feb 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW2ee8Vj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF2213248
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073984; cv=none; b=sLIsrV6+nX7sgx45iIMRcVRztirf45+MBUECNFVCrJoeEnY+sHPB+fdX85Wr/wnX0UnGLa84zIBzgbcGVuh0b/I32ZT/DA0GYpGVwHayqz+HTjefAZSG3CdG0LpWFLzMOkYmgNeqp2sLmJ5jbPV4QjuRcw5njYcfMNhpDL/fM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073984; c=relaxed/simple;
	bh=gT+/dtf7l6dyqRNDTTRLgxVavPeJwjFazxzv5yF5y4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsOROi/woaY/AFEfYb7NWnzgAJMROLi81hvkLtOKhHxk5SY1srz+UwBP5qpoLcIQQ4NNvrhdmalaEjmMTAODxv0FqP/Hrh79QN+vvdElfvcCXSwlFX4HfWeiDUYcuib8LnlVqo1efdVEm2M4lBbD9Y/gCuHZPLpHGP1pJ64hhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW2ee8Vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62893C4CED1;
	Thu, 20 Feb 2025 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740073983;
	bh=gT+/dtf7l6dyqRNDTTRLgxVavPeJwjFazxzv5yF5y4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BW2ee8VjsCI6fQ1QyMWg6L48DGuxY9L/2H5WjonzdX77Hcskzhck9qfcjUv4qv8B1
	 hsQckL8EYcHqzKkWsxI0qf3ZnlWF8VJ0kZYMWrNcJePoouRraYgqOBkfJ4ZFbj5swY
	 vpjaWCpd5jR4s6uI1VvFmFoubDeN1762A0+YbSsPnwFdWWnckSsYzmHOAJqxY9Hqw0
	 MsSXhLeS/Jk13H2cWHGzZmN+JjY6cyz5axQTZwj9UHFfs3xnTB9wgT1uhuToxRSC7/
	 quR2NHumfhGbJge2Gj9zQt1kd52Y+uDvsivrA4jzIwgtm0OYyUJt02CR2g7+J6OMAk
	 W7yQz5pC65aKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	catalin.marinas@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10.y-6.12.y] arm64: mte: Do not allow PROT_MTE on MAP_HUGETLB user mappings
Date: Thu, 20 Feb 2025 12:52:59 -0500
Message-Id: <20250220123630-be1fcd2241843e8a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250220155801.1731061-1-catalin.marinas@arm.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |


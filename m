Return-Path: <stable+bounces-135187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD7DA975DE
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5C51881D0A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9A29AAE6;
	Tue, 22 Apr 2025 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVTQXv9A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179D298CBB
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351162; cv=none; b=IEdWnDyZKXeghHCfGKXiCpSL90q7GmzHAnzU3cQ4ARqYKhWRttUC2YdFGrSlOR7vCsatXjfJqyW6CR/BPCDVTqyZecxiTFBUv2Ta8bjOas5HxpDhlyxq7DCU2nLveMhF+EIkI0jThtJlM9wMoaba0GL9RGoez5sZhJyk0wm37EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351162; c=relaxed/simple;
	bh=mioiwomoUhCsY2EXAT9ApWzlzy0wpBehYUlIRn1FZxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtcOnZKN4MryncWqFHCtRcyFavYEPEm3tq5kymnxhzN6tfK2uOYXVjSBtAZbBOqU8nEmo/XaXqH+XVGT42xWi601/g6jcbSsci7XBWU9w8ytoyZepHOPutp6gsxVjLqvuDwe4xZ+As72XRYvCAvIiCisU4siV/U3DKVyhyLD3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVTQXv9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16199C4CEED;
	Tue, 22 Apr 2025 19:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351162;
	bh=mioiwomoUhCsY2EXAT9ApWzlzy0wpBehYUlIRn1FZxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVTQXv9AEIocctTj7YLdypnk9FgomnVg2jDCc794Czf2lsA0MgPCIxcnI1a+WaWWd
	 oNvBfL3m6bKRwVMuTev7BO/bEXt7cpfQxSJOYVW+/je2bOo7uAmFj287pXs8br3BXN
	 mXPiDfehN7VJsr/fY09FVSmipjDz+2LYY1m04G3yuASabMjgv4NbtdqnUdeOxVngz8
	 zFqMLcoc7EwJ1Ji25TNrX8pxxj3AF8iXvbwrf2++9d5Nq4WkucUUEjQ8OSX1g3+0A1
	 cej/7LGErDIU68Wzg+CAkqEQIIef3qRRd+Sju4yqO+1BiockJuCl/8EsTyLSKQmW5j
	 6jHfOZZXvuS9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/3 v5.4.y] dmaengine: ti: edma: add missed operations
Date: Tue, 22 Apr 2025 15:46:00 -0400
Message-Id: <20250422134039-b16a8f0b417a5acf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422151709.26646-1-hgohil@mvista.com>
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
⚠️ Found follow-up fixes in mainline

Found matching upstream commit: 2a03c1314506557277829562dd2ec5c11a6ea914

WARNING: Author mismatch between patch and found commit:
Backport author: Hardik Gohil<hgohil@mvista.com>
Commit author: Chuhong Yuan<hslester96@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Found fixes commits:
d1fd03a35efc dmaengine: ti: edma: Fix error return code in edma_probe()

Note: The patch differs from the upstream commit:
---
1:  2a03c13145065 < -:  ------------- dmaengine: ti: edma: add missed operations
-:  ------------- > 1:  1b01d9c341770 Linux 5.4.292
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |


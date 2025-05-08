Return-Path: <stable+bounces-142895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF4AB0028
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954349C525D
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877DC2798E2;
	Thu,  8 May 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVejMwpg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A6280CD0
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721119; cv=none; b=vDah4Rop08d9n+CpHMJuJSGXZyUUBDYx39sd4mPDFHId2oUtZ8F8EyXgR3JTjatiKSfahN6InFaRyZup5lu9h0o5aX5R1HSSzJS6uQnowlYP4cruzhnqBn9rASkH4T19mC/ZxPT+Cl6QOvjly6CZjkLXScH5mLP/l9DvN5Lj360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721119; c=relaxed/simple;
	bh=AlZtkO0RrpnlFFXt3G4V2u+1cndHpeuQVMkoyNOkBuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFVDlmDQJ+i8hNVjQreJpvhXwsnOc3Z+pD68nLgdXbF2A962XAbarUC/P8IS3vY8Zn/u0u5hTaQIy6juYFlIDa3cvnD1FpKVtmhhcf0k/GkNpvbiUjzI2zqOafH5YERl6XFiajLOI7TrT8WW56OSEwvwJMrFZq3REwxYIKx+OzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVejMwpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26688C4CEE7;
	Thu,  8 May 2025 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721118;
	bh=AlZtkO0RrpnlFFXt3G4V2u+1cndHpeuQVMkoyNOkBuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVejMwpg4aubIKPv7LEDOYXpqgWm91l44ctDDjTKCbGZ10djjbGXMrocn/Y34blvI
	 xPmL6bpgK2CS8nbUs+wWs3XgUyt+BFOgXSlrkobx9LJWyhYWasZDZxbfTQJ4LHIH9u
	 McHEUYwFGz1h+4+yEeyjHl78Zg5RxXhxls4vxKo1gAE/hrjwiGWUcEwOZODp89mXEA
	 5+gEOxjdMRsHKThGbJ29gtcCksNXC9ONhE7RmWiE7mRWuzYW8nw1UJAIVZPGbQK4iO
	 rrG3Zm+mQHWpEfK3foQ6lXKjixyGjYC6GXJAiwwz17xmy8OPCilryEV6QC1czV8QDC
	 qb2dRPRxqdCAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tudor.ambarus@linaro.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] dm: fix copying after src array boundaries
Date: Thu,  8 May 2025 12:18:34 -0400
Message-Id: <20250507091331-0e5597c4cb20ab9e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250506-dm-past-array-boundaries-v1-1-b5b1bb8b2b34@linaro.org>
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

Found matching upstream commit: f1aff4bc199cb92c055668caed65505e3b4d2656

Note: The patch differs from the upstream commit:
---
1:  f1aff4bc199cb < -:  ------------- dm: fix copying after src array boundaries
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |


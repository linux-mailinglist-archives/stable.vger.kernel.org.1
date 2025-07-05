Return-Path: <stable+bounces-160270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C51AFA21E
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 23:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436451BC8A6C
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8126658F;
	Sat,  5 Jul 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDQsdpDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2E262FE4
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751635; cv=none; b=HcWqNMvhkuhIshQy6L+xj1C9KbfbI8xavu5CX1CdPCbet1VpA/5PY2aXWRYYVxdi/TD0Dcy4C0g594pENG6xzbjJ0sZem7T8V/mOI8T9hcvxGHV/lMLwTDDLQrXRA2GT8oiBxevi8aOnl5oDL0JfnzrA6ew6jWoUUfoldiCXOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751635; c=relaxed/simple;
	bh=Dv4AzDpk+VzMx+2zuOWfHWUXH4pNJaT8Ql/bgSeBOWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AS9SAb2tvbSfvOpYim8256eoDRKOSB1AaErux+MekGwVzys1DfjPQJyD7sfbslfnxWltKOgBfSOw93a4isIdSUhMRDt5C1t3dSY+M4/ub8q3+GigCCP4u0Z3U8NXZdMll+ZIXJe5P7euE2KRWF7hmZbfaurU1kbTV48j+YQrufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDQsdpDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71266C4CEE7;
	Sat,  5 Jul 2025 21:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751634;
	bh=Dv4AzDpk+VzMx+2zuOWfHWUXH4pNJaT8Ql/bgSeBOWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDQsdpDc1RrtJ5kcfd51nTEG+JZHFcnOqArPXzkrDx95wUh/WzYDmZYZh6CqyGymj
	 xCnQFjcmaGeZqGBb8w+EKD3RfH3GF3yLoECrOGD4F4vJ2daFiQLhpw0DFL3pKkSvfO
	 plQLj3Ga4vxRdRIsVgjV7zaNCwKKTnOB55NrBwDJJE41dpw4E2AZ7yDVITvuzxdwZl
	 qE6xKcKq1V8E8PAxJSkgjLA0+zSzDCbuf9kj99Ew3/kIaLpCo1cPbkpIcbabOylT0H
	 vO44JWAJ4zqeqRcwp+AO2kgrxZrGWoQsE6+UOSJJ+lqEfAlTWLQ8Uj37z1OGcT97Ml
	 /DH02UJW+bOSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Liam.Howlett@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
Date: Sat,  5 Jul 2025 17:40:33 -0400
Message-Id: <20250705112916-9d09937d9c6e6d22@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250704152336.143063-1-Liam.Howlett@oracle.com>
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

Found matching upstream commit: fba46a5d83ca8decb338722fb4899026d8d9ead2

Status in newer kernel trees:
6.15.y | Present (different SHA1: 0c23ae32bfba)
6.12.y | Present (different SHA1: 1d026fb05207)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fba46a5d83ca8 < -:  ------------- maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
-:  ------------- > 1:  25bfd68644907 maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


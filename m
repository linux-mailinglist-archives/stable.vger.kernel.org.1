Return-Path: <stable+bounces-163315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EEBB09938
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E72188DF31
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D213C9C4;
	Fri, 18 Jul 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGDcXFMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002513DDAE
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802482; cv=none; b=Ic/3MBMbFDbv5kRcaJyYsszDZd+uIgbe7xHbW23CYyeG44xgferuLGFkO/lCoKL0opYKfwTAMS//gq0jU7ntL/bRZCbWpbCIfD39oL9b7nBIrWPH9Ml1IP8Q6+wCAQquGV3wbJlUHBOhf7mBQ5pWmxkX00bRhAfq4ty+2jX+ou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802482; c=relaxed/simple;
	bh=1erUDSM1vxZP8NFoFlsF3ODclsLwJFks1oRRflLBu7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbxco43a+bXSK9HPqmVtYojXdj8RzW8hX2Gxm1ZC3ybJB7RtGHLJR8btXjK+d4bs87kYmAJCDBOH140LFhlsJE5Ir5sVmK/h7vZDofMonCmP/ILGrDgRMerLg5ouZWO19fJGm9hzkGy2DcWFeijxi8O0YHy8K4Qjdw1FHub9+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGDcXFMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BBEC4CEE3;
	Fri, 18 Jul 2025 01:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802482;
	bh=1erUDSM1vxZP8NFoFlsF3ODclsLwJFks1oRRflLBu7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGDcXFMnMEpbmWer/wmIHVAe8iYHea+OJodGv36Aw9YJLsmaQy5CcZCxfXDAjEccZ
	 pA8dFIBjiP1oSxYEnoGcyKgdmziSn+VJuO3maJ+7s3zonFkzWUBfqsA6hLYI6mGerA
	 tpTzgqIz1UCCW1PwOlMCVPTOPiwSzh3a14mUx+cEzvP2SG8DWi7LRZdwe8JrRRwFus
	 ++tAGl9io9HZc0wsaynVOsEbdkMjg3zP6Gz4KhqwxPFR4boze7ZeGmN3wry+fR8VnI
	 hnoukWd2XZ6HicFvSRP/4eT4IHTs2bli2uO9Gn4Dn21iIOQb1tvDfgILIg/651CUZx
	 tGpMN35p7mWXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 4/6] net_sched: sch_sfq: use a temporary work area for validating configuration
Date: Thu, 17 Jul 2025 21:34:39 -0400
Message-Id: <1752797234-2f11d75d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717124556.589696-5-harshit.m.mogalapalli@oracle.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8c0cea59d40cf6dd13c2950437631dd614fbade6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Octavian Purdila <tavip@google.com>

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |


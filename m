Return-Path: <stable+bounces-109461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1D8A15EA2
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B923A7167
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB754723;
	Sat, 18 Jan 2025 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhZuFH5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057C1F94C
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229259; cv=none; b=UW3nY6RuO53krL7cixS9p9wxT/IV+AsMoHqtWOE4h/YTAJHdBPKGCFITgqKaCR5IdWO8A+KH40mNGgR02baNraW6okzdTCk67fW6PqBP/4l7emhH309h2zZG1sbbBnImNp33vibWEcfugbShOHrg4uw7LN+TKzerAgpME8edLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229259; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONQE8zofGGA40nGbp+lom4XeGw17a73i4aEn2VoMoeCUp5FkWi7VTV196GdVStGNCrFzxhfwsjfGLk1PRf7KvxyHWjXwDsyso3cWdsaZJumLnXe+KKNxeSBW4+RHV14lJgHxvaA0fL72aktAzuSMjTzOlhZ7koucwvN8DAWp10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhZuFH5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE996C4CEE3;
	Sat, 18 Jan 2025 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229259;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhZuFH5ppMpulCEq6s8rGyKRecW0jgqGRpD5sEWgkRMD2FYyV/71GvVbxfpg2QvtX
	 x2IpY7CfDomtWz3ftUmVmArS4ZSCkbY9A0/XGxBxNstjbzI/oYsk2zwG4SWD3iFx3x
	 lYRNS+mnMG1kQEBLUwpnHOUGKD0hYIEuexYCfnfvF8OXivZAFMO38h2t7JcmIHz8Lw
	 ykRiHOS7ZEGd2BVGw7xcAQcVBhQNeYWKBfP7fxahQSZICGoho5SHExhYVqMiD1ZeOg
	 R/xuDeIwoBf3RFuEh94IiT5Odmxp6FI9WxMpq3a9zzMIVsS9FIQ0pitK9RmUhI7BTE
	 O+SRI1T+fOueg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ron Economos <re@w6rz.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals
Date: Sat, 18 Jan 2025 14:40:57 -0500
Message-Id: <20250118135541-094843b53c8ca289@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250118121505.4052080-1-re@w6rz.net>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


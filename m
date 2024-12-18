Return-Path: <stable+bounces-105150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D79F65F2
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA8518820BE
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E81A2383;
	Wed, 18 Dec 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFIWu2yp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150861534EC
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525237; cv=none; b=qlbbenIvFQzSV+TtbvkWdpFUOE7wvLOZXXGaDwBQUrkj/SVw3LWGE32r7tRoanNtgfqAZe6WgMFantZU4kcfNCrqujEruQQnyyoRuCHRUDDsJyoqNbDcgHW9TKC2EMa0TSmxZlOOFzZs04MPhmFt6sVMEMzbJV/fdwNL9J36W3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525237; c=relaxed/simple;
	bh=svZqO7ZbsWpD0ycbcFSTBkkmoNyxad6ZkBI0Ef/vTBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkBCX40FXeXyJV+JF8e+vm1bnbE2lOZHaKXuQLqxPQ/ltp+iLM7xFPwiUxuse1h6TmTYV3qj4yp5582Tyd3k2QRjmNT1QEHbbuy5UrTrBAO6AOV73dAVK/aHRSR1lJBs4/4QqInneYABDdCmQ+KJjCmEJVUSPaLkdgIhQOlgKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFIWu2yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33522C4CECE;
	Wed, 18 Dec 2024 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734525236;
	bh=svZqO7ZbsWpD0ycbcFSTBkkmoNyxad6ZkBI0Ef/vTBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFIWu2ypWiuf/NIrza0Pf+JO0t4fn05UBN1hqMR1ajtNljPCUBloNOJRQbNW45WQa
	 vTHBspQO+CFVkUYb/+UbV2+8FfAa6O3muAZFdRwRygibuv6h1r1oRe6IeNrIjRQFK0
	 EAZ9UBvCuFqBVVZ/bSSMTf/6bjWITXhs2fJADtIwpnOlbDNg7lUuNUOLV9UV6/TN82
	 nH411I40bJ3DXl+J8KebIBuZwtq1QH9gYv5QjYaQ1gG+IgPej0U/t5YhQWL9gki6BJ
	 jegyo+r/r622/E5i/66gkS7V0xbFbJRk+r4GM+fNdTg8XZwaOqr31p48c2OEbVLqEM
	 mlXTVazIGaEUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/2] erofs: fix incorrect symlink detection in fast symlink
Date: Wed, 18 Dec 2024 07:33:54 -0500
Message-Id: <20241218071924-a6bfff50c5acaf2c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218073626.454638-2-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 9ed50b8231e37b1ae863f5dec8153b98d9f389b4


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0c9b52bfee0e)
6.1.y | Present (different SHA1: ec134c1855c8)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...

interdiff error output:
/home/sasha/stable/mailbot.sh: line 525: interdiff: command not found
interdiff failed, falling back to standard diff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


Return-Path: <stable+bounces-197014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB7C89D1B
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB14EB06B
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C92329C41;
	Wed, 26 Nov 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkgK8RmO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F4329381
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160991; cv=none; b=Az/Ni0fgnoWeIPbj9o4L7tpgRegk0TcszCrfTY2G1trA/728HfVbrp7ypTEGBf6gKRLghKu3Vr7FW6amgyNeUrYlBObxMQqLZCcO3ufDe7nL7w3dggqJHc/m1aOaZaa2+g/2/vOuTXAGobUbejdviT+LZQb1KCvp4bb+lvoXVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160991; c=relaxed/simple;
	bh=s7AcGcf2LcwCTnWlFoBTFG5ORq+sJHIVpStrmKDI1+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpB+QyNss81hvaEahMyvNbmcq9Tw6Wo7PMePIAO9aqj5sQ2AKvIx+4nZlZtdkbdThz4xW1+LWe/lYBje6B7njKdvMklkhrthjKyYQGNphYke8FKqAVfVQcuCJXEwlw8FK3xp1Oa8yGb+/+nGfHwHAGMieM5IFcDOttDNHOsCPzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkgK8RmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528C1C19421;
	Wed, 26 Nov 2025 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764160990;
	bh=s7AcGcf2LcwCTnWlFoBTFG5ORq+sJHIVpStrmKDI1+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkgK8RmOhlhzYxeHAp64LnNbYzm58XPwoy5sQ+LCQxHm/2BXfV/8Dw3FPgratJilp
	 1PaIaVH2vNG34Cp/VUgSVOWtr7AextS548yfPeirMgOkxXXSo1694RfNvjbNAyX+Px
	 Q9VYpVReZDKvRMjB9w9ROXbcJ34h8nrkYBHrdiI8k6YU8DLWpvkvZ1655RDh8RW1fA
	 WPvDOTmId6DAJYX7hWf/98PRzHsIO3paTnGE7QjnmQg7cvQoHRMekLDh4XGAglHH8q
	 ySF9ZMIaZVaADpApaLdjr4Tw2XbEstYQ6B7Ak4r6Y7vak9zAc3TuTsfCjmPiE2vZ7B
	 CVJuzZS/F2SrA==
From: Sasha Levin <sashal@kernel.org>
To: lanbincn@139.com
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Daeho Jeong <daehojeong@google.com>,
	Baocong Liu <baocong.liu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic
Date: Wed, 26 Nov 2025 07:43:08 -0500
Message-ID: <20251126124308.1366635-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125064028.3295-2-lanbincn@139.com>
References: <20251125064028.3295-2-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.6 stable tree.

Subject: f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic
Queue: 6.6

Thanks for the backport!


Return-Path: <stable+bounces-95835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72E9DEC99
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707441639B2
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987741A0AE1;
	Fri, 29 Nov 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5K7HnRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EA13DB9F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910600; cv=none; b=BMX9E5l3XSFeOg2Q/oPN99ax0gUqGayCcHxZZSWLD6TekWpB2q5xRgmWu5p/BFD1M5FD3cHHrZ7mSZKfmA8fMjN7Z4aVl+RbXVc0pXRDGXKdjPbdyKFV+z/rVhSXQdb6k8bDJLb0C7Ckh/6d4akAqPXO8aJiIeB4qgfhTf122U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910600; c=relaxed/simple;
	bh=1xKwIxKKGRzodcfYP4M5fZ25NPEckjBwzjntCyzJH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uskdVaeJY3/k12LB4YklBXZwd8QTGtVGgqLBXYv0x1Kkx+Npx2JQE+p6EUQdf4DeRtrAA6Gn8D178FQj8zvlZBJ5WOoPt/eZ1pgDziNVYXkzsLtwfy6xRh1slxxw5DTNdld2elGwbhHgq/V8+ammBRiisnYtRE1hBA2DJ49eqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5K7HnRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABB0C4CED2;
	Fri, 29 Nov 2024 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910599;
	bh=1xKwIxKKGRzodcfYP4M5fZ25NPEckjBwzjntCyzJH/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5K7HnRn3Of7YtcaOnlLkp9xfOqYon4bX3r1vPrxldGnkHk5uLerRhTIi4NxyDnpH
	 bWSckUFaCQLGe/N6TRZDeu0Lgw7LbH1f8fHGsNmaF92vwGRr+DtQD3ZXR+ZHWR7tuP
	 UUTvjnDjQXhCn56CMI9z9gODhn9Ukq2StkCUEfhN0wNwuluxO79R2vqSroPXw7D1jR
	 2y6KNUeYRyDFEvLxdqv31DBM/3SIsgAdTU5VgnfR6B0P4BRoJWPT4U1vPLcewC768v
	 7vDKgx76aAy6eLiVxOPu6UwTutatOJhLp24yWZXX03gBcnReS+t0Ct92APmxwJOb9z
	 gLXQE18guob3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Acs <acsjakub@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/5.15/5.10/5.4] udf: fix null-ptr-deref if sb_getblk() fails
Date: Fri, 29 Nov 2024 15:03:18 -0500
Message-ID: <20241129135613-3f62bd8114976810@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241129105846.4698-1-acsjakub@amazon.com>
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
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |


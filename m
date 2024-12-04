Return-Path: <stable+bounces-98590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650EC9E48BA
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD961880765
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEB202C30;
	Wed,  4 Dec 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhPj8Kux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106A19DFB4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354609; cv=none; b=KMGVoaZB6FWKXQl+3qtUrmqtu/W1Ue2gmhfNquBEHoioS7JWQ9SXBVvQvBMewOoUi6fimVFUJR2MJzBWCWlKjkJHolAPGoZZMZ0Uya5E+09BgbV7mDDPjirZXZktEuokZaOaredquRQM4uVeoH6Fn2g+qfDjKODw3ljdd+MUufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354609; c=relaxed/simple;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxsZjzLLeYLyalXWyf7cQk0fPsfY7dxYqVRm1b61woXjgF7E4TkNFNjWzvOWFwtK4xIMU692HAYxsYQQ77MCIVlo9GITP8ExNA6sFy1UQeuDEp/V8t6ZEcksK1a6rgNTXOvO1i/pDyzHZ7fltijK96OaP12AX1XlZTxv8AIdXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhPj8Kux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F47C4CECD;
	Wed,  4 Dec 2024 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354609;
	bh=WfV3Jso+sLZLFfF3Ui1yCgxVJmuzjPQWKs0MP8BQN60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhPj8KuxHzHbHCcyJkbG2jtc1gSRniY/AaeSDlk5PQ+F8HokZKou95Wub9P/2+DZX
	 AwztXpFIH9mhpHEwsUSY9qEp0N60RJiIWCePid1oNKb3FdP/FKVahWX0xe38PRS8G/
	 WYGTm1qpx6iDWduxFpfLQQxUrV3DEYS5NJyH9SQhum+kseDv7c1uUXcBXSGfEPZeub
	 SmyquuwqgjX2hESOxHqFYuSvK9jc8LpihKNp0v6kL39qW1JXGONVOT540hhcR+ROLP
	 luKvfwz1tCBY3kCZXFJEj/QvaFCZXgCJRRFJTkeQVl1dwRQUMvMKb6SFEivWVlbwyE
	 L1bmeFgg+4AUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 17:12:09 -0500
Message-ID: <20241204070128-b73be6c1e5cb2818@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082627.3756-1-zhangzekun11@huawei.com>
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
| stable/linux-5.15.y       |  Success    |  Success   |


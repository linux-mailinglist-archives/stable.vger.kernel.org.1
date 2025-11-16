Return-Path: <stable+bounces-194877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A97C619A5
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E20124E16AE
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A0930C379;
	Sun, 16 Nov 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSXoSQlx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2E2FAC0C
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763314173; cv=none; b=OF2P7X3MCx6A99/6wUBJWQ7LuWdHz9QaRy4LQFTORqRM6tZfcsdU08W+UHr20G6mdMcovvKcZe3W0lF/lr5fIpUhWc5X31iOncCDGB7njXMVG8lBo7W9SPgRM7K5jPINxsIHQFVfIZdiUw+xd5W/KSU1fQmB8wtXQ9cLeXcAbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763314173; c=relaxed/simple;
	bh=p2y6nxXcK1Iy/6Ndu1+n8ysyvOXuhOzG8oAv/ed/83o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBZ5XqjuiM1bMvVVa61hMJMUhG9Kz+UcHbuJOJkZ4XP0uet36qUnf9h6JkTjwAoV1JQ1vnB2yUwT2HW8ZagtRX0RBrb9CEBkGf6QXZYK9oYeidF5+q9C9XOYkvj+1/q0IczcWw/1obEHkJVzhOrftgrCzNwDG2oRTPEoPCnnkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSXoSQlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693FAC4CEF5;
	Sun, 16 Nov 2025 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763314173;
	bh=p2y6nxXcK1Iy/6Ndu1+n8ysyvOXuhOzG8oAv/ed/83o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSXoSQlxV+bnyG73z1w5yssklXHRGHlf8dz8WSbCXKc4a9qGlN5VkjCBxUwRAHJK+
	 A7UAemM6BmRHpm3qPK8hKLkuTAQ8gu9By5gLEJcaY/sloYS9Yw1+K19RlPmZRQBMVN
	 jVjKNMPMpm4cycnOhvzXdo5d0ooNnnEVVSMwiEFY3mEzKlZM8MZXc2c3XLANJqhZ0k
	 IOxED4d7OSdsd7SJAL2gBWOBi3t+nM8JsNsvLukPgVdFd7pgdndPUTzAXzkJA24okI
	 QDPUupYN5wa6FxAmtHNwFEATkTtwEIorqyFzYqY1nv6fAlpN3N9dwD+29TCZB123dz
	 SwTminziP+JQA==
From: Sasha Levin <sashal@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: jack@suse.cz,
	tytso@mit.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 2/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Sun, 16 Nov 2025 12:29:31 -0500
Message-ID: <20251116172931.3621490-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113095537.1831-3-681739313@139.com>
References: <20251113095537.1831-3-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

Thanks!


Return-Path: <stable+bounces-99962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270B29E76BF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3ACC167B9D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442C1F3D49;
	Fri,  6 Dec 2024 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs1zWb26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054BB1F4E36
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505089; cv=none; b=P/sG7Iv3n1k9zjQ057C0cwwxXwBCoPW89H+V2NZNqP5MDmkT+7Ui57FNBmlbGw9JHFdjYHxN8H8GydGeE4sNXQryVbkWKlKEZUYIyXJ24cam0rmZMqA2qZ07gyjeyrWcvw3CrzuGTwmBs70kizY05T9AlpKFgr5fTtVQsStea10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505089; c=relaxed/simple;
	bh=N0P84IMJxpSaMvmqTJIuq6iUdz+NXGcwnaLwe1mQJE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE1oe1ZT21sdZF7dhX7tZ9n+yWXTuShgFJ+qLbkyk5w6QY7I/37LfvShaQAO/2uiG6omQWIn7a7ik8xLhN/+Qeg/arHa85TSUAji8kRE5Y/5o1Z8yp5q9MSzF2kxBZbHLgh5Rf8PAVTFl84CIUJE9q4isu88eRkr7fZnmrPIv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs1zWb26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FA6C4CEDC;
	Fri,  6 Dec 2024 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505088;
	bh=N0P84IMJxpSaMvmqTJIuq6iUdz+NXGcwnaLwe1mQJE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gs1zWb26dQwt5oTbJXDN4k61G9yD18ocZ2bk6CtRzr7zhlEfMDik6XKiRg9AOiCX7
	 +5LptibpMW/fMaDbKd3X0785NuFzIMz+pVt39FBJXetEbv67KnsT/25sK8S1tqDzlm
	 M7OHTnpNXMwSMwZod5tY/wMlW+hsO3W7XaahMxZNPx5xXMLsrZk3dtJ1jk0WHz+EwW
	 +6XexKTlUqCxiTAqMRbcH6RBuOTL2Rpl+1+yoTfoKV3gZ1ieGDcqlK831rO2T7OQA3
	 8/oRKOfOJjcZXz0xqCRuVZC3PMDIV6/HXpVyflRP743dkOTBI9H/u3GCMB0ozxrNqm
	 aHRk7I+eq7MFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: FAILED: patch "[PATCH] posix-timers: Target group sigqueue to current task only if" failed to apply to 6.12-stable tree
Date: Fri,  6 Dec 2024 12:11:26 -0500
Message-ID: <20241206102129-dd39d62e89649bb6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206130824.GA31748@redhat.com>
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

The upstream commit SHA1 provided is correct: 63dffecfba3eddcf67a8f76d80e0c141f93d44a5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Oleg Nesterov <oleg@redhat.com>
Commit author: Frederic Weisbecker <frederic@kernel.org>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  63dffecfba3ed < -:  ------------- posix-timers: Target group sigqueue to current task only if not exiting
-:  ------------- > 1:  b5913c9a2e038 FAILED: patch "[PATCH] posix-timers: Target group sigqueue to current task only if" failed to apply to 6.12-stable tree
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |


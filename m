Return-Path: <stable+bounces-100194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173A9E98F9
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3057282E0D
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715A1B0413;
	Mon,  9 Dec 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1bRwR3O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6915575F
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754911; cv=none; b=ENq913V8bb3nU72dMITBN+6dMiso8McL9boEwY+EFoG71YyVGHH9wwmG6p+xiCCI6r9nFfGlVzKieMcwSL8TxL4JHG8HUI7sU0rVAIvhNBFBXNKDxHEobavXHvQVDJl8SUsVG9mIw/r1Pz2qQlV0n3+IVMr1nlfPRUcTTD9S/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754911; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dim7Mv46joXY2ayVgFDGfU2rSHUfK8uKWFoF5yhNyJEecvpWYZUxgnUy2brNrQR6S6dc1Ur94FEvOkMvV+s2IDI43ZG3coFHmDzalkYMd2f5LB24dIMSsjNMTOi+1abd/mGoDA4PLAJobGv5nQ+SGCglY+iJ4kBcfk7+Qi3CImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1bRwR3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F7BC4CED1;
	Mon,  9 Dec 2024 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754911;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1bRwR3OpcxK0+yCJaXfwGxQWyh8z+qDkk+ZeGKIImSBRBHDmmJGqYFepYVJr1Rjb
	 qGTudV4YcY/bqGr31Rx2pgertPWp/ftpzXkk2yazMBpRU31ul/RjLxUtks5pD9LI9w
	 gewmWlAV6thtkhJEeY+nvabAmcmVXeEIAczb10Apiadvt/qD7zxBNBmyS9o8xWYHGx
	 cIybWgjtbwsl5i4GBHQoJ6N+WAftO1oYo4/bkor7Z58wSrrqToo97Ez8kqom6Adbcd
	 Jbd6NY7TDX9t64Jw0NZWd1GJnUFxtRKUlbhVorlzB3Yz6tk9rlO1/o2ixOW1u+wO5y
	 +fC+4IaCBPnoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolay Kuratov <kniv@yandex-team.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()
Date: Mon,  9 Dec 2024 09:35:09 -0500
Message-ID: <20241208092730-0c4f36e4444c76c3@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241208083743.77295-1-kniv@yandex-team.ru>
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


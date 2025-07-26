Return-Path: <stable+bounces-164814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F479B12856
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656BB7B305A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA938199FD0;
	Sat, 26 Jul 2025 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QstjjbDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66D2E36E6
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491697; cv=none; b=aD8em6eP8o/IY4m12MJKLx2HMK3cfWd47h+AMsy5/248KTqkDQ4KEqdjfVOYRBs/2eHVSD9qcea36zPq3eJv0PIF5Ual/tgK2czZDx0tMdRpt9jNatTFwHO4/qIe3J5PPNZzgEcsKx/DfYPGT2i7X37SQ9SrRLFZsGDwtr6/Az8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491697; c=relaxed/simple;
	bh=8U/chku4DaS6mFC5PdIL8PlVW4723dW9HHD+IcX1l8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMuqvOH4OnaupTFoeHeqz0CPIOWfEyApCw62tRfQEs2BVeV5My3TV15itVJQMyOC+CjafmAUdBwRvqPLsumwJbaxiJBBam/xBSAPJmejHe7DJOON686le28o2HlJGOFaXOP4x1hqadkbk7O/1O3PWoG6S2C6nt5+A2hlcOXD0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QstjjbDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16CEC4CEE7;
	Sat, 26 Jul 2025 01:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491697;
	bh=8U/chku4DaS6mFC5PdIL8PlVW4723dW9HHD+IcX1l8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QstjjbDZkHdBiH5hWuJIdqdkQ8ayjwNSbn5J0xndI/xO+m1P3ma+mMuNt1mz5qDpS
	 aq2g47i5BJMSKHNdG5EwLOro040um2XZ4qe/LTGWcBepIf0jdXJAjE7zOMRQqcGNko
	 QV/iAbWyZzKJcCjOCo9yanhHJgqycHPhCufzmiAXFoVx9AvXx3NR13J4Dy/93f3rhj
	 +/vb0l4NEcVM1yHdZDJ/n564Xp0XPrsPhYjeah+VaSS0pmCgzQLmwLPYODk8XEmPW/
	 dk2HmTbZlJQHd66ldFnKofA2jIUI3KFoFkEcv6868/zhSu2Ha7YtoGSECHF0HxSf+T
	 Z3cU/C4wfjaLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	justinstitt@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] KVM: arm64: silence -Wuninitialized-const-pointer warning
Date: Fri, 25 Jul 2025 21:01:34 -0400
Message-Id: <1753460939-5b451fb9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Success     | Success    |


Return-Path: <stable+bounces-150751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3EACCD24
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7ADA7A8AE3
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9171DDC1A;
	Tue,  3 Jun 2025 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgt/VkeO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63BBA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975759; cv=none; b=IQwYPbRcdzhCLfVpk4Gm3ZIRN+Zq3j0zCppmSsBQLn9yp8r1/aPvtENzmrQFTAw6AEamKIVok4x4GXwUMypQER1iJTNn+ZRKONk/FIIp+6/aiBvb9FOIP+9Z+OBh2oZrFhUBUf+ehMRi0WRezKTUs3Y8E0qaqsUW6N/+fuJgG9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975759; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfZfMX4FXuvAa7UkskLR2ryX5wo9yiyXUKygcS5l//IhAH/8ar+ltqi34HrJb9a2pgavJ6hyxbKYFaBgN5FKxuU9WwVNPuyJqbD6GGZN8/mk1ozvLQJcidsI0S8gMHf5FbS44FUo6TcDUHXbtirsjDgprV1T26IvmAnbo/hyhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgt/VkeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8EAC4CEED;
	Tue,  3 Jun 2025 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975759;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgt/VkeOtrNChP+wh+Pu4tNlnHzfoj0aIsrKjiMZfkU4wlOUL+k6C0V8cyiy5glwE
	 cjiJZmHPMrDBbJca4lQMWJO+sWlgtS8tWmzlni03ru6bC2oruBFRZk5nH6gX0+D43+
	 /4JKFzRAR9CZ326YnEDB8p14YXbWXhxYLLdyxXxxxR+wdWVvAPueyRoDem9W1nIIht
	 D/j4ieT65T0Luy+Wq0bBhC5YNw8XWMDOCJSeTabsIhriY52HFrNHurv1I73X4PV/2U
	 PpkmUYQSR4uCt88AhwhsQrpNK8CHjaL3KMRNmmSwn9fRG6lEJypZUSkVlPzuYx/rMV
	 dpmzK4PHEoFxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenridong@huaweicloud.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6.y] arm64: kaslr: fix nokaslr cmdline parsing
Date: Tue,  3 Jun 2025 14:35:57 -0400
Message-Id: <20250603140326-78f57ce6c28b3292@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250603125233.2707474-1-chenridong@huaweicloud.com>
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
| stable/linux-6.6.y        |  Success    |  Success   |


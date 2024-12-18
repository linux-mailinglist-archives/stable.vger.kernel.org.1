Return-Path: <stable+bounces-105149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978BA9F65F3
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9427A7A177D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030319B5BE;
	Wed, 18 Dec 2024 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOuTpO/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092E1534EC
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525235; cv=none; b=vBX3Gbx6tyBl+TGTlIaNUDINdPLutJUEKEZogr/Bv4g/BaWRZYBVYwy9V6ypAv9DXcO1blJO1Pgxtn/a8NA6IuTPPnWfpnSESNAvf9xrrbYjScwHjFiw11ORF2uimFBSDoe9xTFZewzF4xON7dwzzOt+FyC1wTB6RDbvl226gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525235; c=relaxed/simple;
	bh=sc5ic0k2dXC9Prgj4nuu0EWCCmszCWJgQfPsqgmXnJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyXHiXOc3xWwu3ElsrzNp3tsPVlx13GIY9oUD0w82NJwRV7oC69zEzajIAJ4v6ngW0Nq2tUytqZu6+i0NXhiX8uwtOIsxWGSIFO+/LjSJKDxnNl24fBjT3qoDkZgUW4slVYoiFBuRrrrLfrB3QSTU4QHy86+FGDfDnhqYG1eUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOuTpO/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D03DC4CECE;
	Wed, 18 Dec 2024 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734525234;
	bh=sc5ic0k2dXC9Prgj4nuu0EWCCmszCWJgQfPsqgmXnJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOuTpO/cpFY8Jq3x15jhfyUR0FJOrFcrpnf0ZT3VZh7uExOc6B/C8paOK/PCEuCmb
	 fyExvjBhzCv6yEHkLQT79YLDMBL8EgPRW/VvKqJ8/sJbOl6u511G7Djf1gVYUm/lra
	 SowP0YJrI3Hmrm2XP4tQWhRa7d1dV096V4Tq6GO7puPu2I7WWMi27ccsACpDkVdTeB
	 ZJ3yDZN2PWgkwKPT2NPRnkOkdrbW/5dFWmeaR1N7nChgIc5INSrVizrtlihY9biS/Y
	 ac4ntn4NwZxCtuv/UAtbOqNuFi27u7xeZ8oGT7EHaVBpdRJKB/M5e8vSdfZMqdVb5g
	 PamFkuEBL8aIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/2] erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
Date: Wed, 18 Dec 2024 07:33:52 -0500
Message-Id: <20241218070057-52bcf8fd39c6bf2c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218073938.459812-1-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 1dd73601a1cba37a0ed5f89a8662c90191df5873


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: acc2f40b980c)
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1dd73601a1cb < -:  ------------ erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
-:  ------------ > 1:  2f92cbdf6ed3 erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |


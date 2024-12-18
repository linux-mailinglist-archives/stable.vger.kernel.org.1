Return-Path: <stable+bounces-105240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CEC9F6F25
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F541891B3D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B14161311;
	Wed, 18 Dec 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGY8AJbP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7815697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555683; cv=none; b=dQzjMxDiZnOi9DiLLu5DMLg1QRrBrbkNY+D9Fr9F7HtYRvloHUDTLnJTVbBhiQEiv/QjmT6o2rcyoznGx3RRLJW3r+07M37ZQJmVfEf/6hgQrlTpkooGbjRKpDcLwivAwxwj5uBZ3fVbcFXmvBRqRUcB2L1ZfrTNJGq6ZOBaP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555683; c=relaxed/simple;
	bh=kjJteGH3Q0YjUDb8US8B3u+RUpuJRvo8f/cJey3R3cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqGyrNo4TGC7PCjN8zuRqjFVeQ4LeEvdZrDbEZrdOtCBtfe+EbG7GqrBcYabsPbbJAIhBRJbYwu0Rm2VFydRwb8HxIhsIRNHVnzsRiO9lV/jdHGOwBnmgX0dWPTUbNY9AdbLM2u+y+2zIrooRB3e7DGquXM0pfsnTN5jqDNUzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGY8AJbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C76C4CECD;
	Wed, 18 Dec 2024 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555683;
	bh=kjJteGH3Q0YjUDb8US8B3u+RUpuJRvo8f/cJey3R3cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGY8AJbPlEe9R3gCbBVQZ6LOyiSVJwzcN5PdUzJO7yxPK4eVoFjgaLO0xlHdorXaK
	 KoQd/X5hZNl5zP/5cCQWBb252Z8A9t2kXGRXeGXYOB6RXQoBQ4dUMwDAI2WPA3QGT+
	 urJCZcsueGR4Wtj5Z3Tv/upq7hvs4I0YvYlgVZ7qgviALe/Q9K+4B4Q+GVmB2JP9nf
	 G0Icuq0fR+9KbeZ8tdBIG9/vBbq5GiJcGG2tleHW7izZ/RGqae+N8lA1FDSrKusg5w
	 ynkjp1cw3kqa7G+QGGLrDSuSJrzbcz6XoWvMQiG8Wi0tQUOtbyH7nK5RBrA0CcaC9z
	 o+2w/TcixGlnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 05/17] xfs: create a new helper to return a file's allocation unit
Date: Wed, 18 Dec 2024 16:01:21 -0500
Message-Id: <20241218152239-92e5eceb62708736@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-6-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: ee20808d848c87a51e176706d81b95a21747d6cf

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Darrick J. Wong <djwong@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

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
| stable/linux-6.6.y        |  Success    |  Success   |


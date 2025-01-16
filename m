Return-Path: <stable+bounces-109198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1130AA12FAB
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E733A333B
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C7A957;
	Thu, 16 Jan 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1x7mnMO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213679EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987172; cv=none; b=d8oMH4cBjvao5mI4X+h45uOzur9rJa2or3QrtY86l71wtQeaLMvLjqHV+FXFricISKA/8EUlWzSU8IRYmKHpZ4HKyejbvWHPV6djD8h1u/gWtqIopOhkPdpxKsV57ff1xnC3tumPU4RvqIv/xTOHAhxrC6JueVeNWOsjesXFbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987172; c=relaxed/simple;
	bh=Oy5AgabTDwS7j0F+mQHfIO8xvJ7131EXKb4O644Jfn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jVFbq2E445xzlXjzu3g7S8oSK/jwgjrbiQATCke+h7PWFZjTcQImd4jqctMVNCPj/egJFrWIicgaiJcrbAp52S4M/XcvfdywQWe+bfdFp6QV/FCaq4vy5ETKXBaTX8cwwEF3o8oAKVmaBkHAt5YfBDhjqdpgM9LkMXRrpm78KWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1x7mnMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BDC4CED1;
	Thu, 16 Jan 2025 00:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987172;
	bh=Oy5AgabTDwS7j0F+mQHfIO8xvJ7131EXKb4O644Jfn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1x7mnMOeo/+77B92wMQEVEJ3xhiIe//1VrCm9Cg0xOiIK+v0zLwjuyiaWV44cS6W
	 J4hMRMpMFQS7kRa9VdUKi162Q/oXwTMjiJOU6wkeMCsX/EoNzW8I9N8nbDk8+4BHgG
	 K6aO2bKSzhKLO6Z733atcZoHgoiWMBcV3SwDgFJfZ96DeUs4h9n06XG3noAb2QqUJY
	 lygG+hbuuaxp1TqVM9TwMDhDAN6WgO4GB1cIXg6aP+5k1T6lopHPXgu6Dv2A92xzsE
	 N1Sk3pXPgvaSZBm54uB8UbK+bMmB4Pm2yUUIRxAVq/NiRo/EgHHcNJaJpI+du+japp
	 FKrbKNIXgeTcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] erofs: handle NONHEAD !delta[1] lclusters gracefully
Date: Wed, 15 Jan 2025 19:26:08 -0500
Message-Id: <20250115170624-1911321300b3a71c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115095048.2845612-2-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 0bc8061ffc733a0a246b8689b2d32a3e9204f43c


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |


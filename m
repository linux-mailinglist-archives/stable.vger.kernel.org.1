Return-Path: <stable+bounces-136638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002C2A9BB33
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3753B55E9
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F97227E96;
	Thu, 24 Apr 2025 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Y5hJ/C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E63A93D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536989; cv=none; b=UcirpnKBjxunLbLhTGHVY4D6/lDUrA7tU1GBmkVjJJvZuv5YX5TuKn8NjsrjH+sfhA1Auvng4r4sJzSFOEMeqiANfNuUhB+q/00COOO9QIGwmzmz0o0POFrlhFe7jC6BBk/yKo71SB+3u6umltfU/N7234xyL4ZcgDMhMRYpGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536989; c=relaxed/simple;
	bh=0Iy7kQ6GqbLNSoJcT1QLF1JX4VA7Xe43dLgSNUPVHdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9TqAP91CaBWMJZFDd6pcjzjkBGpp2DUbPEK9/P49dg2ApyMv8JhPrO8YO+MTRZ+KkDivvhaREywNMtSPWeBESWfKON+hHrtgtt+q7+HM0jN/LH9wheO2pYjHNnz/6U/4sYsT8wO6ODjFrJMNwbrWUL6Io5HD0DyPvLiPXFev9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Y5hJ/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A34C4CEE3;
	Thu, 24 Apr 2025 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536988;
	bh=0Iy7kQ6GqbLNSoJcT1QLF1JX4VA7Xe43dLgSNUPVHdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/Y5hJ/CmqipkT6yvA/pbccKK2KkOz98wSXmDwIPyTOWTF15SZDjWcg4xLBiMAl6v
	 Sxkdi66Z3iqMCNTWHL8auF43pF8DFvxbXBqH32GLFBdye6Ag4zbfW/nXFbLjHTcwXK
	 j9mB49OYgKIQh+uwJNXWDrywWWHxo67Gv4Sozkls5rnCEjmjVCOKliPEuRYW2e3X0I
	 eks0+guoGTVu6FMjeh0ahIxrflX6YtRp80z7jc96ZGhGqX86TEHilvpmFIcmuOnJeb
	 8K2jlPnYQnSZBwImBCVatAG1Gf5TU10M8TQrXGY0FcLCxMJeBYP2+OnhlsYPCeEORo
	 LEdaQVLyyhzew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bigeasy@linutronix.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v6.1 v5.15] xdp: Reset bpf_redirect_info before running a xdp's BPF prog.
Date: Thu, 24 Apr 2025 19:23:05 -0400
Message-Id: <20250424173540-e119550828e3bb7e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424130314.C9jOS1c5@linutronix.de>
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
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |


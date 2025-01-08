Return-Path: <stable+bounces-108031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317EFA0658E
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 20:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613CE3A2D61
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72E51AE877;
	Wed,  8 Jan 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGoyuDCG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3422611
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365784; cv=none; b=cjGjYfNvAkzORjkhZWlEZSMtNh66ys0ISoCfgRy/mSz4mWYZ6+svSoxq/EOu/lS8pEBxxmxQ1LMK6cv+rUk0UpIpyYcXRlre8oVPheDY5UAUgHwj52XC+4ddCI09U+S5Z3/vsjXeORM50LHP0PeVWF7hiyPlxN0KFFjkiAfGRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365784; c=relaxed/simple;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDGkFm1j1xPG7gkUZs0q6eiq+0YI+871858GuMLgOfc0jw3mrTWLr+Kb7LDSoIwVOECR7CLlSm3gh/XPhJT3BN80+Gmq+7lJNe0gUK5ocfzadXW8Jwwje5giGwkkwFB/9LOaJktz3VhxyAeC1Dkzjw0qjlJXMFhzm2VKWOyBNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGoyuDCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A03EC4CED3;
	Wed,  8 Jan 2025 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365784;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGoyuDCGnfA9G5ZNrOrftypCM1guBXigJWmIhjzM5PO0Spt2B7T6MQ/+DvauckAEG
	 0X8XagRH6GGYfUk+6meiqRLU/pbChtBERvoxvEUbjuvyeXsRSuoZBRZ9GU/vIqiIrx
	 ZTF9RA2vCYEPBv8ujZLkSLX2KLjuYXXNvawyxxhaS7S9rCLVs+i3KPNmvXzGHISQVR
	 /qeM+K7l163kgFSE8ec395ajvPqO5nfBA7zwOKlAhjopK8ok6frImZZfLJYaNzLkgE
	 cOsDwPpzqgpRZBNVyZcO+bbdjtNgOEOoiYZ+mpG7nNoIUBDV5voyQlgwbHMNKZVi3G
	 dYc4L7n8qKcqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] ftrace: use preempt_enable/disable notrace macros to avoid double fault
Date: Wed,  8 Jan 2025 14:49:42 -0500
Message-Id: <20250108140733-3117928851ec84ee@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250108031736.3318120-1-koichiro.den@canonical.com>
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
| stable/linux-5.4.y        |  Success    |  Success   |


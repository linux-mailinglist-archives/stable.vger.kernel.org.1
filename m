Return-Path: <stable+bounces-109462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB93A15EA3
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE613A74D3
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F61B7F4;
	Sat, 18 Jan 2025 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frGJTJWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECE1A725A
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229261; cv=none; b=lm3Z1QgxOmk2xki4dmCZLT4skpODMzL7xJ9kuZY00JJWKrlZrCbnOboQ/GazBbRjO0qQAv+a+q8CNoGYaGdmWuHAaklx/vgu9Cvt12UWOcfL0h9QpVm8JEVDAzIkp7PM2UMyVvK/d6bw6Vzo1k7aITDl9GLn+HApq6YexNNxGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229261; c=relaxed/simple;
	bh=vsyabUZ1DcGKWWzlOwQyE0e/JOxKbRE9Qw/5F7BHxis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MjfLH2raan9lpKsTgYWZZwrJxp/GE5yP/o4E3A5TmY/+8VYhWQ5vCY/to4FRPAU/A0DGzNjFZhgUc08Bvqt75RFdEGmy7/4kKIdYNdHxSgRubPAICf1c/BU4kwH1WC0fJpnczQmviHLom09s6tY88stX3i6/7XXBEo2znUWdKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frGJTJWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84EEC4CED1;
	Sat, 18 Jan 2025 19:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229261;
	bh=vsyabUZ1DcGKWWzlOwQyE0e/JOxKbRE9Qw/5F7BHxis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=frGJTJWK9nko2wr9ZIG/b2nzUEUd2q2Z2owyJ3qBnShgoJvzPOYJL6pxa/XGfhPVF
	 vkIR/IpiFFI7I6uuwwvc4GSMcyzudLIXwo2GTc3j5PUp4nPQ7HSPspMuVxlxyCQzX3
	 Mp2UWRcK0sltKGvOuiwDhYQhTH7QuYltn3zTD/BPXzWLm6F7gxq3funl1TToZi443T
	 s60uc9TlsxcO7hKiIirjXOJM00OabusFPGP4KpI1/w2eiP3niY1V8wWvXew78OvBRi
	 bZqbCNKulSniR8/bq/l2oQcAeioyFw0rLAxIkL0VgWG/MxYEKh5Xi/Gfb5umBXiEyb
	 yjt3RhUAY/CDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Tritton <terry.tritton@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] Revert "PCI: Use preserve_config in place of pci_flags"
Date: Sat, 18 Jan 2025 14:40:59 -0500
Message-Id: <20250118123735-e1cf932dfb4cb19e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250117151551.6409-1-terry.tritton@linaro.org>
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

The upstream commit SHA1 provided is correct: 7246a4520b4bf1494d7d030166a11b5226f6d508

WARNING: Author mismatch between patch and upstream commit:
Backport author: Terry Tritton<terry.tritton@linaro.org>
Commit author: Vidya Sagar<vidyas@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3e221877dd92)
6.1.y | Present (different SHA1: f858b0fab28d)
5.15.y | Present (different SHA1: c1a1393f7844)
5.10.y | Present (different SHA1: 0dde3ae52a0d)

Note: The patch differs from the upstream commit:
---
1:  7246a4520b4bf < -:  ------------- PCI: Use preserve_config in place of pci_flags
-:  ------------- > 1:  367f98ddc0072 Revert "PCI: Use preserve_config in place of pci_flags"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


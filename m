Return-Path: <stable+bounces-98155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8536F9E2A85
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE50162245
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1811F8901;
	Tue,  3 Dec 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXHdpfOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29F1FC7E7
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249611; cv=none; b=upqw/6cH4GDvwg/eDptD13gS8ofeHWi7KUYJCoUl5sMgveglLI1x0/DYHDbRdlfAHI7v7P8QyQpDmMQAtke6BQh6FGtqAdOf8DnwpqiK3dbPijgIbetZDNkZFcRV0vcqmvMmbpR11u662QdpKOPZ/OIL9w5x3bvAraYQ6MLoPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249611; c=relaxed/simple;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twNmsD4lpOM5k7ypTw2A5mbS4w5bbfVYhinkKO75Ea+H9pQps0m3k3DrsACDHpwDEyeKrV8q3IxMGgWN/dz6hQbAeIU+gw3mljI8QVGkKtrFobL4HkvPypHGLgKxYbiPXrn4YCd1xpIRtX76fhAYVYrxb+DZsCI6zVUY3iQqTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXHdpfOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5345C4CECF;
	Tue,  3 Dec 2024 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249611;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXHdpfOrxXSnQl58pIGA/Ho3Kv03E6pUqfL9dorzcRkwDxnUSoZkVfF3TaMpq2gNb
	 f40ubDVc8s7j3jsBGrRm56+2UxzMGiV/J2775e0NzDbwg7YRK2s2IPR5bi07FPoL50
	 wxjjwuNlP+Lft0TPu+mJtvuBQyjGtBiPSOw3HwQnCUXBUw31qI/UtjeIE64I3sJJV4
	 90ix/vXA0EaGIBX3tNoJnS+zXhGA8VSm2y5DGFdKvC4M626Qt4hjAvw7N93c1M5z3Y
	 QT899AyGpJP7ehSH9iRVBtF2PPsVRGgRbILlNcrabRZE0Mj4GATxiIJQG5I8tkkahA
	 zN9L58/rJL06Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v3 3/3] net: fec: make PPS channel configurable
Date: Tue,  3 Dec 2024 13:13:29 -0500
Message-ID: <20241202125809-a4b6e45bc387a071@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155713.3564460-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |


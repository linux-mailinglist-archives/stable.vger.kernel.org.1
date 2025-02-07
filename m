Return-Path: <stable+bounces-114332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86083A2D0FD
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EFD16D643
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403C1C6FE6;
	Fri,  7 Feb 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQMlFKlb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448921AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968673; cv=none; b=ON1CpQs3P0j1cZeQkRUFkcf3KeAVxTwjd3WX+laajUO6yOJf2HI5e4EXbbOD2AoqsVbesKVP7yRfudpCZIvC7pF7/OvXyAwunHUWkfS3qAJacy9NEBgJMyYK54/qzwg7z1QIMM02CG8O+7IoRVNUVs+GmfHbEh36kc78Pa6NncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968673; c=relaxed/simple;
	bh=ri7wIQCIiyWbRR/5RTTolWiVYyYJhRcovhZdpzM3uh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6TpuvTZPKkD5lEbhiDDVvsdRh81KhwGErAvwhHq+em+6CmoCuJaOtaN9z/1MEXz/lEJctVHbMeSBn+j0zLyPI7yHdhiv6eVAlWEHTY6Scsx/otnfCqawLQCbXjFU8ayzwhGym/fz5gct7cEihsQSyJNC/vKzuTDJ7Pp6PwuWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQMlFKlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB30C4CED1;
	Fri,  7 Feb 2025 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968673;
	bh=ri7wIQCIiyWbRR/5RTTolWiVYyYJhRcovhZdpzM3uh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQMlFKlbVya1qyFnSxuwQwsdyzsQxS/0HSc9Wp2o2dAFDX+88zHlp+z8QPF7EMZVX
	 EbNG0PPCbui6T0OXhme7PrZYzRm11hY9ZHRjb5P2CApO8Z8GZvArHGxU6rAD7ZH5r5
	 FPPFg5BKAxIiRjBdeGzQzuxoD+hcl5YvyxfsW2APyScMIfzIxpdwDI4NZV6+Lixa7/
	 3JWryS3xMG59tKkvcFmYyX2iqmxmefcJvlsFU9UDDW7IWQv4+rSyZ+jD2+y4XjI3hR
	 Fzs5gG8dBZoEc+EFnlZVkdn4ZAEZ4AcNnFNVX4a/3TCXdaBEXTb2mQFJhQfFGjeDDi
	 AOolc2Tdmdu1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishanth Jagaduri via B4 Relay <devnull+Krishanth.Jagaduri.sony.com@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Documentation/no_hz: Remove description that states boot CPU cannot be nohz_full
Date: Fri,  7 Feb 2025 17:51:11 -0500
Message-Id: <20250207163329-66b9c636007be548@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250205-send-oss-20250129-v1-1-d404921e6d7e@sony.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 5097cbcb38e6e0d2627c9dde1985e=
91d2c9f880e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Krishanth Jagaduri via B4 Relay<devnull+Krishanth.Jagaduri=
.sony.com@kernel.org>
Commit author: Oleg Nesterov<oleg@redhat.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Success    |  Failed    |
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Failed    |
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.15.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.10.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.4.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D


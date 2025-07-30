Return-Path: <stable+bounces-165556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3998B164A4
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D794E3E1D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911DD2DCBEC;
	Wed, 30 Jul 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtoksjDq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A31DFD96
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892951; cv=none; b=f4C1wANdDs4WWvd4jFzDq03r14xFGQIS7P48WJ3DpE7Aoiie4UgcklAoNN8/J1gomU+IWX/XalVhaHj4BP07fTWBpj7BeAzqkr4H2ZWg5aw2tSz4crynJ4baLXTzcZBSPUuvZkXVrQKwBPuTnwSDLvei79kKzFuxgRVNrHdc+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892951; c=relaxed/simple;
	bh=MW5dTQ+l1waU75pKT9DOnjpn9+Me1PSniwpXfoa/gJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvPRUYrYypsF3VVoojZV01jS0+4h8Ztdyy7t4gHJDx7R2+TUMn11sz7oQ/m6qMVyPDFuCKjjKDEUttj/TCgkHQx4Yq3xQt9/7n3SftGs0OwLg4NBmyIPEOr56sv3L+KmwuODzQ5QQ5DTTaMKhS+B1uRoNitiuuv/S5kn38VjTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtoksjDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2795DC4CEE3;
	Wed, 30 Jul 2025 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892950;
	bh=MW5dTQ+l1waU75pKT9DOnjpn9+Me1PSniwpXfoa/gJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtoksjDqZi1gBHNd73wukkWs9RcoeCPfbSzoqyMj4eWqU+BhhdWlM7q5bsUOcA2je
	 VLI2qKFHWWo2ST5SDOhMN1IDKSfRfT5Q1GCzIoROTyxSbz9tOQMzKq+yBSqbXhJGPQ
	 Sv7JJ+e9yLtmExUHBIlxuMXBwVFk3Wnp0i4vvIeQLNacYw8e2xA6bn2VrLP/71rc2e
	 2Lg6sZA/5ByKiAGamTZ+utzUGANPRpNrWmvDcLBPpA7RRf9bhJ08rFbGqUdfBSebpX
	 30gkK0xO2iDvAXAnYFxHOh0uzuufHtR24jrY6wXSP6iiktOMA0+W5w4C4eA3t4lulR
	 703raH/uwE1Pw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	matttbe@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] selftests: mptcp: connect: also cover alt modes
Date: Wed, 30 Jul 2025 12:29:08 -0400
Message-Id: <1753886701-e31fd001@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730111805.1659125-2-matttbe@kernel.org>
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

The claimed upstream commit SHA1 (37848a456fc38c191aedfe41f662cc24db8c23d9) was not found.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |


Return-Path: <stable+bounces-165548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F2B1649A
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8E13BEC11
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198522DC329;
	Wed, 30 Jul 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH8OdAkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB40F26FA76
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892928; cv=none; b=cKAE33u1Ass6RqZL1tLf4j6tYgFrmoPX87BuCSAl5NsKtnHqhzp5B0KZTCxfT8DajK84g7sJ/bDgbXPsoGV2yPNGCt8FViX/F5rZJQ/Is2IzA6TNhBLl3OVRUEK1GHKk89IfIsShwMT1MmbS5xkca5X2paDRSpnUiC1Gf5MbUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892928; c=relaxed/simple;
	bh=Hf1BrXX3je+HO6oLwuNAGex81zJ3hlUD4qZ09utbrVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjwHHDrnx1WvlRtJ845FT4EbRE2gcwRGViEdytopM95CQ7s6WUKWm9bZj221J4JV5SKDFvHr26e3BMzaKnGsIJ19r+sSAQXWEdZi1Mff2IzqR/oryh9bMNx4qeHqIrx9h4EBdQm2IusFWGfjfMxo7Q1nhi+RbiaG0GJnuyMY3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH8OdAkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA014C4CEE3;
	Wed, 30 Jul 2025 16:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892928;
	bh=Hf1BrXX3je+HO6oLwuNAGex81zJ3hlUD4qZ09utbrVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vH8OdAkZlGN3G7Qkp9Pfk8ZZ6hH5yJnzEpGQjmX0nYt8iemUnTF3x9f3S1IgvbZNh
	 8yLL9aLEM91Xts1uA+BXPEg8/5AVrsM4EKUJBxWker4FXWHT7Z2keLDJniEjS0+u32
	 x6i0F3iSV6pxwltW0ht1gIIeE1q2ajgv8oLhwTYXqHZGB1nso2uTjeASG+7UiPcZBQ
	 MTFY9NoQqWF6UM9L/3RPsOit3/MryKb8lDsYagKP/hSOA2S0l+lC/2+rWIc5qkenYl
	 l/ZYmHMz84RC+HvZ0hTq1K/RIci87sI/KYO9i12Mjdomd94+6AFyMLd6z/Ssqiw7j+
	 0tSGqSvG2BZHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	matttbe@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/3] selftests: mptcp: connect: also cover checksum
Date: Wed, 30 Jul 2025 12:28:46 -0400
Message-Id: <1753887608-bc3b14e9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730102806.1405622-8-matttbe@kernel.org>
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
ℹ️ This is part 3/3 of a series
⚠️ Could not find matching upstream commit

The claimed upstream commit SHA1 (fdf0f60a2bb02ba581d9e71d583e69dd0714a521) was not found.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |


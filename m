Return-Path: <stable+bounces-108213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF5A098B9
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F667A05B4
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0A21420D;
	Fri, 10 Jan 2025 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl3rR/Hj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE652135A5
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736530750; cv=none; b=EjFy1sFwDZFFas6/tKxSSRzNE7bBskV9vTRFS9D73jpnAW9FFlkmPPzpJjShHzNc0ltbSB1lWXvsDCvo/6/8PaQ/XlcGJtY191t4INfUd06fMsrRS/0UvzMbLfKqB5GFX4XuqjWcAetcBqkhGiMdaT/NWVAsA8IyMavv9VjvRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736530750; c=relaxed/simple;
	bh=JK4Zm+AWL/21tqEB85X9lts/596zKnFZr77pxnExQZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQ5lS7ixhqmjnQXxISf0R0K7qsfqYeMfuEOE4IaZX1OwZq4rK47N4HNp0NFnYqF3e64Ub1zFhAecp+lMe9tQQXd6vVevLl8h2hvsoBquEckUSNnlv7VjrzPaP5sJwJeBhgG43YJ0oWGxcaXjN0PI/QZru+Kwe/B3OH84iGuPxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl3rR/Hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B0FC4CEE1;
	Fri, 10 Jan 2025 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736530749;
	bh=JK4Zm+AWL/21tqEB85X9lts/596zKnFZr77pxnExQZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fl3rR/HjY4PtUglhR/g13OSDgx8xFHrKcuJxepODbh4+g/sMjGc8FEIiL/+r5x6/E
	 76w2rcE6u3i3eVtQzV8EMjJoBWqExepv+BTAzHwWwhw5uLTNx9hYzUY2U48FSugBk2
	 XPNa/qcRBwlBX4/P5JmSa6IXJmsiRbmk6n7NLRk/zJ7HEbGZ3i4lYLw6NghTRWCDaE
	 2edFfBx2uZoF+5nV00CSXgJ+L8vOdzlQXfVas7dLpZ56BsgFt5HAN+BpwK/QZVM3Bn
	 1hK4IW+nLZx9w1H8ExCaumWl00oZ+Tcfb10yuupy32g/g5qP+t4KWzs1WwHJWicnfY
	 JWzZMayw9nJGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing the linear region
Date: Fri, 10 Jan 2025 12:39:07 -0500
Message-Id: <20250110101726-09ad4c3161b0a090@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250109165419.1623683-2-florian.fainelli@broadcom.com>
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

The upstream commit SHA1 provided is correct: 97d6786e0669daa5c2f2d07a057f574e849dfd3e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Ard Biesheuvel<ardb@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |


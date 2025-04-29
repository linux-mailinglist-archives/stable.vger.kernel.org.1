Return-Path: <stable+bounces-137081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E1AAA0C1C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CBE463930
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1128E20E023;
	Tue, 29 Apr 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF4wNtLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B192701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931040; cv=none; b=BO3FFAHfMZSDxnkq+bw8142/dbUANbKpjLx9LMQP+61Qv/vTX+M3HfXSAI6v16/nm+xvZRkrwqO6xvc5Ofvw0bSAxSsGB9hXvdsGudgikdNH7ZSd27sl5hXE+ph5TcBPeBEWpbCsmxtrrLRS8l5xg0R9LIyJWOLbKhzk9uNfN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931040; c=relaxed/simple;
	bh=nTqjEjfPAMeoeZqZEl4htGR+mbS4zeaFcdyHNJj0vaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8bAc+ke6E7lbdaFbRxJ8ItgdYoxU48LC5qVXk2/UGdD7s5dLduq9J3vONnNgO3E4t+sxrBHHws94AVzfDw0pB27JfvjJw/9lUMrYOgwuYlU65I44N5huPXHdmw4ROg63TS6+8Lfbs1JVS80DoWxmF+JmnENS5TuALYyCrlhGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF4wNtLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEDCC4CEE3;
	Tue, 29 Apr 2025 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931040;
	bh=nTqjEjfPAMeoeZqZEl4htGR+mbS4zeaFcdyHNJj0vaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bF4wNtLLYVXTVImJiA5KLKbo4jWlhcrPbPbc4b1amhDCqVK6BNtmev/NlcphkrpZZ
	 Vz3PSHNtJoKyo8FFH/S3hYqvnK34y1ztots8RoTSx/rO4EomRKnqPB5V+VG5sIMJJP
	 HL/0AwWhqCfHj06HU66lzJadZO/vjQ0SCSplGRj1hV12jy872hZHYG6wSCrCyT9STH
	 celJNgr3tuYLWtLB9bW4MRycyDH8fmVGGNOGqj1BQnoMkcejmvDqv2GDjJ1ioogzo2
	 Fl8Rqqz0J+18qXPaEpH3hMwT5cpRWHgPy6VijHFIwdWVnp8+V4C8/AEM7kUN0j3F3A
	 UVpg6GZy2/d+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/4] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Tue, 29 Apr 2025 08:50:36 -0400
Message-Id: <20250428222218-a076849d1042ec65@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428082956.21502-3-kabel@kernel.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: a2ef58e2c4aea4de166fc9832eb2b621e88c98d5

Status in newer kernel trees:
6.14.y | Present (different SHA1: a0898cf9a38d)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a2ef58e2c4aea ! 1:  442f469a89052 net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
    @@ Metadata
      ## Commit message ##
         net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
     
    +    commit a2ef58e2c4aea4de166fc9832eb2b621e88c98d5 upstream.
    +
         Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
         did not add the .port_set_policy() method for the 6320 family. Fix it.
     
         Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
         Signed-off-by: Marek Behún <kabel@kernel.org>
    -    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    -    Link: https://patch.msgid.link/20250317173250.28780-5-kabel@kernel.org
    -    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
     
      ## drivers/net/dsa/mv88e6xxx/chip.c ##
     @@ drivers/net/dsa/mv88e6xxx/chip.c: static const struct mv88e6xxx_ops mv88e6320_ops = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |


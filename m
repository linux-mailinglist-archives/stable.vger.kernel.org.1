Return-Path: <stable+bounces-155276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 229CDAE339A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB1A7A6B5E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14818DF6E;
	Mon, 23 Jun 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1UKYssa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C900171A1
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646010; cv=none; b=NHvnLfL3pQIkMg/J8cIDOzqbVWMu9345N5eCqKpDciqE8FKrKwuCh7xbxevmLlBnM/PQNN0ZAm6UDNTgg0nCpFsFrs3sfZIyD7mjmspdwftWXDcdvq7R8pQkqSgjS55Im0YvtAq6mVwHKVn/Coiikz0aE1LbvDjqS3KKi2XslVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646010; c=relaxed/simple;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMqHiwVHkkikljl6UDiTIaukdlHQRqRItMCOEOUbLIeGOdxzPSW38cTJPWVPeuhwhSExho3oHTiQC+CGJGXxr2Y5ciFWQiL9QyeDIUCmQy0AdBP9wzVUcOoIX1Wry0hJYM4f+xWO7NqzjrS1MKcVNxiqYbOxqJDoASA1/b0aiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1UKYssa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A10C4CEE3;
	Mon, 23 Jun 2025 02:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646010;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1UKYssaxMrYpRqH/F4fbB+1JAwAnCMsxRlP+lcMJNNspDI8Qea9npCqi2O3CW7q9
	 no8mpr8DTGBhJbzSbACvJU8BjGeoC5d0yG3Inzt+aFq2JyVndHssmWYRCHVwSYuouv
	 e5+z3X85Kuvw0Z9toW36ih8Fd1REIgO3+/kjCRDlAykkVM13cVrPvktEkOG0oyrMpK
	 OXYxQJXFTIye6vWL8rrnE4oVN6zxiQyQaQMhqiggTCpE0UJUm3hSNVxIjQkPeywjxW
	 S2BnbNVNeCoOyU4azgCA/wHE2y+l7ogmkM6QK+2AchY4WXhsfUdenOSiwjz+LJkGQC
	 8OfekWhrWdbjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	oliver.schramm97@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5 15
Date: Sun, 22 Jun 2025 22:33:29 -0400
Message-Id: <20250622211226-81c907fc68fb7d4d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250621223000.11817-2-oliver.schramm97@gmail.com>
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


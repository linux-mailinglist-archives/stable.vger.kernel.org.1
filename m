Return-Path: <stable+bounces-142888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC35AB001C
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C4505C7B
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86022422D;
	Thu,  8 May 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvlEXBJW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3C28032C
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721090; cv=none; b=TrOOH+EDeHvTmP45DXq/mXpT9ArCMaTcGIQOwjtOJua+njLKbO3DU/lh05V6WVx+z8y5srkGfVFO2mDQ1on+ZgwpHOXyFU41OIbPfwxNQroDMbJLZFcsINuGkeFoF9lgxleng6vV4rDtEd4UkyN3wbwWDC6B66rHikGV9My2LG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721090; c=relaxed/simple;
	bh=cf01kdzsCmEaT6JTXucz+B/0XS+NYp+SjAVKqW34Ik8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTGdjjCHJHn8+XWH56Z6J/ACKYFmdKw9Y2S1mrdbsqMDCAp9fNu0NkRV7iSfAWsisISfiw5dydGqD2H1XG44yUsCwQZe3kmKMOuUMPi2WthfgZaAqZ2D/1nGBB3xJHQ1c5Zbn1jpM4m8VWSV5yCS90rqFlf8g0+3gg/82y3HLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvlEXBJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA217C4CEF0;
	Thu,  8 May 2025 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721090;
	bh=cf01kdzsCmEaT6JTXucz+B/0XS+NYp+SjAVKqW34Ik8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvlEXBJWCYZmHP6ZhIkVAtcSrcODSo/Q+E2wGpXyQQK5CuaFHQRmnrLwUE8xJ1Yc2
	 q5CdWv4gbTIkQ0hD0b1AZzN4wDJ1hY9xX0Olpooq/d0Jlrvr6OXdutsx4u7bAePC5T
	 F8zQHk77LlAA2VJYRvqhaB8fHF6xGjrsKLdwGLs8AMyiUXUPApzhxK1IgiD9I/OFIo
	 YEY0zWw66FzBNSZKFSpEiOUZohb3Yl5btYFlNDW0OP4hLoESJt4cM4c1JeLA7Ks97K
	 +akJOk6Ue6JqqSVRuXTjFwxTPk+9dbBkDAfJT8Ek6lXdVUkC3z4FdgHLqU2hXyxcVz
	 ubtNQpmMxQ6cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kuurtb@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] platform/x86: alienware-wmi-wmax: Add support for Alienware m15 R7
Date: Thu,  8 May 2025 12:18:06 -0400
Message-Id: <20250507080321-4706d5ff17056ff6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250506141921.19467-1-kuurtb@gmail.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 246f9bb62016c423972ea7f2335a8e0ed3521cde

Note: The patch differs from the upstream commit:
---
1:  246f9bb62016c < -:  ------------- platform/x86: alienware-wmi-wmax: Add support for Alienware m15 R7
-:  ------------- > 1:  6d7a63cbdfa6e platform/x86: alienware-wmi-wmax: Add support for Alienware m15 R7
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |


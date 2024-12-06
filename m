Return-Path: <stable+bounces-99967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D443A9E76C4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F221D165829
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714FB1F63F0;
	Fri,  6 Dec 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmX9W788"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B1206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505099; cv=none; b=loruE0uMpDCkkYPI8//ZT2bU6Hs8B12IWFupGujdsJE1CCK80qBJUxmDS/3kXTs42f0tmfzOK0OduzMd0qis0Gm1Q1gIiteIzfgeShmg5soh4IXKNSov44BPdWv2eDjrJDQqy9cNce583scOShlyld6szg4ina6oOSyZFU+Ydxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505099; c=relaxed/simple;
	bh=5kRysu/B0XH6D3HeWDMik/x9a2/nLAzhVll9gw7Q+Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt1AZ+6ILrt1tfnsNdQLloR/LXFMTJ2aZbctLhYbbxEtGNCqdn91+7s+f7mGL/pF+3eidzGHIdzz1cE3WllOoh7uKRJgOcLVVq0/cDBEdgMatYYtHGGzvW0vkeRV568b9ZgZuNiDxrjkGzkIu8Fd38mwk9y1X4AYTGY64YQSR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmX9W788; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F36EC4CED1;
	Fri,  6 Dec 2024 17:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505098;
	bh=5kRysu/B0XH6D3HeWDMik/x9a2/nLAzhVll9gw7Q+Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YmX9W788RXctwp5SnkhrbMS+ab8se6ND8qOAianLT1GNm2RA8N+Ca2cV0Rlbl/0jy
	 hH4N0j+50WZZY67SQCWzNK3ZiSuWFJeRBftdkTrFcnPswgLY0KDYY2TDHvFubkpcJt
	 6WOr/6r/VWgUCliQ1NtEiI9NkqGOmAkry0Tn2/8UigLzq6/ooCX2xND1WQslA6Ksnd
	 haetW6e+nDwQddmS1fMTZa3kiQo6nw+ZHfbwKpHSElGq3SfU6lh3GYFVI9I+F1kJgr
	 qSPz8xouUEMhJfo9lYp3Zo7/+/75wcwTdhzQYWIEWxsrL16HqOaLqW7ELEguy0uWEM
	 gF8uCo6G5XrFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] arm64/sve: Discard stale CPU state when handling SVE traps
Date: Fri,  6 Dec 2024 12:11:36 -0500
Message-ID: <20241206113330-219cac939ed049d0@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206141119.203712-1-broonie@kernel.org>
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

Found matching upstream commit: 751ecf6afd6568adc98f2a6052315552c0483d18


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 51d11ea0250d)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  751ecf6afd656 < -:  ------------- arm64/sve: Discard stale CPU state when handling SVE traps
-:  ------------- > 1:  d4ee6a25278c5 arm64/sve: Discard stale CPU state when handling SVE traps
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


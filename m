Return-Path: <stable+bounces-110058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6784DA185D7
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1083A881B
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A01F4E50;
	Tue, 21 Jan 2025 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbd0tWjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783E1F4E20
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489171; cv=none; b=NrwVJnXnxcCwxZ4aCTltF/zlk3xmZ6RR3fbkmuDCjzWVRNwso8IyzzrRimCZCHGI3YL1AfY6L8BLbGMMRiDhxsi+Y7rjeBzkxyAiR0jIe/weRlH781SldRXbxyMyjS6+4aR33nIzVw1fhtIq4a56opncq5wl1ZQ1HylvLxxTaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489171; c=relaxed/simple;
	bh=yfiVbh6++3g9a/iK3qpK0ELDU4TCwD5+PTtLby3uTes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyV5UZJmM1TazGJAyx45o2wEUIhRG7eSbKBsTPpTojYbRRbdXBJXcmKSNzamlD3k0Yy9Jg4/s8RhbmhJGIt0CZ/vOs214Rcllhr5oL3zl4PRkZ/4yMx+6ASBZa3gr/zGmMB2iCz6UOXmCRPS2bb5+DJFRNG7WwXdEsYIXjkE7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbd0tWjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A89C4CEDF;
	Tue, 21 Jan 2025 19:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489170;
	bh=yfiVbh6++3g9a/iK3qpK0ELDU4TCwD5+PTtLby3uTes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbd0tWjMma2HuL6gG5bZzGCltPlhDMgxj9oML1XiHi1oPv4uPi19/BdxTT5pinGYJ
	 xAmKLXL9GuKWjaPZ/5h/8Zlxv8Q6z0AuYBbaUMWTJj65fWIAU++isytoi8kpmfeBn0
	 Tsxotq13lf9idzPH8fqhlLppNzvjSH1J6nwMMeFURayf3N2BTY3v7unKFTNmkaAV5S
	 9DjETyim06Gds0/gn79ce3giqMOcazexe7URqtxzMOvLUKKkQPFbg4dMn1Zb9sxIJt
	 uVUfcrewinqIhW2Rz6advPV7izOg1LQ7azo2nD2z9rIE/AligRPluzbsqDDxJKp+rl
	 q0zBp91Zp/GwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]
Date: Tue, 21 Jan 2025 14:52:48 -0500
Message-Id: <20250121120422-b8061314be3de96c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250120153203.217246-1-sgarzare@redhat.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


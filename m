Return-Path: <stable+bounces-145031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF003ABD1B5
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6061BA159F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF1262FDC;
	Tue, 20 May 2025 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjNZrrDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE923BD0E
	for <stable@vger.kernel.org>; Tue, 20 May 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729161; cv=none; b=BHme2EsK7syHav3OqZlGUCfVWhcWSKJdD5iJh6Ggtr1g4cOvo2T3TKJblpB7Dt/+3FDpOLYY49uHa3xmcsaFcMQ7XG6rNfNHHL3aeTRClZtYf8sO7O8pO2hgCQPuSQ1/R6GiXw0zSHbieo7LJfGl2xWw66YwJ53Rqa2dj9VsKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729161; c=relaxed/simple;
	bh=1JSWIKBRX+0RNbzxv8RkjZgPHBpUh8QDtaLEtN0LkzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNEpPl76j0lQI/N5onbGusqAgPVSOjlYBHO4SqnzVDodirngLTG9UZOMFIzG3svJUGk6Z+5HSGGUwUtclIHdT8ralqChMW7uFUxJDlZN4WKvNxRX7LryljXi6wpg6suBtBJ0DPxxrmTnHoASlS+npUjrjhKJipG3ldXrau0zgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjNZrrDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16955C4CEE9;
	Tue, 20 May 2025 08:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729160;
	bh=1JSWIKBRX+0RNbzxv8RkjZgPHBpUh8QDtaLEtN0LkzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjNZrrDQIFp6hUjFpvi34BFeDdFVVvbr+oRwnN6uKyOwYzrshxCSXpDS7IPz5yUKR
	 52PMg3IEPSa0SP28age11BGdP40GO1TTEm1ZOCMy6AEPCinBBOne9zS9lG7aJqioKn
	 WzHQYTu0rvkKK7gFt/dcGQAXpF7pCajMv9lQ+8Zy/uviJ0vIrHpn2rMNtizkj6UzeD
	 V4VIUHdUUDw/GHlbtcXWvfb7MCoSxavnw+JBgAKdrRYgnb6wE073bCQ3r/q121yaNX
	 0gSigzpm2bilX4fBuXbWlB06oj6XR4Wvyn9Czv38npBhJmBiAy7xX6J0PqMyZxSfQh
	 rB1WARSOh5Gtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	festevam@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 2/3] drm/panel-mipi-dbi: Run DRM default client setup
Date: Tue, 20 May 2025 04:19:18 -0400
Message-Id: <20250519190053-804eb9744c457e04@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519163230.1303438-2-festevam@gmail.com>
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
ℹ️ This is part 2/3 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 1b0caa5f5ac20bcaf82fc89a5c849b21ce3bfdf6

WARNING: Author mismatch between patch and found commit:
Backport author: Fabio Estevam<festevam@gmail.com>
Commit author: Thomas Zimmermann<tzimmermann@suse.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  1b0caa5f5ac20 ! 1:  bb5f954861543 drm/panel-mipi-dbi: Run DRM default client setup
    @@ Metadata
      ## Commit message ##
         drm/panel-mipi-dbi: Run DRM default client setup
     
    +    commit 1b0caa5f5ac20bcaf82fc89a5c849b21ce3bfdf6 uptream.
    +
         Call drm_client_setup() to run the kernel's default client setup
         for DRM. Set fbdev_probe in struct drm_driver, so that the client
         setup can start the common fbdev client.
    @@ Commit message
         Cc: "Noralf Trønnes" <noralf@tronnes.org>
         Acked-by: Noralf Trønnes <noralf@tronnes.org>
         Link: https://patchwork.freedesktop.org/patch/msgid/20240924071734.98201-32-tzimmermann@suse.de
    +    Signed-off-by: Fabio Estevam <festevam@denx.de>
     
      ## drivers/gpu/drm/tiny/Kconfig ##
     @@ drivers/gpu/drm/tiny/Kconfig: config DRM_OFDRM
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |


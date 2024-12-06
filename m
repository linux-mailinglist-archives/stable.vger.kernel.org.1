Return-Path: <stable+bounces-99963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2F89E76C0
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41381623C5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD71F8AF0;
	Fri,  6 Dec 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhmMB/yT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E31C1F4E36
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505091; cv=none; b=rGD1ol5PacL7bUV9EY+oyyZ1mK+pOcteUH4zNycsKWif+b1Ql7evNh8AG9LOJogDXT2+3TgnuRsC7qX8o9Zc5RmxFmDeQBDUZvBwWjbi8tELkzZn+ALkN9IzBOsRRbS4AyhGarixQF0/1NNbDKwQJKcemtwrsgN06iKMhQDFJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505091; c=relaxed/simple;
	bh=fJIgl/FpOUHCvWPvIAZ5o4iXR+4l35COmsS/45BFD+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYFlMxjCpmVtId16rZbLSl5D6iOmYx3dw8MQGyIKIQIkj4/klhx5IDvUnTmf8+LY9t6bN9AmYRav2UIrPqKTDPLy7+A9sfI+M0xLf3njmMlGJmOEL9dwldL+6WYSht0/h76bZdcUnDAHW17X/iElgqctLFbfF2mIJC1MxGvFIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhmMB/yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E47C4CED1;
	Fri,  6 Dec 2024 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505090;
	bh=fJIgl/FpOUHCvWPvIAZ5o4iXR+4l35COmsS/45BFD+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhmMB/yTtczzGv6hiScTixb5qZlUq+VoHAMFDRskjY0CTw6VNGmBmmvzwE/1KNMBL
	 ri+eo7rBuCTbKehPA9EDmGms5z8S93FrraTyoES+e78XQ0EjAnOCk9F/ZYJhgx9nQv
	 /hj12mGTncw/g0Az6Ynz6rO1zAgVKaXyzmyWWmmIbxtA5LLa+T847j9E1t9BoSPwhu
	 JQJxw8C6YFppMLracnAS94Hn3pcuCtVRUyagzx9fDdTCHDY8pHjAec6caieGV75msJ
	 Lh+TFuOOKhV6d7NwHZLrUTgY1KqbR/l2D8GMYy+sz7o3ws0CaIYEJy/pmX3C22lHiM
	 QLwHWFQLwZ9lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y v3] ALSA: usb-audio: Fix out of bounds reads when finding clock sources
Date: Fri,  6 Dec 2024 12:11:28 -0500
Message-ID: <20241206103625-b02b11d89f7fcccf@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206102357.1259610-1-bsevens@google.com>
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

Found matching upstream commit: a3dd4d63eeb452cfb064a13862fb376ab108f6a6

WARNING: Author mismatch between patch and found commit:
Backport author: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Commit author: Takashi Iwai <tiwai@suse.de>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 096bb5b43edf)
6.6.y | Present (different SHA1: a3e9b49ef5a5)
6.1.y | Present (different SHA1: f30a4d8cb1bd)
5.15.y | Present (different SHA1: db5afb61c536)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a3dd4d63eeb45 < -:  ------------- ALSA: usb-audio: Fix out of bounds reads when finding clock sources
-:  ------------- > 1:  9bf995ef0eedc ALSA: usb-audio: Fix out of bounds reads when finding clock sources
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |


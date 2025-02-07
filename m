Return-Path: <stable+bounces-114324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99658A2D0F6
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E10C7A36F8
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2F1BD03F;
	Fri,  7 Feb 2025 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llEfJtMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947441AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968656; cv=none; b=CT4LpHUriNiPben6X9l0RDYOugr43M7mZ9Bb8iDNU72xfomV+J9lBfg4yM5Q/q81ENvOXTnjeJhgFxAA8RnCNnhVR/zpsuL5LqDh8kF4hWZbfLw5U7HMvpKu8Rdoe7qK7qKLL531Hf3xcFKB0XHq8TH7mUfJkD5p6h1aa80yzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968656; c=relaxed/simple;
	bh=wJfMLgc9T9TVPg3wbLyG+IE/ANQRfteJsXf3jbblUI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnG4YWA4XFZCx5uOSU6H3HTO4XpXWnJckhK0yb/m8E5ZCTq4WfI05tuQ3DI8nSa0xAfCnaoxtzfhQ5/omS0rZUeZ0ZAkCz2n5E6T9rt9OnAbCmiLr/dvaoiQW7Lvy0nQtXiMyIZIwdeC9nwdEXhhde0x1qqCeHfhYKag8IIJBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llEfJtMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D81C4CED1;
	Fri,  7 Feb 2025 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968656;
	bh=wJfMLgc9T9TVPg3wbLyG+IE/ANQRfteJsXf3jbblUI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llEfJtMBAnmub/U6fh4Auz0U4vYhzpdg1JlJ3+p9HJ8AZ2oBFv0smqqCjcdLrElfD
	 rZT4ZdVjgBB6I3GzLTp+DWOP9nXKNYvwkqP54ijFKSJm6NA/mgVHtx8c6oEfm6NXiN
	 OCd+UDO+MqH2JP3tPqctnrWUEsDXaOZoR8WW/SrtDMLxb/NJ/j4zZU9bM6W52s/Jxh
	 i4Z2YY7nmBFlcSx/FwK9YKuI+ZwQZVfAOGTR2qumCZao/gItkcJjikK4NrRYIzGc3y
	 Yppa/AR2CbCgA2jDo0Xq53VwNSu3W0E3f0gY40JZOhNwIawG1MoP3M65+eV/gFWiXg
	 dVDflk1sZ546g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: vgiraud.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Fri,  7 Feb 2025 17:50:54 -0500
Message-Id: <20250207163518-3f0fbd40ecd861ca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250207123926.2464363-1-vgiraud.opensource@witekio.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 985b67cd86392310d9e9326de941c=
22fc9340eec

WARNING: Author mismatch between patch and upstream commit:
Backport author: vgiraud.opensource@witekio.com
Commit author: Lizhi Xu<lizhi.xu@windriver.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  985b67cd86392 < -:  ------------- ext4: filesystems without casefold fe=
ature cannot be mounted with siphash
-:  ------------- > 1:  ade03c938cb51 ext4: filesystems without casefold fe=
ature cannot be mounted with siphash
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D


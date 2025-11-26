Return-Path: <stable+bounces-197010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE874C89B9B
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C61034F8D7
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04FB320A31;
	Wed, 26 Nov 2025 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofXjVZA6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A314F125
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764159590; cv=none; b=H6uHASyU4ahAsVnymmumOZdcnwLpemN3gfa09Kyz0oLu2Ttnxrvh52stU7r3yqw5wWITxqefhe94DMFwqo4jsxKKMuGTjOkJ5B40qVDnuenbEuLti7IdeDAK7XXnizAUOiXEVJr3KELY8N/A9TGsuMb88nzw/Xw6WW7twXLKr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764159590; c=relaxed/simple;
	bh=nZLUh38m8l+uQ11+lRPxhjuqt1CSrhCDtQdj+FjiK10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McrekObEqih8fxSO0IRuO0OVyFq//hWJgIvcq30v5Y3JogF4LEk7mALuOehWW+ahTu8ZuItQFkys2B8iUoNoJm0U+C6RjEfYhC7cZcdHFOCS0A47sM6wZ/AS4ZJypEDWVbuiS/etI3xp/Or7Q6flBYFiv+IqgMGoZCdqIVyHs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofXjVZA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC0BC113D0;
	Wed, 26 Nov 2025 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764159590;
	bh=nZLUh38m8l+uQ11+lRPxhjuqt1CSrhCDtQdj+FjiK10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofXjVZA6aoz0wP2zHN3tWd0AqiJUz7HG4RbgtKea1YwUQFRz0uJCkY+yUMrrAANNT
	 4K1nIyjQ36EG5HoSbg2y3YMj7xFOv+N+z6NyUwfxT7zfECD3j4X/2iikzWFmYFHqK4
	 EHnF6y4iyDODz1JGJVxjqkeCnGRGnGXoow1thZ/2kp8Np/0q029IYnp5R5cm1NRZVC
	 LnVAKAOhgOjpulcYXjQj0p888rh5OTn4a7zygqAGvho2KuXH2wJeVTT5E/gtW0qy1s
	 M8rSwl9ARemeOX35BgTDiERH13MU0bnhUTsapPTkIpZotlcnGQ9V9JYbgy/lsF5Eth
	 iToBNI3TlqkFA==
From: Sasha Levin <sashal@kernel.org>
To: lanbincn@139.com
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Baocong Liu <baocong.liu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
Date: Wed, 26 Nov 2025 07:19:48 -0500
Message-ID: <20251126121948.1361036-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125064028.3295-1-lanbincn@139.com>
References: <20251125064028.3295-1-lanbincn@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.6 stable tree.

Subject: f2fs: compress: change the first parameter of page_array_{alloc,free} to sbi
Queue: 6.6

Thanks for the backport!


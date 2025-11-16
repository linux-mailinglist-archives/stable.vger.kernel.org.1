Return-Path: <stable+bounces-194881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F1C619C0
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005AE3B7E9E
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340F2F39BE;
	Sun, 16 Nov 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwNUZGf3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276A22D9ED
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763314555; cv=none; b=FGQH06754zu6uBcCqZTbxtfnjqWPFWbhrevXHKacZNi4JeVnuNxqdMJSgOu4yOagD8Sndo94L9B9jvW6lLBweEeoeYHcdmvEWJrvSlDikDa/PrpjIvqhCbxqTDePp5kvC1tpqR+3Iyp1NYrr4lmbBPxGj1tistWwqFSmHTgzB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763314555; c=relaxed/simple;
	bh=/iEIAq1+yO3TUPucdxa2PfaceMvo1PMktdBphXeYEMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjwj0KwJ+JO0pxmTH/WGQXH9vfj0XVIYCj/5OR54Xodiwu1qWRzeQiPjssdYNQyfFYbRfVwNw5z0SFaYOKUQfa404aKZE1q1LRwtucMdvZ2X/BEjzlAgY6gApL/rDKFtrE6OHxzTx1gyRj1rQgbdhH+/IwNKvxsbcpsEuXzWYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwNUZGf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDC8C4AF09;
	Sun, 16 Nov 2025 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763314555;
	bh=/iEIAq1+yO3TUPucdxa2PfaceMvo1PMktdBphXeYEMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwNUZGf3dY+nZglGiz5APRMSpRDjd/HAgBr7lQjL7dt422wI3tPyJqJEUMJeEHjZr
	 5QFP0mS9/muW6jLf1Sbwxw9ubWSzF//ctJdJGnhf8asTd3lJraXi7pt1PsU+LxaJu3
	 kXqhoypkIoT6GmuxNYjXnueuGEUJQYDq/Bdv8uqTOQKPYdB8ZTqAmqi/osNVZHsFCW
	 0Ffrpv4Iod1rkLW4VNi4y5e7Cl/q6nb6itYRDO3aDriKCHgPU94qKnC/IpGOXZvCHC
	 0lRmdFlNe3Saaj/FeCmFnz8AfaBc6pES/9i7p1GsnTvImhEbkgON5Eq5FEAy9E3IB0
	 2MuW2oOMAVW1g==
From: Sasha Levin <sashal@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12] f2fs: fix to avoid overflow while left shift operation
Date: Sun, 16 Nov 2025 12:35:53 -0500
Message-ID: <20251116173553.3624778-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114064740.25944-1-681739313@139.com>
References: <20251114064740.25944-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: f2fs: fix to avoid overflow while left shift operation

Thanks!


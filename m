Return-Path: <stable+bounces-194958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8AC649B0
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3181E4E2458
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C074332ED3;
	Mon, 17 Nov 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcjmDX9l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55660645;
	Mon, 17 Nov 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388919; cv=none; b=hrkBj+S6/Gh7voFPnQb7m0pWImKgjRlYbfEMRpNOrIuwqQY2BZd90vD4Y7Btv3Fy0U+awnpT6hNpvvSlzO2KkWGXeyNwbITXUsWkDJH41omrKqPzQ4ZMX6nuGEjtUsEpXtUrxDsiLUsxisHhs7jIEZByGYfYbTTrgyi2yheHVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388919; c=relaxed/simple;
	bh=z1rqxme79mB3G8od2sgEHHs/pMWVkN8IYJhPdcqGq8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcG4cEMY3h7VzAF/YGlVVtoe6leyGlpbL2lX0ywBsHoEdsntNMixKUsBtHuYxjKmK0mTjyLoNk5YxOOKZrNjKi0O8senm+0BNiBi7OcE939gdYzRph9RdhIPFRVmDnjM3vVh8+CytRntWa9iFCMvqpoBkei/IiyAyNWgM+FmViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcjmDX9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B7DC4CEFB;
	Mon, 17 Nov 2025 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388918;
	bh=z1rqxme79mB3G8od2sgEHHs/pMWVkN8IYJhPdcqGq8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcjmDX9li7ll6oqpku8QYAQOjQX1qg6UeGusZxmO44sIhnsVpDYOe4Gbv44IXUNGC
	 x73Gh8sE1uBKPw6OBYfXP/mW/EFkT1RNqHH1Rb/fJb3nQYkGqEmbI0AzKmBqkiCGXp
	 C+4oGwSrQ8Wj5AP6Mb7sT6GIn+XCRq8U48lpiDInW8xOECFKeobxu0okXEbEin2l4D
	 tAmiu0z7/0fXOwmsYqYehqtyX9GoWUBWhk8VF7L4lh306IyjGFx+jxbDbUSkGu2iDw
	 2AzOY9WIUxG8XTzczEyv/gGq9UJTjzYF1C9HQdklp2bEnZ0rcsedkGJgFnnkkcqfj7
	 F0YyT2x2m2djw==
From: Sasha Levin <sashal@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
Date: Mon, 17 Nov 2025 09:15:16 -0500
Message-ID: <20251117141516.3861420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113152256.3075806-2-matttbe@kernel.org>
References: <20251113152256.3075806-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: mptcp: pm: in-kernel: C-flag: handle late ADD_ADDR
Queue: 5.15

Thanks for the backport!


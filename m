Return-Path: <stable+bounces-195035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7EC6689B
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 00:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14F97354680
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 23:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6282327BF6C;
	Mon, 17 Nov 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgWnxdg1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3E2571A0;
	Mon, 17 Nov 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763421485; cv=none; b=hK+9Kpe06pzrAkZlW5FiIK4Mobh3oM04RrhWGxcexYQG+zmiwsDpAoN+5faKK1hKVGFT/qswPcNCQSJyDmqXC9UA/J7wJtoKzywcflKIhpo8Q6b/Mrey5gVlNByB5VQUzKiyN3yq5/0qgCz+aUZIOosLxGjWNeCS5QuzJ8aeJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763421485; c=relaxed/simple;
	bh=4mt3CjTW+Dpx+9tMjlqgZzmCrtXkNdPjs5s5hHOCDFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIqqA2g1vQqc4mey7D+tcsoWke8+CEOYvZXwaK39kPbECyYv/1+iFCpX+iw6gpfeGGydYx/K/aJ1NIA8gIU7g8COL1VCoSszEwXxpXpapeh4fnYyD9cNjjw3S29VQ8r9URau8wZaOQZc2Ff0XTu7kOVVkz5vydj5iKcjnz3pOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgWnxdg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C037C113D0;
	Mon, 17 Nov 2025 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763421484;
	bh=4mt3CjTW+Dpx+9tMjlqgZzmCrtXkNdPjs5s5hHOCDFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgWnxdg1HpYmHjHLHP9Je39sTeFIyc2KX/ssaw3jHo4rjCTeyvwnwyZwcUJRZ+/7/
	 KOVsosztRDYxXDJFqeTwaXjjh/SQSxI3+LCNFHp8Vpm1usKyFKnd5O2FvQpOPXzGVY
	 l+QzS2hj3ComO1+Biuj+XLMCn3iMafJ4Ke7tVfpquOLIL/XQ8hT9DouHfvhcayTQoL
	 GXUTldoFx153bi1FPxnv1bO4ptt923UMVUJoU1sEez0Gv1xsWhGGXrlaXMDsb+xF7a
	 E4nJXe+jHj17Kh+0vGPPCpkMPEjbDZXmmK0Qdvpp0X5lQBZB5hyTizGGFqrXcGlLYs
	 4mO6wdON3UIxQ==
From: Sasha Levin <sashal@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH -stable,6.6 1/1] netfilter: nf_tables: reject duplicate device on updates
Date: Mon, 17 Nov 2025 18:18:01 -0500
Message-ID: <20251117231801.4114008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117213921.858836-2-pablo@netfilter.org>
References: <20251117213921.858836-2-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.6 stable tree.

Subject: netfilter: nf_tables: reject duplicate device on updates
Queue: 6.6

Thanks for the backport!


Return-Path: <stable+bounces-194882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC59C619C6
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DDC14E252E
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBDC284B58;
	Sun, 16 Nov 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxjLWado"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E6227B95
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763315062; cv=none; b=qrOJAUxAxomJHVhzIBFz/dtT04rGYVbgEyVXNF2OKEsxZu2o8em1eInMeLGVgCt3S/ahQmuw/uANh7vi6DgJtnSHOYyZbm1a4ROnx5XOzUq3sWqFWABIlQBmq8EjKOkXjUiTBYrAEDXo1h91m6ISmpBOAkDH/mtLK0tvRl4ouP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763315062; c=relaxed/simple;
	bh=RPf7+yPtrLxpvHBw+ameWTp287RzIJ/0tQXV8IJS6lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hv6etrVh2/gZ89VzTehZ5YvrW1XYVENIoiCi87ok349beJHkla/YFUO5azBBzQ5cpMXWKmEbv/meF2ZcanVZxR6YogtyFyX/rQ7ibOSSG8SlddWEwdiyhaOdmD+5nxiLuuSk12ol96Vf4K655R6BD9FX0hecm6kpqWqxUK0bPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxjLWado; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A77C4CEF5;
	Sun, 16 Nov 2025 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763315062;
	bh=RPf7+yPtrLxpvHBw+ameWTp287RzIJ/0tQXV8IJS6lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxjLWadoJyUiQUPHOopEzqia1ZE6x58ETCFtD22dB509rFG24rpkQiJnuax27KliL
	 Vw/tZOxJFUjha51YJu5EwL9UesGqc6NO24Z/uTGACLCGu/mWbjthy+TatQuBs6HkLz
	 QcPf1MMAFpwYdtz2X+t4khTx5hUHmh7+TYs+MhDslD1Z5wx1s4iFu9mmEtt+iiIYev
	 AF5uLyfEhTvWykeF/uGmn5Cg/TFNflvpp3eOct5rA74nOrbADl2Eg2H/NJsZGp9Tad
	 aBK5TPHgvrMjh86g+6FecVOuPX0PwEF58HYFAZ3ESxquzpUj4qbpAfFcVLkidTksiW
	 WNtsKoJkJYKJw==
From: Sasha Levin <sashal@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: dsahern@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: fix NULL pointer dereference in l3mdev_l3_rcv
Date: Sun, 16 Nov 2025 12:44:20 -0500
Message-ID: <20251116174420.3649860-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107035902.3695-1-681739313@139.com>
References: <20251107035902.3695-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: net: fix NULL pointer dereference in l3mdev_l3_rcv

Thanks!


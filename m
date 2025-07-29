Return-Path: <stable+bounces-165137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8BB153DC
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C391898043
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9B295537;
	Tue, 29 Jul 2025 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYQltr2H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9972951BA
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818335; cv=none; b=vBW04W/FvteT+PaJG1xdtgrqRn1Z7oSncSRJaib9oUcaiihXZtNFAYpnpCqgiVZyk28zvYZrs8Bt/vK0sRZaPAxvhUjPcs26NDAfTeK25cbw3WvPWMNlRVUcOUCtQ4ahtgSYFTulJdmQ6q1PBdFGvc58LWPIZjqAQvZZWlJrBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818335; c=relaxed/simple;
	bh=8U/chku4DaS6mFC5PdIL8PlVW4723dW9HHD+IcX1l8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlsJrrDmwR1pJicQWxFzWHF6Hb6E6Lv3JFY5YqQGsZCBSm6JLNZ6kttEitKbnTERAJMNOvJ8CDvtD/tNrrCvMeH7XdUy9u4ZOlrwtXz7gawJzDRPt59uJL9xedi1KEmqJQRTle7iZIilgcn097+08M2SEzVG2K7iH6ogZmj5Rw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYQltr2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DCDC4CEF6;
	Tue, 29 Jul 2025 19:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818334;
	bh=8U/chku4DaS6mFC5PdIL8PlVW4723dW9HHD+IcX1l8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYQltr2HWqKgQOk4VhimEXVJV40Gj0CDzwLMNoUDVnVa8AlSgvAKHSx2rcfArZY21
	 QvEt/a8CzhIsNyjiOxY9XBtocZajtMH3x5e3bHI/i6IAgjiskUmDH4xwo3dT+FHdAy
	 7q0MqOejOG3FdYZmiPY6kEr4stjt8ZM0+BQS+nV2lGsOkIv9cHeXrPo4R1wENpdCZL
	 O5IAyCeuu1wHvTON0EZom8ofByIFN6JsBlsq7IiXD0t3KeDzO9ngRBDC43nrzwyYce
	 APrnzdgoXS0dP4VLTw61Q5767HTAwYyDqzKXFfaMWJI2d11I6o89M2PYdnYmtXnyyN
	 6hlHDrk7m/60w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	justinstitt@google.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] KVM: arm64: sys_regs: disable -Wuninitialized-const-pointer warning
Date: Tue, 29 Jul 2025 15:45:32 -0400
Message-Id: <1753813152-8d44cca8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728-stable-disable-unit-ptr-warn-v1-1-958be9b66520@google.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Success     | Success    |


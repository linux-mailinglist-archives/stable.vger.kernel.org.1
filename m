Return-Path: <stable+bounces-150752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB4ACCD23
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069EF3A67F8
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AAC23BCE2;
	Tue,  3 Jun 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSbh/RZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386BBA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975761; cv=none; b=PU0rvNiG2/+xCPzdT0ilNsI+bDJ6ZsN3n9qIpdfvcWD/RbDZ6n2OMXjSgHxQo8xwlQmXcCNOycWRO0xDKhFE7RFyL/aLu9LfeOydoo3JC4D8Pr4J3YllZTvVrjCkIsUCUz8pbGdMZsI1dXhL2lkhHNEM7bngZTCAXboSaNyzk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975761; c=relaxed/simple;
	bh=sj12GX9zL103L2i5oC8eSPpUWT3o56foKYeuHCSxo/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEABSRVXo7/1F/xDcnnFST+cghPKxEkl4P+qQE7NT6vaEVFjCeT2Tl+W/hWmpz5FdOk8RNNzu30Lu+f7YFIBC/JTs4+q1OWWCpffqS9clC0SYUmLRy35e1Lf/xiC3f34A7mNdM6a//LAOGjpCU14GSeFAc3749zipapQ4E1LWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSbh/RZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44F9C4CEED;
	Tue,  3 Jun 2025 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975761;
	bh=sj12GX9zL103L2i5oC8eSPpUWT3o56foKYeuHCSxo/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSbh/RZs6vukfpNGxZqWJJdFW+tLbR5phOkSFBLlLiWaz5B5k9TdcwusYvcyBDoZG
	 rgtzW2XPR0S9GG7O5qHrUzXM5ErHmOZwkC9Ik6k3eh5Dfmc6nfpXlovvaxJR6uqHMB
	 9LKIO3RABWd1jZqi9hxOGCdS31IMuTjufvj724qKCzYFQL+yyJM755QvEQBZmc7VX/
	 HlcKKwHl9ZoknXoCbAiEJ1f1PTBikClY7O8xw9mOYc6q2V+4ceV+skk7QUKUOQ6OC+
	 A802bQaq6EYr0Heajtr7zb4gqfxviWBCcC7b/kLSW6eVnFSDk3UUbh8Yu0Pz2S+7dk
	 z67yUwHlq6tJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 3/4] serial: sh-sci: Clean sci_ports[0] after at earlycon exit
Date: Tue,  3 Jun 2025 14:35:59 -0400
Message-Id: <20250603142718-0fc0e63f5e602a4e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250603093701.3928327-4-claudiu.beznea.uj@bp.renesas.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 5f1017069933489add0c08659673443c9905659e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Claudiu<claudiu.beznea@tuxon.dev>
Commit author: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5f10170699334 ! 1:  b68647923713a serial: sh-sci: Clean sci_ports[0] after at earlycon exit
    @@ Metadata
      ## Commit message ##
         serial: sh-sci: Clean sci_ports[0] after at earlycon exit
     
    +    commit 5f1017069933489add0c08659673443c9905659e upstream.
    +
         The early_console_setup() function initializes sci_ports[0].port with an
         object of type struct uart_port obtained from the struct earlycon_device
         passed as an argument to early_console_setup().
    @@ Commit message
         Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
         Link: https://lore.kernel.org/r/20250116182249.3828577-5-claudiu.beznea.uj@bp.renesas.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
     
      ## drivers/tty/serial/sh-sci.c ##
     @@ drivers/tty/serial/sh-sci.c: static struct sci_port sci_ports[SCI_NPORTS];
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |


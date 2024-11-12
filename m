Return-Path: <stable+bounces-92698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB99C569B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD356B3F6DF
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B40F2194B1;
	Tue, 12 Nov 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rJy4jhku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622F2141A4;
	Tue, 12 Nov 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408297; cv=none; b=BTAc9Wn2vQ2G+lCexXOjYWueEjjaDC1iuMEAhp8yJL8PRr0z4xEmM3zZ4Y/kKFN7RzbrzXwz1KXgYy2Am8ffY+TRbFFKNbn1kHu9/xlTclsnPWvqc15NrtEgDQVH9Xl3903Pm6D7ghGOPOZoE8vktgHDZhdfQiYVY5H4Ug9YwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408297; c=relaxed/simple;
	bh=rjtdnUDnuAekcL/rKPAeDlrVogQV5XhObUvIGyU7sTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn+rIKenWuf+y9ENS1agZVNr44rTBBXX3hYNwUFzRpK7V2QmnBZpHQXJWSuOrzqVwpeVktXTJsFR7qwYdDPL/QNsPnCoN1W+dNmDKw6SZyIqkMsXRSbu0pPeKz2igJpEf5twut0Ej+M+KUhqV8dsipd3YNWbakg2LHou9q5nTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rJy4jhku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23A2C4CECD;
	Tue, 12 Nov 2024 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408297;
	bh=rjtdnUDnuAekcL/rKPAeDlrVogQV5XhObUvIGyU7sTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJy4jhkuxsCcUwrVrnXP/K6sUecFAVnFne4TSAwRR9kwdihfHQzjSVj/vB55ETyTM
	 +8vLMid28WEW71IkZQR/u0CTnIXpL3AxzziEabiMPLFW74X6CSCMzMLkSgAdK2cUde
	 E8wgXWrQBdQ4Pmu8FtBuchlcWfdPDlPQNYHrzuDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zichen Xie <zichenxie0106@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.11 119/184] dm-unstriped: cast an operand to sector_t to prevent potential uint32_t overflow
Date: Tue, 12 Nov 2024 11:21:17 +0100
Message-ID: <20241112101905.436433283@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zichen Xie <zichenxie0106@gmail.com>

commit 5a4510c762fc04c74cff264cd4d9e9f5bf364bae upstream.

This was found by a static analyzer.
There may be a potential integer overflow issue in
unstripe_ctr(). uc->unstripe_offset and uc->unstripe_width are
defined as "sector_t"(uint64_t), while uc->unstripe,
uc->chunk_size and uc->stripes are all defined as "uint32_t".
The result of the calculation will be limited to "uint32_t"
without correct casting.
So, we recommend adding an extra cast to prevent potential
integer overflow.

Fixes: 18a5bf270532 ("dm: add unstriped target")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-unstripe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-unstripe.c
+++ b/drivers/md/dm-unstripe.c
@@ -85,8 +85,8 @@ static int unstripe_ctr(struct dm_target
 	}
 	uc->physical_start = start;
 
-	uc->unstripe_offset = uc->unstripe * uc->chunk_size;
-	uc->unstripe_width = (uc->stripes - 1) * uc->chunk_size;
+	uc->unstripe_offset = (sector_t)uc->unstripe * uc->chunk_size;
+	uc->unstripe_width = (sector_t)(uc->stripes - 1) * uc->chunk_size;
 	uc->chunk_shift = is_power_of_2(uc->chunk_size) ? fls(uc->chunk_size) - 1 : 0;
 
 	tmp_len = ti->len;




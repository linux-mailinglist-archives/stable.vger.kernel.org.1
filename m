Return-Path: <stable+bounces-85452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA599E764
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4DE28699F
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95C1E6316;
	Tue, 15 Oct 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oQqhfSFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A111D95AB;
	Tue, 15 Oct 2024 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993162; cv=none; b=Hbq/iq9a3QH4X1kEgVWxdfvDQqat0j9ud7s6Mv+C6RBvkuNQNvfGAeLdWszNBmmtIrBrC8xFJGkevwtDWhc3GTopvZqguw3zvPLOzW2karXIXIxhTFMk4UD+0pkfHoyjK4OwfYZlJOTwfiRvqLH5SCSf/mIDBao4pV315mGjZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993162; c=relaxed/simple;
	bh=F3zQg0X5ArO2y7eVdgEv9SYa8ShD3rHe4KKFdFZaQNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1S2qyvo0FXCpUlkrJLyPSmtnQeVx8080ZJVzcsLwsi7a7DDsJY4C7xEsd1WHVYDU68eE8ew/mR/KL+JMkW8ThnYCbWHIJoZGrqSQXP+ftRjy9yHJekepv0ecMrTmUZbvvSepKQVFN9n1YYpSzFMJv3wsMdiDXNNPj/wkUdIbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oQqhfSFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A21C4CEC6;
	Tue, 15 Oct 2024 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993162;
	bh=F3zQg0X5ArO2y7eVdgEv9SYa8ShD3rHe4KKFdFZaQNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQqhfSFXDv5jRb2+AFxkRM+GfUBfvXrRpWaGrAjsjvEe8cLwI64I2xQPPfcZTyF1L
	 8mSZabyJM6Qe04aJoiobU1pbBdEcZ/sMPsaCQDSWzResslfUrTQwg1MtdxdZ/f3zwa
	 +4kJwZJa10gb2J/QCSLrPtNy64WsIdNFAfmM4KlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 330/691] drbd: Add NULL check for net_conf to prevent dereference in state validation
Date: Tue, 15 Oct 2024 13:24:38 +0200
Message-ID: <20241015112453.433464254@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Lobanov <m.lobanov@rosalinux.ru>

commit a5e61b50c9f44c5edb6e134ede6fee8806ffafa9 upstream.

If the net_conf pointer is NULL and the code attempts to access its
fields without a check, it will lead to a null pointer dereference.
Add a NULL check before dereferencing the pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 44ed167da748 ("drbd: rcu_read_lock() and rcu_dereference() for tconn->net_conf")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Link: https://lore.kernel.org/r/20240909133740.84297-1-m.lobanov@rosalinux.ru
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/drbd/drbd_state.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -876,7 +876,7 @@ is_valid_state(struct drbd_device *devic
 		  ns.disk == D_OUTDATED)
 		rv = SS_CONNECTED_OUTDATES;
 
-	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
+	else if (nc && (ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
 		 (nc->verify_alg[0] == 0))
 		rv = SS_NO_VERIFY_ALG;
 




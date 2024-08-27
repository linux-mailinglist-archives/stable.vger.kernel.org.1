Return-Path: <stable+bounces-70686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB20960F85
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8D31C20AC1
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3441C579F;
	Tue, 27 Aug 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SP7qKqGY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D91C0DE7;
	Tue, 27 Aug 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770732; cv=none; b=Y5Pm2upK34KKI5sdq5easKWX6BLEPLADqKd4+Fya461x3yECnvFZLPTY0DwpAKvPkl+lTB7PnH2jem93WYqVWKrm6WO5vbUD6nRCEbX2fx7oLmgg8jB43D3UJEpnuN959H3v4HTQaQcRW1xSLsKCyyUm+hc1JNXp1Ly7annXudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770732; c=relaxed/simple;
	bh=vwXdOxn8HUWuQ8kisHRBqj1JsKC5XsDMKQ+X6KE+o9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvbCDDLKhORDXmmwm1TcqHRdOHCf/88772Axjo1gP4cXsTSHgE+4ifxEBAzLLEdw7YWmTV5dS/lKsqAiOGhnO/NGVHvYWu700/ne+Ak0HgMbsS1NAXNXxNMJtwS7qoHlrugjBzsf0vVGUmmWb+VFCmd7xRji1mB8PtAeZaKFQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SP7qKqGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8745C61044;
	Tue, 27 Aug 2024 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770732;
	bh=vwXdOxn8HUWuQ8kisHRBqj1JsKC5XsDMKQ+X6KE+o9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SP7qKqGYTNAfGD5He/qVbGmUia1ycbmHGCUUIQykL7pdniUftWxdYw/Pdb0C6qLot
	 XWsTgZmSfQ90gyJElk/b435dYPp4HMliWRlIhX6/2yCcJwrFZrJnH6fHYr7M0nVQN9
	 z5NJkJy0PewV4pqmvKOnE0ZLM3ZMKZq50fN/r77I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 316/341] mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
Date: Tue, 27 Aug 2024 16:39:07 +0200
Message-ID: <20240827143855.420429923@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 0137a3c7c2ea3f9df8ebfc65d78b4ba712a187bb upstream.

The limits might have changed in between, it is best to check them
before accepting new ADD_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-10-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -856,8 +856,8 @@ static void mptcp_pm_nl_rm_addr_or_subfl
 			/* Note: if the subflow has been closed before, this
 			 * add_addr_accepted counter will not be decremented.
 			 */
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		}
 	}
 }




Return-Path: <stable+bounces-197146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B4C8EDBD
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1963B2383
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD67D27FB1E;
	Thu, 27 Nov 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NzsuZ/7P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0C273816;
	Thu, 27 Nov 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254923; cv=none; b=B7giLugeBsA51svbO2PcGusSKHbvkKOS3YfNAzGardvpp8g5Zgvto1CmN50s+VM+L49I16zDDsQF1X8OBKu0h4Dx9sEJe3yZcxxppFI1e3RrUhqvvfnIiisWjZmkM4JPFSFYzwvjCWfwTrRK6uj42ZzqQ7lhteTFR3sR88s5VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254923; c=relaxed/simple;
	bh=CYRneJtQT4A3tJsOBHsl2/TVdDupRYlQIQDEaFBaEvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+a462XdTeDTs6AYN4ouZbLezASvzXMuuO6lc6Uy5TPY9HC3Yqh4PXjQdOLDzvXLhCkSgU68HlgTPFV7csyZoWPJLj6liWriDiOtkCR4oyoJ0BIjw+2vqqh38oNeSQidM0YNbgBGJBa6IRvYb1OCpRtCeOl7Jy4XXVS7X670lWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NzsuZ/7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11F4C4CEF8;
	Thu, 27 Nov 2025 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764254923;
	bh=CYRneJtQT4A3tJsOBHsl2/TVdDupRYlQIQDEaFBaEvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzsuZ/7PY8cfBoSuzv/qPeregI1Hj4GAwzMH0o4dorMSwpPiJZoeFJ3arq051LYaH
	 MLe2ZAB3WLrNiglmEf0vVHOwdVaazBOMJcLQ2fzwNElKfdDZdpm+/xp7NVrCQIXBlt
	 koivHLfXn7HNp5xqOJmfnsUInEzYD5UZNjcMruXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 33/86] mptcp: do not fallback when OoO is present
Date: Thu, 27 Nov 2025 15:45:49 +0100
Message-ID: <20251127144029.033901702@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144027.800761504@linuxfoundation.org>
References: <20251127144027.800761504@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Paolo Abeni <pabeni@redhat.com>

commit 1bba3f219c5e8c29e63afa3c1fc24f875ebec119 upstream.

In case of DSS corruption, the MPTCP protocol tries to avoid the subflow
reset if fallback is possible. Such corruptions happen in the receive
path; to ensure fallback is possible the stack additionally needs to
check for OoO data, otherwise the fallback will break the data stream.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-4-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -904,6 +904,13 @@ static bool __mptcp_finish_join(struct m
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);




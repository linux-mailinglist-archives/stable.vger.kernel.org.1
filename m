Return-Path: <stable+bounces-165270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 808F7B15C56
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835EE1887BE0
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBEF275865;
	Wed, 30 Jul 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HydYjluX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013A26D4F9;
	Wed, 30 Jul 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868465; cv=none; b=S/biKIJJqqB4bgMy+an01xFz75y9pAz9tI83Z35UqvJzbIJ1wyabk5MVY+ra3irCYat94FZSOoiyhzZnDW7+S2s4vwN/KS8Ln1HzZmhCTTZ8lFwPkVMZhZLqkmfHJWhklRF9Rpzx2pEXb58Mjol0oRx1LbmxTQWnFJXwwrKYptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868465; c=relaxed/simple;
	bh=Aw3qbmxO2I9h+B2QyfaxdcVg9LwdrasSn9owZNLPTOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lt/V3nfhHX2aNPS8klRNU1PggnvZ8iJidzz9N/9dEGRm4rs+XS0BE9clUCgc8jTtuwcn4KpEIBFsqha25DIuc5JqTho6v5bWQCPlT7lnvQ4O4NN9s5HBhR+e57Fgpaw2cGkOdX680oxnKe0cNFg2Rcdmnbm6fiHAVsdIJ3Js/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HydYjluX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9DBC4CEE7;
	Wed, 30 Jul 2025 09:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868465;
	bh=Aw3qbmxO2I9h+B2QyfaxdcVg9LwdrasSn9owZNLPTOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HydYjluXGZ+C61I5lbfX1KGLzUwmnBTF9lSgg7sqdE7lzpeEnf7jbZJu/DTthUUrI
	 rprN6rJn4RX2sGQjj74+ZTDQ4MMb1W1qocS1HmxepL0ubtZ1KsgHVPDQcPNqH4bpVs
	 P4yfNCKZaGUysXAXz8Pr8nhI0Z6sxoTkip9zBbiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 72/76] mptcp: reset fallback status gracefully at disconnect() time
Date: Wed, 30 Jul 2025 11:36:05 +0200
Message-ID: <20250730093229.656732347@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
User-Agent: quilt/0.68
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

commit da9b2fc7b73d147d88abe1922de5ab72d72d7756 upstream.

mptcp_disconnect() clears the fallback bit unconditionally, without
touching the associated flags.

The bit clear is safe, as no fallback operation can race with that --
all subflow are already in TCP_CLOSE status thanks to the previous
FASTCLOSE -- but we need to consistently reset all the fallback related
status.

Also acquire the relevant lock, to avoid fouling static analyzers.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-3-391aff963322@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3208,7 +3208,16 @@ static int mptcp_disconnect(struct sock
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
+
+	/* The first subflow is already in TCP_CLOSE status, the following
+	 * can't overlap with a fallback anymore
+	 */
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
 	WRITE_ONCE(msk->flags, 0);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	msk->cb_flags = 0;
 	msk->recovery = false;
 	msk->can_ack = false;




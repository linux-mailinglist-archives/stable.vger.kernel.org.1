Return-Path: <stable+bounces-71311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3089612CB
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49311F2415A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2F1CE703;
	Tue, 27 Aug 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKAI3Hte"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF1D517;
	Tue, 27 Aug 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772796; cv=none; b=oH7dOOKHcZtrFwU2k+wtVniDqayzTBvuUljAlIr0BDGNsL0kVYEL3UVXmy21k3jhj8LnD8tfUkr+Oy67cYCmJb8EqmZxtWsAI1e7Qz/S4zqxubZ3l1TFR18gf4+f/mUS8t3CRCnwGRSyYLX4425zHmjxdbZk55jivlV813bFgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772796; c=relaxed/simple;
	bh=b+Ix5Y51hiF4qP9XNMLC+HlklOan+Hio8apxDUAEXk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3htWA+z3Y6PD1s2MLLZNXxmPX/V7VK4Gr1Yq2VkiI7aJRn1F0Tm4JXYdzwNDKqdNTYvFUOtlcEzr4feuiwbU57W5jtkxuE81fnReXBinpq31FxNMPyCt0iwKj1ySHvGyj66b20upBrABW8atmgaechRQvPUrY+Nh3Dk339dwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKAI3Hte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF5CC61050;
	Tue, 27 Aug 2024 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772796;
	bh=b+Ix5Y51hiF4qP9XNMLC+HlklOan+Hio8apxDUAEXk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKAI3HteXW/mYNC7TdpavuE3rj9x5xS35QZL1tCvtTnrfbI7Ln/zuGliQoKqmo8sj
	 9V1JUUbfZItAJgqxs/7YtW7emGc2zMZaODOBX+8AJw6Hmk9hA9EY5ePTUhnyqwNlU7
	 G/JR8TeL2L/ODAzrhxtscOzH3JJaaKYvl4nXyI18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 304/321] wifi: mac80211: add documentation for amsdu_mesh_control
Date: Tue, 27 Aug 2024 16:40:12 +0200
Message-ID: <20240827143849.827588377@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 3caf31e7b18a90b74a2709d761a0dfa423f2c2e4 upstream.

This documentation wasn't added in the original patch,
add it now.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 6e4c0d0460bd ("wifi: mac80211: add a workaround for receiving non-standard mesh A-MSDU")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/sta_info.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -621,6 +621,8 @@ struct link_sta_info {
  *	taken from HT/VHT capabilities or VHT operating mode notification
  * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
+ * @amsdu_mesh_control: track the mesh A-MSDU format used by the peer
+ *	(-1: not yet known, 0: non-standard [without mesh header], 1: standard)
  * @fast_tx: TX fastpath information
  * @fast_rx: RX fastpath information
  * @tdls_chandef: a TDLS peer can have a wider chandef that is compatible to




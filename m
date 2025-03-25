Return-Path: <stable+bounces-126227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E537A7002C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1C3BFFFF
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF126773A;
	Tue, 25 Mar 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u4YV43uc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F54267734;
	Tue, 25 Mar 2025 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905836; cv=none; b=Hs4fTU1DaavrNl0Tq9HSKEdX3yuVHw/pa2VmEefvFLDT6LrfiP7MfEKP6i4PjHFWG5GMPr8J8wouFSyutCn/skm0kJRgr3Te8cOKZbKQqoFDNPzPBLBHzrtEno9/y+n5xt6e5vQv/2dpaN3yoHKeHijSjGF8KJriSdVDG8IOALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905836; c=relaxed/simple;
	bh=3LuGyXzhSDdqlyOYjY+s5fvjVGKu3zpO1sxWxd4liSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnB1gCnqOA5wClu1mYH1Ve/nNg/2a6OK0Y1BEXcqfhCYkKsDWtamFODxJ65K/UN7yfXwnXXhzvkGJGY6kVkAVynsvq7mFJUhBQHy1RPZ3pWPbcWERJTHmVU7zbofvG3sWY7IncB1YMZHtWjAxDOREz6TnF17H2h47Xpx5BHeEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4YV43uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362F1C4CEED;
	Tue, 25 Mar 2025 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905835;
	bh=3LuGyXzhSDdqlyOYjY+s5fvjVGKu3zpO1sxWxd4liSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4YV43ucaCBkOmvVbT0Mp7yS38k7Plxun/lCvuQ4qDNoaMUujnYNMh/1MdlKtzrlD
	 PExDc2LALdyqbHLhc1CBM09dg0yK+utUNiWGWEbevP7z+LFanyUnTYMB3PItrjGKrd
	 bGjWZmXdpP5q9naeHMdA2H068rlIgwvDEaH2Ed4Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Arthur Mongodin <amongodin@randorisec.fr>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 6.1 189/198] mptcp: Fix data stream corruption in the address announcement
Date: Tue, 25 Mar 2025 08:22:31 -0400
Message-ID: <20250325122201.607775451@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arthur Mongodin <amongodin@randorisec.fr>

commit 2c1f97a52cb827a5f2768e67a9dddffae1ed47ab upstream.

Because of the size restriction in the TCP options space, the MPTCP
ADD_ADDR option is exclusive and cannot be sent with other MPTCP ones.
For this reason, in the linked mptcp_out_options structure, group of
fields linked to different options are part of the same union.

There is a case where the mptcp_pm_add_addr_signal() function can modify
opts->addr, but not ended up sending an ADD_ADDR. Later on, back in
mptcp_established_options, other options will be sent, but with
unexpected data written in other fields due to the union, e.g. in
opts->ext_copy. This could lead to a data stream corruption in the next
packet.

Using an intermediate variable, prevents from corrupting previously
established DSS option. The assignment of the ADD_ADDR option
parameters is now done once we are sure this ADD_ADDR option can be set
in the packet, e.g. after having dropped other suboptions.

Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Arthur Mongodin <amongodin@randorisec.fr>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
[ Matt: the commit message has been updated: long lines splits and some
  clarifications. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-1-122dbb249db3@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -649,6 +649,7 @@ static bool mptcp_established_options_ad
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
+	struct mptcp_addr_info addr;
 	bool echo;
 	int len;
 
@@ -657,7 +658,7 @@ static bool mptcp_established_options_ad
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
 		    &echo, &drop_other_suboptions))
 		return false;
 
@@ -670,7 +671,7 @@ static bool mptcp_established_options_ad
 	else if (opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
-	len = mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
+	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
 	if (remaining < len)
 		return false;
 
@@ -687,6 +688,7 @@ static bool mptcp_established_options_ad
 		opts->ahmac = 0;
 		*size -= opt_size;
 	}
+	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,




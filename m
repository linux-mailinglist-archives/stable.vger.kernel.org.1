Return-Path: <stable+bounces-25851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6386FBD6
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9913E1F21877
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC917565;
	Mon,  4 Mar 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z9sLeVWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8F175AB
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540932; cv=none; b=bat14S4pZs4LUdjF5MWBhoTMIfk+H4UhMekQiomyxLIlFHWycp13rQhhsOiRwfgESeboJp3x4xJEX2L+78cB2A1gjH7+gVzWAAUGwagk7Lle8P1qc77D8/ySzVCZycDA3tuwY2bockLGBv27/IObHb+1IfWGOK4/CcSEkhjDE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540932; c=relaxed/simple;
	bh=gPNlsrvPTyrCgpzVz8w/4R/45Bs6EZFtVjT4ysCm7ow=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=itcnevcfc7PmYtHMRs5fJui+LnSu2wJyhpLur9GUxc0e5ka4PbE9rpgkvB+a3WfYWMUIRIeh8w9p3iTxlRMWK7ARufB01hI0Y26OyxvO/396ejvOs+EgYHeLyZJHc7AQUAcZSIOTYUrNJMwe+t5Yrz9KTTMRx7BZ0aZNKHcl9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9sLeVWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2F0C433F1;
	Mon,  4 Mar 2024 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540931;
	bh=gPNlsrvPTyrCgpzVz8w/4R/45Bs6EZFtVjT4ysCm7ow=;
	h=Subject:To:Cc:From:Date:From;
	b=Z9sLeVWGLYtCnygJ+1VOJz/+gcWnbX2vMTkL3eJjvjkdFimqx5ED+riphxh14MwRx
	 wEsa0J/dykrhnlAly5MCfPbFgXP/fD20mDhZdSE196p66YfdSev1I+/jh5gzK28izI
	 A6/iR55sh/8GOXMRBkpam08hHp1VGIkSnkfqDB98=
Subject: FAILED: patch "[PATCH] mptcp: push at DSS boundaries" failed to apply to 5.4-stable tree
To: pabeni@redhat.com,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:28:48 +0100
Message-ID: <2024030448-walrus-tribunal-7b38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b9cd26f640a308ea314ad23532de9a8592cd09d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030448-walrus-tribunal-7b38@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

b9cd26f640a3 ("mptcp: push at DSS boundaries")
1094c6fe7280 ("mptcp: fix possible divide by zero")
8ce568ed06ce ("mptcp: drop tx skb cache")
4e14867d5e91 ("mptcp: tune re-injections for csum enabled mode")
2948d0a1e5ae ("mptcp: factor out __mptcp_retrans helper()")
eaeef1ce55ec ("mptcp: fix memory accounting on allocation error")
d489ded1a369 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9cd26f640a308ea314ad23532de9a8592cd09d2 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 23 Feb 2024 17:14:14 +0100
Subject: [PATCH] mptcp: push at DSS boundaries

when inserting not contiguous data in the subflow write queue,
the protocol creates a new skb and prevent the TCP stack from
merging it later with already queued skbs by setting the EOR marker.

Still no push flag is explicitly set at the end of previous GSO
packet, making the aggregation on the receiver side sub-optimal -
and packetdrill self-tests less predictable.

Explicitly mark the end of not contiguous DSS with the push flag.

Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data packets")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240223-upstream-net-20240223-misc-fixes-v1-4-162e87e48497@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 948606a537da..442fa7d9b57a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1260,6 +1260,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
+			tcp_mark_push(tcp_sk(ssk), skb);
 			goto alloc_skb;
 		}
 



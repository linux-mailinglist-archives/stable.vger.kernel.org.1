Return-Path: <stable+bounces-113792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C7A29325
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FC87A118A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07330155327;
	Wed,  5 Feb 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XiC5eZYZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72321E89C;
	Wed,  5 Feb 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768188; cv=none; b=AP9o5+qYwxQBMT7rXI+WFSqdZZ7nPB+SfiO8Uuj1IyVxgzeVaxWlJkPOsgSxw8FAjeZG1GdWReXesW5iyBsgqdPyz3CcSmfpFNwpSfUgVFOofnfFjxV7wjqjKaVqnocrA6ijBw0ZKsts8y4PF5il4gWa2KrT2Ei6m/86g32CT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768188; c=relaxed/simple;
	bh=4HOGczX4n7l0SqUMM3Wxqbi21GrRLlNvACqxYKTFokU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu/d1HCRRhEr5T2ZkMjobGKz5Enz0IET3KdivLokNbIf0gnJmMMSpRbDsMw5UUmW2KCTsZTmY/PyQCL9xHYEpjcm9uVIMNARGPBwZ1Dn2tDXWcV+VeDwJj8dJir/2VnSvvCgZfc+zMDyI1uaxj2nBFzHTpcUd+pL91Uv3fbkXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XiC5eZYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256BEC4CED1;
	Wed,  5 Feb 2025 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738768188;
	bh=4HOGczX4n7l0SqUMM3Wxqbi21GrRLlNvACqxYKTFokU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XiC5eZYZe0IvUvxsF4ieW8rsDe9nI4zE7DNvMAmISDgyIWwFqOLSkq4/xhtTDwWwY
	 Zy68dlfQHZba14yFXq/rjua71sAO+e0IlL9LgYWlPNUy2yiSyOoRE6E5D8QQDMq9/y
	 yNuhPekkr7MmoRLrmUJTahd+Dhk0ZSxc6hzny84g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 565/590] mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
Date: Wed,  5 Feb 2025 14:45:20 +0100
Message-ID: <20250205134516.881826226@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit e598d8981fd34470b78a1ae777dbf131b15d5bf2 upstream.

The Fixes commit mentioned this:

> An MPTCP firewall blackhole can be detected if the following SYN
> retransmission after a fallback to "plain" TCP is accepted.

But in fact, this blackhole was detected if any following SYN
retransmissions after a fallback to TCP was accepted.

That's because 'mptcp_subflow_early_fallback()' will set 'request_mptcp'
to 0, and 'mpc_drop' will never be reset to 0 after.

This is an issue, because some not so unusual situations might cause the
kernel to detect a false-positive blackhole, e.g. a client trying to
connect to a server while the network is not ready yet, causing a few
SYN retransmissions, before reaching the end server.

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/ctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -405,9 +405,9 @@ void mptcp_active_detect_blackhole(struc
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
 			subflow->mpc_drop = 1;
 			mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
-		} else {
-			subflow->mpc_drop = 0;
 		}
+	} else if (ssk->sk_state == TCP_SYN_SENT) {
+		subflow->mpc_drop = 0;
 	}
 }
 




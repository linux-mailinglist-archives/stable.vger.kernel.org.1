Return-Path: <stable+bounces-50034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072219013D9
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 00:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6782D2821CB
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 22:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128BEFC19;
	Sat,  8 Jun 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="OG1UyGsY"
X-Original-To: stable@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D632E85A;
	Sat,  8 Jun 2024 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717884138; cv=pass; b=K84daRcY/bwSqC1gEl9oALYvIG3yDyHUA3jcbIbIyjj/QBhk7w4aCAzWTSLkubbdBruTrE9pyfAuBbzvmRx5TQ/9w3kAeRSrIY+Pqrg2se4lmunV1EOMj5hU0VCL5aWvaHS7tU28VbrSBWsNslI+5XoFtV65zuadKcvj5DKPlSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717884138; c=relaxed/simple;
	bh=OYO6fS3hEPlk4kettYB1VkvhuPf9VYvUv/bky0SmkFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5toxsvt5o+1sFL1ihZDRYZlbfd5yv8uKue4BAIaPnZt0qOfpP+BnoMuBAWAD8pstY/6L4fDa+ZD4cATVXSZ/Mb0PI8q1xdsnuC5HUaZG4vVPsTJwpzXAZUfUtzv4dVc3e1TlX+yEqe/YrUwHMomn06il0gB9QoN7fKGapk0VaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=OG1UyGsY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VxX982d0czyNC;
	Sun,  9 Jun 2024 01:02:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1717884126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQwo46XW5qDRWfTw7yYSPgYDh6MEenC0f3oCmhIKWKI=;
	b=OG1UyGsYApKnec+qv7/robFGo+0y+arN8eziZOye2zMcGNCoIXss7bySCSJOKp1x3d9sqG
	kzFflULnNA4Cg9Qhl1o2CcNqqMA13/zvu9XJHl/+XVByFlUgqtfzDMRyD3XhA+B5jeGw/d
	bh+BrZ3eh3dQ6/upsyhICDPsz1w34es=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1717884126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQwo46XW5qDRWfTw7yYSPgYDh6MEenC0f3oCmhIKWKI=;
	b=sLrzaWyWuiIOplHMywyIDgLG+csD8zynkLOwPdEQFhUkwHvWpy2YG7dVi4QLUjU5NxccD2
	Ta2wBuGy9yZ4z+7icrDJUUCHHnAWnZI/WAbMmpTfz3Gw9b57xl8ou11nY6YcPGFF6nAEqi
	QM2rJP5IixceOGvzYmrp3YZdOyOgBC4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1717884126; a=rsa-sha256; cv=none;
	b=xsZXp9dk+70Lg95JXxAptbj9K6bTBiFRi1P8Uirm/ChzRj1Rg/1HD4OafsMDi1YioDh+Xv
	z+hanQgoZpy9rgs2BabPFHqqc6iweszPZ1FBlTanoNDI8SBlAUZ8r7axpPduKrwilgoAK9
	7SLefs1Y1PuPJp5+QSvKCgcBZLbVcoo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	stable@vger.kernel.org,
	luiz.von.dentz@intel.com,
	der.timosch@gmail.com
Subject: [PATCH] Bluetooth: fix connection setup in l2cap_connect
Date: Sun,  9 Jun 2024 00:59:43 +0300
Message-ID: <de9169c3e607696a9430f5beb182c914c136edcf.1717883849.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amp_id argument of l2cap_connect() was removed in
commit 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")

It was always called with amp_id == 0, i.e. AMP_ID_BREDR == 0x00 (ie.
non-AMP controller).  In the above commit, the code path for amp_id != 0
was preserved, although it should have used the amp_id == 0 one.

Restore the previous behavior of the non-AMP code path, to fix problems
with L2CAP connections.

Fixes: 84a4bb6548a2 ("Bluetooth: HCI: Remove HCI_AMP support")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Tried proofreading the commit, and this part seemed suspicious.
    Can you try if this fixes the problem?

 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c49e0d4b3c0d..fc633feb12a1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4016,8 +4016,8 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
-			l2cap_state_change(chan, BT_CONNECT2);
-			result = L2CAP_CR_PEND;
+			l2cap_state_change(chan, BT_CONFIG);
+			result = L2CAP_CR_SUCCESS;
 			status = L2CAP_CS_AUTHEN_PEND;
 		}
 	} else {
-- 
2.45.2



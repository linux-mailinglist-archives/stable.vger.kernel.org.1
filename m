Return-Path: <stable+bounces-70975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B59610F9
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372FA281813
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D3E1C6F49;
	Tue, 27 Aug 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eFSC+d2a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39191C5783;
	Tue, 27 Aug 2024 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771683; cv=none; b=Lt2vXxApWHNrLbE4pYAPMOtoANx+wsTMJexbB3gaectCP8DNHz/T9+ZLLUpoM4MP8muJuTj93Ytz+45/QPwKrsPIzINpKTK6V+ic9mhop6xTDhDTGt5duwCO+CR2t+fKIMYnZ429Z8yDrps7OU4ypkvWccEhI7kcFw32jeb9ElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771683; c=relaxed/simple;
	bh=nI8JFNmIwup8ExgM08EGHpHnBc32bhQS9PHF4pdblII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqdqENn7EwbihfHWYysSNpF9ZQsKqDllDDrluPCUSXmdhZiITBlZaIeAsrRfVErj+0FSn4PM25MFFu6FlWoVPVj92dPhBsT1riI+GpCreVtGX92w5h/xJsVGjY+FRqx7CAS+EZogPBhf/Os1sGcYKDkdg9fS4olFqDPTTCW908Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eFSC+d2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE09C61064;
	Tue, 27 Aug 2024 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771683;
	bh=nI8JFNmIwup8ExgM08EGHpHnBc32bhQS9PHF4pdblII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFSC+d2ajbZXQBhVYlRH5fl450ooCelXYl4cd14zcqlS9vqn834I9QnwJTwabIjdb
	 4xcomSdDylCs/JjevUJ9C2e/FLKspCMl/DgQRHWkbu+dKj08+sCFc1FZpKS9+/b+qs
	 C5YoXuUhBbS2yhfHW7ia8YPBu+Yc1Fs9YtB4gkMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10 261/273] mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
Date: Tue, 27 Aug 2024 16:39:45 +0200
Message-ID: <20240827143843.330267419@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -848,8 +848,8 @@ static void mptcp_pm_nl_rm_addr_or_subfl
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




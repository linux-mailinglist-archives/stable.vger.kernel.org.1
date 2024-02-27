Return-Path: <stable+bounces-25128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4808697DF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AC81C2278C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03B143C46;
	Tue, 27 Feb 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="huP+wPYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE661420DA;
	Tue, 27 Feb 2024 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043942; cv=none; b=bSESAd9KDIqNNodqSS+d+fXqKftT/1UAn8Jl88FcaRxXopXZVvr2Ipz5RcEus9mQBWtlD6tdbq7HUwVab+erqq7oZXE8vJ77KIdmWMfm5XN6MM5+FIFfk1WqEnhcBXTf0Gv7zW3znHjlqC27qhd8FVeppSaLbWl02ThIfQ2lV24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043942; c=relaxed/simple;
	bh=l1tt1bNB6Dm4JawhedatBCFQ24sk4hSgH1/PIDOsW+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/pkX7H7t1tgnmv/c4nS8nRconmsMXs51/a0/W1BTQTGMKcPulhgO7RsaCOodWvtJaQoEJd4c+IJUeOGIo7q9jSm8DZc0Yguy66TTPbXteL/g34g5eYWKhHs5VsShQvIL36gLod9ZdNsaWtx7Wc3EzHYGgqMnfA+6YFaQc6RXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=huP+wPYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1897FC433C7;
	Tue, 27 Feb 2024 14:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043942;
	bh=l1tt1bNB6Dm4JawhedatBCFQ24sk4hSgH1/PIDOsW+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huP+wPYdNXzx0dGNixUOlnARv2XZ5moKykVGIIlICcSlEnKexWfYI7+aLcRCoyyCE
	 7LOfaTNaqBR9xebTAn2xjknnsXGeoinivu7H+2NznafDJEXTwVTaannI89iBxDVokH
	 jDekYmKa7BNXmMqkB96g3nW7gWMeGSo+sbQdDaO0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 78/84] tls: rx: drop pointless else after goto
Date: Tue, 27 Feb 2024 14:27:45 +0100
Message-ID: <20240227131555.409714424@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit d5123edd10cf9d324fcb88e276bdc7375f3c5321 ]

Pointless else branch after goto makes the code harder to refactor
down the line.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: fdfbaec5923d ("tls: stop recv() if initial process_rx_list gave us non-DATA")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 606a51237c50f..fb7428f222a8f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1777,10 +1777,9 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (err < 0) {
 		tls_err_abort(sk, err);
 		goto end;
-	} else {
-		copied = err;
 	}
 
+	copied = err;
 	if (len <= copied)
 		goto end;
 
-- 
2.43.0





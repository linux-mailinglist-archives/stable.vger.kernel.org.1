Return-Path: <stable+bounces-117463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA2A3B689
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FBA3BC6B1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9671EB5F4;
	Wed, 19 Feb 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cF9eG4Nh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FF1EDA3A;
	Wed, 19 Feb 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955369; cv=none; b=S1HLXM1Vg82ewOdZYB5j2W1hwBS2GMKBKW75P+adJSQok6ZerAr49QvEZOQh43UFSpFiH9MVMxTAnyWlnZkxL/70YKvSruKtwo7+Uz0cnzXMXy9GxhUuXqrpcqOzR0l5vR4Y+5W0+S9J0vOA1wyIcmrJbWZv+myzNXyhKEj/XU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955369; c=relaxed/simple;
	bh=fA5TmwjS/3vwO9Tgxt8S7nPWcJEb4dOfor+l7hvgMA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czWSQRxAJ9ecjRjMVPzq/3YEYOcQL2VoIQmyN1vl812vYHmxgmldSq3eKbZ9+xrUG5O5vQUm9EqdPERsE8fazmzuolpyeruAHUHLnb8ltzfcPC1ntdvUWxX7b4JjJnpkQxSHfY4kU+CTrtOAj/IDSuxxzmztH09ZgmC3/HR8TBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cF9eG4Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8DCC4CED1;
	Wed, 19 Feb 2025 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955369;
	bh=fA5TmwjS/3vwO9Tgxt8S7nPWcJEb4dOfor+l7hvgMA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cF9eG4NhuYdRxY7WfjSjsoyeawLiDfuMkXX9BNgH13WPGU3k+uBKgO3oWTiF3EOGp
	 t81GYLTNxegcNrJ33PZI96yiUhs8iRlPMMjpsl9K70C2Bn1f0QV3t/mZLD96rFh/lY
	 EvYaHPTjyu+KgzivIrlyYGIZ2kM2hWB+Car3CUVU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12 215/230] netdevsim: print human readable IP address
Date: Wed, 19 Feb 2025 09:28:52 +0100
Message-ID: <20250219082610.105892200@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
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

From: Hangbin Liu <liuhangbin@gmail.com>

commit c71bc6da6198a6d88df86094f1052bb581951d65 upstream.

Currently, IPSec addresses are printed in hexadecimal format, which is
not user-friendly. e.g.

  # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
  SA count=2 tx=20
  sa[0] rx ipaddr=0x00000000 00000000 00000000 0100a8c0
  sa[0]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
  sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
  sa[1] tx ipaddr=0x00000000 00000000 00000000 00000000
  sa[1]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
  sa[1]    key=0x3167608a ca4f1397 43565909 941fa627

This patch updates the code to print the IPSec address in a human-readable
format for easier debug. e.g.

 # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
 SA count=4 tx=40
 sa[0] tx ipaddr=0.0.0.0
 sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[1] rx ipaddr=192.168.0.1
 sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[2] tx ipaddr=::
 sa[2]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
 sa[2]    key=0x3167608a ca4f1397 43565909 941fa627
 sa[3] rx ipaddr=2000::1
 sa[3]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
 sa[3]    key=0x3167608a ca4f1397 43565909 941fa627

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20241010040027.21440-2-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/netdevsim/ipsec.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -39,10 +39,14 @@ static ssize_t nsim_dbg_netdev_ops_read(
 		if (!sap->used)
 			continue;
 
-		p += scnprintf(p, bufsize - (p - buf),
-			       "sa[%i] %cx ipaddr=0x%08x %08x %08x %08x\n",
-			       i, (sap->rx ? 'r' : 't'), sap->ipaddr[0],
-			       sap->ipaddr[1], sap->ipaddr[2], sap->ipaddr[3]);
+		if (sap->xs->props.family == AF_INET6)
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI6c\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr);
+		else
+			p += scnprintf(p, bufsize - (p - buf),
+				       "sa[%i] %cx ipaddr=%pI4\n",
+				       i, (sap->rx ? 'r' : 't'), &sap->ipaddr[3]);
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    spi=0x%08x proto=0x%x salt=0x%08x crypt=%d\n",
 			       i, be32_to_cpu(sap->xs->id.spi),




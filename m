Return-Path: <stable+bounces-134485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C48A92B63
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20B03B8224
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DA25A640;
	Thu, 17 Apr 2025 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JMQ+7p3D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0725742B;
	Thu, 17 Apr 2025 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916267; cv=none; b=T5vUCx7Z1qs2ZSlAPyxmlA0tvMgZqHmGqVr3TEwErb+fcM4rSBWJkM7kAZbQFw6Iclze9JzRm49cUvegsgWSkfhxudKo4F+ICE57+KwM5/d46dB6hyeziDSAQjaqzdUw2iCxzRQ8MjyAYBX/XdkOFZrv3NPtIFnx4G9LKy7nDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916267; c=relaxed/simple;
	bh=sXGDHxFHLeBKnp0TZ0m0cAV57ZdmbpIp1uy0A31ftgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnOnjWeAeRQvUIMAFwz+HQOD8E9UvfpH1HfczlghdpPfUuHhSL8w9BmFR/xjdV3kP5ChtCJEqHYlNximhc+enE9DveDYIH043iAhWCzKO7dVmvMeBBQ816/m+VaPDv31UvN+lnqMbYfdLRie3pUOPsXyfyTE4BbDBqjn2URMZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JMQ+7p3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F204DC4CEE4;
	Thu, 17 Apr 2025 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916267;
	bh=sXGDHxFHLeBKnp0TZ0m0cAV57ZdmbpIp1uy0A31ftgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMQ+7p3DZhuW6j1SGlvOdAB+AA263DWeFPbwU3PYB8wVaVTZyEX+3PeJGIq5ufZd9
	 Qkh+OoWHpI/+wehMssbV4m9rxTzno17SetSAc8uZxvpsJgf5RCEhIQ5S4mpaMhZkf7
	 QyQeyx1UI2aEIE9MWrm9N1kI6+QwZ/hO9NEMSxjg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.12 385/393] NFSD: fix decoding in nfs4_xdr_dec_cb_getattr
Date: Thu, 17 Apr 2025 19:53:14 +0200
Message-ID: <20250417175123.096196131@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

From: Olga Kornievskaia <okorniev@redhat.com>

commit 1b3e26a5ccbfc2f85bda1930cc278e313165e353 upstream.

If a client were to send an error to a CB_GETATTR call, the code
erronously continues to try decode past the error code. It ends
up returning BAD_XDR error to the rpc layer and then in turn
trigger a WARN_ONCE in nfsd4_cb_done() function.

Fixes: 6487a13b5c6b ("NFSD: add support for CB_GETATTR callback")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4callback.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -605,7 +605,7 @@ static int nfs4_xdr_dec_cb_getattr(struc
 		return status;
 
 	status = decode_cb_op_status(xdr, OP_CB_GETATTR, &cb->cb_status);
-	if (status)
+	if (unlikely(status || cb->cb_seq_status))
 		return status;
 	if (xdr_stream_decode_uint32_array(xdr, bitmap, 3) < 0)
 		return -NFSERR_BAD_XDR;




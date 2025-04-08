Return-Path: <stable+bounces-131747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C629A80BA7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FE9505C9C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6B278F49;
	Tue,  8 Apr 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pjDC7KpX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E08836;
	Tue,  8 Apr 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117224; cv=none; b=eTSh3biMLU3/QG4OLKQ5bSaZnKmP2xDEN7ATHF90m3biGR8J1IwnTlCwCyiEvESiPh2N2TKykoafvOTy21gcqKXYFok152ladVddnJzUkF1tycDqwETdd3MLVL1nxnYaowXbjX6aQXG7/GUCNn+J8jLmW5/FzfwkpoAMpMzLWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117224; c=relaxed/simple;
	bh=FuQmSCGltt75TeCxPrqeHSvOFXRfcdSONWQ4BQbbzrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T11h7pN6T1gV9laNt3RQOeEbRJ4R1GdgnvnOPAP/lO5mR64zepkG2lQZJf20vyiQAQAHLTuZv8NNwZreBYgMjStbnDUoshu4Z/lHz8U2hYps+RtCi9TBQRy/JcvZCcGzpooZvwf/CAYEkH9SRSBn3+MCzcCwmsxgl/Tu+POGxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pjDC7KpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05617C4CEE5;
	Tue,  8 Apr 2025 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744117224;
	bh=FuQmSCGltt75TeCxPrqeHSvOFXRfcdSONWQ4BQbbzrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pjDC7KpXK5nm74kCUbwaAwxbmW71/IBr+foV6CxiRHoSfBSkmlMlziRh+dhi+P6w7
	 htPUXLzdyRo2SfpqYiWjRBjh1llKAqLsMaTbVKsDSIfTuadbsVlo4X19DP0DWXX/xH
	 rJiOPUg65OmQ4Hghf/3gSxkGs9iWg0Y1LO7kTTmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.12 395/423] ksmbd: add bounds check for create lease context
Date: Tue,  8 Apr 2025 12:52:01 +0200
Message-ID: <20250408104855.097466303@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

From: Norbert Szetei <norbert@doyensec.com>

commit bab703ed8472aa9d109c5f8c1863921533363dae upstream.

Add missing bounds check for create lease context.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/oplock.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1505,6 +1505,10 @@ struct lease_ctx_info *parse_lease_state
 	if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
+		if (le16_to_cpu(cc->DataOffset) + le32_to_cpu(cc->DataLength) <
+		    sizeof(struct create_lease_v2) - 4)
+			return NULL;
+
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
@@ -1517,6 +1521,10 @@ struct lease_ctx_info *parse_lease_state
 	} else {
 		struct create_lease *lc = (struct create_lease *)cc;
 
+		if (le16_to_cpu(cc->DataOffset) + le32_to_cpu(cc->DataLength) <
+		    sizeof(struct create_lease))
+			return NULL;
+
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;




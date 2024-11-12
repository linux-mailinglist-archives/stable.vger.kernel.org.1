Return-Path: <stable+bounces-92467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C299C55C1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC3BB37BAC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710E2123D9;
	Tue, 12 Nov 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XRS1II59"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE751EE02B;
	Tue, 12 Nov 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407754; cv=none; b=ThDu5htlwaChxqeoJCa+GYRQLGuLEPiiaEcyJPWwhp0k1E72J5S4tJJb8/5G2TjDBBeLEng/e+euBwk+ZJBDWxFPNo51imqG2W8ALS6XSL/oW5WlcM+oi3Gv2yDG+ldXR51R6/rmxjdcVy6W8fllc/pDy5GBtvXFZq4KpFVIB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407754; c=relaxed/simple;
	bh=aeySF/2whujQQ56XLxhqU6zijNuT1nDoJhfSSykRglU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhluTHixzKfe8Mcy21hzV9YHbr6YBcJBZl30/1+KPc2ldCec0v3P+nu4wz1YFaSmi94Mhgaq/1Li/C9Ja5G4uKioBvSAxq+YTULUHftMRHX2q/W0IM+syGUwjU9/bcGxziKzPMexGxLVscnQTFapTUDjIs9ccOTLr4alWbDq+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XRS1II59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09944C4CED6;
	Tue, 12 Nov 2024 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407754;
	bh=aeySF/2whujQQ56XLxhqU6zijNuT1nDoJhfSSykRglU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRS1II59S69+XDW38vr3iJ14XMJzH8pchJdYFzu5IcGo/WLRA1eQosOeb5A5vVVbz
	 WAGj/OdQvdA/4vdMroZT9+nR5DSBvqAfk8P3zclKe3zUFy54kuW3gBWR+gHW1J/PQf
	 VyWFaUuzHMRsSJeI/ffu0ZgmUgIcJPYZr7D/XPLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 073/119] ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp
Date: Tue, 12 Nov 2024 11:21:21 +0100
Message-ID: <20241112101851.506678100@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit b8fc56fbca7482c1e5c0e3351c6ae78982e25ada upstream.

ksmbd_user_session_put should be called under smb3_preauth_hash_rsp().
It will avoid freeing session before calling smb3_preauth_hash_rsp().

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/server.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -238,11 +238,11 @@ static void __handle_ksmbd_work(struct k
 	} while (is_chained == true);
 
 send:
-	if (work->sess)
-		ksmbd_user_session_put(work->sess);
 	if (work->tcon)
 		ksmbd_tree_connect_put(work->tcon);
 	smb3_preauth_hash_rsp(work);
+	if (work->sess)
+		ksmbd_user_session_put(work->sess);
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
 		rc = conn->ops->encrypt_resp(work);




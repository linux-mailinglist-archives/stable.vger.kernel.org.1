Return-Path: <stable+bounces-199764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E17CA0A69
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29473331EFCD
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB79346772;
	Wed,  3 Dec 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JcyOJwZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8E3446D3;
	Wed,  3 Dec 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780859; cv=none; b=VGouICW+7kWz/SoG305tTV4u3PTmxRlfQcADDPn/6CPPf3AMStZy8VYX3IYGBPhaNujh6jp5Odr66s3Hwb8pkBWqZJVcTVfIhbaYzwA52R74uGU7CMquKsqUIHE0oF93xbGoD74rU2BdYa1gifyIFRIP0qbSbGYbQAHy8yAHA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780859; c=relaxed/simple;
	bh=Lvnsqi9WV1tgqUMi52I3VNB0I+ejlRAtLseH6FV9fcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXTLcmHgqYORB56jszLosaNw6Kt80IHhPpTCVeWHzQVGDdLIdgFS2D6AwElQxO+6Xa+qn71MXh3tc13JJ2h4DWYhOLLwBAHOMNnrhxfUGnA/751Il7Ld4FCsFQukuGFkO0sXgdhLvDFGLoEYpyOO7QFZYXtXDTd1RmhFS1xmAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JcyOJwZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D959FC4CEF5;
	Wed,  3 Dec 2025 16:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780859;
	bh=Lvnsqi9WV1tgqUMi52I3VNB0I+ejlRAtLseH6FV9fcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcyOJwZJMBDZgNO61vrFVOzI2P6+f2V1WrmyfR2jrzPcZTtBzP1z6Wqyz8GOvhYbz
	 q2+5X/+IOlz0kospr5/8QBxyqri0qW5lYpNsSLufKHspc5xrmeFqAAMdFLkShEG8/6
	 qWM9oZe6d1dEHQKDa/LF8IkfJzEBQiQt7BeRNYZo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ziming zhang <ezrakiez@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.12 112/132] libceph: prevent potential out-of-bounds writes in handle_auth_session_key()
Date: Wed,  3 Dec 2025 16:29:51 +0100
Message-ID: <20251203152347.431007153@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
References: <20251203152343.285859633@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: ziming zhang <ezrakiez@gmail.com>

commit 7fce830ecd0a0256590ee37eb65a39cbad3d64fc upstream.

The len field originates from untrusted network packets. Boundary
checks have been added to prevent potential out-of-bounds writes when
decrypting the connection secret or processing service tickets.

[ idryomov: changelog ]

Cc: stable@vger.kernel.org
Signed-off-by: ziming zhang <ezrakiez@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/auth_x.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -631,6 +631,7 @@ static int handle_auth_session_key(struc
 
 	/* connection secret */
 	ceph_decode_32_safe(p, end, len, e_inval);
+	ceph_decode_need(p, end, len, e_inval);
 	dout("%s connection secret blob len %d\n", __func__, len);
 	if (len > 0) {
 		dp = *p + ceph_x_encrypt_offset();
@@ -648,6 +649,7 @@ static int handle_auth_session_key(struc
 
 	/* service tickets */
 	ceph_decode_32_safe(p, end, len, e_inval);
+	ceph_decode_need(p, end, len, e_inval);
 	dout("%s service tickets blob len %d\n", __func__, len);
 	if (len > 0) {
 		ret = ceph_x_proc_ticket_reply(ac, &th->session_key,




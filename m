Return-Path: <stable+bounces-26260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D472A870DC7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED85B277A3
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2C4086B;
	Mon,  4 Mar 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjFcq4eL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1648F58;
	Mon,  4 Mar 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588258; cv=none; b=E+GHM07bPcSsqn4GgqMW9w+tSB360lTLgErwvGY4M3z6Jco5yssM6E0G90n44bFGkxjobLa5Z3a4GSUUrV2qsCYTEwZlXr5n/R2pWOfKrUzMxWY8NRG8uTaCyQ1w6Mh7/YkmsOD7LZq+jPW2Ptz93eZUrpB1e1R9oX8scyMU9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588258; c=relaxed/simple;
	bh=j6cydAnt5PSfskAhFD6kfRiyPxLMFCFprYF6gMP0DtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDnSUDgIoSqx6jnaKXFNIWfK0/Nz8fNyrtS0b96XGNWI0WlS9SpTpyL94Hdqbg7LX6WAwYYShK0EfXfSygo87TqZcIh171ey+9Qc9P2I29R6A5vE5xB8UIS44i62Qs2eJU29OW+OhGKMmhaqoY6rozDlbnUq0Jb7rhdXB8NJGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjFcq4eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1592C433F1;
	Mon,  4 Mar 2024 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588258;
	bh=j6cydAnt5PSfskAhFD6kfRiyPxLMFCFprYF6gMP0DtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjFcq4eL3SxqQj7k5twWQ5Aj/8Wtqx4ITj0brh2z11k8gLjywBRZkDmZ0sYvXUpmf
	 Ep8XcqnU2QvBwLDl0z2y2p5ICSg34B4mXpyWhlVurIOgMh8L1ar7y8ZTahzSIllOUB
	 KGgX+3YlukVPNzuUyqX6l9jWnw05c/lmHWkPtH6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Iurman <justin.iurman@uliege.be>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/143] uapi: in6: replace temporary label with rfc9486
Date: Mon,  4 Mar 2024 21:22:21 +0000
Message-ID: <20240304211550.618059392@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

From: Justin Iurman <justin.iurman@uliege.be>

[ Upstream commit 6a2008641920a9c6fe1abbeb9acbec463215d505 ]

Not really a fix per se, but IPV6_TLV_IOAM is still tagged as "TEMPORARY
IANA allocation for IOAM", while RFC 9486 is available for some time
now. Just update the reference.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240226124921.9097-1-justin.iurman@uliege.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/in6.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index c4c53a9ab9595..ff8d21f9e95b7 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -145,7 +145,7 @@ struct in6_flowlabel_req {
 #define IPV6_TLV_PADN		1
 #define IPV6_TLV_ROUTERALERT	5
 #define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* TEMPORARY IANA allocation for IOAM */
+#define IPV6_TLV_IOAM		49	/* RFC 9486 */
 #define IPV6_TLV_JUMBO		194
 #define IPV6_TLV_HAO		201	/* home address option */
 
-- 
2.43.0





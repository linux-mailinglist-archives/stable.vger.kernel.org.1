Return-Path: <stable+bounces-120617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796BA5077D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD99C18936E8
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603D250C1C;
	Wed,  5 Mar 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNp+QTGg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699F24C07D;
	Wed,  5 Mar 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197479; cv=none; b=CWqgbJsip+JNzWPaFU4Xvci0Cge+vO21q/cXH9j6K1M4T1g52TTQLPk1uvS2Kul9t57VT1run65EABAlJrj3zqe+/QCLGmY2K/Yq4pFAr8gXh8wmLCzEF82dxS+3vMgrSFAcLSUO43qNI0jWmuSrjt+D8hwPbIXCH5zNzk5fu/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197479; c=relaxed/simple;
	bh=PJ8oYJwDIiPGSbBSyjmubeKX6qE9mvXsgWwo59SVL80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pG9qIMZe4gsWIMpg2+Mse6fdmjuFi4uQdn+j/tN+y3IdmS2TngeV/CtiLl1/oebDhGyhozXRP9qBRGh/hDZ5IIXIgH9KB8+q8zWjbWIMTyEXl86WvPuIWmT+MK814eT1FAxRgmB5G8ZUHn2AFpxD4LGMx7tfj6dB/fhU7nDHI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNp+QTGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4484C4CED1;
	Wed,  5 Mar 2025 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197479;
	bh=PJ8oYJwDIiPGSbBSyjmubeKX6qE9mvXsgWwo59SVL80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xNp+QTGgGl5PhD7yyxQ7Q1dri18SpYd3KWD9GhtkAFQEeXKIREoXb10O4ohsjGLrE
	 cxNJfrSAXYbaE01XUfoEpJixuLBkjw9+ck63w270rurEXtdSkvVsRPFDS0G5DYLHgV
	 cNiAKOHv8G4+3pnpjl0XlWEFqKgSm4Wlq3bNQCQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Iurman <justin.iurman@uliege.be>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 138/176] include: net: add static inline dst_dev_overhead() to dst.h
Date: Wed,  5 Mar 2025 18:48:27 +0100
Message-ID: <20250305174510.984699536@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Iurman <justin.iurman@uliege.be>

[ Upstream commit 0600cf40e9b36fe17f9c9f04d4f9cef249eaa5e7 ]

Add static inline dst_dev_overhead() function to include/net/dst.h. This
helper function is used by ioam6_iptunnel, rpl_iptunnel and
seg6_iptunnel to get the dev's overhead based on a cache entry
(dst_entry). If the cache is empty, the default and generic value
skb->mac_len is returned. Otherwise, LL_RESERVED_SPACE() over dst's dev
is returned.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: c64a0727f9b1 ("net: ipv6: fix dst ref loop on input in seg6 lwt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/dst.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/dst.h b/include/net/dst.h
index d67fda89cd0fa..3a1a6f94a8092 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -434,6 +434,15 @@ static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 		dst->expires = expires;
 }
 
+static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
+					    struct sk_buff *skb)
+{
+	if (likely(dst))
+		return LL_RESERVED_SPACE(dst->dev);
+
+	return skb->mac_len;
+}
+
 INDIRECT_CALLABLE_DECLARE(int ip6_output(struct net *, struct sock *,
 					 struct sk_buff *));
 INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
-- 
2.39.5





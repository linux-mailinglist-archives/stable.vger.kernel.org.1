Return-Path: <stable+bounces-68683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE195337A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DA71C23E4A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F9619EED7;
	Thu, 15 Aug 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Drp966zg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221001AC44F;
	Thu, 15 Aug 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731338; cv=none; b=lSXF1gQU+Ct2Q3jd5p7ZVc4i21oU61TPMaFOfBJYFSQHRy/26cHcqdZoVBoVXLp657Lm1leoHpW38Jx3+tuBATv/CrVh3fc0NFIb7gMt6qCm74dX6g1ee9GQziWiT1DMpmSyMkh6E51kcS6UjZCF2mwFoZM9a0EjjY85okpCvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731338; c=relaxed/simple;
	bh=f82BVEn0+qe8czBxLolKoptMTVhkp9smwM2guZfOhsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4WfY9b84CuyxmpdhnQlHFjMqiTU2lgN0+Qjx3cu9MyC/JYU9lxv5WDNcOxcJx54QA3SNl6oTfnJWZoQpx30PvB+oyfDOV3x7ZCCsgAy9M45IJyuBQra86jW/RmEqR+W7Mufa9KxFA963JQOzJpx7fyO9kHyrSazSTju09B3Fm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Drp966zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BC3C32786;
	Thu, 15 Aug 2024 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731338;
	bh=f82BVEn0+qe8czBxLolKoptMTVhkp9smwM2guZfOhsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Drp966zgUlH1QhbZID6q1A4CaKD+AWLcRvjvVUTvKJuokdapRs4Yvxg6sO/xEGNwn
	 nF7QOg5SDqJyTgvMzKf0lnrUcupKff6Qps+9IeRPZ9rpcGgF0GANIy2smYOrn9BZhO
	 3flxZoRuG+2v1pOwlUCCnexQNdc2JrdtzFpaQMR4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Coddington <bcodding@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/259] SUNRPC: Fixup gss_status tracepoint error output
Date: Thu, 15 Aug 2024 15:23:19 +0200
Message-ID: <20240815131905.354065533@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit b9fae9f06d84ffab0f3f9118f3a96bbcdc528bf6 ]

The GSS routine errors are values, not flags.

Fixes: 0c77668ddb4e ("SUNRPC: Introduce trace points in rpc_auth_gss.ko")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/rpcgss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index d1f7fe1b6fe44..23e8288a76b5c 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -42,7 +42,7 @@ TRACE_DEFINE_ENUM(GSS_S_UNSEQ_TOKEN);
 TRACE_DEFINE_ENUM(GSS_S_GAP_TOKEN);
 
 #define show_gss_status(x)						\
-	__print_flags(x, "|",						\
+	__print_symbolic(x, 						\
 		{ GSS_S_BAD_MECH, "GSS_S_BAD_MECH" },			\
 		{ GSS_S_BAD_NAME, "GSS_S_BAD_NAME" },			\
 		{ GSS_S_BAD_NAMETYPE, "GSS_S_BAD_NAMETYPE" },		\
-- 
2.43.0





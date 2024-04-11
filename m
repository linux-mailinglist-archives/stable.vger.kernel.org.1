Return-Path: <stable+bounces-38244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF4F8A0DAC
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18E91F21FFA
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55CC145B26;
	Thu, 11 Apr 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PT81p3B5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C851448F3;
	Thu, 11 Apr 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829986; cv=none; b=XTTAi+yCoYylyDswnK7DiMrItTCdcv4jhEOOh5SzpT2b/SNiKO+f/K2JM4tEB3NuRjjBTlohXVB2qUQZ68JrXPd+b4pr1cV+Kg5Vlvuj9aWGTQ1pD4SIJdQptaNXUeVxY1/8dRfwKcg5lNAlLTWaxc/OPareIF0huIym72cv37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829986; c=relaxed/simple;
	bh=yrDwsMOhSQapn/ZO2tFtCLG+8jE842uT/Fe6rQxUTIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpBX2ausBIxTrVDCQRPdAWIyaWy3kJQOmhnuzWrVPmvHTldcBwZD7fkCDcYV1eFh2Tt065iPZ/ZktKRxnmZAMz4OL9roSWtG/21YISqjdSh8ms8dNPzfa5HRkEdFI3ZE6wlGX5qwA90z1PDay4/X2v0mjeWoLSrVXXr/i8tgHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PT81p3B5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107A6C433F1;
	Thu, 11 Apr 2024 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712829986;
	bh=yrDwsMOhSQapn/ZO2tFtCLG+8jE842uT/Fe6rQxUTIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PT81p3B5upkfAgWy4RTKUwzrTBApJ0yIR0Tu3vZAZu1RABJvnHxfb3FJVxyOslnUI
	 siB+RLWtQIYbzw8WZk+0F+4p0R+8QxE2vz4p/F4RtCQy6/HRXkCEQWTS0cBw9sy+I/
	 D+8U5Fov4ei0ALXvhroO6slL7XdoWAPN7JU2hIzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <eric.dumazet@gmail.com>,
	William Tu <u9012063@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 173/175] erspan: Check IFLA_GRE_ERSPAN_VER is set.
Date: Thu, 11 Apr 2024 11:56:36 +0200
Message-ID: <20240411095424.771608977@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Tu <u9012063@gmail.com>

commit 51fa960d3b5163b1af22efdebcabfccc5d615ad6 upstream.

Add a check to make sure the IFLA_GRE_ERSPAN_VER is provided by users.

Fixes: f989d546a2d5 ("erspan: Add type I version 0 support.")
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: William Tu <u9012063@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1182,7 +1182,8 @@ static int erspan_validate(struct nlattr
 	if (ret)
 		return ret;
 
-	if (nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0)
+	if (data[IFLA_GRE_ERSPAN_VER] &&
+	    nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0)
 		return 0;
 
 	/* ERSPAN type II/III should only have GRE sequence and key flag */




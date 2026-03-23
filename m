Return-Path: <stable+bounces-229954-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDwLLaJ2wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229954-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:21:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9C2F9C73
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FCEA35CE5BA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D33C063A;
	Mon, 23 Mar 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AjctWLe2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF53BC689;
	Mon, 23 Mar 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283356; cv=none; b=pmbA9BG8aQ/44tU2QTyPNfvv7D2yr/BqrhpwP9lh0atojIdyxBo94KAuwjNxD22fpeH2AjNl35t1VhYmKwxgd69KAEWkxvtiKzEOTJozsNBbBxu5BEoaKyv0wvsTNVRrZPQCcW2Q3JR1dRdj5EyQDsjFtKGOqJ+7+rygY7wWbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283356; c=relaxed/simple;
	bh=P+SkuWoVxOAEKTEJBsOvAxjlP9tX0sfXEsKS3CURtQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajTd6aAFRbArrZuZ1LBYTw/dcgUYRLm0VIm6Vxirr23cpwOITwgj+E0VeZCqWbNVfilWRo3yY1AQa+7ynw1e1NBV51cWMQSIU1gkQzCEJh4J5OTaHkBY2HOMCCv6arQ/ilZSSx7uDQVqt7vEYbVrSqidaMPYC4faZg2BHw1wcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AjctWLe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB0EC4CEF7;
	Mon, 23 Mar 2026 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283355;
	bh=P+SkuWoVxOAEKTEJBsOvAxjlP9tX0sfXEsKS3CURtQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjctWLe2LkVXdLR/VeCLKbyZ9IUC22BHlDvbjkMLEgSEyTdP7Byl2i8MX0UzBlcP6
	 lXq/UFJ1/fJvPzq8eGOaMfS7TTM8zrMPuGzCptR6OO3ZJVAAyJGdMlWkbqv8cBw6S8
	 4w7eZukmiZ/R110OvwTJ/NPSPdmlfoKfilA0yhPc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Gao <zcgao@amazon.com>,
	Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH 6.1 481/481] Revert "selftests: net: amt: wait longer for connection before sending packets"
Date: Mon, 23 Mar 2026 14:47:43 +0100
Message-ID: <20260323134536.953014085@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229954-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amazon.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0DB9C2F9C73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Gao <zcgao@amazon.com>

This reverts commit 7724036d4804222007689cd69f248347eb154793 which is
commit 04708606fd7bdc34b69089a4ff848ff36d7088f9 upstream.

The reverted patch introduced dependency on lib.sh under net selftests.
The file was introduced in v6.8-rc1 via commit 25ae948b4478
("selftests/net: add lib.sh").

Without lib.sh, the amt test fails with:
./amt.sh: line 76: source: lib.sh: file not found

The whole history of lib.sh includes about 50 commits and considering
the file never landed on 6.1 it may be better to not introduce it.

Signed-off-by: Nathan Gao <zcgao@amazon.com>
Acked-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/amt.sh |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -73,8 +73,6 @@
 #       +------------------------+
 #==============================================================================
 
-source lib.sh
-
 readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
@@ -242,15 +240,14 @@ test_ipv6_forward()
 
 send_mcast4()
 {
-	sleep 5
-	wait_local_port_listen ${LISTENER} 4000 udp
+	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
 
 send_mcast6()
 {
-	wait_local_port_listen ${LISTENER} 6000 udp
+	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
 		'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
 }




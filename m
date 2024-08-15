Return-Path: <stable+bounces-68841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19799953440
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72B11F291E0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02C1A76A7;
	Thu, 15 Aug 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQtEv4c3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A43214;
	Thu, 15 Aug 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731832; cv=none; b=ZTsOZ8+Q846mwsfe9RZfeCjxZVfLERtBCaJKqi8n6f3o4LimiiD8kH+lR/vxxk6ViEk34JQz7D187ZVPfNIvDuRjDts1RIdMxL3cz0nvHS6n13kKIrmtu52FDqm6zIA3qQ82t/7pLhMfhlbkAPoXBqRg5PxxVMARPKURElMUXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731832; c=relaxed/simple;
	bh=v/I9aFmL/vPUrtLGL/L5xd7HQWz3r3ARkk4MZpnAyjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eklZAcGEvGzpUHqMmkhPiQKTe+jYrq6gOyWAh1VGMWFuCWJUO/gkfYJEvK1xFKVbuTF+6aVidqNsLuh/xkv7CINzn70P8yZLX+CnzO+OqTllr4JM2j1doPTBbFjGRTBVCZ07KDEiS21o+gFa9s8hB0NpAupEkIoV/Ja/oJQuJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQtEv4c3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122C3C32786;
	Thu, 15 Aug 2024 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731831;
	bh=v/I9aFmL/vPUrtLGL/L5xd7HQWz3r3ARkk4MZpnAyjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQtEv4c3d4mYb6TrIDk1qHCzaBnXG+VUUC+evFc9AvHs/ZpFHfWggLSJgFA8q3OCj
	 971AH7v2eNgUHJLbTom1XTCDaEySUtqNyuMAzXSDTzXgf7BHG6B4xQxdo0ZPWycpuP
	 JwRErXopnCjBiqY/2H9ihWPvOV0NmDT7cpDsbLTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 251/259] netfilter: nf_tables: set element extended ACK reporting support
Date: Thu, 15 Aug 2024 15:26:24 +0200
Message-ID: <20240815131912.463897394@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit b53c116642502b0c85ecef78bff4f826a7dd4145 upstream.

Report the element that causes problems via netlink extended ACK for set
element commands.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4670,8 +4670,10 @@ static int nf_tables_getsetelem(struct n
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 
 	return err;
@@ -5063,8 +5065,10 @@ static int nf_tables_newsetelem(struct n
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_add_set_elem(&ctx, set, attr, nlh->nlmsg_flags);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			return err;
+		}
 	}
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
@@ -5264,9 +5268,10 @@ static int nf_tables_delsetelem(struct n
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_del_setelem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
-
+		}
 		set->ndeact++;
 	}
 	return err;




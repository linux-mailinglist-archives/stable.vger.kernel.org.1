Return-Path: <stable+bounces-135401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA8A98E1C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6904C1B81E57
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C5280A5F;
	Wed, 23 Apr 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uUWu+1d+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D127FD7A;
	Wed, 23 Apr 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419827; cv=none; b=jg3TMdjRS46KcJ48w7H6ErbR68oqkplWEYqmSr0pHzXlzV8RjPwpCUMCCkWLxNxd8EFmFdOK8uZK7VrQfJY4wYftKvv8hHlmGRDe7N6u3cDx5QE8RAmcymiJcWh/Y52uGFPsXREmKs6r761GgN/pkRJMOHNa3dZiKC21CgTwNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419827; c=relaxed/simple;
	bh=oWa4vu39wJpmQTMskEITDtkBgroq5P+Qlv4QjbN7XL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjtF812BASkCvz5VTDtaSpFyiBe1X9UGwPzqA4+wgKeYCiZfU8qjDKSEHyxvpgtSX6YEMao6lqFlJ/q1BpXqTP7T+Kh43Duz+QWrLgrOsbd5sbUPaDK5ntFHoziqbNsOGgf0azcpMQroFZV2ZOwWIGhjxy3BORj6unIW7wxZtYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uUWu+1d+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2D9C4CEE2;
	Wed, 23 Apr 2025 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419826;
	bh=oWa4vu39wJpmQTMskEITDtkBgroq5P+Qlv4QjbN7XL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUWu+1d+YrqLggVsFE61ga8aSJ1LYxA14LCkmMc6T9SKsMWyArwmSh9ZTonaLI9Ki
	 APNIAjhCbNwOJfV2ya0ucf8bMeauBp8sbZi4xkri2PMsIhKN/XpCEU8JXpQV26IJiN
	 XbSmQRfmsUwUWAf6DJXrxVaVSLAdMp1VGuDenNzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 046/223] netlink: specs: ovs_vport: align with C codegen capabilities
Date: Wed, 23 Apr 2025 16:41:58 +0200
Message-ID: <20250423142619.009771107@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 747fb8413aaa36e4c988d45c4fe20d4c2b0778cd ]

We started generating C code for OvS a while back, but actually
C codegen only supports fixed headers specified at the family
level right now (schema also allows specifying them per op).
ovs_flow and ovs_datapath already specify the fixed header
at the family level but ovs_vport does it per op.
Move the property, all ops use the same header.

This ensures YNL C sees the correct hdr_len:

   const struct ynl_family ynl_ovs_vport_family =  {
          .name           = "ovs_vport",
  -       .hdr_len        = sizeof(struct genlmsghdr),
  +       .hdr_len        = sizeof(struct genlmsghdr) + sizeof(struct ovs_header),
   };

Fixes: 7c59c9c8f202 ("tools: ynl: generate code for ovs families")
Link: https://patch.msgid.link/20250409145541.580674-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/ovs_vport.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index 86ba9ac2a5210..b538bb99ee9b5 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -123,12 +123,12 @@ attribute-sets:
 
 operations:
   name-prefix: ovs-vport-cmd-
+  fixed-header: ovs-header
   list:
     -
       name: new
       doc: Create a new OVS vport
       attribute-set: vport
-      fixed-header: ovs-header
       do:
         request:
           attributes:
@@ -141,7 +141,6 @@ operations:
       name: del
       doc: Delete existing OVS vport from a data path
       attribute-set: vport
-      fixed-header: ovs-header
       do:
         request:
           attributes:
@@ -152,7 +151,6 @@ operations:
       name: get
       doc: Get / dump OVS vport configuration and state
       attribute-set: vport
-      fixed-header: ovs-header
       do: &vport-get-op
         request:
           attributes:
-- 
2.39.5





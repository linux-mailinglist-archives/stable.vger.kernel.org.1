Return-Path: <stable+bounces-140642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4481AAAA75
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A145A28EE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E012D868A;
	Mon,  5 May 2025 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i77d85uN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AE2D5D14;
	Mon,  5 May 2025 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485678; cv=none; b=OkshbliBTu7Yk6Csy+wFp2v77FMOKvp5IGFnlZFA04MUxTYzjthu3rTvNew7MZk8/4SlwzCPbB/cvbzHI/cq2GAuNNLlHLLEAOafPHITrR/QcdlFxo3qgxgq5PHs2/+mtCnwb2zXwlu7tc/PK1RTqv+MNf8IoupNpFYyRAMEcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485678; c=relaxed/simple;
	bh=OLizhLH1GnI6+VepvsENhJMEKJeSmbGNRZoZnzB8f1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXs/0r5lWUSxDDBJEO7t1It2Jfc4N6oHGHcw53FIVKkU7tH4gKD59JZDJen/4hze5OAfiwnBBAhIr2GAe5maV5fvp6kByoGtqD197NRs+l1jQ4shIDnX5/vZRqSRYJxdx4nUtw3x50+vnKu+t6p5SbAAkMrsh2hughQSsipdOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i77d85uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D244C4CEEE;
	Mon,  5 May 2025 22:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485676;
	bh=OLizhLH1GnI6+VepvsENhJMEKJeSmbGNRZoZnzB8f1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i77d85uNxp5bn/QBN+XqUXSNimrMt/nlyjarAflPysKmy/CepRA0nNi5n9NGHNXmE
	 vh9jlx4KDzlkJv7D3thekbURfsED9Na0nTplRQhfusTErdhtsIJBlt1Sdd76sDqJss
	 EgzyEOLlHk2of0uE05rZsG/ZTnVINirJDShBhGETCJ5aA9Xq3YNs+PnC7eo9T+io1P
	 awU4M5wgoCR74wnWP8oCeG0Fw4prQmH3UHsEuFEyy3s8Sy0s+kgnh2jPK3PQ8ALgMX
	 FGzSI7CDnbpNmDj46r3XpG8bywVhj1KIlA6NHLcTLG2bubCAWYUN2Rn5gEfswPx8E0
	 yFf/Ap99PvuYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	sdf@fomichev.me,
	antonio@openvpn.net,
	jstancek@redhat.com,
	johannes.berg@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 421/486] tools: ynl-gen: don't output external constants
Date: Mon,  5 May 2025 18:38:17 -0400
Message-Id: <20250505223922.2682012-421-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7e8b24e24ac46038e48c9a042e7d9b31855cbca5 ]

A definition with a "header" property is an "external" definition
for C code, as in it is defined already in another C header file.
Other languages will need the exact value but C codegen should
not recreate it. So don't output those definitions in the uAPI
header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20250203215510.1288728-1-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 463f1394ab971..c78f1c1bca75c 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2417,6 +2417,9 @@ def render_uapi(family, cw):
 
     defines = []
     for const in family['definitions']:
+        if const.get('header'):
+            continue
+
         if const['type'] != 'const':
             cw.writes_defines(defines)
             defines = []
-- 
2.39.5



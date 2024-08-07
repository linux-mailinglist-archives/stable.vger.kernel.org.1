Return-Path: <stable+bounces-65608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85D94AAFF
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76D71F29310
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6578B4C;
	Wed,  7 Aug 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ul+/V0nq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838E23CE;
	Wed,  7 Aug 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042924; cv=none; b=M4yBjSszk2JFPyBkdEJkH22H0ZA+ge+8D7h7fB85Af1N3ch/z3Z8fY5WZnEVMvrW2i5G2RYn+ooOpMOb7+IIQFZeGG8C/cHCxwNhnhfDGfFZIaEb0+3FS9VZJ7gjhOhVNmjAlHXo2n+fHlvVC6x20GI0hlTgtJWOWPaq7j0hEgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042924; c=relaxed/simple;
	bh=+iPcK6aKvxR5WXIuVkcfrH5gsNC3PML7nB7Wl6CYKd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrRdYp7UTCUuo/j2qcVxQeehhJMWnoFY9oqKDzs39ildqgWTAgTrQQFtUBuNMa171ndY0MFQ34Col7LREf/b2efA+3uKuH/hYuourj8eSDezUNpUy1XmObbddxkWDKiJJqkNKYMnb7OxmoIrECGadxqMi92M5fXJYRShvpCWEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ul+/V0nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE86C32781;
	Wed,  7 Aug 2024 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723042923;
	bh=+iPcK6aKvxR5WXIuVkcfrH5gsNC3PML7nB7Wl6CYKd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ul+/V0nqcolEUVD+HE9tXzp5PgdD0Z+BEOvoVptJJ8t4TalzX1MxwhWsfxkOWYMlL
	 UZv1TCGkKXlVTQBSmulyv7A1PT3Fv36aa411oWUAXQzYz1qY4OvnB9mJ5rbGK24rRv
	 wG9quma9rewWwrZg2mqw5bovK4NPjjQXlnanTyII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 025/123] netlink: specs: correct the spec of ethtool
Date: Wed,  7 Aug 2024 16:59:04 +0200
Message-ID: <20240807150021.625443753@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit a40c7a24f97edda025f53cfe8f0bc6a6e3c12fa6 ]

The spec for Ethtool is a bit inaccurate. We don't currently
support dump. Context is only accepted as input and not echoed
to output (which is a separate bug).

Fixes: a353318ebf24 ("tools: ynl: populate most of the ethtool spec")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Link: https://patch.msgid.link/20240724234249.2621109-2-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 4510e8d1adcb8..3632c1c891e94 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1634,15 +1634,14 @@ operations:
         request:
           attributes:
             - header
+            - context
         reply:
           attributes:
             - header
-            - context
             - hfunc
             - indir
             - hkey
             - input_xfrm
-      dump: *rss-get-op
     -
       name: plca-get-cfg
       doc: Get PLCA params.
-- 
2.43.0





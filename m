Return-Path: <stable+bounces-136321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB6A992DE
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA5E4A2F68
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9276293478;
	Wed, 23 Apr 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krUNTcpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3D293472;
	Wed, 23 Apr 2025 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422238; cv=none; b=sV1ceu5Sw6yK4/5CMo7J8qGbCrqT81oEZwQZgVBjky7BP7mMLfdTwugd6rsaZcOW7ZvwMz126094nrnD4SgBp9TvlSwX9dj+ffD+1vPpwQ9Tu94py0z52eHOFmTXWt16RVRG+qajwoyLTlJcpK5InsihdRVW/r3VMo+vkhksl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422238; c=relaxed/simple;
	bh=gaMei66A29Qd7kbURtTAOHXePDvrlUbhnkD0YkaK91k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CecmQYsodc9MLCzrwItnoAImI9neg3Kxm7DAUA38Ls5+O2VW8D5PM5HCTVX7UXouZc3jrDZl0LYgiqto1T/fVZopwcPmGLsgalW/nRk4r92Suf7a6rSQ8mkygMBwotCCi6s5xJ7h1OYwaZ3d+3SyoErp00CXT+rn4wOcTlBgrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krUNTcpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE810C4CEE2;
	Wed, 23 Apr 2025 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422238;
	bh=gaMei66A29Qd7kbURtTAOHXePDvrlUbhnkD0YkaK91k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krUNTcpar7FRDg1EpCVKvUeKpqPNQdD6vNZ8PX55RgCf2baKAiMX2xbCwrLFDlRGN
	 ZKHQObZ+OMgXEL75MjN9uvV5RhBhGsDQi+4VyTVetF2abwjcvXvYha3qLuXF9zj7ev
	 oWI/TsMoWg4pMi+6RPCP/wss6TXFNMDdWLHX6x+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 281/393] netlink: specs: rt-link: adjust mctp attribute naming
Date: Wed, 23 Apr 2025 16:42:57 +0200
Message-ID: <20250423142654.953230855@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit beb3c5ad8829b52057f48a776a9d9558b98c157f ]

MCTP attribute naming is inconsistent. In C we have:
    IFLA_MCTP_NET,
    IFLA_MCTP_PHYS_BINDING,
         ^^^^

but in YAML:
    - mctp-net
    - phys-binding
      ^
       no "mctp"

It's unclear whether the "mctp" part of the name is supposed
to be a prefix or part of attribute name. Make it a prefix,
seems cleaner, even tho technically phys-binding was added later.

Fixes: b2f63d904e72 ("doc/netlink: Add spec for rt link messages")
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20250414211851.602096-8-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/rt_link.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 34f74c451dcdb..a8a1466adf179 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1199,9 +1199,10 @@ attribute-sets:
         type: u32
   -
     name: mctp-attrs
+    name-prefix: ifla-mctp-
     attributes:
       -
-        name: mctp-net
+        name: net
         type: u32
   -
     name: stats-attrs
-- 
2.39.5





Return-Path: <stable+bounces-80544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDE98DDFA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946D01F22E6B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E01D0DF2;
	Wed,  2 Oct 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFKNw1pS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F51D0DDF;
	Wed,  2 Oct 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880683; cv=none; b=dkqeJ6MmuSrH12qTm5DKVs1+Kq3j+kgPjc4Nd7ktug37ePi/jhte/5R5El1uOC5DSce/WcfJZIfnYyIVQFqh+DCheBvJh7KKUAAt3xq6QidO5nVATl7IjWivCsQ6hPbSrNqn0vHsM0it37Ul5QzyNAcy0dboweUd4yezdpNZZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880683; c=relaxed/simple;
	bh=JPCZD5A+b9DO4CuA2U5J5i+bbbyhShEpnt/vrQaY6Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOm7CRx/WHXX9C+U87A7fuPf0xKCBQFxzBTMVNYb9V4bvJ1buvrvng4lkblDkPLzA9DDs9czrHjF/ctKE2M+uZW6mGfgEt38gAXMy/YB0Ly9dk9GCFCouFhStRRSYrPgeRr8KDPRDHThpYcoG3uGWxOske8pV/lqVJul2rNtlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YFKNw1pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E2BC4CEDE;
	Wed,  2 Oct 2024 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880682;
	bh=JPCZD5A+b9DO4CuA2U5J5i+bbbyhShEpnt/vrQaY6Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFKNw1pSxf0kHFf4/yHVXLKqdENnhgT63vL/GWB4FgUV8pZSD0vNGqvY/9hyAuuK+
	 Wds58++vGdSYy984//KrQvBMh3sW1de97JZ75SjDsdD9WtDPuhz/lU1UlzGmABV+Ca
	 Pp4D1911lZctipWkU43VljALNXA+oUoNr/AANofs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengfei Xu <pengfei.xu@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.6 535/538] thunderbolt: Send uevent after asymmetric/symmetric switch
Date: Wed,  2 Oct 2024 15:02:54 +0200
Message-ID: <20241002125813.562074986@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 5391bcfa56c79a891734e4d22aa0ca3217b86491 upstream.

We should send uevent to userspace whenever the link speed or width
changes but tb_switch_asym_enable() and tb_switch_asym_disable() set the
sw->link_width already so tb_switch_update_link_attributes() never
noticed the change.

Fix this so that we let tb_switch_update_link_attributes() update the
fields accordingly.

Fixes: 81af2952e606 ("thunderbolt: Add support for asymmetric link")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/switch.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2981,6 +2981,7 @@ static int tb_switch_lane_bonding_disabl
 	return tb_port_wait_for_link_width(down, TB_LINK_WIDTH_SINGLE, 100);
 }
 
+/* Note updating sw->link_width done in tb_switch_update_link_attributes() */
 static int tb_switch_asym_enable(struct tb_switch *sw, enum tb_link_width width)
 {
 	struct tb_port *up, *down, *port;
@@ -3020,10 +3021,10 @@ static int tb_switch_asym_enable(struct
 			return ret;
 	}
 
-	sw->link_width = width;
 	return 0;
 }
 
+/* Note updating sw->link_width done in tb_switch_update_link_attributes() */
 static int tb_switch_asym_disable(struct tb_switch *sw)
 {
 	struct tb_port *up, *down;
@@ -3058,7 +3059,6 @@ static int tb_switch_asym_disable(struct
 			return ret;
 	}
 
-	sw->link_width = TB_LINK_WIDTH_DUAL;
 	return 0;
 }
 




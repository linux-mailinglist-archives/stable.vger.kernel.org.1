Return-Path: <stable+bounces-226448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PRlGKGJuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:04:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06C2AEE14
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CBCA303CEC0
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDF3F788B;
	Tue, 17 Mar 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMZEv6Xg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92393F23B3;
	Tue, 17 Mar 2026 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766761; cv=none; b=Flb95O6VmxDv2Z3EZtt27W/7ZzHadWu8hSIC0OD6voGkWZXv+PaPHdiY0vpttKxNUpdUy7GHdv3ieZZI5cRtOQ8IKn8zsxm6umVGubY1WLrpdrF+1nbPniauJ54uDndfhSt77cgf/lJJEpINHs1Yil+qIjKpKr9uMzYxFRkVMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766761; c=relaxed/simple;
	bh=VXD1vzjG817AaMyFHHf2NDX/Dcy4H7XTZnQl2CXbN2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxeoT5LYReIeEhhtvTY35ypY1JlvwO2YxXlgXCf349bNqwdzkylQQsFbQPnLKhHMnJT+9ZV9tqXMLGbCbXn7PdSfROu3jmiM7ttrTqwR/+3IlZgJHMhvhfnNzjpqtM7yklYsIQYA/KdT3XSVZAoaOLey1kRel0aiIYSHF40GDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMZEv6Xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3A3C4CEF7;
	Tue, 17 Mar 2026 16:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766761;
	bh=VXD1vzjG817AaMyFHHf2NDX/Dcy4H7XTZnQl2CXbN2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMZEv6XgKS0nBb9AzJK48KxceglS/y5kwJQcQ2u9YGTBE5XMGHa18wNt1IhTql1QM
	 uXgr9dT45SNWV4qzdXwmO/oVjb9lOXBVsLC/Ka1RZD70uyIrDlMAMHZFMuPMlWJl9M
	 QX+MKmwsI8mmK01ggn7FFCbHjxJQEVSOPRIS/uTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.19 316/378] can: dev: keep the max bitrate error at 5%
Date: Tue, 17 Mar 2026 17:34:33 +0100
Message-ID: <20260317163018.618383806@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226448-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nxp.com:email,msgid.link:url,pengutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A06C2AEE14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

commit 1eea46908c57abb7109b1fce024f366ae6c69c4f upstream.

Commit b360a13d44db ("can: dev: print bitrate error with two decimal
digits") changed calculation of the bit rate error from on-tenth of a
percent to on-hundredth of a percent, but forgot to adjust the scale of the
CAN_CALC_MAX_ERROR constant.

Keeping the existing logic unchanged: Only when the bitrate error exceeds
5% should an error be returned. Otherwise, simply output a warning log.

Fixes: b360a13d44db ("can: dev: print bitrate error with two decimal digits")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://patch.msgid.link/20260306-can-fix-v1-1-ac526cec6777@nxp.com
Cc: stable@kernel.org
[mkl: improve commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/dev/calc_bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index cc4022241553..42498e9d3f38 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -8,7 +8,7 @@
 #include <linux/units.h>
 #include <linux/can/dev.h>
 
-#define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
+#define CAN_CALC_MAX_ERROR 500 /* max error 5% */
 
 /* CiA recommended sample points for Non Return to Zero encoding. */
 static int can_calc_sample_point_nrz(const struct can_bittiming *bt)
-- 
2.53.0





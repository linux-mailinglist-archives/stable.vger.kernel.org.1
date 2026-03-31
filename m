Return-Path: <stable+bounces-231664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCaZOIT5y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:42:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E18236D001
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96993156137
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E34266B5;
	Tue, 31 Mar 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jBIi/EZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259B4266AA;
	Tue, 31 Mar 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974750; cv=none; b=QFgrIuIzkEzqnJe1hUd1WFwUFaNBnB6A7SEyKH7Xhpi7QHD8LFT1tRE1KYvfOll8Lq22IYhAb0FdYgQVtShZTao7aHnc52zIMqSWRhfP62/HKcFTHPwkIjgKKW9/nfzAYZl5YxCsMzLI9UzBuAh6uX6dZEL442mGPOIY1WpbVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974750; c=relaxed/simple;
	bh=Z5Ha0q3BO4W8NfHuz9B17rG/9hyDvxw+ZIRcrpiH4hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQFCPk/sHmI1vE/DwM3D+NWGuP7/8dM+4o6mL8/G8FW0IzS4vdytB1t2ePuKAbyYLpwhvts9le/to6asFbOjPACcJ8QdXOgW9v13wENyPCWHfq1sLGJMToYZAj+72fuOgYBLoQKmyiDeHxT7UO9+LN8Xf2e2KnazDxm3pRN9q4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jBIi/EZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B616C19423;
	Tue, 31 Mar 2026 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974749;
	bh=Z5Ha0q3BO4W8NfHuz9B17rG/9hyDvxw+ZIRcrpiH4hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBIi/EZfCz1h+tm7JEzUty9FllvFzup5pBL29AT74dITJb8t9hkVNckVrRjJgzKiY
	 APYBeMVMBBLiGxRuHUnDNcGt01Rke7PQu8RhOo8Wjgbi8wY46QvTudLzzIK5wbxQe0
	 d6ZaG+vVp9AbyiZNGyohzpEzIAf6kYl0VovY/Psw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 030/342] platform/x86: hp-wmi: add Omen 14-fb1xxx (board 8E41) support
Date: Tue, 31 Mar 2026 18:17:43 +0200
Message-ID: <20260331161800.018750674@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231664-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3E18236D001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Plotnikov <plotnikovanton@gmail.com>

[ Upstream commit 729ffcffa73069cb066fd54a2bc7b09e5f782d48 ]

Reverse engineering of the HP Omen Windows utility shows that for performance
mode it uses the same codes listed in hp_thermal_profile_omen_v1. Therefore it
seems sufficient to add the board model name to omen_thermal_profile_boards.

Tested on Omen 14-fb1xxx: CPU power in performance profile reaches the Windows
limit (65W), instead of 45W in automatic BIOS mode. Max fan speed was reached
as well.

Link: https://patch.msgid.link/20260203164832.40514-1-plotnikovanton@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index bc550da031fa1..ec87fd96686cf 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -133,6 +133,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"8900", "8901", "8902", "8912", "8917", "8918", "8949", "894A", "89EB",
 	"8A15", "8A42",
 	"8BAD",
+	"8E41",
 };
 
 /* DMI Board names of Omen laptops that are specifically set to be thermal
-- 
2.51.0





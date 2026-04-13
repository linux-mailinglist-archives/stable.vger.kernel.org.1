Return-Path: <stable+bounces-236829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGl+FVsi3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-236829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04C3F0B27
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A2C310720C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7FE2D0C7E;
	Mon, 13 Apr 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d+OZC71Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA82C3768;
	Mon, 13 Apr 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097899; cv=none; b=bOOqei4qlFWFZThCSod+4ACRK28SbYS76yaOeEB8rb1//ugNzYOkLl41BUxkDjSrM1roRPwN8rCLQBYioDWK8zILvaKoZoRp8yoaZzxh3NxusPOlPKhALIVjdLh0wvcuwVx6f/JY5DQejEWzrHjw9Pro548gFdExdNKk88oktOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097899; c=relaxed/simple;
	bh=+wg+pWacRFw9tqe8GaL1kwVZbJjLf8LgKRO9gdsH92k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6fbJPixnvAebF2M2770YryL5Y8waQq16DAPSd3ogHKFqnH8gH1DBdsu7Ni/L9aJqEiUkLFjrjRcUM3kJnlc0LQ9yJKdm7mS3LKu5gN0XfszvggpyMKtK4M3w19gjIiAfnrb1m6M3jF49VbRdGiH3lGMI5S/1PP/pEeVfkY3r1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d+OZC71Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB34C2BCAF;
	Mon, 13 Apr 2026 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097898;
	bh=+wg+pWacRFw9tqe8GaL1kwVZbJjLf8LgKRO9gdsH92k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+OZC71QIN82UE7Z3Q52Jn9g6H0dY0fEgp1vzC2E8jz/cCc/pcIbWxf/hIa+1wl0G
	 Eu6bzO71jUlL2O/U0WD+ozoCXKbyewAaX6gX9dDiKuZ+OTVX2ExsJKoUszz6uMTClS
	 L3nMd5etbUQSzuE2BcV1JRwfN4NxcKOYRMqzTISo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Metz <peter.metz@unarin.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 298/570] platform/x86: intel-hid: Add Dell 14 Plus 2-in-1 to dmi_vgbs_allow_list
Date: Mon, 13 Apr 2026 17:57:09 +0200
Message-ID: <20260413155841.665912619@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236829-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: AA04C3F0B27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Metz <peter.metz@unarin.com>

[ Upstream commit 6b3fa0615cd8432148581de62a52f83847af3d70 ]

The Dell 14 Plus 2-in-1 (model DB04250) requires the VGBS allow list
entry to correctly enable the tablet mode switch. Without this, the
chassis state is not reported, and the hinge rotation only emits
unknown scancodes.

Verified on Dell 14 Plus 2-in-1 DB04250.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221090
Signed-off-by: Peter Metz <peter.metz@unarin.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260213044627.203638-1-peter.metz@unarin.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/hid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 4d488e985dc55..6331469ee6585 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -156,6 +156,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Rugged 12 Tablet RA02260"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell 14 Plus 2-in-1 DB04250"),
+		},
+	},
 	{ }
 };
 
-- 
2.51.0





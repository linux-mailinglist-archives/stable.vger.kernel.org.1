Return-Path: <stable+bounces-220491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKq8MYo5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091C1C65C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BFDE30A51E7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229373C7547;
	Sat, 28 Feb 2026 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suNbqh0C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58F3C7540;
	Sat, 28 Feb 2026 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300376; cv=none; b=YxYEtsis6k5jXB/C/19VPTRIYMLxsb/nCEJG2V+MeP4/nQvyC6+u7zNjt/IGhb6QUp8kpJDBDyVpyL3hkcBpr0w9GND0VwIe3f/gr0U+9yyPiSHZExRlak7KgrKHulomQnyz4ou32KreXHBb4e74c+a3DYEvxIs7/R8xuKJhJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300376; c=relaxed/simple;
	bh=I+WvSmise0Jx+vGOsNKnKisnbDDF5sjkEkUosGkspek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCMutkNPMpJhgR1bWjEj/CSl1RVC/eabUVbpPaJju66Nm4OgDZhHNmWUF0YAgi05USPFinKJxnL072fA6qR6/bZsSDIqX4QFHQJbS0q2N7iHkQI22LNxzqMqH1XU+Of2x/O80BK3W3ZUX+Qa6MhKBqPiZYsahnc9ECqgxOM+1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suNbqh0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F0EC19423;
	Sat, 28 Feb 2026 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300376;
	bh=I+WvSmise0Jx+vGOsNKnKisnbDDF5sjkEkUosGkspek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=suNbqh0CDJYBXnnsCyDQTiuQPjqt1Fv6SeGiNork1UtFNRIFhn0cDsKAxhjz/IISx
	 q7+qARlvPoLYlO1UPOWmLz8b2UjU7EJ9B8AZj4cdOC+7L6BveOuuPL34ZUVOVse/b1
	 KXcnvxhcmKQj+FUt7rq35CaoeWjqaOc7qhp+athPA9ePpz34MJw+KSoG29EqviFaMu
	 xBzL1cxF2eJdeNa82ENW/X4COgkqXB0SstZNKYgwHzAexFc6TTwNrdTEJeM+1Wh0wE
	 Iod4gcEk0v9DpzjSOTloIgOwTV4fxdvUvKu7gxfUxkK15glnv8BHf5Nc1ogkKhU03Q
	 E26j1skfyD33Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 412/844] thermal: int340x: Fix sysfs group leak on DLVR registration failure
Date: Sat, 28 Feb 2026 12:25:25 -0500
Message-ID: <20260228173244.1509663-413-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220491-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6091C1C65C0
X-Rspamd-Action: no action

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit 15176b818e048ccf6ef4b96db34eda7b7e98938a ]

When DLVR sysfs group creation fails in proc_thermal_rfim_add(),
the function returns immediately without cleaning up the FIVR group
that may have been created earlier.

Add proper error unwinding to remove the FIVR group before returning
failure.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/LV3PR11MB876881B77D32A2854AD2908EF563A@LV3PR11MB8768.namprd11.prod.outlook.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../thermal/intel/int340x_thermal/processor_thermal_rfim.c   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 589a3a71f0c4c..ba88d878c998d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -466,8 +466,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 			break;
 		}
 		ret = sysfs_create_group(&pdev->dev.kobj, &dlvr_attribute_group);
-		if (ret)
+		if (ret) {
+			if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
+				sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
 			return ret;
+		}
 	}
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
-- 
2.51.0



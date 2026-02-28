Return-Path: <stable+bounces-220391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCCTLnA5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D816A1C658D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4070531A5546
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098C3A8E37;
	Sat, 28 Feb 2026 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjd62ETT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FC3A8E2E;
	Sat, 28 Feb 2026 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300284; cv=none; b=gUnJHf83KGei3ohXe2DWYkjy/hsSLUDGzLeBWTuj01LvvtzNmfg0rjVPrG49Rqg48sUeH6CeGjNQ8I4j0wxhmOm1TO4aiJN7k42UgBCokBgClKp/CUiM/m++AjDR0Dx0jgwnubdr8Sr1XusZGN570Ht0QhY1IxsATf0YQ25FKUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300284; c=relaxed/simple;
	bh=xRWtLbm0zjBdLRyDSj+VAA8imS9R2w3IqEL1uvlgr3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLDDpVQWuHM3j73XP/u7+BoTTT6XVLNFjscDfhGOjP6mP+T3vevOV6FoApu4RbAqW8zwhI/dILFLekyun50Z+w/S3SMqSoemgJ3sN10WassfQjJ8v4ufDbc4pYo3sfVokj4ngfpwIxhsJ4+53ajIf4VxKr7dvWpf1489BYY3IdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjd62ETT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9864FC116D0;
	Sat, 28 Feb 2026 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300284;
	bh=xRWtLbm0zjBdLRyDSj+VAA8imS9R2w3IqEL1uvlgr3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vjd62ETTXD6YDw+ZhsapA499u2jnmRNjvDDe+eTYOwrpI8JmLug2wUYFdzLouhg5C
	 BJ/ftYNF4/fEx96yL3j3n0jCWsE2dDU3XUvYRJBNdNjKU2kjH9ZRT3MyExA92fvXOT
	 Y4GTLD0UDc3pO6jqB4B8G3Bem3MwPJ0aRhsbqHZh88doY1aAhOjUlGpFioO6doggZv
	 LnScZ0y2MGzoCfpWXkrHBVpLANou4WY9tdPnYTT5h2THkNwlffdnMtZsj8h7AtAnFR
	 FnENsUKaUq+YCfYt0ahVk4C/7gArkA8mwWhPajta0xRL+stYIokoVufkG2FYEOTnnx
	 T2mG06W/tdD3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 312/844] wifi: iwlegacy: add missing mutex protection in il3945_store_measurement()
Date: Sat, 28 Feb 2026 12:23:45 -0500
Message-ID: <20260228173244.1509663-313-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[u.northwestern.edu,wp.pl,intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220391-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D816A1C658D
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit 4dd1dda65265ecbc9f43ffc08e333684cf715152 ]

il3945_store_measurement() calls il3945_get_measurement() which internally
calls il_send_cmd_sync() without holding il->mutex. However,
il_send_cmd_sync() has lockdep_assert_held(&il->mutex) indicating that
callers must hold this lock.

Other sysfs store functions in the same file properly acquire the mutex:
- il3945_store_flags() acquires mutex at 3945-mac.c:3110
- il3945_store_filter_flags() acquires mutex at 3945-mac.c:3144

Add mutex_lock()/mutex_unlock() around the il3945_get_measurement() call
in the sysfs store function to fix the missing lock protection.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260125193005.1090429-1-n7l8m4@u.northwestern.edu
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 104748fcdc33e..54991f31c52c5 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -3224,7 +3224,9 @@ il3945_store_measurement(struct device *d, struct device_attribute *attr,
 
 	D_INFO("Invoking measurement of type %d on " "channel %d (for '%s')\n",
 	       type, params.channel, buf);
+	mutex_lock(&il->mutex);
 	il3945_get_measurement(il, &params, type);
+	mutex_unlock(&il->mutex);
 
 	return count;
 }
-- 
2.51.0



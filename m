Return-Path: <stable+bounces-247734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBalBAkTB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:35:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4C054FA8B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22659314CE21
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526EA47A0DB;
	Fri, 15 May 2026 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBKI0WdU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD047ECEE
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847150; cv=none; b=YR8ALQMorCPoaMIZfl+peVuad3Qy+bgbYKp8zCixtNXCI3eMexLPXh+P0uuYd+qEfmo1AxEPG5G/I96DpCPo0zRsXQQZTjy6qzLtfp2axAGdabsIQau4Idxtl3/JUKEbg0PstSMvHyuIh2hlfB5KVKJoin6jx80AoLc3HI2DtmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847150; c=relaxed/simple;
	bh=2R3vKeNVW74nHrBVufrdcdbAaqqXsE5GSwxXB5EcMe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcozTBkRTSQ1uMYoMOhwdxRegWmftT+08hYV3F9OMhC5l4sHOCvFhi0fgWqH1jWaXo8GXVE+JHagYOYNeVfjA9nwpdLeD95hpIGhu4akO+c1GVxatvhRskfZQwAAfZVSSUCZD1+1iRp0uKkixKpaa9hK6ubaThRd6DatsEyfjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBKI0WdU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fbd79350dso83838481cf.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778847148; x=1779451948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amCrfYz+XZIkhe1QNRlSts2vKTBkBvty+ZpNysynPNw=;
        b=mBKI0WdUBvoFb/OCKDjYLq67HP0ZPOpVe51UHLstAoW4bb4W3AQJIkXzrREm6wI96r
         Y0vZDKVVcFQC1NqOALdKla57kQJeV6rUqGiau/sz4pe+MdWv6fmO7UVjZNSPt8OVdIyO
         QB7iIXtG5vwb6LFGFpf4X1v1eFDWHUHXwDBWZLPw7nTvH0wsN0MlAjKnZhf66gkH7au2
         AdagbL6qjCj+Dz6HzKXGkBrfsR5P7/3/QIT6MmbTFPSE/tXDsquKM+tigbXI+7T6ZdAL
         5i6LvsTyTALE5iGWo9+t3Nt7/LpUo/aNbLyZd0Wj5LnldHvtlgbmnfDY4/g8LfLhbPcL
         l5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847148; x=1779451948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amCrfYz+XZIkhe1QNRlSts2vKTBkBvty+ZpNysynPNw=;
        b=Y6Q8Ied+3iAuuAvFvfZDApjdyStzhzsb2sstQfyLb8zDKyPloE74ASLNNDmpfSMCr2
         chpXgao6rgk2mkE+E3jLa1x+uAV1NcEZIcRrBMIqnimcX4glw1mlVTf4iZySFnC7ArlD
         KifZpQUVTxXMWtMPM4tqmKOkkPB8zCNXxsWUpzyymz25/rk/gxp+XX4aN/oVZ/bnWboc
         21hNEL2PXx08Of5KIV1OJdXopbIxmsrMU1mSmatXj3Qgrt9zzpmCXTqtsaBuqJaW99nS
         YYNbvav4Q9xoaggsjqbyeTnDk4SQmoDFyA1yl7p7xJlyUmFZlOtntVpknVqlRWg8q4xo
         UwWA==
X-Forwarded-Encrypted: i=1; AFNElJ+eLnaoJE4XY/vrUd4DJ14UYEuSi2LGwODJtku9yhmH7lEUyUa9SIFbaViOghf901Un5Rpj2ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVEUbODht2KykY2U9MwFSwy+vdOSmRrC+t8QXI4oz8yvNOpv2
	l+MnY9k8EhzBU3iyVEhDCh/9vwjZdN2tvgBytU6NNuRYd6m7gzKQFkw3
X-Gm-Gg: Acq92OE4hNORt0CM+xMBGyLbHt8bfHJI8JtlLrQwH3qUEGwhkvzrH8kZkzw+aKcQtbI
	01srgebodrA2RGO4a51c5Qm2RuthtBMtaDj4/KXdY60R9eCLWy43Et7Avu6YyE53r7Z5nGxJOd9
	wp0uBaC0LooM3HGCBa6OV6t6ZwG6Y1HoSYAWfm0iRcNiptJNiu2HCCIU1astCIfaDflb60HRB9r
	x+16cGVZ3y3khly6/AWswHt5+160K/j8nNen9BF0x0lbyqaqk5oUDEV0DSrLP8fq0LQOplzRppu
	4a0zZZsd4di+l6qdwq3ihPidROHEu3TGo4DRAUVoRNffadcsKFlD2cPyXJnulT+uONVQTf92C+f
	QGqLHshBeNmVWOS2dG3LDz90L9JSh55+8G0tmTn/4N5p26IGWg14JxH5kVVJRmmm8UpXVa3Gw8k
	f4/XMXfffd9GcWVm6mPS/a30Jt8HumfpAlYkUlAGCJEbtrVKdTIxgs/oJzAG1eX0yg88wGSO21v
	tGFGC7k6+XtuNbuamy0S6ocMTd7+y11pKUu+Nz2sDo=
X-Received: by 2002:a05:622a:1f16:b0:50f:bc57:d69 with SMTP id d75a77b69052e-51659ed0e67mr48506521cf.0.1778847147439;
        Fri, 15 May 2026 05:12:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm45534491cf.3.2026.05.15.05.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:12:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] wifi: iwlwifi: mld: include matches tail in match-info length check
Date: Fri, 15 May 2026 08:10:59 -0400
Message-ID: <20260515121100.649334-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515121100.649334-1-michael.bommarito@gmail.com>
References: <20260515121100.649334-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B4C054FA8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247734-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

iwl_mld_netdetect_match_info_handler() validates the firmware
notification length against sizeof(*notif) (the fixed-header
size of struct iwl_scan_offload_match_info, 24 bytes) but then
immediately memcpys NETDETECT_QUERY_BUF_LEN bytes from
notif->matches:

	if (IWL_FW_CHECK(mld, len < sizeof(*notif),
			 "Invalid scan offload match notif of length: %d\n",
			 len))
		return true;
	...
	if (results->matched_profiles)
		memcpy(results->matches, notif->matches,
		       NETDETECT_QUERY_BUF_LEN);

NETDETECT_QUERY_BUF_LEN is

	(sizeof(struct iwl_scan_offload_profile_match) *
	 IWL_SCAN_MAX_PROFILES_V2)
	= 18 * 8 = 144 bytes

so a firmware-emitted notif sized at exactly sizeof(*notif)
(24 bytes) satisfies the guard yet the memcpy reads 144 bytes
past the slab-allocated notification buffer.

Reproduced under UML+KASAN via a KUnit harness that lifts the
length-validation + memcpy logic into a self-contained test.
KASAN reports

  BUG: KASAN: slab-out-of-bounds in mld_match_info_buggy.constprop.0
  Read of size 144 at addr ...

Building drivers/net/wireless/intel/iwlwifi/mld/d3.o under
x86_64 allmodconfig with the fix applied yields no new warnings.

This is the same bug shape as the previously fixed sibling
commit 744fabc338e8 ("wifi: iwlwifi: mvm: fix potential
out-of-bounds read in iwl_mvm_nd_match_info_handler()") applied
to the mvm peer function. The mld driver was added in February
2025 and inherited the same length-check miss; apply the same
correction shape.

Cc: stable@vger.kernel.org
Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index ef98efc8fb1b..e89ec531cb06 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1128,7 +1128,7 @@ iwl_mld_netdetect_match_info_handler(struct iwl_mld *mld,
 			 mld->netdetect))
 		return true;
 
-	if (IWL_FW_CHECK(mld, len < sizeof(*notif),
+	if (IWL_FW_CHECK(mld, len < sizeof(*notif) + NETDETECT_QUERY_BUF_LEN,
 			 "Invalid scan offload match notif of length: %d\n",
 			 len))
 		return true;
-- 
2.53.0



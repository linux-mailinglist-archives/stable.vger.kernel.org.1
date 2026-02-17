Return-Path: <stable+bounces-217132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNdODjvVlGnnIAIAu9opvQ
	(envelope-from <stable+bounces-217132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:53:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6515075F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB1043053CF7
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F342C21C1;
	Tue, 17 Feb 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HX5LglaW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731E29A1;
	Tue, 17 Feb 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361531; cv=none; b=Ir95eogokZIlShD7zzPc9iG2krR4ygC5MNfqAMZvBB0J0PKuM9IfuYx1x4Drdvlki+cfV1YJP/XC3BfuCUkupnZ+OFxOUfxW50yNNwGIO23u2OtrA3DokhzydGvQ3YEeBO3DljxuwZiPvkD7KDLrW/b8kIqC2GcWrG27CFO0XWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361531; c=relaxed/simple;
	bh=ZKJrD5wUOEFCRjFOBSLlb0F0QHLRUMsrGGX8AVlWe2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDAQQI+5vHYiwsosrDNxn8XGku4vY52MOXBZX+rpPzbTC7rJHfofpNlx8km9QCw4/wiCvuiOS3cdi2G+JYpnrKpZCBlkF9miY059PMa8yE6Vti2G4j/a/oYJx3f8lkv8D1UWwSvFIqTkkdNyHQOrjMv/DXDd3Mnc+b4LNU3/QqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HX5LglaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E50C4CEF7;
	Tue, 17 Feb 2026 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361531;
	bh=ZKJrD5wUOEFCRjFOBSLlb0F0QHLRUMsrGGX8AVlWe2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX5LglaWlQ/rYJ9+6K+1nh2XKifm+g6J5OM7BSWYi17QVKF+sMZcdrHGPcTqNXqnG
	 3TBKRhQlnhar5r5n9FebBwGWB7FYw6Tfx4MKV/FotPIwHdAPqUIa9sDllscGSlkbOK
	 rkgtn+UIIJs7Xm+1mUe0MqPWBk/JA1yZ/gFdas10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 33/43] f2fs: fix to check sysfs filename w/ gc_pin_file_thresh correctly
Date: Tue, 17 Feb 2026 21:32:13 +0100
Message-ID: <20260217200007.740395658@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
References: <20260217200006.470920131@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217132-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2A6515075F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

commit 0eda086de85e140f53c6123a4c00662f4e614ee4 upstream.

Sysfs entry name is gc_pin_file_thresh instead of gc_pin_file_threshold,
fix it.

Cc: stable@kernel.org
Fixes: c521a6ab4ad7 ("f2fs: fix to limit gc_pin_file_threshold")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -749,7 +749,7 @@ out:
 		return count;
 	}
 
-	if (!strcmp(a->attr.name, "gc_pin_file_threshold")) {
+	if (!strcmp(a->attr.name, "gc_pin_file_thresh")) {
 		if (t > MAX_GC_FAILED_PINNED_FILES)
 			return -EINVAL;
 		sbi->gc_pin_file_threshold = t;




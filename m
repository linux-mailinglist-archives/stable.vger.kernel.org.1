Return-Path: <stable+bounces-252044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IxIIoj+DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C63EF596937
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E0F3894662
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A943F23BF;
	Wed, 20 May 2026 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dAV+qkxF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479E3A3E60;
	Wed, 20 May 2026 17:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299599; cv=none; b=BPyRFENmi5DXdf0NeSmZAcqDsNfl3wDGvZmemUJKMIEhY4jTlx5juSjinBsaNm6Nnw06WP+vcY0DGmZznWyY0ITzxymgBc5ODv2VvWi+vDsY+yWkU2A4cQEkotQss4tSJgMU7uFREA9L9GnIYD3I+V0LwWyNsGzuYqPY8xwyJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299599; c=relaxed/simple;
	bh=rahn2ierDjrr9GXm9bM6wXv27BXyb5Ixoik48IuivFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by5l8pnmw6pzomCSRHm9ZZ77gvrkd1d94ZQ3musWr/KkJl3GiTPBP0+YJrLhpBg593/Wmo5JpLPPS7hEs1VLfS6UcLxRqBH4rQ0UyrwhVmuD7Xq3GpfjGb+qLib8Ovj++pQ3B+ArpkC7HyLNeLD8ktyKwEWr2mN4Mz4uIHXtMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dAV+qkxF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9D71F000E9;
	Wed, 20 May 2026 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299598;
	bh=bvxDva1WUkjj0jLWKJrADQ7d0xhVcqX2ModVcN1ygUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dAV+qkxFbaotUMVVk7Wbrxc8maBKCP0CtWM4BNqQvxc9VXVRxB8tZ6GYeuvGa1489
	 yNdQgR1QlKnGOaoKZeFXkhmtc4wGkZEkZQA4vXmyjLVGhQu+Nm6J1lFB6tMcYnbbXR
	 2k2LdzTmSnPlwHjybxZ6RbmmooMLaY2O1cBPE1wU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stuart Summers <stuart.summers@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 832/957] drm/xe/debugfs: Correct printing of register whitelist ranges
Date: Wed, 20 May 2026 18:21:55 +0200
Message-ID: <20260520162152.610602621@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252044-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: C63EF596937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Roper <matthew.d.roper@intel.com>

[ Upstream commit 03f2499c51dffce611b065b2894406beb9f2ebe0 ]

The register-save-restore debugfs prints whitelist entries as offset
ranges.  E.g.,

        REG[0x39319c-0x39319f]: allow read access

for a single dword-sized register.  However the GENMASK value used to
set the lower bits to '1' for the upper bound of the whitelist range
incorrectly included one more bit than it should have, causing the
whitelist ranges to sometimes appear twice as large as they really were.
For example,

        REG[0x6210-0x6217]: allow rw access

was also intended to be a single dword-sized register whitelist (with a
range 0x6210-0x6213) but was printed incorrectly as a qword-sized range
because one too many bits was flipped on.  Similar 'off by one' logic
was applied when printing 4-dword register ranges and 64-dword register
ranges as well.

Correct the GENMASK logic to print these ranges in debugfs correctly.
No impact outside of correcting the misleading debugfs output.

Fixes: d855d2246ea6 ("drm/xe: Print whitelist while applying")
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Link: https://patch.msgid.link/20260408-regsr_wl_range-v1-1-e9a28c8b4264@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit 1a2a722ff96749734a5585dfe7f0bea7719caa8b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 23f6c81d99946..21763dc51150b 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -174,7 +174,7 @@ void xe_reg_whitelist_print_entry(struct drm_printer *p, unsigned int indent,
 	}
 
 	range_start = reg & REG_GENMASK(25, range_bit);
-	range_end = range_start | REG_GENMASK(range_bit, 0);
+	range_end = range_start | REG_GENMASK(range_bit - 1, 0);
 
 	switch (val & RING_FORCE_TO_NONPRIV_ACCESS_MASK) {
 	case RING_FORCE_TO_NONPRIV_ACCESS_RW:
-- 
2.53.0





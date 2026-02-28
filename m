Return-Path: <stable+bounces-220289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKHoOTE0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737CA1C5E02
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFD853284377
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF136386EB4;
	Sat, 28 Feb 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0hEPSo1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93277386EA3;
	Sat, 28 Feb 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300193; cv=none; b=QwFFhaeFNassxPm6qRve21WSExnJuMYL4jDOF1YbU4N6LdMIQ4MJFN5oiuWKqRzRrgI7fWOS4OXESzU2ZM4FLXdzkefOs534sYNxcOi8CyH8KTCC3YY1lcbKXSPpnl2otnnJRJNqa3FrYa2yj/CRKD2DVOMmA7uqLf/MtyEZMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300193; c=relaxed/simple;
	bh=CMEbP+rdVxf9RR+AzjzYLeY+N4AES/ai99H2uz96kp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6SSxMOquBjAxsxxtlUnNSSKkxHoB8h1AID4ZWRnJors3Et7IctrHr7ZCF+Sq1i7cdaCT1Szsd7672QR8Bmicv898HPfvMcfkHww9mVzl2v+2GjukyWW/3iO11GHyXXPHWdoOEWfhjwiFY4PLWcPXYlUfihKlv4kpmDwfuhZZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0hEPSo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF31C19423;
	Sat, 28 Feb 2026 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300193;
	bh=CMEbP+rdVxf9RR+AzjzYLeY+N4AES/ai99H2uz96kp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0hEPSo1v0lry+qNE7B/CDlZw8egP8TmCqVWT23XUJTSs++l6CK2qUHtY8XbLoB+4
	 fMytYHvX4yb4Ci9cZDczBM2/b9+Z67Lforg/uWAZkuK+SBCsrlFBIxqEec1wTCW/PO
	 A7Q8gy7NpEHaYZjF5P+9Q9Gj5UvIIUJwA+Gq6VWrfTDFrGCm+ouhJRCHLh5HM9gnDU
	 V227uk7qnPELrIbA1qSg6b0ftjWx766l766OM9RPKI6LiWU41MaoI3klKzLmRrYLIj
	 QJTGoGKxCznzl3Ic6Plo44Y2OT1ykfFzXmGxQQa+oE27mVGjofFqLMdbAAQxs/NDvg
	 xJLuu0YUwHgDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gangliang Xie <ganglxie@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 211/844] drm/amdgpu: mark invalid records with U64_MAX
Date: Sat, 28 Feb 2026 12:22:04 -0500
Message-ID: <20260228173244.1509663-212-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220289-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 737CA1C5E02
X-Rspamd-Action: no action

From: Gangliang Xie <ganglxie@amd.com>

[ Upstream commit 0028b86b52f7609e36af635ef6cb908925306233 ]

set retired_page of invalid ras records to U64_MAX, and skip
them when reading ras records

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6b069dc4bab06..ee4d08b0988d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2777,6 +2777,10 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			if (!data->bps[i].ts)
 				continue;
 
+			/* U64_MAX is used to mark the record as invalid */
+			if (data->bps[i].retired_page == U64_MAX)
+				continue;
+
 			bps[r].bp = data->bps[i].retired_page;
 			r++;
 			if (r >= count)
@@ -3083,6 +3087,8 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 
 		if (amdgpu_ras_check_bad_page_unlock(con,
 			bps[j].retired_page << AMDGPU_GPU_PAGE_SHIFT)) {
+			/* set to U64_MAX to mark it as invalid */
+			data->bps[data->count].retired_page = U64_MAX;
 			data->count++;
 			data->space_left--;
 			continue;
-- 
2.51.0



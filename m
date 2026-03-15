Return-Path: <stable+bounces-225489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGPvLPg/t2kwOwEAu9opvQ
	(envelope-from <stable+bounces-225489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 00:25:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF329302B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 00:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 028E83013A4F
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816DE2BDC23;
	Sun, 15 Mar 2026 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duygOQXM"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D02135D7
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773617120; cv=none; b=YTgqoM4rwaF8pGbxjrwUg6tnZPi/VLuv4tmoobPTQ2ulWBrrux/VwmH5xr9cu34uMx0hK9JIuUsVXQ4CalCoJrygfKwdw6cgMtIReW2eyXgutpIiBiCckWbgtWJ3l/i0IIVkTQ1bG1TvrrnFcf2pgZrZ6ihMxMvI3RCNtbQkyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773617120; c=relaxed/simple;
	bh=jAMfolcZSWXlBmUQWetpINLpy01Bq3OSZvhc2R2/9CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=na3lGDzv8jjiJAY8APKIhEsqlhuRZvfvFMbq7D3JwuBevstq6rVtTJB+JZbWriT3QJiiWzCeYvb0J6uVTc3JrE2+AoC/Q0MxFS/oMuLMgwoEzGBarODrF6UZ8qvL+0rgEeeCpyWhch37SITiMXPGrVTaGdPwCcSGWfingv5Vwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duygOQXM; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so1602289eec.1
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773617117; x=1774221917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeJ4mquJYADCwtgoxMoMXaszduThytc8keaBhAGxhiY=;
        b=duygOQXMHtlmZSAaZsJLarnH+A5ocoOLHLvMDcw6N/W4KI5tI9F0RFLDW+WhzuXOLG
         PJSXfjUyGWxBK3L12rkxfH/2aCWI3Xt+FnBbydO0TlvcTrxu8J/2tPe1QrQkoXnvKyRY
         hfpilROOY1Q10wLt6xLWdx8oU0Om3HBmmxQPVSumkVmvIfcrSKMAtO02YkmBzzIlLlN8
         ZWgjnVfNqzsOTtOiJzi7QCaZnXUuiTWvsld7F33rNMEWZLyByj2EibnKUkW5Gkddbfat
         ZTXQ0pb4Qvykmh7dw9YbCTYE+XofFqlNVwMZs4jl9otH9L1hr84Ke8cSQXR4/911Y/Bh
         ZQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773617117; x=1774221917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeJ4mquJYADCwtgoxMoMXaszduThytc8keaBhAGxhiY=;
        b=ecs9nQYhCxjZiNhpEuQEw8QWznABLsV3OdlDMIBtAbWFnG8nG9a7OydqkCYEFz0wdL
         0/fI+LBQRJPJiUjsUzDcQVSq+GZKCJD1+HTg7VwUubSAoG8GkQXIHE5fnMahAmCzxwcC
         N+iRcOXvPWYdCOlrEiJecbNUK1DduFNkbAsps7377a/Ob4T0qw+kDacgpqVJYO8CXvoS
         LG8sRP/ciStuDvIW/DiNkEoOyFTpC8Sg7m4TNdsYLCJBRIK+kiYqfnN8qo3B/RdHvAj5
         5/94KyFf0lwohxriRPaffqKB3WUaAFEDOgILbJ4J/+9nFVh8tsutLlwmfUgumX60m560
         h3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXL+PO5k8HrpXGgDSReFIMYQ0eK3e0sUOXYID8KAudf0lywlSXaVudNAfkxMm3YF/4dPHstc2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YybMBthDrQHjAKPJPLoNixEROkFIBE1F2C6Spj5w+zWY8A/zUew
	eSjt5IsXY0g2GFCbM/pxMRZqQWBmQEDr8zHSYrH+o59UIkFJnA9yPqTW
X-Gm-Gg: ATEYQzwyXJls8ON4SOmbTMMek/i30g65XI1Tzv9dum2RPA0wBLJW19BAeBsOFcbmQ3y
	xUu8sXmSiDDS4Cr8M3v8OICmGzbvVgrZyZCfpNG3kaau9tRtBrwtZMtunLTS7GcvhLH/18Cqst4
	dRFTyHxyfwvGJBMqtSg9+OLpzNGQ/M4OsgBbYZtbvUg8wbiYdX4LV6iL5udN4DxmwNBL+3Qwjk3
	YqkVV3zsQjVa4b/ncQiYD0vhS3njsxBf8rJ035iWNAy8rEKbqoaDPU9xeOAisChi4wC9PBPv2L/
	uZRlI02q57u5g/t84HGPtud47smZdapooVQvHgByHlthcu/ArwWh43q0nxqvvuDg2R1UQQh4oju
	8xl4pnyP9XjEEE1EhT4R2TQUapSgPwoxtDi02K6iE6FIneTPt2J83OM/HerBCtIAOxlAEkBAlT4
	qs/DXRK97bkCc1F4PAX5XbQ6AwBRsHFQcZoHUNKk756LMLqbvpBpZtkupdxit3ReMe
X-Received: by 2002:a05:7300:2319:b0:2ba:8e16:260e with SMTP id 5a478bee46e88-2bea5473d9bmr5229217eec.11.1773617116756;
        Sun, 15 Mar 2026 16:25:16 -0700 (PDT)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a0b3fsm12531375eec.5.2026.03.15.16.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 16:25:16 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Milind Changire <mchangir@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto allocation fails
Date: Sun, 15 Mar 2026 16:25:00 -0700
Message-ID: <20260315232500.251088-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225489-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21AF329302B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

move_dirty_folio_in_page_array() may fail if the file is encrypted, the
dirty folio is not the first in the batch, and it fails to allocate a
bounce buffer to hold the ciphertext. When that happens,
ceph_process_folio_batch() simply redirties the folio and flushes the
current batch -- it can retry that folio in a future batch.

However, if this failed folio is not contiguous with the last folio that
did make it into the batch, then ceph_process_folio_batch() has already
incremented `ceph_wbc->num_ops`; because it doesn't follow through and
add the discontiguous folio to the array, ceph_submit_write() -- which
expects that `ceph_wbc->num_ops` accurately reflects the number of
contiguous ranges (and therefore the required number of "write extent"
ops) in the writeback -- will panic the kernel:

    BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);

Fix this crash by decrementing `ceph_wbc->num_ops` back to the correct
value when move_dirty_folio_in_page_array() fails, but the folio already
started counting a new (i.e. still-empty) extent.

The defect corrected by this patch has existed since 2022 (see first
`Fixes:`), but another bug blocked multi-folio encrypted writeback until
recently (see second `Fixes:`). The second commit made it into 6.18.16,
6.19.6, and 7.0-rc1, unmasking the panic in those versions. This patch
therefore fixes a regression (panic) introduced by cac190c7674f.

Cc: stable@vger.kernel.org # v6.18+
Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Fixes: cac190c7674f ("ceph: fix write storm on fscrypted files")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e87b3bb94ee8..f366e159ffa6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1366,6 +1366,10 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			/* Did we just begin a new contiguous op? Nevermind! */
+			if (ceph_wbc->len == 0)
+				ceph_wbc->num_ops--;
+
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.52.0



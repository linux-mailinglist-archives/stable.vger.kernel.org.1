Return-Path: <stable+bounces-224640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d3nwLVj7sGnCpQIAu9opvQ
	(envelope-from <stable+bounces-224640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:19:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929725C5B5
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 06:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A113303204F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 05:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF1E23FC41;
	Wed, 11 Mar 2026 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBL9mSe9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC7A95E
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206358; cv=none; b=ElcJNI4ibS/uozRyp3LPek/fENHPArmaE+D6v98R0MC5baQAPu5hYHp1W9y8nVtFMroUJBqRDgljse3LKhuBRKXxPjfcDoBHubBZdDikG2DK4g4xRlQWbwX33S20QOyxnoSeKqqivHgi6MIWJ92fuLbfPrm5nobuMbmfjsNgJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206358; c=relaxed/simple;
	bh=/otAp9NdejqBs41+FT2LB5tb9QwuRBvG6lARjkW9TE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1r8tCFOElm/fHOSblxAs0PSpPG5xOU9epWt/kqpZJLufJGtRw2AQ+AyvKVD6OGSd7Y7+Kr83VJ0ist2V3P7tyOeaPS9WQxCfEW55wcvufnHfv+z+cF1O8Yx3pcOXhGRYUU2YXi4E7k/ziDbDLYOO4BWfVZgaWlzix7PwPIxiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBL9mSe9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82985f42664so3524268b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773206356; x=1773811156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/V5vIb9B8E4ZT9kdnjcFWofNvOiBc6LRtGKSykRz08=;
        b=gBL9mSe9+FHYM76ySINw2WdyTPXVbx4Raylo9b/2GUZOWyzxHZppyKE/hSm/BUwZgv
         2oQnAWfT2bvjD918ajnanPkY4MHd0OrH1UYm/rDs4kUZD9FNLMU5WTGNvEC335TcOELH
         TByS81ZH4Kvm94HYM9fcast6EUnXkDY3h+IM9ExxM9QcM6cirKpuMLA2U2sjLXgf/viS
         uGKS1fb1XsgAujAsEUHWsniKCzDnp4vwCQFdlJzPu/Vi5YXUWkUI310S9ukmR4b4tTFf
         34MjY+SjhE2bXasWB9Rs9RJQ5r4MOrQ5u+qKK+wA3NWlBm/CBDhSAjTOSgnl1qkvqEQU
         qeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206356; x=1773811156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/V5vIb9B8E4ZT9kdnjcFWofNvOiBc6LRtGKSykRz08=;
        b=UdmXHecdOfVxC45tDNpcw+i613gVyae3RzIvXBabs1D1UUdJyx8/YTFnJIjB/MQY2K
         Ivie34d6jbjanls58OeHZCPQ69y74+DhCXkRg4ZUI3SD4Ac2Cb8mBJueOpDlK5bnzA8A
         4cNltI9KSjMoHS5ypvRpVZ33ugobh+TAI206n5JHa4v8zChNqHcOZiH8YAqe21yhGtgk
         1kaJuc4vPElu8Cfb2r4JXWZY/rOEJfL1Mbkfhs/LmFnLcPAKePkFAeTU2PpCG6qD/Gux
         kVyDr+5dRU0aTPZTYCAU19EqPbtKcrRNiGmgl/Eymr0pxt0ycdy3Ld0dOGyOHrJteP1Q
         Zi7w==
X-Forwarded-Encrypted: i=1; AJvYcCUNwrIU40x/khzQQwZdYpktiQ4kKXCYVxKqPjAoy5E4X3zQANb6pPAN1XWbHqgrcsXg3Q75Ba0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNSqxCDi4TdptnloFYq2zvT9MvRrAb/RN5LBYBDFh8MnGkPAlO
	roosCwooedHPgFvXnMGc/AXC9a9EwTzQOcoTyQht83nq7uc/TRvhRYu9
X-Gm-Gg: ATEYQzxtEE1wBrJPXvIBFIWXIbSeCQxjBVFMnE1oNsAoRELkkSi47os3CJx7NN13WjU
	/PmClHcmNujN7wattUBSb9Q3jsUUBpLFUEqQ32+R9CrFhvUuRxVpF8wDnaUJXtQRETP1165rsMo
	NDPLE+eWOfbIQoA7xvDcnMepXKYvdpkwq9ey5xEBYhFnk5uHTN/M1K+9JG2rxndjTj7vuxfQni/
	2pk1jvoXaTZdu6T7mGY5/0wPexshX4bZ3lFc+oqJd4CytL9Cu35eckQuRWP9k7Nz2zvbbg+Yor4
	DLonYEt2o1iJ+ITaSBvcEIUDcapH9DcMcNYAW/7QmOMGDFDvIffktWb4CkVCRcqqeeiQwI7SBxw
	ashmcGPLYyLlOqPBhJkoUl9Jt31S3JRnFKT81cix5+9xBnXLKz54zn6GEgAc8PQ06UYvP9CQqT+
	HAQefPjis2eOp/C68+dJEzSAyqY6HOFeJPsTwdN19WgzsZCa9fYMQ=
X-Received: by 2002:a05:6a00:950c:b0:7f7:2f82:9904 with SMTP id d2e1a72fcca58-829f6ee86d6mr1225830b3a.5.1773206356392;
        Tue, 10 Mar 2026 22:19:16 -0700 (PDT)
Received: from sprasad-dev1.corp.microsoft.com ([167.220.110.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6c2fdcbsm988821b3a.0.2026.03.10.22.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 22:19:15 -0700 (PDT)
From: nspmangalore@gmail.com
X-Google-Original-From: sprasad@microsoft.com
To: linux-cifs@vger.kernel.org,
	smfrench@gmail.com,
	pc@manguebit.com,
	bharathsm@microsoft.com,
	dhowells@redhat.com
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] cifs: make default value of retrans as zero
Date: Wed, 11 Mar 2026 10:48:54 +0530
Message-ID: <20260311051854.2584907-1-sprasad@microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5929725C5B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224640-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Shyam Prasad N <sprasad@microsoft.com>

When retrans mount option was introduced, the default value was set
as 1. However, in the light of some bugs that this has exposed recently
we should change it to 0 and retain the old behaviour before this option
was introduced.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
---
 fs/smb/client/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 54090739535fb..a4a7c7eee038c 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1997,7 +1997,7 @@ int smb3_init_fs_context(struct fs_context *fc)
 	ctx->backupuid_specified = false; /* no backup intent for a user */
 	ctx->backupgid_specified = false; /* no backup intent for a group */
 
-	ctx->retrans = 1;
+	ctx->retrans = 0;
 	ctx->reparse_type = CIFS_REPARSE_TYPE_DEFAULT;
 	ctx->symlink_type = CIFS_SYMLINK_TYPE_DEFAULT;
 	ctx->nonativesocket = 0;
-- 
2.43.0



Return-Path: <stable+bounces-111852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56588A242E2
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 19:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4323A88EF
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2731F2379;
	Fri, 31 Jan 2025 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHsBg40O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463B7081F
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349058; cv=none; b=jrlVBBdoKpRY6KaiYqhgAC4eLO0jy3/IR8dmmXpkVJLZ5Jum3UvyWjgHjl1H+6YSaDALmkIXAPdGJB7Nuk0O5RvhWCc8C1MarmBklJPk9gCWqQKTG8mh6Ad4W2QfjuNOIPc87iMjdtJchqejgn7zxe0KrJ3rXSrdhRQNcpXjWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349058; c=relaxed/simple;
	bh=YSwnjXOnBcp4QJLJEzKW9oTdc+d1XGO2LhWgVtjnxzQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tTnF4BE8IafZRbUe1PNg672heppZmg6Kkd+ASBvezxJMtWQ8v+QK6cKswJJ/P2/mfHoCVo0YyuCeno17DlgBAsxuNHy0trBHp2/tonCPG9XXdCrhzXro/eYaQEEVoCinuAos8f2kAQjC0KwnardyoOgV8626mmBmDhRtUnHLuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHsBg40O; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef114d8346so4519742a91.0
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 10:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738349056; x=1738953856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ljqvdoe66PsV0ko9USqCX1cFitPJRiLzefenHrRR1Us=;
        b=hHsBg40OnBcvhRpw6GmUU2m/tgxZ0AxlMmbxDfH6So23Rd9yAqdXF8M7lCtrqs0ymt
         ERa21kxdm3SMfgjYrFV3oFtiAAZ4FDJhb/rI+CmPWd0kaYYnT4niR/iapr5fchLipjh2
         LtwoBqogISIa73Me9LGb0rn/z2AMpdqh6r6HHfSbkyiVXR3dgRUHOKSpPTVAruy1IgpR
         PLFXDBfrxaMV775N+ZmlWUqCxbbUJrnwbcpRCYuPP74Rzt65W9fojNEl6hUkfcQKRQHS
         7qhL5ZV4QudWa1jwQWuquO9YFykstGjWL83v25DnuYuwXcG3Uf9alkqaqlyAGT5XmHGH
         RAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738349056; x=1738953856;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljqvdoe66PsV0ko9USqCX1cFitPJRiLzefenHrRR1Us=;
        b=NHKQBEXud1URlqNk5upLLMTVJJhle+9X54Lb/o2nc703zawlz9HFGgCMS3v9dtq7Cq
         B7SMKxXyXXRt8Atza+7gatzCB0b2lzE964cnTG8XOEZNN5PIBMtMdg5tfF9yyznbz/No
         Cw5wP8KsaUGtUutCI5q71Qc3tf0KyVR3WSnXS00bnXC0sHW3U4HfE7XdFuMdzBH+i3ms
         hyUhfoxpysb8rHXdTeg0doWhJ1W0l5wkgJ4EpbzTUxpcoDzVQ3SxfYnYAHgBJ5B0Mf3R
         yvARfBHx4gqt8rK1X/eCw9RH+nYjvPR/8esR2CBDz83Q2H83J3eR7xI3f/Z1+fm4YuOl
         3HMA==
X-Forwarded-Encrypted: i=1; AJvYcCWU5frzocaWyX/G990joR/OUNZSlEUPJeRGNfA1/q1H4j9f1LarApZ7qA2f1P1HHmFPBqJhoJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDWj9TzQ1VXuxoNJzASuEKXT4Zf/9/LBrxP9XtEbMkW+NqfOo
	DP12lsAZmcYL5UBbHtO79kW33ExOAbkPAV485TfLoKqK4clfkjFoPPyljibkN2zFTvCH6VzOOU6
	+oC/gcf+cqw==
X-Google-Smtp-Source: AGHT+IF+uYFJf6336pW4NcaKvfIFPem3UA+dJK9i/dockjZWIM7szv9chSDIgoK3n6FFScQsadqVvG+86ZmScw==
X-Received: from pjbsy8.prod.google.com ([2002:a17:90b:2d08:b0:2f5:5240:4f0f])
 (user=ipylypiv job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:37ce:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f83acb10e5mr15208961a91.34.1738349056642;
 Fri, 31 Jan 2025 10:44:16 -0800 (PST)
Date: Fri, 31 Jan 2025 10:44:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131184408.859579-1-ipylypiv@google.com>
Subject: [PATCH v2] scsi: core: Do not retry I/Os during depopulation
From: Igor Pylypiv <ipylypiv@google.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Douglas Gilbert <dgilbert@interlog.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fail I/Os instead of retry to prevent user space processes from being
blocked on the I/O completion for several minutes.

Retrying I/Os during "depopulation in progress" or "depopulation restore
in progress" results in a continuous retry loop until the depopulation
completes or until the I/O retry loop is aborted due to a timeout by
the scsi_cmd_runtime_exceeced().

Depopulation is slow and can take 24+ hours to complete on 20+ TB HDDs.
Most I/Os in the depopulation retry loop end up taking several minutes
before returning the failure to user space.

Cc: <stable@vger.kernel.org> # 4.18.x: 2bbeb8d scsi: core: Handle depopulation and restoration in progress
Cc: <stable@vger.kernel.org> # 4.18.x
Fixes: e37c7d9a0341 ("scsi: core: sanitize++ in progress")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

Changes in v2:
- Added Fixes: and Cc: stable tags.

 drivers/scsi/scsi_lib.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e7ea1f04164a..3ab4c958da45 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -872,13 +872,18 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 				case 0x1a: /* start stop unit in progress */
 				case 0x1b: /* sanitize in progress */
 				case 0x1d: /* configuration in progress */
-				case 0x24: /* depopulation in progress */
-				case 0x25: /* depopulation restore in progress */
 					action = ACTION_DELAYED_RETRY;
 					break;
 				case 0x0a: /* ALUA state transition */
 					action = ACTION_DELAYED_REPREP;
 					break;
+				/*
+				 * Depopulation might take many hours,
+				 * thus it is not worthwhile to retry.
+				 */
+				case 0x24: /* depopulation in progress */
+				case 0x25: /* depopulation restore in progress */
+					fallthrough;
 				default:
 					action = ACTION_FAIL;
 					break;
-- 
2.48.1.362.g079036d154-goog



Return-Path: <stable+bounces-238210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIv6NP/532ntbAAAu9opvQ
	(envelope-from <stable+bounces-238210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:50:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57139407B69
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A33E30C33DC
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C1838C2C8;
	Wed, 15 Apr 2026 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DhTGujyu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938E387569
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286148; cv=none; b=oMWWtBFVUV1A+BJxnwMP027i0p3a47TKg7/4H0ksspt7oOJm4im0W/WVfx29OaMrCV+HEOgxSZ7E7o8cWV1FZ8ESNTk1QQHjX4RQp2KjgmqijaPOZ7U8qXpS9s9yUY4Srn6OIZfp1rtLOSvrTEJQVoTDAYNe8b2r1rC25ANaypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286148; c=relaxed/simple;
	bh=jaHsYdGbpYEYbhaKRJDxVaFvTJCn06yxrg2fJlh+JU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqc63nqoMRzHbA6uFRTlLkUd2KLstkdFfVxnV5QjFS0rs8BlePWpgpy/sF/jpD/ARlQ9zkDilK6DGJ4K+E70N+o7Pvx5P0q1PpnkuccGJC2OuE5MWdN/8YEN9pW5DJoW/jQG3J2KOJcLQKDRC2hRRxd7vv15N80XUaUd9V1WMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DhTGujyu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso40391285e9.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776286145; x=1776890945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUcXYrAHaFcSZpGG6Or5FD6LmBv6L/glEjP9yZLQ6B4=;
        b=DhTGujyuwfKiK1pVz3Rhe/Y4mVw2moOtSuBL7h1xGW+nS96sNBU+YEibYLIS177txH
         cUM2oXdUjjB6XlhYjra5bGWtrVvBRpjTHCj4BiekJZMB6Yiu2JEmdp8ER/MEF8d9bV86
         nZvCCKLANx/LA6NwWK8YMUE+/qTHx/VUPtrdVDy81bKh1frcDs+7a7LCiv0St21fHWAR
         tAIeXECUYs01ZT+FwE1PsRe0vPhlaqQXAWZoMc1IJKLlJ37plmFDtNkFESRUrO2eCY8o
         cM6gMFWRVGHvB9xqoFVXBcirAjjs02DkMTzvgM1XIB0wfpjWqfJ1QRbHwM48bQTZhIBk
         zywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286145; x=1776890945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zUcXYrAHaFcSZpGG6Or5FD6LmBv6L/glEjP9yZLQ6B4=;
        b=AfLMj/GiwyUXKCZz2dfsANeZzI6kqun/9Z9bfQCYaHEZOa6aeS9QdcFJk1DyZMshpP
         2KpRQbAmcEQUQIH4FIn8h+MCarc7xP4TojIAEg/Izr8vYRmc8FEHYkqpGoFJfqf5Eiyn
         g/lkuN/hb4td8S9fKf0++7/+UnLHV7320OVPAUcaS2txxROYRVD7QgzOg/MpcjQqkaIf
         lCr1RFoQBlARIB6c84nZ3+oxf8M/v6Fema+pBb9wnSsG0KI48fLZdWzGQCG1AM9U/GfA
         XqAJI7Ax5DbLSwMecjtGUJK6GbZTlrEQFbFmifiN3jX+jwoc/sIL48cd1gwh65uAAMLI
         1Ang==
X-Forwarded-Encrypted: i=1; AFNElJ+SxEDwk7oOp9AQ8vnNRN2w0ftzVaoEycjAT1PV8Ubp9cRscldoxbCgkBEuAdc5bgop9xai0A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUhbsD+yL53ofMn+S0dz74JBNbG2EJT8R4WCeUMFe5vP7RHv4
	ExcygZFhP9wuiNu1lceg2/U6rXAyKKAReoDGG2OXXX+7TkOTbelT12W/VBHNKX/LrMhKjBbf9Fy
	LEtUzW/0=
X-Gm-Gg: AeBDieusn/BoDsuDO80XkTf0JTbhaUXT5iFuHDnON/MkLMCiYLTIp9ZXPQSwT9+flZI
	JeW7hgSfvwfVz2htVYnvUaRWf9iTgAGI+IVATabuf3LP/SmR/HzWCMU+2pP1PReSZkvzyrRK4ad
	kRmR+PrlcW5YyWQ8iGoqUAdYI1C4/kY9e7vzFAs3jhxkW7JXaTi2IAS8Vx1AznKZG3xmEOK2M9V
	iVEw5x1VQAUskp96W8hJKwUAZBVfMG6yhesWQeW3BSWjnOdwBSAZEiv2YDMuVcS0GBLTlabhPjS
	OHOvqZc9hnd3qzkxjFIxFny7FSc8Cq1EPclscvWUWWppTtt2DWQtRWyAXrIpU70ebR0KUQzKkzj
	F4sLeqPyZ7LWkATv8puSmQ8gFN1yzjAxLI/T8FAPsdSfmc9/lrC6cqI44bmsDXS7TFpYl8+zpNm
	Gc6/g3DgikRllioj6zZdXU+JDLQTvFGFV6PgI7b3QB/E8xm/l7CIlA2Sf6WIRmQfCd6a1IgRQYB
	FFctc/1cCUu1r4PGgCKm2lg
X-Received: by 2002:a05:600c:460a:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-488e00fdbc3mr152534465e9.22.1776286145008;
        Wed, 15 Apr 2026 13:49:05 -0700 (PDT)
Received: from localhost (p200300de374a06005c73df0aad605173.dip0.t-ipconnect.de. [2003:de:374a:600:5c73:df0a:ad60:5173])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488f1e945d0sm92777675e9.12.2026.04.15.13.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 13:49:04 -0700 (PDT)
From: Martin Wilck <martin.wilck@suse.com>
X-Google-Original-From: Martin Wilck <mwilck@suse.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Don Brace <don.brace@microchip.com>
Cc: linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Lee Duncan <lduncan@suse.com>,
	Martin Wilck <mwilck@suse.com>,
	storagedev@microchip.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] scsi: smartpqi: use shost_to_hba() in pqi_scan_finished()
Date: Wed, 15 Apr 2026 22:48:49 +0200
Message-ID: <20260415204850.799431-2-mwilck@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415204850.799431-1-mwilck@suse.com>
References: <20260415204850.799431-1-mwilck@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238210-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.wilck@suse.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 57139407B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

shost_to_hba() is used everywhere except to obtain pqi_ctrl_info
from shosti, except in pqi_scan_finished(), where shost_priv() is used.
This causes one pointer dereference to be missed, as shost->hostdata
is a pointer in smartpqi. Fix it.

Fixes: 6c223761eb54 ("smartpqi: initial commit of Microsemi smartpqi driver")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Cc: Don Brace <don.brace@microchip.com>
Cc: storagedev@microchip.com
Cc: stable@vger.kernel.org
---
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index b4ed991..65ff509 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2642,7 +2642,7 @@ static int pqi_scan_finished(struct Scsi_Host *shost,
 {
 	struct pqi_ctrl_info *ctrl_info;
 
-	ctrl_info = shost_priv(shost);
+	ctrl_info = shost_to_hba(shost);
 
 	return !mutex_is_locked(&ctrl_info->scan_mutex);
 }
-- 
2.51.0



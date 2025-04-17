Return-Path: <stable+bounces-133507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F3AA925F1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604F23B0DC0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385272571BA;
	Thu, 17 Apr 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LoDl3tm9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2291EB1BF;
	Thu, 17 Apr 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913286; cv=none; b=A8AXWWVM6SO6zjQsn2mufxhDw4OllOSvb1F0rKfSJqJxv9lYLAUXDiAxR7vDKBi/eo1yrnjDmqHpvE5GCT6dcP8ubikD+Jo5fEYntnBKjZM6HGznvJsxB4Jy1mrlFP1NcUGsGhckYuo4o4DQ4DngdCjLVAuO1rVGv7DxQ3ocbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913286; c=relaxed/simple;
	bh=29pCH2AzR/n1fJLegB096NaN8zzAiwSiQFlNH2BD57w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCcfFSm5xI7XBJlFbfFHldbo3p+bOhOqZF5txVlT/po8fTS9UMedJbHoeZnxQDiXMm65VsnFaNfOte2ngs8KApJkpVMxtapvchqeut2MchLh/I0F0eNG7PM8fCHEcwdZd/MAW4W/fdLQk6uoa6s84sE6J9n+Oc1LbG7bTrwcqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LoDl3tm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D50C4CEE4;
	Thu, 17 Apr 2025 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913285;
	bh=29pCH2AzR/n1fJLegB096NaN8zzAiwSiQFlNH2BD57w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LoDl3tm9HGAjpEGAF0oRpWfB9HalQiFT/XgGIohhaXAew06pRonN8ADRK5BWERC10
	 uy6z2Q6upJJi0tV2veqWfRyKg7OAUCEsxAyTrZJyC/EcXwI7T3c3KgHEY1xi3G8shl
	 YliwekqIAy3a5wAcKxFHKNlouY2U0NSxBB6DxZGk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marco Patalano <mpatalan@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.14 288/449] scsi: lpfc: Restore clearing of NLP_UNREG_INP in ndlp->nlp_flag
Date: Thu, 17 Apr 2025 19:49:36 +0200
Message-ID: <20250417175129.673250930@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ewan D. Milne <emilne@redhat.com>

commit 040492ac2578b66d3ff4dcefb4f56811634de53d upstream.

Commit 32566a6f1ae5 ("scsi: lpfc: Remove NLP_RELEASE_RPI flag from nodelist
structure") introduced a regression with SLI-3 adapters (e.g. LPe12000 8Gb)
where a Link Down / Link Up such as caused by disabling an host FC switch
port would result in the devices remaining in the transport-offline state
and multipath reporting them as failed.  This problem was not seen with
newer SLI-4 adapters.

The problem was caused by portions of the patch which removed the functions
__lpfc_sli_rpi_release() and lpfc_sli_rpi_release() and all their callers.
This was presumably because with the removal of the NLP_RELEASE_RPI flag
there was no need to free the rpi.

However, __lpfc_sli_rpi_release() and lpfc_sli_rpi_release() which calls it
reset the NLP_UNREG_INP flag. And, lpfc_sli_def_mbox_cmpl() has a path
where __lpfc_sli_rpi_release() was called in a particular case where
NLP_UNREG_INP was not otherwise cleared because of other conditions.

Restoring the else clause of this conditional and simply clearing the
NLP_UNREG_INP flag appears to resolve the problem with SLI-3 adapters.  It
should be noted that the code path in question is not specific to SLI-3,
but there are other SLI-4 code paths which may have masked the issue.

Fixes: 32566a6f1ae5 ("scsi: lpfc: Remove NLP_RELEASE_RPI flag from nodelist structure")
Cc: stable@vger.kernel.org
Tested-by: Marco Patalano <mpatalan@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Link: https://lore.kernel.org/r/20250317163731.356873-1-emilne@redhat.com
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2923,6 +2923,8 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *
 				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				ndlp->nlp_defer_did = NLP_EVT_NOTHING_PENDING;
 				lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
+			} else {
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 			}
 
 			/* The unreg_login mailbox is complete and had a




Return-Path: <stable+bounces-6352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B780DA3B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278AB1F21CD7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E0524C1;
	Mon, 11 Dec 2023 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2i0yHVAG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40108E548;
	Mon, 11 Dec 2023 18:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E6C433C7;
	Mon, 11 Dec 2023 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321197;
	bh=n00xeMBRa/TBnwFG4n+flDxQBj7mdiellIv/ZxvQdlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2i0yHVAGw+MvrUFUOnTuWVfpQiNxmxc0uWrVou/vHLJs4JYgQWVMDGGyLlB1H2hKn
	 vDuBOY2DfWI+CGz5CHZukvxAY8F2J8AM3MTGoYFRCDW82ePF93sRzFtrDUXvBPjLFS
	 b7uwN1afOo/a+FWqcyf6+X/5eX1CqerRBA6RY8Vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nico Boehr <nrb@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH 5.15 133/141] KVM: s390/mm: Properly reset no-dat
Date: Mon, 11 Dec 2023 19:23:12 +0100
Message-ID: <20231211182032.328097584@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

commit 27072b8e18a73ffeffb1c140939023915a35134b upstream.

When the CMMA state needs to be reset, the no-dat bit also needs to be
reset. Failure to do so could cause issues in the guest, since the
guest expects the bit to be cleared after a reset.

Cc: <stable@vger.kernel.org>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Message-ID: <20231109123624.37314-1-imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/mm/pgtable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -731,7 +731,7 @@ void ptep_zap_unused(struct mm_struct *m
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
-		pgste_val(pgste) &= ~_PGSTE_GPS_USAGE_MASK;
+		pgste_val(pgste) &= ~(_PGSTE_GPS_USAGE_MASK | _PGSTE_GPS_NODAT);
 	pgste_set_unlock(ptep, pgste);
 	preempt_enable();
 }




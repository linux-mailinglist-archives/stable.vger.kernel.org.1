Return-Path: <stable+bounces-6019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAAF80D859
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93A41F21AF8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB9951C3B;
	Mon, 11 Dec 2023 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q7fjb9YH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBDAFC06;
	Mon, 11 Dec 2023 18:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B310C433C8;
	Mon, 11 Dec 2023 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320293;
	bh=REF7HPdTexmT3MUzNXhiiG5GUac8PEnIU6LBhIl/lYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7fjb9YHjWbzbwpx4eR3OvvX7k+/ECwoSAI+Xu6a7RF/zZDkAPQmsgY+nQVErbZoa
	 enzzMQkxxRAuYCOpZ0qz2f4qPXXiaRQ4y5L+u5nM2V6TmZ7nc+FU1a1fAM5fOSDRqQ
	 wXexd6I+D+Cs2bpnLn5A9oBR34V2Y+jPayJWFyRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nico Boehr <nrb@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH 5.4 55/67] KVM: s390/mm: Properly reset no-dat
Date: Mon, 11 Dec 2023 19:22:39 +0100
Message-ID: <20231211182017.344117116@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -699,7 +699,7 @@ void ptep_zap_unused(struct mm_struct *m
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
-		pgste_val(pgste) &= ~_PGSTE_GPS_USAGE_MASK;
+		pgste_val(pgste) &= ~(_PGSTE_GPS_USAGE_MASK | _PGSTE_GPS_NODAT);
 	pgste_set_unlock(ptep, pgste);
 	preempt_enable();
 }




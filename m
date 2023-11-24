Return-Path: <stable+bounces-1703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E47F80F6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DAA282626
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634635F04;
	Fri, 24 Nov 2023 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ADfIi3yb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F72321AD;
	Fri, 24 Nov 2023 18:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8751CC433C8;
	Fri, 24 Nov 2023 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852064;
	bh=Ci99OSgqiEYzMsUNSBZyJxIMRbP49uEuD+S/IvuMEoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADfIi3yb8DZQREDvKWE5ZQziWMRG1xe8d0fcV7ig2qJN78QICOFiccNVy/kB6hriR
	 n5Sn/9WjGQLmrqpGcgkXi3CsvaCL7LepLsHEV4aX3N46S1CORU6qc6Xul0m7G5hj+N
	 vfY/K7JW1+lzd90xu/oj0iZK7eVhSfu5lfUGxfg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 206/372] parisc/pdc: Add width field to struct pdc_model
Date: Fri, 24 Nov 2023 17:49:53 +0000
Message-ID: <20231124172017.330527492@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 6240553b52c475d9fc9674de0521b77e692f3764 upstream.

PDC2.0 specifies the additional PSW-bit field.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/uapi/asm/pdc.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/parisc/include/uapi/asm/pdc.h
+++ b/arch/parisc/include/uapi/asm/pdc.h
@@ -472,6 +472,7 @@ struct pdc_model {		/* for PDC_MODEL */
 	unsigned long arch_rev;
 	unsigned long pot_key;
 	unsigned long curr_key;
+	unsigned long width;	/* default of PSW_W bit (1=enabled) */
 };
 
 struct pdc_cache_cf {		/* for PDC_CACHE  (I/D-caches) */




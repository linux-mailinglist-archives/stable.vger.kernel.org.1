Return-Path: <stable+bounces-50890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FFB906D50
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE5AB268C0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F051459FE;
	Thu, 13 Jun 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvJf4++o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D43144D16;
	Thu, 13 Jun 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279687; cv=none; b=jWYPWHiN1ge+0qNoTF8c3l9nMyKBMxbI+MpTYoeMrVYjfEP3YB5I/Gj19KXoqq1qtSja+ePeHZCvtpOqAFZn3o6nX9EOfEMEx0a7Cp0RHwLAieGcA7KHz/zAAM+J+CBR5bthNR/lIdsbUVBKuH5Rh68xS0BvCjmrS6D9gMIC6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279687; c=relaxed/simple;
	bh=j9Q8nI18Jgwxz8PTFNR6QPTk6WxrYnm2RVVbqdl6gGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n98z4TMcJoiSxeEEtRXrB824qalg8RwaXg5JM3REGLz0DRrXkkdGXOr8WJNNc8gRxUxraHOAWcbODVoWci7AeqIVgtYzQBMsrjeSx+smTglAB/GWezQK727wfchfZM8cwYRH9LBEEZKwqJQ0BHNAJW/YXfHigNpsaVbGJFIACkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvJf4++o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C43AC2BBFC;
	Thu, 13 Jun 2024 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279687;
	bh=j9Q8nI18Jgwxz8PTFNR6QPTk6WxrYnm2RVVbqdl6gGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvJf4++oUhdXQlFg/UZxtLoeCaUH6SCKcPXU5l8aKO7X5wqwE6xr8yCq+Kd37PwM1
	 dc1GPJqQS3CqN7sXYXA3IG6rbE5bhgyDOyJZemd6/7Xs6gFvzCatvyCx4Re4yg4VlZ
	 mphdHJI7qba9tViCC8bzKxZFdgJdMtH64fV7wF2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>
Subject: [PATCH 6.9 129/157] s390/cpacf: Make use of invalid opcode produce a link error
Date: Thu, 13 Jun 2024 13:34:14 +0200
Message-ID: <20240613113232.400642203@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

commit 32e8bd6423fc127d2b37bdcf804fd76af3bbec79 upstream.

Instead of calling BUG() at runtime introduce and use a prototype for a
non-existing function to produce a link error during compile when a not
supported opcode is used with the __cpacf_query() or __cpacf_check_opcode()
inline functions.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/cpacf.h |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -166,6 +166,13 @@
 
 typedef struct { unsigned char bytes[16]; } cpacf_mask_t;
 
+/*
+ * Prototype for a not existing function to produce a link
+ * error if __cpacf_query() or __cpacf_check_opcode() is used
+ * with an invalid compile time const opcode.
+ */
+void __cpacf_bad_opcode(void);
+
 static __always_inline void __cpacf_query_rre(u32 opc, u8 r1, u8 r2,
 					      cpacf_mask_t *mask)
 {
@@ -237,7 +244,7 @@ static __always_inline void __cpacf_quer
 		__cpacf_query_rre(CPACF_PRNO, 2, 4, mask);
 		break;
 	default:
-		BUG();
+		__cpacf_bad_opcode();
 	}
 }
 
@@ -262,7 +269,8 @@ static __always_inline int __cpacf_check
 	case CPACF_KMA:
 		return test_facility(146);	/* check for MSA8 */
 	default:
-		BUG();
+		__cpacf_bad_opcode();
+		return 0;
 	}
 }
 




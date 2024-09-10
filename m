Return-Path: <stable+bounces-75167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44818973331
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1ADF1F23A26
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E119ABCB;
	Tue, 10 Sep 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pwYMI+Rh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAC8198A3F;
	Tue, 10 Sep 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963943; cv=none; b=h4Y2zIrNMrYfVnehL/t4ePmzd4rBurkb9yjCi8MkCGjO7gxjfqsLL2YSMnTAV1ADJZTc8TcI5vGokC+MBPVZU6K+vWvkmJFXZ7q7P5BpBEZa7eGGf3vKY/HLw+QtxOvpcUQbQB2NKDZbJ8A9O9DZ+0S2IAQQuxkfAGreLjdn4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963943; c=relaxed/simple;
	bh=IZt4u1tbVB03PwmK0nDs5lp/oZ0OIxBFj7MXkTqkb8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmZyjyTOP43mCiU7exrgt/1X75abDxBnKXXskpJWdQQzNzVkbT3VPuIa0gy7s1D5CGMmFWDydvr6iMBnchb5wYCbFBG4C4NDw6xX6O9mSZlxxdV5gA1BEBkVWoFgE4hLuXHELbM2HxWip7s0V8lvXSn9MDHB+wS+ge0atnr3QCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pwYMI+Rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38165C4CEC3;
	Tue, 10 Sep 2024 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963943;
	bh=IZt4u1tbVB03PwmK0nDs5lp/oZ0OIxBFj7MXkTqkb8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwYMI+RhecrORy9UhmqI/sCkEw6bTymtd3ZUEkSfLRB3KbKVl+5UPR6lKyoka2zbi
	 AQYSAP7cHS774Q11lUvL4G/+bfkkwh+E8J0UzMhW3PGSGIi1GTFFXaDwUFGVbaq/Lb
	 sORw9p2wHYxEcYyT/qbCZzZxHw6EYY7YDwPijq2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.6 015/269] x86/tdx: Fix data leak in mmio_read()
Date: Tue, 10 Sep 2024 11:30:02 +0200
Message-ID: <20240910092608.801798303@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit b6fb565a2d15277896583d471b21bc14a0c99661 upstream.

The mmio_read() function makes a TDVMCALL to retrieve MMIO data for an
address from the VMM.

Sean noticed that mmio_read() unintentionally exposes the value of an
initialized variable (val) on the stack to the VMM.

This variable is only needed as an output value. It did not need to be
passed to the VMM in the first place.

Do not send the original value of *val to the VMM.

[ dhansen: clarify what 'val' is used for. ]

Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240826125304.1566719-1-kirill.shutemov%40linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/coco/tdx/tdx.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -362,7 +362,6 @@ static bool mmio_read(int size, unsigned
 		.r12 = size,
 		.r13 = EPT_READ,
 		.r14 = addr,
-		.r15 = *val,
 	};
 
 	if (__tdx_hypercall_ret(&args))




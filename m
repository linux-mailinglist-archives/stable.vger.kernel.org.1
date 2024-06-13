Return-Path: <stable+bounces-51947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9E1907273
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3EBB27184
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD10881ABE;
	Thu, 13 Jun 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kbVFvFnK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09717FD;
	Thu, 13 Jun 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282784; cv=none; b=EK07P2FeeMO8Du2G2bTTUIbLOgVlQj2VdhtrsTY9aEHloKhPAvQ0I22JEtA9quTNMS0PUF+1HftXnhIyM2SO+HHd5f9FgIiVokAu+CUXS4+yBSwHJ7GMkGw/P4t38C+vdWk9r6GYJsO69+QGwAhFhMh88CQBWW9pmK3AfpqPMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282784; c=relaxed/simple;
	bh=g/ovnwdE8hV3bBrG11MRzjmjE4lYNkemZpgToAjtwOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZqQfP/xAUt0f6XRvGpEwwh0JjQnsrKtg/AKB2rPnvZ3ygvxqmggA99lwA+3ZL9qE9J4fJ0qzU++VZfMyROpoCRAudwX9QdAgzO/gMpPdh9DX3783OsPz+5yy+jWAl1jcVjar8VSggBeuDbWTyi/a6rxphtwsNnXwm3imf8tGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kbVFvFnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DA2C2BBFC;
	Thu, 13 Jun 2024 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282784;
	bh=g/ovnwdE8hV3bBrG11MRzjmjE4lYNkemZpgToAjtwOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbVFvFnKigt6jdJx06/KZ1BmOw4f8YI5SrnHY0g52JgXdxVXEAzJ1ulIvH/JYt8HR
	 b2hWaiKzS3WWz81CCI/SqHgh6qOOGGhZ2989to2GYMevyt21/+YqndS+i+QO4lAIvQ
	 o6QQeTcUc7rXyd8KpXYP45ngCkwd+BLLuhs8j+fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Hartmayer <mhartmay@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5.15 395/402] s390/ap: Fix crash in AP internal function modify_bitmap()
Date: Thu, 13 Jun 2024 13:35:52 +0200
Message-ID: <20240613113317.563355952@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

From: Harald Freudenberger <freude@linux.ibm.com>

commit d4f9d5a99a3fd1b1c691b7a1a6f8f3f25f4116c9 upstream.

A system crash like this

  Failing address: 200000cb7df6f000 TEID: 200000cb7df6f403
  Fault in home space mode while using kernel ASCE.
  AS:00000002d71bc007 R3:00000003fe5b8007 S:000000011a446000 P:000000015660c13d
  Oops: 0038 ilc:3 [#1] PREEMPT SMP
  Modules linked in: mlx5_ib ...
  CPU: 8 PID: 7556 Comm: bash Not tainted 6.9.0-rc7 #8
  Hardware name: IBM 3931 A01 704 (LPAR)
  Krnl PSW : 0704e00180000000 0000014b75e7b606 (ap_parse_bitmap_str+0x10e/0x1f8)
  R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
  Krnl GPRS: 0000000000000001 ffffffffffffffc0 0000000000000001 00000048f96b75d3
  000000cb00000100 ffffffffffffffff ffffffffffffffff 000000cb7df6fce0
  000000cb7df6fce0 00000000ffffffff 000000000000002b 00000048ffffffff
  000003ff9b2dbc80 200000cb7df6fcd8 0000014bffffffc0 000000cb7df6fbc8
  Krnl Code: 0000014b75e7b5fc: a7840047            brc     8,0000014b75e7b68a
  0000014b75e7b600: 18b2                lr      %r11,%r2
  #0000014b75e7b602: a7f4000a            brc     15,0000014b75e7b616
  >0000014b75e7b606: eb22d00000e6        laog    %r2,%r2,0(%r13)
  0000014b75e7b60c: a7680001            lhi     %r6,1
  0000014b75e7b610: 187b                lr      %r7,%r11
  0000014b75e7b612: 84960021            brxh    %r9,%r6,0000014b75e7b654
  0000014b75e7b616: 18e9                lr      %r14,%r9
  Call Trace:
  [<0000014b75e7b606>] ap_parse_bitmap_str+0x10e/0x1f8
  ([<0000014b75e7b5dc>] ap_parse_bitmap_str+0xe4/0x1f8)
  [<0000014b75e7b758>] apmask_store+0x68/0x140
  [<0000014b75679196>] kernfs_fop_write_iter+0x14e/0x1e8
  [<0000014b75598524>] vfs_write+0x1b4/0x448
  [<0000014b7559894c>] ksys_write+0x74/0x100
  [<0000014b7618a440>] __do_syscall+0x268/0x328
  [<0000014b761a3558>] system_call+0x70/0x98
  INFO: lockdep is turned off.
  Last Breaking-Event-Address:
  [<0000014b75e7b636>] ap_parse_bitmap_str+0x13e/0x1f8
  Kernel panic - not syncing: Fatal exception: panic_on_oops

occured when /sys/bus/ap/a[pq]mask was updated with a relative mask value
(like +0x10-0x12,+60,-90) with one of the numeric values exceeding INT_MAX.

The fix is simple: use unsigned long values for the internal variables. The
correct checks are already in place in the function but a simple int for
the internal variables was used with the possibility to overflow.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/ap_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1031,7 +1031,7 @@ static int hex2bitmap(const char *str, u
  */
 static int modify_bitmap(const char *str, unsigned long *bitmap, int bits)
 {
-	int a, i, z;
+	unsigned long a, i, z;
 	char *np, sign;
 
 	/* bits needs to be a multiple of 8 */




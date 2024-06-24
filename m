Return-Path: <stable+bounces-55038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734AC91519A
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4ACB23BC1
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C7C19CCF4;
	Mon, 24 Jun 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GCW/c1Vt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAB19ADBE
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241855; cv=none; b=DWu5Rv2yR1snnI00FqcmBzZD9Vqkiinb3LmxMysbFqD6jVmQFY4easGVDMysLrVn1hXSBHHBPZW+V5E9EBBgOQ3DQgRMHzYvTK0CqlWuq+XPM9KQCA4F/ssWBYLnTpD5W2Bb91g86cCW4f4aHybsSaPBjbtfkLQCUKPAdJE7mA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241855; c=relaxed/simple;
	bh=LjBWrXuTobKe3REZ5gt3jkBuzNXm9UZIIWTcchGH0q0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Oy4Y6fVW1muyExP+l6ntlJdES8TvqlTh8ymAfHYvD8VXL+nW2t/kT+QYGSmq6pKcrntfmEy3A18Cy2fwOYa2C7uqmap9mwK/0S0X51vn1yjaRgzHngHeG+kfpRWdzEAPNaP8LWK/HzQHZ/Wf1fXKUMrt2ztiBgdVLsP2wJqXvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GCW/c1Vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66312C2BBFC;
	Mon, 24 Jun 2024 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241854;
	bh=LjBWrXuTobKe3REZ5gt3jkBuzNXm9UZIIWTcchGH0q0=;
	h=Subject:To:Cc:From:Date:From;
	b=GCW/c1VtE2HmCKnCrXj+AmsVxyYrksTxsYYPhm23Vdzi2WpNwgtZFXLqIKVaJVsZJ
	 mmMofbmNr5+tmnMco7XV57L0VLnjDJ9YNaYRqR+GfrQYB7PcLi7MKojA++yYtCjecG
	 BgvReYs6M0RvdLx4p2vj32JbPrxYA8FChl5mUcfw=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Remove an unneeded semicolon" failed to apply to 6.9-stable tree
To: yang.lee@linux.alibaba.com,abaci@linux.alibaba.com,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:10:52 +0200
Message-ID: <2024062451-unsalted-unvalued-9498@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x d0a1c07739e1b7f74683fe061545669156d102f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062451-unsalted-unvalued-9498@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d0a1c07739e1b7f74683fe061545669156d102f2 Mon Sep 17 00:00:00 2001
From: Yang Li <yang.lee@linux.alibaba.com>
Date: Fri, 21 Jun 2024 10:18:40 +0800
Subject: [PATCH] LoongArch: KVM: Remove an unneeded semicolon

Remove an unneeded semicolon to avoid build warnings:

./arch/loongarch/kvm/exit.c:764:2-3: Unneeded semicolon

Cc: stable@vger.kernel.org
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9343
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index c86e099af5ca..a68573e091c0 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -761,7 +761,7 @@ static void kvm_handle_service(struct kvm_vcpu *vcpu)
 	default:
 		ret = KVM_HCALL_INVALID_CODE;
 		break;
-	};
+	}
 
 	kvm_write_reg(vcpu, LOONGARCH_GPR_A0, ret);
 }



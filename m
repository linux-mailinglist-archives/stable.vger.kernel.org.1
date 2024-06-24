Return-Path: <stable+bounces-55039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16837915198
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73A71F217D8
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437219ADBE;
	Mon, 24 Jun 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QpQ7xUkz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984E19CD1E
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241863; cv=none; b=cG/zXG5koOyORQNyb+eTrjmzKh3YXeeLcBHwfymZvIo9BpIF9YkG0/SEomGi6aN4Uh2ecy6J7LUog58OL5M3XzjTcyJ3t29sZrUwf88fWNs4GovHMmauQPMf+sbukULIBTN9q0bBFD4PIEE7i/JXGQa8dFB67r1XqtICf1tIqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241863; c=relaxed/simple;
	bh=FNCVI+9v5wWP6SBgGUCIQRFKbwyM/NAl2QVvn88WcRA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=orwGT4p7f3sOSSKcHUs5xjP7vPAY9SiF3rFdPSArkIIDUuOnSrAtbmntnDnIGu0meQsyrxOZ5kQEo+088u89SIB09JjzkFrt5qUpHyWVK/K4k5Jz6j1+IeFv8KPb6SuzUz6d40h5v/i/9NQpufPEudRY7nXPnwn2ZGrigJK9cUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QpQ7xUkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016CFC2BBFC;
	Mon, 24 Jun 2024 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241863;
	bh=FNCVI+9v5wWP6SBgGUCIQRFKbwyM/NAl2QVvn88WcRA=;
	h=Subject:To:Cc:From:Date:From;
	b=QpQ7xUkzlN88KO3BNzNqzp4BkXHehWf5QLZjWllauJ5D4RnB7fiiTtUtt2wvLw5sl
	 wEoOclZQMyqmpWp7B9NTF7NlSngPEgFejfy3rEynAEy7diHMrq3lE/u7P+lwMR3DCS
	 VryFGBPyJCdi6pOUkIFx9Dsjjwtb+hVB1u8SbMkk=
Subject: FAILED: patch "[PATCH] LoongArch: KVM: Remove an unneeded semicolon" failed to apply to 6.6-stable tree
To: yang.lee@linux.alibaba.com,abaci@linux.alibaba.com,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:10:52 +0200
Message-ID: <2024062452-savage-commotion-3ab2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d0a1c07739e1b7f74683fe061545669156d102f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062452-savage-commotion-3ab2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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



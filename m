Return-Path: <stable+bounces-138873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADFAA1A2E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33C818875D2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D8240611;
	Tue, 29 Apr 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHjUN3wc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AE155A4E;
	Tue, 29 Apr 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950622; cv=none; b=jafGydWz4PxoqPamOxlg/4JE6lUrszbmqIWaS/amQpGwU0v/PqEITBJaX+p2s/Xg2ee5Kji95HsyVLnqWKwOI+hrtmq6IAsquT1Kg84wrXi+IDKrxMwWuo+yiOSd2hUP3qsHxKW+xE3a6KD9ZbH5r0Vr63iezY1AyQThEPv0n2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950622; c=relaxed/simple;
	bh=WsJLiDjIBelLMhbmqcXpof/AfiS8WJKjmV6Nl3grcbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCAhZNYqJk9vI1SUBLab9RceiZB7BwIs5q4lMGxnv9id4emhSH3coqM+kTuPeWu8mHQG72hjLpUXZ/6OmzFWxCrujldELL5YBStBP2uo7dgpMrKvfI1cJHniUTi6S0pDWM/wtB2fEAWW1Rta29qD1znA4DoG0+ArX293dxm/uNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHjUN3wc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966B2C4CEE3;
	Tue, 29 Apr 2025 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950622;
	bh=WsJLiDjIBelLMhbmqcXpof/AfiS8WJKjmV6Nl3grcbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHjUN3wclWe/bUPNutY3JK8fjQdwXPzUfuPmfnBxbiSNZ218DLcCOyRVu20WrsY/4
	 Zdl+MuFs7jjbz+DYgox22KUoED+LxMWHjBj/8hSijEm0nxD0p9GWFAYeew3HhVRgJp
	 kWYzGsWV9Wvqg8fgYijdpmsac77IWIvTG01QiRzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Michael Mueller <mimu@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 153/204] KVM: s390: Dont use %pK through tracepoints
Date: Tue, 29 Apr 2025 18:44:01 +0200
Message-ID: <20250429161105.679371479@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 6c9567e0850be2f0f94ab64fa6512413fd1a1eb1 ]

Restricted pointers ("%pK") are not meant to be used through TP_format().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Michael Mueller <mimu@linux.ibm.com>
Link: https://lore.kernel.org/r/20250217-restricted-pointers-s390-v1-1-0e4ace75d8aa@linutronix.de
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20250217-restricted-pointers-s390-v1-1-0e4ace75d8aa@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/trace-s390.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 6f0209d45164f..9c5f546a2e1a3 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -56,7 +56,7 @@ TRACE_EVENT(kvm_s390_create_vcpu,
 		    __entry->sie_block = sie_block;
 		    ),
 
-	    TP_printk("create cpu %d at 0x%pK, sie block at 0x%pK",
+	    TP_printk("create cpu %d at 0x%p, sie block at 0x%p",
 		      __entry->id, __entry->vcpu, __entry->sie_block)
 	);
 
@@ -255,7 +255,7 @@ TRACE_EVENT(kvm_s390_enable_css,
 		    __entry->kvm = kvm;
 		    ),
 
-	    TP_printk("enabling channel I/O support (kvm @ %pK)\n",
+	    TP_printk("enabling channel I/O support (kvm @ %p)\n",
 		      __entry->kvm)
 	);
 
-- 
2.39.5





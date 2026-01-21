Return-Path: <stable+bounces-211108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKRcMaAucWmcfAAAu9opvQ
	(envelope-from <stable+bounces-211108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:53:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4ED5C9B0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A0EFAA5CD2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCD396D17;
	Wed, 21 Jan 2026 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVOlAx7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EE28506C;
	Wed, 21 Jan 2026 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020464; cv=none; b=L3wU3sNvEW2MPadgBIwY1NQ3/85v1ZiBINJbHvRhbgrwdVTkvGtUXwdNy+p0U14ZarPFH/AWomdqxFwnLCQxoq3MQ8mChvzafvXymAvaISjNYCk7kThbmpTSw8XoVviwJjzPdAGFl/+hsMt+UOISXiR9GtlFxA+bv3i1ver6O1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020464; c=relaxed/simple;
	bh=LOWCw9MzjKKPrio+54NOeuFbJ1MLJNEXm5HI6wNXhio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1n5jpqSbQmPZ0RNhhEZAp719qLPGU3tARgwfLPSFtsidDigDv1TZMvtMLY22KoKY3vwFdqHG+2AH5lmFZDGJt1yoFKJAvc06Wnvd5i2nqWgnNRav8co337Klfs0g0GRw3/Dmtk5ZcKY2DcuNDt8tMA7mmLS1GL6ObIDdMpV6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVOlAx7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1C1C4CEF1;
	Wed, 21 Jan 2026 18:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020464;
	bh=LOWCw9MzjKKPrio+54NOeuFbJ1MLJNEXm5HI6wNXhio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVOlAx7JCgoe/TirRBxS6Z9p5Pw9FnliOlyjDUx5ABJrME+jaqXQO8P0rhXfQOpK1
	 nSPUwYjT8dO5SvLFG0/egaYurKf3IjXZ/av+tbNY8Zwd62nfSDN4gHVMSeDUdWcTG0
	 yauOx5EIxhzNVbszowclr1toFoxnHAguKTczrzuI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Qiang Ma <maqianga@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 165/198] LoongArch: KVM: Fix kvm_device leak in kvm_ipi_destroy()
Date: Wed, 21 Jan 2026 19:16:33 +0100
Message-ID: <20260121181424.485176894@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211108-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,uniontech.com:email,loongson.cn:email]
X-Rspamd-Queue-Id: 2D4ED5C9B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiang Ma <maqianga@uniontech.com>

commit 0bf58cb7288a4d3de6d8ecbb3a65928a9362bf21 upstream.

In kvm_ioctl_create_device(), kvm_device has allocated memory,
kvm_device->destroy() seems to be supposed to free its kvm_device
struct, but kvm_ipi_destroy() is not currently doing this, that
would lead to a memory leak.

So, fix it.

Cc: stable@vger.kernel.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/intc/ipi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -459,6 +459,7 @@ static void kvm_ipi_destroy(struct kvm_d
 	ipi = kvm->arch.ipi;
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &ipi->device);
 	kfree(ipi);
+	kfree(dev);
 }
 
 static struct kvm_device_ops kvm_ipi_dev_ops = {




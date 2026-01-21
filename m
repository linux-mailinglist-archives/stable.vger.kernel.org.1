Return-Path: <stable+bounces-211106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFqWEKMycWlQfQAAu9opvQ
	(envelope-from <stable+bounces-211106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:10:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70C5CE05
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A17EC9CFF2E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44483AE711;
	Wed, 21 Jan 2026 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGznZ1Hq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBF2D97A2;
	Wed, 21 Jan 2026 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020458; cv=none; b=t9CGeNGgoUXmgrZHX+4TX5Dw+dGFwTUqzzdbdWQ4DoA2hl71LfqlIbWRHeEQ4h42i8gcx+pgVCesFIwTi0kVUlSW6HsZSm0X68sdYQJ5lRJpWXsOF/mHnBMhNrk5rPgejmAL/TDci3747utz0caNFH6m+ENrpKzLOtf0Yz7Ur6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020458; c=relaxed/simple;
	bh=0sAy9jZHsq1Qan1Z6bbZniMqj+bTC9BDueG8+BUYwTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC2pgqF1kH+5MrHkuPWTxA9VmssbxdY03eSnuQY97nMnJUj91yI8bQ7HYPL/iw77vWadf5FBuWlqqONmuvHnxAWOcVLcU1v4zY0rtILTLQ12mONKm46FYpGnU7nmv3z4Wx4WRvko288JOfE8uTK+ZkHHi3OAD1RoHKFwqveErWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zGznZ1Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7296C4CEF1;
	Wed, 21 Jan 2026 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020458;
	bh=0sAy9jZHsq1Qan1Z6bbZniMqj+bTC9BDueG8+BUYwTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zGznZ1HqD42dShTzEdRAlAOIPg7WRhN+YcrFCektIfcRWRqApzx/z45B/2+38MF8j
	 QUYpg9azMAscLmzxZ/+kGPvDLmiYJqL2rO+rAune48T1WPuz1YlRSuudvXGPlzH7KK
	 /Bd9TnICrs8L06I73/JnmOQCD3h+d/MArC0CjoGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Qiang Ma <maqianga@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 164/198] LoongArch: KVM: Fix kvm_device leak in kvm_eiointc_destroy()
Date: Wed, 21 Jan 2026 19:16:32 +0100
Message-ID: <20260121181424.450369012@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-211106-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,loongson.cn:email]
X-Rspamd-Queue-Id: 9F70C5CE05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiang Ma <maqianga@uniontech.com>

commit 7d8553fc75aefa7ec936af0cf8443ff90b51732e upstream.

In kvm_ioctl_create_device(), kvm_device has allocated memory,
kvm_device->destroy() seems to be supposed to free its kvm_device
struct, but kvm_eiointc_destroy() is not currently doing this, that
would lead to a memory leak.

So, fix it.

Cc: stable@vger.kernel.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/intc/eiointc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -679,6 +679,7 @@ static void kvm_eiointc_destroy(struct k
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device);
 	kvm_io_bus_unregister_dev(kvm, KVM_IOCSR_BUS, &eiointc->device_vext);
 	kfree(eiointc);
+	kfree(dev);
 }
 
 static struct kvm_device_ops kvm_eiointc_dev_ops = {




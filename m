Return-Path: <stable+bounces-246017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEJeA1JqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:58:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07352665D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9507C3173174
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC273E5A17;
	Tue, 12 May 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGcHCGa6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB03E5A0E;
	Tue, 12 May 2026 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608145; cv=none; b=RO6WQHr5n6N/WWqBIL8SdlnZj55Q9/l0SvwgoknbJ/fxPfk25lmKUquJwgTFKwycnv3CHKw7Mo4osx7qHtEP0Arrss1SrCYq6bdP/tva4FciejVZF7/j7OkgwXRDUWrMtQ40S2LRBeOrc0+KjYOhlrBcbo6YGPmJ6NcvjgFpohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608145; c=relaxed/simple;
	bh=A6gzWuuf66GzTDbvkqz+1ouMpmhInCmwRZ8gUL54NTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNCA2ZWAfG65HM9dv8N3orJKayzMvOKHOzXIGCHyIPQQaHuIeQExZtYOi9tbEjNAleNPmSAuKpSkdv3Mu1suehng49Yozj80egbO4gXGaUiM13nDewaxHvOJs4mC8c7fLDb9+5eGBvp2EwxlwhMljs1wZb8v3gn/x1VjS+hwHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGcHCGa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46578C2BCB0;
	Tue, 12 May 2026 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608144;
	bh=A6gzWuuf66GzTDbvkqz+1ouMpmhInCmwRZ8gUL54NTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGcHCGa6ZbLDaYgYSzwR5qDPHmj7qf1egC7iqAuwTERw9TZ8F/eGp1VvYoQRZ4D2m
	 4hUTNXt5FQ3bucXTRnBHaRBoiLEFRC7fqd8d2f+PuHME2OBNDI6YV4eFx6Ud+iIkN7
	 rqt4WEsNvzbykA4SrZQ9A8n5vLIzx8IKKtj1G0ZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Qiang Ma <maqianga@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 172/206] LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
Date: Tue, 12 May 2026 19:40:24 +0200
Message-ID: <20260512173936.503467120@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6C07352665D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246017-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,loongson.cn:email,uniontech.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiang Ma <maqianga@uniontech.com>

commit b3e31a6650d4cab63f0814c37c0b360372c6ee9e upstream.

It doesn't make sense to return the recommended maximum number of vCPUs
which exceeds the maximum possible number of vCPUs.

Other architectures have already done this, such as commit 57a2e13ebdda
("KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS")

Cc: stable@vger.kernel.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Qiang Ma <maqianga@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/vm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -91,7 +91,7 @@ int kvm_vm_ioctl_check_extension(struct
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
-		r = num_online_cpus();
+		r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;




Return-Path: <stable+bounces-245930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMmvLV1oA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:50:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C23526316
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80AA9303D710
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C13E0749;
	Tue, 12 May 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BM9U+U1g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DFD3DB99C;
	Tue, 12 May 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607921; cv=none; b=WTjV84WHLwLTMEpI/sPixNVIX6ztg+J8/2HYlP71pV9BzdFZzlx8AYym+1mZkwJ1+YET73+INxQul8Sx2pRmqRjzURBh4tOYX2Y3NaJ1vKKZyWyoeC9RRG2auRpzXDELUbtLVgFkzn6YigpklgHeKEmRVoQqlYLlkya4ajMkLsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607921; c=relaxed/simple;
	bh=DXq8rUsLW0IBi4pK0CCvI9OTZvmKBwgK/r99pM0VPPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJE54GJauW1I9HRi+1qzjVKpXFC1P7fwx3WPPABCMyzbearJ/9CqSdHtfBkUFUX/nk6wZosz947riD5uZsiRwwlboJg06VX318w0qhsOQhR71UQD+oprbwKJ8bSCc8c5dH4N9pqJcL2Na/+dozfWH3Qr21TxI0eM7a+73O/IUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BM9U+U1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B272FC2BCB0;
	Tue, 12 May 2026 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607921;
	bh=DXq8rUsLW0IBi4pK0CCvI9OTZvmKBwgK/r99pM0VPPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BM9U+U1g2ELa8wY2iNWlZE1z8lrSKbclFXi4hu9YkpeajKzWHbPlTGgRZh34CnVKG
	 YZ4oWSbw/CYbxMip1buoNnEggqmzAl1L5CP8FXyojUJ/z2BFlgxD6MoK5+y/jy2XCp
	 LMGS5OSdjl8tqmGbTelJ3gLYhuqOaxFkCgzUUNos=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Tao Cui <cuitao@kylinos.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 060/206] LoongArch: KVM: Fix missing EMULATE_FAIL in kvm_emu_mmio_read()
Date: Tue, 12 May 2026 19:38:32 +0200
Message-ID: <20260512173934.113278467@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 19C23526316
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
	TAGGED_FROM(0.00)[bounces-245930-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,loongson.cn:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tao Cui <cuitao@kylinos.cn>

commit f26faae96c411a70641e4d21b759475caa6122d5 upstream.

In the ldptr (0x24...0x27) opcode decoding path, the default case only
breaks out but without setting "ret" value to EMULATE_FAIL. This leaves
run->mmio.len uninitialized (stale from a previous MMIO operation) while
"ret" value remains EMULATE_DO_MMIO, causing the code to proceed with an
incorrect MMIO length.

Add "ret = EMULATE_FAIL" to match the other default branches in the same
function (e.g. the 0x28...0x2e and 0x38 cases).

Cc: stable@vger.kernel.org
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/exit.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -371,6 +371,7 @@ int kvm_emu_mmio_read(struct kvm_vcpu *v
 			run->mmio.len = 8;
 			break;
 		default:
+			ret = EMULATE_FAIL;
 			break;
 		}
 		break;




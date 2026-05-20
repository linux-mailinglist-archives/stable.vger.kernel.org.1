Return-Path: <stable+bounces-251367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KzZAg7xDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:36:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7508459413C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C3F231331BC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B33BA246;
	Wed, 20 May 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5Qmi3z+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7A331220;
	Wed, 20 May 2026 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297794; cv=none; b=qAkoTUpRovGzIe11GwmoLqu8EdHkLLA9Q68PRLwgx87ThfjbqVYbvEAV9R0ijuBoQNZOkdCzN+cXTHlR6U2707r/1foWMjOLkZ0de0fBviCZWLUztFs+cIImdwLQuVNEOJ+mlADqWRXHr1IW3vgAReTRm5SjsCHdBJ4d7F0EUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297794; c=relaxed/simple;
	bh=kDxgJ6rXTgEf6nUExUcSI501eLDpWjmhvjNXljiKaAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjWsIQ+vklrmshVHwIxplg26yCounDEF/dxvSGzB0fRRK4FXUhO3YQyjgfelTya8OVdW/lYfs6YaeHpT0PI32c4c7sOiypnVfwGQ38ofWssduUCm6Xb0aY6RmmcK7aAsWiDdMtcGMchY82Ubxo+ILaWDfRYtijLyeXzwJldEQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5Qmi3z+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA861F000E9;
	Wed, 20 May 2026 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297793;
	bh=k8G7m51q3ZWFn8MjgMnDQ2TQv+YAc1rGEnsLV5J2OYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5Qmi3z+apUJgV7X3qYG//nNw4Dk9N83pjoHCkImdpAVoZ+rrAicWZ1gPwx93rnjn
	 8Bvo40ofP5s5usf/WBdqR9PgoUoKFoqeinr79/KhKuuqyAvZnNJU82RdqDIpV9931o
	 z8VhnBp8nUPTGeLbpfk9mxJmmium6odgwG9egaeQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaiyan Mei <kaiyanm@hust.edu.cn>,
	Lang Xu <xulang@uniontech.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 165/957] bpf: Fix OOB in pcpu_init_value
Date: Wed, 20 May 2026 18:10:48 +0200
Message-ID: <20260520162138.130827738@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251367-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,hust.edu.cn:email]
X-Rspamd-Queue-Id: 7508459413C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lang Xu <xulang@uniontech.com>

[ Upstream commit 576afddfee8d1108ee299bf10f581593540d1a36 ]

An out-of-bounds read occurs when copying element from a
BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
same value_size that is not rounded up to 8 bytes.

The issue happens when:
1. A CGROUP_STORAGE map is created with value_size not aligned to
   8 bytes (e.g., 4 bytes)
2. A pcpu map is created with the same value_size (e.g., 4 bytes)
3. Update element in 2 with data in 1

pcpu_init_value assumes that all sources are rounded up to 8 bytes,
and invokes copy_map_value_long to make a data copy, However, the
assumption doesn't stand since there are some cases where the source
may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE, skb->data.
the verifier verifies exactly the size that the source claims, not
the size rounded up to 8 bytes by kernel, an OOB happens when the
source has only 4 bytes while the copy size(4) is rounded up to 8.

Fixes: d3bec0138bfb ("bpf: Zero-fill re-used per-cpu map element")
Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
Link: https://lore.kernel.org/r/420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com
Signed-off-by: Lang Xu <xulang@uniontech.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index e7721f0776c72..469bc48b25127 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -981,7 +981,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 
 		for_each_possible_cpu(cpu) {
 			if (cpu == current_cpu)
-				copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value);
+				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
 			else /* Since elem is preallocated, we cannot touch special fields */
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
-- 
2.53.0





Return-Path: <stable+bounces-252237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH/BBGYEDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-252237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:58:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328BD597829
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B7CF30FCEF2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE8340A57;
	Wed, 20 May 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxQe1/g7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8463E95A4;
	Wed, 20 May 2026 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300151; cv=none; b=dxEEMB+n7eLNUmUcPgY8X3xscgw6DJNLRg7tbPNWhvZ9maE2Vo1XuvQZAfFupRMhYGWBHlQ669EFDwHYYpsep4B9hcnKXvtcu0BKQNIM96HAon46f6nLxCAi0GLpa6Iy8jX8FynbNuen0lq+S7EgmCMFVksgZBJNVuB3M9jwqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300151; c=relaxed/simple;
	bh=1fOP63Sfd/teFdVzjC8TpERffJHQXRlvMzR/FjplYz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F044dti2iMU4MZLefmY9ACBajZQWWaeNeuutkdUtVFTFF1EyJ4Ao3VfHpCdq3V95PP5RzpU7CmAULQPKliWqg+y8S0DCWicuaP/3v9rPKzyzbGtE37MT2ZgUxcyoxfhYYubIGmFdpCASLUyslfwEuWPwWvne1vliAW0a3Af1UcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxQe1/g7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5CD1F000E9;
	Wed, 20 May 2026 18:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300150;
	bh=xCFF8kF8YfpkUdch0XUk771rOE5zDjLGIfxOMDYAFiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RxQe1/g72sLi3FAQLtkWNlbu1hAgoXR9e0OID1ce03bRpAxqrc++jG/KEzk72zhx5
	 Wo8KQL1y3Gbux35bZ7gI0JO8BxhpTWc099RDtX75/hUKWZhOUFhK6MZP98JmUeknze
	 2/mXo2naOdywTgrIeMnVQ5yCdKOu9WOaIpjXv1Zk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	MingTao Huang <mintaohuang@tencent.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 065/666] bpf: Fix stale offload->prog pointer after constant blinding
Date: Wed, 20 May 2026 18:14:36 +0200
Message-ID: <20260520162112.640454503@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252237-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,tencent.com:email]
X-Rspamd-Queue-Id: 328BD597829
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: MingTao Huang <mintaohuang@tencent.com>

[ Upstream commit a1aa9ef47c299c5bbc30594d3c2f0589edf908e6 ]

When a dev-bound-only BPF program (BPF_F_XDP_DEV_BOUND_ONLY) undergoes
JIT compilation with constant blinding enabled (bpf_jit_harden >= 2),
bpf_jit_blind_constants() clones the program. The original prog is then
freed in bpf_jit_prog_release_other(), which updates aux->prog to point
to the surviving clone, but fails to update offload->prog.

This leaves offload->prog pointing to the freed original program. When
the network namespace is subsequently destroyed, cleanup_net() triggers
bpf_dev_bound_netdev_unregister(), which iterates ondev->progs and calls
__bpf_prog_offload_destroy(offload->prog). Accessing the freed prog
causes a page fault:

BUG: unable to handle page fault for address: ffffc900085f1038
Workqueue: netns cleanup_net
RIP: 0010:__bpf_prog_offload_destroy+0xc/0x80
Call Trace:
__bpf_offload_dev_netdev_unregister+0x257/0x350
bpf_dev_bound_netdev_unregister+0x4a/0x90
unregister_netdevice_many_notify+0x2a2/0x660
...
cleanup_net+0x21a/0x320

The test sequence that triggers this reliably is:

1. Set net.core.bpf_jit_harden=2 (echo 2 > /proc/sys/net/core/bpf_jit_harden)
2. Run xdp_metadata selftest, which creates a dev-bound-only XDP
   program on a veth inside a netns (./test_progs -t xdp_metadata)
3. cleanup_net -> page fault in __bpf_prog_offload_destroy

Dev-bound-only programs are unique in that they have an offload structure
but go through the normal JIT path instead of bpf_prog_offload_compile().
This means they are subject to constant blinding's prog clone-and-replace,
while also having offload->prog that must stay in sync.

Fix this by updating offload->prog in bpf_jit_prog_release_other(),
alongside the existing aux->prog update. Both are back-pointers to
the prog that must be kept in sync when the prog is replaced.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Signed-off-by: MingTao Huang <mintaohuang@tencent.com>
Link: https://lore.kernel.org/r/tencent_BCF692F45859CCE6C22B7B0B64827947D406@qq.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b58833e99969a..517710c89fa50 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1489,6 +1489,8 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
 	 * know whether fp here is the clone or the original.
 	 */
 	fp->aux->prog = fp;
+	if (fp->aux->offload)
+		fp->aux->offload->prog = fp;
 	bpf_prog_clone_free(fp_other);
 }
 
-- 
2.53.0





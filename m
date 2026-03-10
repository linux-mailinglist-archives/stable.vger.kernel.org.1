Return-Path: <stable+bounces-224118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMbAOcn+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545D24A7E2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6238730B9B65
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4138A70A;
	Tue, 10 Mar 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlJwTt8V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA6389DE0;
	Tue, 10 Mar 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141251; cv=none; b=GoxG6tlOHI6oRvAuCof/e0at1vewKZjBR1r1OvDkuTnLSgoYtqy4cGIrEB7jxfWXriy24B0eiFsxwxANCMkbPeKAhtJyeOcLtSottdcSi231QZixqy4i8NTUstzbbbNYgHofOl6lONeaHgRmRxeGSA9dLJh8w0Vzu9xom6fmUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141251; c=relaxed/simple;
	bh=MWxevizfa4UTSCHs74z/dL/BGlQaQiAyB7wt3o1ZKjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgJ1z8PCh3Vy/+hjLewia0867Ksoi2BXb/xUgZS0Amarn5qIIz2aclNUwQKxz+30ycmuOtfNVvP99k9vGcAIGDWEj2Tt4dC4Ojp68ro/1870QF1+zVcejI0HtYP8GQ3pBvI8IU1hO+7nEXFv90MbZDnpayt95kmEsQUfOe6AHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlJwTt8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98535C2BC86;
	Tue, 10 Mar 2026 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141251;
	bh=MWxevizfa4UTSCHs74z/dL/BGlQaQiAyB7wt3o1ZKjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlJwTt8VoMpp0Y7uL4gdV5pNfHWaz5oGgkYvovV3O7mbWOGWDuSESHtUT5R24xk2F
	 qKQT34q+muORqDHeggP80NUPamAfgYBQhydXkM/z4UPXMG9fXSvfK93HU8wFt5/OG5
	 uohuZGA9yv8j4sPnqyQvNsZDFJy4MOzF9N95wc22x8uby3pNkaYIFdgniMOq6w/Vyi
	 LIXUxZI+EuKE2RiVzo8tpBsgAXmPl3GUe7Ud6Rvx6eXl8VenxbGeKnHS396bPT99qp
	 5s1ZnRE9veFsf9mN8BFT0LlKkwfKJEvxoIuk5i2PDXwDxlgRBuf3052v8XFAnj3XlE
	 PhOlU/VEGFVUA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lang Xu <xulang@uniontech.com>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 253/311] bpf: Fix a UAF issue in bpf_trampoline_link_cgroup_shim
Date: Tue, 10 Mar 2026 07:05:00 -0400
Message-ID: <d55b0654bddaa32f4df466e9e569bf924a6fd63e.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6545D24A7E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224118-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Lang Xu <xulang@uniontech.com>

[ Upstream commit 56145d237385ca0e7ca9ff7b226aaf2eb8ef368b ]

The root cause of this bug is that when 'bpf_link_put' reduces the
refcount of 'shim_link->link.link' to zero, the resource is considered
released but may still be referenced via 'tr->progs_hlist' in
'cgroup_shim_find'. The actual cleanup of 'tr->progs_hlist' in
'bpf_shim_tramp_link_release' is deferred. During this window, another
process can cause a use-after-free via 'bpf_trampoline_link_cgroup_shim'.

Based on Martin KaFai Lau's suggestions, I have created a simple patch.

To fix this:
   Add an atomic non-zero check in 'bpf_trampoline_link_cgroup_shim'.
   Only increment the refcount if it is not already zero.

Testing:
   I verified the fix by adding a delay in
   'bpf_shim_tramp_link_release' to make the bug easier to trigger:

static void bpf_shim_tramp_link_release(struct bpf_link *link)
{
	/* ... */
	if (!shim_link->trampoline)
		return;

+	msleep(100);
	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link,
		shim_link->trampoline, NULL));
	bpf_trampoline_put(shim_link->trampoline);
}

Before the patch, running a PoC easily reproduced the crash(almost 100%)
with a call trace similar to KaiyanM's report.
After the patch, the bug no longer occurs even after millions of
iterations.

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/3c4ebb0b.46ff8.19abab8abe2.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Lang Xu <xulang@uniontech.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/279EEE1BA1DDB49D+20260303095217.34436-1-xulang@uniontech.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/trampoline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index b9a358d7a78f1..47c70eb451f3a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -796,10 +796,8 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 	mutex_lock(&tr->mutex);
 
 	shim_link = cgroup_shim_find(tr, bpf_func);
-	if (shim_link) {
+	if (shim_link && !IS_ERR(bpf_link_inc_not_zero(&shim_link->link.link))) {
 		/* Reusing existing shim attached by the other program. */
-		bpf_link_inc(&shim_link->link.link);
-
 		mutex_unlock(&tr->mutex);
 		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
 		return 0;
-- 
2.51.0



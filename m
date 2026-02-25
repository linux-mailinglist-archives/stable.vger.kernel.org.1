Return-Path: <stable+bounces-218942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHk8CMtWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BF1903D4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E5831A6F09
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B327FB3E;
	Wed, 25 Feb 2026 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NqCNyUzE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5E25A642;
	Wed, 25 Feb 2026 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983841; cv=none; b=inK/foiKEHNcbE405Tml6Y+9JW/yiM4Et1iP1Tw1+Q0LtS21R12iABlyyFDHDLFHR3FXdJEKck6XudSM1+BiCdVubtn3gt8b1f7g8N4q+YEP6MdJ//A28aFxogKat3raeNWueZbEId9lIJUExnMcJUS9oAKEoeVc9r8cToW8f3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983841; c=relaxed/simple;
	bh=3teG+UDy55ALG/cUAirxI6YzznCZc4HzhNBG6zbKEM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buE+2PJNFJiKYvopC0Yr6u3aBX59RPXXk1h/x/yZhLxO8QVXGAdoKsUliNHjskcwpMQfveF7/AP4LjfimBr/8UwIKk5bXB3shPeyHuh7YgUoTLCR4o70FgadVTedpnEf0WEkec+WgPIEvUVtZJTv7z94BfEbi2b1oULtKpnCZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NqCNyUzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26779C116D0;
	Wed, 25 Feb 2026 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983841;
	bh=3teG+UDy55ALG/cUAirxI6YzznCZc4HzhNBG6zbKEM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqCNyUzEeWY1t+o8dAdorbSL3ODJUDfqvGmhb3MEFbXRYwUDNk1BAoaNswFZlWESS
	 1D4LQuLV/N265dDjkfT6hV0XoQ1S+8uvN+AwKMA3CD8GVXsethUXedGbG+XzNPR1Nf
	 4A5az5yAVCyRPbi5KQr4N85j6SFOXo3r6Llgil/g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Toshi Piazza <toshi.piazza@microsoft.com>,
	KP Singh <kpsingh@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 119/641] bpf: Require frozen map for calculating map hash
Date: Tue, 24 Feb 2026 17:17:25 -0800
Message-ID: <20260225012352.017771651@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218942-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8D3BF1903D4
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KP Singh <kpsingh@kernel.org>

[ Upstream commit a2c86aa621c22f2a7e26c654f936d65cfff0aa91 ]

Currently, bpf_map_get_info_by_fd calculates and caches the hash of the
map regardless of the map's frozen state.

This leads to a TOCTOU bug where userspace can call
BPF_OBJ_GET_INFO_BY_FD to cache the hash and then modify the map
contents before freezing.

Therefore, a trusted loader can be tricked into verifying the stale hash
while loading the modified contents.

Fix this by returning -EPERM if the map is not frozen when the hash is
requested. This ensures the hash is only generated for the final,
immutable state of the map.

Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
Reported-by: Toshi Piazza <toshi.piazza@microsoft.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260205070755.695776-1-kpsingh@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2649e0472dfe0..586ece78f783a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5303,6 +5303,9 @@ static int bpf_map_get_info_by_fd(struct file *file,
 		if (info.hash_size != SHA256_DIGEST_SIZE)
 			return -EINVAL;
 
+		if (!READ_ONCE(map->frozen))
+			return -EPERM;
+
 		err = map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha);
 		if (err != 0)
 			return err;
-- 
2.51.0





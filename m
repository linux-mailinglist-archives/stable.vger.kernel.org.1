Return-Path: <stable+bounces-252526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAMSFTkVDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-252526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:10:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F77599380
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB5D431C559D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C35367B9E;
	Wed, 20 May 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYBDXgoL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D23F789B;
	Wed, 20 May 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300904; cv=none; b=RcwMzQEwHEz58L/z7LvQvxusEIw+VVf/WhP6WE5L6lubDNIYpAQiMAcL7IML20QSHbOM0MX5gIoFzST/z7Bg6uLp5idDAU5pPFwK9ahDr54LtysNQPx3EOvRB7L9KlP1g693iyyFk+rmEN3mygAtWRJsR7eWibwl0UHpHGlWUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300904; c=relaxed/simple;
	bh=aCn2WT4LB8nZ3a4wrPN/OFSNWZBW5suiHVQ6ysem4ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sne8SPEKnreISXMxh4EQb3sHAtZAY+vevcehJAx5Aqdq+grzvjO2g5T6e1vbG6+Zi0m5Hwfh+NkjV2avIo35X40Le+ZT0LS1CTLuIIfOrXezmbbUrSE6Qo9ySxhGLzR24mukDS41+gnzmUIPXs3LdzxhaOk0WUD2XByZtmLt/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYBDXgoL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD231F000E9;
	Wed, 20 May 2026 18:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300903;
	bh=mXAPGvYVf6ewYtw9VdYFufDR0O8z1rUb0GJZrqKeHy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYBDXgoLBl2Z9lK1KJqmqkbsAUZ+v4OxqaY6pKRvpz4QJhpLBGeDz+zSjDOstT3wC
	 w3FgYH/NS4CJauqG0o7n+53VWZGIFeyzzEY9cfutDoh6k2uG0WUTYtWMh/51ndk5XC
	 rf3Z2Kp+tkI963wUZ/+4R6rVYTGkoif0m+DwvyFM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 353/666] libbpf: Change log level of BTF loading error message
Date: Wed, 20 May 2026 18:19:24 +0200
Message-ID: <20260520162118.883978604@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252526-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iogearbox.net:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,pm.me:email]
X-Rspamd-Queue-Id: 71F77599380
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ihor Solodrai <ihor.solodrai@pm.me>

[ Upstream commit 8b334d91834666dbc4c1c0b0abed3f855ed16cf3 ]

Reduce log level of BTF loading error to INFO if BTF is not required.

Andrii says:

  Nowadays the expectation is that the BPF program will have a valid
  .BTF section, so even though .BTF is "optional", I think it's fine
  to emit a warning for that case (any reasonably recent Clang will
  produce valid BTF).

  Ihor's patch is fixing the situation with an outdated host kernel
  that doesn't understand BTF. libbpf will try to "upload" the
  program's BTF, but if that fails and the BPF object doesn't use
  any features that require having BTF uploaded, then it's just an
  information message to the user, but otherwise can be ignored.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 380044c40b16 ("libbpf: Prevent double close and leak of btf objects")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7d496f0a9a30d..791488efec27d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3582,11 +3582,12 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 report:
 	if (err) {
 		btf_mandatory = kernel_needs_btf(obj);
-		pr_warn("Error loading .BTF into kernel: %d. %s\n", err,
-			btf_mandatory ? "BTF is mandatory, can't proceed."
-				      : "BTF is optional, ignoring.");
-		if (!btf_mandatory)
+		if (btf_mandatory) {
+			pr_warn("Error loading .BTF into kernel: %d. BTF is mandatory, can't proceed.\n", err);
+		} else {
+			pr_info("Error loading .BTF into kernel: %d. BTF is optional, ignoring.\n", err);
 			err = 0;
+		}
 	}
 	return err;
 }
-- 
2.53.0





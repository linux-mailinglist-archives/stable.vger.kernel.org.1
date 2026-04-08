Return-Path: <stable+bounces-235217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IkJN0Ws1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:28:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E93C308D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D859317A63F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D973DA5B0;
	Wed,  8 Apr 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FFrMPUbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16393DA5AC;
	Wed,  8 Apr 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674871; cv=none; b=aKm4Z6TxReatIWC7lr/V0L1lmOKuQv7otKI71XJvfc9VGIs8Jl9nrH1g0A7qdEQO0gHj32cIKfP0acRC3oHm+ARwJ7cglJu8qepzPjaIatscEv/SVxhmnyAXAFzJHurkhViV3CkSXjkxSOBXfqEXAbYWlcpyca6EEvjMfzro1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674871; c=relaxed/simple;
	bh=gHJhq4b1I1gEgCPt0QyJjhghZGLmij4CBGBgv6Rj9zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs8qoWt/LGYBeQiWEkvUyMwZffkZGTIOkz4wiuGuBUNtgPW6PZaSRaYuZj/9lv2AGjaXXDkpQ2psuivXQBCKc6xIfSgVPAC78FxyAOScTyvU5nNCur2cEcsZQ8CkZu1EQ7kWI/dR7N+ZsbEa0XWAtHJL3rfOVPatv8fEe48faWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FFrMPUbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DCBC19421;
	Wed,  8 Apr 2026 19:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674871;
	bh=gHJhq4b1I1gEgCPt0QyJjhghZGLmij4CBGBgv6Rj9zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFrMPUbRmP6bydui7nrAWjUm2mjpinSPw2ULqb96SQ5RowIWNvv7joRXQM77FiRc+
	 aHADt9TzRB0jlWvyWlTnG3CG0WTsRE5KPtzJWe9uaOSeiZRPd5AMsmtOZP6wcgd05F
	 dG4D73dbakTskq64rsfBy12q/WaNRH5EfPlMYLD0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Lai <yi1.lai@linux.intel.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.19 265/311] PM: EM: Fix NULL pointer dereference when perf domain ID is not found
Date: Wed,  8 Apr 2026 20:04:25 +0200
Message-ID: <20260408175949.277515505@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235217-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3D1E93C308D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Changwoo Min <changwoo@igalia.com>

commit 9badc2a84e688be1275bb740942d5f6f51746908 upstream.

dev_energymodel_nl_get_perf_domains_doit() calls
em_perf_domain_get_by_id() but does not check the return value before
passing it to __em_nl_get_pd_size(). When a caller supplies a
non-existent perf domain ID, em_perf_domain_get_by_id() returns NULL,
and __em_nl_get_pd_size() immediately dereferences pd->cpus
(struct offset 0x30), causing a NULL pointer dereference.

The sister handler dev_energymodel_nl_get_perf_table_doit() already
handles this correctly via __em_nl_get_pd_table_id(), which returns
NULL and causes the caller to return -EINVAL. Add the same NULL check
in the get-perf-domains do handler.

Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL spec")
Reported-by: Yi Lai <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/lkml/aXiySM79UYfk+ytd@ly-workstation/
Signed-off-by: Changwoo Min <changwoo@igalia.com>
Cc: 6.19+ <stable@vger.kernel.org> # 6.19+
[ rjw: Subject and changelog edits ]
Link: https://patch.msgid.link/20260329073615.649976-1-changwoo@igalia.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/power/em_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 5a611d3950fd..4d4fd29bd2be 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -109,6 +109,8 @@ int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
 
 	id = nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID]);
 	pd = em_perf_domain_get_by_id(id);
+	if (!pd)
+		return -EINVAL;
 
 	__em_nl_get_pd_size(pd, &msg_sz);
 	msg = genlmsg_new(msg_sz, GFP_KERNEL);
-- 
2.53.0





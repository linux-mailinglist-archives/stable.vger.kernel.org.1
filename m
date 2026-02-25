Return-Path: <stable+bounces-219517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICyfHh2jnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:22:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1F1934B8
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74F98320BA09
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE006311C2F;
	Wed, 25 Feb 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXQDdyoU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716922D73BE;
	Wed, 25 Feb 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002768; cv=none; b=ui9FoQlhGEqn0dgXx9skldsT9YJ4WRae0krJUA14wOTZzQRplGnNYzG/2RlM2dlgKH8NImkMt1kF+j42g28Bew0Nb2Z+c6uewm6x1ERZXwoCwIerGYzacHbAmqgRDyF24oJ17O2hjlQmrPvAsunPEMOGhdc+/C74/Q609Ot+z54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002768; c=relaxed/simple;
	bh=LGPDdhVADTeCz4Y673m0b1y9bQlXY3BSrvQGJ4uvJUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB96XjHXn9DSx9akp8u2u61lZW2TaSwMrBPV2qAFhiLVEQoB+Gq/bP6fcPwc1e08LoLKn5HUwFaUIEGep5IGPIRLoIPNcF1qA8J/e5QDNC3n0ALvVBhQcgzXunfmKqIe9bwWpyKVEYkLuewxOdVT3yORemPvl+dRytLs/Fc1po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CXQDdyoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B78C116D0;
	Wed, 25 Feb 2026 06:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002768;
	bh=LGPDdhVADTeCz4Y673m0b1y9bQlXY3BSrvQGJ4uvJUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXQDdyoUI6TqsV60F7bMRsyItBb5eV3ufh/5he1R3VU3MslwMqT8xmGCtwRL8byNH
	 VfFPmwgYxJ/EK9tSQqP0nEi2iCffMA8HtvPrBCEhnaFYIzSBS3+BdcUaMNW/SIybkj
	 ZMTpmA+qFgINR+6wmcsEyM19GDIrdCL0pAtuP+Ak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Georgia Garcia <georgia.garcia@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 572/641] apparmor: fix rlimit for posix cpu timers
Date: Tue, 24 Feb 2026 17:24:58 -0800
Message-ID: <20260225012402.379679817@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219517-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCE1F1934B8
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 6ca56813f4a589f536adceb42882855d91fb1125 ]

Posix cpu timers requires an additional step beyond setting the rlimit.
Refactor the code so its clear when what code is setting the
limit and conditionally update the posix cpu timers when appropriate.

Fixes: baa73d9e478ff ("posix-timers: Make them configurable")
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/resource.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
index 8e80db3ae21c0..64212b39ba4bb 100644
--- a/security/apparmor/resource.c
+++ b/security/apparmor/resource.c
@@ -196,6 +196,11 @@ void __aa_transition_rlimits(struct aa_label *old_l, struct aa_label *new_l)
 					     rules->rlimits.limits[j].rlim_max);
 			/* soft limit should not exceed hard limit */
 			rlim->rlim_cur = min(rlim->rlim_cur, rlim->rlim_max);
+			if (j == RLIMIT_CPU &&
+			    rlim->rlim_cur != RLIM_INFINITY &&
+			    IS_ENABLED(CONFIG_POSIX_TIMERS))
+				(void) update_rlimit_cpu(current->group_leader,
+							 rlim->rlim_cur);
 		}
 	}
 }
-- 
2.51.0





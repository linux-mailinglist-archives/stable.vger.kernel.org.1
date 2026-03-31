Return-Path: <stable+bounces-232122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKcEDq8EzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:30:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547136ED31
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0BA8319DA03
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5D425CD9;
	Tue, 31 Mar 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HvRg9F/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE69423149;
	Tue, 31 Mar 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975932; cv=none; b=VNLwdVgx7HYJyVUKD/IBqKTgA+Je/M1kn0u5L7v9PhbLmyc4wKqCy3TeCHus/u6gyWIIgTeeFW9pv2wZPoS36d6Z/HsSTef2WBE5F1gytXLrQ3vgV1PoYVAal0r+yq5/lo0sdSh9bSz+TY57aWn1/Lcg18bAo4RlXcmCYtclGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975932; c=relaxed/simple;
	bh=hRObCq6mv5gcB+eVgMiH74/b36oNF643xlcS1JjWySo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgRu158mlQ/3Qaa9RirWlEILpioDRxD/YuPhLwTWwQXKFX7UBne4KLGQ+vRgHb2k3R+NVsEbLIEaCIVxgqDaWsOh8XAFnJoDhexjDc9x2cJ8atnl+lFw+WXXBsuyKOwV1Z/60fEB9bEWZEWencz912mFyj2AzStOZ1senj6uT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HvRg9F/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F8DC19423;
	Tue, 31 Mar 2026 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975932;
	bh=hRObCq6mv5gcB+eVgMiH74/b36oNF643xlcS1JjWySo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvRg9F/+rFOj5thHX4G2w4I54daHSaLMaV1lSk35EQtRZCzKnQlNvgs/mLhkcyD+e
	 J2YK459W9GiSzHXc6SgkC4hpv7OEqhyLosNgO6V8yHbNt1u2Zze+z36rVx1YA4x3Lf
	 bZk2nhcimi/6ncJ+uanQQ6cpgt8djKFJEiqxgZPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 109/244] RDMA/irdma: Update ibqp state to error if QP is already in error state
Date: Tue, 31 Mar 2026 18:20:59 +0200
Message-ID: <20260331161745.693406044@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232122-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 3547136ED31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit 8c1f19a2225cf37b3f8ab0b5a8a5322291cda620 ]

In irdma_modify_qp() update ibqp state to error if the irdma QP is already
in error state, otherwise the ibqp state which is visible to the consumer
app remains stale.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 7514c5e54e026..90d2c36928c1e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1442,6 +1442,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		case IB_QPS_ERR:
 		case IB_QPS_RESET:
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
+				iwqp->ibqp_state = attr->qp_state;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata && udata->inlen) {
 					if (ib_copy_from_udata(&ureq, udata,
@@ -1647,6 +1648,7 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 		case IB_QPS_ERR:
 		case IB_QPS_RESET:
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
+				iwqp->ibqp_state = attr->qp_state;
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata && udata->inlen) {
 					if (ib_copy_from_udata(&ureq, udata,
-- 
2.53.0





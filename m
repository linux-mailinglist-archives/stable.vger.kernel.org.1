Return-Path: <stable+bounces-257352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FMhKScbG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC660F3AD
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950D130A3B6D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95F5366567;
	Sat, 30 May 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gazhJfXe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4012690D5;
	Sat, 30 May 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160695; cv=none; b=oHdUdDmp2oZMxsOtYbOkGZz2+fOCVcpJbahIE38ha2LApeKVYWqrAkXYXYTt0Dd6UGWpS2oMpdSzEU3ukEh952kx6wM3091QVENORXlwE7pBQDWwXF6XFSESwqusiCEs9Un+ZMe3WABbBRLaw0MCdzdLQ+FPU7if25qJspxwzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160695; c=relaxed/simple;
	bh=btAn/3MUUgpN9QgVPwDeYuM98I7Mf/0npcteWLykBR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MExkyge7PfgYl71IYeDxcGejeVj/gx9utDKEVrQN6WnEitEB6Y8tJjpgS06oC4m+I3WCExqD3iCQJFYz61qqe1rrJjYQ8LpD8gnPIdRfxNEmfIZ66rH2rmHQdm7XgFhcy4JMHjD8K9mLTDtZ+qIuDkKh1ShX2Fvyfo44XATGWgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gazhJfXe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF5E1F00893;
	Sat, 30 May 2026 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160694;
	bh=32Ivv3MpeqKdMJsBBCo88V35ct+q9hkFUyhjcO7t2RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gazhJfXe/y02SfPtMEeIGGsu2BsXsUSyupYLR0z7zKZ94vmEw7cXJqwIal0WU1a0D
	 fNPhXpCJ6zv62B+TyXNPQsIDK3GCtcf1lBgpQpO3e6z/3Q0fs7tFyZo6mAUK60Fin+
	 tkefhe2pMUa9L6ocQ4c1u0su92Rjp6s3zvaFT9Z4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Woodhouse <dwmw@amazon.co.uk>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 378/969] KVM: arm64: vgic: Fix IIDR revision field extracted from wrong value
Date: Sat, 30 May 2026 17:58:22 +0200
Message-ID: <20260530160310.739463342@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257352-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 09EC660F3AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit a0e6ae45af17e8b27958830595799c702ffbab8d upstream.

The uaccess write handlers for GICD_IIDR in both GICv2 and GICv3
extract the revision field from 'reg' (the current IIDR value read back
from the emulated distributor) instead of 'val' (the value userspace is
trying to write). This means userspace can never actually change the
implementation revision — the extracted value is always the current one.

Fix the FIELD_GET to use 'val' so that userspace can select a different
revision for migration compatibility.

Fixes: 49a1a2c70a7f ("KVM: arm64: vgic-v3: Advertise GICR_CTLR.{IR, CES} as a new GICD_IIDR revision")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Link: https://patch.msgid.link/20260407210949.2076251-2-dwmw2@infradead.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-mmio-v2.c |    2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kvm/vgic/vgic-mmio-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
@@ -91,7 +91,7 @@ static int vgic_mmio_uaccess_write_v2_mi
 		 * migration from old kernels to new kernels with legacy
 		 * userspace.
 		 */
-		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, reg);
+		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, val);
 		switch (reg) {
 		case KVM_VGIC_IMP_REV_2:
 		case KVM_VGIC_IMP_REV_3:
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -167,7 +167,7 @@ static int vgic_mmio_uaccess_write_v3_mi
 		if ((reg ^ val) & ~GICD_IIDR_REVISION_MASK)
 			return -EINVAL;
 
-		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, reg);
+		reg = FIELD_GET(GICD_IIDR_REVISION_MASK, val);
 		switch (reg) {
 		case KVM_VGIC_IMP_REV_2:
 		case KVM_VGIC_IMP_REV_3:




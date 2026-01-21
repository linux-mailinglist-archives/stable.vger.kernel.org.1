Return-Path: <stable+bounces-211093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AxWGpUscWl1fAAAu9opvQ
	(envelope-from <stable+bounces-211093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:44:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 208625C6DC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2F33846B02
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C13B52E2;
	Wed, 21 Jan 2026 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j6iUOhWI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3413A0B05;
	Wed, 21 Jan 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020416; cv=none; b=dhoKTPBfFs3VgEB92Yoxf2gR+IglpOAGL1Kt40p8QfltSMgmJmfN6GJfmQ3dtD2aMNWkwbPuS/HCmZ4dNrZbOoNqxMO4CEYaCFrml+NbHnGqUQk5PYnbmk1CK69p17WWUS9nOesuvTk7F/4v1FkjM+TKVkzQ/kHlrNdH+E3YT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020416; c=relaxed/simple;
	bh=BqXdIbM9Q0Uu01rAarQsUBUYB1JDCH8e2R6zsMe+Qrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVNpLRzGxO8Z6tVmPCoiSR6BrtUoZTLSOs4woBzV4bwQv0Gsle69bLGmI0ApyN42rId/NRJc4ZlbM/qlMJJ2xW30wVbRk/Mc9gIyIOcpAIjFnHw8/Pc3z0J7bwtsW2tlLzH6NceAepwa9+uSGL7kvIQUKOJ18O54GK7N8rgN1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j6iUOhWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1820CC16AAE;
	Wed, 21 Jan 2026 18:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020416;
	bh=BqXdIbM9Q0Uu01rAarQsUBUYB1JDCH8e2R6zsMe+Qrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6iUOhWICjx+BmpxdvvkpwoDJpmoCGsnDud8fB6X4E4n0EkspHM8iGOde32G2k+2U
	 SYQnEwHlSyFWrT6/DSEmrXJyza5Xfrwb9Ru2BylXplWkRqyBog/QKbu+Jq/trtIKFS
	 iuMbpCjTG70K6IK4oyvGEhLe6JaBnPQIPyxODogo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 152/198] drm/amdgpu: Fix gfx9 update PTE mtype flag
Date: Wed, 21 Jan 2026 19:16:20 +0100
Message-ID: <20260121181424.025295146@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-211093-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 208625C6DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

commit 292e5757b2229c0c6f1d059123a85f8a28f4464d upstream.

Fix copy&paste error, that should have been an assignment instead of an or,
otherwise MTYPE_UC 0x3 can not be updated to MTYPE_RW 0x1.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit fc1366016abe4103c0f0fac882811aea961ef213)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1233,16 +1233,16 @@ static void gmc_v9_0_get_vm_pte(struct a
 		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
 		break;
 	case AMDGPU_VM_MTYPE_WC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
 		break;
 	case AMDGPU_VM_MTYPE_RW:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
 		break;
 	case AMDGPU_VM_MTYPE_CC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
 		break;
 	case AMDGPU_VM_MTYPE_UC:
-		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
+		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
 		break;
 	}
 




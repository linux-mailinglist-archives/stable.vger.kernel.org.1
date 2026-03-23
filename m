Return-Path: <stable+bounces-228338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGBELjlMwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:20:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE62F43E4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D864E30B790F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FA63B2FF9;
	Mon, 23 Mar 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1JgP5qT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05EF36F414;
	Mon, 23 Mar 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274851; cv=none; b=Xx26qFWOynIgehSCo8ihwipd/mnvYUAcp2Qf1CQUqJjVTbsx6LKd3JDHHRBZWAxowp8EWGhkm0uWKRJ67JShv77Rf7fJimNUjLJMII51knLdEvop70nt1j3/D10ltzo6rd64ukfLqoWYlOfIBdgT9Nt81E6xYLZjTJeysVBdMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274851; c=relaxed/simple;
	bh=1jflw6anNIi0uB1OKlKGkgUKMpkFdQgphF2EXdC3o+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQ3HcQArXXB64eXmN7cTvs6CTdXvmhhfc1KsEdEbSoWew9IEotxeMc6Nbp9mkPavSffMyNbfmYNxS//BxdgprWCGDOSsvb3ILxDeZede4meRvYtTUR7moBYEXmCb2pwgvbYB+VxQiMEyRr/62lf66gXIeyyFOwnIaXGnsUN35bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1JgP5qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72025C4CEF7;
	Mon, 23 Mar 2026 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274850;
	bh=1jflw6anNIi0uB1OKlKGkgUKMpkFdQgphF2EXdC3o+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1JgP5qTiSdn3+9W2ZCkaaWAv3Ovg5fslgufn7YD9g4AJnjClqLp8jzR0ZCMKtXVr
	 ipr+Zd4PjRxnve/nOBxPpXFlgrkqLFlz1QIFNZ6qliVroP/ESEqhHVQE5oxiRY9y/g
	 1bPl7ibHKXtmn2i7T/uclpLduYQR2KU6W/nZKZFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 087/212] drm/amdgpu/mmhub4.1.0: add bounds checking for cid
Date: Mon, 23 Mar 2026 14:45:08 +0100
Message-ID: <20260323134506.524235391@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228338-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,linuxfoundation.org:server fail,amd.com:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,amd.com:email]
X-Rspamd-Queue-Id: 61CE62F43E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 3cdd405831d8cc50a5eae086403402697bb98a4a upstream.

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 04f063d85090f5dd0c671010ce88ee49d9dcc8ed)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -102,7 +102,8 @@ mmhub_v4_1_0_print_l2_protection_fault_s
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
-		mmhub_cid = mmhub_client_ids_v4_1_0[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v4_1_0) ?
+			mmhub_client_ids_v4_1_0[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;




Return-Path: <stable+bounces-228104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMu+KoNIwWlGSAQAu9opvQ
	(envelope-from <stable+bounces-228104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:04:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 320EB2F3C42
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEC4331289E0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3B3AD539;
	Mon, 23 Mar 2026 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c7e4EeLe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481351A680D;
	Mon, 23 Mar 2026 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274137; cv=none; b=T73YYNdq2IgdXAJnVNcBmdZB5UD03XmjsD6ZPAtKusJrbDNmzHQLxpbUOg4oWOebYAf/c8t00WrUHdTUQz37zXP/UyGZ+ezMaMFkn5YMd7Hm/30ipWIo/THUZc4UGAG1zwOKYpoFmFAxAkMjR3YdMXj6EKPfTkGP+ZEXOEkQInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274137; c=relaxed/simple;
	bh=oduutQ2/EMPNfA5K32PVsaVtAcMlDcyXhXaMFt35l/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9BHgBxXGQsTbK367F1vFPkwzKtrAnrftoBXvhN2kuHtBHwPb2fJX4BvvAJCqA+2XTUJTWWaCbJiCK5mhoLOZCFNSXWJ37wHRDMjr+7HplUGl6foYYf8K1Fw4p74DnmUS8auHUj8d5qw6rEGI1VReRxbOsL5+9pND2pih9haWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c7e4EeLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1849C4CEF7;
	Mon, 23 Mar 2026 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274137;
	bh=oduutQ2/EMPNfA5K32PVsaVtAcMlDcyXhXaMFt35l/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7e4EeLeiH+W9fgl0qkrhWxrt+PLoWrsHwdofcks7HV4KWES7BggobWX8eWl0XYNC
	 725CCGabtLw5kiK1jGCrwf2v8+dqEdMKS70y4/wUZe5A3dvJFJnjIokpjfl7OVRL+w
	 vbdLsWnwvBquWKk39LWxOiF5YLbj2DgSjDR5iC58=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.19 079/220] drm/amdgpu/mmhub4.1.0: add bounds checking for cid
Date: Mon, 23 Mar 2026 14:44:16 +0100
Message-ID: <20260323134507.091205272@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228104-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 320EB2F3C42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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




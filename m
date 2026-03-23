Return-Path: <stable+bounces-228334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL7vGKROwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:31:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC62F4A5B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D4713159524
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D23B52FE;
	Mon, 23 Mar 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mb5Nnl5/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E4E3AEF46;
	Mon, 23 Mar 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274840; cv=none; b=VdmoIPw+uqTEbDc86OqJEazCjjn6GEPlPnqCcGlxyrtjUu2Fd/MdXC4qXFhbOmon+Dc/SWb/D8GecDYziSTfhs8TWKOoysZw5toRTnE57v7Za74meQrM4+yip6Mx21pFebOigMXi4B7iWnhmMdWbIlMGvOhrT2L9RPPIxZHr3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274840; c=relaxed/simple;
	bh=mjCM9vfj/InsavEfd0mHsuDevxCtBdBNJVyniJZp5us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O56NeLp07YgCM39XxDiBQUw5ZIxXg62m17Okz37WPr2xxr7FpwVhGFyA4JkzWMnmSHz/mnoc1DRwR8B+Ip3y11IDlDlrkAy6o3eFI2eMdBXM1dfxwS/KD9rhWahNtRFrNnh/Wx+zkpdqWX9rei/lKkYTiw6ARLV+bXp9aN/DlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mb5Nnl5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05704C2BC9E;
	Mon, 23 Mar 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274840;
	bh=mjCM9vfj/InsavEfd0mHsuDevxCtBdBNJVyniJZp5us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mb5Nnl5/GopMEyYqoHMmpz2xn+l7ZQIV3XRSAWntlSVaj6qX9x9o8F4GkSUYamg+q
	 HGDc0jjr1SDUiulFZaSMgsGFs7nvpJhdAvWAAuCBocBZi+Vu/i+2RznrZANXhzNB++
	 AvsVTirsKp63sgUcKJnUaPQengSNgD0Vty+6ubbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Cheng <benjamin.cheng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 083/212] drm/amdgpu/mmhub2.3: add bounds checking for cid
Date: Mon, 23 Mar 2026 14:45:04 +0100
Message-ID: <20260323134506.395968797@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228334-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DDEC62F4A5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit a54403a534972af5d9ba5aaa3bb6ead612500ec6 upstream.

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Reviewed-by: Benjamin Cheng <benjamin.cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 89cd90375c19fb45138990b70e9f4ba4806f05c4)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -94,7 +94,8 @@ mmhub_v2_3_print_l2_protection_fault_sta
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 4, 0):
 	case IP_VERSION(2, 4, 1):
-		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_vangogh) ?
+			mmhub_client_ids_vangogh[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;




Return-Path: <stable+bounces-248125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIW5ES9LB2q5wwIAu9opvQ
	(envelope-from <stable+bounces-248125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AAC5537FE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2758330CF61C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334C3BB116;
	Fri, 15 May 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pIShZzWf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15830569C;
	Fri, 15 May 2026 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860937; cv=none; b=gDEGTqV/J6YkMs7SIbed4nRxte04/87eipPh/OefQou/yfvcmU2tDW6MeNd3PIqpIKsQzytLk4mT8LHceyOzS+osNPJBxFMM8Jj5me/vgB4C5V70PDoPgB4nJANEyDvxiQ6TJRI5VcDNX1z+kmMlxwMuDpWxfs/S7Dg0ouRztlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860937; c=relaxed/simple;
	bh=HakIShUAQzpuIhRhpJbmdCSl38ETHH38yWBqADvCrLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKzzGK6ijPxVai/BLhJBsG6XMMCOu4qcxU3ticZlUPyMhE2fvisZpZU04dXIJsb+/V8xKKsMSo2M0fXKSq5h1v1Z5nHDhsoLU4ZJh0DGhQnXBJJo+Kpf12rlP7FCGgJsVPZMIQbWWy7VhOb4xBrU7TeTxQHMrLImzBfPEuCV29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pIShZzWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE77C2BCB0;
	Fri, 15 May 2026 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860936;
	bh=HakIShUAQzpuIhRhpJbmdCSl38ETHH38yWBqADvCrLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIShZzWfX/WCvwYBfqTEIgZ3QM+UtrVBUNVboTVkF5RkPx6zoESWC3IO8Hx7O+zP8
	 tX2k3p3SLB8XIVq5aDB1hKqlnzsFicZChNdg5V8UyGXh7KympHO3VBeXnvBOpx7DXT
	 VxzFh8KF5hwWjAa7XpeF98afR3iUw22VlxSfcLoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Douglas Anderson <dianders@chromium.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.6 136/474] driver core: Add kernel-doc for DEV_FLAG_COUNT enum value
Date: Fri, 15 May 2026 17:44:05 +0200
Message-ID: <20260515154717.974155841@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F1AAC5537FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248125-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

commit 5b484311507b5d403c1f7a45f6aa3778549e268b upstream.

Even though nobody should use this value (except when declaring the
"flags" bitmap), kernel-doc still gets upset that it's not documented.
It reports:

  WARNING: ../include/linux/device.h:519
  Enum value 'DEV_FLAG_COUNT' not described in enum 'struct_device_flags'

Add the description of DEV_FLAG_COUNT.

Fixes: a2225b6e834a ("driver core: Don't let a device probe until it's ready")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/f318cd43-81fd-48b9-abf7-92af85f12f91@infradead.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260413195910.1.I23aca74fe2d3636a47df196a80920fecb2643220@changeid
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -610,6 +610,7 @@ struct device_physical_location {
  *
  * @DEV_FLAG_READY_TO_PROBE: If set then device_add() has finished enough
  *		initialization that probe could be called.
+ * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,




Return-Path: <stable+bounces-236406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KsDC+wb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:38:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 995C43EF6CA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFD8C30EA574
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096CE26F293;
	Mon, 13 Apr 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HirwbYQm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BE24DCF6;
	Mon, 13 Apr 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096823; cv=none; b=BGPjjSQlfkNHsZknLab0NKjcvBy7NSyLgN9mX7zw6VF/IASPBQFgh7/qN+aQRWoyWHUshCz6VGn6Mqy1pumXjHqJAtdxB+A1fcaHT3s4gFiR2+sSFEgFKWnKpLpBM62mRlrRM+TVMUSdNvbHiG7fTYQFgYD4zUewwuLMKIXilvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096823; c=relaxed/simple;
	bh=WO1OivKVqpiLsYI4zspRVJPUBqg0Qn9oQlbXS5AnV2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3ANsuT5DpiBw2LlU7XSrGLIp1hoS2PPKtJdb1f977yeENydjOMjcrWMMZ7YxrRcvMlM7U3CV8srhOKcmaBr1Znt9AXUSV8lNGhONaO7wg8u1wyT73ldCAT7DKCY4B1o8oEIUTQi+wEGmUeaqFr/e+DBM3P3cmMFGFADy2tCPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HirwbYQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568AAC2BCAF;
	Mon, 13 Apr 2026 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096823;
	bh=WO1OivKVqpiLsYI4zspRVJPUBqg0Qn9oQlbXS5AnV2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HirwbYQmTEEL4Cmyx6Ncsfoi8tB3v1yTOciYYJHT0ixN01Ul5imEKJJH/SWhLvsgg
	 c8z0o4Bi7c3z1tEQopMNs1rK7ylb1ZJn8rTwSIlGM6N7Gvt0cCtryVCm+tb8h718w8
	 aihj5f216kbMVWGhEN0qW8V2LcIsd+zPambi0LXY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ray Zhang <sgzhang@google.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Samuel Salin <Samuel.salin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.12 56/70] idpf: improve locking around idpf_vc_xn_push_free()
Date: Mon, 13 Apr 2026 18:00:51 +0200
Message-ID: <20260413155730.276824852@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236406-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linutronix.de:email]
X-Rspamd-Queue-Id: 995C43EF6CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Tantilov <emil.s.tantilov@intel.com>

commit d086fae65006368618104ba4c57779440eab2217 upstream.

Protect the set_bit() operation for the free_xn bitmask in
idpf_vc_xn_push_free(), to make the locking consistent with rest of the
code and avoid potential races in that logic.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Cc: stable@vger.kernel.org
Reported-by: Ray Zhang <sgzhang@google.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -431,7 +431,9 @@ static void idpf_vc_xn_push_free(struct
 				 struct idpf_vc_xn *xn)
 {
 	idpf_vc_xn_release_bufs(xn);
+	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
 	set_bit(xn->idx, vcxn_mngr->free_xn_bm);
+	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
 }
 
 /**




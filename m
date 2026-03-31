Return-Path: <stable+bounces-232232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NIwK53/y2koNQYAu9opvQ
	(envelope-from <stable+bounces-232232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B5736DF92
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64BFF30EA76A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1757423A7C;
	Tue, 31 Mar 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EmBn31h0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B06423A99;
	Tue, 31 Mar 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976217; cv=none; b=Wf7tMaNhgiVwMByy/zuWJ9eC5lQNq/3LFcI+OcVGi3NyoKEgbCweRRt2D1nfiu7wBgObJkZ+nbpRxCf3UlzFE3BgRJQ0SVd/D4N8VDb+JGc6TqKFqGeAf3/KQ+ShggLCS2CtYTL5KPvC6qmBpn0WW20ULDq2t+whPvZuqHf3TO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976217; c=relaxed/simple;
	bh=dKdFs1ONmxSSrUN5+trAMwix7M1FtkixQPQ8xNzF9hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ug8PHFLiO9aB90IHZb8pA93T8cn4dkWX5gFhwlYTd5S+4zVArIDEz/bcyKqq97tmizerGbpqj5/LV4cZUZmE0LB9i4XSm0WWC69oH1egeHtwXHaFCeJmOteXnlVw/662lVSsSDVUWMNAtyH64l+6wTAgBBGS1e5ZhcJch0yx78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EmBn31h0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E38C19424;
	Tue, 31 Mar 2026 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976217;
	bh=dKdFs1ONmxSSrUN5+trAMwix7M1FtkixQPQ8xNzF9hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmBn31h0aBPruVm1HgVZA6bLbak8aSt75UnyY5h+AsHbOHQ75sFoVT9vnSUAo4Sql
	 5cTFY/kXip1f1PxbzIu6Iud8Q3anmKCMakd47FFiSowYuLxSn8fGcHYTWTGcMN2L1k
	 3u3xp0htCPp8g5J5T5rEMhtnYKMAAxAnX3uPy/t8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Li <boolli@google.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.12 244/244] idpf: nullify pointers after they are freed
Date: Tue, 31 Mar 2026 18:23:14 +0200
Message-ID: <20260331161750.768396800@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232232-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 56B5736DF92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Li <boolli@google.com>

commit bc3b31977314433e4685ae92853d1b6e91ad7bc2 upstream.

rss_data->rss_key needs to be nullified after it is freed.
Checks like "if (!rss_data->rss_key)" in the code could fail
if it is not nullified.

Tested: built and booted the kernel.

Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early ethtool operations")
Signed-off-by: Li Li <boolli@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1230,6 +1230,7 @@ static struct idpf_vport *idpf_vport_all
 
 free_rss_key:
 	kfree(rss_data->rss_key);
+	rss_data->rss_key = NULL;
 free_vector_idxs:
 	kfree(vport->q_vector_idxs);
 free_vport:




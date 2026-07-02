Return-Path: <stable+bounces-271249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5CXLL1+kRmpkawsAu9opvQ
	(envelope-from <stable+bounces-271249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:48:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A276FBA26
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:48:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="A/qKCxrY";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271249-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271249-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DE633BDB20
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CE637A83F;
	Thu,  2 Jul 2026 16:50:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53908359A89;
	Thu,  2 Jul 2026 16:50:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011053; cv=none; b=b11/w1DPPUP8GENRff5D8+KPjtCoGHGBt9SE9XJDtSdG9RqswSOAVVLF6GDucvv9sCGpzKxZZ+4h6buFFnZw+/Iz8zcwCZC7QB0+qIJiPF5e0R3DpL2pVtzvn2rTuWiX1xk8G5/CGvwkS23bXHctdTFp/JffbD9eLcKH2hI+KUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011053; c=relaxed/simple;
	bh=ECR3z7zkkzE8OZMlRyE8hJiygObcNwjU5W3ZYe47gBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIQBssBPdZxm3ob9vDyAsk2R5qc1Mrw9CRoAitcu0fp9/Sq2FF0Mze7NdYQHmUrD+hylMeDRPycNAYnpgkMtk1lE5AqpwxHuVKBaWwVzhd68/4Q0GO5yMCC7p+tLhitMns/Jqq+x3FvrbyaVvaTLqqyHuYyQZGc74lLfybynEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A/qKCxrY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABDB1F000E9;
	Thu,  2 Jul 2026 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011052;
	bh=0vEhIA8xOY4jU7MOyNffcnpZdAxE995MDrQOLC3tx70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/qKCxrYjNsxD8jLeetMjfPQfYcwgUMEfk5D1pRJlsVH+6hqGzMuOnfYyTqMhTHR9
	 77+xUVUXe8BLIOfT+EwOnLuVO/8e28xgSAA9KkR+wvz00GarVp9YnQoYmq+0fBsItE
	 2sXDAY2m94UgleFwW6qQWTsMyaLTRUOjRgpRtdK0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junjie Cao <junjie.cao@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 6.6 136/175] wifi: iwlwifi: mvm: fix race condition in PTP removal
Date: Thu,  2 Jul 2026 18:20:37 +0200
Message-ID: <20260702155118.674881244@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271249-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:junjie.cao@intel.com,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16A276FBA26

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junjie Cao <junjie.cao@intel.com>

commit 65150c9cc3e06ab54bc4e8134a47f6f5d095a4e3 upstream.

iwl_mvm_ptp_remove() calls cancel_delayed_work_sync() only after
ptp_clock_unregister() and clearing ptp_data state (ptp_clock,
ptp_clock_info, last_gp2).

This creates a race where the delayed work iwl_mvm_ptp_work() can
execute between ptp_clock_unregister() and cancel_delayed_work_sync(),
observing partially cleared PTP state.

Move cancel_delayed_work_sync() before ptp_clock_unregister() to
ensure the delayed work is fully stopped before any PTP cleanup
begins.

Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Link: https://patch.msgid.link/20260212125035.1345718-1-junjie.cao@intel.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -316,11 +316,11 @@ void iwl_mvm_ptp_remove(struct iwl_mvm *
 			 mvm->ptp_data.ptp_clock_info.name,
 			 ptp_clock_index(mvm->ptp_data.ptp_clock));
 
+		cancel_delayed_work_sync(&mvm->ptp_data.dwork);
 		ptp_clock_unregister(mvm->ptp_data.ptp_clock);
 		mvm->ptp_data.ptp_clock = NULL;
 		memset(&mvm->ptp_data.ptp_clock_info, 0,
 		       sizeof(mvm->ptp_data.ptp_clock_info));
 		mvm->ptp_data.last_gp2 = 0;
-		cancel_delayed_work_sync(&mvm->ptp_data.dwork);
 	}
 }




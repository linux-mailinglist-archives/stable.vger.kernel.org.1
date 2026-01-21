Return-Path: <stable+bounces-210924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHP/H9ktcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-210924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:49:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B015C87C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D1A102D6
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B939B4BB;
	Wed, 21 Jan 2026 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="koPZb3gG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD823AB98;
	Wed, 21 Jan 2026 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019846; cv=none; b=Z3IKeBOKML4yZkSfj9uEDoyTVI807O632IENr9ZnNdUpVotMHjKmZm0A4DWJ7EcUfbRR4Ffj0k8y0KwjE3ecCsaNQkGiFARnEJNvgSniNVhFLi0fKinw93EUAS5LEP+VJK5bgUuwLspIu1Rb9Mc0zLbwzep3PmCWJlPWET5oMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019846; c=relaxed/simple;
	bh=r58VJ1xzUrETjoPHzh8kgr4dZ9W2h2Fe1Jo7aTimo6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKnipJKO9o/RPkle10K/XxahsJLVnTG2gioOiFKS2gjNDkzVuMns2J/PtlD73DkBhsQ/kvbVcBjV3mX8VWJw7vS3ahH1/g3sFfHxdcTCY/VJqra/zTJB1D7QCfuNtgzrK/FwZgPoB1a8/S8UiwF672xoANWG2rFZ2P7g7VXtBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=koPZb3gG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971C8C16AAE;
	Wed, 21 Jan 2026 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019846;
	bh=r58VJ1xzUrETjoPHzh8kgr4dZ9W2h2Fe1Jo7aTimo6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koPZb3gGZ4LC4OjQe6Jgm4bTiNd5rp7xH6LE6a8YQgCgKeJe2sDlcNXNxhXnOQ53m
	 DT3CPyovlHXud5XdBla2rR8uY/ss9kBErCREHhcyFUrgcmZ2xsHi4sowstKepHYw9X
	 53oeyporjSMRNAp/FgwIC1SQCcWfRnzu7RQJgQgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.12 123/139] HID: intel-ish-hid: Fix -Wcast-function-type-strict in devm_ishtp_alloc_workqueue()
Date: Wed, 21 Jan 2026 19:16:11 +0100
Message-ID: <20260121181415.880028669@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210924-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,suse.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E6B015C87C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 3644f4411713f52bf231574aa8759e3d8e20b341 upstream.

Clang warns (or errors with CONFIG_WERROR=y / W=e):

  drivers/hid/intel-ish-hid/ipc/ipc.c:935:36: error: cast from 'void (*)(struct workqueue_struct *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
    935 |         if (devm_add_action_or_reset(dev, (void (*)(void *))destroy_workqueue,
        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/device/devres.h:168:34: note: expanded from macro 'devm_add_action_or_reset'
    168 |         __devm_add_action_or_ireset(dev, action, data, #action)
        |                                         ^~~~~~

This warning is pointing out a kernel control flow integrity (kCFI /
CONFIG_CFI=y) violation will occur due to this function cast when the
destroy_workqueue() is indirectly called via devm_action_release()
because the prototype of destroy_workqueue() does not match the
prototype of (*action)().

Use a local function with the correct prototype to wrap
destroy_workqueue() to resolve the warning and CFI violation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510190103.qTZvfdjj-lkp@intel.com/
Closes: https://github.com/ClangBuiltLinux/linux/issues/2139
Fixes: 0d30dae38fe0 ("HID: intel-ish-hid: Use dedicated unbound workqueues to prevent resume blocking")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -932,6 +932,11 @@ static const struct ishtp_hw_ops ish_hw_
 	.dma_no_cache_snooping = _dma_no_cache_snooping
 };
 
+static void ishtp_free_workqueue(void *wq)
+{
+	destroy_workqueue(wq);
+}
+
 static struct workqueue_struct *devm_ishtp_alloc_workqueue(struct device *dev)
 {
 	struct workqueue_struct *wq;
@@ -940,8 +945,7 @@ static struct workqueue_struct *devm_ish
 	if (!wq)
 		return NULL;
 
-	if (devm_add_action_or_reset(dev, (void (*)(void *))destroy_workqueue,
-				     wq))
+	if (devm_add_action_or_reset(dev, ishtp_free_workqueue, wq))
 		return NULL;
 
 	return wq;




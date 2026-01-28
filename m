Return-Path: <stable+bounces-212365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEb9FOcwemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:53:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC0A4A25
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94EB43093043
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC93033C3;
	Wed, 28 Jan 2026 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LQoTLX0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87F2DF155;
	Wed, 28 Jan 2026 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615276; cv=none; b=tkO/0a+kaeVuQfrTb92dprYy7oDlQ7MJX7NwjJFnLXTa0KFc6jS09spe4Npvh1VWtVASCf/kyPQaguOMmyUjaQ74ygIhhzwRpbq862J90uQcC9RvVSW5H7lkxAf+2RmRUULZWd1bWVHnRHyB7qTuKqFK0iLDZGbrYXRHP5P5LYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615276; c=relaxed/simple;
	bh=FIxOqBiq65TWqMj4SCnOXKmjVwxY8GYfbZepMxnzrvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB4jkJ31Dk0w/7NfKDmSyy2JJZ0CLYKhFhIHSmqlLmf2CrAbvazR2epUiDoPDYxhAh1dko0jG8Y5pgAPbOPL+HQbMLruf2Tw1ORBFGg1mf/6SSAT0TuSi7eOykej0k+FZDTzbNaue8V60glxdTjOvhvrqI/6XT3plcw9EbnBSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LQoTLX0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B440C4CEF1;
	Wed, 28 Jan 2026 15:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615275;
	bh=FIxOqBiq65TWqMj4SCnOXKmjVwxY8GYfbZepMxnzrvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQoTLX0LDZrPsA27fp7pSiL6gzeFDx8Dn8dcMJEUpPn0ywWNSd8QRnMTGacKch70p
	 navg5C5fpEOQeIzeeH0BkTxyGY60cg5gqtacAJRduAn+Xw7x+gM13ti5uuKG7UTqPk
	 is8nU8IOdINgpmsmNNmGmhmUDcb4iFxzlGfLMYpU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 6.12 131/169] uacce: fix isolate sysfs check condition
Date: Wed, 28 Jan 2026 16:23:34 +0100
Message-ID: <20260128145338.723352088@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212365-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E2EC0A4A25
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghai Huang <huangchenghai2@huawei.com>

commit 98eec349259b1fd876f350b1c600403bcef8f85d upstream.

uacce supports the device isolation feature. If the driver
implements the isolate_err_threshold_read and
isolate_err_threshold_write callback functions, uacce will create
sysfs files now. Users can read and configure the isolation policy
through sysfs. Currently, sysfs files are created as long as either
isolate_err_threshold_read or isolate_err_threshold_write callback
functions are present.

However, accessing a non-existent callback function may cause the
system to crash. Therefore, intercept the creation of sysfs if
neither read nor write exists; create sysfs if either is supported,
but intercept unsupported operations at the call site.

Fixes: e3e289fbc0b5 ("uacce: supports device isolation feature")
Cc: stable@vger.kernel.org
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://patch.msgid.link/20251202061256.4158641-3-huangchenghai2@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/uacce/uacce.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -382,6 +382,9 @@ static ssize_t isolate_strategy_show(str
 	struct uacce_device *uacce = to_uacce_device(dev);
 	u32 val;
 
+	if (!uacce->ops->isolate_err_threshold_read)
+		return -ENOENT;
+
 	val = uacce->ops->isolate_err_threshold_read(uacce);
 
 	return sysfs_emit(buf, "%u\n", val);
@@ -394,6 +397,9 @@ static ssize_t isolate_strategy_store(st
 	unsigned long val;
 	int ret;
 
+	if (!uacce->ops->isolate_err_threshold_write)
+		return -ENOENT;
+
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 




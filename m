Return-Path: <stable+bounces-218604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ9wAfNTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351318FAF4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40BB31833AC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9753D248881;
	Wed, 25 Feb 2026 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgzP1oYZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE891FE45D;
	Wed, 25 Feb 2026 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983449; cv=none; b=c6aSWFbn2Ve+hJQlEljoTz/iE+iChot/RKRUck91/Odxzim1rOaXya9xxNM30vKqdd48SRwc5FHERn8+c+92WWKzFOVNpS+EX86HxVnWx5tUCXw2G6aAiQYknXMSpCOqtlb/didxav2iAfXy0lN2zl8mm9zwD8FFW6VCndlf/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983449; c=relaxed/simple;
	bh=0tmKKklpurzQcV9+NMMED3vS8z4Eqo9HNvRw2qHVYsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPbOA/wE5u6NlC/+vb9semRO81+fYpbBZskkqZFk4el+WE9Vpnz4++CHyNzZRfDCEb8pFMKs9x90zIRjDTFb6PBiruS+G8yBWXQoDmZCedfcCLyrOJEM15IBrwkhPTb2y9hKfgm36QUSqQhHVzSqvDTDsV0SALChqjdXiYx9S5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgzP1oYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D328C19423;
	Wed, 25 Feb 2026 01:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983449;
	bh=0tmKKklpurzQcV9+NMMED3vS8z4Eqo9HNvRw2qHVYsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bgzP1oYZ3e4kvO+OHezQc5M6TcXFfuYehO/R6c60z+pp4nVbrMSMBZmBZGVwvdM6m
	 lZQUcTbmTlxZuFQ+dDAGecqsiLzm2/M9D/2eOo40aG+Y4NR1HDgRR6y04erv91Y1aU
	 0vu1foeCoYCFTdn2GzzzQO4STDs6aiuLfjyV0x0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alper Ak <alperyasinak1@gmail.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 565/781] char: misc: Use IS_ERR() for filp_open() return value
Date: Tue, 24 Feb 2026 17:21:14 -0800
Message-ID: <20260225012413.660729995@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,linaro.org,gmail.com,igalia.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218604-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8351318FAF4
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alper Ak <alperyasinak1@gmail.com>

[ Upstream commit e849ada70c6b1ee22e9f4f5c0e38231dcee53f04 ]

filp_open() never returns NULL, it returns either a valid pointer or an
error pointer. Using IS_ERR_OR_NULL() is unnecessary. Additionally, if
filp were NULL, PTR_ERR(NULL) would return 0, leading to a misleading
error message.

Fixes: 74d8361be344 ("char: misc: add test cases")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202506132058.thWZHlrb-lkp@intel.com/
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
Acked-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://patch.msgid.link/20251226230248.113073-1-alperyasinak1@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/misc_minor_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/misc_minor_kunit.c b/drivers/char/misc_minor_kunit.c
index 6fc8b05169c57..e930c78e1ef97 100644
--- a/drivers/char/misc_minor_kunit.c
+++ b/drivers/char/misc_minor_kunit.c
@@ -166,7 +166,7 @@ static void __init miscdev_test_can_open(struct kunit *test, struct miscdevice *
 		KUNIT_FAIL(test, "failed to create node\n");
 
 	filp = filp_open(devname, O_RDONLY, 0);
-	if (IS_ERR_OR_NULL(filp))
+	if (IS_ERR(filp))
 		KUNIT_FAIL(test, "failed to open misc device: %ld\n", PTR_ERR(filp));
 	else
 		fput(filp);
-- 
2.51.0





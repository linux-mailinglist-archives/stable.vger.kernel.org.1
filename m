Return-Path: <stable+bounces-218965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP+kCAxanmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 400FD190A1D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F3D430F2276
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C8271471;
	Wed, 25 Feb 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pzO7/YXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509EC27280F;
	Wed, 25 Feb 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983867; cv=none; b=eWQd+mvdtsh3V+/9l/9jq6MAVCOxDfBGN+ZJzQIcRI0hFVWlBsBRs4KwlNGEh4YkUfDeU8H0oqNB07YQDG/8olF2rOXj/6EP2w+oPl83habhB3eARgJcq9T81XkaRAw7fEcqS1bUpgHEbW1kcdn5xr+ziTuDYfmUcCA4h1k0WiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983867; c=relaxed/simple;
	bh=BCDthqZJKFBA6LAwt5sfNqmf7HMEIJ7GVVRFGibyMX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4DJpb5vjPcfvslObqL3Cw3hlDuMep+3ma6jw6a4VSUc6QpJfwnr28/KJb+3Xm5wFBvCLbW8Wvt986j8oke9blienwSm8jtXPcC3p5ajck8wTAaloyGnxEnUJlAYrl+EoZxH4reNrYW7UgEfFqQ5driEuBdsV0HKlXzxXna3z8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pzO7/YXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC22C116D0;
	Wed, 25 Feb 2026 01:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983867;
	bh=BCDthqZJKFBA6LAwt5sfNqmf7HMEIJ7GVVRFGibyMX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pzO7/YXOwe4rZ7RpknRy3tjrUHWY/BVHhrsh85ruK6OjphM4KgLn5moDJOkYMM31L
	 MwK4kskNJbtG5XZ1dSwNtddG+PC0j9H6g+AOLro8r+k9DxLQN0ny/9kM/hTe93qL9/
	 d9W3bTjXe7mTtpaquKIIjSV8mve29lLOMZQjzikQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 144/641] soc: mediatek: svs: Fix memory leak in svs_enable_debug_write()
Date: Tue, 24 Feb 2026 17:17:50 -0800
Message-ID: <20260225012352.603206827@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218965-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,seu.edu.cn:email,collabora.com:email]
X-Rspamd-Queue-Id: 400FD190A1D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 6259094ee806fb813ca95894c65fb80e2ec98bf1 ]

In svs_enable_debug_write(), the buf allocated by memdup_user_nul()
is leaked if kstrtoint() fails.

Fix this by using __free(kfree) to automatically free buf, eliminating
the need for explicit kfree() calls and preventing leaks.

Fixes: 13f1bbcfb582 ("soc: mediatek: SVS: add debug commands")
Co-developed-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
[Angelo: Added missing cleanup.h inclusion]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/mediatek/mtk-svs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index f45537546553e..99edecb204f25 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -9,6 +9,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/debugfs.h>
@@ -789,7 +790,7 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 	struct svs_bank *svsb = file_inode(filp)->i_private;
 	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
 	int enabled, ret;
-	char *buf = NULL;
+	char *buf __free(kfree) = NULL;
 
 	if (count >= PAGE_SIZE)
 		return -EINVAL;
@@ -807,8 +808,6 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 		svsb->mode_support = SVSB_MODE_ALL_DISABLE;
 	}
 
-	kfree(buf);
-
 	return count;
 }
 
-- 
2.51.0





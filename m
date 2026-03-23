Return-Path: <stable+bounces-229043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOO8CdNcwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:31:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 290C42F66A4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CD0C30339D9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38A9386554;
	Mon, 23 Mar 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wBVUbLsp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67718370D76;
	Mon, 23 Mar 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277878; cv=none; b=kEWy+PDcXbdzOvhJVv8ddv37WOn+GFlzwiwoNCKnzhojLrCc67LALTbQ4t893sfEXCdkgvwR9pFs4dW5XtQnuLCPNwM97KdjWIWZuwNvIslsQFh0wHynjtCtTXjsmU/qysoaWLrvjvVbQ1keQ9Gl168CWUuthKQhw9MT3RhQe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277878; c=relaxed/simple;
	bh=KlA2CAu3K+MUiVS5Zj2gkUpTlKLLyS6+0FbPbgEgkDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gG5tCwwtE8+hcb9r6GAtZj4mjIhOxnCrY+76Cap4dL1lfx2ZvUR3CBxfThTu5AIO6ZsTol9fdGysPM1Q8BaALP1buNUcg8XLyodBVsE50mBVNo2ClgpxY3tfd51KNuIQt4t3b6I8xM26q7yADWMH7sFJWrRKjSucV+W+b/QAUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wBVUbLsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E324CC2BCB3;
	Mon, 23 Mar 2026 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277878;
	bh=KlA2CAu3K+MUiVS5Zj2gkUpTlKLLyS6+0FbPbgEgkDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wBVUbLspOk/j4a78CyiIM/GrNeOiQ2RfWzyUtI7mWqfOjl/pnDP70RGs7ib0wyaUZ
	 cXe89IDOHs3WIAaqSKkZEZ2sQZbNA9U6qnlS0gtD+fmn1CXYK3811Dz/Z69+1wXxv4
	 Jtr7dInFn9iK1qSAxNWhTSpWfJTThRJhk0JbXiFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 130/567] drm/ssd130x: Use bool for ssd130x_deviceinfo flags
Date: Mon, 23 Mar 2026 14:40:50 +0100
Message-ID: <20260323134537.020481325@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229043-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 290C42F66A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 15d30b46573d75f5cb58cfacded8ebab9c76a2b0 ]

The .need_pwm and .need_chargepump fields in struct ssd130x_deviceinfo
are flags that can have only two possible values: 0 and 1.
Reduce kernel size by changing their types from int to bool.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/285005ff361969eff001386c5f97990f0e703838.1692888745.git.geert@linux-m68k.org
Stable-dep-of: 36d9579fed6c ("drm/solomon: Fix page start when updating rectangle in page addressing mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/solomon/ssd130x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index 87968b3e7fb82..aa39b13615ebe 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -40,8 +40,8 @@ struct ssd130x_deviceinfo {
 	u32 default_width;
 	u32 default_height;
 	u32 page_height;
-	int need_pwm;
-	int need_chargepump;
+	bool need_pwm;
+	bool need_chargepump;
 	bool page_mode_only;
 };
 
-- 
2.51.0




